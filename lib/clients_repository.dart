import 'package:studie_bloc/clients.dart';

class ClientsRepository {
  final List<Client> _clients = [];

  List<Client> loadClients() {
    _clients.addAll([
      Client(nome: 'José Arnaldo'), 
      Client(nome: 'Maria da Silva'),
      Client(nome: 'João da Silva'),
      Client(nome: 'Pedro da Silva'),
      Client(nome: 'Paulo da Silva'),
    ]);
    return _clients;
  }

  List<Client> addClient(Client client) {
    _clients.add(client);
    return _clients;
  }

  List<Client> removeClient(Client client) {
    _clients.remove(client);
    return _clients;
  }
}