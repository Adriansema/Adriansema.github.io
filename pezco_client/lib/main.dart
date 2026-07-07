import 'package:flutter/material.dart';
import 'package:pezco_client/services/proyecciones_service.dart';
import 'package:provider/provider.dart';
import 'package:pezco_client/presentation/layout/layout.dart';
import 'package:pezco_client/services/api_service.dart';
import 'package:pezco_client/services/auth_service.dart';
import 'package:pezco_client/providers/auth_provider.dart';
import 'package:pezco_client/presentation/screens/login_screen.dart';

void main() {
  // Instancias únicas compartidas por toda la app
  final apiService = ApiService();
  final authService = AuthService(apiService);
  final authProvider = AuthProvider(authService);
  final proyeccionesService = ProyeccionesService(apiService);

  // Conectamos el 401 global con el logout automático del provider
  apiService.onUnauthorized = () {
    authProvider.forzarCierreSesionPorTokenInvalido();
  };

  runApp(MyApp(
    apiService: apiService,
    authProvider: authProvider,
    proyeccionesService: proyeccionesService,
  ));
}

class MyApp extends StatelessWidget {
  final ApiService apiService;
  final AuthProvider authProvider;
  final ProyeccionesService proyeccionesService;

  const MyApp({
    super.key,
    required this.apiService,
    required this.authProvider,
    required this.proyeccionesService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiService>.value(value: apiService),
        Provider<ProyeccionesService>.value(value: proyeccionesService),
        ChangeNotifierProvider<AuthProvider>.value(value: authProvider),
      ],
      child: MaterialApp(
        title: 'Pezco Client',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const AuthWrapper(),
      ),
    );
  }
}

/// Decide qué pantalla mostrar según el estado de autenticación
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void initState() {
    super.initState();
    // Al arrancar la app, intentamos restaurar la sesión desde el storage
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthProvider>().intentarRestaurarSesion();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    switch (authProvider.status) {
      case AuthStatus.desconocido:
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      case AuthStatus.autenticado:
        return const AppLayout();
      case AuthStatus.noAutenticado:
        return const LoginScreen();
    }
  }
}