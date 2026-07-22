import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pezco_client/core/app_color.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _correoController = TextEditingController();
  final _contrasenaController = TextEditingController();

  bool _ocultarContrasena = true;

  @override
  void dispose() {
    _correoController.dispose();
    _contrasenaController.dispose();
    super.dispose();
  }

  String? _validarCorreo(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Ingresa tu correo electrónico';
    }
    final regexCorreo = RegExp(r'^[\w.\-]+@([\w\-]+\.)+[\w\-]{2,4}$');
    if (!regexCorreo.hasMatch(value.trim())) {
      return 'Ingresa un correo válido';
    }
    return null;
  }

  String? _validarContrasena(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingresa tu contraseña';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  Future<void> _handleLogin() async {
    // Valida formato antes de siquiera llamar a la API
    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AuthProvider>();

    final exito = await authProvider.login(
      _correoController.text.trim(),
      _contrasenaController.text,
    );

    if (!exito && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.errorMensaje ?? 'Error al iniciar sesión'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
    // Si exito == true, no hacemos nada aquí:
    // AuthWrapper detecta el cambio de estado y navega solo al AppLayout
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fondo_login.png'),
            fit: BoxFit.cover, // cubre toda la pantalla
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SingleChildScrollView(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.all(30),
                  height: (MediaQuery.of(context).size.height * 0.75).clamp(
                    500,
                    double.infinity,
                  ),
                  width: 460,
                  decoration: BoxDecoration(
                    color: const Color(0x25FFFFFF), // el "vidrio"
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                    border: Border.all(
                      color: const Color(0x2BFFFFFF),
                      width: 1.5,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      height: 400,
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Icon(
                                Icons.water,
                                size: 64,
                                color: colorScheme.primary,
                              ),
                              const Expanded(child: SizedBox(height: 16)),
                              Text(
                                'Login',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headlineMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const Expanded(child: SizedBox(height: 16)),
                    
                              TextFormField(
                                controller: _correoController,
                                enabled: !authProvider.isLoading,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  labelText: 'Correo electrónico',
                                  prefixIcon: Icon(Icons.email_outlined),
                                  border: OutlineInputBorder(),
                                ),
                                validator: _validarCorreo,
                              ),
                              const SizedBox(height: 16),
                    
                              TextFormField(
                                controller: _contrasenaController,
                                enabled: !authProvider.isLoading,
                                obscureText: _ocultarContrasena,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (_) => _handleLogin(),
                                decoration: InputDecoration(
                                  labelText: 'Contraseña',
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  border: const OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _ocultarContrasena
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                    ),
                                    onPressed: () {
                                      setState(
                                        () => _ocultarContrasena =
                                            !_ocultarContrasena,
                                      );
                                    },
                                  ),
                                ),
                                validator: _validarContrasena,
                              ),
                              const SizedBox(height: 24),
                    
                              FilledButton(
                                onPressed: authProvider.isLoading
                                    ? null
                                    : _handleLogin,
                                style: FilledButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                ),
                                child: authProvider.isLoading
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text('Iniciar sesión'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
