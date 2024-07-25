import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:managerment/theme/app_theme.dart';

class ProgressCart extends StatelessWidget {
  final Map item;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onRefresh;
  ProgressCart(
      {Key? key,
      required this.item,
      required this.onEdit,
      required this.onDelete,
      required this.onRefresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.parse(item['expiredAt']));
    String expiredAt = 'Expired At: $formattedDate';
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 3,
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 123, 0, 245),
                borderRadius: BorderRadius.circular(10)),
          ),
          Expanded(
            child: Container(
              height: 100,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color:
                      Get.isDarkMode ? ThemeColor.dark1 : ThemeColor.background,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 123, 0, 245),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Icon(
                      CupertinoIcons.doc_append,
                      color: ThemeColor.background
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          item['title'],
                          style: GoogleFonts.poppins(
                            color: Get.isDarkMode
                                ? ThemeColor.background
                                : ThemeColor.dark2,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          item['description'],
                          style: GoogleFonts.poppins(
                            color: Get.isDarkMode
                                ? ThemeColor.background
                                : ThemeColor.dark2,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          expiredAt,
                          style: GoogleFonts.poppins(
                            color: Get.isDarkMode
                                ? ThemeColor.background
                                : ThemeColor.dark2,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  PopupMenuButton(
                    onSelected: (value){
                      if(value == 'edit')
                      {
                        onRefresh();
                        onEdit();
                      }
                      else if(value == 'delete'){
                        onRefresh();
                        onDelete();
                      }
                    },
                    itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: Text("Edit"),
                        value: 'edit'
                      ),
                      PopupMenuItem(
                        child: Text("Delete"),
                        value: 'delete',
                      )
                    ];
                  })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
