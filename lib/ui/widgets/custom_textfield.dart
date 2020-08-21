part of 'widgets.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isReadOnly;
  final Function onChanged;
  final String hint;
  final bool isProfilePage;

  const CustomTextField(
      {Key key,
      this.textEditingController,
      this.isReadOnly,
      this.onChanged,
      this.hint, this.isProfilePage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textCapitalization:
          (isReadOnly) ? TextCapitalization.none : TextCapitalization.words,
      controller: textEditingController,
      readOnly: isReadOnly,
      onChanged: onChanged,
      style: GoogleFonts.montserratAlternates(
          color: SharedColor.COLOR_BLACK_400,
          fontSize: ConstantFontSize.FONT_SIZE_14_0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.45),
      decoration: InputDecoration(        
        contentPadding: EdgeInsets.symmetric(
          horizontal: ConstantSpace.SPACE_2_5,
          vertical: ConstantSpace.SPACE_2_2_5,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: SharedColor.COLOR_YELLOW_500, width: 1.5),
          borderRadius: BorderRadius.circular(ConstantSpace.SPACE_3),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ConstantSpace.SPACE_3)),
        hintText: hint,
        hintStyle: GoogleFonts.montserratAlternates(
            color: SharedColor.COLOR_BLACK_300,
            fontSize: ConstantFontSize.FONT_SIZE_14_0,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.45),
      ),
    );
  }
}
