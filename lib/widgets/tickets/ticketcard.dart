import 'package:flutter/material.dart';

class TicketCard extends StatelessWidget {
  final String eventTitle;
  final String time;
  final String seat;
  final String ticketType;

  TicketCard({
    required this.eventTitle,
    required this.time,
    required this.seat,
    required this.ticketType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventTitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12),
                child: const Icon(
                  Icons.palette,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          DividerWithCutEdges(),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                const Icon(Icons.access_time, size: 16),
                const SizedBox(width: 4),
                Text(time),
                const SizedBox(width: 16),
                const Icon(Icons.event_seat, size: 16),
                const SizedBox(width: 4),
                Text(seat),
              ]),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  ticketType,
                  style:  TextStyle(
                    color: ticketType == 'Regular'? Colors.black54 :Colors.blue
                  ),
                ),
              ),
            ],
          ),
          // SizedBox(height: 8),
        ],
      ),
    );
  }
}

class DividerWithCutEdges extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      child: CustomPaint(
        painter: CutEdgesDividerPainter(),
      ),
    );
  }
}

class CutEdgesDividerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    double dashWidth = 5, dashSpace = 3;
    double startX = 0;

    final path = Path();
    path.moveTo(0, size.height / 2);
    while (startX < size.width) {
      path.lineTo(startX + dashWidth, size.height / 2);
      startX += dashWidth + dashSpace;
      path.moveTo(startX, size.height / 2);
    }

    canvas.drawPath(path, paint);

    // Draw the cut edges
    final cutPath = Path();
    double cutHeight = 10;
    double cutWidth = 15;

    // Left cut
    cutPath.moveTo(0, size.height / 2 - cutHeight / 2);
    cutPath.quadraticBezierTo(
      cutWidth / 2,
      size.height / 2,
      0,
      size.height / 2 + cutHeight / 2,
    );

    // Right cut
    cutPath.moveTo(size.width, size.height / 2 - cutHeight / 2);
    cutPath.quadraticBezierTo(
      size.width - cutWidth / 2,
      size.height / 2,
      size.width,
      size.height / 2 + cutHeight / 2,
    );

    canvas.drawPath(cutPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
