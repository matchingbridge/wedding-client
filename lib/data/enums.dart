enum Area {
  seoul,
  busan,
  daegu,
  incheon,
  gwangju,
  daejeon,
  ulsan,
  sejong,
  gyeonggi,
  gangwon,
  chungbuk,
  chungnam,
  jeonnam,
  jeonbuk,
  gyeongnam,
  gyeongbuk,
  jeju,
}

extension AreaLiteral on Area {
  get literal {
    switch (this) {
      case Area.seoul:
        return '서울특별시';
      case Area.busan:
        return '부산광역시';
      case Area.daegu:
        return '대구광역시';
      case Area.incheon:
        return '인천광역시';
      case Area.gwangju:
        return '광주광역시';
      case Area.daejeon:
        return '대전광역시';
      case Area.ulsan:
        return '울산광역시';
      case Area.sejong:
        return '세종특별자치시';
      case Area.gyeonggi:
        return '경기도';
      case Area.gangwon:
        return '강원도';
      case Area.chungbuk:
        return '충청북도';
      case Area.chungnam:
        return '충청남도';
      case Area.jeonnam:
        return '전라남도';
      case Area.jeonbuk:
        return '전라북도';
      case Area.gyeongnam:
        return '경상남도';
      case Area.gyeongbuk:
        return '경상북도';
      case Area.jeju:
        return '제주도';
    }
  }
}

enum Gender { male, female }

extension GenderLiteral on Gender {
  get literal {
    switch (this) {
      case Gender.male:
        return '남';
      case Gender.female:
        return '여';
    }
  }
}

enum Marriage { never, did, nevermind }

extension MarriageLiteral on Marriage {
  get literal {
    switch (this) {
      case Marriage.never:
        return '미혼';
      case Marriage.did:
        return '돌싱';
      case Marriage.nevermind:
        return '무관';
    }
  }
}

enum Religion { protestant, catholic, buddhist, none, other }

extension ReligionLiteral on Religion {
  get literal {
    switch (this) {
      case Religion.protestant:
        return '기독교';
      case Religion.catholic:
        return '천주교';
      case Religion.buddhist:
        return '불교';
      case Religion.none:
        return '무교';
      case Religion.other:
        return '기타';
    }
  }
}

enum Scholar { onUniv, inUniv, onGrad, inGrad, other }

extension ScholarLiteral on Scholar {
  get literal {
    switch (this) {
      case Scholar.onUniv:
        return '대학교 재학';
      case Scholar.inUniv:
        return '대학교 졸업';
      case Scholar.onGrad:
        return '대학원 재학';
      case Scholar.inGrad:
        return '대학원 졸업';
      case Scholar.other:
        return '고등학교 졸업 및 기타';
    }
  }
}

enum School { grad, seoul, regional, college, highschool, nevermind }

extension SchoolLiteral on School {
  get literal {
    switch (this) {
      case School.grad:
        return '대학원졸';
      case School.seoul:
        return '서울권 4년제 대학졸 이상';
      case School.regional:
        return '지방 4년제 대학졸 이상';
      case School.college:
        return '2년제 대학졸 이상';
      case School.highschool:
        return '고졸 이상';
      case School.nevermind:
        return '무관';
    }
  }
}

enum Job { professional, big, small, government, public, business, nevermind }

extension JobLiteral on Job {
  get literal {
    switch (this) {
      case Job.professional:
        return '전문직';
      case Job.big:
        return '대기업';
      case Job.small:
        return '중소기업';
      case Job.government:
        return '공무원';
      case Job.public:
        return '공기업';
      case Job.business:
        return '사업가';
      case Job.nevermind:
        return '무관';
    }
  }
}

enum Employment { regular, nonregular, intern, freelancer, temporary, business }

extension EmploymentLiteral on Employment {
  get literal {
    switch (this) {
      case Employment.regular:
        return '정규직';
      case Employment.nonregular:
        return '비정규직';
      case Employment.intern:
        return '인턴';
      case Employment.freelancer:
        return '프리랜서';
      case Employment.temporary:
        return '기간제';
      case Employment.business:
        return '개인사업';
    }
  }
}

enum Smoke { smoke, nosmoke, nevermind }

extension SmokeLiteral on Smoke {
  get literal {
    switch (this) {
      case Smoke.smoke:
        return '흡연';
      case Smoke.nosmoke:
        return '비흡연';
      case Smoke.nevermind:
        return '무관';
    }
  }
}

enum Drink { drink, nodrink, nevermind }

extension DrinkLiteral on Drink {
  get literal {
    switch (this) {
      case Drink.drink:
        return '음주';
      case Drink.nodrink:
        return '비음주';
      case Drink.nevermind:
        return '무관';
    }
  }
}

enum Salary { under3, over3, over4, over5, over6, over7, over8, over9, over10 }

extension SalaryLiteral on Salary {
  get literal {
    switch (this) {
      case Salary.under3:
        return '3천 이하';
      case Salary.over3:
        return '3천 이상';
      case Salary.over4:
        return '4천 이상';
      case Salary.over5:
        return '5천 이상';
      case Salary.over6:
        return '6천 이상';
      case Salary.over7:
        return '7천 이상';
      case Salary.over8:
        return '8천 이상';
      case Salary.over9:
        return '9천 이상';
      case Salary.over10:
        return '1억 이상';
    }
  }
}

enum Character {
  extrovert,
  introvert,
  macho,
  calm,
  talkative,
  silent,
  sexy,
  humorous,
  considerate,
  emotional,
  reasonable,
  free,
  plan,
  adorable,
  cute,
  graceful,
  normal,
  ugly,
  sexual,
}

extension CharacterLiteral on Character {
  get literal {
    switch (this) {
      case Character.extrovert:
        return '외향적인';
      case Character.introvert:
        return '내성적인';
      case Character.macho:
        return '상남자같은';
      case Character.calm:
        return '차분한';
      case Character.talkative:
        return '수다스러운';
      case Character.silent:
        return '과묵한';
      case Character.sexy:
        return '섹시한';
      case Character.humorous:
        return '유머있는';
      case Character.considerate:
        return '배려심깊은';
      case Character.emotional:
        return '감성적인';
      case Character.reasonable:
        return '이성적인';
      case Character.free:
        return '자유로운';
      case Character.plan:
        return '계획적인';
      case Character.adorable:
        return '애교있는';
      case Character.cute:
        return '귀여운';
      case Character.graceful:
        return '우아한';
      case Character.normal:
        return '평범한';
      case Character.ugly:
        return '못생긴';
      case Character.sexual:
        return '성적성향이있는';
    }
  }
}

enum BodyType {
  type1,
  type2,
  type3,
  type4,
  type5,
  type6,
  type7,
  type8,
  type9,
  type10,
}

extension BodyTypeLiteral on BodyType {
  get male {
    switch (this) {
      case BodyType.type1:
        return '곰같은';
      case BodyType.type2:
        return '근육질인';
      case BodyType.type3:
        return '보통인';
      case BodyType.type4:
        return '어깨가 넓은';
      case BodyType.type5:
        return '허벅지가 탄탄한';
      case BodyType.type6:
        return '엉덩이가 예쁜';
      case BodyType.type7:
        return '배가 나온';
      case BodyType.type8:
        return '근육돼지';
      case BodyType.type9:
        return '마른';
      case BodyType.type10:
        return '얼굴이 작은';
    }
  }

  get female {
    switch (this) {
      case BodyType.type1:
        return '글래머러스한';
      case BodyType.type2:
        return '통통한';
      case BodyType.type3:
        return '살집이 있는';
      case BodyType.type4:
        return '가슴이 큰';
      case BodyType.type5:
        return '엉덩이가 예쁜';
      case BodyType.type6:
        return '허리가 잘록한';
      case BodyType.type7:
        return '얼굴이 작은';
      case BodyType.type8:
        return '보통인';
      case BodyType.type9:
        return '여리여리한';
      case BodyType.type10:
        return '근육질인';
    }
  }
}
