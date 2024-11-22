import 'package:dimple/common/const/colors.dart';
import 'package:dimple/common/layout/default_layout.dart';
import 'package:dimple/dashboard/component/dashboard_container.dart';
import 'package:dimple/dashboard/component/dashboard_petInfo_container.dart';
import 'package:dimple/dashboard/view/moved_distance_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final FlipCardController _controller = FlipCardController();
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.flipcard();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const NeverScrollableScrollPhysics();
    return DefaultLayout(
      floatingActionButton: _getMultiplePets(),
      child: SafeArea(
        child: CustomScrollView(
          controller: controller,
          slivers: [
            const SliverAppBar(),
            petInfoSliver(_controller),
            makeSpace(),
            movedDistance(context),
            makeSpace(),
            pupuActivity(),
          ],
        ),
      ),
    );
  }
}

Widget _getMultiplePets(){
  return SpeedDial(
    spaceBetweenChildren: 5,
    visible: true,
    animatedIcon: AnimatedIcons.menu_close,
    animatedIconTheme: IconThemeData(size: 20),
    backgroundColor: PRIMARY_COLOR  ,
    curve: Curves.bounceIn,
    children: [
      SpeedDialChild(
        backgroundColor: PRIMARY_COLOR,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset('assets/img/banreou.png',fit: BoxFit.cover,),
        ),
        onTap: (){},
      ),

      SpeedDialChild(
        backgroundColor: PRIMARY_COLOR,
        child:  Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset('assets/img/runningDog.jpg',fit: BoxFit.cover,),
        ),
        onTap: (){},
      ),
    ],
  );
}


SliverPadding petInfoSliver(FlipCardController controller) {
  return SliverPadding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    sliver: SliverToBoxAdapter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FlipCard(
            rotateSide: RotateSide.bottom,
            onTapFlipping: true,
            axis: FlipAxis.vertical,
            controller: controller,
            frontWidget: DashboardPetInfoCard(
              img: Image.asset(
                'assets/img/banreou.png',
                fit: BoxFit.cover,
              ),
              name: '마콩',
              age: 12,
              type: '포메라니안',
              petNum: 1234567891011,
              isFront: true,
            ),
            backWidget: DashboardPetInfoCard(
              img: Image.asset(
                'assets/img/banreou.png',
                fit: BoxFit.cover,
              ),
              name: '마콩',
              type: '포메라니안',
              lastCheck: '2022-03-21',
              weight: 2.2,
              isFront: false,
            ),
          ),
        ],
      ),
    ),
  );
}

SliverPadding movedDistance(BuildContext context) {
  return SliverPadding(
    padding: const EdgeInsets.symmetric(horizontal: 30.0),
    sliver: SliverToBoxAdapter(
      child: DashboardContainer(
        title: '이동거리',
        // // 이렇게하면 바텀네비게이션바 없애면서 페이지 이동 --> 나중에 라우터 적용하면 달라짐
        // onTap: () {
        //  pushScreen(context, screen: MovedDistanceScreen(),withNavBar: false);
        // },
        // 이렇게하면 바텀네비게이션바 유지하면서 페이지이동 --> 나중에 라우터 적용하면 달라짐
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => MovedDistanceScreen()));
        },

        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/runningDog.jpg',
                fit: BoxFit.cover,
                width: 60,
                height: 60,
              ),
              const Column(
                children: [
                  Text(
                    '80KM',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '123kcal',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

SliverPadding makeSpace() {
  return SliverPadding(
    padding: EdgeInsets.only(top: 16.0),
  );
}

SliverPadding pupuActivity() {
  return SliverPadding(
    padding: const EdgeInsets.symmetric(horizontal: 30.0),
    sliver: SliverToBoxAdapter(
      child: DashboardContainer(
        title: '배변활동',
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/pupuActivity.png',
                fit: BoxFit.cover,
                width: 60,
                height: 60,
              ),
              Row(
                children: [
                  Text(
                    '10',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        child: IconButton(
                            onPressed: () {}, icon: Icon(Icons.plus_one)),
                      ),
                      CircleAvatar(
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.exposure_minus_1)),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

SliverPadding adminHealth() {
  return SliverPadding(
    padding: const EdgeInsets.symmetric(horizontal: 30.0),
    sliver: SliverToBoxAdapter(
      child: DashboardContainer(
        title: '건강 관리',
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/pupuActivity.png',
                fit: BoxFit.cover,
                width: 60,
                height: 60,
              ),
              Row(
                children: [
                  Text(
                    '10',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        child: IconButton(
                            onPressed: () {}, icon: Icon(Icons.plus_one)),
                      ),
                      CircleAvatar(
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.exposure_minus_1)),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
