void loadNames() {
  styleName = new StringList();
  styleName.append("Blank");
  styleName.append("Box");
  styleName.append("Line Short [arrow keys]");
  styleName.append("Line Long [arrow keys]");
  styleName.append("Pull Pixels [r][g][b][a]");
  styleName.append("Push Pixels [r][g][b][a]");
  styleName.append("Remove Color Channel [r][g][b]");
  styleName.append("Noise");
  styleName.append("Invert");
  styleName.append("Posterize");
  styleName.append("Circle");
  println(styleName.get(1));

  filterName = new StringList();
  filterName.append("Blank");
  filterName.append("Vertical Blinds");
  filterName.append("Horizontal Blinds");
  filterName.append("Quilted");
  filterName.append("Pointillism (Uniform)");
  filterName.append("Pointillism (Random)");
}
