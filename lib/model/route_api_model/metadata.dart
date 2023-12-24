class Metadata {
  List<String>? datasourceNames;

  Metadata({this.datasourceNames});

  Metadata.fromJson(Map<String, dynamic> json) {
    datasourceNames = json['datasource_names'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['datasource_names'] = this.datasourceNames;
    return data;
  }
}
