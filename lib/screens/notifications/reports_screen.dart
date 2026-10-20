import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_colors.dart';
import '../../core/app_state.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/primary_button.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  int _tab = 0;
  String? _projectId;

  String _fmtDuration(Duration? d, AppLocalizations l) {
    if (d == null) return '—';
    final days = d.inDays;
    final hours = d.inHours % 24;
    if (days > 0) return l.durationDaysHours(days, hours);
    if (d.inHours > 0) return l.durationHours(d.inHours);
    return l.durationMinutes(d.inMinutes);
  }

  Widget _tabChip(String label, int index) {
    final selected = _tab == index;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => setState(() => _tab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: selected ? AppColors.navy : Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Text(label,
              style: TextStyle(
                color: selected ? Colors.white : AppColors.navy,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              )),
        ),
      ),
    );
  }

  Widget _row(String label, String value, {Color? color, bool last = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: last
            ? null
            : const Border(bottom: BorderSide(color: Color(0xFFEDEAFB))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
                  const TextStyle(color: AppColors.textSoft, fontSize: 14)),
          Text(value,
              style: TextStyle(
                color: color ?? AppColors.navy,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>();
    final l = AppLocalizations.of(context)!;
    final projects = s.projects;

    final String? pid = _tab == 0
        ? null
        : (_projectId ?? (projects.isEmpty ? null : projects.first.id));
    final noProject = _tab == 1 && pid == null;
    final r = s.reportFor(pid);
    final percent = (r.successRate * 100).round();

    return Scaffold(
      appBar: AppBar(
        title: Text(l.reportsTitle,
            style: Theme.of(context).textTheme.titleLarge),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Row(children: [
            _tabChip(l.tabGlobal, 0),
            _tabChip(l.tabByProject, 1),
          ]),
          const SizedBox(height: 16),
          if (_tab == 1 && projects.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: DropdownButton<String>(
                value: pid,
                isExpanded: true,
                underline: const SizedBox(),
                style: const TextStyle(
                  color: AppColors.navy,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
                items: projects
                    .map((p) =>
                        DropdownMenuItem(value: p.id, child: Text(p.name)))
                    .toList(),
                onChanged: (v) => setState(() => _projectId = v),
              ),
            ),
            const SizedBox(height: 16),
          ],
          if (noProject)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Center(
                child: Text(l.noProjectYet,
                    style: const TextStyle(color: AppColors.textSoft)),
              ),
            )
          else ...[
            Container(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l.summary,
                      style: const TextStyle(
                        color: AppColors.navy,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      )),
                  const SizedBox(height: 4),
                  _row(l.totalTasks, '${r.total}'),
                  _row(l.statDone, '${r.done}', color: AppColors.mint),
                  _row(l.overdueLabel, '${r.overdue}',
                      color: AppColors.coral),
                  _row(l.avgResolution, _fmtDuration(r.avgResolution, l),
                      last: true),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(l.successRate,
                          style: const TextStyle(
                            color: AppColors.navy,
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                          )),
                      Text('$percent %',
                          style: const TextStyle(
                            color: AppColors.mint,
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                          )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: r.successRate,
                      minHeight: 8,
                      backgroundColor: AppColors.background,
                      valueColor:
                          const AlwaysStoppedAnimation(AppColors.mint),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            PrimaryButton(
              label: l.exportPdf,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l.pdfSoon)),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}