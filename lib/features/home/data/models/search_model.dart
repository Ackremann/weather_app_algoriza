class SearchModel {
  dynamic id;
  String? name;
  String? region;
  String? country;
  dynamic lat;
  dynamic lon;
  String? url;

  SearchModel(
      {this.id,
      this.name,
      this.region,
      this.country,
      this.lat,
      this.lon,
      this.url});

  SearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    region = json['region'];
    country = json['country'];
    lat = json['lat'];
    lon = json['lon'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['region'] = this.region;
    data['country'] = this.country;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['url'] = this.url;
    return data;
  }
}
