
import 'dart:convert';

Populares popularesFromJson(String str) => Populares.fromJson(json.decode(str));

class Populares {
    Populares({
        this.page,
        this.totalResults,
        this.totalPages,
        this.results,
    });

    int page;
    int totalResults;
    int totalPages;
    List<Pelicula> results;

    factory Populares.fromJson(Map<String, dynamic> json) => Populares(
        page: json["page"],
        totalResults: json["total_results"],
        totalPages: json["total_pages"],
        results: List<Pelicula>.from(json["results"].map((x) => Pelicula.fromJson(x))),
    );

}

class Pelicula {
    Pelicula({
        this.popularity,
        this.voteCount,
        this.video,
        this.posterPath,
        this.id,
        this.adult,
        this.backdropPath,
        this.originalTitle,
        this.genreIds,
        this.title,
        this.voteAverage,
        this.overview,
        this.releaseDate,
    });

    double popularity;
    int voteCount;
    bool video;
    String posterPath;
    int id;
    bool adult;
    String backdropPath;
    String originalTitle;
    List<int> genreIds;
    String title;
    double voteAverage;
    String overview;
    DateTime releaseDate;

    factory Pelicula.fromJson(Map<String, dynamic> json) => Pelicula(
        popularity: json["popularity"].toDouble(),
        voteCount: json["vote_count"],
        video: json["video"],
        posterPath: json["poster_path"],
        id: json["id"],
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        originalTitle: json["original_title"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        title: json["title"],
        voteAverage: json["vote_average"].toDouble(),
        overview: json["overview"],
        releaseDate: DateTime.parse(json["release_date"]),
    );

}


