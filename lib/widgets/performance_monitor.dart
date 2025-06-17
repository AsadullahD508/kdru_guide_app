import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class PerformanceMonitor extends StatefulWidget {
  final Widget child;
  final String screenName;
  final bool enabled;

  const PerformanceMonitor({
    super.key,
    required this.child,
    required this.screenName,
    this.enabled = kDebugMode,
  });

  @override
  State<PerformanceMonitor> createState() => _PerformanceMonitorState();
}

class _PerformanceMonitorState extends State<PerformanceMonitor> {
  late DateTime _startTime;
  int _buildCount = 0;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    if (widget.enabled) {
      debugPrint('🚀 [${widget.screenName}] Screen initialized');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.enabled) {
      _buildCount++;
      final buildTime = DateTime.now().difference(_startTime).inMilliseconds;
      
      if (_buildCount > 1) {
        debugPrint('🔄 [${widget.screenName}] Rebuild #$_buildCount after ${buildTime}ms');
      }
    }

    return widget.child;
  }

  @override
  void dispose() {
    if (widget.enabled) {
      final totalTime = DateTime.now().difference(_startTime).inMilliseconds;
      debugPrint('🏁 [${widget.screenName}] Disposed after ${totalTime}ms, $_buildCount builds');
    }
    super.dispose();
  }
}

class OptimizedBuilder extends StatelessWidget {
  final Widget Function(BuildContext context) builder;
  final String? debugLabel;

  const OptimizedBuilder({
    super.key,
    required this.builder,
    this.debugLabel,
  });

  @override
  Widget build(BuildContext context) {
    if (kDebugMode && debugLabel != null) {
      final stopwatch = Stopwatch()..start();
      final widget = builder(context);
      stopwatch.stop();
      
      if (stopwatch.elapsedMilliseconds > 16) { // More than one frame
        debugPrint('⚠️ Slow build: $debugLabel took ${stopwatch.elapsedMilliseconds}ms');
      }
      
      return widget;
    }
    
    return builder(context);
  }
}

class LazyBuilder extends StatefulWidget {
  final Widget Function(BuildContext context) builder;
  final Duration delay;

  const LazyBuilder({
    super.key,
    required this.builder,
    this.delay = const Duration(milliseconds: 100),
  });

  @override
  State<LazyBuilder> createState() => _LazyBuilderState();
}

class _LazyBuilderState extends State<LazyBuilder> {
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) {
        setState(() {
          _isReady = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) {
      return const SizedBox.shrink();
    }
    
    return widget.builder(context);
  }
}

class MemoryEfficientList extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final ScrollController? controller;
  final EdgeInsets? padding;
  final bool shrinkWrap;

  const MemoryEfficientList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.controller,
    this.padding,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      padding: padding,
      shrinkWrap: shrinkWrap,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      cacheExtent: 500,
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
    );
  }
}

class MemoryEfficientGrid extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final SliverGridDelegate gridDelegate;
  final ScrollController? controller;
  final EdgeInsets? padding;
  final bool shrinkWrap;

  const MemoryEfficientGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.gridDelegate,
    this.controller,
    this.padding,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: controller,
      padding: padding,
      shrinkWrap: shrinkWrap,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      gridDelegate: gridDelegate,
      cacheExtent: 500,
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
    );
  }
}

class CachedWidget extends StatefulWidget {
  final Widget Function(BuildContext context) builder;
  final Duration cacheDuration;
  final String? cacheKey;

  const CachedWidget({
    super.key,
    required this.builder,
    this.cacheDuration = const Duration(minutes: 5),
    this.cacheKey,
  });

  @override
  State<CachedWidget> createState() => _CachedWidgetState();
}

class _CachedWidgetState extends State<CachedWidget> {
  Widget? _cachedWidget;
  DateTime? _cacheTime;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    
    if (_cachedWidget == null || 
        _cacheTime == null || 
        now.difference(_cacheTime!).compareTo(widget.cacheDuration) > 0) {
      
      _cachedWidget = widget.builder(context);
      _cacheTime = now;
      
      if (kDebugMode && widget.cacheKey != null) {
        debugPrint('🔄 Cache miss for ${widget.cacheKey}');
      }
    } else if (kDebugMode && widget.cacheKey != null) {
      debugPrint('✅ Cache hit for ${widget.cacheKey}');
    }
    
    return _cachedWidget!;
  }
}

class DebouncedBuilder extends StatefulWidget {
  final Widget Function(BuildContext context) builder;
  final Duration debounceTime;

  const DebouncedBuilder({
    super.key,
    required this.builder,
    this.debounceTime = const Duration(milliseconds: 100),
  });

  @override
  State<DebouncedBuilder> createState() => _DebouncedBuilderState();
}

class _DebouncedBuilderState extends State<DebouncedBuilder> {
  Widget? _currentWidget;
  DateTime? _lastBuildTime;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    
    if (_lastBuildTime == null || 
        now.difference(_lastBuildTime!).compareTo(widget.debounceTime) > 0) {
      
      _currentWidget = widget.builder(context);
      _lastBuildTime = now;
    }
    
    return _currentWidget ?? const SizedBox.shrink();
  }
}

class PerformanceOverlay extends StatelessWidget {
  final Widget child;
  final bool showFPS;
  final bool showMemory;

  const PerformanceOverlay({
    super.key,
    required this.child,
    this.showFPS = false,
    this.showMemory = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode || (!showFPS && !showMemory)) {
      return child;
    }

    return Stack(
      children: [
        child,
        if (showFPS || showMemory)
          Positioned(
            top: 50,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (showFPS)
                    const Text(
                      'FPS: Monitor in DevTools',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  if (showMemory)
                    const Text(
                      'Memory: Monitor in DevTools',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
