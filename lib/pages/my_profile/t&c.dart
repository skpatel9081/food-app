import 'package:flutter/material.dart';
import 'package:food_app/constant/color/colors.dart';

class terms extends StatelessWidget {
  const terms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: App_Colors.Primary_Color,
        title: const Text("Terms and Condition"),
      ),
      backgroundColor: App_Colors.ScafoldeColor,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),
              Center(
                child: Text(
                  "TERMS AND CONDITIONS",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: text(
                    body:
                        "1.The Goods shall be delivered to the Clientat the DSF’s address.The risk in the Goods shall pass to the Clientupon such delivery takingplace."),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: text(
                    body:
                        "2.If the Clientproperly rejects any of the Goods which are not in accordance with the contract, the Clientshall nonetheless pay the fullPrice for such Goods unless the Clientgives notice of rejection to the DSFwithin 4 hours of the time of delivery and returns such Goods to the DSFwithin 24 hours of delivery."),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: text(
                    body:
                        "3.The Client will be provided an invoice for the items purchase.  The Client has 24 hours to contest any price level set.  After 24 hours, the prices are considered accepted and may not be contested or adjusted by the client."),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: text(
                    body:
                        "4.DSF reserve the right to not tosupply specific products, primarily if the supply is very short (unavailable in the market) or the Client believes DSF purchase price is set high."),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: text(
                    body:
                        "5.Any Goods deemed by the Clientas poor quality; the Clientmust keep the goods, un-touched for a possible collection by the DSF.  If on collection DSFdeems the goods to be of suitable condition for sale, the Clientmay be liable for Administration and or collectionfees."),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: text(
                    body:
                        "6.If for any reason beyond DSFreasonable control, DSF isunable to supply a particular item, DSFis not liable to the Client. Please note thatDSFwill attempt to deliver an equal or above equivalent product should the selected item be unavailable unless ClientrequestsDSFnot to doso."),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: text(
                    body:
                        "7.Under no circumstancesshall the liability of the Seller exceed thePrice of the Goods."),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class text extends StatelessWidget {
  const text({Key? key, required this.body}) : super(key: key);
  final String body;
  @override
  Widget build(BuildContext context) {
    return Text(
      body,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: 17,
      ),
    );
  }
}
