class TravelModel {
  int totalCount;
  List<ResultList> resultList;

  TravelModel({ this.totalCount, this.resultList});

  TravelModel.fromJson(Map<String, dynamic> json) {
  
    totalCount = json['totalCount'];
    if (json['resultList'] != null) {
      resultList = new List<ResultList>();
      json['resultList'].forEach((v) {
        resultList.add(new ResultList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
 
    data['totalCount'] = this.totalCount;
    if (this.resultList != null) {
      data['resultList'] = this.resultList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultList {
  int type;
  Article article;

  ResultList({this.type, this.article});

  ResultList.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    article =
        json['article'] != null ? new Article.fromJson(json['article']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.article != null) {
      data['article'] = this.article.toJson();
    }
    return data;
  }
}

class Article {
  int articleId;
  int productType;
  int sourceType;
  String articleTitle;
  String articleDesc;
  Author author;
  List<Images> images;
  bool hasVideo;
  int readCount;
  int likeCount;
  int commentCount;
  int shareCount;
  List<Urls> urls;
  List<Tags> tags;
  List<Topics> topics;
  List<Pois> pois;
  String publishTime;
  String publishTimeDisplay;
  String shootTime;
  String shootTimeDisplay;
  String sourceInfo;
  int level;
  String distanceText;
  bool isLike;
  int imageCounts;
  bool isCollected;
  int collectCount;
  int articleStatus;
  String poiName;
  ShareInfo shareInfo;
  String currentDate;
  int sourceId;

  Article(
      {this.articleId,
      this.productType,
      this.sourceType,
      this.articleTitle,
      this.articleDesc,
      this.author,
      this.images,
      this.hasVideo,
      this.readCount,
      this.likeCount,
      this.commentCount,
      this.shareCount,
      this.urls,
      this.tags,
      this.topics,
      this.pois,
      this.publishTime,
      this.publishTimeDisplay,
      this.shootTime,
      this.shootTimeDisplay,
      this.sourceInfo,
      this.level,
      this.distanceText,
      this.isLike,
      this.imageCounts,
      this.isCollected,
      this.collectCount,
      this.articleStatus,
      this.poiName,
      this.shareInfo,
      this.currentDate,
      this.sourceId});

  Article.fromJson(Map<String, dynamic> json) {
    articleId = json['articleId'];
    productType = json['productType'];
    sourceType = json['sourceType'];
    articleTitle = json['articleTitle'];
    articleDesc = json['articleDesc'];
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    hasVideo = json['hasVideo'];
    readCount = json['readCount'];
    likeCount = json['likeCount'];
    commentCount = json['commentCount'];
    shareCount = json['shareCount'];
    if (json['urls'] != null) {
      urls = new List<Urls>();
      json['urls'].forEach((v) {
        urls.add(new Urls.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = new List<Tags>();
      json['tags'].forEach((v) {
        tags.add(new Tags.fromJson(v));
      });
    }
    if (json['topics'] != null) {
      topics = new List<Topics>();
      json['topics'].forEach((v) {
        topics.add(new Topics.fromJson(v));
      });
    }
    if (json['pois'] != null) {
      pois = new List<Pois>();
      json['pois'].forEach((v) {
        pois.add(new Pois.fromJson(v));
      });
    }
    publishTime = json['publishTime'];
    publishTimeDisplay = json['publishTimeDisplay'];
    shootTime = json['shootTime'];
    shootTimeDisplay = json['shootTimeDisplay'];
    sourceInfo = json['sourceInfo'];
    level = json['level'];
    distanceText = json['distanceText'];
    isLike = json['isLike'];
    imageCounts = json['imageCounts'];
    isCollected = json['isCollected'];
    collectCount = json['collectCount'];
    articleStatus = json['articleStatus'];
    poiName = json['poiName'];
    shareInfo = json['shareInfo'] != null
        ? new ShareInfo.fromJson(json['shareInfo'])
        : null;
    currentDate = json['currentDate'];
    sourceId = json['sourceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['articleId'] = this.articleId;
    data['productType'] = this.productType;
    data['sourceType'] = this.sourceType;
    data['articleTitle'] = this.articleTitle;
    data['articleDesc'] = this.articleDesc;
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    data['hasVideo'] = this.hasVideo;
    data['readCount'] = this.readCount;
    data['likeCount'] = this.likeCount;
    data['commentCount'] = this.commentCount;
    data['shareCount'] = this.shareCount;
    if (this.urls != null) {
      data['urls'] = this.urls.map((v) => v.toJson()).toList();
    }
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    if (this.topics != null) {
      data['topics'] = this.topics.map((v) => v.toJson()).toList();
    }
    if (this.pois != null) {
      data['pois'] = this.pois.map((v) => v.toJson()).toList();
    }
    data['publishTime'] = this.publishTime;
    data['publishTimeDisplay'] = this.publishTimeDisplay;
    data['shootTime'] = this.shootTime;
    data['shootTimeDisplay'] = this.shootTimeDisplay;
    data['sourceInfo'] = this.sourceInfo;
    data['level'] = this.level;
    data['distanceText'] = this.distanceText;
    data['isLike'] = this.isLike;
    data['imageCounts'] = this.imageCounts;
    data['isCollected'] = this.isCollected;
    data['collectCount'] = this.collectCount;
    data['articleStatus'] = this.articleStatus;
    data['poiName'] = this.poiName;
    if (this.shareInfo != null) {
      data['shareInfo'] = this.shareInfo.toJson();
    }
    data['currentDate'] = this.currentDate;
    data['sourceId'] = this.sourceId;
    return data;
  }
}

class Author {
  int authorId;
  String nickName;
  String describe;
  String clientAuth;
  String jumpUrl;
  CoverImage coverImage;
  String tag;
  int followCount;
  String qualification;
  int identityType;
  String identityTypeName;
  List<UserTags> userTags;

  Author(
      {this.authorId,
      this.nickName,
      this.describe,
      this.clientAuth,
      this.jumpUrl,
      this.coverImage,
      this.tag,
      this.followCount,
      this.qualification,
      this.identityType,
      this.identityTypeName,
      this.userTags});

  Author.fromJson(Map<String, dynamic> json) {
    authorId = json['authorId'];
    nickName = json['nickName'];
    describe = json['describe'];
    clientAuth = json['clientAuth'];
    jumpUrl = json['jumpUrl'];
    coverImage = json['coverImage'] != null
        ? new CoverImage.fromJson(json['coverImage'])
        : null;
    tag = json['tag'];
    followCount = json['followCount'];
    qualification = json['qualification'];
    identityType = json['identityType'];
    identityTypeName = json['identityTypeName'];
    if (json['userTags'] != null) {
      userTags = new List<UserTags>();
      json['userTags'].forEach((v) {
        userTags.add(new UserTags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authorId'] = this.authorId;
    data['nickName'] = this.nickName;
    data['describe'] = this.describe;
    data['clientAuth'] = this.clientAuth;
    data['jumpUrl'] = this.jumpUrl;
    if (this.coverImage != null) {
      data['coverImage'] = this.coverImage.toJson();
    }
    data['tag'] = this.tag;
    data['followCount'] = this.followCount;
    data['qualification'] = this.qualification;
    data['identityType'] = this.identityType;
    data['identityTypeName'] = this.identityTypeName;
    if (this.userTags != null) {
      data['userTags'] = this.userTags.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CoverImage {
  String dynamicUrl;
  String originalUrl;

  CoverImage({this.dynamicUrl, this.originalUrl});

  CoverImage.fromJson(Map<String, dynamic> json) {
    dynamicUrl = json['dynamicUrl'];
    originalUrl = json['originalUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dynamicUrl'] = this.dynamicUrl;
    data['originalUrl'] = this.originalUrl;
    return data;
  }
}

class UserTags {
  int tagType;
  String tagName;
  String tagDesc;
  String appUrl;
  String h5Url;
  String wxUrl;

  UserTags(
      {this.tagType,
      this.tagName,
      this.tagDesc,
      this.appUrl,
      this.h5Url,
      this.wxUrl});

  UserTags.fromJson(Map<String, dynamic> json) {
    tagType = json['tagType'];
    tagName = json['tagName'];
    tagDesc = json['tagDesc'];
    appUrl = json['appUrl'];
    h5Url = json['h5Url'];
    wxUrl = json['wxUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tagType'] = this.tagType;
    data['tagName'] = this.tagName;
    data['tagDesc'] = this.tagDesc;
    data['appUrl'] = this.appUrl;
    data['h5Url'] = this.h5Url;
    data['wxUrl'] = this.wxUrl;
    return data;
  }
}

class Images {
  int imageId;
  String dynamicUrl;
  String originalUrl;
  double width;
  double height;
  int mediaType;
  double lat;
  double lon;
  bool isWaterMarked;

  Images(
      {this.imageId,
      this.dynamicUrl,
      this.originalUrl,
      this.width,
      this.height,
      this.mediaType,
      this.lat,
      this.lon,
      this.isWaterMarked});

  Images.fromJson(Map<String, dynamic> json) {
    imageId = json['imageId'];
    dynamicUrl = json['dynamicUrl'];
    originalUrl = json['originalUrl'];
    //_TypeError (type 'double' is not a subtype of type 'int')

    width = json['width'];
    height = json['height'];
    mediaType = json['mediaType'];
    lat = json['lat'];
    lon = json['lon'];
    isWaterMarked = json['isWaterMarked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageId'] = this.imageId;
    data['dynamicUrl'] = this.dynamicUrl;
    data['originalUrl'] = this.originalUrl;
    data['width'] = this.width;
    data['height'] = this.height;
    data['mediaType'] = this.mediaType;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['isWaterMarked'] = this.isWaterMarked;
    return data;
  }
}

class Urls {
  String version;
  String appUrl;
  String h5Url;
  String wxUrl;

  Urls({this.version, this.appUrl, this.h5Url, this.wxUrl});

  Urls.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    appUrl = json['appUrl'];
    h5Url = json['h5Url'];
    wxUrl = json['wxUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['version'] = this.version;
    data['appUrl'] = this.appUrl;
    data['h5Url'] = this.h5Url;
    data['wxUrl'] = this.wxUrl;
    return data;
  }
}

class Tags {
  int tagId;
  String tagName;
  int tagLevel;
  int parentTagId;
  int source;
  int sortIndex;

  Tags(
      {this.tagId,
      this.tagName,
      this.tagLevel,
      this.parentTagId,
      this.source,
      this.sortIndex});

  Tags.fromJson(Map<String, dynamic> json) {
    tagId = json['tagId'];
    tagName = json['tagName'];
    tagLevel = json['tagLevel'];
    parentTagId = json['parentTagId'];
    source = json['source'];
    sortIndex = json['sortIndex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tagId'] = this.tagId;
    data['tagName'] = this.tagName;
    data['tagLevel'] = this.tagLevel;
    data['parentTagId'] = this.parentTagId;
    data['source'] = this.source;
    data['sortIndex'] = this.sortIndex;
    return data;
  }
}

class Topics {
  int topicId;
  String topicName;
  int level;
  Image image;
  Image iconImage;

  Topics(
      {this.topicId, this.topicName, this.level, this.image, this.iconImage});

  Topics.fromJson(Map<String, dynamic> json) {
    topicId = json['topicId'];
    topicName = json['topicName'];
    level = json['level'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    iconImage = json['iconImage'] != null
        ? new Image.fromJson(json['iconImage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['topicId'] = this.topicId;
    data['topicName'] = this.topicName;
    data['level'] = this.level;
    if (this.image != null) {
      data['image'] = this.image.toJson();
    }
    if (this.iconImage != null) {
      data['iconImage'] = this.iconImage.toJson();
    }
    return data;
  }
}

class Image {
  int imageId;
  String dynamicUrl;
  String originalUrl;
  double width;
  double height;
  int mediaType;
  double lat;
  double lon;

  Image(
      {this.imageId,
      this.dynamicUrl,
      this.originalUrl,
      this.width,
      this.height,
      this.mediaType,
      this.lat,
      this.lon});

  Image.fromJson(Map<String, dynamic> json) {
    imageId = json['imageId'];
    dynamicUrl = json['dynamicUrl'];
    originalUrl = json['originalUrl'];
    width = json['width'];
    height = json['height'];
    mediaType = json['mediaType'];
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageId'] = this.imageId;
    data['dynamicUrl'] = this.dynamicUrl;
    data['originalUrl'] = this.originalUrl;
    data['width'] = this.width;
    data['height'] = this.height;
    data['mediaType'] = this.mediaType;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    return data;
  }
}

class Pois {
  int poiType;
  int poiId;
  String poiName;
  int businessId;
  int districtId;
  PoiExt poiExt;
  int source;
  int isMain;
  bool isInChina;
  String countryName;
  String districtName;
  String districtENName;

  Pois(
      {this.poiType,
      this.poiId,
      this.poiName,
      this.businessId,
      this.districtId,
      this.poiExt,
      this.source,
      this.isMain,
      this.isInChina,
      this.countryName,
      this.districtName,
      this.districtENName});

  Pois.fromJson(Map<String, dynamic> json) {
    poiType = json['poiType'];
    poiId = json['poiId'];
    poiName = json['poiName'];
    businessId = json['businessId'];
    districtId = json['districtId'];
    poiExt =
        json['poiExt'] != null ? new PoiExt.fromJson(json['poiExt']) : null;
    source = json['source'];
    isMain = json['isMain'];
    isInChina = json['isInChina'];
    countryName = json['countryName'];
    districtName = json['districtName'];
    districtENName = json['districtENName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['poiType'] = this.poiType;
    data['poiId'] = this.poiId;
    data['poiName'] = this.poiName;
    data['businessId'] = this.businessId;
    data['districtId'] = this.districtId;
    if (this.poiExt != null) {
      data['poiExt'] = this.poiExt.toJson();
    }
    data['source'] = this.source;
    data['isMain'] = this.isMain;
    data['isInChina'] = this.isInChina;
    data['countryName'] = this.countryName;
    data['districtName'] = this.districtName;
    data['districtENName'] = this.districtENName;
    return data;
  }
}

class PoiExt {
  String h5Url;
  String appUrl;

  PoiExt({this.h5Url, this.appUrl});

  PoiExt.fromJson(Map<String, dynamic> json) {
    h5Url = json['h5Url'];
    appUrl = json['appUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['h5Url'] = this.h5Url;
    data['appUrl'] = this.appUrl;
    return data;
  }
}

class ShareInfo {
  String imageUrl;
  String shareTitle;
  String shareContent;
  String platForm;
  String token;

  ShareInfo(
      {this.imageUrl,
      this.shareTitle,
      this.shareContent,
      this.platForm,
      this.token});

  ShareInfo.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    shareTitle = json['shareTitle'];
    shareContent = json['shareContent'];
    platForm = json['platForm'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['shareTitle'] = this.shareTitle;
    data['shareContent'] = this.shareContent;
    data['platForm'] = this.platForm;
    data['token'] = this.token;
    return data;
  }
}