import 'package:flutter/material.dart';

enum SingingCharacter { Exclusive, Inclusive }

class GSTCalculator extends StatefulWidget {
  const GSTCalculator({super.key});


  @override
  State<GSTCalculator> createState() => _GSTCalculatorState();
}

class _GSTCalculatorState extends State<GSTCalculator> {

  SingingCharacter? _character = SingingCharacter.Exclusive;


  @override
  Widget build(BuildContext context) {



    return Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage("https://img.freepik.com/free-vector/indian-rupee-money-bag_23-2147998532.jpg?w=1480&t=st=1700556653~exp=1700557253~hmac=6f609894db498a28729864cbce9aae8ec45a4608d3d0ecd1a63fef85e7f242f6"),
                    fit: BoxFit.cover
                )
            ),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: MediaQuery.of(context).size.height*0.2,
                    width: 300,
                    decoration:BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10)
                    ) ,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("Select type",style: TextStyle(color: Colors.red, fontSize: 18,fontWeight:FontWeight.bold ),),
                        RadioListTile<SingingCharacter>(
                          title: const Text('Exclusive'),
                          value: SingingCharacter.Exclusive,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                            });
                          },
                        ),
                        RadioListTile<SingingCharacter>(
                          title: const Text('Inclusive'),
                          value: SingingCharacter.Inclusive,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                            });
                          },
                        ),
                      ],
                    )
                ),
                SizedBox(height: 50,),
                Container(
                  height: MediaQuery.of(context).size.height*0.5,
                  width: 300,
                  decoration:BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10)
                  ) ,
                  child:
                  _character == SingingCharacter.Exclusive
                      ? ExclusiveDataWidget()
                      : InclusiveDataWidget(),
                )
              ],
            )
        )
    );
  }
}

class ExclusiveDataWidget extends StatefulWidget {
  const ExclusiveDataWidget({super.key});

  @override
  State<ExclusiveDataWidget> createState() => _ExclusiveDataWidgetState();
}

class _ExclusiveDataWidgetState extends State<ExclusiveDataWidget> {

  List<String> list = <String>['5', '12', '18', '28'];
  late String dropdownValue ;

  TextEditingController actualAmount = TextEditingController();
  TextEditingController gstValue = TextEditingController();

  double totalAmount =0;
  double gstAmount =0;
  double sum=0;

  void calculateExclusive(){
    setState(() {
      gstAmount = ((double.parse(actualAmount.text) * int.parse(gstValue.text)/100));
      totalAmount = double.parse(actualAmount.text) + gstAmount;
      sum = totalAmount - gstAmount;
      print(totalAmount);
      print(gstAmount);
      print(sum);

    });
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Exclusive GST"),
          TextFormField(
            controller: actualAmount,
            decoration: InputDecoration(
                hintText: "Enter Total Amount",
                border: OutlineInputBorder()
            ),
          ),
          DropdownMenu(
            leadingIcon: Icon(Icons.percent),
            controller: gstValue,
            width: 285,
            initialSelection: list.first,
            onSelected: (String? value) {
              setState(() {
                dropdownValue = value!;
              });
            },

            dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          ),
          ElevatedButton(onPressed: (){
            calculateExclusive();
            print("Tapped");
          }, child: Text("Calculate Exclusive GST")),


          Row(
            children: [
              Text("Total Amount : "),
              Text((totalAmount).toString()),
            ],
          ),
          Row(
            children: [
              Text("Actual Amount : "),
              Text((sum).toString()),
            ],
          ),
          Row(
            children: [
              Text("GST Amount : "),
              Text((gstAmount).toString()),
            ],
          ),
        ],
      ),
    );
  }
}




class InclusiveDataWidget extends StatefulWidget {
  const InclusiveDataWidget({super.key});

  @override
  State<InclusiveDataWidget> createState() => _InclusiveDataWidgetState();
}

class _InclusiveDataWidgetState extends State<InclusiveDataWidget> {

  List<String> list = <String>['5', '12', '18', '28'];
  late String dropdownValue ;

  TextEditingController totalAmount = TextEditingController();
  TextEditingController gstValue = TextEditingController();

  double actualAmount =0;
  double gstAmount =0;
  double sum=0;

  void calculateInclusive(){
    setState(() {
      actualAmount = (double.parse(totalAmount.text) * (100/(100 + int.parse(gstValue.text))));
      gstAmount = double.parse(totalAmount.text)- actualAmount;
      sum = gstAmount + actualAmount;
      print(actualAmount);
      print(gstAmount);
      print(sum);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Inclusive GST"),
          TextFormField(
            controller: totalAmount,
            decoration: InputDecoration(
                hintText: "Enter Total Amount",
                border: OutlineInputBorder()
            ),
          ),
          DropdownMenu(
            leadingIcon: Icon(Icons.percent),
            controller: gstValue,
            width: 285,
            initialSelection: list.first,
            onSelected: (String? value) {
              setState(() {
                dropdownValue = value!;
              });
            },

            dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          ),
          ElevatedButton(
              onPressed: (){
                calculateInclusive();
                },
              child: Text("Calculate Inclusive GST")),
          Row(
            children: [
              Text("Total Amount : "),
              Text((sum).toString()),
            ],
          ),
          Row(
            children: [
              Text("Actual Amount : "),
              Text((actualAmount).toString()),
            ],
          ),
          Row(
            children: [
              Text("GST Amount : "),
              Text((gstAmount).toString()),
            ],
          ),




        ],
      ),
    );
  }
}





