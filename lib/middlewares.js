var parse;

parse = require('./parsers');

exports.all = function(_arg) {
  var fields, pagination, sort, _ref;
  _ref = _arg != null ? _arg : {}, sort = _ref.sort, pagination = _ref.pagination, fields = _ref.fields;
  return function(req, res, next) {
    var page, q;
    q = req.query;
    req.options || (req.options = {});
    if (sort) {
      req.options.sort = parse.sort(q.sort, sort);
      delete q.sort;
    }
    if (pagination) {
      page = parse.pagination({
        page: q.page,
        offset: q.offset,
        limit: q.limit,
        "default": pagination["default"] || 50,
        max: pagination.limit || 100
      });
      req.options.offset = page.offset;
      req.options.limit = page.limit;
      delete q.page;
      delete q.offset;
      delete q.limit;
    }
    if (fields) {
      req.options.fields = parse.csv(q.fields, fields);
      delete q.fields;
    }
    return next();
  };
};

exports.sort = function(conf) {
  return exports.all({
    sort: conf
  });
};

exports.pagination = function(conf) {
  return exports.all({
    pagination: conf
  });
};

exports.fields = function(conf) {
  return exports.all({
    fields: conf
  });
};
