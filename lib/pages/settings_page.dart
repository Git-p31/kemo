import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  const SettingsPage({
    super.key,
    required this.onThemeChanged,
    required this.isDarkMode,
  });

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  late bool _isDarkMode;
  late bool _notificationsEnabled;
  late bool _isFirebaseConnected;
  final String _appVersion = '1.0.0';

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
    _notificationsEnabled = false; // Изначально уведомления выключены
    _isFirebaseConnected = true; // Для примера считаем, что Firebase подключен
  }

  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
    widget.onThemeChanged(value);
  }

  void _toggleNotifications(bool value) {
    setState(() {
      _notificationsEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildCustomSwitch(),
          const SizedBox(height: 20),
          _buildNotificationsSwitch(),
          const SizedBox(height: 20),
          _buildFirebaseStatus(),
          const SizedBox(height: 20),
          // Место для версии приложения внизу
          const Text(
            'Версия приложения:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'Текущая версия: $_appVersion',
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomSwitch() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
        color: _isDarkMode ? Colors.green : Colors.grey[800],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _isDarkMode
              ? Icon(
            Icons.dark_mode,
            color: Colors.white,
          )
              : Icon(
            Icons.light_mode,
            color: Colors.white,
          ),
          Switch(
            value: _isDarkMode,
            onChanged: _toggleTheme,
            activeColor: Colors.white,
            inactiveThumbColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsSwitch() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Уведомления',
            style: TextStyle(fontSize: 16),
          ),
          Switch(
            value: _notificationsEnabled,
            onChanged: _toggleNotifications,
            activeColor: Colors.green,
            inactiveThumbColor: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildFirebaseStatus() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Firebase',
            style: TextStyle(fontSize: 16),
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 6,
                backgroundColor: _isFirebaseConnected ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 10),
              Text(
                _isFirebaseConnected ? 'Подключено' : 'Не подключено',
                style: TextStyle(
                  color: _isFirebaseConnected ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
