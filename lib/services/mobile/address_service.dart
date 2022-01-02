import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wedding/data/enums.dart';
import 'package:wedding/data/models.dart';

class AddressService {
  static Future<List<Address>> getAddress(String keyword) async {
    const confmKey = 'U01TX0FVVEgyMDIxMTEwNDAwMjMxNjExMTgzNzE=';
    var response = await Dio().get('https://www.juso.go.kr/addrlink/addrLinkApi.do', queryParameters: {
      'keyword': keyword,
      'resultType': 'json',
      'confmKey': confmKey,
    });
    switch (response.statusCode) {
      case HttpStatus.ok:
        var addressList = response.data['results']['juso'];
        if (addressList is List) {
          return addressList.map<Address>((address) {
            switch (address['siNm'] as String) {
              case '서울특별시':
                return Address(area: Area.seoul, address: address['roadAddr']);
              case '부산광역시':
                return Address(area: Area.busan, address: address['roadAddr']);
              case '대구광역시':
                return Address(area: Area.daegu, address: address['roadAddr']);
              case '인천광역시':
                return Address(area: Area.incheon, address: address['roadAddr']);
              case '광주광역시':
                return Address(area: Area.gwangju, address: address['roadAddr']);
              case '대전광역시':
                return Address(area: Area.daejeon, address: address['roadAddr']);
              case '울산광역시':
                return Address(area: Area.ulsan, address: address['roadAddr']);
              case '세종특별자치시':
                return Address(area: Area.sejong, address: address['roadAddr']);
              case '경기도':
                return Address(area: Area.gyeonggi, address: address['roadAddr']);
              case '강원도':
                return Address(area: Area.gangwon, address: address['roadAddr']);
              case '충청북도':
                return Address(area: Area.chungbuk, address: address['roadAddr']);
              case '충청남도':
                return Address(area: Area.chungnam, address: address['roadAddr']);
              case '전라남도':
                return Address(area: Area.jeonnam, address: address['roadAddr']);
              case '전라북도':
                return Address(area: Area.jeonbuk, address: address['roadAddr']);
              case '경상남도':
                return Address(area: Area.gyeongnam, address: address['roadAddr']);
              case '경상북도':
                return Address(area: Area.gyeongbuk, address: address['roadAddr']);
              case '제주특별자치도':
                return Address(area: Area.jeju, address: address['roadAddr']);
              default:
                throw 'unknown area';
            }
          }).toList();
        } else {
          return [];
        }
      default:
        throw response.data;
    }
  }
}
