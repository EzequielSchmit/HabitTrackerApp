enum MyIcon {
  plus(iconName: "plus.svg"),
  completed(iconName: "complete-black.svg"),
  correct(iconName: "correct.svg"),
  incorrect(iconName: "incorrect.svg");
  final String iconName;
  const MyIcon({required this.iconName});
}