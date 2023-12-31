import 'package:claim_reg_frontend/enums/claim_status.dart';
import 'package:claim_reg_frontend/widgets/AppCard.dart';
import 'package:flutter/material.dart';

import '../models/Claim.dart';
import '../services/ClaimService.dart';
import '../widgets/BaseAppBar.dart';

class ClaimDetailsPage extends StatefulWidget {
  final String heading;
  final ClaimStatus claimStatus;
  const ClaimDetailsPage(
      {Key? key, required this.heading, required this.claimStatus})
      : super(key: key);

  @override
  State<ClaimDetailsPage> createState() => _ClaimDetailsPageState();
}

class _ClaimDetailsPageState extends State<ClaimDetailsPage> {
  List<Claim>? claims;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    claims = await ClaimService().getClaims(widget.claimStatus);
    if (claims != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: widget.heading,
        appBar: AppBar(),
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
          itemCount: claims?.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
              child: AppCard(valueList: [
                'id : ${claims![index].id.toString()}',
                'claimant : ${claims![index].claimant.name}',
                'approver : ${claims![index].approver.name}',
                'type : ${claims![index].type}',
                'currency : ${claims![index].currency}',
                'status : ${claims![index].status}',
              ]),
            );
          },
        ),
      ),
    );
  }
}
