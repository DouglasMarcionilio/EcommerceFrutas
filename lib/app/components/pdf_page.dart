import 'package:ecommerce_frutas/app/components_controllers/sacola_controller.dart';
import 'package:ecommerce_frutas/app/modules/principal/principal_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

PdfPage pdfPage = PdfPage();

class PdfPage {
  pdfConfiguration() async {
    return pw.Page(
      build: (context) {
        return pw.Container(
          child: pw.Column(
            children: [
              pw.Row(
                children: [
                  pw.Expanded(
                    child: pw.Container(
                      color: PdfColor.fromInt(Colors.orange.shade100.value),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Center(
                          child: pw.Text(
                            'COMPROVANTE',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(8.0),
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Text(
                        'Itens',
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Text(
                          'Qtd',
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          'Total',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.ListView.builder(
                itemBuilder: (context, index) {
                  var li = principalController.listItensSacolas[index];
                  return pw.Padding(
                    padding: pw.EdgeInsets.all(8),
                    child: pw.Row(
                      children: [
                        pw.Expanded(
                          child: pw.Text(
                            li.produto.nomeProduto,
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Text(
                              li.qtd.toString(),
                            ),
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Align(
                            alignment: pw.Alignment.centerRight,
                            child: pw.Text(
                              'R\$${li.total.toStringAsFixed(2)}',
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: principalController.listItensSacolas.length,
              ),
              pw.Padding(
                padding: pw.EdgeInsets.all(8),
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Text(
                        'Valor total da compra:',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          'R\$${sacolaController.totalSacola.toStringAsFixed(2)}',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
