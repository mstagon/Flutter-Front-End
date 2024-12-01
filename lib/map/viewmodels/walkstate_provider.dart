import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/walk_state.dart';

final walkStateProvider = StateProvider<WalkState>((ref) => WalkState.before);