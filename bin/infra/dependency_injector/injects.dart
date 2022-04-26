import '../../apis/blog_api.dart';
import '../../apis/login_api.dart';
import '../../models/news_model.dart';
import '../../services/generic_service.dart';
import '../../services/news_service.dart';
import '../database/db_configuration.dart';
import '../database/mysql_db_configuration.dart';
import '../security/security_server.dart';
import '../security/sercurity_server_imp.dart';
import 'dependency_injector.dart';

class Injects {
  static DependencyInjector initialize() {
    var di = DependencyInjector();
    di.register<SecurityService>(() => SecurityServerImp());

    di.register<LoginApi>(() => LoginApi(di<SecurityService>()));

    di.register<GenericService<NewsModel>>(() => NewsService());
    di.register<BlogApi>(() => BlogApi(di<GenericService<NewsModel>>()));

    di.register<DBConfiguration>(() => MySqlDBConfiguration());

    return di;
  }
}
