part of 'widgets.dart';

class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "You're Not Logged In",
            style: GoogleFonts.montserratAlternates(
              color: SharedColor.COLOR_BLACK_400,
              fontSize: ConstantFontSize.FONT_SIZE_14_0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: ConstantSpace.SPACE_2),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: ConstantSpace.SPACE_5 * 2.75,
              ),
            child: ButtonTheme(    
              buttonColor: SharedColor.COLOR_YELLOW_400,          
              height: ConstantSpace.SPACE_6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ConstantSpace.SPACE_4)),
              padding: const EdgeInsets.symmetric(
                horizontal: ConstantSpace.SPACE_2,
                vertical: ConstantSpace.SPACE_1_5,
              ),
              child: RaisedButton(                
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => DashboardPage(
                              selectedIndex: 4,
                            )),
                    (route) => false,
                  );
                },
                child: Text(
                  'Login',
                  style: GoogleFonts.montserratAlternates(
                      color: SharedColor.COLOR_PRIMARY,
                      fontSize: ConstantFontSize.FONT_SIZE_14_0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.6),
                ),
                elevation: 0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
