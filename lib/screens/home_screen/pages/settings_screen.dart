import 'package:ffe_app/core/api/auth_service.dart';
import 'package:ffe_app/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final AuthService _authService;
  bool _isLoggingOut = false;

  @override
  void initState() {
    super.initState();
    _authService = AuthService();
  }

  Future<void> _showLogoutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _handleLogout();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleLogout() async {
    setState(() {
      _isLoggingOut = true;
    });

    try {
      await _authService.signOut();
      
      if (mounted) {
        // Navigate to sign in screen and clear all routes
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SignInScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Logout failed: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoggingOut = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Settings Title
            Text(
              'Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1745),
              ),
            ),
            const SizedBox(height: 20),
            
            // Settings Options Container
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildSettingsTile(
                    icon: Icons.person,
                    title: 'Profile',
                    subtitle: 'Manage your profile information',
                    onTap: () {
                      // Handle profile tap
                    },
                  ),
                  _buildDivider(),
                  _buildSettingsTile(
                    icon: Icons.notifications,
                    title: 'Notifications',
                    subtitle: 'Manage notification preferences',
                    onTap: () {
                      // Handle notifications tap
                    },
                  ),
                  _buildDivider(),
                  _buildSettingsTile(
                    icon: Icons.security,
                    title: 'Privacy & Security',
                    subtitle: 'Privacy and security settings',
                    onTap: () {
                      // Handle privacy tap
                    },
                  ),
                  _buildDivider(),
                  _buildSettingsTile(
                    icon: Icons.help,
                    title: 'Help & Support',
                    subtitle: 'Get help and support',
                    onTap: () {
                      // Handle help tap
                    },
                  ),
                ],
              ),
            ),
            
            const Spacer(),
            
            // Logout Button
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.shade300),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: _isLoggingOut ? null : _showLogoutDialog,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_isLoggingOut)
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                            ),
                          )
                        else
                          Icon(
                            Icons.logout,
                            color: Colors.red,
                            size: 20,
                          ),
                        const SizedBox(width: 8),
                        Text(
                          _isLoggingOut ? 'Logging out...' : 'Logout',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xFF1E1745).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: Color(0xFF1E1745),
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      color: Colors.grey[200],
      indent: 16,
      endIndent: 16,
    );
  }
}