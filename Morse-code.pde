import controlP5.*;

String charToMorse(Character input) {
  switch(input) {
    case 'A': return "*-";
    case 'B': return "-***";
    case 'C': return "-*-*";
    case 'D': return "-**";
    case 'E': return "*";
    case 'F': return "**-*";
    case 'G': return "--*";
    case 'H': return "****";
    case 'I': return "**";
    case 'J': return "*---";
    case 'K': return "-*-";
    case 'L': return "*-**";
    case 'M': return "--";
    case 'N': return "-*";
    case 'O': return "---";
    case 'P': return "*--*";
    case 'Q': return "--*-";
    case 'R': return "*-*";
    case 'S': return "***";
    case 'T': return "-";
    case 'U': return "**-";
    case 'V': return "***-";
    case 'W': return "*--";
    case 'X': return "-**-";
    case 'Y': return "-*--";
    case 'Z': return "--**";
  
    case '1': return "*----";
    case '2': return "**---";
    case '3': return "***--";
    case '4': return "****-";
    case '5': return "*****";
    case '6': return "-****";
    case '7': return "--***";
    case '8': return "---**";
    case '9': return "----*";
    case '0': return "-----";
    default: return "";
  }
}

String convertToMorse(String input) {
  String output = "";
  for(Character c : input.toCharArray()) {
    output += charToMorse(c) + "  ";
  }
  return output;
}

HashMap<Character, Float> calcProbabilities(String input) {
  HashMap<Character, Float> probabilities = new HashMap<Character, Float>();
  for(Character c : input.toCharArray()){
    Float val = probabilities.get(c);
    if(val != null) {
      probabilities.put(c, new Float(val + 1.0 / input.length()));
    }
    else {
      probabilities.put(c, 1.0 / input.length());
    }
  }
  return probabilities;
}

Float calcWordLength(String input) {
  Float average_wordlength = 0.0;
  HashMap<Character, Float> probabilities = calcProbabilities(input);
  
  for (Character c : probabilities.keySet()) {
    Float probability = probabilities.get(c);
    
    average_wordlength += probability * charToMorse(c).length();
  }
  return average_wordlength;
}

Float calcEntropy(String input) {
  Float entropy = 0.0;
  HashMap<Character, Float> probabilities = calcProbabilities(input);
  
  for (Character c : probabilities.keySet()) {
    Float probability = probabilities.get(c);

    entropy -= new Float(probability * Math.log(probability)/Math.log(2));
  }
  return entropy;
}

Float calcRedundancy(String input) {
  return calcWordLength(input) - calcEntropy(input);
}

ControlP5 cp5;

Button btn;
Textfield input;
Textarea output;

void setup() {
  size(710, 510);
  
  cp5 = new ControlP5(this);
  
  PFont font = createFont("", 32);
  
  input = cp5.addTextfield("txt");
  input.setPosition(20, 20);
  input.setSize(400, 40);
  input.setLabel("");
  input.setFont(font);
  
  btn = cp5.addButton("button");
  btn.setPosition(440, 20);
  btn.setSize(260, 40);
  btn.setFont(font);
  btn.setLabel("Übersetzen");
  
  output = cp5.addTextarea("label");
  output.setPosition(20, 80);
  output.setSize(680, 400);
  output.setFont(font);
}

void draw() {
  background(100);
  fill(50);
  rect(20, 80, 680, 400);
}

public void button() {
  String src = input.getText().toUpperCase().replaceAll("\\s+","");
  output.setText(
    "Input: " + src + "\n" +
    "Morsecode: \n" + convertToMorse(src) + "\n" +
    "mittlere Wortlänge: " + calcWordLength(src).toString() + "\n" +
    "Entropie: " + calcEntropy(src).toString() + "\n" +
    "Redundanz: " + calcRedundancy(src).toString() + "\n"
  );
}
