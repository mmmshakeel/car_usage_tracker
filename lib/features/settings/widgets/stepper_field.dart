import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_theme.dart';

class StepperField extends StatefulWidget {
  const StepperField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.step = 1,
    this.min = 0,
  });

  final String label;
  final int value;
  final ValueChanged<int> onChanged;
  final int step;
  final int min;

  @override
  State<StepperField> createState() => _StepperFieldState();
}

class _StepperFieldState extends State<StepperField> {
  late final TextEditingController _controller;
  late int _current;

  @override
  void initState() {
    super.initState();
    _current = widget.value;
    _controller = TextEditingController(text: '${widget.value}');
  }

  @override
  void didUpdateWidget(StepperField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _current) {
      _current = widget.value;
      // Preserve cursor position while syncing text
      final selection = _controller.selection;
      _controller.text = '$_current';
      // Restore cursor to end if it was at end, else keep position
      final newOffset = _controller.text.length;
      _controller.selection = selection.isValid && selection.end <= newOffset
          ? selection
          : TextSelection.collapsed(offset: newOffset);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _decrement() {
    FocusScope.of(context).unfocus();
    final next = (_current - widget.step).clamp(widget.min, double.maxFinite.toInt());
    widget.onChanged(next);
  }

  void _increment() {
    FocusScope.of(context).unfocus();
    widget.onChanged(_current + widget.step);
  }

  void _onTextChanged(String text) {
    final parsed = int.tryParse(text);
    if (parsed != null && parsed >= widget.min) {
      _current = parsed;
      widget.onChanged(parsed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: [
            _StepButton(icon: Icons.remove, onTap: _current > widget.min ? _decrement : null),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.sm,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: AppRadius.card,
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: AppRadius.card,
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                textInputAction: TextInputAction.done,
                onChanged: _onTextChanged,
                onSubmitted: (_) => FocusScope.of(context).unfocus(),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            _StepButton(icon: Icons.add, onTap: _increment),
          ],
        ),
      ],
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: onTap != null ? AppColors.primary : Colors.grey.shade300,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}
