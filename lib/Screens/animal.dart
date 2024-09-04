import 'package:flutter/material.dart';

class AnimalSymptomsPage extends StatefulWidget {
  @override
  _AnimalSymptomsPageState createState() => _AnimalSymptomsPageState();
}

class _AnimalSymptomsPageState extends State<AnimalSymptomsPage> {
  final List<String> animals = ['Dog', 'Cat', 'Horse', 'Elephant', 'Tiger'];
  final List<String> symptoms = [
    'Fever',
    'Cough',
    'Sneezing',
    'Vomiting',
    'Diarrhea'
  ];

  String selectedAnimal = '';
  List<String> selectedSymptoms = [];
  List<String> filteredSymptoms = [];
  int age = 0;
  final TextEditingController _ageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    filteredSymptoms = symptoms;
  }

  void _filterSymptoms(String query) {
    setState(() {
      filteredSymptoms = symptoms
          .where(
              (symptom) => symptom.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _toggleSymptom(String symptom) {
    setState(() {
      if (selectedSymptoms.contains(symptom)) {
        selectedSymptoms.remove(symptom);
      } else {
        selectedSymptoms.add(symptom);
      }
    });
  }

  void _printSelections() {
    print('Selected Animal: $selectedAnimal');
    print('Selected Symptoms: $selectedSymptoms');
    List<String> finalList = _combineSelections();
    print('Final List: $finalList');
  }

  List<String> _combineSelections() {
    final combinedSelections = <String>[];

    // Add selected animal first
    if (selectedAnimal.isNotEmpty) {
      combinedSelections.add(selectedAnimal);
    }
    combinedSelections.add(age.toString());
    // Add selected symptoms next
    if (selectedSymptoms.isNotEmpty) {
      combinedSelections.add(selectedSymptoms.join(', '));
    }

    // Return combined list
    return combinedSelections;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animal and Symptoms Selector')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Text Field with Drop Down List
            TextField(
              controller: TextEditingController(text: selectedAnimal),
              decoration: InputDecoration(
                labelText: 'Selected Animal',
                border: OutlineInputBorder(),
              ),
              readOnly: true,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Select Animal'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: animals
                          .where((animal) => animal
                              .toLowerCase()
                              .contains(selectedAnimal.toLowerCase()))
                          .map((animal) => ListTile(
                                title: Text(animal),
                                onTap: () {
                                  setState(() {
                                    selectedAnimal = animal;
                                  });
                                  Navigator.of(context).pop();
                                },
                              ))
                          .toList(),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            // Text Field for Entering Age
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Age',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                // The age is updated automatically via the controller listener
                //change the TSring ton in

                age = int.parse(value);
              },
            ),
            SizedBox(height: 16),
            // Container to Show Selected Symptoms
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: selectedSymptoms.isEmpty
                  ? Text('No symptoms selected')
                  : Text(selectedSymptoms.join(', ')),
            ),
            SizedBox(height: 16),
            // Grid of Toggle Buttons
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 1,
                ),
                itemCount: filteredSymptoms.length,
                itemBuilder: (context, index) {
                  final symptom = filteredSymptoms[index];
                  return GestureDetector(
                    onTap: () => _toggleSymptom(symptom),
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: 10, // Minimum height of the container
                        maxHeight: 10, // Maximum height of the container
                      ),
                      decoration: BoxDecoration(
                        color: selectedSymptoms.contains(symptom)
                            ? const Color.fromARGB(255, 0, 82, 55)
                            : const Color.fromARGB(255, 234, 234, 234),
                        borderRadius: BorderRadius.circular(8),
                        //border: Border.all(color: Colors.black),
                      ),
                      child: Center(
                        child: Text(
                          symptom,
                          style: TextStyle(
                            color: selectedSymptoms.contains(symptom)
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            // Button to Print Selected Animal and Symptoms
            ElevatedButton(
              onPressed: _printSelections,
              child: Text('Print Selections'),
            ),
          ],
        ),
      ),
    );
  }
}
