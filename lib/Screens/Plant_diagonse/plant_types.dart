import 'package:farmer_app/Screens/Plant_diagonse/plantwidget.dart';
import 'package:flutter/material.dart';

class PlantType extends StatefulWidget {
  @override
  _PlantTypeState createState() => _PlantTypeState();
}

class _PlantTypeState extends State<PlantType> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _plantNames = [
    'Tomato',
    'Corn',
    'Wheat',
    'Rice',
    'Barley',
  ];
  List<String> _filteredPlantNames = [];

  @override
  void initState() {
    super.initState();
    _filteredPlantNames = _plantNames;
  }

  void _filterPlants(String query) {
    setState(() {
      _filteredPlantNames = _plantNames
          .where((plant) => plant.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select the Plant Name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              onChanged: _filterPlants,
              decoration: InputDecoration(
                labelText: 'Search Plants',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 16),

            // Grid Layout for Plant Names
            Expanded(
              child: GridView.builder(
                itemCount: _filteredPlantNames.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 3 / 2,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Handle plant selection
                      print('Selected: ${_filteredPlantNames[index]}');
                    },
                    child: PlantWidget(filteredPlantNames: _filteredPlantNames,index: index,),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

