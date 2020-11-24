class Subject{
  String category;
  List<SubCategory> subcategories;
  Subject(
      {
        this.category,this.subcategories
      }
  );

}

class SubCategory{
  String subcategory;
  SubCategory(
      {
        this.subcategory
      }
      );
}