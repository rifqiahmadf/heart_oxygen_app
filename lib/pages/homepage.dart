// import 'dart:io';
import 'dart:ui';
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:heart_oxygen_alarm/cubit/bottompage/bottompage_cubit.dart';
import 'package:heart_oxygen_alarm/pages/bluetoothoffscreen.dart';
import 'package:heart_oxygen_alarm/pages/homepagescreen/homemap.dart';
import 'package:heart_oxygen_alarm/pages/homepagescreen/homesolusi.dart';
import 'package:heart_oxygen_alarm/pages/homepagescreen/homeutama.dart';
import 'package:heart_oxygen_alarm/pages/loginpage.dart';
import 'package:heart_oxygen_alarm/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth/auth_cubit.dart';
import '../widget/bluetoothwidget.dart';

class HomePage extends StatefulWidget {
  HomePage({required this.bluetoothDevice, super.key});
  final BluetoothDevice bluetoothDevice;

  static const nameRoute = '/homePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stream<List<int>>? listStream;
  BluetoothCharacteristic? c;

  // late BluetoothCharacteristic c;

  discoverServices() async {
    List<BluetoothService> services =
        await widget.bluetoothDevice.discoverServices();
    //checking each services provided by device
    print('masuk discover 1');
    services.forEach(
      (service) {
        if (service.uuid.toString().toUpperCase().substring(4, 8) == '180D') {
          print('masuk discover 2 : ${service.uuid.toString()}');
          service.characteristics.forEach(
            (characteristic) async {
              if (characteristic.uuid
                      .toString()
                      .toUpperCase()
                      .substring(4, 8) ==
                  '2A37') {
                print('masuk discover 3 : ${characteristic.uuid.toString()}');
                //Updating characteristic to perform write operation.
                // c = characteristic;

                await characteristic
                    .setNotifyValue(!characteristic.isNotifying);
                await characteristic.read();
                setState(() {
                  listStream = characteristic.value.asBroadcastStream();
                  c = characteristic;
                });

                // characteristic.read();
              }
            },
          );
        }
      },
    );
  }

  readAgain() async {
    await c!.setNotifyValue(!c!.isNotifying);
    await c!.read();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    discoverServices();
  }

  @override
  Widget build(BuildContext context) {
    /*listStream.listen((event) {
      print('hasil new = ${event.toString()}');
    });*/
    /*print('hasil 1 = ${widget.bluetoothDevice.id}');
    widget.bluetoothDevice.discoverServices();

    widget.bluetoothDevice.services.listen((event) {
      print('hasil 2 = ${event.length}');
      // print(event[5]);
    });
    /*bluetoothDevice.services.asyncMap((event) {
      print('hasil 2 = $event');
    });*/
    /*bluetoothDevice.services.listen((event) {
      event.map((e) => print('hasil = ${e.uuid}'));
    });*/*/
    var bloc = context.read<BottompageCubit>();

    Widget contentPage(int index, String heartRate) {
      switch (index) {
        case 1:
          return const HomeMap();
        case 2:
          /*return StreamBuilder(
            stream: listStream,
            initialData: [],
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return HomeUtama(
                nama: widget.bluetoothDevice.name,
                id: widget.bluetoothDevice.id.toString(),
                listStream: snapshot.data,
              );
            },
          );*/
          return HomeUtama(
            nama: widget.bluetoothDevice.name,
            id: widget.bluetoothDevice.id.toString(),
            listStream: heartRate,
          );

        case 3:
          return const HomeSolusi();
        default:
          return HomeUtama(
            nama: widget.bluetoothDevice.name,
            id: widget.bluetoothDevice.id.toString(),
            listStream: heartRate,
          );
      }
    }

    TextStyle navBarColor(int index, int state) {
      if (index == state) {
        return cNavBarText.copyWith(
          color: cPurpleDarkColor,
        );
      }
      return cNavBarText;
    }

    print(
        'namanya${widget.bluetoothDevice.name} : ${widget.bluetoothDevice.id}');
    return StreamBuilder<BluetoothState>(
      stream: FlutterBluePlus.instance.state,
      initialData: BluetoothState.unknown,
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state == BluetoothState.on) {
          return Scaffold(
            body: Stack(
              children: [
                Image.asset('assets/images/headerhome.png'),
                SafeArea(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthFailed) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.error),
                              backgroundColor: cRedColor,
                            ),
                          );
                        } else if (state is AuthInitial) {
                          context.read<BottompageCubit>().setPage(2);
                          Navigator.pushNamedAndRemoveUntil(
                              context, LoginPage.nameRoute, (route) => false);
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return IconButton(
                          onPressed: () {
                            context.read<AuthCubit>().signOut();
                          },
                          icon: const Icon(
                            Icons.logout_outlined,
                            color: cPurpleColor,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SafeArea(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return FindDevicesScreen();
                          },
                        ));
                      },
                      icon: StreamBuilder(
                        stream: widget.bluetoothDevice.state,
                        initialData: BluetoothDeviceState.connecting,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return snapshot.data == BluetoothDeviceState.connected
                              ? const Icon(
                                  Icons.bluetooth_connected,
                                  color: cPurpleColor,
                                )
                              : const Icon(
                                  Icons.bluetooth_disabled,
                                  color: cPurpleColor,
                                );
                        },
                      ),
                    ),
                  ),
                ),
                /*SafeArea(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: StreamBuilder<List<int>>(
                      stream: listStream, //here we're using our char's value
                      initialData: [],
                      builder: (BuildContext context,
                          AsyncSnapshot<List<int>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                              //In this method we'll interpret received data
                              // interpretReceivedData(currentValue);

                          return Text(snapshot.data.toString());
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                  ),
                ),*/

                //
                //
                BlocBuilder<BottompageCubit, int>(
                  builder: (context, state) {
                    return StreamBuilder<List<int>>(
                      stream: listStream,
                      initialData: [],
                      builder: (context, snapshot) {
                        return snapshot.data!.length < 2
                            ? contentPage(state, 'loading')
                            : contentPage(state, snapshot.data![1].toString());
                      },
                    );
                  },
                ),

                //
                //
                //! bottom nav bar
                BlocBuilder<BottompageCubit, int>(
                  builder: (context, state) {
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 5,
                            sigmaY: 5,
                          ),
                          child: Container(
                            height: 105,
                            alignment: Alignment.topCenter,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            width: double.infinity,
                            color: state == 1
                                ? const Color(0xffF4F3FF).withOpacity(0.8)
                                : const Color(0xffF4F3FF),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    bloc.setPage(1);
                                  },
                                  child: Text(
                                    'Map',
                                    style: navBarColor(1, state),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    bloc.setPage(2);
                                  },
                                  child: Text(
                                    'Utama',
                                    style: navBarColor(2, state),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    bloc.setPage(3);
                                  },
                                  child: Text(
                                    'Solusi',
                                    style: navBarColor(3, state),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }
        return BluetoothOffScreen(
          state: state,
        );
      },
    );
  }
}

class FindDevicesScreen extends StatelessWidget {
  const FindDevicesScreen({Key? key}) : super(key: key);

  static const nameRoute = '/findDevicesScreen';

  @override
  Widget build(BuildContext context) {
    print('masuk 2');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cPurpleColor,
        title: const Text('Find Mi Band Connection'),
      ),
      //! Bluetooth : 5.2 RefreshIndicator berfungsi untuk merefresh ulang halaman dengan menscroll kebawah melebihi batas scroll
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //! Bluetooth : 5.7 megecek secara rutin apakah ada ada device yang terconnect, kalau ada nanti tampilin tombol open yang akan mengarahkan ke device screen
            //! fungsi tombol ini kalau misal dari device screen ke back lagi ke halaman findDevice, maka akan ada tampilan button untuk kembali ke halaman device screen
            StreamBuilder<List<BluetoothDevice>>(
              stream: Stream.periodic(const Duration(seconds: 2))
                  .asyncMap((_) => FlutterBluePlus.instance.connectedDevices),
              initialData: const [],
              builder: (c, snapshot) {
                return Column(
                  children: snapshot.data!
                      .map(
                        (d) => ListTile(
                          title: Text(d.name),
                          subtitle: Text(d.id.toString()),
                          trailing: StreamBuilder<BluetoothDeviceState>(
                            stream: d.state,
                            initialData: BluetoothDeviceState.disconnected,
                            builder: (c, snapshot) {
                              if (snapshot.data ==
                                  BluetoothDeviceState.connected) {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: cPurpleColor,
                                    shape: const StadiumBorder(),
                                  ),
                                  child: const Text('OPEN'),
                                  onPressed: () => Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) {
                                      return HomePage(
                                        bluetoothDevice: d,
                                      );
                                    }),
                                  ),
                                );
                              }
                              return Text(snapshot.data.toString());
                            },
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
            //! Bluetooth : 5.5 hasil scan setelah proses 5.4 akan dilisten menggunakan stream disini, return stream berupa list dari seluruh scan device
            StreamBuilder<List<ScanResult>>(
              stream: FlutterBluePlus.instance.scanResults,
              initialData: const [],
              builder: (c, snapshot) {
                return Column(
                  children: snapshot.data!
                      .map(
                        //! Bluetooth : 5.5.1 di map ke dalam widget custom ScanResultTile
                        (r) => ScanResultTile(
                          result: r,
                          //! Bluetooth : 5.6.7 voidcallback ontap akan menampilkan halaman DeviceScreen yang kita connect
                          onTap: () => Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            //! Bluetooth : 5.6.8 Connect ke device menggunakan method result.device.connect()
                            r.device.disconnect();
                            r.device.connect();

                            return HomePage(
                              bluetoothDevice: r.device,
                            );
                          })),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),

      //! Bluetooth : 5.4 tombol floatingaction button untuk melakukan scan device bluetooth yang tersedia (return data dari stream adalah bool yang berisi tentang informasi apakah sedang menjalankan proses scan atau tidak)
      floatingActionButton: StreamBuilder<bool>(
        //? mengambil status boolean dari isscanning
        stream: FlutterBluePlus.instance.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          //? kalau snapshot true karena sedang melakukan scanning, maka akan merubah button menjadi button stop
          if (snapshot.data!) {
            return FloatingActionButton(
              //? kalau sedang melakukan scan, memanggil fungsi stopScan untuk menghentikan scan, mengubah snapshot dari true menjadi false
              onPressed: () => FlutterBluePlus.instance.stopScan(),
              backgroundColor: Colors.red,
              child: Icon(Icons.stop),
            );
            //? kalau snapshot false, maka akan melakukan scanning, ketika melakukan startScan maka snpshot akan berubah menjadi true
          } else {
            return FloatingActionButton(
              //? memanggul fungsi startscan, mengubah snapshot dari stream menjadi true
              onPressed: () => FlutterBluePlus.instance.startScan(
                timeout: const Duration(seconds: 4),
              ),
              backgroundColor: cPurpleColor,
              child: const Icon(Icons.search),
            );
          }
        },
      ),
    );
  }
}

//! ========================================================================================================================================================================================================================

//! Bluetooth : 6 ketika tombol connect di FindDeviceScreen dipanggil, maka akan diarahkan ke halaman ini
class DeviceScreen extends StatelessWidget {
  const DeviceScreen({Key? key, required this.device}) : super(key: key);

  final BluetoothDevice device;

  //! Bluetooth : 7 _getRandomBytes akan menggenerate angka random yang akan digunakan untuk nilai write (tidak begitu penting kalau kita cuma mau ngeread aja)
  List<int> _getRandomBytes() {
    final math = Random();
    return [
      math.nextInt(255),
      math.nextInt(255),
      math.nextInt(255),
      math.nextInt(255)
    ];
  }

  //! Bluetooth : 7.2 _buildServiceTiles akan menampilkan list service yang tersedia dari device tersebut
  List<Widget> _buildServiceTiles(List<BluetoothService> services) {
    return services
        .map(
          //! Bluetooth : 7.5 memanggil widget ServiceTile untuk menampilkan informasi Service
          (s) => ServiceTile(
            service: s,
            //! Bluetooth : 7.4 memanggil widget CharacteristicTile untuk menampilkan informasi Characteristic dari Service, diexpand ketika menekan ServiceTile
            characteristicTiles: s.characteristics
                .map(
                  (c) => CharacteristicTile(
                    characteristic: c,
                    onReadPressed: () => c.read(),
                    onWritePressed: () async {
                      await c.write(_getRandomBytes(), withoutResponse: true);
                      await c.read();
                    },
                    onNotificationPressed: () async {
                      await c.setNotifyValue(!c.isNotifying);
                      await c.read();
                    },
                    //! Bluetooth : 7.3 memanggil widget DescriptorTile untuk menampilkan informasi Characteristic dari Service, diexpand ketika menekan CharacteristicTile
                    descriptorTiles: c.descriptors
                        .map(
                          (d) => DescriptorTile(
                            descriptor: d,
                            onReadPressed: () => d.read(),
                            onWritePressed: () => d.write(_getRandomBytes()),
                          ),
                        )
                        .toList(),
                  ),
                )
                .toList(),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    //! Bluetooth : 6.1 informasi device yang dipilih ditampilkan disini
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cPurpleColor,
        //? menampilkan nama device
        title: Text(device.name),
        actions: <Widget>[
          //! Bluetooth : 6.2 mengubah nilai button connect/disconnect di appbar, melakukan stream untuk selalu mengecek apakah device terconnect atau ngga
          StreamBuilder<BluetoothDeviceState>(
            stream: device.state,
            initialData: BluetoothDeviceState.connecting,
            builder: (c, snapshot) {
              VoidCallback? onPressed;
              String text;
              //? kalau connect maka tampilkan button disconnect, begitu pula sebaliknya
              switch (snapshot.data) {
                case BluetoothDeviceState.connected:
                  onPressed = () => device.disconnect();
                  text = 'DISCONNECT';
                  break;
                case BluetoothDeviceState.disconnected:
                  onPressed = () => device.connect();
                  text = 'CONNECT';
                  break;
                default:
                  onPressed = null;
                  //? substring ke 21 isinya apa yaaa ????
                  text = snapshot.data.toString().substring(21).toUpperCase();
                  break;
              }
              //? text button berdasarkan switch diatas
              return TextButton(
                onPressed: onPressed,
                child: Text(
                  text,
                  style: Theme.of(context)
                      .primaryTextTheme
                      .button
                      ?.copyWith(color: Colors.white),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //! Bluetooth : 6.3 return stream adalah icon bluetooth dan text kekuatan dari bluetooth (rssi), serta device id dan tombol repeat untuk merefresh
            StreamBuilder<BluetoothDeviceState>(
              stream: device.state,
              initialData: BluetoothDeviceState.connecting,
              builder: (c, snapshot) => ListTile(
                //? leading nampilin icon bluetooth dan kekuatan rssi/sinyal
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    snapshot.data == BluetoothDeviceState.connected
                        ? const Icon(Icons.bluetooth_connected)
                        : const Icon(Icons.bluetooth_disabled),
                    snapshot.data == BluetoothDeviceState.connected
                        ? StreamBuilder<int>(
                            stream: rssiStream(),
                            builder: (context, snapshot) {
                              return Text(
                                  snapshot.hasData ? '${snapshot.data}dBm' : '',
                                  style: Theme.of(context).textTheme.caption);
                            })
                        : Text('', style: Theme.of(context).textTheme.caption),
                  ],
                ),
                //? Device is Connected .. or .. Device is Disconnected
                title: Text(
                  'Device is ${snapshot.data.toString().split('.')[1]}.',
                ),
                //? id dari devicenya
                subtitle: Text('${device.id}'),
                //? button refresh
                trailing: StreamBuilder<bool>(
                  //? menstream isDiscoveringServices yang menunjukkan apakah sedang melakukab proses discoverService atau tidak
                  stream: device.isDiscoveringServices,
                  initialData: false,
                  //? indexedStack berfungsi seperti stack biasa, tapi bisa berpindah-pindah stack berdasarkan index yang kita tentukan
                  builder: (c, snapshot) => IndexedStack(
                    //? kalau service sedang memuat ulang atau service lagi kosong, maka akan mereturn index 0, kalau data dari service tersedia, maka return index 1
                    index: snapshot.data! ? 1 : 0,
                    children: <Widget>[
                      //? kalau sedang tidak tidak melakukan discoverService maka tampilkan tombol refresh
                      //? tombol refresh untuk melakukan refresh dan menampilkan list service
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        //? kalau button dipencet, maka akan memanggul method bluetooth untuk mendiscover/memuat ulang seluruh service
                        onPressed: () => device.discoverServices(),
                      ),
                      //? kalau sedang melakukan discoverService maka tampilkan progressindicator
                      const IconButton(
                        icon: SizedBox(
                          width: 18.0,
                          height: 18.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.grey),
                          ),
                        ),
                        onPressed: null,
                      )
                    ],
                  ),
                ),
              ),
            ),
            //! Bluetooth : 6.4 MTU (Maximum Transfer Unit), jumlah byte yang bisa dikirim dalam satu operasi (Tidak Begitu Penting)
            StreamBuilder<int>(
              stream: device.mtu,
              initialData: 0,
              builder: (c, snapshot) => ListTile(
                title: const Text('MTU Size'),
                subtitle: Text('${snapshot.data} bytes'),
                //? icon edit untuk melakukan request perubahan nilai MTU
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => device.requestMtu(223),
                ),
              ),
            ),
            //! Bluetooth : 6.5 tampilkan service, akan ditampilkan ketika sudah melakukan discoverService ketika menekan tombol refresh
            StreamBuilder<List<BluetoothService>>(
              stream: device.services,
              initialData: const [],
              builder: (c, snapshot) {
                return Column(
                  children: _buildServiceTiles(snapshot.data!),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  //! Bluetooth : 6.3.1 melakukan stream nilai rssi (GABEGITU PENTING)
  Stream<int> rssiStream() async* {
    var isConnected = true;
    final subscription = device.state.listen((state) {
      isConnected = state == BluetoothDeviceState.connected;
    });
    while (isConnected) {
      yield await device.readRssi();
      await Future.delayed(const Duration(seconds: 1));
    }
    subscription.cancel();
    // Device disconnected, stopping RSSI stream
  }
}
