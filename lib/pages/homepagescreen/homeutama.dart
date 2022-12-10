import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/gen/flutterblueplus.pbserver.dart';

import '../../shared/theme.dart';

class HomeUtama extends StatefulWidget {
  const HomeUtama(
      {required this.nama,
      required this.id,
      required this.listStream,
      required this.debugAngka,
      super.key});
  final String nama;
  final String id;
  // final List<BluetoothService> services;
  // final Stream<List<int>>? listStream;
  final String listStream;
  final String debugAngka;

  @override
  State<HomeUtama> createState() => _HomeUtamaState();
}

// Stream<int> dummyData() async* {
//   for (int i = 0; i <= 5; i++) {
//     await Future.delayed(const Duration(seconds: 1));
//     yield i;
//   }
// }

class _HomeUtamaState extends State<HomeUtama> {
  /*Stream dummyData = Stream.periodic(
    const Duration(seconds: 1),
    ((i) {
      int rand = Random().nextInt(10);

      if (rand > 0 && rand < 2) {
        int randDouble = Random().nextInt(30);
        return randDouble + 20;
      } else if (rand > 9 && rand < 10) {
        int randDouble = Random().nextInt(30);
        return randDouble + 80;
      } else {
        int randDouble = Random().nextInt(30);
        return randDouble + 50;
      }
    }),
  );*/
  int dummyValue = Random().nextInt(50) + 30;
  // late StreamSubscription _sub;

  /* @override
  void initState() {
    super.initState();
    _sub = dummyData.listen((event) {
      if (mounted) {
        setState(() {
          dummyValue = event;
        });
      }
    });

    _sub.resume();
  }*/

  @override
  void dispose() {
    // _sub.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Connected to ${widget.nama}',
            style: cNavBarText.copyWith(
              fontSize: 10,
              color: cPurpleDarkColor,
            ),
          ),
          Text(
            widget.id,
            style: cNavBarText.copyWith(
              fontSize: 10,
              color: cPurpleDarkColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  color: cGreyColor,
                  height: 2,
                  margin: const EdgeInsets.only(
                    right: 10,
                  ),
                ),
              ),
              Text(
                'Status Kamu',
                style: cNavBarText.copyWith(
                  fontSize: 20,
                  color: cPurpleDarkColor,
                ),
              ),
              Expanded(
                child: Container(
                  color: cGreyColor,
                  height: 2,
                  margin: const EdgeInsets.only(
                    left: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          //
          //
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.favorite,
                    size: 50,
                    color: cRedColor,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  /*StreamBuilder<List<int>>(
                    stream:
                        widget.listStream, //here we're using our char's value
                    initialData: [],
                    builder: (BuildContext context,
                        AsyncSnapshot<List<int>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        //In this method we'll interpret received data
                        // interpretReceivedData(currentValue);

                        return Text(
                          snapshot.data.toString() + ' DPM',
                          style: cHeader1Style.copyWith(
                            color: cBlackColor,
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),*/
                  Text(
                    '${widget.listStream} DPM',
                    style: cHeader1Style.copyWith(
                      color: cBlackColor,
                    ),
                  ),
                  /*Text(
                    '$dummyValue DPM',
                    style: cHeader1Style.copyWith(
                      color: cBlackColor,
                    ),
                  ),*/
                ],
              ),
              /*Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.favorite,
                    size: 50,
                    color: cRedColor,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    '${dummyValue + Random().nextInt(7)} %',
                    style: cHeader1Style.copyWith(
                      color: cBlackColor,
                    ),
                  ),
                ],
              )*/
            ],
          ),
          //
          //
          const SizedBox(
            height: 26,
          ),
          Text(
            dummyValue < 50
                ? 'HeartRate Rendah'
                : dummyValue > 80
                    ? 'HeartRate Tinggi'
                    : 'Normal',
            style: cNavBarText.copyWith(
              fontSize: 20,
              color: cPurpleDarkColor,
            ),
          ),
          Text(widget.debugAngka),
          /*ElevatedButton(
            onPressed: () {
              _sub.pause();
            },
            child: const Text('pause'),
          ),*/
        ],
      ),
    );
  }
}
