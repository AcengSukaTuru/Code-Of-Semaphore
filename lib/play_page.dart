// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:math'; // Import library Random untuk memilih kata secara acak

class PlayPage extends StatefulWidget {
  const PlayPage({super.key});

  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  final List<String> words = [
    "aku suka nasi goreng",
    "saya sangat takut",
    "ibu itu baik hati",
    "makan pagi bersama keluarga",
    "belajar adalah kunci sukses",
  ];
  String currentWord = ""; // Kata target
  String inputWord = ""; // Input dari pemain
  int lives = 3; // Nyawa pemain
  List<String> keyboardLetters = [];

  @override
  void initState() {
    super.initState();
    chooseRandomWord(); // Pilih kata acak saat game dimulai
    randomizeKeyboard(); // Acak keyboard saat game dimulai
  }

  void chooseRandomWord() {
    final random = Random();
    setState(() {
      currentWord = words[random.nextInt(words.length)];
    });
  }

  void randomizeKeyboard() {
    final random = Random();
    keyboardLetters = 'abcdefghijklmnopqrstuvwxyz'.split('')..shuffle(random);
  }

  // Fungsi untuk menangani tombol yang ditekan
  void handleKeyPress(String letter) {
    setState(() {
      if (inputWord.replaceAll(" ", "").length < currentWord.replaceAll(" ", "").length) {
        // Skip spaces in the target word
        while (inputWord.length < currentWord.length && currentWord[inputWord.length] == " ") {
          inputWord += " ";
        }

        if (letter == " ") return; // Ignore space input
        inputWord += letter;

        // Jika huruf salah, kurangi nyawa
        if (currentWord.replaceAll(" ", "")[inputWord.replaceAll(" ", "").length - 1] != letter) {
          lives--;
          inputWord = inputWord.substring(0, inputWord.length - 1); // Undo input
        }

        // Jika nyawa habis
        if (lives <= 0) {
          showGameOverDialog();
        }

        // Jika selesai dengan benar
        if (inputWord.replaceAll(" ", "") == currentWord.replaceAll(" ", "")) {
          showSuccessDialog();
        }
      }
    });
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Agar dialog tidak bisa ditutup dengan klik luar
      barrierColor: Colors.black.withOpacity(0.8), // Layar di luar pop-up gelap
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent, // Hapus background putih
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/berhasil.png"), // Gambar berhasil
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Tutup pop-up
                    Navigator.pop(context); // Kembali ke layar sebelumnya
                  },
                  child: Image.asset(
                    "assets/images/back.png",
                    width: 300,
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Tutup pop-up
                    resetGame(); // Ulangi game
                  },
                  child: Image.asset(
                    "assets/images/again.png",
                    width: 300,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/gameover.png"), // Gambar game over
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Tutup pop-up
                    Navigator.pop(context); // Kembali ke layar sebelumnya
                  },
                  child: Image.asset(
                    "assets/images/back.png",
                    width: 300,
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Tutup pop-up
                    resetGame(); // Ulangi game
                  },
                  child: Image.asset(
                    "assets/images/again.png",
                    width: 300,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void resetGame() {
    setState(() {
      inputWord = ""; // Reset input
      lives = 3; // Reset nyawa
      chooseRandomWord(); // Pilih kata acak baru
      randomizeKeyboard(); // Acak keyboard saat game diulang
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color(0xFFA67B5B),
          ),
          // Gambar latar belakang
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover, // Agar gambar menyesuaikan layar
            ),
          ),
          // Konten utama
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Nyawa pemain
              // Nyawa pemain dengan gambar life.png
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context); // Kembali ke layar sebelumnya
                      },
                      child: Image.asset(
                        'assets/images/back_btn.png', // Tombol back
                        width: 50, // Ukuran tombol back
                      ),
                    ),
                  ),
                  const Spacer(), // Pindahkan nyawa ke pojok kanan atas
                  Row(
                    children: List.generate(
                      lives,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Image.asset(
                          'assets/images/life.png', // Gambar nyawa
                          width: 60, // Ukuran gambar nyawa
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),

              // Kata target dengan huruf yang berubah warna
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/word_border.png', // Gambar latar belakang
                        width: currentWord.length * 1000.0, // Sesuaikan ukuran gambar
                        height: 100,
                      ),
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: List.generate(
                          currentWord.length,
                          (index) {
                            String letter = currentWord[index];
                            bool isSpace = letter == " "; // Cek apakah karakter adalah spasi
                            bool isCorrect = index < inputWord.length && inputWord[index] == letter;

                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                              child: Text(
                                isSpace
                                    ? " " // Spasi ditampilkan sebagai ruang kosong
                                    : letter.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 42,
                                  fontWeight: FontWeight.bold,
                                  color: isCorrect ? Colors.green : Colors.black,
                                  fontFamily: 'Beige',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Keyboard (randomized layout)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildKeyboardRow(keyboardLetters.sublist(0, 10).join('')),
                      const SizedBox(height: 5),
                      buildKeyboardRow(keyboardLetters.sublist(10, 19).join('')),
                      const SizedBox(height: 5),
                      buildKeyboardRow(keyboardLetters.sublist(19).join('')),
                      // Remove the space key
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membangun satu baris keyboard
  Widget buildKeyboardRow(String letters) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: letters.split('').map((letter) => buildKey(letter)).toList(),
    );
  }

  // Fungsi untuk membangun tombol dengan gambar sandi Morse
  Widget buildKey(String letter) {
    return GestureDetector(
      onTap: () => handleKeyPress(letter),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2), // Spasi antar tombol
        width: 125, // Lebar tombol
        height: 125, // Tinggi tombol
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(5),
          color: Color(0xFFC36A2D), // Warna tombol
        ),
        child: Image.asset(
          'assets/images/$letter.png', // Gambar sesuai huruf
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
