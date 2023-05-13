import '../../../../core/core.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/domain.dart';
import '../models/models.dart';

class RemoteAddUser implements AddUser {
  final FirebaseFirestoreClient databaseClient;

  RemoteAddUser({required this.databaseClient});
  @override
  Future<void> call({required UserEntity userEntity}) async {
    try {
      final json = RemoteUserModel.fromEntity(userEntity).toJson();

      await databaseClient.save(collection: "users", json: json);
    } catch (e) {
      throw DomainError.unexpected;
    }
  }
}
