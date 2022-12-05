import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:heart_oxygen_alarm/shared/theme.dart';

//! Bluetooth : 5.6 ScanResultTile merupakan class untuk menampilkan tile dari scan hasil result, yang akan menampilkan isi result dan tombol untuk connect ke device
class ScanResultTile extends StatelessWidget {
  const ScanResultTile({Key? key, required this.result, this.onTap})
      : super(key: key);

  final ScanResult result;
  final VoidCallback? onTap;

  //! Bluetooth : 5.6.1 _buildTitle dimasukkan ke paremeter 'title:' di widget tile yang ditampilin di halaman utama, berisi informasi tentang nama dan id
  Widget _buildTitle(BuildContext context) {
    if (result.device.name.isNotEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //?tampilkan nama device
          Text(
            result.device.name,
            overflow: TextOverflow.ellipsis,
          ),
          //? tampilkan id dari device
          Text(
            result.device.id.toString(),
            style: Theme.of(context).textTheme.caption,
          )
        ],
      );
      //? kalau nama device gaada tampilkan id aja
    } else {
      return Text(result.device.id.toString());
    }
  }

  //! Bluetooth : 5.6.2 _buildAdvRow ditampilin ketika expand, menampilkan nilai 'Complete Local Name','Manufacturer Data', dan 'Service Data'
  Widget _buildAdvRow(BuildContext context, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.caption),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.apply(color: Colors.black),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  //! Bluetooth : 5.6.3 method custom untuk mengubah dan menggabungkan beberapa nilai int menjadi bentuk heksadesimal kemudian menjadi string
  //? example hasil jadi = [10,05,31,18,B4,1E,C9]
  String getNiceHexArray(List<int> bytes) {
    return '[${bytes.map((i) => i.toRadixString(16).padLeft(2, '0')).join(', ')}]'
        .toUpperCase();
  }

  //! Bluetooth : 5.6.4 dimasukkan kedalam expand bagian Manufacturer Data, menampilkan nilai hex 5.6.3 yang digabungkan dengan nilai hex id (KEBANYAKAN NILAINYA NULL)
  //? example hasil jadi = 4C:[10,05,31,18,B4,1E,C9]
  //? kalau dilihat dari algoritmanya, kayanya bisa lebih dari 1 id
  //? inputan berupa nilai result.advertisementData.manufacturerData
  String getNiceManufacturerData(Map<int, List<int>> data) {
    if (data.isEmpty) {
      return 'N/A';
    }
    List<String> res = [];
    data.forEach((id, bytes) {
      res.add(
          '${id.toRadixString(16).toUpperCase()}: ${getNiceHexArray(bytes)}');
    });
    return res.join(', ');
  }

  //! Bluetooth : 5.6.5  dimasukkan kedalam expand bagian Service Data, menampilkan nilai hex 5.6.3 yang digabungkan dengan nilai hex id (KEBANYAKAN NILAINYA NULL)
  String getNiceServiceData(Map<String, List<int>> data) {
    if (data.isEmpty) {
      return 'N/A';
    }
    List<String> res = [];
    data.forEach((id, bytes) {
      res.add('${id.toUpperCase()}: ${getNiceHexArray(bytes)}');
    });
    return res.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    //! Bluetooth : 5.6.6 panggil seluruh method diatas ke dalam ExpansionTile
    //? expansion tile, tile yang bisa melebar kebawah kalau dipencet
    return ExpansionTile(
      title: _buildTitle(context), //? isi utamanya nama dan id, memanggil 5.6.1
      leading: Text(
        result.rssi.toString(),
      ), //? kekuatan sinyal bluetooth (rssi : Received Signal Strength Indicator)
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: cPurpleDarkColor,
          shape: const StadiumBorder(),
        ),
        //? button connect, jika device bersifat connectable maka akan memanggil voidcallback dari main.dart, jika tidak maka button akan disable dan menjadi warna abu-abu
        onPressed: (result.advertisementData.connectable) ? onTap : null,
        child: const Text('CONNECT'),
      ),
      //? kalau tile diexpands muncul
      children: <Widget>[
        _buildAdvRow(
            context,
            'Complete Local Name',
            result.advertisementData
                .localName), //? result.advertisementData.localName kebanyakan null
        _buildAdvRow(context, 'Tx Power Level',
            '${result.advertisementData.txPowerLevel ?? 'N/A'}'), //? txPowerLever kebanyakan null
        _buildAdvRow(
            context,
            'Manufacturer Data',
            getNiceManufacturerData(result.advertisementData
                .manufacturerData)), //? kadang ada, kadang null, nilainya tidak begitu kepake
        _buildAdvRow(
            context,
            'Service UUIDs',
            (result.advertisementData.serviceUuids.isNotEmpty)
                ? result.advertisementData.serviceUuids.join(', ').toUpperCase()
                : 'N/A'), //? kadang null, kadang ada
        _buildAdvRow(
            context,
            'Service Data',
            getNiceServiceData(
                result.advertisementData.serviceData)), //? kebanyakan null
      ],
    );
  }
}

//! ============================================================================================================

//! Bluetooth : 7.5.1 ServiceTile untuk menampilkan tile setiap list dari service yang ada di device
class ServiceTile extends StatelessWidget {
  final BluetoothService service;
  //? characteristicTiles untuk untuk menyimpan hasil map dari services.characteristic
  final List<CharacteristicTile> characteristicTiles;

  const ServiceTile({
    Key? key,
    required this.service,
    required this.characteristicTiles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (characteristicTiles.isNotEmpty) {
      //? tampilkan nilai Service, dan expan nilai characteristic dari service ini
      return ExpansionTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Service'),
            Text('0x${service.uuid.toString().toUpperCase().substring(4, 8)}',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: Theme.of(context).textTheme.caption?.color))
          ],
        ),
        children: characteristicTiles,
      );
    } else {
      //? kalau characteristicTile kosong, tampilkan Services id saja
      return ListTile(
        title: const Text('Service'),
        subtitle:
            Text('0x${service.uuid.toString().toUpperCase().substring(4, 8)}'),
      );
    }
  }
}

//! ============================================================================================================

//! Bluetooth : 7.4.1
class CharacteristicTile extends StatelessWidget {
  final BluetoothCharacteristic characteristic;
  final List<DescriptorTile> descriptorTiles;
  final VoidCallback? onReadPressed;
  final VoidCallback? onWritePressed;
  final VoidCallback? onNotificationPressed;

  const CharacteristicTile(
      {Key? key,
      required this.characteristic,
      required this.descriptorTiles,
      this.onReadPressed,
      this.onWritePressed,
      this.onNotificationPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<int>>(
      stream: characteristic.value,
      initialData: characteristic.lastValue,
      builder: (c, snapshot) {
        final value = snapshot.data;
        return ExpansionTile(
          title: ListTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Characteristic'),
                Text(
                    '0x${characteristic.uuid.toString().toUpperCase().substring(4, 8)}',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: Theme.of(context).textTheme.caption?.color))
              ],
            ),
            subtitle: Text(value.toString()),
            contentPadding: const EdgeInsets.all(0.0),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.file_download,
                  color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
                ),
                onPressed: onReadPressed,
              ),
              IconButton(
                icon: Icon(Icons.file_upload,
                    color: Theme.of(context).iconTheme.color?.withOpacity(0.5)),
                onPressed: onWritePressed,
              ),
              IconButton(
                icon: Icon(
                    characteristic.isNotifying
                        ? Icons.sync_disabled
                        : Icons.sync,
                    color: Theme.of(context).iconTheme.color?.withOpacity(0.5)),
                onPressed: onNotificationPressed,
              )
            ],
          ),
          children: descriptorTiles,
        );
      },
    );
  }
}

//! Bluetooth : 7.3.1 menampilkan Descriptor untuk mengirim/membaca perintah spesifik pada characteristic
class DescriptorTile extends StatelessWidget {
  //? nilai descriptor, kalau read mau ngapain, kalau write mau ngapain
  final BluetoothDescriptor descriptor;
  final VoidCallback? onReadPressed;
  final VoidCallback? onWritePressed;

  const DescriptorTile(
      {Key? key,
      required this.descriptor,
      this.onReadPressed,
      this.onWritePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('0x${descriptor.uuid.toString().toUpperCase().substring(4, 8)} = ${descriptor.uuid.toString().toUpperCase()}');
    return ListTile(
      //? title buat nampilin text Descriptor dan nilai id dari descriptor itu
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Descriptor'),
          //? bentuk asli 00002902-0000-1000-8000-00805F9B34FB
          //? yang ditampilkan setelah proses substring 0x2902
          Text('0x${descriptor.uuid.toString().toUpperCase().substring(4, 8)}',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: Theme.of(context).textTheme.caption?.color))
        ],
      ),
      //? menampilkan nilai value hasil read ketika proses descriptor.read() yang dipanggil di main.dart
      subtitle: StreamBuilder<List<int>>(
        stream: descriptor.value,
        initialData: descriptor.lastValue,
        builder: (c, snapshot) => Text(snapshot.data.toString()),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //? read dan write berdasarkan perintah dariCharacteristicTile yang dipanggil di main.dart
          IconButton(
            icon: Icon(
              Icons.file_download,
              color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
            ),
            onPressed: onReadPressed,
          ),
          IconButton(
            icon: Icon(
              Icons.file_upload,
              color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
            ),
            onPressed: onWritePressed,
          )
        ],
      ),
    );
  }
}

//! gatau fungsinya apa gadipanggil dimana2
class AdapterStateTile extends StatelessWidget {
  const AdapterStateTile({Key? key, required this.state}) : super(key: key);

  final BluetoothState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      child: ListTile(
        title: Text(
          'Bluetooth adapter is ${state.toString().substring(15)}',
          style: Theme.of(context).primaryTextTheme.subtitle2,
        ),
        trailing: Icon(
          Icons.error,
          color: Theme.of(context).primaryTextTheme.subtitle2?.color,
        ),
      ),
    );
  }
}
