class Data {
  String url;
  String title;
  String option;
  double lat;
  double lon;
  int id;
  int area;
  double density;
  String category;

  Data(
      {this.url,
        this.title,
        this.option,
        this.id,
        this.lat,
        this.lon,
        this.area,
        this.density,
        this.category});

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "url": url,
      "option": option,
      "lat": lat,
      "lon": lon,
      "area": area,
      "density": density,
      "category": category
    };
  }
}