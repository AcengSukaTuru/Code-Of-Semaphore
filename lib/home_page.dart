// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:code_of_the_semaphore/play_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AudioPlayer _audioPlayer;
  late AudioPlayer _buttonSoundPlayer; // Audio player untuk suara tombol
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _buttonSoundPlayer = AudioPlayer();
    _playMusicOnStart();
  }

  Future<void> _playMusicOnStart() async {
    await _audioPlayer.play(AssetSource('sounds/song.mp3'));
  }

  Future<void> playButtonSound() async {
    await _buttonSoundPlayer.play(AssetSource('sounds/btn_sound.mp3'));
  }

  void _toggleMusic() async {
    playButtonSound(); // Mainkan suara tombol
    if (_isPlaying) {
      await _audioPlayer.stop();
    } else {
      await _audioPlayer.play(AssetSource('sounds/song.mp3'));
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _buttonSoundPlayer.dispose(); // Bebaskan resource
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background color
          Container(
            color: const Color(0xFFA67B5B),
          ),
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Help and Speaker Buttons
          Positioned(
            top: 40,
            right: 20,
            child: Row(
              children: [
                // Help Button
                IconButton(
                  onPressed: () {
                    playButtonSound(); // Mainkan suara tombol
                    // Tampilkan pop-up Help
                    showDialog(
                      context: context,
                      barrierColor: Colors.black.withOpacity(0.8),
                      builder: (context) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 20),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Konten Pop-up
                                  Image.asset(
                                    'assets/images/cara_bermain.png',
                                    width: 700,
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    "Di halaman bermain, pemain akan diberikan kata-kata dan di bawahnya ada kotak yang berisi kode bendera semaphore.\n\n"
                                    "Pemain ditugaskan untuk mengikuti kata-kata yang sudah diberikan dengan menekan kode semaphore yang ada.\n\n"
                                    "Kode semaphore ditampilkan secara acak dan tidak sesuai dengan abjad yang ada.\n\n"
                                    "Setiap selesai satu kata, pemain wajib menekan tombol yang berwarna coklat dan terletak di paling akhir.\n\n"
                                    "SELAMAT BELAJAR SAMBIL BERMAIN !!!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      decoration: TextDecoration.none,
                                      fontFamily: 'Beige',
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF865D42),
                                    ),
                                    child: const Text("Tutup"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.help_outline,
                    color: Color.fromARGB(255, 107, 75, 53),
                    size: 60,
                  ),
                ),
                const SizedBox(width: 20),
                // Speaker Button
                IconButton(
                  onPressed: _toggleMusic, // Jalankan toggle dan mainkan suara tombol
                  icon: Icon(
                    _isPlaying ? Icons.volume_up : Icons.volume_off,
                    color: Color.fromARGB(255, 107, 75, 53),
                    size: 60,
                  ),
                ),
              ],
            ),
          ),
          // Title "CODE"
          Positioned(
            top: 175,
            left: 300,
            child: Image.asset(
              'assets/images/code.png',
              width: 500,
            ),
          ),
          // Title "OF THE"
          Positioned(
            top: 225,
            left: 700,
            child: Image.asset(
              'assets/images/of_the.png',
              width: 320,
            ),
          ),
          // Title "SEMAPHORE"
          Positioned(
            top: 300,
            left: 250,
            child: Image.asset(
              'assets/images/semaphore.png',
              width: 1000,
            ),
          ),
          // Play Button
          Positioned(
            bottom: 200,
            left: MediaQuery.of(context).size.width / 2 - 275,
            child: GestureDetector(
              onTap: () async {
                await _audioPlayer.stop(); // Hentikan musik
                playButtonSound(); // Mainkan suara tombol
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PlayPage(),
                  ),
                ).then((_) => _audioPlayer.resume()); // Resume jika perlu setelah kembali
              },
              child: Image.asset(
                'assets/images/play_btn.png',
                width: 500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}