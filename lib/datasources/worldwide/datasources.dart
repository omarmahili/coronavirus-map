import 'package:coronavirusapp/datasources/worldwide/base.dart';
import 'package:coronavirusapp/datasources/worldwide/jhu_github.dart';

class Datasources {
  static List<BaseDatasource> list = [
    JHUGithubDatasource(),
  ];
}
