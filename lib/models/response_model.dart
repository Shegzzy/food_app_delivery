class ResponseModel{
  bool _isSuccessful;
  String _message;

  ResponseModel(this._isSuccessful, this._message);
  bool get isSuccess => _isSuccessful;
  String get message => _message;
}