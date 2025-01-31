int prevSecond; 
float scaleChange = 1.0;
float maxScale = 2.5; // maximum scale I can get to 
float minScale = 1.0; // 1 because I want to start from my set punto size which is 64
PFont font;

void setup() {
  size(600,200);
  textAlign(LEFT, CENTER); // Left-aligned text

font = createFont("Panamera-Bold.otf", 256, true); // loading font I want to use
  smooth();
  hint(ENABLE_NATIVE_FONTS); // Use OS-level font rendering for best quality
}




void draw() {
  background(241, 209, 33);

  int h = hour(); //getting hour
  int m = minute(); // getting minute
  int s = second(); // Getting my second

  // Define min and max punto sizes
  float minPunto = 64;
  float maxPunto = 210; 

  // Scale my Punto accordign to highes and lowest values ie hour is 00 at low 24 at high
  float hourSize = map(h, 0, 24, minPunto, maxPunto); //Map will deternmine my font size etween the ranges of mintextsize and maxtextsizde if my initial number ranges fom 1 - 24
  float minuteSize = map(m, 0, 59, minPunto, maxPunto);
  float secondSize = map(s, 0, 59, minPunto, maxPunto);

  if (s != prevSecond) { //When my second isn't equal to the preivious second
    scaleChange = map(s, 0, 59, minScale, maxScale); //second number size is determined within a number between minScale and Maxscale depending on where it is in the range 0 - 59
    prevSecond = s; //re records the currents second as the previous second
  }

  if (s == 60) { //When my second equals 60, I change my scale change back to min scale which is 1 (popping effect)
    scaleChange = minScale;
  }

  drawClock(h, m, s, hourSize, minuteSize, secondSize);
}
void drawClock(int h, int m, int s, float hourSize, float minuteSize, float secondSize) {
  fill(255);
  float y = height / 2; // divided by two because I want it to be in the center


  textFont(font);   // Set the custom font

  
  textSize(hourSize); //this changes accordging to the below calcualtion with nf() every hour
  float hourWidth = textWidth(nf(h, 2)); //Meusures my hour numbers width (always has the number as 2 digits)
  // I use these to make sure they touch each other and get pushed out as the other ones grow
  textSize(minuteSize);
  float minuteWidth = textWidth(nf(m, 2));

  textSize(secondSize);
  float secondWidth = textWidth(nf(s, 2));


  float totalWidth = hourWidth + minuteWidth + secondWidth;  // Calculating my total width with all my numbers because I need this to center everythign
  float startX = (width - totalWidth) / 2; // Leaving even spacing between left and right by dividing my remaingin width in 2

  float xHour = startX; //my x for hour text will start here at evenly spaced left edge
  float xMinute = xHour + hourWidth;   //whatever my hour's width is I add that to my start to make sure the minute always touches it
  float xSecond = xMinute + minuteWidth; // Same thing with seconds

  
  fill(0); 
  textSize(hourSize); //drawing my text at the correct punto according to its time value
  text(nf(h, 2), xHour, y); // getting custom (moving_ x value, y is always the same since I want them centered

  textSize(minuteSize);
  text(nf(m, 2), xMinute, y);

  textSize(secondSize);
  text(nf(s, 2), xSecond, y);
}
