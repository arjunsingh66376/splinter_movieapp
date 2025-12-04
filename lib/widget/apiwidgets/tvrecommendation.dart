import 'package:flutter/material.dart';
import 'package:movies_app/constant/customurl.dart';
import 'package:movies_app/model/movie.dart';
import 'package:movies_app/utils/context_extension.dart';

class Tvrecommendation extends StatelessWidget {
  final Future<List<Movie>> future;
  const Tvrecommendation({super.key, required this.future});

  final url = Customurl.baseImgUrl;

  @override
  Widget build(BuildContext context) {
    final screenh = context.h;
    final screenw = context.w;
    return FutureBuilder<List<Movie>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: const CircularProgressIndicator(color: Colors.red),
          );
        } else if (snapshot.hasError) {
          return Text('error : ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final moviedata = snapshot.data!;

          return SizedBox(
            height: screenh * 0.22,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: moviedata.length,
              itemBuilder: (context, index) {
                final m = moviedata[index];
                return Container(
                  width: screenw * 0.3,
                  // color: Colors.amber,
                  padding: EdgeInsets.only(left: 10, right: 10),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: screenh * 0.16,
                        width: screenw * 0.3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            '$url${m.posterpath}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        m.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
        return const Text('no movies found ');
      },
    );
  }
}
