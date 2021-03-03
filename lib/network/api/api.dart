class Api {
  static final String HOST = "https://www.wanandroid.com";

  // 资讯列表
  static final String BOOK_LIST = HOST + "/article/list/";

  static final String BOOK_TAB = HOST + "/tree/json";
  static final String BOOK_DETAIL = HOST + "?action=detail&q=";

  static getArticleList(int page, int id) async {
    return '$BOOK_LIST$page/json?cid=$id'.toString();
  }
}
