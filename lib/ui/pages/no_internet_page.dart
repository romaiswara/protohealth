part of 'pages.dart';

class NoInternetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConnectionCubit>(
      create: (_) => ConnectionCubit(),
      child: BlocListener<ConnectionCubit, ConnectionInternetState>(
        listener: (context, state) {
          if (state is AvailableConnectionState) {
            Navigator.of(context).pop();
          }
        },
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'No Internet Connection',
                textAlign: TextAlign.center,
              ),
              BlocBuilder<ConnectionCubit, ConnectionInternetState>(
                builder: (context, state) {
                  return RaisedButton(
                    onPressed: () async {
                      if (state is AvailableConnectionState) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Try Again'),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
