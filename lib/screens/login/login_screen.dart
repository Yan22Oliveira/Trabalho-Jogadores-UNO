import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../../api/api.dart';
import '../../helpers/helpers.dart';
import '../../widgets/widgets.dart';

import '../home/home_screen.dart';
import '../signup/signup_screen.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  GlobalKey<FormState> _formKeyLogin = GlobalKey<FormState>(debugLabel: '_loginFormKey');

  final _emailController = TextEditingController();

  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Consumer<Login>(

      builder: (_,login,__){

        return Scaffold(
          key: login.scaffoldKeyLogin,
          backgroundColor: colorSmokyBlack,
          appBar: AppBar(
            backgroundColor: colorSmokyBlack,
            elevation: 0,
          ),
          body: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 500,
              ),
              child: Form(
                key: _formKeyLogin,
                child: AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle.light,
                  child: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Container(
                      height: double.maxFinite,
                      color: colorSmokyBlack,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              const SizedBox(height: 20,),
                              Center(
                                child: Column(
                                  children: [

                                    Image.asset(
                                      "images/uno.png",
                                      height: 260,
                                    ),

                                    const SizedBox(height: 40,),
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              TextoTituloForm(texto: 'Informe seu e-mail',),
                                              const SizedBox(height: 4,),
                                              FormField(
                                                validator: (email) {
                                                  if (!emailValid(_emailController.text)) {
                                                    return 'E-mail inválido';
                                                  }
                                                  return null;
                                                },
                                                builder: (state){
                                                  return Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(4),
                                                        ),
                                                        child: FormGeral(
                                                          hintText: 'E-mail',
                                                          keyboardType: TextInputType.emailAddress,
                                                          controller: _emailController,
                                                          autocorrect: false,
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                      if(state.hasError)
                                                        const SizedBox(height: 4,),
                                                      if(state.hasError)
                                                        Text(
                                                          state.errorText as String,
                                                          style: const TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 12
                                                          ),
                                                        ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 16,),
                                              TextoTituloForm(texto: 'Informe sua senha',),
                                              const SizedBox(height: 4,),
                                              FormField(
                                                validator: (pass) {
                                                  if (_passController.text.isEmpty || _passController.text.length < 8)
                                                    return 'Senha inválida';
                                                  return null;
                                                },
                                                builder: (state){
                                                  return Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(4),
                                                        ),
                                                        child: FormGeral(
                                                          hintText: "Senha",
                                                          keyboardType: TextInputType.visiblePassword,
                                                          controller: _passController,
                                                          maxLines: 1,
                                                          obscureText: true,
                                                        ),
                                                      ),
                                                      if(state.hasError)
                                                        const SizedBox(height: 4,),
                                                      if(state.hasError)
                                                        Text(
                                                          state.errorText as String,
                                                          style: const TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 12
                                                          ),
                                                        ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ],
                                          ),

                                          Container(
                                            alignment: Alignment.bottomRight,
                                            child: TextButton(
                                              onPressed: (){

                                              },
                                              child: Text(
                                                "Esqueceu a senha?",
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  color: colorRedSalsa,
                                                ),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 12),

                                          RaisedButton(
                                            onPressed: login.loading?null:(){

                                              if(_formKeyLogin.currentState!.validate()){

                                                login.postLogin(
                                                    senha: _passController.text,
                                                    email: _emailController.text,
                                                    onSuccess: (_){

                                                      Navigator.of(context).pushReplacement(
                                                        MaterialPageRoute(builder: (context) => HomeScreen(),
                                                        ),
                                                      );

                                                    },
                                                    onFail: (text){
                                                      login.retornarMensagem(
                                                        voltarTela: false,
                                                        context: context,
                                                        color: Colors.redAccent,
                                                        mensagem: text,
                                                      );
                                                    }
                                                );

                                              }


                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            elevation: 3,
                                            color: colorMalachite,
                                            padding: EdgeInsets.all(8),
                                            child: login.loading?
                                            Center(
                                              child: SizedBox(
                                                width: 32,
                                                height: 32,
                                                child: CircularProgressIndicator(
                                                  color: colorRedSalsa,
                                                ),
                                              ),
                                            ):
                                            Container(
                                              height: 36,
                                              child: Center(
                                                child: Text(
                                                  "Autenticar",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 20),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Não possui uma conta?",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: (){

                                                  Navigator.of(context).pushReplacement(
                                                    MaterialPageRoute(builder: (context) => SignupScreen(),
                                                    ),
                                                  );

                                                },
                                                child: Text(
                                                  "Criar Conta",
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                    color: colorRedSalsa,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          const SizedBox(height: 32),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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
        );

      },

    );

  }
}