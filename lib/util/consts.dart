import 'package:flutter/material.dart';

class Consts {
  static List<Map<String, Object>> groupLayers = [
    {
      'id': 'g2',
      'name': 'Produção Municipal',
      'layers': [
        {
          'label': '2013',
          'name': 'cite:prod2.mun.13_21',
          'checked': false,
          'style': 'prod munic 2013',
        },
        {
          'label': '2014',
          'name': 'cite:prod2.mun.13_21',
          'checked': false,
          'style': 'prod munic 2014',
        },
        {
          'label': '2015',
          'name': 'cite:prod2.mun.13_21',
          'checked': false,
          'style': 'prod munic 2015',
        },
        {
          'label': '2016',
          'name': 'cite:prod2.mun.13_21',
          'checked': false,
          'style': 'prod munic 2016',
        },
        {
          'label': '2017',
          'name': 'cite:prod2.mun.13_21',
          'checked': false,
          'style': 'prod munic 2017',
        },
        {
          'label': '2018',
          'name': 'cite:prod2.mun.13_21',
          'checked': false,
          'style': 'prod munic 2018',
        },
        {
          'label': '2019',
          'name': 'cite:prod2.mun.13_21',
          'checked': false,
          'style': 'prod munic 2019',
        },
        {
          'label': '2020',
          'name': 'cite:prod2.mun.13_21',
          'checked': false,
          'style': 'prod munic 2020',
        },
        {
          'label': '2021',
          'name': 'cite:prod2.mun.13_21',
          'checked': false,
          'style': 'prod munic 2021',
        },
      ],
    },
    {
      'id': 'g4',
      'name': 'Infraestrutura',
      'layers': [
        {
          'label': 'Energética',
          'name': 'cite:tudo',
          'checked': false,
          'style': 'estilo med_energia',
        },
        {
          'label': 'Portuária',
          'name': 'cite:tudo',
          'checked': false,
          'style': 'estilo med_portos',
        },
        {
          'label': 'Beneficiamento',
          'name': 'cite:tudo',
          'checked': false,
          'style': 'estilo med_unid_benef',
        },
        {
          'label': 'Viária',
          'name': 'cite:tudo',
          'checked': false,
          'style': 'estilo med_inf_viaria',
        },
        {
          'label': 'Indicador de infraestrutura para carcinicultura',
          'name': 'cite:iia',
          'checked': false,
          'style': 'estilo med_iaa',
        },
      ],
    },
    {
      'id': 'g3',
      'name': 'Cadeia de Insumos',
      'layers': [
        {
          'label': 'Equipamentos para aquicultura',
          'name': 'cite:tudo',
          'checked': false,
          'style': 'estilo med_equipamento',
        },
        {
          'label': 'Fábricas de gelo',
          'name': 'cite:tudo',
          'checked': false,
          'style': 'estilo med_gelo',
        },
        {
          'label': 'Laboratórios de pós-larvas',
          'name': 'cite:tudo',
          'checked': false,
          'style': 'estilo med_larvas',
        },
        {
          'label': 'Produtos de sanidade aquícola',
          'name': 'cite:tudo',
          'checked': false,
          'style': 'estilo med_prod_sani',
        },
        {
          'label': 'Fábricas de ração',
          'name': 'cite:tudo',
          'checked': false,
          'style': 'estilo med_racao',
        },
        {
          'label': 'Cadeia de insumos para carcinicultura',
          'name': 'cite:ici',
          'checked': false,
          'style': 'estilo med_ici',
        },
      ],
    },
    {
      'id': 'g1',
      'name': 'Unidades produtivas',
      'layers': [
        {
          'label': 'Polos produtivos',
          'name': 'atlas:polos',
          'checked': false,
          'style': 'polos',
        },
        {
          'label': 'Fazendas de cultivo',
          'name': 'atlas:fazendas_de_cultivo',
          'checked': false,
        },
      ],
    },
    {
      'id': 'g5',
      'name': 'Serviços e Produtos',
      'layers': [
        {
          'cod':1,
          'label': 'Associação de Aquicultores',
          'name': 'cite:servico',
          'checked': false,
          'style': 'estilo associacoes_aquicultores',
        },
        {
          'cod':2,
          'label': 'Comercialização de Pescados',
          'name': 'cite:servico',
          'checked': false,
          'style': 'estilo comercializacao_pescados',
        },
        {
          'cod':3,
          'label': 'Consultoria em Aquicultura',
          'name': 'cite:servico',
          'checked': false,
          'style': 'estilo consultoria_aquicultura',
        },
        {
          'cod':4,
          'label': 'Produção de Sanidade Aquícola',
          'name': 'cite:servico',
          'checked': false,
          'style': 'estilo producao_sanidade_aquicola',
        },
        {
          'cod':5,
          'label': 'Venda de Equipamentos Aquícolas',
          'name': 'cite:servico',
          'checked': false,
          'style': 'estilo venda_equipamentos_aquicolas',
        },
        {
          'cod':6,
          'label': 'Fábrica de Gelo',
          'name': 'cite:servico',
          'checked': false,
          'style': 'estilo fabricas_gelo',
        },
        {
          'cod':7,
          'label': 'Curso / Instituição de Ensino',
          'name': 'cite:servico',
          'checked': false,
          'style': 'estilo curso_instituicao_ensino',
        },
        {
          'cod':8,
          'label': 'Laboratório de Formas Jovens',
          'name': 'cite:servico',
          'checked': false,
          'style': 'estilo laboratorio_formas_jovens',
        },
        {
          'cod':9,
          'label': 'Unidade de Beneficiamento de Pescados',
          'name': 'cite:servico',
          'checked': false,
          'style': 'estilo unidade_beneficiamento_pescados',
        },
      ],
    },
  ];

  //Vetor de Images para o Popup
  static List<Widget> lImages = [
    Image.asset(
      "assets/images/MarkerBlue.png",
      width: 15,
    ),
    Image.asset(
      "assets/images/MarkerBrown.png",
      width: 15,
    ),
    Image.asset(
      "assets/images/MarkerCyan.png",
      width: 15,
    ),
    Image.asset(
      "assets/images/MarkerRed.png",
      width: 15,
    ),
    Image.asset(
      "assets/images/MarkerYellow.png",
      width: 15,
    ),
    Image.asset(
      "assets/images/MarkerPink.png",
      width: 15,
    ),
    Image.asset(
      "assets/images/MarkerDeepOrange.png",
      width: 15,
    ),
    Image.asset(
      "assets/images/MarkerPurple.png",
      width: 15,
    ),
    Image.asset(
      "assets/images/MarkerTeal.png",
      width: 15,
    ),
  ];
}
