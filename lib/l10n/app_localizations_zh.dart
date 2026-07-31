// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get local => '本地';

  @override
  String get cloud => '云端';

  @override
  String get sync => '同步';

  @override
  String get cloudSync => '云端同步';

  @override
  String get localFolder => '本地相册';

  @override
  String get cloudStorage => '云端设置';

  @override
  String get backgroundSync => '后台同步';

  @override
  String get notSync => '张照片尚未同步';

  @override
  String get unsynchronizedPhotos => '未同步照片';

  @override
  String get date => '日期';

  @override
  String get delete => '删除';

  @override
  String get photos => '照片';

  @override
  String get deleteThisPhoto => '删除这张照片?';

  @override
  String get deleteThisPhotos => '删除选中的照片?';

  @override
  String get cantBeUndone => '该操作无法撤销';

  @override
  String get download => '下载';

  @override
  String get upload => '上传';

  @override
  String get success => '成功';

  @override
  String get pics => '照片';

  @override
  String get choose => '选择';

  @override
  String get stop => '停止';

  @override
  String get uploading => '上传中';

  @override
  String get downloading => '下载中';

  @override
  String get uploadFailed => '上传失败';

  @override
  String get uploaded => '已上传';

  @override
  String get notUploaded => '未上传';

  @override
  String get chooseAlbum => '选择相册';

  @override
  String get storageSetting => '网络储存设置';

  @override
  String get remoteStorageType => '网络储存类型';

  @override
  String get samvbaServerAddress => 'Samba服务器地址';

  @override
  String get username => '用户名';

  @override
  String get password => '密码';

  @override
  String get share => '分享';

  @override
  String get rootPath => '储存根目录(照片会储存在该目录下)';

  @override
  String get optional => '可选';

  @override
  String get testStorage => '测试连接';

  @override
  String get save => '保存';

  @override
  String get enableBackgroundSync => '启用后台同步';

  @override
  String get syncOnlyOnWifi => '仅在连接WIFI时同步';

  @override
  String get syncInterval => '同步间隔';

  @override
  String get minite => '分钟';

  @override
  String get hour => '小时';

  @override
  String get day => '天';

  @override
  String get week => '周';

  @override
  String get month => '月';

  @override
  String get year => '年';

  @override
  String get chineseday => '日';

  @override
  String get yes => '确认';

  @override
  String get cancel => '取消';

  @override
  String get permissionDenied => '权限不足';

  @override
  String get setLocalFirst => '请先设置本地相册';

  @override
  String get downloadFailed => '下载失败';

  @override
  String get storageNotSetted => '网络储存未配置,请先配置网络储存';

  @override
  String get successfullyUpload => '成功上传';

  @override
  String get testSuccess => '连接成功,请点击保存';

  @override
  String get connectFailed => '连接失败';

  @override
  String get selectRoot => '选择根目录';

  @override
  String get currentPath => '当前目录';

  @override
  String get refreshingPleaseWait =>
      '正在交叉对比你本地和云端的照片,首次运行或数量较多可能耗时较久,请耐心等待......';

  @override
  String get setRemoteStroage => '请先点击云端设置设置网络储存';

  @override
  String get needPermision => '需要访问相册的权限';

  @override
  String get gotoSystemSetting => '浏览系统相册需要授予相册访问权限,如有需要请转至系统设置授予相册的权限';

  @override
  String get openSetting => '打开设置';

  @override
  String get advancedSetting => '高级设置';

  @override
  String get goToSet => '去设置';

  @override
  String get streamFallbackDownload => '流式播放失败,正在下载后播放';

  @override
  String get dataDirWarning => '修改目录结构只会改变以后上传的文件，不会对已上传的文件进行修改';

  @override
  String get dirType01 => '按日期多层级';

  @override
  String get dirType02 => '按日期单层级';

  @override
  String get tapToSet => '点击设置';

  @override
  String get longPressToCancel => '长按取消设置';

  @override
  String get jumpTo => '快速定位到';

  @override
  String get jumpToByDate => '按日期定位';

  @override
  String get onlyCamera => '仅相机拍摄';

  @override
  String get unlockAllAdvancedFeatures => '解锁所有高级功能';

  @override
  String get browseInRecents => '请在Recents中浏览';

  @override
  String get failedTooMany => '失败次数过多, 已暂停同步';

  @override
  String get refreshing => '获取照片中,请耐心等待...';

  @override
  String get settings => '设置';

  @override
  String get desktopStorageSettingDesc => '设置网络储存来浏览你用Pho备份的照片';

  @override
  String get zoomIn => '放大视图';

  @override
  String get zoomOut => '缩小视图';

  @override
  String get about => '应用信息';

  @override
  String get appVersion => '应用版本';

  @override
  String get releaseStorage => '释放储存空间';

  @override
  String get deleteSynced => '删除已同步的照片';

  @override
  String get youHaveSynced => '您已经同步了';

  @override
  String get photosInCloud => '张照片或视频';

  @override
  String get canDeleteNow => '现在可以删除它们以节省空间';

  @override
  String get canBrowserAnyTime => '您可以随时在云端储存中以原画质浏览它们';

  @override
  String get pleaseConfirmBeforeDelete => '请您务必确认你已经在云端储存中备份了这些照片,否则删除后将无法恢复';

  @override
  String get installHEVCExtention =>
      '如果HEIC或HEVC格式无法正常显示，请在Microsoft Store安装\"HEVC 视频扩展\"';

  @override
  String get openMSStore => '安装';

  @override
  String get clearCache => '清除缓存';

  @override
  String get clearCacheDescription => '此操作只会清除图片缓存,不会删除你的任何配置,确认清除缓存?';

  @override
  String get clearCacheSuccess => '清除缓存成功';

  @override
  String get clearCacheFailed => '清除缓存失败';

  @override
  String get offline => '离线';

  @override
  String get noLocalPhotos => '未找到照片';

  @override
  String get noCloudPhotos => '无云端照片';

  @override
  String get refreshUnsynchronizedPhotos => '刷新未同步照片';

  @override
  String get onboardingWelcome => '欢迎使用 Pho';

  @override
  String get onboardingWelcomeDesc => '你的无服务端照片同步工具';

  @override
  String get onboardingSyncTitle => '同步到你的存储';

  @override
  String get onboardingSyncDesc => '支持 SMB、WebDAV 和 NFS，照片按日期自动组织';

  @override
  String get onboardingPrivacyTitle => '你的数据你做主';

  @override
  String get onboardingPrivacyDesc => '无服务器、无数据库，文件直接存储在你的网络存储中';

  @override
  String get onboardingSkip => '跳过';

  @override
  String get onboardingNext => '下一步';

  @override
  String get onboardingGetStarted => '开始使用';

  @override
  String get onboardingPermissionTitle => '需要相册访问权限';

  @override
  String get onboardingPermissionDesc => 'Pho 需要访问你的相册以浏览和同步照片';

  @override
  String get onboardingGrantPermission => '授予权限';

  @override
  String get onboardingLater => '稍后设置';

  @override
  String get onboardingStorageTitle => '设置云端存储（可选）';

  @override
  String get onboardingStorageDesc => '你现在可以设置或稍后在设置中配置';

  @override
  String get onboardingSetupStorage => '设置存储';

  @override
  String get onboardingComplete => '完成';

  @override
  String get settingsBasic => '基础';

  @override
  String get settingsUtilities => '实用工具';

  @override
  String get monthlyPlan => '月订阅';

  @override
  String get yearlyPlan => '年订阅';

  @override
  String get lifetimePlan => '终身买断';

  @override
  String perMonth(Object price) {
    return '$price/月';
  }

  @override
  String perYear(Object price) {
    return '$price/年';
  }

  @override
  String get oneTime => '一次付费';

  @override
  String savePercent(Object percent) {
    return '省 $percent%';
  }

  @override
  String get recommended => '推荐';

  @override
  String get bestValue => '最划算';

  @override
  String get mostFlexible => '最灵活';

  @override
  String get subscribe => '订阅';

  @override
  String get termsOfUse => '使用条款';

  @override
  String get iosBackgroundSyncDescription => 'iOS 后台同步由系统在充电时自动调度，无需手动设置间隔';

  @override
  String get notificationDenied => '通知权限未开启，同步正常但无提醒';

  @override
  String get backgroundRefreshDisabledTitle => '后台 App 刷新已关闭';

  @override
  String get backgroundRefreshDisabledDesc =>
      '后台同步将无法触发。请到 设置 -> Pho 开启后台 App 刷新，再到 设置 -> 通用 -> 后台 App 刷新 确认全局开启';

  @override
  String get backgroundRefreshDisabledAction => '打开 Pho 设置';

  @override
  String get bgSyncSuccessNotificationTitle => 'Pho 后台同步';

  @override
  String bgSyncSuccessNotificationBody(int count) {
    return '成功同步 $count 张照片';
  }

  @override
  String bgSyncSuccessNotificationBodyWithFailures(int succeeded, int failed) {
    return '成功同步 $succeeded 张照片（$failed 张失败）';
  }
}
