import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class WallHomePage extends StatelessWidget {
  const WallHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.black,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Image.asset('images/menu_icon.png'),
          elevation: 0,
          backgroundColor: Colors.transparent,
          brightness: Brightness.light,
          actions: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, left: 32, right: 32),
              height: 30,
              child: Container(
                height: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45),
                  color: Color(0x50F02D2D),
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 8),
                      child: Text(
                        'Search',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFF02D2D),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 16),
                      child: Icon(
                        Icons.search,
                        color: Color(0xFFF02D2D),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),

        // backgroundColor: Colors.black,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child: Icon(Icons.add),
          onPressed: () {},
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          shape: CircularNotchedRectangle(),
          child: Container(
            color: Colors.black,
            // height: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: Colors.white,
                          // size: 32,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Home',
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                        )
                      ],
                    ),
                    // onPressed: () {},
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.favorite,
                          color: Colors.grey,
                          // size: 32,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Favourites',
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                        )
                      ],
                    ),
                    // onPressed: () {},
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.image,
                          color: Colors.grey,
                          // size: 32,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'My Wallpapers',
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                        )
                      ],
                    ),
                    // onPressed: () {},
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.more_horiz,
                          color: Colors.grey,
                          // size: 32,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'More',
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                        )
                      ],
                    ),
                    // onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Wallpapers(),
      ),
    );
  }
}



class Wallpapers extends StatelessWidget {
  const Wallpapers({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.white,
          child: ListView(
            // shrinkWrap: true,
            children: <Widget>[
              header(),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                child: Text(
                  'Free stunning walls for you..',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              latestWalls(context),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                child: Text(
                  'Travel !',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                child: Text(
                  'Featuring travellers from around the world as they explore destinations & adventures.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300
                  ),
                ),
              ),
              gridList(context)
            ],
          ),
        
      ),
    );
  }
}

Widget latestWalls(context) {
  return Container(
    padding: EdgeInsets.only(left: 8),
    height: MediaQuery.of(context).size.width * 0.85,
    child: FutureBuilder(
      future: getImages(type: 'black cars'),
      builder: (BuildContext context, AsyncSnapshot<ImagesListModel> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        else if (snapshot.data != null)
          return ListView.builder(
            itemCount: snapshot.data.results.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (BuildContext listContext, index) {
              Result data = snapshot.data.results[index];
              return Container(
                height: MediaQuery.of(context).size.width * 0.75,
                width: MediaQuery.of(context).size.width * 0.50,
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(data.urls.small),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              );
            },
          );
        else
          return Container();
      },
    ),
  );
}

Widget gridList(context) {
  return Container(
    // height: 700,
    child: FutureBuilder(
      future: getImages(type: 'travel'),
      builder: (BuildContext context, AsyncSnapshot<ImagesListModel> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        else if (snapshot.data != null)
          return StaggeredGridView.countBuilder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            itemCount: snapshot.data.results.length,
            itemBuilder: (BuildContext context, int index) {
              Result data = snapshot.data.results[index];
              return Container(
                height: MediaQuery.of(context).size.width * 0.75,
                width: MediaQuery.of(context).size.width * 0.50,
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(data.urls.small),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              );
            },
            staggeredTileBuilder: (int index) =>
                new StaggeredTile.count(2, index.isEven ? 3 : 1.5),
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 2.0,
          );
        else
          return Container();
      },
    ),
  );
}

Widget header() {
  return Container(
    height: 50,
    child: ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 16, right: 32),
          child: Text('Latest',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 32, right: 32),
          child: Text('Toplist',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w100,
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 32, right: 32),
          child: Text('Random',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w100,
              )),
        )
      ],
    ),
  );
}



ImagesListModel imagesListModelFromJson(String str) => ImagesListModel.fromJson(json.decode(str));

String imagesListModelToJson(ImagesListModel data) => json.encode(data.toJson());

class ImagesListModel {
    int total;
    int totalPages;
    List<Result> results;

    ImagesListModel({
        this.total,
        this.totalPages,
        this.results,
    });

    factory ImagesListModel.fromJson(Map<String, dynamic> json) => new ImagesListModel(
        total: json["total"] == null ? null : json["total"],
        totalPages: json["total_pages"] == null ? null : json["total_pages"],
        results: json["results"] == null ? null : new List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total == null ? null : total,
        "total_pages": totalPages == null ? null : totalPages,
        "results": results == null ? null : new List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    String id;
    DateTime createdAt;
    DateTime updatedAt;
    int width;
    int height;
    String color;
    String description;
    String altDescription;
    Urls urls;
    ResultLinks links;
    List<dynamic> categories;
    int likes;
    bool likedByUser;
    List<dynamic> currentUserCollections;
    User user;
    List<Tag> tags;

    Result({
        this.id,
        this.createdAt,
        this.updatedAt,
        this.width,
        this.height,
        this.color,
        this.description,
        this.altDescription,
        this.urls,
        this.links,
        this.categories,
        this.likes,
        this.likedByUser,
        this.currentUserCollections,
        this.user,
        this.tags,
    });

    factory Result.fromJson(Map<String, dynamic> json) => new Result(
        id: json["id"] == null ? null : json["id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        width: json["width"] == null ? null : json["width"],
        height: json["height"] == null ? null : json["height"],
        color: json["color"] == null ? null : json["color"],
        description: json["description"] == null ? null : json["description"],
        altDescription: json["alt_description"] == null ? null : json["alt_description"],
        urls: json["urls"] == null ? null : Urls.fromJson(json["urls"]),
        links: json["links"] == null ? null : ResultLinks.fromJson(json["links"]),
        categories: json["categories"] == null ? null : new List<dynamic>.from(json["categories"].map((x) => x)),
        likes: json["likes"] == null ? null : json["likes"],
        likedByUser: json["liked_by_user"] == null ? null : json["liked_by_user"],
        currentUserCollections: json["current_user_collections"] == null ? null : new List<dynamic>.from(json["current_user_collections"].map((x) => x)),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        tags: json["tags"] == null ? null : new List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "width": width == null ? null : width,
        "height": height == null ? null : height,
        "color": color == null ? null : color,
        "description": description == null ? null : description,
        "alt_description": altDescription == null ? null : altDescription,
        "urls": urls == null ? null : urls.toJson(),
        "links": links == null ? null : links.toJson(),
        "categories": categories == null ? null : new List<dynamic>.from(categories.map((x) => x)),
        "likes": likes == null ? null : likes,
        "liked_by_user": likedByUser == null ? null : likedByUser,
        "current_user_collections": currentUserCollections == null ? null : new List<dynamic>.from(currentUserCollections.map((x) => x)),
        "user": user == null ? null : user.toJson(),
        "tags": tags == null ? null : new List<dynamic>.from(tags.map((x) => x.toJson())),
    };
}

class ResultLinks {
    String self;
    String html;
    String download;
    String downloadLocation;

    ResultLinks({
        this.self,
        this.html,
        this.download,
        this.downloadLocation,
    });

    factory ResultLinks.fromJson(Map<String, dynamic> json) => new ResultLinks(
        self: json["self"] == null ? null : json["self"],
        html: json["html"] == null ? null : json["html"],
        download: json["download"] == null ? null : json["download"],
        downloadLocation: json["download_location"] == null ? null : json["download_location"],
    );

    Map<String, dynamic> toJson() => {
        "self": self == null ? null : self,
        "html": html == null ? null : html,
        "download": download == null ? null : download,
        "download_location": downloadLocation == null ? null : downloadLocation,
    };
}

class Tag {
    String title;

    Tag({
        this.title,
    });

    factory Tag.fromJson(Map<String, dynamic> json) => new Tag(
        title: json["title"] == null ? null : json["title"],
    );

    Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
    };
}

class Urls {
    String raw;
    String full;
    String regular;
    String small;
    String thumb;

    Urls({
        this.raw,
        this.full,
        this.regular,
        this.small,
        this.thumb,
    });

    factory Urls.fromJson(Map<String, dynamic> json) => new Urls(
        raw: json["raw"] == null ? null : json["raw"],
        full: json["full"] == null ? null : json["full"],
        regular: json["regular"] == null ? null : json["regular"],
        small: json["small"] == null ? null : json["small"],
        thumb: json["thumb"] == null ? null : json["thumb"],
    );

    Map<String, dynamic> toJson() => {
        "raw": raw == null ? null : raw,
        "full": full == null ? null : full,
        "regular": regular == null ? null : regular,
        "small": small == null ? null : small,
        "thumb": thumb == null ? null : thumb,
    };
}

class User {
    String id;
    DateTime updatedAt;
    String username;
    String name;
    String firstName;
    String lastName;
    String twitterUsername;
    String portfolioUrl;
    String bio;
    String location;
    UserLinks links;
    ProfileImage profileImage;
    String instagramUsername;
    int totalCollections;
    int totalLikes;
    int totalPhotos;
    bool acceptedTos;

    User({
        this.id,
        this.updatedAt,
        this.username,
        this.name,
        this.firstName,
        this.lastName,
        this.twitterUsername,
        this.portfolioUrl,
        this.bio,
        this.location,
        this.links,
        this.profileImage,
        this.instagramUsername,
        this.totalCollections,
        this.totalLikes,
        this.totalPhotos,
        this.acceptedTos,
    });

    factory User.fromJson(Map<String, dynamic> json) => new User(
        id: json["id"] == null ? null : json["id"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        username: json["username"] == null ? null : json["username"],
        name: json["name"] == null ? null : json["name"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        twitterUsername: json["twitter_username"] == null ? null : json["twitter_username"],
        portfolioUrl: json["portfolio_url"] == null ? null : json["portfolio_url"],
        bio: json["bio"] == null ? null : json["bio"],
        location: json["location"] == null ? null : json["location"],
        links: json["links"] == null ? null : UserLinks.fromJson(json["links"]),
        profileImage: json["profile_image"] == null ? null : ProfileImage.fromJson(json["profile_image"]),
        instagramUsername: json["instagram_username"] == null ? null : json["instagram_username"],
        totalCollections: json["total_collections"] == null ? null : json["total_collections"],
        totalLikes: json["total_likes"] == null ? null : json["total_likes"],
        totalPhotos: json["total_photos"] == null ? null : json["total_photos"],
        acceptedTos: json["accepted_tos"] == null ? null : json["accepted_tos"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "username": username == null ? null : username,
        "name": name == null ? null : name,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "twitter_username": twitterUsername == null ? null : twitterUsername,
        "portfolio_url": portfolioUrl == null ? null : portfolioUrl,
        "bio": bio == null ? null : bio,
        "location": location == null ? null : location,
        "links": links == null ? null : links.toJson(),
        "profile_image": profileImage == null ? null : profileImage.toJson(),
        "instagram_username": instagramUsername == null ? null : instagramUsername,
        "total_collections": totalCollections == null ? null : totalCollections,
        "total_likes": totalLikes == null ? null : totalLikes,
        "total_photos": totalPhotos == null ? null : totalPhotos,
        "accepted_tos": acceptedTos == null ? null : acceptedTos,
    };
}

class UserLinks {
    String self;
    String html;
    String photos;
    String likes;
    String portfolio;
    String following;
    String followers;

    UserLinks({
        this.self,
        this.html,
        this.photos,
        this.likes,
        this.portfolio,
        this.following,
        this.followers,
    });

    factory UserLinks.fromJson(Map<String, dynamic> json) => new UserLinks(
        self: json["self"] == null ? null : json["self"],
        html: json["html"] == null ? null : json["html"],
        photos: json["photos"] == null ? null : json["photos"],
        likes: json["likes"] == null ? null : json["likes"],
        portfolio: json["portfolio"] == null ? null : json["portfolio"],
        following: json["following"] == null ? null : json["following"],
        followers: json["followers"] == null ? null : json["followers"],
    );

    Map<String, dynamic> toJson() => {
        "self": self == null ? null : self,
        "html": html == null ? null : html,
        "photos": photos == null ? null : photos,
        "likes": likes == null ? null : likes,
        "portfolio": portfolio == null ? null : portfolio,
        "following": following == null ? null : following,
        "followers": followers == null ? null : followers,
    };
}

class ProfileImage {
    String small;
    String medium;
    String large;

    ProfileImage({
        this.small,
        this.medium,
        this.large,
    });

    factory ProfileImage.fromJson(Map<String, dynamic> json) => new ProfileImage(
        small: json["small"] == null ? null : json["small"],
        medium: json["medium"] == null ? null : json["medium"],
        large: json["large"] == null ? null : json["large"],
    );

    Map<String, dynamic> toJson() => {
        "small": small == null ? null : small,
        "medium": medium == null ? null : medium,
        "large": large == null ? null : large,
    };
}


Future<ImagesListModel> getImages({String type}) async {
  final res = await http.get(
      'https://api.unsplash.com//search/photos/?client_id=3b1df5538a261c90edc00b184736b38859226d215482386c9b3fc00c5ec094a2&query=$type');

  if (res.statusCode == 200) {
    print(res.body);
    return imagesListModelFromJson(res.body);
  } else
    return null;
}

// Future<List<CollectionListModel>> getCollection() async {
//   final res = await http.get(
//       'https://api.unsplash.com/collections/featured?page=1&client_id=3b1df5538a261c90edc00b184736b38859226d215482386c9b3fc00c5ec094a2');

//   if (res.statusCode == 200) {
//     print(res.body);
//     return collectionListModelFromJson(res.body);
//   } else
//     return null;
// }

