import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_ui/models/Diet.dart';
import 'package:flutter_ui/models/category.dart';
import 'package:flutter_ui/models/popular_diets.dart';

class FitnessPage extends StatefulWidget {
  const FitnessPage({Key? key}) : super(key: key);

  @override
  _FitnessPageState createState() => _FitnessPageState();
}

class _FitnessPageState extends State<FitnessPage> {
  List<CategoryModel> categories = [];
  List<DietModel> diets = [];
  List<PopularDietModel> popularDiets = [];

  void _getCategories() {
    setState(() {
      categories = CategoryModel.getCategories();
    });
  }

  void _getDiets() {
    setState(() {
      diets = DietModel.getDiets();
    });
  }

  void _getPopularDiets() {
    setState(() {
      popularDiets = PopularDietModel.getPopularDiets();
    });
  }

  void _fillLists() {
    _getCategories();
    _getDiets();
    _getPopularDiets();
  }

  @override
  void initState() {
    super.initState();
    _fillLists();
  }

  @override
  Widget build(BuildContext context) {
    _fillLists();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          _searchField(),
          const SizedBox(height: 40),
          _categoriesSection(),
          const SizedBox(height: 40),
          _dietsSection(),
          const SizedBox(height: 40),
          _popularDietSection(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Column _categoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Category',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Container(
          height: 150,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            separatorBuilder: (context, index) => const SizedBox(
              width: 20,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Container(
                width: 120,
                decoration: BoxDecoration(
                  color: categories[index].boxColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: SvgPicture.asset(
                          categories[index].iconPath,
                        ),
                      ),
                    ),
                    Text(
                      categories[index].name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Column _dietsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Recommendation\nfor Diet',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Container(
          height: 240,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            itemBuilder: (context, index) {
              return Container(
                width: 210,
                decoration: BoxDecoration(
                  color: diets[index].boxColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SvgPicture.asset(diets[index].iconPath),
                    Column(
                      children: <Widget>[
                        Text(
                          diets[index].name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${diets[index].level} | ${diets[index].duration} | ${diets[index].calorie}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xff7B6F72),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 45,
                      width: 130,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: diets[index].isViewSelected
                              ? [
                                  Color(0xff9DCEFF),
                                  Color(0xff92A3FD),
                                ]
                              : [
                                  Colors.transparent,
                                  Colors.transparent,
                                ],
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          'View',
                          style: TextStyle(
                            color: diets[index].isViewSelected
                                ? Colors.white
                                : Color(0xffC58BF2),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 25),
            itemCount: diets.length,
          ),
        ),
      ],
    );
  }

  Column _popularDietSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(
            left: 20,
          ),
          child: Text(
            'Popular',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 15),
        ListView.separated(
          itemCount: popularDiets.length,
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 20, right: 20),
          separatorBuilder: (context, index) => const SizedBox(height: 15),
          itemBuilder: (context, index) {
            return Container(
              height: 100,
              decoration: BoxDecoration(
                color: popularDiets[index].isBoxSelected
                    ? Colors.white
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                boxShadow: popularDiets[index].isBoxSelected
                    ? <BoxShadow>[
                        BoxShadow(
                          color: const Color(0xff1D1617).withOpacity(0.3),
                          offset: const Offset(0, 10),
                          blurRadius: 40,
                          spreadRadius: 0,
                        ),
                      ]
                    : [],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                    popularDiets[index].iconPath,
                    width: 65,
                    height: 65,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        popularDiets[index].name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '${popularDiets[index].level} | ${popularDiets[index].duration} | ${popularDiets[index].calorie}',
                        style: const TextStyle(
                          color: Color(0xff7B6F72),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset(
                      'assets/icons/button.svg',
                      width: 30,
                      height: 30,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

AppBar _appBar() {
  return AppBar(
    title: const Text(
      'Breakfast',
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,
    elevation: 0.0,
    backgroundColor: Colors.white,
    leading: GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F8F8),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          'assets/icons/arrow-left.svg',
          height: 20,
          width: 20,
        ),
      ),
    ),
    actions: <Widget>[
      GestureDetector(
        onTap: () {},
        child: Container(
          width: 37,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F8F8),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/icons/dots.svg',
            height: 5,
            width: 5,
          ),
        ),
      ),
    ],
  );
}

Container _searchField() {
  return Container(
    margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
    decoration: BoxDecoration(
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xff1D1617).withOpacity(0.11),
          blurRadius: 40,
          spreadRadius: 0.0,
        ),
      ],
    ),
    child: TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(15),
        hintText: 'Serach Pancakes',
        hintStyle: const TextStyle(
          color: Color(0xffDDDADA),
          fontSize: 14,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset('assets/icons/Search.svg'),
        ),
        suffixIcon: Container(
          width: 60,
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const VerticalDivider(
                  color: Colors.black,
                  indent: 10,
                  endIndent: 10,
                  thickness: 0.1,
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset('assets/icons/Filter.svg'),
                ),
              ],
            ),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}
