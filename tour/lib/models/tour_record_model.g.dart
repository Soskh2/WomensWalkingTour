// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TourRecord _$TourRecordFromJson(Map<String, dynamic> json) => TourRecord(
      id: json['id'] as String,
      createdTime: json['createdTime'] as String,
      fields: (json['fields'] as List<dynamic>?)
          ?.map((e) => Field.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Field _$FieldFromJson(Map<String, dynamic> json) => Field(
      name: json['Name'] as String,
      orderNumber: (json['order number'] as num?)?.toInt(),
      included: json['included'] as bool?,
      description: json['description'] as String?,
      image: Field._tourImageFromJson(json['image'] as List?),
      audio: Field._audioFromJson(json['audio'] as List?),
      lat: (json['latitude'] as num?)?.toDouble(),
      lon: (json['longitude'] as num?)?.toDouble(),
    );

TourImage _$TourImageFromJson(Map<String, dynamic> json) => TourImage(
      id: json['id'] as String?,
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      url: json['url'] as String?,
      filename: json['filename'] as String?,
      size: (json['size'] as num?)?.toInt(),
      type: json['type'] as String?,
      thumbnails: json['thumbnails'] == null
          ? null
          : Thumbnails.fromJson(json['thumbnails'] as Map<String, dynamic>),
    );

Thumbnails _$ThumbnailsFromJson(Map<String, dynamic> json) => Thumbnails(
      small: Thumbnail.fromJson(json['small'] as Map<String, dynamic>),
      large: Thumbnail.fromJson(json['large'] as Map<String, dynamic>),
      full: Thumbnail.fromJson(json['full'] as Map<String, dynamic>),
    );

Thumbnail _$ThumbnailFromJson(Map<String, dynamic> json) => Thumbnail(
      url: json['url'] as String?,
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
    );

Audio _$AudioFromJson(Map<String, dynamic> json) => Audio(
      id: json['id'] as String?,
      url: json['url'] as String?,
      filename: json['filename'] as String?,
      size: (json['size'] as num?)?.toInt(),
      type: json['type'] as String?,
    );
