import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding/data/colors.dart';

enum GuidePageType { howto, rule, service, refund }

extension GuidePageTypeLiteral on GuidePageType {
  String get literal {
    switch (this) {
      case GuidePageType.howto:
        return '매칭방법';
      case GuidePageType.rule:
        return '이용규칙';
      case GuidePageType.service:
        return '주선자서비스';
      case GuidePageType.refund:
        return '환불정책';
    }
  }
}

class GuidePageState {
  GuidePageType guidePageType;
  GuidePageState({required this.guidePageType});
  GuidePageState copyWith({
    GuidePageType? guidePageType,
  }) {
    return GuidePageState(guidePageType: guidePageType ?? this.guidePageType);
  }
}

class GuidePageBloc extends Cubit<GuidePageState> {
  GuidePageBloc() : super(GuidePageState(guidePageType: GuidePageType.howto));

  void setType(GuidePageType guidePageType) {
    emit(state.copyWith(guidePageType: guidePageType));
  }
}

class GuidePage extends StatelessWidget {
  const GuidePage({Key? key}) : super(key: key);

  Widget buildTab(GuidePageType guidePageType) {
    return BlocBuilder<GuidePageBloc, GuidePageState>(
      builder: (context, state) {
        final isSelected = guidePageType == state.guidePageType;
        return GestureDetector(
          child: Container(
            child: Text(
              guidePageType.literal,
              style: TextStyle(color: isSelected ? secondaryColor : textColor),
            ),
            decoration: BoxDecoration(
                border: Border.all(color: isSelected ? secondaryColor : textColor),
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent),
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          ),
          onTap: () {
            context.read<GuidePageBloc>().setType(guidePageType);
          },
        );
      },
      buildWhen: (previous, current) {
        return previous.guidePageType != current.guidePageType;
      },
    );
  }

  Widget buildHowTo() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text('매일 3명의 이성 중 한 명을 선택합니다.', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text('다중 선택은 불가합니다. 하루에 한 명만 선택할 수 있습니다. 만약 마음에 드는 이성이 없다면, 주선자에게 세부적인 조건에 맞는 이성을 3명까지 소개받을 수 있습니다.(유료) 이때, 3명의 이성이 모두 수락하지 않을 수 있습니다', style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w400)),
          Padding(child: Image.asset('assets/images/spacer.png', scale: 2), padding: const EdgeInsets.all(16)),
          const Text('열람된 이성의 정보는 무료와 유료정보로 나눠집니다.', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text('유료정보에는 상대방 가족들에 관한 정보가 포함되어있습니다.', style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w400)),
          Padding(child: Image.asset('assets/images/spacer.png', scale: 2), padding: const EdgeInsets.all(16)),
          const Text('꽃다발 보내기를 신청한 후 상대방의 응답을 기다립니다.', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text('상대방이 수락을 하면 서로의 연락처가 공개되고 어플은 양쪽 다 휴면처리 됩니다. 상대방이 거절했을 경우에는 다시 첫페이지로 돌아가 다른 이성을 선택합니다.', style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w400)),
          Padding(child: Image.asset('assets/images/spacer.png', scale: 2), padding: const EdgeInsets.all(16)),
          const Text('성사 실패 후 재이용을 원할 때에는 “만남종료”버튼을 누릅니다.', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text('해당 어플은 가벼운 만남을 지양하기 위해서 다중만남을 원칙적으로 금지합니다. 매칭이 성공하면 어플이 자동적으로 양쪽 둘 다 일시 휴면처리가 됩니다. 따라서 재이용을 원할때에는 ‘만남종료’버튼을 눌러야 휴면이 취소됩니다.이 때 양쪽 중 한명이라도 만남 종료를 누르면 양쪽 다 휴면이 취소되고 활성화 됩니다.', style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w400)),
          Padding(child: Image.asset('assets/images/spacer.png', scale: 2), padding: const EdgeInsets.all(16)),
          const Text('위의 절차를 반복하면 되며, 사용자가 진정한 소울메이트를 만날 때까지 매칭브릿지는 최선을 다하겠습니다.', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
      padding: const EdgeInsets.all(20),
    );
  }

  Widget buildRules() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text('다중매칭 금지', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text('매칭이 되면 만남이 끝날때까지 동시에 다른 이성을 소개받을 수 없습니다. 따라서 매칭 후에는 자동적으로 휴면 처리가 되며 이성은 상대 이성 또한 마찬가지 입니다. 재소개를 원하신다면 ‘만남종료’아이콘을 눌러주세요. 소개가 활성화되고 상대이성의 어플도 자동적으로 활성화가 됩니다.', style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w400)),
          Padding(child: Image.asset('assets/images/spacer.png', scale: 2), padding: const EdgeInsets.all(16)),
          const Text('신분 위조 금지', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text('매칭브릿지를 이용하기 위해 기입하는 모든 개인 정보들은 본인의 것이어야 합니다. 타인의 정보를 도용해서는 안됩니다. 인증 서류들도 마찬가지로 본인의 인증 서류들이어야 합니다. 만약 위조인것으로 드러났을 경우 어떠한 환불 조치 없이 영구적으로 제명됩니다.', style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w400)),
          Padding(child: Image.asset('assets/images/spacer.png', scale: 2), padding: const EdgeInsets.all(16)),
          const Text('첫만남 이후 후기 남기기', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text('매칭이 되고 이루어진 첫만남 이후 서로에 대한 만남후기를 남겨주세요. 이는 차후에 주선자가 컨설팅을 하는데 많은 참고자료가 될 수 있습니다. 이 후기는 글쓴이와 후기 본인, 그리고 주선자만 열람이 가능합니다.', style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w400)),
        ],
      ),
      padding: const EdgeInsets.all(20),
    );
  }

  Widget buildService() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset('assets/images/dislike.png', scale: 2),
          const SizedBox(height: 16),
          const Text('자동소개되는 이성이 마음에 들지 않아요.', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text("가입 후 심사절차를 거친 후 같은 지역 내의 3명의 이성을 소개받는다. 주선자에게 직접 맞춤 제시를 받고 싶은 경우 '주선자에게 제시받기' 버튼을 누른다. (주선자에게 직접 제시받기는 데이트신청하기와는 별도의 유료 서비스입니다.)", style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w400)),
          TextButton(
            child: const Text('만남 컨설팅 받기', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400)),
            onPressed: () {

            }, 
            style: TextButton.styleFrom(
              backgroundColor: secondaryColor,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)))
            ),
          ),
          Padding(child: Image.asset('assets/images/spacer.png', scale: 2), padding: const EdgeInsets.all(16)),
          const Text('매칭 후 데이트 컨설팅 서비스.', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          const Text('매칭후 소개팅을 성공적으로 끝내기위해 주선자가 정성껏 설계해드립니다.', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 16),
          Column(
            children: [
              Text('1. 소개팅 만남 컨설팅(온라인)', style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w400)),
              Text('a. 매칭된 이성에 대한 정보를 바탕으로 설계합니다.', style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w400)),
              Text('b. 외형 스타일링 상담.', style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w400)),
              Text('c. 데이트코스 추천', style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w400)),
              const SizedBox(height: 16),
              Text('2. 소개팅 만남 컨설팅(고객에게 찾아가는 서비스)', style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w400)),
              Text('a. 매칭된 이성에 대한 정보를 바탕으로 설계합니다.', style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w400)),
              Text('b. 외형 스타일링 상담.', style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w400)),
              Text('c. 데이트코스 추천', style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w400)),
            ],
            crossAxisAlignment: CrossAxisAlignment.stretch,
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
      padding: const EdgeInsets.all(20),
    );
  }

  Widget buildRefund() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text('1. 회원은 회사가 제공하는 다양한 결제수단을 통해 유료서비스를 이용할 수 있으며, 결제가 비정상적으로 처리되어 정상처리를 요청할 경우 결제금액을 정상처리할 의무를 가집니다.', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 16),
          const Text('2. 회사는 부정한 방법 또는 회사가 금지한 방법을 통해 충전 및 결제된 금액에 대해서는 이를 취소 하거나 환불을 제한할 수 있습니다.',style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          Text('(충전 후 결제사에서 직접 결제취소 한 경우 부여받은 꽃다발은 환수 조치)', style: TextStyle(color: hintColor, fontSize: 12, fontWeight: FontWeight.w400)),
          const SizedBox(height: 16),
          const Text('3. 회원은 다음 각 호의 사유가 있으면 아래의 4항 규정에 따라서 회사로부터 결제 취소, 환불 및 보상을 받을 수 있습니다.', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          Padding(
            child: Column(
              children: [
                Text('· 결제를 통해 사용할 수 있는 서비스가 전무하여 그에 대한 책임이 전적으로 회사에 있을 경우 (단, 사전 공지된 시스템 정기 점검 등의 불가피한 경우는 제외)', style: TextStyle(color: hintColor, fontSize: 12, fontWeight: FontWeight.w400)),
                Text('· 회사 또는 결제대행사의 시스템 오류로 인하여 결제기록이 중복으로 발생한 경우', style: TextStyle(color: hintColor, fontSize: 12, fontWeight: FontWeight.w400)),
                Text('· 서비스 종료등의 명목으로 회사가 회원에게 해지를 통보하는 경우', style: TextStyle(color: hintColor, fontSize: 12, fontWeight: FontWeight.w400)),
                Text('· 기타 소비자 보호를 위하여 당사에서 따로 정하는 경우', style: TextStyle(color: hintColor, fontSize: 12, fontWeight: FontWeight.w400)),
                Text('· 회원이 미사용한 아이템을 유료 결제 후 7일 이내에 환불 요청 하는 경우  단, 1번이라도 이용기록이 있을 경우 환불은 불가합니다.', style: TextStyle(color: hintColor, fontSize: 12, fontWeight: FontWeight.w400)),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            padding: const EdgeInsets.only(left: 12),
          ),
          const SizedBox(height: 16),
          
          const Text('4. 환불, 결제 취소 절차는 다음 각 항목과 같습니다.', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400)),
          Padding(
            child: Column(
              children: [
                Text('· 환불을 원하는 회원은 고객센터에 연락하여 본인임을 인증하고 환불 사유를 구체적으로 명시하여 접수하셔야 합니다.', style: TextStyle(color: hintColor, fontSize: 12, fontWeight: FontWeight.w400)),
                Text('· 회사는 회원이 환불 요청 사유가 적합한지를 판단하고 3항의 환불사유가 존재하고, 적합한 절차를 거친 것으로 판명된 회원에게 환불합니다.', style: TextStyle(color: hintColor, fontSize: 12, fontWeight: FontWeight.w400)),
                Text('· 회사는 회원에게 환불되어야 할 금액 산정방식과 절차를 회원에게 상세히 설명하고 난 후 회원에게 해당 환불 및 결제 취소 처리합니다.', style: TextStyle(color: hintColor, fontSize: 12, fontWeight: FontWeight.w400)),
                Text('· 회원은 구매시점으로부터 7일 이내인 경우 환불 요청이 가능하며 구매시점 7일 이후에는 시스템 오류로의 미지급 등 회사의 귀책사유로 인정되는 경우에만 환불이 가능합니다.', style: TextStyle(color: hintColor, fontSize: 12, fontWeight: FontWeight.w400)),
              ],
            ),
            padding: const EdgeInsets.only(left: 12),
          ),
          const SizedBox(height: 16),
          const Text('5. 회원이 이용약관을 위반한 행위로 인해 이용정지 또는 강제탈퇴 되는 경우 환불 및 보상하지 않습니다.', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400))
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      padding: const EdgeInsets.all(20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            color: Colors.black,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('이용 절차', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                child: Row(children: GuidePageType.values.map((guidePageType) => buildTab(guidePageType)).toList()),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                scrollDirection: Axis.horizontal,
              ),
              BlocBuilder<GuidePageBloc, GuidePageState>(
                builder: (context, state) {
                  return IndexedStack(
                    children: [
                      buildHowTo(),
                      buildRules(),
                      buildService(),
                      buildRefund(),
                    ],
                    index: state.guidePageType.index,
                  );
                },
                buildWhen: (previous, current) {
                  return previous.guidePageType != current.guidePageType;
                },
              )
            ],
          ),
        ),
      ),
      create: (context) => GuidePageBloc(),
    );
  }
}
