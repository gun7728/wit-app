import 'dart:convert';
import 'dart:html' as html;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ImageSearch extends StatefulWidget {
  const ImageSearch({super.key});

  @override
  _ImageSearchState createState() => _ImageSearchState();
}

class _ImageSearchState extends State<ImageSearch> {
  String? _base64Image;
  List<int> selections = List.filled(17, 0);
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://43.201.45.113',
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    },
  ));

  void _pickImage() {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((e) async {
      final reader = html.FileReader();
      reader.readAsDataUrl(uploadInput.files![0]);

      reader.onLoadEnd.listen((e) {
        setState(() {
          _base64Image = reader.result as String;
        });
      });
    });
  }

  Future<void> _uploadImage() async {
    if (_base64Image == null) return;

    var data = {
      "keyword": selections.map((e) => e.toString()).toList(),
      "image": _base64Image,
    };

    final response = await _dio.post('http://43.201.45.113/search',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(data));

    if (response.statusCode == 200) {
      print('Upload successful: $response');
    } else {
      print('Upload failed: ${response.statusCode}');
    }
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Upload and Selection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 이미지 업로드 버튼
            if (_base64Image == null)
              SizedBox(
                width: screenWidth * 0.8,
                height: screenHeight * 0.4,
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
                        size: screenWidth * 0.4,
                      ),
                      const Text('Upload Image'),
                    ],
                  ),
                ),
              ),

            const SizedBox(
              height: 20,
            ),
            // 선택된 이미지 미리보기
            if (_base64Image != null)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Image.network(
                  _base64Image!,
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.4,
                ),
              ),
            if (_base64Image != null)
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Change Image'),
              ),

            const SizedBox(
              height: 20,
            ),
            // 카테고리 선택 버튼
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: List.generate(categories.length, (index) {
                    return GestureDetector(
                      onTap: () => updateSelections(index),
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
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
              ),
            ),
            // 이미지 업로드 및 선택 전송 버튼
            SizedBox(
              width: double.infinity,
              height: screenHeight * 0.06,
              child: ElevatedButton(
                onPressed: _uploadImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF106DF4),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // 네모난 모양
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
          ],
        ),
      ),
    );
  }
}

// 카테고리 리스트
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
