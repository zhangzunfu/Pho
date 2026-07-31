import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:img_syncer/background_sync_route.dart';
import 'package:img_syncer/choose_album_route.dart';
import 'package:img_syncer/design_tokens.dart';
import 'package:img_syncer/logger/logger.dart';
import 'package:img_syncer/proto/img_syncer.pbgrpc.dart';
import 'package:img_syncer/setting_storage_route.dart';
import 'package:img_syncer/storage/storage.dart';
import 'package:img_syncer/global.dart';
import 'package:img_syncer/state_model.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRoute extends StatefulWidget {
  const SettingsRoute({Key? key}) : super(key: key);

  @override
  SettingsRouteState createState() => SettingsRouteState();
}

class SettingsRouteState extends State<SettingsRoute> {
  final TextEditingController _encryptPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _encryptPasswordController.text = settingModel.encryptionPassword;
  }

  @override
  void dispose() {
    _encryptPasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: ListView(
        children: [
          // === 基础功能 ===
          tile(
            Icons.folder_outlined,
            l10n.chooseAlbum,
            null,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChooseAlbumRoute(),
              ),
            ),
          ),
          tile(
            Icons.cloud_outlined,
            l10n.cloudStorage,
            null,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingStorageRoute(),
              ),
            ),
          ),
          if (Platform.isAndroid)
            tile(
              Icons.cloud_sync_outlined,
              l10n.backgroundSync,
              null,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BackgroundSyncSettingRoute(),
                ),
              ),
            ),
          const Divider(),

          // === Pro 功能 ===
          _buildProSection(),

          const Divider(),

          // === 其他 ===
          tile(
            Icons.cleaning_services,
            l10n.clearCache,
            null,
            onTap: () => showClearCacheDialog(context),
          ),
          tile(
            Icons.info,
            l10n.about,
            null,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AboutRoute(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProSection() {
    return Consumer<SettingModel>(
      builder: (context, _, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.paddingStandard, AppSpacing.sm, 0, AppSpacing.xs),
              child: Text(
                'Pro',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.proCrownColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),

            // AES 加密
            SwitchListTile(
              title: const Text('AES 加密上传'),
              subtitle: Text(
                settingModel.enableEncrypt
                    ? settingModel.encryptionType == EncryptionType.aesGcm
                        ? 'AES-256-GCM (支持 Range 播放)'
                        : 'AES-128-CFB'
                    : '已关闭',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              secondary: Icon(
                settingModel.enableEncrypt ? Icons.lock : Icons.lock_open,
                color: settingModel.enableEncrypt
                    ? AppColors.proCrownColor
                    : null,
              ),
              value: settingModel.enableEncrypt,
              onChanged: (value) async {
                settingModel.setEncryptSwitch(value);
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool("enable_encrypt", value);
              },
            ),

            if (settingModel.enableEncrypt)
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.paddingLarge),
                child: SegmentedButton<EncryptionType>(
                  segments: const [
                    ButtonSegment(
                      value: EncryptionType.aesGcm,
                      label: Text('AES-256-GCM'),
                    ),
                    ButtonSegment(
                      value: EncryptionType.aesCfb,
                      label: Text('AES-128-CFB'),
                    ),
                  ],
                  selected: {settingModel.encryptionType},
                  onSelectionChanged: (Set<EncryptionType> value) async {
                    settingModel.setEncryptionType(value.first);
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setInt("encryption_type", value.first.index);
                  },
                ),
              ),

            if (settingModel.enableEncrypt)
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.paddingLarge,
                    vertical: AppSpacing.xs),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: '加密密码',
                    hintText: '输入加密密码',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.key),
                  ),
                  controller: _encryptPasswordController,
                  onChanged: (value) async {
                    settingModel.setEncryptionPassword(value);
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString("encryption_password", value);
                  },
                ),
              ),

            // 并行上传
            ListTile(
              leading: const Icon(Icons.speed),
              title: const Text('并行上传'),
              subtitle: Text(
                '${settingModel.parallelUploadCount} 个文件并发上传',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              trailing: DropdownMenu<int>(
                initialSelection: settingModel.parallelUploadCount,
                dropdownMenuEntries: List.generate(8, (i) {
                  final v = i + 1;
                  return DropdownMenuEntry(value: v, label: '$v');
                }),
                onSelected: (value) async {
                  if (value == null) return;
                  settingModel.setParallelUploadCount(value);
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setInt("parallel_upload_count", value);
                },
              ),
            ),

            // 文件筛选
            ListTile(
              leading: const Icon(Icons.filter_list),
              title: const Text('文件筛选'),
              subtitle: Text(
                _fileFilterName(settingModel.fileFilterType),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              trailing: DropdownMenu<FileFilterType>(
                initialSelection: settingModel.fileFilterType,
                dropdownMenuEntries: const [
                  DropdownMenuEntry(
                      value: FileFilterType.all, label: '全部文件'),
                  DropdownMenuEntry(
                      value: FileFilterType.imagesOnly, label: '仅图片'),
                  DropdownMenuEntry(
                      value: FileFilterType.videosOnly, label: '仅视频'),
                ],
                onSelected: (value) async {
                  if (value == null) return;
                  settingModel.setFileFilterType(value);
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setInt("file_filter_type", value.index);
                },
              ),
            ),

            // 目录结构
            ListTile(
              leading: const Icon(Icons.folder_special),
              title: const Text('目录结构'),
              subtitle: Text(
                settingModel.dirLayout == DirLayout.yyyymmdd
                    ? 'YYYYMMDD/文件名'
                    : 'YYYY/MM/DD/文件名',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              trailing: DropdownMenu<DirLayout>(
                initialSelection: settingModel.dirLayout,
                dropdownMenuEntries: const [
                  DropdownMenuEntry(
                      value: DirLayout.yyyymmdd, label: 'YYYYMMDD'),
                  DropdownMenuEntry(
                      value: DirLayout.yymmdd, label: 'YYYY/MM/DD'),
                ],
                onSelected: (value) async {
                  if (value == null) return;
                  settingModel.setDirLayout(value);
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setInt("dir_layout", value.index);
                  // 同步设置到 Go 服务端
                  try {
                    await storage.cli.setDirectoryType(
                      SetDirectoryTypeRequest(
                        directoryType: value == DirLayout.yyyymmdd
                            ? DirectoryType.DIRECTORY_TYPE_02
                            : DirectoryType.DIRECTORY_TYPE_01,
                      ),
                    );
                  } catch (e) {
                    logger.addLog('setDirectoryType failed: $e');
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  String _fileFilterName(FileFilterType type) {
    switch (type) {
      case FileFilterType.all:
        return '同步所有文件';
      case FileFilterType.imagesOnly:
        return '仅同步图片';
      case FileFilterType.videosOnly:
        return '仅同步视频';
    }
  }

  Widget tile(IconData icon, String title, String? subtitle,
      {Function()? onTap}) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.paddingSmall),
      child: ListTile(
        leading: Icon(
          icon,
          size: 28,
          color: colorScheme.onSurfaceVariant,
        ),
        title: Text(title, style: textTheme.titleLarge),
        subtitle: subtitle != null
            ? Text(subtitle,
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ))
            : null,
        onTap: onTap,
      ),
    );
  }

  void showClearCacheDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(30, 20, 20, 5),
                    child: Text(
                      l10n.clearCache,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(30, 5, 20, 5),
                    child: Text(
                      l10n.clearCacheDescription,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 5),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(l10n.cancel),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 5),
                        child: TextButton(
                          onPressed: () {
                            clearDiskCachedImages();
                            PhotoManager.clearFileCache();
                            Navigator.of(context).pop();
                          },
                          child: Text(l10n.yes),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class AboutRoute extends StatelessWidget {
  const AboutRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const version = '1.5.0';
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.about),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.paddingSmall,
                vertical: AppSpacing.xs),
            child: ListTile(
              title: Text(l10n.appVersion,
                  style: Theme.of(context).textTheme.titleLarge),
              subtitle: Text(
                'Pho - $version',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
