import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Tip extends StatelessWidget {
  final String? textTip;

  const Tip({Key? key, required this.textTip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        top: 40.0,
        bottom: 10.0,
      ),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(30.0),
        ),
        child:
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              textTip!,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class CarouselTips extends StatefulWidget {
  const CarouselTips({Key? key}) : super(key: key);

  @override
  _CarouselTipsState createState() => _CarouselTipsState();
}

class _CarouselTipsState extends State<CarouselTips> {
  int _currentIndex = 0;
  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8, top: 16, bottom: 0),
                child:
                ListTile(
                  minLeadingWidth: 10,
                  title: Text('Dicas', style: TextStyle(fontSize: 20)),
                  leading: Icon(Icons.tips_and_updates),
                ),
              ),
            ),
          ],
        ),
        CarouselSlider(
          carouselController: buttonCarouselController,
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(seconds: 3),
            //scrollDirection: Axis.vertical,
            onPageChanged: (index, reason) {
              setState(
                    () {
                  _currentIndex = index;
                },
              );
            },
          ),
          items: [
            const Tip(textTip: 'Beba água com frequência durante o dia para se manter hidratado'),
            const Tip(textTip: 'Mantenha uma alimentação de 3 em 3 horas para ativar o metabolismo'),
            const Tip(textTip: 'Dormir no mínimo 8 horas por dia'),
            const Tip(textTip: 'Evitar ingerir carboidratos em excesso'),
          ].toList(),
        ),
      ],
    );
  }
}