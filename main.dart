import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Менеджер привычек',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Мои привычки'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _percentage = 100;
  final List _listHabits = [];
  var res;

  void addNewHabits() {
    setState(() async {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      final res = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const AddNewHabits(
                  title: 'Добавить привычку',
                )),
      );
      if (res != null) {
        setState(() {
          _listHabits.add(res);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          const Center(
            child: Text(
              "Добавить",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          IconButton(onPressed: addNewHabits, icon: const Icon(Icons.add))
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30.0),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Все привычки',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '$_percentage%',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
      body:
      Container(
        alignment: Alignment.center,
        child: ListView.builder(
          itemCount: _listHabits.length,
          itemBuilder: (BuildContext context, int index) {
            return _listHabits[index];
          },
        ),
      ),
    );
  }
}

class AddNewHabits extends StatefulWidget {
  const AddNewHabits({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;

  @override
  State<AddNewHabits> createState() => _AddNewHabits();
}

class _AddNewHabits extends State<AddNewHabits> {
  void addNewHabits() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      Navigator.pop(
          context, const Habit(title: 'Running', descrip: "test"));
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          const Center(
            child: Text(
              "Сохранить",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          IconButton(onPressed: addNewHabits, icon: const Icon(Icons.add_task))
        ],
        leading: IconButton(
            onPressed: addNewHabits, icon: const Icon(Icons.arrow_back_sharp)),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}

class Habit extends StatefulWidget {
  const Habit({super.key, required this.title, required this.descrip});

  final title;
  final descrip;

  @override
  _HabitState createState() => _HabitState();
}

class _HabitState extends State<Habit> {
  final List<String> _daysOfWeek = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
  final List<bool> _selectedDays = List.filled(7, false);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Text(
                'Текст 1',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(width: 16),
              Text(
                'Текст 2',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(width: 16),
              Text(
                'Текст 3',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: _daysOfWeek
                .asMap()
                .entries
                .map(
                  (entry) => FilterChip(
                    label: Text(entry.value),
                    selected: _selectedDays[entry.key],
                    onSelected: (selected) {
                      setState(() {
                        _selectedDays[entry.key] = selected;
                      });
                    },
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
