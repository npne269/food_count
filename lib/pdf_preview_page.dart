import 'package:flutter/material.dart';
import 'package:foodcount/colors.dart';
import 'package:foodcount/model/food_model.dart';
import 'package:foodcount/pdf_generator_page.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class PdfPreviewPage extends StatelessWidget {
  const PdfPreviewPage(
      {Key? key,
      required this.consumedModelList,
      required this.totalAmountList,
      required this.fullName})
      : super(key: key);

  final List<ConsumedModel> consumedModelList;
  final List<double> totalAmountList;
  final String fullName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PdfPreview(
        build: (format) => makePdf(
          consumedModelList,
          totalAmountList,
          fullName,
        ),
        allowPrinting: true,
        loadingWidget: const Center(child: Text("Loading pdf...")),
        pdfPreviewPageDecoration: const BoxDecoration(
          color: AppColors.bgColor,
        ),
        allowSharing: false,
        canChangePageFormat: false,
        canChangeOrientation: false,
        canDebug: false,
        initialPageFormat: PdfPageFormat.a3,
        // maxPageWidth: 600,
      ),
    );
  }
}
