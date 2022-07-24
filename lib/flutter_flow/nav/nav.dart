import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import '../flutter_flow_theme.dart';
import '../../backend/backend.dart';
import '../../auth/firebase_user_provider.dart';

import '../../index.dart';
import '../../main.dart';
import 'serialization_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  EZXSBetaFirebaseUser? initialUser;
  EZXSBetaFirebaseUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(EZXSBetaFirebaseUser newUser) {
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    if (notifyOnAuthChange) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, _) =>
          appStateNotifier.loggedIn ? NavBarPage() : LoginWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? NavBarPage() : LoginWidget(),
          routes: [
            FFRoute(
              name: 'dashboardGlobal',
              path: 'dashboardGlobal',
              builder: (context, params) => params.isEmpty
                  ? NavBarPage(initialPage: 'dashboardGlobal')
                  : DashboardGlobalWidget(),
            ),
            FFRoute(
              name: 'Venue',
              path: 'venue',
              builder: (context, params) => VenueWidget(),
            ),
            FFRoute(
              name: 'Production',
              path: 'production',
              builder: (context, params) => ProductionWidget(),
            ),
            FFRoute(
              name: 'PassesMenu',
              path: 'passesMenu',
              builder: (context, params) => params.isEmpty
                  ? NavBarPage(initialPage: 'PassesMenu')
                  : PassesMenuWidget(),
            ),
            FFRoute(
              name: 'Home',
              path: 'home',
              builder: (context, params) => HomeWidget(),
            ),
            FFRoute(
              name: 'Tonight',
              path: 'tonight',
              builder: (context, params) => params.isEmpty
                  ? NavBarPage(initialPage: 'Tonight')
                  : TonightWidget(),
            ),
            FFRoute(
              name: 'Profile',
              path: 'profile',
              builder: (context, params) => ProfileWidget(),
            ),
            FFRoute(
              name: 'ProfileSettings',
              path: 'profileSettings',
              builder: (context, params) => ProfileSettingsWidget(),
            ),
            FFRoute(
              name: 'ProfileSetting',
              path: 'profileSetting',
              builder: (context, params) => ProfileSettingWidget(),
            ),
            FFRoute(
              name: 'GetPass',
              path: 'getPass',
              builder: (context, params) => GetPassWidget(),
            ),
            FFRoute(
              name: 'PassGenerator',
              path: 'passGenerator',
              builder: (context, params) => PassGeneratorWidget(),
            ),
            FFRoute(
              name: 'TicketScanned',
              path: 'ticketScanned',
              builder: (context, params) => TicketScannedWidget(
                redeemTicket: params.getParam('redeemTicket', ParamType.String),
              ),
            ),
            FFRoute(
              name: 'ScannedHistory',
              path: 'scannedHistory',
              builder: (context, params) => ScannedHistoryWidget(),
            ),
            FFRoute(
              name: 'OnboardFlow',
              path: 'onboardFlow',
              builder: (context, params) => OnboardFlowWidget(),
            ),
            FFRoute(
              name: 'Login',
              path: 'login',
              builder: (context, params) => LoginWidget(),
            ),
            FFRoute(
              name: 'scanner',
              path: 'scanner',
              builder: (context, params) => ScannerWidget(),
            ),
            FFRoute(
              name: 'PasswordReset',
              path: 'passwordReset',
              builder: (context, params) => PasswordResetWidget(),
            ),
            FFRoute(
              name: 'BarCodeScanner',
              path: 'barCodeScanner',
              builder: (context, params) => BarCodeScannerWidget(),
            ),
            FFRoute(
              name: 'LoginCopy',
              path: 'loginCopy',
              builder: (context, params) => LoginCopyWidget(),
            ),
            FFRoute(
              name: 'LoggedIn',
              path: 'loggedIn',
              builder: (context, params) => LoggedInWidget(),
            ),
            FFRoute(
              name: 'UserSearch',
              path: 'userSearch',
              builder: (context, params) => UserSearchWidget(),
            ),
            FFRoute(
              name: 'OnboardStyle',
              path: 'onboardStyle',
              builder: (context, params) => OnboardStyleWidget(),
            ),
            FFRoute(
              name: 'UserSearch2',
              path: 'userSearch2',
              builder: (context, params) => UserSearch2Widget(),
            ),
            FFRoute(
              name: 'Users',
              path: 'users',
              builder: (context, params) => UsersWidget(),
            ),
            FFRoute(
              name: 'UserBase',
              path: 'userBase',
              builder: (context, params) => UserBaseWidget(),
            ),
            FFRoute(
              name: 'UserScanInfo',
              path: 'userScanInfo',
              builder: (context, params) => UserScanInfoWidget(),
            ),
            FFRoute(
              name: 'Venues',
              path: 'venues',
              builder: (context, params) => VenuesWidget(),
            ),
            FFRoute(
              name: 'ClientFeedback',
              path: 'clientFeedback',
              builder: (context, params) => ClientFeedbackWidget(),
            ),
            FFRoute(
              name: 'MembershipType',
              path: 'membershipType',
              builder: (context, params) => MembershipTypeWidget(),
            ),
            FFRoute(
              name: 'EventEditConfirm',
              path: 'eventEditConfirm',
              builder: (context, params) => EventEditConfirmWidget(),
            ),
            FFRoute(
              name: 'AdminUserOnboard',
              path: 'adminUserOnboard',
              builder: (context, params) => AdminUserOnboardWidget(),
            ),
            FFRoute(
              name: 'EventEditGlobal',
              path: 'eventEditGlobal',
              builder: (context, params) => EventEditGlobalWidget(),
            ),
            FFRoute(
              name: 'EventAnalytic',
              path: 'eventAnalytic',
              builder: (context, params) => EventAnalyticWidget(),
            ),
            FFRoute(
              name: 'EventsConcept',
              path: 'eventsConcept',
              builder: (context, params) => EventsConceptWidget(),
            ),
            FFRoute(
              name: 'EditEvent',
              path: 'editEvent',
              builder: (context, params) => EditEventWidget(),
            ),
            FFRoute(
              name: 'AdminSidePanel',
              path: 'adminSidePanel',
              builder: (context, params) => AdminSidePanelWidget(),
            ),
            FFRoute(
              name: 'NewEventPreview',
              path: 'newEventPreview',
              builder: (context, params) => NewEventPreviewWidget(),
            ),
            FFRoute(
              name: 'EventEdit2',
              path: 'eventEdit2',
              builder: (context, params) => EventEdit2Widget(),
            ),
            FFRoute(
              name: 'EventsCalendar',
              path: 'eventsCalendar',
              builder: (context, params) => EventsCalendarWidget(),
            ),
            FFRoute(
              name: 'EventDetails',
              path: 'eventDetails',
              builder: (context, params) => EventDetailsWidget(),
            ),
            FFRoute(
              name: 'ProductionAnalytic',
              path: 'productionAnalytic',
              builder: (context, params) => ProductionAnalyticWidget(),
            ),
            FFRoute(
              name: 'TicketHistory2',
              path: 'ticketHistory2',
              builder: (context, params) => TicketHistory2Widget(),
            ),
            FFRoute(
              name: 'MembershipType2',
              path: 'membershipType2',
              builder: (context, params) => MembershipType2Widget(),
            ),
            FFRoute(
              name: 'EditUserTicket',
              path: 'editUserTicket',
              builder: (context, params) => EditUserTicketWidget(),
            ),
            FFRoute(
              name: 'ChatPage',
              path: 'chatPage',
              asyncParams: {
                'chatUser': getDoc('users', UsersRecord.serializer),
              },
              builder: (context, params) => ChatPageWidget(
                chatUser: params.getParam('chatUser', ParamType.Document),
                chatRef: params.getParam(
                    'chatRef', ParamType.DocumentReference, 'chats'),
              ),
            ),
            FFRoute(
              name: 'Appbar',
              path: 'appbar',
              builder: (context, params) => AppbarWidget(),
            ),
            FFRoute(
              name: 'inviteuser',
              path: 'inviteuser',
              asyncParams: {
                'chat': getDoc('chats', ChatsRecord.serializer),
              },
              builder: (context, params) => InviteuserWidget(
                chat: params.getParam('chat', ParamType.Document),
              ),
            ),
            FFRoute(
              name: 'appn',
              path: 'appn',
              builder: (context, params) => AppnWidget(),
            ),
            FFRoute(
              name: 'AllChats',
              path: 'allChats',
              builder: (context, params) => params.isEmpty
                  ? NavBarPage(initialPage: 'AllChats')
                  : AllChatsWidget(),
            )
          ].map((r) => r.toRoute(appStateNotifier)).toList(),
        ).toRoute(appStateNotifier),
      ],
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> params = const <String, String>{},
    Map<String, String> queryParams = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              params: params,
              queryParams: queryParams,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> params = const <String, String>{},
    Map<String, String> queryParams = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              params: params,
              queryParams: queryParams,
              extra: extra,
            );
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState =>
      (routerDelegate.refreshListenable as AppStateNotifier);
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void setRedirectLocationIfUnset(String location) =>
      (routerDelegate.refreshListenable as AppStateNotifier)
          .updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(params)
    ..addAll(queryParams)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  bool get isEmpty => state.allParams.isEmpty;
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam(
    String paramName,
    ParamType type, [
    String? collectionName,
  ]) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam(param, type, collectionName);
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.location);
            return '/login';
          }
          return null;
        },
        pageBuilder: (context, state) {
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Container(
                  color: FlutterFlowTheme.of(context).lineColor,
                  child: Center(
                    child: Builder(
                      builder: (context) => Image.asset(
                        'assets/images/Artboard_1.png',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder: PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).transitionsBuilder,
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(
        hasTransition: true,
        transitionType: PageTransitionType.fade,
        duration: Duration(milliseconds: 0),
      );
}
