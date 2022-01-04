import 'package:esense_application/screens/ingame/screens/esense_screen.dart';
import 'package:esense_flutter/esense.dart';
import 'package:flutter/material.dart';

class ConnectionScreen extends StatefulWidget {
  const ConnectionScreen({ Key? key }) : super(key: key);

  @override
  _ConnectionScreenState createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  String _deviceStatus = '';
  bool connected = false;
  ConnectionType connectionType = ConnectionType.unknown;


  // the name of the eSense device to connect to -- change this to your own device.
  final String eSenseName = 'eSense-0864';

  @override
  void initState() {
    super.initState();
    _listenToESense();
    _connectToESense();
  }

  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }

  Future _listenToESense() async {
    // if you want to get the connection events when connecting,
    // set up the listener BEFORE connecting...
    ESenseManager().connectionEvents.listen((event) {

      setState(() {
        connected = false;
        connectionType = event.type;
        switch (event.type) {
          case ConnectionType.connected:
            _deviceStatus = 'connected';
            connected = true;
            break;
          case ConnectionType.unknown:
            _deviceStatus = 'unknown';
            _connectToESense();
            break;
          case ConnectionType.disconnected:
            _deviceStatus = 'disconnected';
            _connectToESense();
            break;
          case ConnectionType.device_found:
            _deviceStatus = 'device_found';
            break;
          case ConnectionType.device_not_found:
            _deviceStatus = 'device_not_found';
            _connectToESense();
            break;
        }
      });
    });
  }

  Future<void> _connectToESense() async {
    setState(() {
      _deviceStatus = 'connecting';
    });

    await ESenseManager().disconnect();
    await ESenseManager().connect(eSenseName);
  }

  @override
  void dispose() {
    ESenseManager().disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HEADACHE'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Connecting to eSense...',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20.0,
                ),
              ),
            ),
          
            (_deviceStatus == 'connected') ?
              FloatingActionButton(
                onPressed: () => Navigator.push(
                  context, 
                  MaterialPageRoute(builder:(context) => ESenseScreen(connection: connectionType)),
                ),
                child: const Icon(Icons.play_arrow_rounded),
              ): 
              const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
