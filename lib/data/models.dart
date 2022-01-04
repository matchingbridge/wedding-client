import 'dart:math';

import 'package:wedding/data/enums.dart';
import 'package:wedding/services/mobile/base_service.dart';

class YM {
  final int year;
  final int month;

  const YM({required this.year, required this.month});

  YMD withDay(int day) => YMD(year: year, month: month, day: day);

  @override
  String toString() => '$year${month.toString().padLeft(2, '0')}';
  YM.fromString(String string)
      : year = int.parse(string.substring(0, 4)),
        month = int.parse(string.substring(4, 6));
}

class YMD extends YM {
  int day;

  YMD({required int year, required int month, required this.day}) : super(year: year, month: month);

  @override
  String toString() => '$year${month.toString().padLeft(2, '0')}${day.toString().padLeft(2, '0')}';
  YMD.fromString(String string)
      : day = int.parse(string.substring(6, 8)),
        super.fromString(string);
}

class User {
  String userID;
  String email;
  String name;
  String phone;

  String face1;
  String face2;
  String body1;
  String body2;
  String video;

  String introduction;

  Area area;
  String address;
  String detail;

  Gender gender;
  YMD birthday;
  int marriage;
  int height;
  int weight;
  bool smoke;
  bool drink;
  Religion religion;
  BodyType bodyType;
  Character character;

  Scholar scholar;
  String school;
  String major;

  Job job;
  String company;
  String workplace;
  Employment employment;
  Salary salary;

  bool distance;
  YM period;

  List<Character> partnerCharacters;
  String vehicle;

  get age => DateTime.now().year - birthday.year + 1;

  User({
    required this.userID,
    required this.email,
    required this.name,
    required this.phone,
    required this.face1,
    required this.face2,
    required this.body1,
    required this.body2,
    required this.video,
    required this.introduction,
    required this.area,
    required this.address,
    required this.detail,
    required this.gender,
    required this.birthday,
    required this.marriage,
    required this.height,
    required this.weight,
    required this.smoke,
    required this.drink,
    required this.religion,
    required this.bodyType,
    required this.character,
    required this.scholar,
    required this.school,
    required this.major,
    required this.job,
    required this.company,
    required this.workplace,
    required this.employment,
    required this.salary,
    required this.distance,
    required this.period,
    required this.partnerCharacters,
    required this.vehicle,
  });

  factory User.profile({required String email, required String name, required String phone}) {
    return User(
      userID: '',
      email: email,
      name: name,
      phone: phone,
      face1: '',
      face2: '',
      body1: '',
      body2: '',
      video: '',
      introduction: '',
      area: Area.seoul,
      address: '',
      detail: '',
      gender: Gender.male,
      birthday: YMD(year: 1980, month: 1, day: 1),
      marriage: 0,
      height: 165,
      weight: 60,
      smoke: false,
      drink: false,
      religion: Religion.protestant,
      character: Character.extrovert,
      bodyType: BodyType.type1,
      scholar: Scholar.onUniv,
      school: '',
      major: '',
      job: Job.big,
      company: '',
      workplace: '',
      employment: Employment.regular,
      salary: Salary.under3,
      distance: false,
      period: const YM(year: 2023, month: 01),
      partnerCharacters: const [],
      vehicle: '',
    );
  }

  User copyWith({
    String? userID,
    String? email,
    String? name,
    String? phone,
    String? face1,
    String? face2,
    String? body1,
    String? body2,
    String? video,
    String? introduction,
    Area? area,
    String? address,
    String? detail,
    Gender? gender,
    YMD? birthday,
    int? marriage,
    int? height,
    int? weight,
    bool? smoke,
    bool? drink,
    Religion? religion,
    BodyType? bodyType,
    Character? character,
    Scholar? scholar,
    String? school,
    String? major,
    Job? job,
    String? company,
    String? workplace,
    Employment? employment,
    Salary? salary,
    bool? distance,
    YM? period,
    List<Character>? partnerCharacters,
    String? vehicle,
  }) {
    return User(
      userID: userID ?? this.userID,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      face1: face1 ?? this.face1,
      face2: face2 ?? this.face2,
      body1: body1 ?? this.body1,
      body2: body2 ?? this.body2,
      video: video ?? this.video,
      introduction: introduction ?? this.introduction,
      area: area ?? this.area,
      address: address ?? this.address,
      detail: detail ?? this.detail,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      marriage: marriage ?? this.marriage,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      smoke: smoke ?? this.smoke,
      drink: drink ?? this.drink,
      religion: religion ?? this.religion,
      bodyType: bodyType ?? this.bodyType,
      character: character ?? this.character,
      scholar: scholar ?? this.scholar,
      school: school ?? this.school,
      major: major ?? this.major,
      job: job ?? this.job,
      company: company ?? this.company,
      workplace: workplace ?? this.workplace,
      employment: employment ?? this.employment,
      salary: salary ?? this.salary,
      distance: distance ?? this.distance,
      period: period ?? this.period,
      partnerCharacters: partnerCharacters ?? this.partnerCharacters,
      vehicle: vehicle ?? this.vehicle,
    );
  }

  String image({String bucket = 'face1'}) => '$host/api/client/user/media/$bucket/$userID';

  User.fromJSON(Map<String, dynamic> json)
      : userID = json['user_id'],
        email = json['email'],
        name = json['name'],
        phone = json['phone'],
        face1 = json['face1'],
        face2 = json['face2'],
        body1 = json['body1'],
        body2 = json['body2'],
        video = json['video'],
        introduction = json['introduction'],
        area = Area.values[json['area'] as int],
        address = json['address'],
        detail = json['detail'],
        gender = Gender.values[json['gender'] as int],
        birthday = YMD.fromString(json['birthday']),
        marriage = json['marriage'],
        height = json['height'],
        weight = json['weight'],
        smoke = json['smoke'],
        drink = json['drink'],
        religion = Religion.values[json['religion'] as int],
        bodyType = BodyType.values[json['bodytype'] as int],
        character = Character.values[json['character'] as int],
        scholar = Scholar.values[json['scholar'] as int],
        school = json['school'],
        major = json['major'],
        job = Job.values[json['job'] as int],
        company = json['company'],
        workplace = json['workplace'],
        employment = Employment.values[json['employment'] as int],
        salary = Salary.values[json['salary'] as int],
        distance = json['distance'],
        period = YM.fromString(json['period']),
        partnerCharacters = (json['partner_characters'] as String).split(',').map((e) => Character.values[int.parse(e)]).toList(),
        vehicle = json['vehicle'];

  Map<String, dynamic> toJSON() => {
        'user_id': userID,
        'email': email,
        'name': name,
        'phone': phone,
        'face1': face1,
        'face2': face2,
        'body1': body1,
        'body2': body2,
        'video': video,
        'introduction': introduction,
        'area': area.index,
        'address': address,
        'detail': detail,
        'gender': gender.index,
        'birthday': birthday.toString(),
        'marriage': marriage,
        'height': height,
        'weight': weight,
        'smoke': smoke,
        'drink': drink,
        'religion': religion.index,
        'bodytype': bodyType.index,
        'character': character.index,
        'scholar': scholar.index,
        'school': school,
        'major': major,
        'job': job.index,
        'company': company,
        'workplace': workplace,
        'employment': employment.index,
        'salary': salary.index,
        'distance': distance,
        'period': period.toString(),
        'partner_characters': partnerCharacters.map((e) => e.index).toList().join(','),
        'vehicle': vehicle,
      };
}

class Range<T extends num> {
  T x;
  T y;

  Range({required this.x, required this.y});

  T get maximum => max(x, y);
  T get minimum => min(x, y);
}

class Detail {
  int detailID;

  String asset;
  bool? realEstate;

  String familyCertificate;
  String schoolCertificate;
  String companyCertificate;
  String salaryCertificate;
  String vehicleCertificate;

  Range<int>? partnerAge;
  Range<int>? partnerHeight;
  School? partnerSchool;
  List<Job>? partnerJobs;
  Salary? partnerSalary;
  String? partnerAsset;
  Smoke? partnerSmoke;
  Drink? partnerDrink;
  Marriage? partnerMarriage;
  List<BodyType>? partnerBodies;
  String partnerDescription;

  Detail({
    required this.detailID,
    this.asset = '',
    this.realEstate,
    this.familyCertificate = '',
    this.schoolCertificate = '',
    this.companyCertificate = '',
    this.salaryCertificate = '',
    this.vehicleCertificate = '',
    this.partnerAge,
    this.partnerHeight,
    this.partnerSchool,
    this.partnerJobs,
    this.partnerSalary,
    this.partnerAsset,
    this.partnerSmoke,
    this.partnerDrink,
    this.partnerMarriage,
    this.partnerBodies,
    this.partnerDescription = '',
  });

  Detail copyWith({
    String? asset,
    bool? realEstate,
    String? familyCertificate,
    String? schoolCertificate,
    String? companyCertificate,
    String? salaryCertificate,
    String? vehicleCertificate,
    Range<int>? partnerAge,
    Range<int>? partnerHeight,
    School? partnerSchool,
    List<Job>? partnerJobs,
    Salary? partnerSalary,
    String? partnerAsset,
    Smoke? partnerSmoke,
    Drink? partnerDrink,
    Marriage? partnerMarriage,
    List<BodyType>? partnerBodies,
    String? partnerDescription,
  }) {
    return Detail(
      detailID: detailID,
      asset: asset ?? this.asset,
      realEstate: realEstate ?? this.realEstate,
      familyCertificate: familyCertificate ?? this.familyCertificate,
      schoolCertificate: schoolCertificate ?? this.schoolCertificate,
      companyCertificate: companyCertificate ?? this.companyCertificate,
      salaryCertificate: salaryCertificate ?? this.salaryCertificate,
      vehicleCertificate: vehicleCertificate ?? this.vehicleCertificate,
      partnerAge: partnerAge ?? this.partnerAge,
      partnerHeight: partnerHeight ?? this.partnerHeight,
      partnerSchool: partnerSchool ?? this.partnerSchool,
      partnerJobs: partnerJobs ?? this.partnerJobs,
      partnerSalary: partnerSalary ?? this.partnerSalary,
      partnerAsset: partnerAsset ?? this.partnerAsset,
      partnerSmoke: partnerSmoke ?? this.partnerSmoke,
      partnerDrink: partnerDrink ?? this.partnerDrink,
      partnerMarriage: partnerMarriage ?? this.partnerMarriage,
      partnerBodies: partnerBodies ?? this.partnerBodies,
      partnerDescription: partnerDescription ?? this.partnerDescription,
    );
  }

  Detail.fromJSON(Map<String, dynamic> json)
      : detailID = json['detail_id'],
        asset = json['asset'],
        realEstate = json['real_estate'],
        familyCertificate = json['family_certificate'],
        schoolCertificate = json['school_certificate'],
        companyCertificate = json['company_certificate'],
        salaryCertificate = json['salary_certificate'],
        vehicleCertificate = json['vehicle_certificate'],
        partnerAge = json['partner_age'],
        partnerHeight = json['partner_height'],
        partnerSchool = json['partner_school'],
        partnerJobs = json['partner_jobs'],
        partnerSalary = json['partner_salary'],
        partnerAsset = json['partner_asset'],
        partnerSmoke = json['partner_smoke'],
        partnerDrink = json['partner_drink'],
        partnerMarriage = json['partner_marriage'],
        partnerBodies = json['partner_bodies'],
        partnerDescription = json['partner_description'];

  Map<String, dynamic> toJSON() => {
        'detail_id': detailID,
        'asset': asset,
        'real_estate': realEstate,
        'family_certificate': familyCertificate,
        'school_certificate': schoolCertificate,
        'company_certificate': companyCertificate,
        'salary_certificate': salaryCertificate,
        'vehicle_certificate': vehicleCertificate,
        'partner_age': partnerAge,
        'partner_height': partnerHeight,
        'partner_school': partnerSchool,
        'partner_jobs': partnerJobs,
        'partner_salary': partnerSalary,
        'partner_asset': partnerAsset,
        'partner_smoke': partnerSmoke,
        'partner_drink': partnerDrink,
        'partner_marriage': partnerMarriage,
        'partner_bodies': partnerBodies,
        'partner_description': partnerDescription,
      };
}

class Chat {
  bool isTalking;
  String message;
  DateTime chattedAt;

  Chat({
    required this.isTalking,
    required this.message,
    required this.chattedAt,
  });

  Chat.fromJSON(Map<String, dynamic> json)
      : isTalking = json['is_talking'],
        message = json['message'],
        chattedAt = DateTime.parse(json['chatted_at']);
}

class Match {
  int matchID;
  String senderID;
  String receiverID;
  DateTime? askedAt;
  DateTime? matchedAt;
  DateTime? terminatedAt;

  String image({String bucket = 'face1'}) => '$host/api/client/user/media/$bucket/$senderID';

  Match({
    required this.matchID,
    required this.senderID,
    required this.receiverID,
    this.askedAt,
    this.matchedAt,
    this.terminatedAt,
  });

  Match.fromJSON(Map<String, dynamic> json)
      : matchID = json['match_id'],
        senderID = json['sender_id'],
        receiverID = json['receiver_id'],
        askedAt = json['asked_at'],
        matchedAt = json['matched_at'],
        terminatedAt = json['terminated_at'];
}

class Review {
  int matchID;
  String targetID;
  DateTime writtenAt;
  String content;
  Review({
    required this.matchID,
    required this.targetID,
    required this.writtenAt,
    required this.content,
  });
}

class Suggestion {
  String userID;
  String partnerID;
  DateTime suggestedAt;

  Suggestion({
    required this.userID,
    required this.partnerID,
    required this.suggestedAt,
  });

  Suggestion.fromJSON(Map<String, dynamic> json)
      : userID = json['user_id'],
        partnerID = json['partner_id'],
        suggestedAt = DateTime.parse(json['suggested_at']);
}

class Authorization {
  String accessToken;
  String refreshToken;
  int expiresAt;

  Authorization({required this.accessToken, required this.refreshToken, required this.expiresAt});

  Authorization.fromJSON(Map<String, dynamic> json)
      : accessToken = json['access_token'],
        refreshToken = json['refresh_token'],
        expiresAt = json['expires_at'];
}

class Address {
  Area area;
  String address;
  Address({required this.area, required this.address});
}

class UserAuth {
  String userID;
  int authID;
  String email;
  String name;
  String phone;

  Area area;
  Gender gender;
  Marriage marriage;
  int height;
  int weight;
  bool smoke;
  bool drink;
  Religion religion;
  BodyType bodytype;
  Character character;
  Scholar scholar;
  Job job;
  DateTime? reviewedAt;

  UserAuth({
    required this.userID,
    required this.authID,
    required this.email,
    required this.name,
    required this.phone,
    required this.area,
    required this.gender,
    required this.marriage,
    required this.height,
    required this.weight,
    required this.smoke,
    required this.drink,
    required this.religion,
    required this.bodytype,
    required this.character,
    required this.scholar,
    required this.job,
    this.reviewedAt,
  });

  UserAuth.fromJSON(Map<String, dynamic> json)
      : userID = json['user_id'],
        authID = json['auth_id'],
        email = json['email'],
        name = json['name'],
        phone = json['phone'],
        area = Area.values[json['area']],
        gender = Gender.values[json['gender']],
        marriage = Marriage.values[json['marriage']],
        height = json['height'],
        weight = json['weight'],
        smoke = json['smoke'],
        drink = json['drink'],
        religion = Religion.values[json['religion'] as int],
        bodytype = BodyType.values[json['bodytype'] as int],
        character = Character.values[json['character'] as int],
        scholar = Scholar.values[json['scholar'] as int],
        job = Job.values[json['job'] as int],
        reviewedAt = json['reviewed_at'] != null ? DateTime.parse(json['reviewed_at']) : null;
}
