import 'package:flutter/material.dart';

class BillSplitter extends StatefulWidget {
  //const BillSplitter({ Key? key }) : super(key: key);

  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  Color _purple = Color(0xFF6908D6);

  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.purple
                    .withOpacity(0.3), //Colors.purpleAccent.shade100,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total per Person',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15.0,
                        color: Colors.purple,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        '\$ ${calculateTotalPerPerson(_billAmount, _personCounter, _tipPercentage)}',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.blueGrey.shade100,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children: [
                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(
                      color: Colors.purple,
                    ),
                    decoration: InputDecoration(
                      prefixText: 'Bill Amount',
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                    onChanged: (String value) {
                      try {
                        _billAmount = double.parse(value);
                      } catch (exception) {}
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Split',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (_personCounter > 1) {
                                  _personCounter = _personCounter - 1;
                                } else {
                                  //do othing
                                }
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.purple.withOpacity(0.3),
                              ),
                              child: Center(
                                  child: Text(
                                '-',
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            ),
                          ),
                          Text('$_personCounter',
                              style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                              )),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _personCounter = _personCounter + 1;
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.purple.withOpacity(0.3),
                              ),
                              child: Center(
                                  child: Text(
                                '+',
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  //Tip
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tip',
                        style: TextStyle(color: Colors.purple),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          '\$ ${(calculateTotalTip(_billAmount, _personCounter, _tipPercentage)).toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),

                  //Slider
                  Column(
                    children: [
                      Text(
                        '$_tipPercentage%',
                        style: TextStyle(
                            color: Colors.purple,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Slider(
                          activeColor: Colors.purple,
                          inactiveColor: Colors.grey,
                          //divisions: 10, //optional
                          min: 0,
                          max: 100,
                          value: _tipPercentage.toDouble(),
                          onChanged: (double newValue) {
                            setState(() {
                              _tipPercentage = newValue.round();
                            });
                          })
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  calculateTotalPerPerson(double billAmount, int splitBy, int tipPercentage) {
    var totalPerPerson =
        (calculateTotalTip(billAmount, splitBy, tipPercentage) + billAmount) /
            splitBy;

    return totalPerPerson.toStringAsFixed(2);
  }

  calculateTotalTip(double billAmount, int splitBy, int tipPercentage) {
    double totalTip = 0.0;

    if (billAmount < 0 || billAmount.toString().isEmpty || billAmount == null) {
    } else {
      totalTip = (billAmount * tipPercentage) / 100;
    }
    return totalTip;
  }
}

class Wisdom extends StatefulWidget {
  //const Wisdom({ Key? key }) : super(key: key);

  @override
  _WisdomState createState() => _WisdomState();
}

class _WisdomState extends State<Wisdom> {
  int _index = 0;

  var quotes = <String>[
    'The greatest glory in living lies not in never falling, but in rising every time we fall.',
    "The way to get started is to quit talking and begin doing.",
    "Your time is limited, so don't waste it living someone else's life. Don't be trapped by dogma – which is living with the results of other people's thinking.",
    "If life were predictable it would cease to be life, and be without flavor.",
    "If you look at what you have in life, you'll always have more. If you look at what you don't have in life, you'll never have enough.",
    "If you set your goals ridiculously high and it's a failure, you will fail above everyone else's success.",
    "Life is what happens when you're busy making other plans.",
    "When you reach the end of your rope, tie a knot in it and hang on.",
    "Don't judge each day by the harvest you reap but by the seeds that you plant.",
    "The future belongs to those who believe in the beauty of their dreams.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 350,
                //height: 200,
                margin: EdgeInsets.all(30.0),
                padding: EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Center(
                    child: Text(
                  quotes[_index % quotes.length],
                  style: TextStyle(fontSize: 15.0, fontStyle: FontStyle.italic),
                ))),

            Divider(
              thickness: 1.3,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: TextButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  onPressed: _showQuote,
                  icon: Icon(
                    Icons.wb_sunny,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Inspire Me',
                    style: TextStyle(color: Colors.white, fontSize: 19.0),
                  )),
            ),
            //Spacer(),
          ],
        ),
      ),
    );
  }

  void _showQuote() {
    //increment index by 1;
    setState(() {
      _index = _index + 1;
    });
  }
}

class BizCard extends StatelessWidget {
  // const BizCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BizCard'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            _getCard(),
            _getAvatar(),
          ],
        ),
      ),
    );
  }

  Container _getCard() {
    return Container(
      width: 350,
      height: 200,
      margin: EdgeInsets.all(50.0),
      decoration: BoxDecoration(
        color: Colors.pinkAccent,
        borderRadius: BorderRadius.circular(14.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'John Doe',
            style: TextStyle(
                fontSize: 21, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          Text('BuildAppsWithJohnDoe.com'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person_outline),
              Text('John_Doe'),
            ],
          ),
        ],
      ),
    );
  }

  Container _getAvatar() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
        border: Border.all(color: Colors.redAccent, width: 1.2),
        image: DecorationImage(
          image: NetworkImage('https://picsum.photos/300/300'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ScaffoldExample extends StatelessWidget {
  //const ScaffoldExample({ Key? key }) : super(key: key);

  _tapButton() {
    debugPrint('Tapped Button');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scaffold'),
        centerTitle: false,
        backgroundColor: Colors.amberAccent.shade700,
        actions: [
          IconButton(
              onPressed: () => debugPrint('Email Tapped'),
              icon: Icon(Icons.email)),
          IconButton(onPressed: _tapButton, icon: Icon(Icons.access_alarm)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => debugPrint('Say Hello!'),
        backgroundColor: Colors.lightGreenAccent,
        child: Icon(
          Icons.missed_video_call,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          debugPrint('Tapped item: $index');
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'First'),
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: 'Second'),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_time_rounded), label: 'Third'),
        ],
      ),
      backgroundColor: Colors.redAccent.shade200,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  //const CustomButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var snackBar = SnackBar(
          content: Text('Hello There!'),
          backgroundColor: Colors.black,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(10.0)),
        child: Text("Button"),
      ),
    );
  }
}

class Home extends StatelessWidget {
  // const Home({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.deepOrange,
      child: Center(
          child: Text(
        'Hello FLutter!',
        textDirection: TextDirection.ltr,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 23.4,
          fontStyle: FontStyle.italic,
        ),
      )),
    );
  }
}
