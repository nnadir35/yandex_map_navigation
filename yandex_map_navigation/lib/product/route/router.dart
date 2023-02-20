import 'package:auto_route/annotations.dart';
import 'package:yandex_map_navigation/features/map/yandexmap.dart';

@AdaptiveAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: YandexMap, initial: true),
  ],
)
class $AppRouter {}
