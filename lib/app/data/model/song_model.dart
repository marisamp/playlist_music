import 'dart:convert';

class SongModel {
  int? resultCount;
  List<Song>? results;

  SongModel({this.resultCount, this.results});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'resultCount': resultCount,
      'results': results?.map((x) => x.toJson()).toList(),
    };
  }

  factory SongModel.fromJson(dynamic json) {
    Map<String, dynamic> data = (json is String) ? jsonDecode(json) : json;

    return SongModel(
      resultCount: int.tryParse(data["resultCount"].toString()),
      results: data["results"] != null
          ? List<Song>.from(data["results"].map((x) => Song.fromJson(x)))
          : [],
    );
  }
}

class Song {
  String? wrapperType, kind, artistName, collectionName, trackName;
  String? previewUrl, artworkUrl100, country, currency, primaryGenreName;
  int? artistId, collectionId, trackId, trackTimeMillis;
  double? collectionPrice, trackPrice;
  DateTime? releaseDate;

  Song({
    this.wrapperType, this.kind, this.artistId, this.collectionId, this.trackId,
    this.artistName, this.collectionName, this.trackName, this.previewUrl,
    this.artworkUrl100, this.collectionPrice, this.trackPrice, this.releaseDate,
    this.trackTimeMillis, this.country, this.currency, this.primaryGenreName,
  });

  
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'wrapperType': wrapperType,
      'kind': kind,
      'artistId': artistId,
      'collectionId': collectionId,
      'trackId': trackId,
      'artistName': artistName,
      'collectionName': collectionName,
      'trackName': trackName,
      'previewUrl': previewUrl,
      'artworkUrl100': artworkUrl100,
      'collectionPrice': collectionPrice,
      'trackPrice': trackPrice,
      'releaseDate': releaseDate?.toIso8601String(), 
      'trackTimeMillis': trackTimeMillis,
      'country': country,
      'currency': currency,
      'primaryGenreName': primaryGenreName,
    };
  }

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      wrapperType: json["wrapperType"]?.toString(),
      kind: json["kind"]?.toString(),
      artistName: json["artistName"]?.toString(),
      collectionName: json["collectionName"]?.toString(),
      trackName: json["trackName"]?.toString(),
      previewUrl: json["previewUrl"]?.toString(),
      artworkUrl100: json["artworkUrl100"]?.toString().replaceAll("100x100bb", "600x600bb"),
      artistId: int.tryParse(json["artistId"].toString()),
      collectionId: int.tryParse(json["collectionId"].toString()),
      trackId: int.tryParse(json["trackId"].toString()),
      trackTimeMillis: int.tryParse(json["trackTimeMillis"].toString()),
      collectionPrice: double.tryParse(json["collectionPrice"].toString()),
      trackPrice: double.tryParse(json["trackPrice"].toString()),
      releaseDate: json["releaseDate"] != null ? DateTime.tryParse(json["releaseDate"].toString()) : null,
      country: json["country"]?.toString(),
      currency: json["currency"]?.toString(),
      primaryGenreName: json["primaryGenreName"]?.toString(),
    );
  }
}