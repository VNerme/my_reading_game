import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class LaslaxaScreen extends StatefulWidget {
  const LaslaxaScreen({super.key});

  @override
  LaslaxaScreenState createState() => LaslaxaScreenState();
}

class LaslaxaScreenState extends State<LaslaxaScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  File? _image;
  List<Offset> markers = [];
  final int _numberOfPages = 5;
  late ScaffoldMessengerState _scaffoldMessenger;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadAnnotations();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scaffoldMessenger = ScaffoldMessenger.of(context);
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        markers = [];
      });
    }
  }

  void _addMarker(TapUpDetails details, BuildContext context) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final localPos = box.globalToLocal(details.globalPosition);
    setState(() {
      markers.add(localPos);
    });
  }

  Future<void> _saveAnnotation() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/annotations.json');

      List<Map<String, double>> markersData =
          markers.map((marker) {
            return {"dx": marker.dx, "dy": marker.dy};
          }).toList();

      await file.writeAsString(jsonEncode(markersData));

      developer.log("Annotation sparad: ${markers.length} markeringar");

      // ✅ Kontrollera att widgeten är "mounted" innan vi använder `_scaffoldMessenger`
      if (mounted) {
        _scaffoldMessenger.showSnackBar(SnackBar(content: Text("Sparat!")));
      }
    } catch (e) {
      developer.log("Fel vid sparande: $e");
    }
  }

  Future<void> _loadAnnotations() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/annotations.json');

      if (await file.exists()) {
        final data = jsonDecode(await file.readAsString());
        setState(() {
          markers =
              (data as List)
                  .map((item) => Offset(item["dx"], item["dy"]))
                  .toList();
        });
        developer.log("Laddade ${markers.length} markeringar");
      }
    } catch (e) {
      developer.log("Fel vid laddning av annotationer: $e");
    }
  }

  Widget _buildAnnotationTab() {
    return Column(
      children: [
        ElevatedButton(onPressed: _pickImage, child: Text("Välj bild")),
        Expanded(
          child:
              _image == null
                  ? Center(child: Text("Ingen bild vald"))
                  : GestureDetector(
                    onTapUp: (details) => _addMarker(details, context),
                    child: Stack(
                      children: [
                        Image.file(_image!),
                        ...markers.map((marker) {
                          return Positioned(
                            left: marker.dx - 10,
                            top: marker.dy - 10,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
        ),
        if (markers.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Antal markeringar: ${markers.length}"),
          ),
        ElevatedButton(onPressed: _saveAnnotation, child: Text("Spara")),
      ],
    );
  }

  Widget _buildReadingTab() {
    return _image == null
        ? Center(
          child: Text(
            "Ingen kapitel vald. Gå till 'Annotera' för att lägga till ett kapitel.",
          ),
        )
        : PageView.builder(
          itemCount: _numberOfPages,
          itemBuilder: (context, index) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Sida ${index + 1}", style: TextStyle(fontSize: 24)),
                  Image.file(_image!),
                ],
              ),
            );
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Läsläxa"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [Tab(text: "Annotera"), Tab(text: "Läsläge")],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildAnnotationTab(), _buildReadingTab()],
      ),
    );
  }
}
