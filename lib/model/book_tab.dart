
import 'package:flutter_app1/page/book_list.dart';

/**
 * 定义TAB页对象  针对每个TAB也给不同的对象
 */
class BookTab{
  String text;
  BookList bookList;
  BookTab(this.text,this.bookList);
}