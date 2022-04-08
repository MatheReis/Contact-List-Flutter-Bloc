import 'dart:math';

import 'package:flutter/material.dart';
import 'package:studie_bloc/blocs/client_bloc.dart';
import 'package:studie_bloc/blocs/client_events.dart';
import 'package:studie_bloc/blocs/client_state.dart';
import 'package:studie_bloc/clients.dart';

class ClientsPage extends StatefulWidget {
  @override
  _ClientsPageState createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  late final ClientBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ClientBloc();
    bloc.inputClient.add(LoadClientEvent());
  }

  @override
  void dispose() {
    bloc.inputClient.close();
    super.dispose();
  }

  String randomName() {
    final random = Random();
    final names = ['José', 'Maria', 'João', 'Pedro', 'Paulo'];
    return names[random.nextInt(names.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 76, 147, 175),
        title: Container(
            margin: const EdgeInsets.only(left: 10),
            child: const Text('Contatos')),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                bloc.inputClient.add(
                  AddClientEvent(
                    client: Client(nome: randomName()),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: StreamBuilder<ClientState>(
          stream: bloc.stream,
          builder: (context, AsyncSnapshot<ClientState> snapshot) {
            final clientsList = snapshot.data?.clients ?? [];
            return ListView.separated(
              itemCount: clientsList.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 76, 147, 175),
                  child: ClipRect(
                    child: Text(
                      clientsList[index].nome.substring(0, 1),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                title: Text(clientsList[index].nome),
                trailing: Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    icon: const Icon(Icons.delete,
                        color: Color.fromARGB(255, 6, 105, 145)),
                    onPressed: () {
                      bloc.inputClient.add(
                        RemoveClientEvent(
                          client: clientsList[index],
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
