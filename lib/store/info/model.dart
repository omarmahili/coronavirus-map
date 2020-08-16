import 'package:coronavirusapp/version.dart';

class InfoState {
  final bool termsAccepted;
  final String version;

  InfoState({
    this.termsAccepted,
    this.version,
  });

  factory InfoState.initial() => InfoState(
        version: currentVersion,
        termsAccepted: false,
      );

  InfoState copyWith({bool termsAccepted, String version}) => InfoState(
        termsAccepted: termsAccepted ?? this.termsAccepted,
        version: version ?? this.version,
      );

  static InfoState fromJson(dynamic json) => json != null
      ? InfoState(
          version: currentVersion,
          termsAccepted: json['version'] != currentVersion && termsChanged ? false : json["termsAccepted"] as bool,
        )
      : InfoState.initial();

  dynamic toJson() => {
        "version": version,
        "termsAccepted": termsAccepted,
      };
}
