class Widget {
  int x, y, w, h;
  String label;
  int event;
  color widgetColor, labelColor;
  PFont widgetFont;
  boolean isMouseOver; // Track if the mouse is over this widget
  int gap;

  Widget(int x, int y, int w, int h, String label, color widgetColor, PFont widgetFont, int event, int gap) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
    this.event = event;
    this.widgetColor = widgetColor;
    this.widgetFont = widgetFont;
    this.labelColor = color(0);
    this.gap = gap;
    isMouseOver = false;
  }

  void draw() {
    if (mouseIntercept(mouseX, mouseY)) {
      stroke(255); // White border if the mouse is over
    } else {
      stroke(0); // Black border otherwise
    }
    fill(widgetColor);
    rect(x, y, w, h);
    fill(labelColor);
    drawText();
  }

  void drawText()
  {
    textFont(widgetFont);
    text(label, x + gap, y + h - gap);
  }

  boolean mouseIntercept(int mX, int mY)
  {
    if (mX > x && mX < x + w && mY > y && mY < y + h)
      return true;
    else
      return false;
  }

  int getEvent(int mX, int mY) {
    if (mouseIntercept(mX, mY))
      return event;
    return EVENT_NULL;
  }
}

class Slider extends Widget {
  int lowerInterval, upperInterval;
  int barWidth, barHeight, sliderWidth, sliderHeight;
  int barX, barY;
  int x, y;
  int currentValue;
  boolean isDragging;
  Slider(int barX, int barY, int sliderWidth, int sliderHeight,
    int barWidth, int barHeight, color sliderColor, PFont sliderFont, int event, int gap)
  {
    super(barX, barY - sliderHeight / 2, barWidth, barHeight, "", sliderColor, sliderFont, event, gap);
    this.barX = barX;
    this.barY = barY;
    this.sliderWidth = sliderWidth;
    this.sliderHeight = sliderHeight;
    this.barWidth = barWidth;
    this.barHeight = barHeight;
    this.x = barX;
    this.y = barY - sliderHeight / 2;
    currentValue = 0;
    isDragging = false;
  }

  void draw()
  {
    noStroke();
    fill(180);
    rect(barX, barY, barWidth, barHeight, barHeight*0.4);
    fill(0);
    rect(x, y+sliderHeight/4, sliderWidth, sliderHeight, sliderHeight*0.5);
    drawText();
  }
  
  void drawText()
  {
    textFont(widgetFont);
    text("Slider :", barX, barY - 20);
    text(currentValue, barX + 55, barY - 20);
  }

  boolean mouseIntercept(int mX, int mY) {
    if (
      (mX > x && mX < x + sliderWidth && mY > y && mY < y + sliderHeight && mousePressed)) {
      return isDragging = true;
    }
    return isDragging = false;
  }

  void mouseDragged(int mX) {
    if (isDragging) {
      x = constrain(mX - sliderWidth / 2, barX, barX + barWidth - sliderWidth);
      currentValue = (int) map(x, barX, barX + barWidth - sliderWidth, 0, 100); // Map the sliderX position to a value between 0 and 100
    }
  }

  void mouseReleased() {
    isDragging = false;
  }
}

class Checkbox extends Widget {
  boolean isChecked;

  Checkbox(int x, int y, int size, String label, color widgetColor, PFont widgetFont, int event, int gap) {
    super(x, y, size, size, label, widgetColor, widgetFont, event, gap); // Assuming square shape for simplicity
    this.isChecked = false;
  }

  void draw() {
    super.draw();
    if (isChecked) {
      line(x, y, x + width, y + height);
      line(x, y + height, x + width, y);
    }
  }

  void drawText()
  {
    textFont(widgetFont);
    text(label, x + gap, y + gap);
  }

  boolean mouseIntercept(int mX, int mY) {
    if (super.mouseIntercept(mX, mY)) {
      isChecked = !isChecked;
      return true;
    }
    return false;
  }
}

class RadioButton extends Widget {
  boolean isChecked;
  RadioButtonList parent;
  RadioButton(int x, int y, int diameter, String label, color widgetColor, PFont widgetFont, int event, int gap) {
    super(x, y, diameter, diameter, label, widgetColor, widgetFont, event, gap); // Assuming circular shape for simplicity
    this.isChecked = false;
    parent = new RadioButtonList();
  }
  
  void draw() {
    super.draw();
    if (isChecked) {
      ellipse(x + width / 2, y + height / 2, width / 2, height / 2);
    }
  }

  void drawText()
  {
    textFont(widgetFont);
    text(label, x + gap, y + gap);
  }
  
  int getEvent(int mX, int mY) {
    if (mouseIntercept(mX, mY) && mousePressed)
    {
      parent.update();
      isChecked = true;
      return event;
    }
    return EVENT_NULL;
  }
}
