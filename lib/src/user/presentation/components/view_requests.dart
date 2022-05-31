import 'package:flutter/material.dart';
import 'package:nfc/src/common/presentation/components/heading_widget.dart';

class ViewRequests extends StatelessWidget {
  const ViewRequests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeadingWidget(text: 'Requests'),
        const SizedBox(height: 8),
        ListTile(
          leading: const CircleAvatar(
            backgroundImage:
                NetworkImage('https://i.ibb.co/SRJPnLc/profile-pic.png'),
          ),
          title: const Text('Taher Abdullah'),
          subtitle: const Text('Wants to view your SSC certificate'),
          trailing: OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(50, 50),
            ),
            onPressed: () {},
            child: const Text('Accept'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        ListTile(
          leading: const CircleAvatar(
            backgroundImage:
                NetworkImage('https://i.ibb.co/6HyT0hG/Shehjad-Profile-1.png'),
          ),
          title: const Text('Shehjad Ali'),
          subtitle: const Text('Wants to view your JSC certificate'),
          trailing: OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(50, 50),
            ),
            onPressed: () {},
            child: const Text('Accept'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
  }
}
