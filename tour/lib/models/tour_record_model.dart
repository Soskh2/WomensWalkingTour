import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
part 'tour_record_model.g.dart';


@JsonSerializable(createToJson: false)
class TourRecord {
  final String id;
  final String createdTime;
  final List<Field>? fields;

  TourRecord({
    required this.id,
    required this.createdTime,
    required this.fields,
  });

  factory TourRecord.fromJson(Map<String, dynamic> json) => _$TourRecordFromJson(json);
}


@JsonSerializable(createToJson: false)
class Field {
  final String? name;
  final int? orderNumber;
  final bool? included;
  final String? description;
  @JsonKey(fromJson: _imageFromJson, defaultValue: null) // Specify custom deserialization for Image
  final Image? image;
  @JsonKey(fromJson: _audioFromJson, defaultValue: null) // Specify custom deserialization for Audio
  final Audio? audio;

  Field({
    required this.name,
    required this.orderNumber,
    required this.included,
    required this.description,
    required this.image,
    required this.audio,
  });

  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);

   // Custom deserialization function for Image
  static _imageFromJson(Map<String, dynamic> json) {
    if (json == null) return null; // Return a default Image if null
    return Image.fromJson(json); // Call the fromJson constructor for Image
  }

  // Custom deserialization function for Audio
  static _audioFromJson(Map<String, dynamic> json) {
    if (json == null) return null; // Return a default Audio if null
    return Audio.fromJson(json); // Call the fromJson constructor for Audio
  }
}

@JsonSerializable(createToJson: false)
class Image {
  final String? id;
  final int? width;
  final int? height;
  final String? url;
  final String? filename;
  final int? size;
  final String? type;
  final List<Thumbnails?> thumbnails;

  Image({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
    required this.filename,
    required this.size,
    required this.type,
    required this.thumbnails,
  });

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
}

@JsonSerializable(createToJson: false)
class Thumbnails {
  final Thumbnail small;
  final Thumbnail large;
  final Thumbnail full;

  Thumbnails({
    required this.small,
    required this.large,
    required this.full,
  });

  factory Thumbnails.fromJson(Map<String, dynamic> json) => _$ThumbnailsFromJson(json);
}

@JsonSerializable(createToJson: false)
class Thumbnail {
  final String? url;
  final int? width;
  final int? height;

  Thumbnail({
    required this.url,
    required this.width,
    required this.height,
  });
  
  factory Thumbnail.fromJson(Map<String, dynamic> json) => _$ThumbnailFromJson(json);
}


@JsonSerializable(createToJson: false)
class Audio {
  final String? id;
  final String? url;
  final String? filename;
  final int? size;
  final String? type;

  Audio({
    required this.id,
    required this.url,
    required this.filename,
    required this.size,
    required this.type,
  });
  
  factory Audio.fromJson(Map<String, dynamic> json) => _$AudioFromJson(json);
}
 
