
import 'dart:io';

import 'package:blog_app/core/usecase/usecases.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';

import '../../domain/entities/blog.dart';
import '/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;

  BlogBloc({required UploadBlog uploadBlog, required GetAllBlogs getAllBlogs})
      : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<UploadBlogEvent>(uploadBlogEvent);
    on<GetAllBlogsEvent>(getAllBlogsEvent);
  }

  void uploadBlogEvent(UploadBlogEvent event, Emitter<BlogState> emit) async {
    final result = await _uploadBlog(UploadBlogParams(
      posterId: event.posterId,
      title: event.title,
      content: event.content,
      image: event.image,
      topics: event.topics,
    ));
    result.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(UploadBlogSuccess()),
    );
  }

  void getAllBlogsEvent(GetAllBlogsEvent event, Emitter<BlogState> emit) async {
    final res = await _getAllBlogs(NoParams());

    res.fold((l) => emit(BlogFailure(l.message)), (r) => emit(DisplayBlogSuccess(r)));
  }
}
