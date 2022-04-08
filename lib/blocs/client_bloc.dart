import 'dart:async';

import 'package:studie_bloc/blocs/client_events.dart';
import 'package:studie_bloc/blocs/client_state.dart';
import 'package:studie_bloc/clients.dart';
import 'package:studie_bloc/clients_repository.dart';

class ClientBloc {
  final _clientRepo = ClientsRepository();

  final StreamController<ClientEvent> _inputClientController = StreamController<ClientEvent>();
  final StreamController<ClientState> _outputClientController = StreamController<ClientState>();

  Sink<ClientEvent> get inputClient => _inputClientController.sink;
  Stream<ClientState> get stream => _outputClientController.stream;

  ClientBloc() {
    _inputClientController.stream.listen(_mapEventToState);
   

  }

  _mapEventToState(ClientEvent event) {
    List<Client> clients = []; 
    if (event is LoadClientEvent) {
      clients = _clientRepo.loadClients();
    } else if (event is AddClientEvent) {
      clients = _clientRepo.addClient(event.client);
    } else if (event is RemoveClientEvent) {
      clients = _clientRepo.removeClient(event.client);
    }
    _outputClientController.add(ClientSucessState(clients: clients));
  }
}