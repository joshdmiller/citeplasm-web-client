
define(["dojo/_base/declare", "dojo/store/Memory", "dojo/text!./_fixtures/sample001.html", "dojo/text!./_fixtures/sample002.html"], function(declare, Memory, sample001, sample002) {
  var author_josh;
  author_josh = {
    name: "Joshua D Miller",
    uid: "joshdmiller"
  };
  return new Memory({
    idProperty: "id",
    data: [
      {
        id: 1,
        slug: "american-hegemony-in-a-globally-interdependent-age",
        title: "American Hegemony in a Globally-Interdependent Age",
        author: author_josh,
        abstract: "This is the abstract for the this document.",
        body: sample001
      }, {
        id: 2,
        slug: "linux-is-not-windows",
        title: "Linux is Not Windows",
        author: author_josh,
        abstract: "This is an incomplete blog post about why Linux distributions should not emulate Windows.",
        body: sample002
      }
    ]
  });
});
