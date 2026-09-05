import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'services/api_service.dart';
import 'services/update_service.dart';
import 'widgets/update_dialog.dart';
import 'providers/dashboard_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize update service
  final updateService = UpdateService();
  updateService.initialize();

  // Initialize API service
  final apiService = ApiService();
  apiService.loadTokens();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        Provider<ApiService>.value(value: apiService),
      ],
      child: const AkatPanelApp(),
    ),
  );
}

class AkatPanelApp extends StatelessWidget {
  const AkatPanelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AKAT PANEL',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00E676),
          secondary: Color(0xFF00BCD4),
          tertiary: Color(0xFF9C27B0),
          surface: Color(0xFF1A1A2E),
          surfaceVariant: Color(0xFF16213E),
          onPrimary: Color(0xFF0A0A0A),
          onSecondary: Color(0xFF0A0A0A),
          onSurface: Colors.white,
          onSurfaceVariant: Colors.white70,
          outline: Color(0xFF00E676),
          outlineVariant: Color(0xFF00E676),
          shadow: Colors.black,
          inverseSurface: Colors.white,
          onInverseSurface: Color(0xFF0A0A0A),
          inversePrimary: Color(0xFF00C853),
        ),
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF1A1A2E),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF1A1A2E),
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: const Color(0xFF00E676).withOpacity(0.2)),
          ),
          margin: const EdgeInsets.all(12),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00E676),
            foregroundColor: const Color(0xFF0A0A0A),
            elevation: 2,
            shadowColor: const Color(0xFF00E676).withOpacity(0.4),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            minimumSize: const Size(double.infinity, 52),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF00E676),
            side: const BorderSide(color: Color(0xFF00E676), width: 1.5),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            minimumSize: const Size(double.infinity, 52),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF00E676),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1A1A2E),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: const Color(0xFF00E676).withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF00E676), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
          floatingLabelStyle: const TextStyle(color: Color(0xFF00E676)),
          prefixIconColor: Colors.white54,
          suffixIconColor: Colors.white54,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: const Color(0xFF1A1A2E),
          selectedItemColor: const Color(0xFF00E676),
          unselectedItemColor: Colors.white54,
          selectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          type: BottomNavigationBarType.fixed,
          elevation: 8,
          showSelectedLabels: true,
          showUnselectedLabels: true,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: const Color(0xFF1A1A2E),
          indicatorColor: const Color(0xFF00E676).withOpacity(0.15),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF00E676),
              );
            }
            return TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.6),
            );
          }),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: Color(0xFF00E676), size: 24);
            }
            return IconThemeData(color: Colors.white.withOpacity(0.6), size: 24);
          }),
          height: 72,
        ),
        chipTheme: ChipThemeData(
          backgroundColor: const Color(0xFF00E676).withOpacity(0.1),
          selectedColor: const Color(0xFF00E676),
          labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
          secondaryLabelStyle: const TextStyle(color: Color(0xFF0A0A0A), fontSize: 12),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          side: BorderSide(color: const Color(0xFF00E676).withOpacity(0.3)),
        ),
        dividerTheme: DividerThemeData(
          color: Colors.white.withOpacity(0.1),
          thickness: 1,
          space: 1,
        ),
        listTileTheme: ListTileThemeData(
          tileColor: Colors.transparent,
          selectedTileColor: const Color(0xFF00E676).withOpacity(0.1),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          iconColor: Colors.white70,
          textColor: Colors.white,
          titleTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
          subtitleTextStyle: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.6)),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color(0xFF00E676),
          linearTrackColor: Color(0xFF1A1A2E),
          circularTrackColor: Color(0xFF1A1A2E),
        ),
        sliderTheme: SliderThemeData(
          activeTrackColor: const Color(0xFF00E676),
          inactiveTrackColor: const Color(0xFF00E676).withOpacity(0.2),
          thumbColor: const Color(0xFF00E676),
          overlayColor: const Color(0xFF00E676).withOpacity(0.2),
          valueIndicatorColor: const Color(0xFF00E676),
          valueIndicatorTextStyle: const TextStyle(color: Colors.white),
        ),
        tabBarTheme: TabBarThemeData(
          labelColor: const Color(0xFF00E676),
          unselectedLabelColor: Colors.white54,
          indicatorColor: const Color(0xFF00E676),
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: -0.5),
          displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: -0.25),
          displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
          headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
          headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
          headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
          titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
          titleMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
          titleSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white70),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.white70),
          bodySmall: TextStyle(fontSize: 12, color: Colors.white54),
          labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF0A0A0A)),
          labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF0A0A0A)),
          labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.white54),
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final UpdateService _updateService = UpdateService();

  @override
  void initState() {
    super.initState();
    _checkForUpdates();
  }

  Future<void> _checkForUpdates() async {
    final updateInfo = await _updateService.checkForUpdate();
    if (mounted && updateInfo != null) {
      _showUpdateDialog(updateInfo);
    }
  }

  void _showUpdateDialog(UpdateInfo info) {
    showDialog(
      context: context,
      barrierDismissible: info.mandatory ? false : true,
      builder: (context) => UpdateDialog(
        updateInfo: info,
        onSkip: () => _updateService.skipVersion(info.version),
        onUpdate: () => _downloadAndInstall(info),
      ),
    );
  }

  Future<void> _downloadAndInstall(UpdateInfo info) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => DownloadProgressDialog(version: info.version),
    );

    try {
      await _updateService.downloadAndInstall(info);
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Güncelleme indirildi! Bildirimden kurun.'),
            backgroundColor: Color(0xFF00E676),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Güncelleme hatası: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = <Widget>[
      DashboardPage(),
      SocialMediaPage(),
      AquariumPage(),
      MediaPage(),
      AIAssistantPage(),
      CameraPage(),
      SettingsPage(),
    ];

    final List<NavigationDestination> destinations = <NavigationDestination>[
      NavigationDestination(
        icon: Icon(Icons.dashboard_rounded),
        selectedIcon: Icon(Icons.dashboard_rounded, color: Color(0xFF00E676)),
        label: 'Dashboard',
      ),
      NavigationDestination(
        icon: Icon(Icons.share_rounded),
        selectedIcon: Icon(Icons.share_rounded, color: Color(0xFF00E676)),
        label: 'Sosyal Medya',
      ),
      NavigationDestination(
        icon: Icon(Icons.water_drop_rounded),
        selectedIcon: Icon(Icons.water_drop_rounded, color: Color(0xFF00E676)),
        label: 'Akvaryum',
      ),
      NavigationDestination(
        icon: Icon(Icons.play_circle_rounded),
        selectedIcon: Icon(Icons.play_circle_rounded, color: Color(0xFF00E676)),
        label: 'Medya',
      ),
      NavigationDestination(
        icon: Icon(Icons.smart_toy_rounded),
        selectedIcon: Icon(Icons.smart_toy_rounded, color: Color(0xFF00E676)),
        label: 'AI Asistan',
      ),
      NavigationDestination(
        icon: Icon(Icons.videocam_rounded),
        selectedIcon: Icon(Icons.videocam_rounded, color: Color(0xFF00E676)),
        label: 'Kamera',
      ),
      NavigationDestination(
        icon: Icon(Icons.settings_rounded),
        selectedIcon: Icon(Icons.settings_rounded, color: Color(0xFF00E676)),
        label: 'Ayarlar',
      ),
    ];

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: pages[_selectedIndex],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        destinations: destinations,
      ),
    );
  }
}
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double childAspectRatio;
  final double spacing;
  final int minCrossAxisCount;
  final int maxCrossAxisCount;
  final double minItemWidth;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.childAspectRatio = 1.5,
    this.spacing = 12,
    this.minCrossAxisCount = 1,
    this.maxCrossAxisCount = 4,
    this.minItemWidth = 160,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = (constraints.maxWidth / minItemWidth).floor().clamp(minCrossAxisCount, maxCrossAxisCount);
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: spacing,
          crossAxisSpacing: spacing,
          childAspectRatio: childAspectRatio,
          children: children,
        );
      },
    );
  }
}

/// Reusable stat card for mobile
class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final double? progress;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.6)),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
            if (progress != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress!,
                  backgroundColor: color.withOpacity(0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  minHeight: 4,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Reusable info card for mobile
class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const InfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.5)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Section header widget
class SectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const SectionHeader({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          if (trailing != null) ...[
            const Spacer(),
            trailing!,
          ],
        ],
      ),
    );
  }
}

/// Dashboard Page - Mobile Optimized
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AKAT PANEL'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {},
            tooltip: 'Yenile',
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert_rounded),
            onSelected: (value) {},
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'settings', child: Text('Ayarlar')),
              const PopupMenuItem(value: 'about', child: Text('Hakkında')),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card
            Card(
              margin: const EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF00E676).withOpacity(0.15),
                      const Color(0xFF00BCD4).withOpacity(0.1),
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hoş geldin, Ali Emre',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Tüm sistemler aktif ve çalışıyor',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00E676).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.check_circle_rounded,
                        color: Color(0xFF00E676),
                        size: 36,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Stats Grid - Responsive
            const SectionHeader(title: 'Sistem Durumu'),
            ResponsiveGrid(
              minItemWidth: 160,
              maxCrossAxisCount: 2,
              childAspectRatio: 1.6,
              children: [
                StatCard(
                  title: 'CPU Sıcaklık',
                  value: '64.2°C',
                  icon: Icons.thermostat_rounded,
                  color: const Color(0xFFFF6B6B),
                  progress: 0.64,
                ),
                StatCard(
                  title: 'RAM Kullanım',
                  value: '3.9/8.0 GB',
                  icon: Icons.memory_rounded,
                  color: const Color(0xFF4ECDC4),
                  progress: 0.49,
                ),
                StatCard(
                  title: 'Disk Kullanım',
                  value: '18/117 GB',
                  icon: Icons.storage_rounded,
                  color: const Color(0xFF45B7D1),
                  progress: 0.15,
                ),
                StatCard(
                  title: 'Aktif Servis',
                  value: '17 servis',
                  icon: Icons.dns_rounded,
                  color: const Color(0xFF96CEB4),
                  progress: 0.85,
                ),
              ],
            ),

            // Services Grid
            const SectionHeader(title: 'Servisler'),
            ResponsiveGrid(
              minItemWidth: 150,
              maxCrossAxisCount: 3,
              childAspectRatio: 2.5,
              children: [
                _serviceCard('Docker', true, Icons.local_shipping_rounded),
                _serviceCard('Jellyfin', true, Icons.play_circle_rounded),
                _serviceCard('Home Assistant', true, Icons.home_rounded),
                _serviceCard('Social Bot', true, Icons.share_rounded),
                _serviceCard('Pi-hole', true, Icons.block_rounded),
                _serviceCard('WireGuard', true, Icons.vpn_key_rounded),
                _serviceCard('Immich', true, Icons.photo_library_rounded),
                _serviceCard('Photoprism', true, Icons.camera_alt_rounded),
                _serviceCard('Uptime Kuma', true, Icons.monitor_heart_rounded),
              ],
            ),

            // Footer
            Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text(
                  'AKAT PANEL v1.0 • ALİ EMRE AKAT • ${DateTime.now().year}',
                  style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.3)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _serviceCard(String name, bool isActive, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Row(
          children: [
            Icon(
              icon,
              color: isActive ? const Color(0xFF00E676) : Colors.red,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF00E676) : Colors.red,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: (isActive ? const Color(0xFF00E676) : Colors.red).withOpacity(0.5),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Social Media Page - Mobile Optimized
class SocialMediaPage extends StatelessWidget {
  const SocialMediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sosyal Medya'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: () {},
            tooltip: 'Yeni Gönderi',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Platform Cards
            const SectionHeader(title: 'Platformlar'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ResponsiveGrid(
                minItemWidth: 150,
                maxCrossAxisCount: 3,
                childAspectRatio: 1.2,
                children: [
                  _platformCard('TikTok', Icons.music_note, Colors.white, 7),
                  _platformCard('Instagram', Icons.camera_alt, const Color(0xFFE1306C), 2),
                  _platformCard('Reddit', Icons.reddit, const Color(0xFFFF4500), 0),
                ],
              ),
            ),

            // Upcoming Uploads
            const SectionHeader(title: 'Yaklaşan Yüklemeler'),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _scheduleRow('TikTok', 'Corydoras Yavruları', '21 Ağu 11:00', true),
                  _scheduleRow('Instagram', 'İskelet Uçabilir...', '21 Ağu 14:00', false),
                  _scheduleRow('TikTok', 'Hava Motoruna İskelet', '21 Ağu 20:00', false),
                  _scheduleRow('Instagram', 'Sinek Larvası Topladım', '22 Ağu 14:00', false),
                  _scheduleRow('TikTok', 'Elma Salyangozları', '22 Ağu 20:00', false),
                ],
              ),
            ),

            // Stats
            const SectionHeader(title: 'İstatistikler'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _statBox('Toplam Yükleme', '9', Icons.cloud_upload_rounded),
                  _statBox('Bekleyen', '122', Icons.hourglass_empty_rounded),
                  _statBox('Bu Ay', '2', Icons.calendar_today_rounded),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _platformCard(String name, IconData icon, Color color, int count) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.3), color.withOpacity(0.1)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 12),
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$count yüklendi',
              style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.6)),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _scheduleRow(String platform, String title, String time, bool isNext) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isNext ? const Color(0xFF00E676).withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isNext ? Border.all(color: const Color(0xFF00E676).withOpacity(0.3)) : null,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: platform == 'TikTok'
                  ? Colors.white.withOpacity(0.1)
                  : const Color(0xFFE1306C).withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              platform,
              style: TextStyle(
                fontSize: 11,
                color: platform == 'TikTok' ? Colors.white : const Color(0xFFE1306C),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 13, color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(time, style: TextStyle(fontSize: 12, color: isNext ? const Color(0xFF00E676) : Colors.white54)),
          if (isNext) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFF00E676),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'SIRADA',
                style: TextStyle(fontSize: 9, color: Color(0xFF0A0A0A), fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ],
      ),
    );
  }

  static Widget _statBox(String label, String value, IconData icon) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, color: const Color(0xFF00BCD4), size: 24),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(
                label,
                style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.5)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Aquarium Page - Mobile Optimized
class AquariumPage extends StatelessWidget {
  const AquariumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Akvaryum'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: () {},
            tooltip: 'Yemleme Ekle',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Temperature Card
            Card(
              margin: const EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF00BCD4).withOpacity(0.2),
                      const Color(0xFF00E676).withOpacity(0.1),
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00BCD4).withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.thermostat_rounded,
                        color: Color(0xFF00BCD4),
                        size: 44,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Su Sıcaklığı',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                          const Text(
                            '26.5°C',
                            style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'Optimal aralık: 24-28°C',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF00E676),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Info Cards
            const SectionHeader(title: 'Yemleme Takibi'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _infoCard('Son Yemleme', 'Bugün 09:30', Icons.restaurant_rounded, const Color(0xFFFF6B6B)),
                  _infoCard('Sonraki', 'Yarın 09:30', Icons.schedule_rounded, const Color(0xFF4ECDC4)),
                  _infoCard('Yem Stok', '%65 dolu', Icons.inventory_2_rounded, const Color(0xFF96CEB4)),
                ],
              ),
            ),

            // Fish List
            const SectionHeader(title: 'Akvaryum Sakinleri'),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _fishRow('Lepistes (Guppy)', '12 adet', '🐟'),
                  _fishRow('Corydoras', '6 adet', '🐠'),
                  _fishRow('Neon Tetra', '8 adet', '✨'),
                  _fishRow('Vatoz (Bristlenose)', '2 adet', '🧹'),
                  _fishRow('Red Cherry Karides', '15 adet', '🦐'),
                  _fishRow('Elma Salyangozu', '4 adet', '🐌'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _infoCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.5)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _fishRow(String name, String count, String emoji) {
    return ListTile(
      leading: Text(emoji, style: const TextStyle(fontSize: 24)),
      title: Text(name, style: const TextStyle(fontSize: 14, color: Colors.white)),
      trailing: Text(
        count,
        style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.6)),
      ),
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }
}

/// Media Page - Mobile Optimized
class MediaPage extends StatelessWidget {
  const MediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medya'),
        actions: [
          IconButton(
            icon: const Icon(Icons.play_circle_rounded),
            onPressed: () {},
            tooltip: 'Jellyfin Aç',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Jellyfin Header
            Card(
              margin: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF9C27B0).withOpacity(0.2),
                      const Color(0xFF673AB7).withOpacity(0.1),
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.play_circle_rounded, color: Color(0xFF9C27B0), size: 44),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Jellyfin Medya Sunucusu',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Aktif • 4.5 GB medya • Son izlenen: Cry Babies',
                            style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.6)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Media Stats
            const SectionHeader(title: 'Depolama'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _mediaStat('Film', '308 GB', Icons.movie_rounded),
                  _mediaStat('Müzik', '2 GB', Icons.music_note_rounded),
                  _mediaStat('Çocuk', '4.5 GB', Icons.child_care_rounded),
                ],
              ),
            ),

            // Quick Actions
            const SectionHeader(title: 'Hızlı İşlemler'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.library_add_rounded, color: Color(0xFF9C27B0)),
                    title: const Text('Yeni Medya Ekle'),
                    subtitle: const Text('Jellyfin\'e dosya yükle'),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.sync_rounded, color: Color(0xFF00BCD4)),
                    title: const Text('Kütüphaneyi Tara'),
                    subtitle: const Text('Yeni dosyaları indeksle'),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.cleaning_services_rounded, color: Color(0xFFFF6B6B)),
                    title: const Text('İzlenenleri Temizle'),
                    subtitle: const Text('%90+ izlenenleri kaldır'),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _mediaStat(String label, String value, IconData icon) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, color: const Color(0xFF9C27B0), size: 28),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.5)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// AI Assistant Page - Mobile Optimized
class AIAssistantPage extends StatelessWidget {
  const AIAssistantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Asistan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat_rounded),
            onPressed: () {},
            tooltip: 'Yeni Sohbet',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Active Models
            const SectionHeader(title: 'Aktif Modeller'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ResponsiveGrid(
                minItemWidth: 160,
                maxCrossAxisCount: 3,
                childAspectRatio: 1.4,
                children: [
                  _aiCard('Gemini 2.5 Flash', 'Ana Model', const Color(0xFF4285F4)),
                  _aiCard('NVIDIA NIM 550B', 'Yedek Model', const Color(0xFF76B900)),
                  _aiCard('99 Model', 'NVIDIA Kütüphane', const Color(0xFFFF6B6B)),
                ],
              ),
            ),

            // Model Categories
            const SectionHeader(title: 'Model Kategorileri'),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _modelCat('Ultra Güçlü', '4 model', '253B-550B', const Color(0xFFFF6B6B)),
                  _modelCat('Güçlü', '6 model', '30B-70B', const Color(0xFFFF9800)),
                  _modelCat('Orta', '18 model', '70B-120B', const Color(0xFF4CAF50)),
                  _modelCat('Hızlı', '16 model', '1B-12B', const Color(0xFF00BCD4)),
                  _modelCat('Kod Yazma', '10 model', '6.7B-70B', const Color(0xFF9C27B0)),
                  _modelCat('Görsel', '15 model', '8B-90B', const Color(0xFFE91E63)),
                  _modelCat('Embedding', '14 model', '1B-7B', const Color(0xFF795548)),
                  _modelCat('Çeviri', '3 model', '4B', const Color(0xFF607D8B)),
                ],
              ),
            ),

            // Quick Actions
            const SectionHeader(title: 'Hızlı İşlemler'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.chat_rounded, color: Color(0xFF4285F4)),
                    title: const Text('Yeni Sohbet Başlat'),
                    subtitle: const Text('Gemini 2.5 Flash ile'),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.code_rounded, color: Color(0xFF9C27B0)),
                    title: const Text('Kod Yardımı Al'),
                    subtitle: const Text('NVIDIA NIM ile kod yaz'),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.translate_rounded, color: Color(0xFFE91E63)),
                    title: const Text('Çeviri Yap'),
                    subtitle: const Text('4B model ile hızlı çeviri'),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _aiCard(String name, String desc, Color color) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.2), color.withOpacity(0.05)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.smart_toy_rounded, color: color, size: 28),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00E676).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'AKTIF',
                    style: TextStyle(fontSize: 10, color: Color(0xFF00E676), fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            Text(desc, style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.5))),
          ],
        ),
      ),
    );
  }

  static Widget _modelCat(String name, String count, String size, Color color) {
    return ListTile(
      leading: Container(
        width: 5,
        height: 28,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2.5)),
      ),
      title: Text(name, style: const TextStyle(fontSize: 14, color: Colors.white)),
      subtitle: Text('$count model', style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.5))),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(size, style: TextStyle(fontSize: 11, color: color)),
      ),
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }
}

/// Camera Page - Mobile Optimized
class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kamera')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.videocam_off_rounded, color: Colors.white.withOpacity(0.3), size: 64),
                  const SizedBox(height: 20),
                  const Text(
                    'Kamera Henüz Bağlanmadı',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'TP-Link Tapo C310 kurulumu bekleniyor',
                    style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.5)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00E676).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFF00E676).withOpacity(0.3)),
                    ),
                    child: const Text(
                      'Frigate entegrasyonu hazır',
                      style: TextStyle(fontSize: 12, color: Color(0xFF00E676)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.settings_rounded),
                    label: const Text('Kamera Ayarları'),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Settings Page - Mobile Optimized
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ayarlar')),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          _section('Genel', [
            _item('Uygulama Adı', 'AKAT PANEL v1.0'),
            _item('Geliştirici', 'ALİ EMRE AKAT'),
            _item('Platform', 'Flutter 3.47.2'),
            _item('Cihaz', 'Raspberry Pi 5'),
            _item('Mimari', 'ARM64'),
          ]),
          _section('Ağ ve Servisler', [
            _item('Raspberry Pi LAN', '192.168.1.3'),
            _item('Tailscale VPN', '100.69.223.25'),
            _item('Jellyfin', 'http://192.168.1.3:8096'),
            _item('Home Assistant', 'http://192.168.1.3:8123'),
            _item('Pi-hole', 'http://192.168.1.3:8080'),
            _item('Uptime Kuma', 'http://192.168.1.3:3001'),
            _item('Portainer', 'http://192.168.1.3:9000'),
          ]),
          _section('Güvenlik', [
            _item('UFW Firewall', 'Aktif (Tailscale + LAN)'),
            _item('Fail2ban', 'Aktif (SSH Koruması)'),
            _item('SSH Port', '22 (Sadece Tailscale/LAN)'),
            _item('Jellyfin Port', '8096 (Sadece Tailscale/LAN)'),
          ]),
          _section('Depolama', [
            _item('Disk A (NVMe)', '117 GB / 25% dolu'),
            _item('Disk B (Medya)', '880 GB / %99 dolu'),
            _item('Disk C (Yedek)', '916 GB / %7 dolu'),
          ]),
          _section('Hakkında', [
            _item('Versiyon', '1.0.0'),
            _item('Build', DateTime.now().toString().split(' ')[0]),
            _item('Lisans', 'MIT'),
            _item('Geliştirici', 'ALİ EMRE AKAT'),
          ]),
          const SizedBox(height: 32),
          Center(
            child: Text(
              'AKAT PANEL v1.0\nTüm hakları saklıdır.',
              style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.3)),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  static Widget _section(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.5),
              letterSpacing: 0.5,
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(children: children),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  static Widget _item(String title, String subtitle, {VoidCallback? onTap}) {
      return ListTile(
        title: Text(title, style: const TextStyle(fontSize: 14, color: Colors.white)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.5))),
        trailing: onTap != null ? const Icon(Icons.chevron_right_rounded, color: Colors.white30) : null,
        onTap: onTap,
        dense: true,
        visualDensity: VisualDensity.compact,
      );
    }
  }