import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class BarCodeScannerWidget extends StatefulWidget {
  const BarCodeScannerWidget({Key key}) : super(key: key);

  @override
  _BarCodeScannerWidgetState createState() => _BarCodeScannerWidgetState();
}

class _BarCodeScannerWidgetState extends State<BarCodeScannerWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var qrValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF7366E9),
        automaticallyImplyLeading: false,
        title: Text(
          'DEMO SCAN',
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Source Sans Pro',
                color: Colors.white,
                fontSize: 22,
              ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [],
              ),
              Icon(
                Icons.qr_code_scanner,
                color: Colors.black,
                size: 200,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                child: Text(
                  valueOrDefault<String>(
                    qrValue,
                    'Not Scanned Yet',
                  ),
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Source Sans Pro',
                        fontSize: 18,
                      ),
                ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  qrValue = await FlutterBarcodeScanner.scanBarcode(
                    '#C62828', // scanning line color
                    'Cancel', // cancel button text
                    true, // whether to show the flash icon
                    ScanMode.BARCODE,
                  );

                  setState(() {});
                },
                text: 'SCAN PASS',
                options: FFButtonOptions(
                  width: 175,
                  height: 55,
                  color: FlutterFlowTheme.of(context).primaryColor,
                  textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                        fontFamily: 'Source Sans Pro',
                        color: Colors.white,
                        fontSize: 20,
                      ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
