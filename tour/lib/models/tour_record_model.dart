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

  factory TourRecord.fromJson(Map<String, dynamic> json) {
    return _$TourRecordFromJson(json);
  }
}


@JsonSerializable(createToJson: false)
class Field {
  final String name;
  final int? orderNumber;
  final bool? included;
  final String? description;
  @JsonKey(fromJson: _tourImageFromJson, defaultValue: null)
  final List<TourImage>? image;
  @JsonKey(fromJson: _audioFromJson, defaultValue: null)
  final List<Audio>? audio;
  final double? lat;
  final double? lon;
  int? index;

  Field({
    required this.name,
    required this.orderNumber,
    required this.included,
    required this.description,
    required this.image,
    required this.audio,
    required this.lat,
    required this.lon,
    required this.index,
  });

  factory Field.fromJson(Map<String, dynamic> json) {
    return _$FieldFromJson(json);
  }

   // Custom deserialization function for Image
  static List<TourImage>? _tourImageFromJson(List<dynamic>? jsonList) {
    if (jsonList == null) return null; 
    return jsonList
        .map((jsonItem) => TourImage.fromJson(jsonItem as Map<String, dynamic>))
        .toList(); 
  }

  // Custom deserialization function for Audio
  static List<Audio>? _audioFromJson(List<dynamic>? jsonList) {
    if (jsonList == null) return null; 
    return jsonList
        .map((jsonItem) => Audio.fromJson(jsonItem as Map<String, dynamic>))
        .toList(); 
  }
}

@JsonSerializable(createToJson: false)
class TourImage {
  final String? id;
  final int? width;
  final int? height;
  final String? url;
  final String? filename;
  final int? size;
  final String? type;
  final Thumbnails? thumbnails;

  TourImage({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
    required this.filename,
    required this.size,
    required this.type,
    required this.thumbnails,
  });

  factory TourImage.fromJson(Map<String, dynamic> json) {
    return _$TourImageFromJson(json);
  }
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

  factory Thumbnails.fromJson(Map<String, dynamic> json) {
    return _$ThumbnailsFromJson(json);
  }
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
  
  factory Thumbnail.fromJson(Map<String, dynamic> json) {
    return _$ThumbnailFromJson(json);
  }
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
  
  factory Audio.fromJson(Map<String, dynamic> json) {
    return _$AudioFromJson(json);
  }
}
 
