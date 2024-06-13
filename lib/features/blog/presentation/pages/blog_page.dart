import '/core/common/widgets/loader.dart';
import '/core/themes/app_pallete.dart';
import '/core/utils/show_snackbar.dart';
import '/features/blog/presentation/blog_bloc/blog_bloc.dart';
import '/features/blog/presentation/pages/add_new_blogs_page.dart';
import '/features/blog/presentation/widgets/blog_card.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const BlogPage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    context.read<BlogBloc>().add(GetAllBlogsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Blogs"), actions: [
        IconButton(
          onPressed: () {
            Navigator.push(context, AddNewBlogsPage.route());
          },
          icon: const Icon(CupertinoIcons.add_circled),
        )
      ]),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          if (state is DisplayBlogSuccess) {
            return ListView.builder(
                itemCount: state.blogs.length,
                itemBuilder: (context, index) {
                  final blog = state.blogs[index];
                  return BlogCard(
                    blog: blog,
                    color: index % 3 == 0
                        ? AppPallete.gradient1
                        : index %3 == 1
                            ? AppPallete.gradient2
                            : AppPallete.gradient3,
                  );
                });
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
