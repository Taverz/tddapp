


import 'package:flutter_network_connectivity/flutter_network_connectivity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tddapp/core/errore/network/network_info.dart';

class MockDataConnectionChecker extends Mock implements FlutterNetworkConnectivity{}


void main(){
  late NetworkinfoImpl networklInfoImpl;
  late MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networklInfoImpl = NetworkinfoImpl(mockDataConnectionChecker);
  });

  group('', 
    () async { 
        when(mockDataConnectionChecker.isInternetAvailable).thenAnswer((_)  => false);

        final result = await networklInfoImpl.isConnect;
        verify(mockDataConnectionChecker.isInternetAvailable);
        expect(result, true);
    },
  );
}