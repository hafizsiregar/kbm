import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kbm/core/utils/source/assets.dart';
import 'package:kbm/core/utils/styles/colors.dart';
import 'package:kbm/features/domain/entities/faskes.dart';
import 'package:kbm/features/presentation/pages/scan/scan_page.dart';
import 'package:kbm/features/presentation/providers/clinic_list_notifier.dart';
import 'package:kbm/features/presentation/providers/hospitals_list_notifier.dart';
import 'package:kbm/features/presentation/widgets/custom_shimmer.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/enums/type_load_more.dart';
import '../detail/faskes_detail_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'home';

  const HomePage({Key? key,}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
    void initState() {
      super.initState();
      Future.microtask(() {
      Provider.of<HospitalsListNotifier>(context, listen: false)
      .fetchListHospitals();
      Provider.of<ClinicListNotifier>(context, listen: false)
      .fetchListClinic();
    });
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    String _selectedValue = 'Filter';
    
    Widget header() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Hi, Mursyid',
              style: GoogleFonts.roboto(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: BaseColor.primaryColor),
            ),
            Image.asset(BaseIcons.notifIcon, width: 25, height: 25),
            // SizedBox(
            //   child: Row(
            //     children: <Widget>[
            //       Image.asset(BaseIcons.notifIcon, width: 25, height: 25),
            //       const SizedBox(width: 15),
            //       InkWell(
            //           onTap: () {
            //             Navigator.pushNamed(context, ChatPage.routeName);
            //           },
            //           child: Image.asset(BaseIcons.messageIcon,
            //               width: 25, height: 25)),
            //     ],
            //   ),
            // ),
          ],
        ),
      );
    }

    Widget cardScan() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: 108,
        width: double.infinity,
        decoration: BoxDecoration(
            color: BaseColor.primaryColor,
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(BaseImages.scanBackground),
            ),
            borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.only(top: 18, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Scan saat berkunjung ke Faskes',
                style: GoogleFonts.roboto(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 14),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ScanPage.routeName);
                },
                child: Container(
                  height: 43,
                  width: 171,
                  decoration: BoxDecoration(
                      color: BaseColor.kWhiteColor,
                      borderRadius: BorderRadius.circular(26)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        BaseIcons.scanIcon,
                        width: 31,
                        height: 31,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'SCAN QR CODE',
                        style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: BaseColor.primaryColor),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget service() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Pelayanan',
              style: GoogleFonts.roboto(
                fontSize: 20,
                color: BaseColor.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Lihat Semua',
              style: GoogleFonts.roboto(
                fontSize: 14,
                color: BaseColor.kBlueColor,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      );
    }

    // Tinggal merubah warna dari text label
    Widget toggleService() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 25,
              width: 230,
              decoration: BoxDecoration(
                color: BaseColor.kWhiteColor,
                borderRadius: BorderRadius.circular(200),
                border: Border.all(color: BaseColor.primaryColor, width: 1),
              ),
              child: TabBar(
                labelColor: BaseColor.kWhiteColor,
                unselectedLabelColor: BaseColor.primaryColor,
                controller: _tabController,
                indicator: BoxDecoration(
                    color: BaseColor.primaryColor,
                    borderRadius: BorderRadius.circular(200)),
                tabs: const [Tab(text: 'Klinik'), Tab(text: 'Rumah Sakit')],
              ),
            ),
            Container(
              height: 25,
              width: 91,
              decoration: BoxDecoration(
                  color: BaseColor.primaryColor,
                  borderRadius: BorderRadius.circular(100)),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                    style: const TextStyle(color: BaseColor.kWhiteColor),
                    value: _selectedValue,
                    icon: Image.asset(BaseIcons.sortDownIcon),
                    items: const [
                      DropdownMenuItem(
                        value: 'Filter',
                        child: Text(
                          'Filter',
                          style: TextStyle(color: BaseColor.kBlackColor),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Sort',
                        child: Text(
                          'Sort',
                          style: TextStyle(color: BaseColor.kBlackColor),
                        ),
                      ),
                    ],
                    onChanged: (String? value) {
                      setState(() {
                        _selectedValue = value!;
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget cardService(context) {
      return SizedBox(
        height: 240,
        width: double.infinity,
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(), 
          controller: _tabController,
          children: [
            Consumer<ClinicListNotifier>(
              builder: (context, data, child) {
                final state = data.listFaskesState;
                if (state == TypeLoadMore.LOADING) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: faskesWithShimmer(data.listFaskes));
                } else if (state == TypeLoadMore.FAILURE) {
                  return Center(
                    child: Text(data.message),
                  );
                } else if (state == TypeLoadMore.LOADED){
                  return FaskesList(faskes: data.listFaskes);
                } else {
                  return const Center(
                    child: Text('Gagal memuat data'),
                  );
                }
              },
            ),
            Consumer<HospitalsListNotifier>(
              builder: (context, data, child) {
                final state = data.listFaskesState;
                if (state == TypeLoadMore.LOADING) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: faskesWithShimmer(data.listFaskes));
                } else if (state == TypeLoadMore.FAILURE) {
                  return Center(
                    child: Text(data.message),
                  );
                } else if (state == TypeLoadMore.LOADED){
                  return FaskesList(faskes: data.listFaskes);
                } else {
                  return const Center(
                    child: Text('Gagal memuat data'),
                  );
                }
              },
            ),
          ],
        ),
      );
    }

    Widget cardSlider() {
      return CarouselSlider(
        options: CarouselOptions(
          height: 170,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 10),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          // enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        items: [1, 2, 3, 4, 5].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: 330,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: BaseColor.kWhiteColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    BaseImages.slideImage1,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        }).toList(),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 25),
              header(),
              const SizedBox(height: 25),
              cardScan(),
              const SizedBox(height: 16),
              service(),
              const SizedBox(height: 18),
              toggleService(),
              const SizedBox(height: 25),
              cardService(context),
              const SizedBox(height: 25),
              cardSlider(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget faskesWithShimmer(List<Faskes> faskes) => ListView.builder(
  shrinkWrap: true,
  physics: const BouncingScrollPhysics(),
  scrollDirection: Axis.horizontal,
  itemCount: faskes.length,
  itemBuilder: (context, index) {
    return Column(
      children: <Widget>[
        CustomShimmer.first(
          padding: const EdgeInsets.only(right: 20),
          width: 170, 
          height: 170, 
          borderRadius: BorderRadius.circular(10)
        ),
        const SizedBox(height: 10),
        CustomShimmer.second(
          padding: const EdgeInsets.only(right: 20),
          width: 170, 
          height: 16, 
          borderRadius: BorderRadius.circular(0)
        ),
        const SizedBox(height: 5),
        CustomShimmer.third(
          padding: const EdgeInsets.only(right: 20),
          width: 170, 
          height: 13, 
          borderRadius: BorderRadius.circular(0)
        ),
      ],
    );
  }
);

class FaskesList extends StatefulWidget {
  final List<Faskes> faskes;
  const FaskesList({
    Key? key,
    required this.faskes,
  }) : super(key: key);

  @override
  State<FaskesList> createState() => _FaskesListState();
}

class _FaskesListState extends State<FaskesList> {

  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    Future.delayed(const Duration(seconds: 3), () {
      if(!mounted) {
        return;
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _isLoading;
  }

  @override
  Widget build(BuildContext context) {
    int lengths = 200;
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(left: 20),
      scrollDirection: Axis.horizontal,
      itemCount: widget.faskes.length,
      itemBuilder: (context, index) {
        if(_isLoading) {
          return faskesWithShimmer(widget.faskes);
        } else {
        final listFaskes = widget.faskes[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(context, FaskesDetailPage.routeName);
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => FaskesDetailPage(
                      faskes: listFaskes,
                    ),
                  ));
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 170,
                  width: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(listFaskes.photoFaskesUrl!),
                        fit: BoxFit.cover),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Image.asset(BaseIcons.klinikIcon),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              listFaskes.name.length < lengths
              ? listFaskes.name.characters.take(lengths - 185).join() + '...'
              : listFaskes.name,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                fontSize: 18,
                color: BaseColor.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: <Widget>[
                Container(
                  height: 25,
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: BaseColor.kWhiteColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(BaseIcons.locationSmallIcon),
                      const SizedBox(width: 4),
                      Text(
                        '2 Km',
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: BaseColor.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 17),
                Row(
                  children: <Widget>[
                    Image.asset(BaseIcons.mapsIcon),
                    const SizedBox(width: 4),
                    Text(
                      listFaskes.address!.length < lengths
                      ? listFaskes.address!.characters.take(lengths - 190).join() + '...'
                      : listFaskes.address!,
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: BaseColor.primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
        }
      },
    );
  }
}