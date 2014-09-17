
// Data source: http://www.4-14.org.uk/xml-bible-web-service-api

import big.data.*;
import big.data.field.FieldToXMLSpec;

float EASING = .05;
float MARGIN = 50;
float FONTSIZE = 18;

String PASSAGE = "Psalms121";
String[] VERSIONS = { 
  "kjv", "danish", "ostervald", 
  "luther1912", "riveduta", "rv1909"
};

ArrayList<String[]> verses = new ArrayList<String[]>();
int curVerse = 0;
int curLang = 0;

float x, y, targetX, targetY;
color c;

void setup() {
  size(600, 600);

  // ------------------------------------------------------
  // Data setup    
  DataSource.initializeProcessing(this);
  DataSource ds = DataSource.connect("http://api.preachingcentral.com/bible.php");
  ds.set("passage", PASSAGE).load(); 
  ds.printUsageString();
  //System.out.println(ds.getFieldSpec().apply(new FieldToXMLSpec()).format(2));

  int i = 0;
  for (String version : VERSIONS) {
    ds.set("version", version).load();
    verses.add( ds.fetchStringArray("range/item/text") );
  }

  // ------------------------------------------------------

  // Graphics setup
  x = width/2;
  y = height/2;
  resetTarget();
  pickColor();
  textAlign(CENTER);
  textSize(FONTSIZE);
}


void draw() {
  background(0);
  String first = verses.get(curLang)[curVerse];
  String words = "";
  for (String word : first.split (" ")) {
    words += "\n" + word;
  }

  fill(c);
  text(words, x, y);

  x = x + (targetX - x) * EASING;
  y = y + (targetY - y) * EASING;

  if (dist(x, y, targetX, targetY) < 3) {
    resetTarget();
    pickColor();
    nextVerse();
  }
}

void nextVerse() {
  curLang++;
  if (curLang >= verses.size()) {
    curLang = 0;
    curVerse++;
    String[] vs = verses.get(curLang);
    if (curVerse >= vs.length) {
      curVerse = 0;
    }
  }
}

void resetTarget() {
  targetX = random(MARGIN, width-MARGIN);
  targetY = random(FONTSIZE, height-20*FONTSIZE);
}


void pickColor() {
  c = color(random(100, 225), random(100, 225), random(100, 225));
}

