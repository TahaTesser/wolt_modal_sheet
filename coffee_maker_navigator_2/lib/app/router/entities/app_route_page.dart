import 'package:coffee_maker_navigator_2/features/add_water/ui/view/add_water_screen.dart';
import 'package:coffee_maker_navigator_2/features/orders/domain/entities/coffee_maker_step.dart';
import 'package:coffee_maker_navigator_2/features/tutorial/view/single_tutorial_screen.dart';
import 'package:coffee_maker_navigator_2/features/tutorial/view/tutorials_screen.dart';
import 'package:coffee_maker_navigator_2/features/login/ui/view/login_screen.dart';
import 'package:coffee_maker_navigator_2/features/onboarding/ui/view/onboarding_modal_sheet_page.dart';
import 'package:coffee_maker_navigator_2/features/orders/ui/view/modal_pages/grind/grind_or_reject_modal_page.dart';
import 'package:coffee_maker_navigator_2/features/orders/ui/view/modal_pages/grind/reject_order_modal_page.dart';
import 'package:coffee_maker_navigator_2/features/orders/ui/view/orders_screen.dart';
import 'package:coffee_maker_navigator_2/app/router/entities/app_route_settings_name.dart';
import 'package:coffee_maker_navigator_2/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

sealed class AppRoutePage<T> extends Page<T> {
  const AppRoutePage({LocalKey? key}) : super(key: key);
}

class AuthRoutePage extends AppRoutePage<void> {
  @override
  String get name => RouteSettingsName.auth.routeName;

  const AuthRoutePage() : super(key: const ValueKey('AuthRoutePage'));

  @override
  Route<void> createRoute(BuildContext context) {
    return MaterialPageRoute<void>(
      builder: (context) => const LoginScreen(),
      settings: this,
    );
  }
}

class OrdersRoutePage extends AppRoutePage<void> {
  @override
  String get name => RouteSettingsName.orders.routeName;

  const OrdersRoutePage() : super(key: const ValueKey('OrdersRoutePage'));

  @override
  Route<void> createRoute(BuildContext context) {
    return MaterialPageRoute<void>(
      builder: (context) => const OrdersScreen(),
      settings: this,
    );
  }
}

class AddWaterRoutePage extends AppRoutePage<void> {
  @override
  String get name => RouteSettingsName.addWater.routeName;

  AddWaterRoutePage(this.coffeeOrderId) : super(key: ValueKey(coffeeOrderId));

  final String coffeeOrderId;

  @override
  Route<void> createRoute(BuildContext context) {
    return MaterialPageRoute<void>(
      builder: (context) {
        return AddWaterScreen(coffeeOrderId: coffeeOrderId);
      },
      settings: this,
    );
  }
}

class SingleTutorialRoutePage extends AppRoutePage<void> {
  @override
  String get name => RouteSettingsName.singleTutorial.routeName;

  SingleTutorialRoutePage(this.coffeeMakerStep)
      : super(key: ValueKey(coffeeMakerStep));

  final CoffeeMakerStep coffeeMakerStep;

  @override
  Route<void> createRoute(BuildContext context) {
    return MaterialPageRoute<void>(
      builder: (context) =>
          SingleTutorialScreen(coffeeMakerStep: coffeeMakerStep),
      settings: this,
    );
  }
}

class TutorialsRoutePage extends AppRoutePage<void> {
  @override
  String get name => RouteSettingsName.tutorials.routeName;

  const TutorialsRoutePage() : super(key: const ValueKey('TutorialsRoutePage'));

  @override
  Route<void> createRoute(BuildContext context) {
    return MaterialPageRoute<void>(
      builder: (context) => const TutorialsScreen(),
      settings: this,
    );
  }
}

class OnboardingModalRoutePage extends AppRoutePage<void> {
  @override
  String get name => RouteSettingsName.onboarding.routeName;

  const OnboardingModalRoutePage()
      : super(key: const ValueKey('OnboardingRoutePage'));

  @override
  Route<void> createRoute(BuildContext context) {
    return WoltModalSheetRoute(
      settings: this,
      pageListBuilderNotifier: ValueNotifier(
        (context) => [OnboardingModalSheetPage()],
      ),
      onModalDismissedWithDrag:
          context.routerViewModel.onCloseOnboardingModalSheet,
      onModalDismissedWithBarrierTap:
          context.routerViewModel.onCloseOnboardingModalSheet,
    );
  }
}

class GrindCoffeeModalRoutePage extends AppRoutePage<void> {
  @override
  String get name => RouteSettingsName.onboarding.routeName;

  final String coffeeOrderId;
  final OnCoffeeOrderStatusChange onCoffeeOrderStatusChange;

  GrindCoffeeModalRoutePage(
    this.coffeeOrderId,
    this.onCoffeeOrderStatusChange,
  ) : super(key: ValueKey('GrindCoffeeModalRoutePage-$coffeeOrderId'));

  @override
  Route<void> createRoute(BuildContext context) {
    return WoltModalSheetRoute(
      settings: this,
      pageListBuilderNotifier: ValueNotifier(
        (context) => [
          GrindOrRejectModalPage(coffeeOrderId, onCoffeeOrderStatusChange),
          RejectOrderModalPage(coffeeOrderId, onCoffeeOrderStatusChange),
        ],
      ),
    );
  }
}