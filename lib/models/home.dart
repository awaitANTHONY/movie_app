class Menu {
  String? title;
  String? submenu;
  List<Tabs>? tabs;

  Menu({this.title, this.submenu, this.tabs});

  Menu.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    submenu = json['submenu'];
    if (json['tabs'] != null) {
      tabs = <Tabs>[];
      json['tabs'].forEach((v) {
        tabs!.add(Tabs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['submenu'] = submenu;
    if (tabs != null) {
      data['tabs'] = tabs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tabs {
  String? title;
  String? provider;
  List<String>? arguments;

  Tabs({this.title, this.provider, this.arguments});

  Tabs.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    provider = json['provider'];
    arguments = json['arguments'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['provider'] = provider;
    data['arguments'] = arguments;
    return data;
  }
}
