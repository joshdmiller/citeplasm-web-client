
define(["dojo/_base/declare", "dojo/store/Memory"], function(declare, Memory) {
  return new Memory({
    idProperty: "id",
    data: [
      {
        id: 0,
        name: "Root"
      }, {
        id: 1,
        name: "Science",
        parent: 0
      }, {
        id: 2,
        name: "Evolution",
        parent: 1
      }, {
        id: 3,
        name: "Physics",
        parent: 1
      }, {
        id: 4,
        name: "Philosophy",
        parent: 0
      }, {
        id: 5,
        name: "History",
        parent: 0
      }, {
        id: 6,
        name: "United States",
        parent: 5
      }
    ],
    getChildren: function(object) {
      return this.query({
        parent: object.id
      });
    }
  });
});
