import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:roadcognizer/components/sign_card/sign_card.dart';
import 'package:roadcognizer/models/traffic_sign_image/traffic_sign_image.dart';
import 'package:roadcognizer/services/user/user.service.dart';

class GridSigns extends StatefulWidget {
  final userService = UserService();

  final Function()? onScrollUp;
  final Function()? onScrollDown;
  final List<TrafficSignImage>? images;

  GridSigns(
      {super.key, this.onScrollUp, this.onScrollDown, required this.images});

  @override
  State<GridSigns> createState() => _GridSignsState();
}

class _GridSignsState extends State<GridSigns> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_fetchMoreImages);
    _scrollController.addListener(_notifyScrollDirection);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_fetchMoreImages);
    _scrollController.removeListener(_notifyScrollDirection);
    _scrollController.dispose();
    super.dispose();
  }

  void _notifyScrollDirection() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      widget.onScrollDown?.call();
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      widget.onScrollUp?.call();
    }
  }

  void _fetchMoreImages() async {
    if (_scrollController.position.maxScrollExtent ==
        _scrollController.offset) {
      widget.userService
          .getCurrentUserImages(limit: 8, startAfter: widget.images!.last)
          .then((images) {
        setState(() {
          widget.images!.addAll(images);
        });
      });
    }
  }

  void _onDeleteImage(TrafficSignImage image) async {
    await widget.userService.deleteImageFromCurrentUser(image);

    if (!mounted) return;

    setState(() {
      widget.images!.remove(image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        controller: _scrollController,
        itemCount: widget.images?.length ?? 8,
        itemBuilder: (context, index) {
          return SignCard(
            image: widget.images?[index],
            isLoading: widget.images == null,
            onDelete: _onDeleteImage,
          );
        },
      ),
    );
  }
}
