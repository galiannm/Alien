class RadioButtonList{
  ArrayList<RadioButton> children;
  
  RadioButtonList()
  {
    children = new ArrayList<RadioButton>();
  }
  
  void addChildren(RadioButton radioButton)
  {
    children.add(radioButton);
    radioButton.parent = this;
  }
  
  void update()
  {
    for (RadioButton child : children)
    {
      child.isChecked = false;
    }
  }
}
