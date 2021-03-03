import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app1/utils/string_util.dart';
import 'package:flutter_app1/main.dart';

// void main() {
//   runApp(LoginPage());
// }

class LoginPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginRoute(),
    );
  }

}
class LoginRoute extends StatefulWidget {
  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  //文本编辑控制器 可用于监听文本内容的改变
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();

  //所填账户信息字符串
  var _str_uname = '';

  //所填密码信息字符串
  var _str_pass = '';
  bool pwdShow = false; //密码是否显示明文
  GlobalKey _formKey = new GlobalKey<FormState>();
  bool _nameAutoFocus = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('登录')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              TextFormField(
                  autofocus: _nameAutoFocus,
                  controller: _unameController,
                  decoration: InputDecoration(
                    // labelText: gm.userName,
                    // hintText: gm.userNameOrEmail,
                    prefixIcon: Icon(Icons.person),
                  ),
                  // 校验用户名（不能为空）
                  validator: (v) {
                    return v.trim().isNotEmpty ? null : _str_uname;
                  }
                  ),
              TextFormField(
                controller: _pwdController,
                autofocus: !_nameAutoFocus,
                decoration: InputDecoration(
                    // labelText: gm.password,
                    // hintText: gm.password,
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                          pwdShow ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          pwdShow = !pwdShow;
                        });
                      },
                    )),
                obscureText: !pwdShow,
                //校验密码（不能为空）
                validator: (v) {
                  return v.trim().isNotEmpty ? null : _str_pass;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(height: 55.0),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: (){
                      _str_uname = _unameController.text;
                      _str_pass = _pwdController.text;
                      _localLogin(_str_uname, _str_pass);
                    },
                    textColor: Colors.white,
                    child: Text('登录'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void _onLogin() async {
  //   // 提交前，先验证各个表单字段是否合法
  //   if ((_formKey.currentState as FormState).validate()) {
  //     showLoading(context);
  //     User user;
  //     try {
  //       user = await Git(context)
  //           .login(_unameController.text, _pwdController.text);
  //       // 因为登录页返回后，首页会build，所以我们传false，更新user后不触发更新
  //       Provider.of<UserModel>(context, listen: false).user = user;
  //     } catch (e) {
  //       //登录失败则提示
  //       if (e.response?.statusCode == 401) {
  //         showToast(GmLocalizations.of(context).userNameOrPasswordWrong);
  //       } else {
  //         showToast(e.toString());
  //       }
  //     } finally {
  //       // 隐藏loading框
  //       Navigator.of(context).pop();
  //     }
  //     if (user != null) {
  //       // 返回
  //       Navigator.of(context).pop();
  //     }
  //   }
  // }

  void _localLogin(String str_account, String str_pass) {
    if (str_account.trim() == '') {
      showToast('手机号不能为空');
      return;
    }
    if (str_pass.trim() == '') {
      showToast('密码不能为空');
      return;
    }

    if (str_pass == '1') {
      showToast( '登录成功');
      Navigator.pop(context);
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => new HomePage()));
    } else {
      showToast('密码错误');
    }
  }
}
