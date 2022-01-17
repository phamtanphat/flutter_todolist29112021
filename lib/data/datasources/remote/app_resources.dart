import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_resources.freezed.dart';

@freezed
class AppResources<T> with _$AppResources<T>{

  const factory AppResources.success(T value) = Success<T>;
  const factory AppResources.error([String? message]) = Error<T>;
}