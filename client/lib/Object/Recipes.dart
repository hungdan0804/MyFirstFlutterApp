class Recipes {
  final List<String> payload;
  final String msg;

  Recipes({this.msg,this.payload});

  factory  Recipes.fromJson(List<dynamic> json) {
    List<dynamic> data = [];
    String mesg = "";
    json.forEach((element) {
      data.addAll(element['payload']);
      mesg = element['msg'];
    });
    List<String>newData = data.cast<String>().toList();
    return  Recipes(
      msg: mesg,
      payload: newData
    );
  }
}