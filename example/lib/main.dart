import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:double_back_to_exit/double_back_to_exit.dart';

void main() {
  runApp(const MyApp());
}

// GoRouter configuration
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/details',
      name: 'details',
      builder: (context, state) => const DetailsPage(),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Double Back to Exit - GoRouter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

// ============================================
// HOME PAGE - Uses DoubleBackToExit
// ============================================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DoubleBackToExit(
      snackBarMessage: 'Presiona atrás de nuevo para salir',
      doubleBackDuration: const Duration(milliseconds: 2000),
      snackbarBackgroundColor: Colors.deepPurple.shade700,
      snackbarBehavior: SnackBarBehavior.floating,
      snackbarMargin: const EdgeInsets.all(16),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Home - GoRouter Demo'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Info Card
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Icon(
                        Icons.arrow_back_rounded,
                        size: 48,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'DoubleBackToExit + GoRouter',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Navega a otras pantallas y prueba el botón de retroceso.\n'
                        'El doble back solo funciona en la pantalla Home.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Navigation Section
              Text(
                'Navegar a:',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),

              // Details Button
              Card(
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.info_outline, color: Colors.white),
                  ),
                  title: const Text('Detalles'),
                  subtitle: const Text('context.push(\'/details\')'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/details'),
                ),
              ),

              const SizedBox(height: 8),

              // Settings Button
              Card(
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.orange,
                    child: Icon(Icons.settings, color: Colors.white),
                  ),
                  title: const Text('Configuración'),
                  subtitle: const Text('context.push(\'/settings\')'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/settings'),
                ),
              ),

              const SizedBox(height: 8),

              // Go (replace) Button
              Card(
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(Icons.swap_horiz, color: Colors.white),
                  ),
                  title: const Text('Ir a Detalles (go)'),
                  subtitle: const Text('context.go(\'/details\') - reemplaza'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.go('/details'),
                ),
              ),

              const SizedBox(height: 24),

              // Instructions
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.amber.shade800),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '¡Presiona el botón de retroceso ahora para probar el doble back!',
                        style: TextStyle(color: Colors.amber.shade900),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================
// DETAILS PAGE
// ============================================
class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        title: const Text('Detalles'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info_outline,
                size: 80,
                color: Colors.blue.shade700,
              ),
              const SizedBox(height: 24),
              Text(
                'Página de Detalles',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                'Esta página no tiene DoubleBackToExit.\n'
                'Presiona atrás para volver al Home.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey.shade600,
                    ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Pop'),
                  ),
                  const SizedBox(width: 16),
                  FilledButton.icon(
                    onPressed: () => context.go('/'),
                    icon: const Icon(Icons.home),
                    label: const Text('Go Home'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================
// SETTINGS PAGE
// ============================================
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade100,
        title: const Text('Configuración'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.settings,
                size: 80,
                color: Colors.orange.shade700,
              ),
              const SizedBox(height: 24),
              Text(
                'Página de Configuración',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                'Navega a múltiples niveles para probar\nel comportamiento del back stack.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey.shade600,
                    ),
              ),
              const SizedBox(height: 32),
              Column(
                children: [
                  FilledButton.icon(
                    onPressed: () => context.push('/details'),
                    icon: const Icon(Icons.add),
                    label: const Text('Push Detalles'),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Pop'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
