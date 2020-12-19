import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Signup/components/background.dart';
import 'package:flutter_auth/Screens/Signup/components/or_divider.dart';
import 'package:flutter_auth/Screens/Signup/components/social_icon.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  List InstituteList;
   Body({
    Key key,
    @required this.InstituteList,
  }) : super(key: key);
  @override
  _SignUpPageState createState() => _SignUpPageState(InstituteList);
}
class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}
class _SignUpPageState extends State<Body> {

  String fullname;
  String mobile;
  String email;
  String password;
  String selectedValue;
  String instituteid;
  String select;
  int male=0;
  int female=0;
  String selectedGender;
  int instituteLength;
  //List<String> InstituteList =  ['Hai','Hello'];

  List<Item> users = <Item>[
    const Item('Scholars Academy, Mundakkayam',Icon(Icons.android,color:  Color(0xFF6F35A5),)),
    const Item('Brillaince Accademy, Pala',Icon(Icons.flag,color:  Color(0xFF6F35A5),)),
    const Item('PC Thomas Insititute, Thrissur',Icon(Icons.format_indent_decrease,color:  Color(0xFF6F35A5),)),
    const Item('Study Internationals, Kollam',Icon(Icons.mobile_screen_share,color:  Color(0xFF6F35A5),)),
  ];
  List gender=["Male","Female"];

  bool _isLoading = false;
  List InstituteList;


  _SignUpPageState(this.InstituteList);
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    print(InstituteList);
    signUp(String fullname, mobile,email,institute,password,selectedGender) async {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      Map data = {
        "fullname":fullname,
        "institute":institute,
        "email":email,
        "mobile":mobile,
        "password":password,
        "role":"student",
        "gender": selectedGender
      };
      var jsonResponse = null;
      final snackBar = new SnackBar(content: new Text('Loading...'));
      Scaffold.of(context).showSnackBar(snackBar);
      var response = await http.post("https://oxystech-study-app-nodejs.herokuapp.com/user/account", body: data);
      if(response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
        if(jsonResponse != null) {
          setState(() {
            _isLoading = false;
          });
          //sharedPreferences.setString("token", jsonResponse['token']);
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginScreen ()), (Route<dynamic> route) => false);
          print("Added new account Successfully");
        }
      }
      else {
        setState(() {
          _isLoading = false;
        });
        print(response.body);

      }
    }
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/signup.jpg",
              height: size.height * 0.35,
            ),

            RoundedInputField(
              hintText: "Full Name",
              onChanged: (value) {
                fullname=value;
                },
            ),
            RoundedInputField(
              hintText: "Mobile(+91)",
              icon: Icons.mobile_friendly,
              onChanged: (value) {mobile=value ;
              },
            ),
            RoundedInputField(
              hintText: "Your Email",
              icon: Icons.attach_email,
              onChanged: (value) {email=value ;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {password=value ;
             },
            ),
          Container(

            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            width: size.width * 0.8,
            decoration: BoxDecoration(
              color: Color(0xFFF1E6FF),
              borderRadius: BorderRadius.circular(29.0),

            ),
            child: Row(


              children: <Widget>[
                Icon(Icons.account_circle_rounded,color: Color(0xff416d6d)),
                Text('    Gender      ',
                    textAlign: TextAlign.left,
                    style: TextStyle( fontSize: 16)),
                addRadioButton(0, 'Male'),
                addRadioButton(1, 'Female')
              ],
            ),
          ),

            Container(

                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.8,
              decoration: BoxDecoration(
                color: Color(0xFFF1E6FF),
                borderRadius: BorderRadius.circular(29.0),

              ),
              child: DropdownButton<String>(

                  iconSize: 0,

                  hint: Row(
                    children: [
                      Container(
                        child: Icon(Icons.school,color: Color(0xff416d6d)),

                      ),
                      Container(
                        child: Text("   Select Institute                               "),
                      ),
                      Container(
                        child: Icon(Icons.arrow_drop_down,size:40,color: Color(0xff416d6d)),
                      ),
                    ],
                  ),

                  value: selectedValue,

                  items: List.generate(
                      InstituteList.length,
                          (index) => DropdownMenuItem(
                          value: InstituteList[index].accountName, child: Text(InstituteList[index].accountName))),
                  onChanged: (newValue) {
                    selectedValue = newValue;
                    instituteLength = InstituteList.length;
                    setState(() {});
                  })
            ),



            SizedBox(height: size.height * 0.01),


            RoundedButton(
              text: "SIGNUP",
                color: Colors.lightBlue[900],
              press: () {
                    if(male==1)
                      {
                        selectedGender='male';
                      }
                    else if(female==1)
                      {
                        selectedGender='female';
                      }
                    instituteid = getInstituteId(selectedValue);
                   signUp(fullname, mobile,email,instituteid,password,selectedGender);
              },
            ),
            SizedBox(height: size.height * 0.01),

            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.01),

          ],
        ),
      ),
    );
  }
  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: gender[btnValue],
          groupValue: select,
          onChanged: (value){
            setState(() {
              print(value);
              select=value;
              if(value=="Male")
                {
                  male=1;
                  female=0;
                }
              else{
                male=0;
                female=1;
              }
            });
          },
        ),
        Text(title)
      ],
    );
  }
  String getInstituteId(String Institutename){

    for(int i=0; i<instituteLength; i++){

      if(InstituteList[i].accountName==Institutename){
        return InstituteList[i].id;
      }
    }
    // return InstituteList[i].id;
  }
}
