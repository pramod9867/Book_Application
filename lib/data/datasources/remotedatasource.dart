import 'package:book_application/core/model/generic_model.dart';
import 'package:book_application/core/remote_client/dio_client.dart';
import 'package:dio/dio.dart';

class RemoteDataSource {
  Future<GenericModel> fetchBooksDetails() async {
    DioClient client = DioClient.defaultClient(header: {});

    Response response = await client.dio!.get("");

    if (response.statusCode == 200 || response.statusCode == 201) {
      GenericModel genericModel =
          new GenericModel("S", "Data Fetch Successfully", response.data);

      return genericModel;
    } else {
      GenericModel genericModel =
          new GenericModel("E", "Unable to fetch Data", response.data);

      return genericModel;
    }
  }
}
