
define(["dojo/_base/declare", "dojo/store/Memory"], function(declare, Memory) {
  return new Memory({
    idProperty: "name",
    data: [
      {
        name: "science",
        count: 20
      }, {
        name: "evolution",
        count: 12
      }, {
        name: "physics",
        count: 6
      }, {
        name: "philosophy",
        count: 12
      }, {
        name: "history",
        count: 5
      }, {
        name: "united-states",
        count: 3
      }
    ],
    getChildren: function(object) {
      return this.query({
        parent: object.tag
      });
    }
  });
});
