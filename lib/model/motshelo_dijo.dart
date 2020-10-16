class MotsheloDijo {
  String n;
  String id;
  int lb;
  int i;
  int b;
  int c;
  int p;
  String m;

  MotsheloDijo(
      {this.n, this.id, this.lb, this.i, this.b, this.c, this.p, this.m});

  MotsheloDijo.fromJson(Map<String, dynamic> json) {
    n = json['n'];
    id = json['id'];
    lb = json['lb'];
    i = json['i'];
    b = json['b'];
    c = json['c'];
    p = json['p'];
    m = json['m'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['n'] = this.n;
    data['id'] = this.id;
    data['lb'] = this.lb;
    data['i'] = this.i;
    data['b'] = this.b;
    data['c'] = this.c;
    data['p'] = this.p;
    data['m'] = this.m;
    return data;
  }
}
