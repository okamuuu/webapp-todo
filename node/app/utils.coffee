_ = require 'lodash'

module.exports.parseGroongaSelectResult = (result)->

  count = result[0].shift()[0]
  columns = _.map result[0].shift(), (item)-> item[0]

  items = []
  for item in result[0]
    h = {}
    for val, i in item
      h[columns[i]] = val
    items.push h

  return {
    count: count
    columns: columns
    items: items
  }

