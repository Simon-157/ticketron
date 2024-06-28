import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticketron/models/event_model.dart';
import 'package:ticketron/screens/event/register_event.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:ticketron/utils/helpers.dart';

class GetTicketScreen extends StatefulWidget {
  final Event event;

  GetTicketScreen({required this.event});

  @override
  _GetTicketScreenState createState() => _GetTicketScreenState();
}

class _GetTicketScreenState extends State<GetTicketScreen> {
  int _premiumTicketCount = 0;
  int _regularTicketCount = 0;

  int getTotalPrice() {
    return (widget.event.price.premiumPrice * _premiumTicketCount +
            widget.event.price.regularPrice * _regularTicketCount)
        .toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get a Ticket'),
         centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Logic for sharing the QR code
            },
            icon:  SvgPicture.asset(
              CustomIcons.menuVertical,
              height: 24,
            ),
          ),],
      ),
      body: Column(
        children: [
          DatePicker(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(Constants.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TicketTypeSection(
                    event: widget.event,
                    onPremiumCountChanged: (count) {
                      setState(() {
                        _premiumTicketCount = count;
                      });
                    },
                    onRegularCountChanged: (count) {
                      setState(() {
                        _regularTicketCount = count;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          TicketPurchaseSection(totalPrice: getTotalPrice(), event: widget.event,),
        ],
      ),
    );
  }
}

class DatePicker extends StatefulWidget {
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  int _selectedIndex = 0;

  final List<DateTime> _dates = List<DateTime>.generate(
    7,
    (i) => DateTime.now().add(Duration(days: i)),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: Constants.paddingMedium),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _dates.length,
        itemBuilder: (context, index) {
          final date = _dates[index];
          final isSelected = index == _selectedIndex;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
              width: 60,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isSelected ? Constants.primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(Constants.borderRadius),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    getMonthName(date.month),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date.day.toString(),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    getWeekDayName(date.weekday),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}

class TicketTypeSection extends StatefulWidget {
  final Event event;
  final Function(int) onPremiumCountChanged;
  final Function(int) onRegularCountChanged;

  TicketTypeSection({
    required this.event,
    required this.onPremiumCountChanged,
    required this.onRegularCountChanged,
  });

  @override
  _TicketTypeSectionState createState() => _TicketTypeSectionState();
}

class _TicketTypeSectionState extends State<TicketTypeSection> {
  int _selectedTicketTypeIndex = 0;
  int _premiumTicketCount = 0;
  int _regularTicketCount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose the ticket',
          style: Constants.heading3,
        ),
        const SizedBox(height: Constants.paddingMedium),
        _buildTicketTypeCard(
          index: 0,
          title: 'Premium price',
          event: widget.event,
          ticketCount: _premiumTicketCount,
          onIncrement: () {
            setState(() {
              _premiumTicketCount++;
              widget.onPremiumCountChanged(_premiumTicketCount);
            });
          },
          onDecrement: () {
            setState(() {
              if (_premiumTicketCount > 0) _premiumTicketCount--;
              widget.onPremiumCountChanged(_premiumTicketCount);
            });
          },
        ),
        const SizedBox(height: Constants.paddingMedium),
        _buildTicketTypeCard(
          index: 1,
          title: 'Regular price',
          event: widget.event,
          ticketCount: _regularTicketCount,
          onIncrement: () {
            setState(() {
              _regularTicketCount++;
              widget.onRegularCountChanged(_regularTicketCount);
            });
          },
          onDecrement: () {
            setState(() {
              if (_regularTicketCount > 0) _regularTicketCount--;
              widget.onRegularCountChanged(_regularTicketCount);
            });
          },
        ),
      ],
    );
  }

  Widget _buildTicketTypeCard({
    required int index,
    required String title,
    required Event event,
    required int ticketCount,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    final isSelected = _selectedTicketTypeIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTicketTypeIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? Constants.primaryColor.withOpacity(0.1)
              : Colors.white,
          border: Border.all(
            color: isSelected ? Constants.primaryColor : Colors.grey[300]!,
          ),
          borderRadius: BorderRadius.circular(Constants.borderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: Constants.paddingSmall,
                horizontal: Constants.paddingMedium,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? Constants.primaryColor
                    : const Color.fromARGB(17, 111, 112, 112),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(Constants.borderRadius),
                  topRight: Radius.circular(Constants.borderRadius),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (isSelected)
                    const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Constants.paddingSmall,
                horizontal: Constants.paddingSmall,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: event.images[0].url,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: Constants.paddingMedium),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event.title,
                              style: Constants.bodyText,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: Constants.paddingSmall),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${event.ticketsLeft} spot left',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(width: Constants.paddingMedium),
                                Padding(
                                    padding: const EdgeInsets.only(
                                      right: Constants.paddingSmall,
                                    ),
                                    child: Text(
                                      '\$${index == 0 ? event.price.premiumPrice : event.price.regularPrice}',
                                      style: Constants.bodyText,
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Constants.paddingSmall),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Show benefit',
                          style: TextStyle(
                            color: Constants.primaryColor,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove,
                                color: Colors.grey, size: 15),
                            onPressed: onDecrement,
                          ),
                          Text(ticketCount.toString()),
                          IconButton(
                            icon: const Icon(Icons.add,
                                color: Colors.grey, size: 15),
                            onPressed: onIncrement,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TicketPurchaseSection extends StatelessWidget {
  final int totalPrice;
  final Event event;

  TicketPurchaseSection({required this.totalPrice, required this.event});
  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.paddingLarge,
        vertical: Constants.paddingSmall,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '\$$totalPrice',
            style: Constants.heading3.copyWith(color: Constants.primaryColor),
          ),
          ElevatedButton(
            onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactInformationScreen(totalPrice: totalPrice, event: event,),
      ),
    );
  },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}
