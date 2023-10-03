
import 'package:exp_app/models/features_model.dart';
import 'package:exp_app/utils/constants.dart';
import 'package:exp_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/combined_model.dart';
import '../../providers/expenses_provider.dart';
import '../widgets.dart';
import 'admin_category.dart';

class BSCategory extends StatefulWidget {
  final CombinedModel cModel;
  const BSCategory({required this.cModel, super.key});

  @override
  State<BSCategory> createState() => _BSCategoryState();
}

class _BSCategoryState extends State<BSCategory> {
  var catList = CategoryList().catList;
  final FeaturesModel fModel = FeaturesModel();

@override
void initState(){
  var exProvider = context.read<ExpensesProvider>();

  if(exProvider.data.isEmpty){
    for (FeaturesModel e in catList){
      exProvider.addNewFeatures(e);
    }
  }
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    final featureList = context.watch<ExpensesProvider>().data;
    bool hasData = false;

    if(widget.cModel.category!="Selecciona Categoría") {hasData=true;}


    return GestureDetector(
      onTap: (){
        categorySelected(featureList);
      },
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children:[
             Icon(
              (hasData)? widget.cModel.icon.toIcon()
              :Icons.category_outlined,
               size:35),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.7,
                    color: 
                    (hasData)?
                    widget.cModel.color.toColor()
                    :Theme.of(context).dividerColor),
                  borderRadius:BorderRadius.circular(30.0)
                ),
                child: Center(
                  child: Text(widget.cModel.category)
                )
              ),
            )
          ]
        ),
      ),
    );
  }

  categorySelected(List<FeaturesModel> features){
    

  void itemSelected(String category,String color, String icon, int link){
    setState(() {
      widget.cModel.link = link;
      widget.cModel.category = category;
      widget.cModel.color = color;
      widget.cModel.icon = icon;
      Navigator.pop(context);
    });

  }

    var widgets = [
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: features.length,
        itemBuilder: (_,i){
          var item = features[i];
          return ListTile(
            onTap: (){
              itemSelected(
              item.category,
              item.color,
              item.icon, item.id!);
            },
            trailing: const Icon(Icons.arrow_forward_ios, size:18),
            leading: Icon(
              item.icon.toIcon(), 
              color: item.color.toColor(),size: 35,),
            title: Text(item.category),

          );
        }),
        const Divider(thickness: 2.0,),
        ListTile(
          leading: const Icon(Icons.create_new_folder_outlined, size:35),
          title: const Text("Crear nueva categoría"),
          trailing: const Icon(Icons.arrow_forward_ios_outlined, size:18),
          onTap: (){
            Navigator.pop(context);
            createNewCategory();
          },
        ),
         ListTile(
          leading: const Icon(Icons.edit_outlined, size:35),
          title: const Text("Administrar categoría"),
          trailing: const Icon(Icons.arrow_forward_ios_outlined, size:18),
          onTap: (){
            Navigator.pop(context);
            adminCategory();
          },
        )
    ];
    showModalBottomSheet(
    isScrollControlled: true,
    shape: Constants.bottomSheet(),
    context: context, 
    builder: (context){
    return SizedBox(
      height: MediaQuery.of(context).size.height/1.5,
      child: ListView(
        children: widgets,
      )
    );
    });
  }

  createNewCategory(){
    var features = FeaturesModel(
      id: fModel.id,
      category:fModel.category,
      color:fModel.color,
      icon:fModel.icon
    );
    showModalBottomSheet(
      shape: Constants.bottomSheet(),
      isScrollControlled: true,
      isDismissible: false,
      context: context, 
      builder: (context){
      return  CreateCategory(fModel: features,);
    });
  }
adminCategory(){
    showModalBottomSheet(
      shape: Constants.bottomSheet(),
      isDismissible: false,
      context: context, 
      builder: (context){
      return const AdminCategory();
    });
  }

}