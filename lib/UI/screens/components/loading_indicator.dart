import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

/// Индикатор загрузки картинки.
class LoadingIndicator {
  static Widget progressIndicatorBuilder(
    BuildContext context,
    String url,
    DownloadProgress downloadProgress,
  ) {
    return Center(
      child: CupertinoActivityIndicator.partiallyRevealed(
        progress: downloadProgress.progress ?? 0,
      ),
    );
  }
}
