import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:universal_html/html.dart' as html;
import 'package:image_picker/image_picker.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/data/models/spots.dart';
import 'package:wit_app/presentation/home/bloc/page_cubit.dart';
import 'package:wit_app/presentation/home/bloc/page_state.dart';
import 'package:wit_app/presentation/home/bloc/selected_spot_cubit.dart';
import 'package:wit_app/presentation/home/bloc/spots_cubit.dart';
import 'package:wit_app/presentation/home/bloc/spots_state.dart';
import 'package:wit_app/presentation/home/components/all/infinite_list_item.dart';
import 'package:wit_app/presentation/home/components/detail/spot_detail.dart';

class ImageSearch extends StatefulWidget {
  const ImageSearch({super.key});

  @override
  _ImageSearchState createState() => _ImageSearchState();
}

class _ImageSearchState extends State<ImageSearch> {
  String? _base64Image;
  Uint8List? _imageBytes;
  List<int> selections = List.filled(17, 0);
  final Dio _dio = Dio(BaseOptions(
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    },
  ));
  List<Spots> _searchResults = [];
  bool _isLoading = false;

  Future<void> _pickImage() async {
    if (kIsWeb) {
      await _pickImageWeb();
    } else {
      await _pickImageMobile();
    }
  }

  Future<void> _pickImageWeb() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((e) async {
      final reader = html.FileReader();
      reader.readAsDataUrl(uploadInput.files![0]);

      reader.onLoadEnd.listen((e) {
        setState(() {
          _base64Image = reader.result as String;
          _imageBytes = base64Decode(_base64Image!.split(',').last);
        });
      });
    });
  }

  Future<void> _pickImageMobile() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        _imageBytes = bytes;
        _base64Image = 'data:image/png;base64,${base64Encode(bytes)}';
      });
    }
  }

  void mapOpen(bool) {
    bool ? Navigator.pop(context) : null;
  }

  Future<void> _uploadImage() async {
    if (_base64Image == null) {
      _showWarningDialog("Please upload an image.");
      return;
    }

    if (!selections.any((element) => element == 1)) {
      _showWarningDialog("Please select at least one category.");
      return;
    }

    var data = {
      "keyword": selections.map((e) => e.toString()).toList(),
      "image": _base64Image,
    };

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _dio.post(
          kIsWeb ? '/api/search' : 'https://wit-back.kro.kr/search',
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
          data: jsonEncode(data));

      if (response.statusCode == 200) {
        var state = context.read<SpotsCubit>().state;
        if (state is SpotsLoaded) {
          List<Spots> newSpot = [];
          for (var tt in response.data['results']) {
            List<Spots> getSpot =
                state.spots.where((spot) => spot.title == tt).toList();
            newSpot.add(getSpot[0]);
          }
          setState(() {
            _searchResults = newSpot;
          });
        }
      } else {
        print('Upload failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during upload: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showWarningDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void updateSelections(int index) {
    setState(() {
      selections[index] = selections[index] == 0 ? 1 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<PageCubit, PageState>(
      builder: (context, state) {
        if (state is PageLoaded) {
          // if (state.currentPage == 2) Navigator.pop(context);
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Image Upload and Selection'),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    if (_imageBytes == null)
                      SizedBox(
                        width: screenWidth * 0.8,
                        height: screenHeight * 0.3,
                        child: ElevatedButton(
                          onPressed: _pickImage,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_outlined,
                                size: screenWidth * 0.3,
                              ),
                              const Text('Upload Image'),
                            ],
                          ),
                        ),
                      ),
                    if (_imageBytes != null)
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Image.memory(
                          _imageBytes!,
                          width: screenWidth * 0.8,
                          height: screenHeight * 0.3,
                          fit: BoxFit.cover,
                        ),
                      ),
                    if (_imageBytes != null)
                      ElevatedButton(
                        onPressed: _pickImage,
                        child: const Text('Change Image'),
                      ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: List.generate(categories.length, (index) {
                        return GestureDetector(
                          onTap: () => updateSelections(index),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: selections[index] == 1
                                  ? Colors.blue
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: selections[index] == 1
                                    ? Colors.blueAccent
                                    : Colors.transparent,
                              ),
                            ),
                            child: Text(
                              categories[index],
                              style: TextStyle(
                                color: selections[index] == 1
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: screenHeight * 0.06,
                      child: ElevatedButton(
                        onPressed: _uploadImage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF106DF4),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: const Text(
                          'Send Data',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (_searchResults.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (contextLoginScreen) {
                                  return MultiBlocProvider(
                                      providers: [
                                        BlocProvider.value(
                                          value: BlocProvider.of<PageCubit>(
                                              context),
                                        ),
                                        BlocProvider.value(
                                          value: BlocProvider.of<
                                              SelectedSpotCubit>(context),
                                        ),
                                      ],
                                      child: SpotDetail(
                                          spot: _searchResults[index],
                                          mapOpen: mapOpen));
                                }),
                              );
                            },
                            child: MultiBlocProvider(
                                providers: [
                                  BlocProvider.value(
                                    value: BlocProvider.of<SelectedSpotCubit>(
                                        context),
                                  ),
                                  BlocProvider.value(
                                    value: BlocProvider.of<PageCubit>(context),
                                  ),
                                ],
                                child: InfiniteListItem(
                                    spot: _searchResults[index])),
                          );
                        },
                      ),
                  ],
                ),
              ),
              if (_isLoading)
                Container(
                  color: Colors.black54,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

const List<String> categories = [
  '자연',
  '한옥',
  '역사',
  '고층빌딩',
  '백화점',
  '미술관',
  '쇼핑',
  '공원',
  '강변',
  '시장',
  '박물관',
  '첨단기술',
  '전망대',
  '테마파크',
  '음식',
  '문화체험',
  '종교'
];
