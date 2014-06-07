var csv, date, dateRange, dateRangeRegex, dateRegex, integer, intersection, pagination, positiveInteger, sort,
  __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

intersection = function(a, b) {
  var value, _i, _len, _ref, _results;
  if (a.length > b.length) {
    _ref = [b, a], a = _ref[0], b = _ref[1];
  }
  _results = [];
  for (_i = 0, _len = a.length; _i < _len; _i++) {
    value = a[_i];
    if (__indexOf.call(b, value) >= 0) {
      _results.push(value);
    }
  }
  return _results;
};

sort = function(string, defaultSort) {
  var key, op, result, s, _i, _len, _ref, _ref1;
  if (typeof string !== 'string' || !string.length) {
    string = defaultSort;
  }
  if (!(string != null ? string.length : void 0)) {
    return {};
  }
  result = {};
  _ref = string.split(',');
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    s = _ref[_i];
    _ref1 = s.trim().match(/^([-]?)(.*)/), s = _ref1[0], op = _ref1[1], key = _ref1[2];
    if (key) {
      result[key] = op === '-' ? 'desc' : 'asc';
    }
  }
  return result;
};

csv = function(string, opt) {
  var fields, _ref;
  if (opt == null) {
    opt = {};
  }
  opt["default"] || (opt["default"] = []);
  if (typeof string === 'number') {
    string = String(string);
  }
  if (typeof string !== 'string') {
    return opt["default"];
  }
  if ((_ref = opt.allowed) != null ? _ref.length : void 0) {
    fields = intersection(opt.allowed, string.split(','));
  } else {
    fields = string.split(',');
  }
  if (fields != null ? fields.length : void 0) {
    return fields;
  }
  return opt["default"];
};

integer = function(number, opt) {
  if (opt == null) {
    opt = {};
  }
  if (opt["default"] === void 0 || opt["default"] === null) {
    opt["default"] = 0;
  }
  if (!(number = parseInt(number))) {
    return opt["default"];
  }
  if (opt.max !== void 0) {
    number = Math.min(number, opt.max);
  }
  if (opt.min !== void 0) {
    number = Math.max(number, opt.min);
  }
  return number;
};

positiveInteger = function(string, opt) {
  var int;
  if (opt == null) {
    opt = {};
  }
  int = integer(string, opt);
  if (int >= 0) {
    return int;
  }
  return opt["default"] || 0;
};

date = function(string) {
  if (/^[0-9\.]*$/.test(string)) {
    string = Number(string);
  }
  string = new Date(string);
  if (string.getTime()) {
    return string;
  }
};

dateRegex = "([0-9\.]{11,13}|[0-9]{4}-[0-9]{2}-[0-9a-zA-Z:\.]*)";

dateRangeRegex = "" + dateRegex + "?-?" + dateRegex + "?";

dateRange = function(string, formatter) {
  var date1, date2;
  if (formatter == null) {
    formatter = date;
  }
  if (typeof string === 'number') {
    string = String(string);
  }
  if (typeof string === 'string' && (string = string != null ? string.match(new RegExp(dateRangeRegex)) : void 0)) {
    date1 = formatter(string[1]);
    date2 = formatter(string[2]);
  }
  return {
    from: date1,
    to: date2
  };
};

pagination = function(opt) {
  var limit, offset;
  if (opt == null) {
    opt = {};
  }
  limit = positiveInteger(opt.limit, {
    "default": opt["default"] || 50,
    max: opt.max
  });
  if (opt.page) {
    offset = (positiveInteger(opt.page, {
      "default": 1
    }) - 1) * limit;
  } else {
    offset = positiveInteger(opt.offset, {
      "default": 0
    });
  }
  return {
    offset: offset,
    limit: limit
  };
};

module.exports = {
  sort: sort,
  csv: csv,
  integer: integer,
  positiveInteger: positiveInteger,
  date: date,
  dateRange: dateRange,
  pagination: pagination
};
