import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class contactus extends StatelessWidget {
  const contactus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormBuilderState> _fbKey =
        GlobalKey<FormBuilderState>();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
        
            child: Card(
              margin: EdgeInsets.all(20.0),
              shape: RoundedRectangleBorder(borderRadius:
                                    BorderRadius.circular(
                                        15.0)),
              elevation: 15.0,
              child: Container(
                padding: EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                    left: 10.0,
                    right: 10.0),
                child: Column(
                  children: <Widget>[
                    FormBuilder(
                      key: _fbKey,
                      autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: <Widget>[
                          FormBuilderFilterChip(
                            name: 'filter_chip',
                            decoration: InputDecoration(
                              labelText:
                                  'What is the issue bout',
                                  
                            ),
                            options: [
                              FormBuilderFieldOption(
                                  value: 'Test',
                                  child: Text('Quality')),
                              FormBuilderFieldOption(
                                  value: 'Test 1',
                                  child: Text('Delivery')),
                              FormBuilderFieldOption(
                                  value: 'Test 2',
                                  child: Text('Broken Item')),
                              FormBuilderFieldOption(
                                  value: 'Test 3',
                                  child: Text('Replacement')),
                              FormBuilderFieldOption(
                                  value: 'Test 4',
                                  child: Text('Others')),
                            ],
                          ),
                          FormBuilderCheckbox(
                            name: 'accept_terms',
                            initialValue: false,
                            //onChanged: _onChanged,
                            title: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        'I have read and agree to the ',
                                    style: TextStyle(
                                        color: Colors.black),
                                  ),
                                  TextSpan(
                                    text:
                                        'Terms and Conditions',
                                    style: TextStyle(
                                        color: Colors.blue),
                                  ),
                                ],
                              ),
                            ),
                            validator:
                                FormBuilderValidators.equal(
                              context,
                              true,
                              errorText:
                                  'You must accept terms and conditions to continue',
                            ),
                          ),
                          FormBuilderTextField(
                            name: 'age',
                            decoration: InputDecoration(
                              labelText: 'Type your Query here',
                            ),
                            //onChanged: _onChanged,
                            // valueTransformer: (text) => num.tryParse(text),
                            validator:
                                FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  context),
                              //FormBuilderValidators.
                              FormBuilderValidators.max(
                                  context, 70),
                            ]),
                            keyboardType: TextInputType.text,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: MaterialButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 15.0),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(
                                        15.0)),
                            color: Colors.black,
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                            onPressed: () {
                              _fbKey.currentState!.save();
                              if (_fbKey.currentState!
                                  .validate()) {
                                print(
                                    _fbKey.currentState!.value);
                              } else {
                                print("validation failed");
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: MaterialButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 15.0),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(
                                        15.0)),
                            color: Colors.black,
                            child: Text(
                              "Reset",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                            onPressed: () {
                              _fbKey.currentState!.reset();
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
