
enum GamePhase {
  initialInput /*l'utente sta inserendo i dati di join, quindi tipicamente: codice stanza e username*/,
  waiting /*l'utente ha contattato il server mandando il messaggio join-room e ha ricevuto i token di partecipazione {reconnection, answering}*/,
}
