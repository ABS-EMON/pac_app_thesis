import 'package:flutter/material.dart';

class Desc extends StatelessWidget {
  const Desc(
      {required this.title,
      required this.price,
      required this.url,
      required this.desc,
      super.key,
      required this.brand,
      required this.serialNo,
      required this.mfgDate,
      required this.expDate,
      required this.sellStatus,
      required this.weight
      });


  final String title;
  final String price;
  final String url;
  final String desc;
  final String brand;
  final String serialNo;
  final String mfgDate;
  final String expDate;
  final String sellStatus;
  final String weight;

  @override
  Widget build(BuildContext context) {
    Color bg = sellStatus =="sold"? Colors.red : const Color(0xff10b981);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Details",
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff10b981),
      ),
      body: Center(
        child: ListView(
          children: [

            SizedBox(height: 300,width: 300, child: Image.network(url)),
            const SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),///Name
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(),
            ),///Divider
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  const Text(
                    "Brand  :  ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    brand,
                    style: const TextStyle(
                    //  fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  const Text(
                    "Weight  :  ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    weight,
                    style: const TextStyle(
                      //  fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  const Text(
                    "Mfg Date  :  ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    mfgDate,
                    style: const TextStyle(
                      //  fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  const Text(
                    "Exp Date  :  ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    expDate,
                    style: const TextStyle(
                      //  fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Price  :  ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        price,
                        style: const TextStyle(
                          //  fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: 25,
                      width: 120,
                      color: bg,
                      child: Center(
                        child: Text(
                          sellStatus.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(),
            ),
            const Center(
              child: Text(
                "Description",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),///description
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                child: Text(
                  desc,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
