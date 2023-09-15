import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../consts/theme_data.dart';
import '../providers/theme_provider.dart';
import '../services/assets_manager.dart';
import '../widgets/products/product_widget.dart';
import '../widgets/title_text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              AssetsManager.shoppingCart,
            ),
          ),
          title: const TitlesTextWidget(label: "Search Products"),
          systemOverlayStyle: statusBarTheme(themeProvider),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: GestureDetector(
                      onTap: () {
                        _searchController.clear();
                        FocusScope.of(context).unfocus();
                      },
                      child: const Icon(Icons.clear)),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
                onChanged: (value) {
                  ///
                },
                onSubmitted: (value) {
                  ///
                },
              ),
              const SizedBox(
                height: 15.0,
              ),
              Expanded(
                child: DynamicHeightGridView(
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    builder: (context, index) {
                      return const ProductWidget();
                    },
                    itemCount: 20,
                    crossAxisCount: 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
