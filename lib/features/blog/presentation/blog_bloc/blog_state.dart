part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class UploadBlogSuccess extends BlogState {}

final class BlogFailure extends BlogState {
  final String message;
  BlogFailure(this.message);
}

final class DisplayBlogSuccess extends BlogState {
  final List<Blog> blogs;

  DisplayBlogSuccess(this.blogs);
}
