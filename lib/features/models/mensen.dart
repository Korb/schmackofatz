enum Mensen {
  ampark("Mensa am Park"),
  petersteinweg("Mensa am Petersteinweg"),
  elsterbecken("Mensa am Elsterbecken"),
  academica("Mensa Academica"),
  medizin("Mensa am Medizincampus"),
  botanischergarten("Mensa am Botanischen Garten"),
  tierkliniken("Mensa an den Tierkliniken"),
  schoenauer("Mensa Schönauer Straße"),
  dittrichring("Cafeteria Dittrichring");

  // Speichert den Namen, der in der UI angezeigt wird
  final String displayName;
  const Mensen(this.displayName);
}