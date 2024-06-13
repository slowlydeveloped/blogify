import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecases.dart';
import 'package:blog_app/features/blog/domain/repostory/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/blog.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;

  GetAllBlogs(this.blogRepository);

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async{
    return await blogRepository.getAllBlogs();
  }
}
