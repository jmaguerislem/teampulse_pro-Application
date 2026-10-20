import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_colors.dart';
import '../core/app_state.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  int _days = 7;

  Widget _statCard(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(color: AppColors.textSoft, fontSize: 13),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _legend(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(color: AppColors.textSoft, fontSize: 12),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final series = s.statsSeries(_days);
    final latePercent = s.taskCount == 0
        ? 0
        : (s.tasksLate * 100 / s.taskCount).round();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: Text(
          'Progression',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          PopupMenuButton<int>(
            initialValue: _days,
            onSelected: (v) => setState(() => _days = v),
            itemBuilder: (_) => const [
              PopupMenuItem(value: 7, child: Text('Cette semaine')),
              PopupMenuItem(value: 30, child: Text('Ce mois')),
            ],
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                _days == 7 ? 'Cette semaine' : 'Ce mois',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Row(
            children: [
              _statCard('Terminées', '${s.tasksDone}', AppColors.mint),
              const SizedBox(width: 12),
              _statCard('En cours', '${s.tasksActive}', AppColors.primary),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.coral.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: AppColors.coral.withValues(alpha: 0.35),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'En retard',
                  style: TextStyle(color: AppColors.textSoft, fontSize: 13),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${s.tasksLate}',
                      style: const TextStyle(
                        color: AppColors.coral,
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        '$latePercent % des tâches',
                        style: const TextStyle(
                          color: AppColors.coral,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Évolution des tâches',
                  style: TextStyle(
                    color: AppColors.navy,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: CustomPaint(painter: _LinePainter(series)),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Il y a $_days jours',
                      style: const TextStyle(
                        color: AppColors.textSoft,
                        fontSize: 11,
                      ),
                    ),
                    const Text(
                      'Aujourd\'hui',
                      style: TextStyle(color: AppColors.textSoft, fontSize: 11),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 16,
                  runSpacing: 6,
                  children: [
                    _legend('Terminées', AppColors.mint),
                    _legend('En cours', AppColors.primary),
                    _legend('En retard', AppColors.coral),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LinePainter extends CustomPainter {
  final List<DayStat> data;
  _LinePainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    var maxV = 1;
    for (final d in data) {
      for (final v in [d.done, d.inProgress, d.overdue]) {
        if (v > maxV) maxV = v;
      }
    }

    final grid = Paint()
      ..color = const Color(0xFFE6E3FA)
      ..strokeWidth = 1;
    for (var i = 0; i < 4; i++) {
      final y = size.height * i / 3;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    void drawLine(int Function(DayStat) pick, Color color) {
      final path = Path();
      for (var i = 0; i < data.length; i++) {
        final x = data.length == 1 ? 0.0 : size.width * i / (data.length - 1);
        final y = size.height - (pick(data[i]) / maxV) * (size.height - 8) - 4;
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      canvas.drawPath(
        path,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round,
      );
    }

    drawLine((d) => d.done, AppColors.mint);
    drawLine((d) => d.inProgress, AppColors.primary);
    drawLine((d) => d.overdue, AppColors.coral);
  }

  @override
  bool shouldRepaint(covariant _LinePainter old) => true;
}
