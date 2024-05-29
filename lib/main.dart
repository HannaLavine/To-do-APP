// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
  List<String> tarefas = [];
  List<String> fazendo = [];
  List<String> feitas = [];
  List<String> arquivadas = [];

class _MyAppState extends State<MyApp> {
  final TextEditingController taskController = TextEditingController();


  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  void moverTarefa(List<String> lista1, List<String> lista2, index){
    String tarefa = lista1[index];
    setState(() {

      lista2.add(tarefa);
      lista1.remove(tarefa);  
    },);
  }


  void addTask() {
    final String task = taskController.text;
    if (task.isNotEmpty) {
      setState(() {
        tarefas.add(task);
        taskController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => MyApp(),
        '/arq': (context) {
          return Arquivadas();
        },
      },
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 33, 169, 214), //bg
          title: Text(
            "TO DO LIST",
            style: TextStyle(
              color: Color.fromARGB(255, 0, 114, 137),
              fontWeight: FontWeight.bold,
            ),
          ), //adiciona bordas embaixo do appBar //alinha o texto no centro
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
          children: [
              Row(
                
                children: [
                  Expanded(
                    child: TextField(
                      controller: taskController,
                      decoration: InputDecoration(
                        labelText: "QUAL A SUA TAREFA?",
                        labelStyle: TextStyle(color: const Color.fromARGB(255, 192, 192, 192),fontWeight: FontWeight.bold),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)
                        )
                      ),
                    ),
                  ),
                  SizedBox(width: 4,),
                  ElevatedButton(
                    onPressed: addTask,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 33, 169, 214),
                      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.elliptical(5, 5))),
                      fixedSize: Size.fromHeight(63)
                    ), 
                    child: Text("NOVA",style: TextStyle(color: Colors.white),),
                    
                    ),
                  
                ],
                
              ),
              SizedBox(height: 20,),
              Text("A FAZER", style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600, fontSize: 20),),
              
              Expanded(child: ListView.builder(
                itemCount: tarefas.length,
                itemBuilder: ((context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(tarefas[index], style: TextStyle(fontSize:20),),
                      leading: IconButton(
                      onPressed: (){
                        setState(() {
                          moverTarefa(tarefas, fazendo, index);
                        });

                      },
                      icon: Icon(Icons.move_down)
                      )
                    )
                  );
                })),),
                SizedBox(height: 5,),
                Text("EM ANDAMENTO", style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600, fontSize: 20, ),),
                Expanded(
                  child: ListView.builder(
                    itemCount: fazendo.length,
                    itemBuilder: ((context,index){
                      return Card(
                        child: ListTile(
                          title: Text(fazendo[index], style: TextStyle(fontSize:20),),
                          leading: IconButton(
                          onPressed: (){
                          setState(() {
                          moverTarefa(fazendo, feitas, index);
                        });

                      },
                      icon: Icon(Icons.move_down)
                      )
                        )
                    
                  );


                    })
                    
                    
                    )

                ),
                SizedBox(height: 5,),
                Text("FEITO", style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600, fontSize: 20, ),),
                Expanded(
                  child: ListView.builder(
                    itemCount: feitas.length,
                    itemBuilder: ((context,index){
                      return Card(
                        child: ListTile(
                          title: Text(feitas[index], style: TextStyle(fontSize:20),),
                          leading: IconButton(
                          onPressed: (){
                          setState(() {
                          moverTarefa(feitas, arquivadas, index);
                        });

                      },
                      icon: Icon(Icons.restore_from_trash_rounded)
                      )
                        )
                    
                  );


                    })
                    
                    
                    )

                ),

                Container(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    color: Color.fromARGB(255, 103, 103, 103),
                    iconSize: 60,
                    onPressed: (){
                      Navigator.pushNamed(context, '/arq');
                    }, 
                    icon: Icon(Icons.history)),
                ),
            ],
          ),
          
        ),
      ),
    );
  }
}

class Arquivadas extends StatefulWidget {
  const Arquivadas({super.key});


  @override
  State<Arquivadas> createState() => _ArquivadasState();
}

class _ArquivadasState extends State<Arquivadas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
          child: Column(
            children: [
              Text("TAREFAS ARQUIVADAS", style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600, fontSize: 20, ),),
              Expanded(
                child: ListView.builder(
                  itemCount: arquivadas.length,
                  itemBuilder: (((context, index) {
                    return Card(
                      child: ListTile(
                          title: Text(arquivadas[index], style: TextStyle(fontSize:20),),
                          leading: IconButton(
                          onPressed: (){
                          setState(() {
                            arquivadas.remove(arquivadas[index]);
                        });

                      },
                      icon: Icon(Icons.clear)
                      )
                        )
                    
                    );
                  }))
                  
                  
                  ))
            ],
          ),
        ),
      );
  }
}