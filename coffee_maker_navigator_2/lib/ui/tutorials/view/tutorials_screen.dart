import 'package:coffee_maker_navigator_2/domain/orders/entities/coffee_maker_step.dart';
import 'package:coffee_maker_navigator_2/ui/router/view_model/router_view_model.dart';
import 'package:demo_ui_components/demo_ui_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_navigation_drawer.dart';

class TutorialsScreen extends StatelessWidget {
  const TutorialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SystemUIAnnotationWrapper(
      child: Scaffold(
        body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    const Stack(
                      children: [
                        SizedBox(height: 200),
                        Image(
                          height: 200,
                          width: double.infinity,
                          image: AssetImage(
                              'lib/assets/images/welcome_modal.webp'),
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              '''
We're excited to assist you with the orders. To ensure you get the most out of our app, we've prepared a brief tutorial that will guide you through the features and functionalities available.
\nLet's begin your journey to quick and easy coffee order fulfillment!
''',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            WoltSelectionList<CoffeeMakerStep>.singleSelect(
                              itemTileDataGroup:
                                  const WoltSelectionListItemDataGroup(
                                group: [
                                  WoltSelectionListItemData(
                                    title: 'Coffee grinding',
                                    value: CoffeeMakerStep.grind,
                                    isSelected: false,
                                  ),
                                  WoltSelectionListItemData(
                                    title: 'Adding water to coffee',
                                    value: CoffeeMakerStep.addWater,
                                    isSelected: false,
                                  ),
                                  WoltSelectionListItemData(
                                    title: 'Serving coffee',
                                    value: CoffeeMakerStep.ready,
                                    isSelected: false,
                                  ),
                                ],
                              ),
                              onSelectionUpdateInSingleSelectionList: (item) {
                                context
                                    .read<RouterViewModel>()
                                    .onTutorialDetailSelected(item.value);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: SafeArea(
                      child: DrawerMenuButton(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        drawer: const AppNavigationDrawer(selectedIndex: 1),
      ),
    );
  }
}
