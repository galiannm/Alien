class Screen {
  ArrayList<Widget> widgets;
  color backgroundColor;
  Screen(color backgroundColor)
  {
    this.widgets  = new ArrayList<Widget>();
    this.backgroundColor = backgroundColor;
  }

  void addWidget(Widget widget)
  {
    widgets.add(widget);
  }

  void draw()
  {
    background(backgroundColor);
    for (Widget widget : widgets)
    {
      widget.draw();
    }
  }
  void mouseMoved(int mX, int mY) {
    for (Widget widget : widgets) {
      int event = widget.getEvent(mX, mY);
      if (event != EVENT_NULL) {
        widget.isMouseOver = true;
      } else {
        widget.isMouseOver = false;
      }
    }
  }

  int getEvent(int mouseX, int mouseY)
  {
    for (Widget widget : widgets)
    {
      int event = widget.getEvent(mouseX, mouseY);
      if (event != EVENT_NULL)
        return event;
    }
    return EVENT_NULL;
  }
}
