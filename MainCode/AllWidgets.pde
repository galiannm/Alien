ArrayList<Widget> widgetList; 
Screen screen1, screen2, screen3;
Screen currentScreen;
PFont stdFont;
final int EVENT_BUTTON1 = 1;
final int EVENT_BUTTON2 = 2;
final int EVENT_BUTTON3 = 3;
final int EVENT_SLIDER_CHANGE = 4;
final int EVENT_NULL = 0;
Widget widgetButton1, widgetForward, widgetForward2, widgetButton2, widgetBackward;
Slider slider1;
Checkbox checkbox1;
RadioButton radioButton1, radioButton2;
RadioButtonList radiobuttons;
color colorRect = color(255, 255, 255); // Assuming this is for another part of your program

void setup() {
  size(400, 400);
  stdFont = createFont("Arial", 16); // Changed for compatibility; replace "Arial" with "Simple.otf" if you have that font
  widgetList = new ArrayList<Widget>();
  
  screen1 = new Screen(color(150));
  screen2 = new Screen(color(0));
  screen3 = new Screen(color(255));
  
  radiobuttons = new RadioButtonList();
  
  widgetButton1 = new Widget(100, 100, 100, 40, "Button 1", color(242, 135, 149), stdFont, EVENT_BUTTON2, 10);
  widgetForward = new Widget(100, 200, 100, 40, "Forward", color(141, 242, 135), stdFont, EVENT_BUTTON1, 10);
  widgetButton2 = new Widget(100, 100, 100, 40, "Button 2", color(135, 144, 242), stdFont, EVENT_BUTTON2, 10);
  widgetForward2 = new Widget(100, 200, 100, 40, "Forward", color(135, 239, 242), stdFont, EVENT_BUTTON3, 10);
  widgetBackward = new Widget(100, 50, 100, 40, "Backwards", color(135, 239, 242), stdFont, EVENT_BUTTON1, 10);
  
  slider1 = new Slider(50, 350, 20, 20, 300, 10, color(150), stdFont, EVENT_SLIDER_CHANGE, 10);
  checkbox1 = new Checkbox(50, 150, 20, "Check me", color(150), stdFont, EVENT_NULL, 21);
  
  radioButton1 = new RadioButton(50, 200, 20, "Option 1", color(150), stdFont, EVENT_NULL, 21);
  radioButton2 = new RadioButton(150, 200, 20, "Option 2", color(150), stdFont, EVENT_NULL, 21);
  
  radiobuttons.addChildren(radioButton1);
  radiobuttons.addChildren(radioButton2);
  
  screen1.addWidget(widgetButton1);
  screen1.addWidget(widgetForward);
  screen2.addWidget(widgetButton2);
  screen2.addWidget(widgetForward2);
  screen3.addWidget(widgetBackward);
  screen3.addWidget(slider1);
  screen3.addWidget(checkbox1);
  screen3.addWidget(radioButton1);
  screen3.addWidget(radioButton2);
  
  currentScreen = screen1;
}

void draw() {
  currentScreen.draw();
}

void mousePressed() {
  int event = currentScreen.getEvent(mouseX, mouseY);
  if (event == EVENT_BUTTON1)
  {
    currentScreen = (currentScreen == screen1)? screen2 : screen1;
  } else if (event == EVENT_BUTTON2){
    println(currentScreen == screen1? "Button 1 pressed" : "Button 2 pressed");
  } else if (event == EVENT_BUTTON3){
    currentScreen = (currentScreen == screen2)? screen3 : screen2;
  } else if (event == EVENT_SLIDER_CHANGE) {
    println("Slider value: " + slider1.currentValue); // Example of reacting to the slider change
  }
}

void mouseMoved() {
  currentScreen.mouseMoved(mouseX, mouseY);
}

void mouseDragged() {
  // This is crucial for the Slider functionality
  if (currentScreen == screen3) { // Assuming the slider is on screen3
    slider1.mouseDragged(mouseX);
  }
}

void mouseReleased() {
  // Necessary to stop dragging the Slider
  if (currentScreen == screen3);
}
