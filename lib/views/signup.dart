import 'package:flutter/material.dart';
import 'package:philippines_rpcmb/philippines_rpcmb.dart';
import 'package:shopping_app/models/user.dart';
import '../services/auth_service.dart';
import '../widgets/forms.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _reenterPasswordController = TextEditingController();

  Region? _selectedRegion;
  Province? _selectedProvince;
  Municipality? _selectedMunicipality;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _reenterPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Create Account',
          style: TextStyle(fontSize: 16, color: colorScheme.onSurface),
        ),
        backgroundColor: colorScheme.surface,
        elevation: 0,
        foregroundColor: colorScheme.onSurface,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Image.asset(
                      'lib/assets/images/logo.png',
                      height: 80,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Embedix',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'CREATE ACCOUNT',
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.onSurface.withOpacity(0.6),
                      letterSpacing: 2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: _firstNameController,
                          labelText: 'First Name',
                          validator: (value) => value == null || value.isEmpty
                              ? 'Required'
                              : null,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomTextField(
                          controller: _lastNameController,
                          labelText: 'Last Name',
                          validator: (value) => value == null || value.isEmpty
                              ? 'Required'
                              : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _usernameController,
                    labelText: 'Username',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  CustomDropdownWrapper(
                    child: PhilippineRegionDropdownView(
                      value: _selectedRegion,
                      onChanged: (Region? region) {
                        setState(() {
                          if (_selectedRegion != region) {
                            _selectedProvince = null;
                            _selectedMunicipality = null;
                          }
                          _selectedRegion = region;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 16),
                  CustomDropdownWrapper(
                    child: PhilippineProvinceDropdownView(
                      provinces: _selectedRegion?.provinces ?? [],
                      value: _selectedProvince,
                      onChanged: (Province? province) {
                        setState(() {
                          if (_selectedProvince != province) {
                            _selectedMunicipality = null;
                          }
                          _selectedProvince = province;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomDropdownWrapper(
                    child: PhilippineMunicipalityDropdownView(
                      municipalities: _selectedProvince?.municipalities ?? [],
                      value: _selectedMunicipality,
                      onChanged: (Municipality? municipality) {
                        setState(() {
                          _selectedMunicipality = municipality;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _passwordController,
                    labelText: 'Password',
                    obscureText: true,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _reenterPasswordController,
                    labelText: 'Re-enter Password',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Required';
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  CustomPrimaryButton(
                    text: 'Create Account',
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;
                      if (_selectedRegion == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select a region.'),
                          ),
                        );
                        return;
                      }
                      if (_selectedProvince == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select a province.'),
                          ),
                        );
                        return;
                      }
                      if (_selectedMunicipality == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select a municipality.'),
                          ),
                        );
                        return;
                      }
                      final user = User(
                        username: _usernameController.text,
                        password: _passwordController.text,
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        region: _selectedRegion!.regionName,
                        province: _selectedProvince!.name,
                        municipality: _selectedMunicipality!.name,
                      );

                      final success = await AuthService.registerUser(user);

                      if (!context.mounted) return;

                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Account created successfully!'),
                          ),
                        );
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Failed to create account. Please try again.',
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
