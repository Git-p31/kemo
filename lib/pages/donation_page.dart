import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key});

  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  String _selectedPaymentMethod = 'Card';
  bool _isAnonymous = false;

  void _submitDonation() {
    final _ = _amountController.text;
    final _ = _messageController.text;
    // Логика отправки пожертвования, например, интеграция с платежной системой.
    // Здесь просто выводим в
    // консоль.
    if (kDebugMode) {
    }
    if (kDebugMode) {
      if (kDebugMode) {
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Пожертвования (Цдака)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Поле для ввода суммы
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Сумма пожертвования',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // Переключатель для анонимного пожертвования
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Анонимное пожертвование',
                  style: TextStyle(fontSize: 16),
                ),
                Switch(
                  value: _isAnonymous,
                  onChanged: (value) {
                    setState(() {
                      _isAnonymous = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Поле для выбора способа оплаты
            const Text(
              'Выберите способ оплаты',
              style: TextStyle(fontSize: 16),
            ),
            DropdownButton<String>(
              value: _selectedPaymentMethod,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPaymentMethod = newValue!;
                });
              },
              items: <String>['Card', 'PayPal', 'Bitcoin']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Поле для сообщения
            TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                labelText: 'Сообщение (необязательно)',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 20),

            // Кнопка отправки пожертвования
            ElevatedButton(
              onPressed: _submitDonation,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Пожертвовать'),
            ),
          ],
        ),
      ),
    );
  }
}
