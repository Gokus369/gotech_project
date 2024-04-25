// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:go_tech_project/widgets/preview.dart';

class PreloadPreview extends StatefulWidget {
  const PreloadPreview({super.key});

  @override
  _PreloadPreviewState createState() => _PreloadPreviewState();
}

class _PreloadPreviewState extends State<PreloadPreview> {
  bool _isLoading = true;
  bool _isError = false;

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  Future<void> _loadData() async {
    try {
      await Future.delayed(const Duration(seconds: 4));

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? _buildLoadingIndicator()
          : _isError
              ? _buildErrorWidget()
              : const Preview(),
    );
  }

  Widget _buildLoadingIndicator() {
    return Scaffold(
      body: Center(
        child: Container(
          height: 500,
          width: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10.0,
                spreadRadius: 2.0,
                offset: Offset(2, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 160.0,
                    decoration: const BoxDecoration(
                      color: Colors.grey, // Placeholder color
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "Loading...", // Placeholder text
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'DancingScript',
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildSkeletonInfoRow(),
                  _buildSkeletonInfoRow(),
                  _buildSkeletonInfoRow(),
                ],
              ),
              Positioned(
                top: 100.0,
                left: 10,
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 4.0,
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 48.0,
                    backgroundColor: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return const Center(
      child: Text("Error loading data. Please try again."),
    );
  }

  Widget _buildSkeletonInfoRow() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        children: [
          SkeletonContainer.rectangle(
            width: 100,
            height: 20,
          ),
          SizedBox(height: 10),
          SkeletonContainer.rectangle(
            width: 100,
            height: 20,
          ),
        ],
      ),
    );
  }
}

class SkeletonContainer extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const SkeletonContainer._({
    this.width = double.infinity,
    this.height = double.infinity,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    Key? key,
  }) : super(key: key);

  const SkeletonContainer.rectangle({
    double width = double.infinity,
    double height = double.infinity,
  }) : this._(width: width, height: height);

  const SkeletonContainer.rounded({
    double width = double.infinity,
    double height = double.infinity,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(12)),
  }) : this._(width: width, height: height, borderRadius: borderRadius);

  const SkeletonContainer.circular({
    double width = double.infinity,
    double height = double.infinity,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(80)),
  }) : this._(width: width, height: height, borderRadius: borderRadius);

  @override
  Widget build(BuildContext context) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: borderRadius,
        ),
      );
}
