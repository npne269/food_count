import 'package:flutter/material.dart';
import 'package:foodcount/colors.dart';
import 'package:foodcount/model/food_model.dart';
import 'package:foodcount/pdf_preview_page.dart';
import 'package:foodcount/widget/info_card.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key, required this.consumedList});

  final List<ConsumedModel> consumedList;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List<double> getTotalComponent(List<ConsumedModel> l) {
    double energy = 0.0;
    double protein = 0.0;

    double carbohydrate = 0.0;
    double fat = 0.0;

    double iron = 0.0;
    double carotene = 0.0;
    double vitaminC = 0.0;

    for (var element in l) {
      energy += element.foodEat!.components.getItems(element.amount)[0];
      protein += element.foodEat!.components.getItems(element.amount)[1];
      carbohydrate += element.foodEat!.components.getItems(element.amount)[2];
      fat += element.foodEat!.components.getItems(element.amount)[3];
      iron += element.foodEat!.components.getItems(element.amount)[4];
      carotene += element.foodEat!.components.getItems(element.amount)[5];
      vitaminC += element.foodEat!.components.getItems(element.amount)[6];
    }

    return [
      energy,
      protein,
      carbohydrate,
      fat,
      iron,
      carotene,
      vitaminC,
    ];
  }

  // Future<Uint8List> makePdf(
  //     List<ConsumedModel> model, List<double> total) async {
  //   final pdf = pw.Document();
  //   pdf.addPage(pw.Page(build: (context) {
  //     return pw.Column(children: const []);
  //   }));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        foregroundColor: Colors.black,
        backgroundColor: AppColors.bgColor,
        title: const Text("Result"),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                showBottomSheet(
                    context: context,
                    // isScrollControlled: ,
                    builder: (context) {
                      final formKey = GlobalKey<FormState>();
                      final controller = TextEditingController();
                      return Container(
                        padding: const EdgeInsets.all(23.0),
                        decoration: const BoxDecoration(
                          color: AppColors.bgColor,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(
                              10.0,
                            ),
                          ),
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: controller,
                                decoration: const InputDecoration(
                                  hintText: "Enter Your Full Name",
                                ),
                                validator: (v) {
                                  if (v!.isEmpty) {
                                    return "Please Specify Your Full Name";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => PdfPreviewPage(
                                          consumedModelList:
                                              widget.consumedList,
                                          totalAmountList: getTotalComponent(
                                            widget.consumedList,
                                          ),
                                          fullName: controller.text,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: const Text("Generate PDF"),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
              icon: const Icon(
                Icons.download,
                color: AppColors.primary,
              ),
            );
          }),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 23),
        itemCount: widget.consumedList.length + 1,
        separatorBuilder: (context, index) => const SizedBox(
          height: 10.0,
        ),
        itemBuilder: (context, index) {
          if (index < widget.consumedList.length) {
            ConsumedModel c = widget.consumedList[index];

            return InfoCard(
              title: c.foodEat?.name ?? "",
              data: c.foodEat?.components.getItems(c.amount),
            );
          }
          return InfoCard(
            title: "",
            data: getTotalComponent(widget.consumedList),
          );
        },
      ),
    );
  }
}
