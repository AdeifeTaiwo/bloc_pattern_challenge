import 'package:bloc_pattern_challenge/blocs/app_bloc.dart';
import 'package:bloc_pattern_challenge/blocs/app_events.dart';
import 'package:bloc_pattern_challenge/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'blocs/app_state.dart';
import 'constants.dart';
import 'detail_scree/details_screen.dart';
import 'model/user_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: RepositoryProvider<UserRepository>(
          create: (BuildContext context) =>
            UserRepository(),

          child: const Home(),
        ));
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider<UserBloc>(
      create: (context) => UserBloc(
        RepositoryProvider.of<UserRepository>(context),
      )..add(UserLoadEvent()),

      child: Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset('assets/icons/side_drawer.svg'),
            onPressed: () {},
          ),
          actions: [
            SizedBox(
                child: Container(
              padding: const EdgeInsets.all(2.5),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey)),
              child: DecoratedBox(
                  decoration: const BoxDecoration(
                      color: Colors.transparent, shape: BoxShape.circle),
                  child: ClipOval(
                    child: Image.asset('assets/images/background_2.jpg',
                        height: 32, width: 32, fit: BoxFit.cover),
                  )),
            )),
            const SizedBox(
              width: kDefaultPadding / 2,
            )
          ],
        ),

        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UserLoadedState) {
              List<UserModel> userList = state.users;

              return ListView.builder(
                itemCount: userList.length,
                  itemBuilder: (context, index){

                    return InkWell(
                      onTap: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => DetailScreen(
                            userModel: userList[index],
                          ))
                        );
                      },
                      child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      padding: const EdgeInsets.all(kDefaultPadding/2),
                        decoration: BoxDecoration(
                          color: kBgColor,
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(
                            color: Colors.grey
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(userList[index].firstName!, style: const TextStyle(
                                  color: Colors.black
                                ),),
                                Text(userList[index].lastName!, style: const TextStyle(
                                    color: Colors.black
                                ))
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.all(2.5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey)),
                              child: DecoratedBox(
                                  decoration: const BoxDecoration(
                                      color: Colors.transparent, shape: BoxShape.circle),
                                  child: ClipOval(

                                    child:Hero(
                                      tag: userList[index].avatar!,
                                      child: CircleAvatar(
                                        backgroundImage:
                                        NetworkImage( userList[index].avatar!, scale: 32)
                                      ),
                                    ) ,
                                  )
                              ),
                            )

                          ],
                        ),
                      ),
                    );
                  }
              );
            }

            if(state is UserErrorState){
              return const Center(child:
                Text('Error occurred while loading user data')
                );
            }

            return Container();
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
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
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
