import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ExecutiveEnglishKSAApp());
}

class ExecutiveEnglishKSAApp extends StatelessWidget {
  const ExecutiveEnglishKSAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Executive English KSA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F0F14),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const ExecutiveWebView(),
    );
  }
}

class ExecutiveWebView extends StatefulWidget {
  const ExecutiveWebView({super.key});

  @override
  State<ExecutiveWebView> createState() => _ExecutiveWebViewState();
}

class _ExecutiveWebViewState extends State<ExecutiveWebView> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _hasError = false;

  static const String appUrl = 'https://masarsa.online/';

  @override
  void initState() {
    super.initState();

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final controller = WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFF7F5F0))
      ..enableZoom(false)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            setState(() {
              _isLoading = true;
              _hasError = false;
            });
          },
          onPageFinished: (_) {
            setState(() => _isLoading = false);
          },
          onWebResourceError: (error) {
            setState(() {
              _isLoading = false;
              _hasError = true;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(appUrl));

    _controller = controller;
  }

  Future<bool> _onWillPop() async {
    if (await _controller.canGoBack()) {
      await _controller.goBack();
      return false;
    }
    return true;
  }

  void _reload() {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    _controller.loadRequest(Uri.parse(appUrl));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F5F0),
        body: SafeArea(
          child: Stack(
            children: [
              WebViewWidget(controller: _controller),
              if (_isLoading)
                Container(
                  color: const Color(0xFFF7F5F0),
                  child: const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Executive English KSA',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0F0F14),
                            )),
                        SizedBox(height: 16),
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                ),
              if (_hasError)
                Container(
                  color: const Color(0xFFF7F5F0),
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.wifi_off_rounded, size: 48, color: Color(0xFF0F0F14)),
                        const SizedBox(height: 12),
                        const Text(
                          'تعذر فتح التطبيق',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'تأكد من الاتصال بالإنترنت ثم حاول مرة أخرى.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 18),
                        ElevatedButton(
                          onPressed: _reload,
                          child: const Text('إعادة المحاولة'),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
