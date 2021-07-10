import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow/modules/insert_boleto/insert_boleto_controller.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/input_text/input_text_widget.dart';
import 'package:payflow/shared/widgets/set_label_buttons/set_label_buttons.dart';

class InsertBoletoPage extends StatefulWidget {
  final String? barcode;
  const InsertBoletoPage({
    Key? key,
    this.barcode,
  }) : super(key: key);

  @override
  _InsertBoletoPageState createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  final controller = InsertBoletoController();

  static final moneyInputTextController = MoneyMaskedTextController(
    leftSymbol: "R\$",
    decimalSeparator: ",",
  );
  static final vencimentoInputTextController = MaskedTextController(
    mask: "00/00/0000",
  );
  static final barcodeInputTextController = TextEditingController();

  @override
  void initState() {
    if (widget.barcode != null) {
      barcodeInputTextController.text = widget.barcode!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: BackButton(
          color: AppColors.input,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 93,
                ),
                child: Text(
                  "Preencha os dados do boleto",
                  style: AppTextStyles.titleBoldHeading,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      InputTextWidget(
                        label: "Nome do boleto",
                        validator: controller.validateName,
                        icon: Icons.description_outlined,
                        onChaged: (value) {
                          controller.onChange(nome: value);
                        },
                      ),
                      InputTextWidget(
                        controller: vencimentoInputTextController,
                        label: "Vencimento",
                        validator: controller.validateVencimento,
                        icon: FontAwesomeIcons.timesCircle,
                        onChaged: (value) {
                          controller.onChange(dataVencimento: value);
                        },
                      ),
                      InputTextWidget(
                        controller: moneyInputTextController,
                        label: "Valor",
                        validator: (_) => controller.validateValor(
                            moneyInputTextController.numberValue),
                        icon: FontAwesomeIcons.wallet,
                        onChaged: (value) {
                          controller.onChange(
                              valor: moneyInputTextController.numberValue);
                        },
                      ),
                      InputTextWidget(
                        controller: barcodeInputTextController,
                        label: "Código",
                        validator: controller.validateCodigo,
                        icon: FontAwesomeIcons.barcode,
                        onChaged: (value) {
                          controller.onChange(barcode: value);
                        },
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: SetLabelButtons(
        primaryLabel: "Cancelar",
        primaryOnPressed: () {
          Navigator.pop(context);
        },
        secondaryLabel: "Cadastrar",
        secondaryOnPressed: () async {
          await controller.cadastrarBoleto();
          Navigator.pop(context);
        },
        enableSecondaryColor: true,
      ),
    );
  }
}
