import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:managerment/api_services/base_api.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({super.key});

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  File? _imageFile;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    fetchImageUrl();
  }

  Future<void> uploadImage(File imageFile) async {
    var url = '${BaseAPI.FLUTTER_API_URL}api/User/UploadImage';
    try {
      // Create form data
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imageFile.path),
      });

      final response = await Dio().post(
        url,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjA1NmFmNWQ1LWNiOGMtNDI3OC1iODc3LTgxNjRkYTU5N2QzYiIsIkVtYWlsIjoic3Ryb0BnbWFpbC5jb20iLCJVc2VybmFtZSI6InN0cmluZyBzdHJpbmciLCJleHAiOjIwMzYyNDY0NDd9.ECRdYCbki95tlC98DtfC_TKNg0HuB5l7gIB8YMReh-Y',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while uploading image: $e');
    }
  }

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
      await uploadImage(_imageFile!);
      await fetchImageUrl();
    }
  }

  Future<void> fetchImageUrl() async {
    final uri = '${BaseAPI.FLUTTER_API_URL}api/User/userAvatar';
    try {
      final token = 'eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjA1NmFmNWQ1LWNiOGMtNDI3OC1iODc3LTgxNjRkYTU5N2QzYiIsIkVtYWlsIjoic3Ryb0BnbWFpbC5jb20iLCJVc2VybmFtZSI6InN0cmluZyBzdHJpbmciLCJleHAiOjIwMzYyNDY0NDd9.ECRdYCbki95tlC98DtfC_TKNg0HuB5l7gIB8YMReh-Y';

      final response = await Dio().get(
        uri,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Response data: ${response.data}');
        setState(() {
          _imageUrl = response.data.toString();
        });
        print('Image URL fetched successfully: $_imageUrl');
      } else {
        print('Failed to fetch image URL. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while fetching image URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: _imageUrl == null
                ? const AssetImage("assets/images/logo.png")
                : NetworkImage(_imageUrl!) as ImageProvider,
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.white),
                  ),
                  backgroundColor: const Color(0xFFF5F6F9),
                ),
                onPressed: pickImage,
                child: Icon(CupertinoIcons.camera_fill, color: Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }
}
