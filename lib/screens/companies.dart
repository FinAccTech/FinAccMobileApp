import 'package:finacc/config/api.dart';
import 'package:flutter/material.dart';
import 'package:finacc/config/globals.dart' as Globals;

class Companies extends StatelessWidget {
  const Companies({Key? key}) : super(key: key);

  static const String routeName = '/companies';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => Companies(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Company"),
        backgroundColor: Colors.white, //background color of app bar
        foregroundColor: Colors.deepOrangeAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32)),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(),
        child: FutureBuilder<List>(
          future: Api.getCompanies(context),
          builder: (context, snapshot) {
            final companies = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      snapshot.error.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                } else {
                  // return SchemeCard(schemes!);
                  return ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: companies?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 5,
                          child: ListTile(
                            onTap: () {
                              Globals.Comp_Name =
                                  companies![index]['Comp_Name'];
                              Globals.DbName = companies![index]['DbName'];
                              Navigator.pushReplacementNamed(
                                  context, "/dashboard");
                            },
                            leading: Icon(Icons.domain),
                            title: Text(
                              companies![index]['Comp_Name'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: Text((index + 1).toString()),
                          ),
                        );
                      });
                }
            }
          },
        ),
      ),
    );
  }
}
