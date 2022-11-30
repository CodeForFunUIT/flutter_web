import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_web_electronic_components/helpers/responsiveness.dart';
import 'package:flutter_web_electronic_components/models/product.dart';
import 'package:flutter_web_electronic_components/widgets/large_screen.dart';
import 'package:flutter_web_electronic_components/widgets/small_screen.dart';
import 'package:image_network/image_network.dart';

class SiteLayout extends StatelessWidget {
  SiteLayout({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      key: scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 112,
        leadingWidth: 0,
        title: Row(
          children: [
            InkWell(
              onTap: () {},
              onHover: (isHover) {},
              child: const Icon(Icons.menu),
            ),
            Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.fill,
              width: 200,
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: TypeAheadField<Product>(
                  hideSuggestionsOnKeyboardHide: true,
                  keepSuggestionsOnLoading: false,
                  textFieldConfiguration: const TextFieldConfiguration(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      hintText: 'Tìm kiếm sản phẩm...',
                    ),
                  ),
                  suggestionsCallback: (string) async {
                    List<Product> list = [
                      Product(
                        name: 'a',
                        price: '10',
                        image:
                            'https://tmpfluttermysql.000webhostapp.com/image/ram/Ram%20Crucial%20DDR5%208GB%20Bus%204800MHz%20CL40%20CT8G48C40S5.jpg',
                      ),
                      Product(
                        name: 'b',
                        price: '10',
                        image:
                            'https://tmpfluttermysql.000webhostapp.com/image/ram/Ram%20Crucial%20DDR5%208GB%20Bus%204800MHz%20CL40%20CT8G48C40S5.jpg',
                      )
                    ];
                    list = list
                        .where((e) => e.name?.contains(string) ?? false)
                        .toList();
                    return list;
                  },
                  itemBuilder: (context, product) {
                    return ListTile(
                      title: Text(product.name ?? ''),
                      subtitle: Text(
                        '${product.price} đ',
                      ),
                      trailing: SizedBox(
                        height: 50,
                        width: 50,
                        child: ImageNetwork(
                          image: product.image ?? '',
                          height: 50,
                          width: 50,
                          fitWeb: BoxFitWeb.fill,
                        ),
                      ),
                    );
                  },
                  onSuggestionSelected: (product) {},
                ),
              ),
            ),
          ],
        ),
      ),
      body: const ResponsiveWidget(
        largeScreen: LargeScreen(),
        smallScreen: SmallScreen(),
      ),
    );
  }
}
