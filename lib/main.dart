import 'package:flutter/material.dart';

void main() {
  runApp(const AkatPanelApp());
}

class AkatPanelApp extends StatelessWidget {
  const AkatPanelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AKAT PANEL',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF00E676),
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00E676),
          secondary: Color(0xFF00BCD4),
          surface: Color(0xFF1A1A2E),
          onPrimary: Color(0xFF0A0A0A),
        ),
        fontFamily: 'Roboto',
        cardTheme: CardThemeData(
          color: const Color(0xFF1A1A2E),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
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

  final List<Widget> _pages = const [
    DashboardPage(),
    SocialMediaPage(),
    AquariumPage(),
    MediaPage(),
    AIAssistantPage(),
    CameraPage(),
    SettingsPage(),
  ];

  final List<IconData> _icons = const [
    Icons.dashboard_rounded,
    Icons.share_rounded,
    Icons.water_drop_rounded,
    Icons.play_circle_rounded,
    Icons.smart_toy_rounded,
    Icons.videocam_rounded,
    Icons.settings_rounded,
  ];

  final List<String> _labels = const [
    'Dashboard',
    'Sosyal Medya',
    'Akvaryum',
    'Medya',
    'AI Asistan',
    'Kamera',
    'Ayarlar',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 80,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(2, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00E676), Color(0xFF00BCD4)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00E676).withOpacity(0.3),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text('A', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF0A0A0A))),
                  ),
                ),
                const SizedBox(height: 8),
                const Text('AKAT', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF00E676), letterSpacing: 3)),
                const SizedBox(height: 30),
                Expanded(
                  child: ListView.builder(
                    itemCount: _icons.length,
                    itemBuilder: (context, index) {
                      final isSelected = _selectedIndex == index;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF00E676).withOpacity(0.15) : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: isSelected ? Border.all(color: const Color(0xFF00E676).withOpacity(0.3)) : null,
                          ),
                          child: IconButton(
                            icon: Icon(_icons[index], color: isSelected ? const Color(0xFF00E676) : Colors.white54, size: 26),
                            tooltip: _labels[index],
                            onPressed: () => setState(() => _selectedIndex = index),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF00E676), shape: BoxShape.circle)),
                      const SizedBox(height: 4),
                      const Text('v1.0', style: TextStyle(fontSize: 8, color: Colors.white30)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A2E),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 2))],
                  ),
                  child: Row(
                    children: [
                      Text(_labels[_selectedIndex], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00E676).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFF00E676).withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF00E676), shape: BoxShape.circle)),
                            const SizedBox(width: 8),
                            const Text('AKTIF', style: TextStyle(fontSize: 11, color: Color(0xFF00E676), fontWeight: FontWeight.bold, letterSpacing: 1)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      const CircleAvatar(radius: 18, backgroundColor: Color(0xFF00BCD4), child: Text('A', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                      const SizedBox(width: 8),
                      const Text('ALİ EMRE AKAT', style: TextStyle(fontSize: 13, color: Colors.white70, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                Expanded(
                  child: AnimatedSwitcher(duration: const Duration(milliseconds: 300), child: _pages[_selectedIndex]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [const Color(0xFF00E676).withOpacity(0.15), const Color(0xFF00BCD4).withOpacity(0.1)]),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF00E676).withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Hoş geldin, Ali Emre', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: 8),
                        Text('Tüm sistemler aktif ve çalışıyor', style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.7))),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: const Color(0xFF00E676).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.check_circle_rounded, color: Color(0xFF00E676), size: 40),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.5,
              children: [
                _statCard('CPU Sıcaklık', '64.2°C', Icons.thermostat_rounded, const Color(0xFFFF6B6B), 0.64),
                _statCard('RAM Kullanım', '3.9/8.0 GB', Icons.memory_rounded, const Color(0xFF4ECDC4), 0.49),
                _statCard('Disk Kullanım', '18/117 GB', Icons.storage_rounded, const Color(0xFF45B7D1), 0.15),
                _statCard('Aktif Servis', '17 servis', Icons.dns_rounded, const Color(0xFF96CEB4), 0.85),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Servis Durumları', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 3,
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
            const SizedBox(height: 24),
            Center(child: Text('AKAT PANEL v1.0 • ALİ EMRE AKAT • ${DateTime.now().year}', style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.3)))),
          ],
        ),
      ),
    );
  }

  static Widget _statCard(String title, String value, IconData icon, Color color, double progress) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Expanded(child: Text(title, style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.6)))),
          ]),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(value: progress, backgroundColor: color.withOpacity(0.1), valueColor: AlwaysStoppedAnimation<Color>(color), minHeight: 4),
          ),
        ],
      ),
    );
  }

  static Widget _serviceCard(String name, bool isActive, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isActive ? const Color(0xFF00E676).withOpacity(0.2) : Colors.red.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: isActive ? const Color(0xFF00E676) : Colors.red, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(name, style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w500))),
          Container(
            width: 8, height: 8,
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF00E676) : Colors.red,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: (isActive ? const Color(0xFF00E676) : Colors.red).withOpacity(0.5), blurRadius: 6)],
            ),
          ),
        ],
      ),
    );
  }
}

class SocialMediaPage extends StatelessWidget {
  const SocialMediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              _platformCard('TikTok', Icons.music_note, Colors.white, 7),
              const SizedBox(width: 16),
              _platformCard('Instagram', Icons.camera_alt, const Color(0xFFE1306C), 2),
              const SizedBox(width: 16),
              _platformCard('Reddit', Icons.reddit, const Color(0xFFFF4500), 0),
            ]),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: const Color(0xFF1A1A2E), borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    const Icon(Icons.schedule, color: Color(0xFF00E676)),
                    const SizedBox(width: 8),
                    const Text('Yaklaşan Yüklemeler', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: const Color(0xFF00E676).withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                      child: const Text('122 video zamanlandı', style: TextStyle(fontSize: 12, color: Color(0xFF00E676))),
                    ),
                  ]),
                  const SizedBox(height: 16),
                  _scheduleRow('TikTok', 'Corydoras Yavruları', '21 Ağu 11:00', true),
                  _scheduleRow('Instagram', 'İskelet Uçabilir...', '21 Ağu 14:00', false),
                  _scheduleRow('TikTok', 'Hava Motoruna İskelet', '21 Ağu 20:00', false),
                  _scheduleRow('Instagram', 'Sinek Larvası Topladım', '22 Ağu 14:00', false),
                  _scheduleRow('TikTok', 'Elma Salyangozları', '22 Ağu 20:00', false),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(children: [
              _statBox('Toplam Yükleme', '9', Icons.cloud_upload_rounded),
              const SizedBox(width: 16),
              _statBox('Bekleyen', '122', Icons.hourglass_empty_rounded),
              const SizedBox(width: 16),
              _statBox('Bu Ay', '2', Icons.calendar_today_rounded),
            ]),
          ],
        ),
      ),
    );
  }

  static Widget _platformCard(String name, IconData icon, Color color, int count) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [color.withOpacity(0.3), color.withOpacity(0.1)]),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 12),
            Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 4),
            Text('$count yüklendi', style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.6))),
          ],
        ),
      ),
    );
  }

  static Widget _scheduleRow(String platform, String title, String time, bool isNext) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isNext ? const Color(0xFF00E676).withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: isNext ? Border.all(color: const Color(0xFF00E676).withOpacity(0.3)) : null,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: platform == 'TikTok' ? Colors.white.withOpacity(0.1) : const Color(0xFFE1306C).withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(platform, style: TextStyle(fontSize: 11, color: platform == 'TikTok' ? Colors.white : const Color(0xFFE1306C), fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 13, color: Colors.white), overflow: TextOverflow.ellipsis)),
          Text(time, style: TextStyle(fontSize: 12, color: isNext ? const Color(0xFF00E676) : Colors.white54)),
          if (isNext) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: const Color(0xFF00E676), borderRadius: BorderRadius.circular(4)),
              child: const Text('SIRADA', style: TextStyle(fontSize: 9, color: Color(0xFF0A0A0A), fontWeight: FontWeight.bold)),
            ),
          ],
        ],
      ),
    );
  }

  static Widget _statBox(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: const Color(0xFF1A1A2E), borderRadius: BorderRadius.circular(12)),
        child: Column(children: [
          Icon(icon, color: const Color(0xFF00BCD4), size: 24),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          Text(label, style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.5))),
        ]),
      ),
    );
  }
}

class AquariumPage extends StatelessWidget {
  const AquariumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [const Color(0xFF00BCD4).withOpacity(0.2), const Color(0xFF00E676).withOpacity(0.1)]),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF00BCD4).withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(color: const Color(0xFF00BCD4).withOpacity(0.2), shape: BoxShape.circle),
                    child: const Icon(Icons.thermostat_rounded, color: Color(0xFF00BCD4), size: 48),
                  ),
                  const SizedBox(width: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Su Sıcaklığı', style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.6))),
                      const Text('26.5°C', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white)),
                      const Text('Optimal aralık: 24-28°C', style: TextStyle(fontSize: 12, color: Color(0xFF00E676))),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(children: [
              _infoCard('Son Yemleme', 'Bugün 09:30', Icons.restaurant_rounded, const Color(0xFFFF6B6B)),
              const SizedBox(width: 16),
              _infoCard('Sonraki Yemleme', 'Yarın 09:30', Icons.schedule_rounded, const Color(0xFF4ECDC4)),
              const SizedBox(width: 16),
              _infoCard('Yem Stok', '%65 dolu', Icons.inventory_2_rounded, const Color(0xFF96CEB4)),
            ]),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: const Color(0xFF1A1A2E), borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Akvaryum Sakinleri', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 16),
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
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2E),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          Text(title, style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.5))),
        ]),
      ),
    );
  }

  static Widget _fishRow(String name, String count, String emoji) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Expanded(child: Text(name, style: const TextStyle(fontSize: 14, color: Colors.white))),
          Text(count, style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.6))),
        ],
      ),
    );
  }
}

class MediaPage extends StatelessWidget {
  const MediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [const Color(0xFF9C27B0).withOpacity(0.2), const Color(0xFF673AB7).withOpacity(0.1)]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.play_circle_rounded, color: Color(0xFF9C27B0), size: 48),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Jellyfin Medya Sunucusu', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                      Text('Aktif • 4.5 GB medya • Son izlenen: Cry Babies', style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.6))),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(children: [
              _mediaStat('Film', '308 GB', Icons.movie_rounded),
              const SizedBox(width: 16),
              _mediaStat('Müzik', '2 GB', Icons.music_note_rounded),
              const SizedBox(width: 16),
              _mediaStat('Çocuk', '4.5 GB', Icons.child_care_rounded),
            ]),
          ],
        ),
      ),
    );
  }

  static Widget _mediaStat(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: const Color(0xFF1A1A2E), borderRadius: BorderRadius.circular(12)),
        child: Column(children: [
          Icon(icon, color: const Color(0xFF9C27B0), size: 28),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.5))),
        ]),
      ),
    );
  }
}

class AIAssistantPage extends StatelessWidget {
  const AIAssistantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              _aiCard('Gemini 2.5 Flash', 'Ana Model', const Color(0xFF4285F4)),
              const SizedBox(width: 16),
              _aiCard('NVIDIA NIM 550B', 'Yedek Model', const Color(0xFF76B900)),
              const SizedBox(width: 16),
              _aiCard('99 Model', 'NVIDIA Kütüphane', const Color(0xFFFF6B6B)),
            ]),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: const Color(0xFF1A1A2E), borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Model Kategorileri', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 16),
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
          ],
        ),
      ),
    );
  }

  static Widget _aiCard(String name, String desc, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [color.withOpacity(0.2), color.withOpacity(0.05)]),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(Icons.smart_toy_rounded, color: color, size: 28),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFF00E676).withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                child: const Text('AKTIF', style: TextStyle(fontSize: 10, color: Color(0xFF00E676), fontWeight: FontWeight.bold)),
              ),
            ]),
            const SizedBox(height: 12),
            Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            Text(desc, style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.5))),
          ],
        ),
      ),
    );
  }

  static Widget _modelCat(String name, String count, String size, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(width: 4, height: 24, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
          const SizedBox(width: 12),
          Expanded(child: Text(name, style: const TextStyle(fontSize: 14, color: Colors.white))),
          Text(count, style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.5))),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
            child: Text(size, style: TextStyle(fontSize: 11, color: color)),
          ),
        ],
      ),
    );
  }
}

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(color: const Color(0xFF1A1A2E), borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.videocam_off_rounded, color: Colors.white.withOpacity(0.3), size: 64),
              const SizedBox(height: 16),
              const Text('Kamera Henüz Bağlanmadı', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 8),
              Text('TP-Link Tapo C310 kurulumu bekleniyor', style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.5))),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF00E676).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF00E676).withOpacity(0.3)),
                ),
                child: const Text('Frigate entegrasyonu hazır', style: TextStyle(fontSize: 12, color: Color(0xFF00E676))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _section('Genel', [
              _item('Uygulama Adı', 'AKAT PANEL v1.0'),
              _item('Geliştirici', 'ALİ EMRE AKAT'),
              _item('Platform', 'Flutter 3.47.2'),
              _item('Cihaz', 'Raspberry Pi 5'),
            ]),
            const SizedBox(height: 16),
            _section('Servisler', [
              _item('Raspberry Pi', '192.168.1.3'),
              _item('Tailscale', '100.69.223.25'),
              _item('Jellyfin', 'port 8096'),
              _item('Dashboard', 'port 5000'),
              _item('noVNC', 'port 6080'),
            ]),
            const SizedBox(height: 16),
            _section('AI Modelleri', [
              _item('Ana Model', 'Gemini 2.5 Flash'),
              _item('Yedek Model', 'NVIDIA NIM 550B'),
              _item('NVIDIA Modelleri', '99 aktif'),
            ]),
            const SizedBox(height: 24),
            Center(
              child: Text(
                '© ${DateTime.now().year} ALİ EMRE AKAT\nTüm hakları saklıdır.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.3)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _section(String title, List<Widget> items) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFF1A1A2E), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF00E676))),
          const SizedBox(height: 12),
          ...items,
        ],
      ),
    );
  }

  static Widget _item(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.7))),
          Text(value, style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
