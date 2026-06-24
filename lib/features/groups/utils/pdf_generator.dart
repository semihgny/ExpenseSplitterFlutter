import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import '../../calculations/models/debt.dart';
import '../../../core/localization/app_localizations.dart';

class PdfGenerator {
  /// Harcama sonuçlarını PDF olarak oluşturur ve cihazdaki geçici bir dosyaya kaydeder.
  /// Kaydedilen dosyanın yolunu [String] olarak döner.
  static Future<String> generateResultPdf({
    required String groupName,
    required double totalExpense,
    required List<Debt> optimizedDebts,
    required String Function(String id) getMemberName,
    required String currencyCode,
    required AppLocalizations loc,
  }) async {
    final appName = loc.translate('app_name');
    final fontRegular = await PdfGoogleFonts.robotoRegular();
    final fontBold = await PdfGoogleFonts.robotoBold();

    final pdf = pw.Document(
      theme: pw.ThemeData.withFont(
        base: fontRegular,
        bold: fontBold,
      ),
    );
    
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            // Header
            pw.Header(
              level: 0,
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('$appName ${loc.translate('pdf_report')}', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold, color: PdfColors.orange700)),
                  pw.Text('${loc.translate('pdf_group')}: $groupName', style: const pw.TextStyle(fontSize: 16, color: PdfColors.grey700)),
                ],
              ),
            ),
            
            pw.SizedBox(height: 20),
            
            // Total Expense
            pw.Container(
              padding: const pw.EdgeInsets.all(16),
              decoration: pw.BoxDecoration(
                color: PdfColors.grey100,
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
                border: pw.Border.all(color: PdfColors.grey300),
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('${loc.translate('share_msg_total_expense')}:', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                  pw.Text(
                    '${totalExpense.toStringAsFixed(2)} $currencyCode', 
                    style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, color: PdfColors.orange700)
                  ),
                ],
              ),
            ),
            
            pw.SizedBox(height: 30),
            
            // Debts Title
            pw.Text(loc.translate('who_pays_who'), style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 15),
            
            if (optimizedDebts.isEmpty)
              pw.Text(loc.translate('share_msg_no_debt'), style: const pw.TextStyle(fontSize: 14))
            else
              // Debts List
              pw.TableHelper.fromTextArray(
                context: context,
                border: pw.TableBorder.all(color: PdfColors.grey300),
                headerDecoration: const pw.BoxDecoration(color: PdfColors.grey200),
                headerHeight: 30,
                cellHeight: 30,
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                headers: <String>[loc.translate('sender_debtor'), loc.translate('receiver_creditor'), loc.translate('amount_title')],
                data: <List<String>>[
                  for (final debt in optimizedDebts)
                    <String>[
                      getMemberName(debt.fromMemberId),
                      getMemberName(debt.toMemberId),
                      '${debt.amount.toStringAsFixed(2)} $currencyCode',
                    ],
                ],
              ),
              
            pw.SizedBox(height: 40),
            pw.Divider(),
            pw.SizedBox(height: 10),
            pw.Center(
              child: pw.Text(
                '${loc.translate('pdf_created_with')} $appName ${loc.translate('pdf_created_with_2')}',
                style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey500),
              ),
            ),
          ];
        },
      ),
    );

    // Save to temp directory
    final output = await getTemporaryDirectory();
    // Replace spaces and invalid chars in filename
    final safeGroupName = groupName.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    final safeAppName = appName.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
    final file = File('${output.path}/${safeAppName}_${safeGroupName}_Raporu.pdf');
    await file.writeAsBytes(await pdf.save());
    
    return file.path;
  }
}
