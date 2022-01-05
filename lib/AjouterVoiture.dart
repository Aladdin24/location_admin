import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'modifier.dart';
import 'TypeVoiture.dart';
import 'voiture.dart';

class AllPersonData extends StatefulWidget {
  @override
  _AllPersonDataState createState() => _AllPersonDataState();
}

class _AllPersonDataState extends State<AllPersonData> {
  Future allPerson() async {
    var url = "http://192.168.43.245/addimage/viewAll.php";
    var response = await http.get(Uri.parse(url));

    var jsonData = json.decode(response.body);

    List<Voiture> voitures = [];

    for (var v in jsonData) {
      Voiture voiture = Voiture(int.parse(v["id_voiture"]), v["Marque"], v["image"],
          v["Modele"], v["vitesses"], v["nbr_places"], v["Prix"], v["Couleur"], v["Disponibilite"]);

      voitures.add(voiture);
    }
    print(voitures.length);

    return voitures;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Center(child: Text('VOITURES')),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black54,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DemoUploadImage(),
            ),
          );
          debugPrint('Clicked FloatingActionButton Button');
        },
      ),
      body: FutureBuilder(
        future: allPerson(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context,  int id) {
                return Card(
                  elevation: 20,
                  child: ListTile(
                    title: Stack(
                      alignment: Alignment.topLeft,
                      children:[ Container(

                        child: Image.network(
                            "http://192.168.43.245/addimage/uploads/${snapshot.data[id].image}"),
                      ),
                        InkWell(
                          child: Icon(Icons.delete),
                          onTap: () {
                            setState(() {
                              var url = Uri.parse('http://192.168.43.245/addimage/delete.php');
                              http.post(url, body: {
                                'id_voiture': snapshot.data[id].id_voiture.toString(),
                              });
                            });
                          },
                        ),
                      ],
                    ),
                    subtitle: Center(child: Text(snapshot.data[id].Marque)),
                    trailing: GestureDetector(
                      child: Icon(Icons.edit),
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllModifier(
                              id_voiture: snapshot.data[id].id_voiture,
                              Marque: snapshot.data[id].Marque,
                              image: snapshot.data[id].image,
                              Modele: snapshot.data[id].Modele,
                              vitesses: snapshot.data[id].vitesses,
                              nbr_places: snapshot.data[id].nbr_places,
                              Prix: snapshot.data[id].Prix,
                              Couleur: snapshot.data[id].Couleur,
                              Disponibilite: snapshot.data[id].Disponibilite,
                            ),
                          ),
                        );
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TypeVoiture(),
                          ));
                    },
                  ),
                );
              })
              : Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      );
  }
}
