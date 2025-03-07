// Skapar swedishAlphabet automatiskt från letterImages.keys
const Map<String, String> letterImages = {
  "A": "assets/images/alfabet/apa.png",
  "B": "assets/images/alfabet/banan.png",
  "C": "assets/images/alfabet/citron.png",
};

final List<String> swedishAlphabet = letterImages.keys.toList();
