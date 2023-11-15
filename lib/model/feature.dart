import 'package:atlas_do_camarao/model/geometry.dart';

class Feature {
  String? type;
  String? id;
  Geometry? geometry;
  String? geometryName;
  Properties? properties;
  List<double>? bbox;

  Feature(
      {this.type,
        this.id,
        this.geometry,
        this.geometryName,
        this.properties,
        this.bbox});

  Feature.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    geometry = json['geometry'] != null
        ? new Geometry.fromJson(json['geometry'])
        : null;
    geometryName = json['geometry_name'];
    properties = json['properties'] != null
        ? new Properties.fromJson(json['properties'])
        : null;
    bbox = json['bbox'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['id'] = this.id;
    if (this.geometry != null) {
      data['geometry'] = this.geometry!.toJson();
    }
    data['geometry_name'] = this.geometryName;
    if (this.properties != null) {
      data['properties'] = this.properties!.toJson();
    }
    data['bbox'] = this.bbox;
    return data;
  }
}

class Properties {
  String? nmFantasia;
  String? rzSocial;
  String? cnpj;
  String? ddd;
  String? telefone;
  String? email;
  String? uf;
  int? cdUf;
  String? nmRgimed;
  int? cdRgimed;
  String? nmRgint;
  int? cdRgint;
  String? nmMeso;
  int? cdMeso;
  String? nmMicro;
  int? cdMicro;
  String? munic;
  int? cdMunic;
  String? endereco;
  String? obs;
  String? validc;
  String? fonte;
  int? gidFornecedor;
  int? gidCategoria;

  Properties(
      {this.nmFantasia,
        this.rzSocial,
        this.cnpj,
        this.ddd,
        this.telefone,
        this.email,
        this.uf,
        this.cdUf,
        this.nmRgimed,
        this.cdRgimed,
        this.nmRgint,
        this.cdRgint,
        this.nmMeso,
        this.cdMeso,
        this.nmMicro,
        this.cdMicro,
        this.munic,
        this.cdMunic,
        this.endereco,
        this.obs,
        this.validc,
        this.fonte,
        this.gidFornecedor,
        this.gidCategoria});

  Properties.fromJson(Map<String, dynamic> json) {
    nmFantasia = json['nm_fantasia'];
    rzSocial = json['rz_social'];
    cnpj = json['cnpj'];
    ddd = json['ddd'];
    telefone = json['telefone'];
    email = json['email'];
    uf = json['uf'];
    cdUf = json['cd_uf'];
    nmRgimed = json['nm_rgimed'];
    cdRgimed = json['cd_rgimed'];
    nmRgint = json['nm_rgint'];
    cdRgint = json['cd_rgint'];
    nmMeso = json['nm_meso'];
    cdMeso = json['cd_meso'];
    nmMicro = json['nm_micro'];
    cdMicro = json['cd_micro'];
    munic = json['munic'];
    cdMunic = json['cd_munic'];
    endereco = json['endereco'];
    obs = json['obs'];
    validc = json['validc'];
    fonte = json['fonte'];
    gidFornecedor = json['gid_fornecedor'];
    gidCategoria = json['gid_categoria'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nm_fantasia'] = this.nmFantasia;
    data['rz_social'] = this.rzSocial;
    data['cnpj'] = this.cnpj;
    data['ddd'] = this.ddd;
    data['telefone'] = this.telefone;
    data['email'] = this.email;
    data['uf'] = this.uf;
    data['cd_uf'] = this.cdUf;
    data['nm_rgimed'] = this.nmRgimed;
    data['cd_rgimed'] = this.cdRgimed;
    data['nm_rgint'] = this.nmRgint;
    data['cd_rgint'] = this.cdRgint;
    data['nm_meso'] = this.nmMeso;
    data['cd_meso'] = this.cdMeso;
    data['nm_micro'] = this.nmMicro;
    data['cd_micro'] = this.cdMicro;
    data['munic'] = this.munic;
    data['cd_munic'] = this.cdMunic;
    data['endereco'] = this.endereco;
    data['obs'] = this.obs;
    data['validc'] = this.validc;
    data['fonte'] = this.fonte;
    data['gid_fornecedor'] = this.gidFornecedor;
    data['gid_categoria'] = this.gidCategoria;
    return data;
  }
}
