class EventDetail {
  String id;
  String _description;
  String _date;
  String _startTime;
  String _endTime;
  String _speaker;
  String _isFavourite;

  EventDetail(this.id, this._description, this._date, this._startTime,
      this._endTime, this._speaker, this._isFavourite);

  String get isFavourite => _isFavourite;

  String get speaker => _speaker;

  String get endTime => _endTime;

  String get startTime => _startTime;

  String get date => _date;

  String get description => _description;

  EventDetail.fromMap(dynamic obj) {
    this.id = obj['id'];
    this._description = obj['description'];
    this._date = obj['date'];
    this._startTime = obj['start_time'];
    this._endTime = obj['end_time'];
    this._speaker = obj['speaker'];
    this._isFavourite = obj['is_favourite'];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['description'] = _description;
    map['date'] = _date;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['speaker'] = _speaker;
    return map;
  }
}
