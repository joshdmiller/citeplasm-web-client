
define(["dojo/_base/declare", "dojo/store/Memory", "dojo/text!./_fixtures/sample001.html", "dojo/text!./_fixtures/sample002.html"], function(declare, Memory, sample001, sample002) {
  var abstract, author_josh;
  author_josh = {
    name: "Joshua D Miller",
    uid: "joshdmiller"
  };
  abstract = "Suspendisse sagittis felis sed diam molestie facilisis. Lorem ipsum dolor\nsit amet, consectetur adipiscing elit. In condimentum placerat mattis.\nNullam ullamcorper blandit massa sed feugiat. Nulla volutpat facilisis\nlectus vehicula venenatis. Phasellus convallis tortor vel nisi\nporttitor fermentum. Class aptent taciti sociosqu ad litora torquent\nper conubia nostra, per inceptos himenaeos. Nam lacus nisi, tristique\nrhoncus vulputate eu, volutpat vitae metus. Aenean accumsan\npellentesque metus vitae dictum. Vivamus lobortis tincidunt tristique.\nDonec faucibus nunc non ipsum fringilla in dignissim nibh\nmalesuada. In hac habitasse platea dictumst. Pellentesque faucibus\ntellus sit amet magna molestie sed sagittis nulla dapibus. Vivamus\nlobortis commodo massa quis gravida. Proin sagittis vestibulum\ndolor, sed porta dui lobortis in.";
  return new Memory({
    idProperty: "id",
    data: [
      {
        id: 1,
        slug: "american-hegemony-in-a-globally-interdependent-age",
        title: "American Hegemony in a Globally-Interdependent Age",
        author: author_josh,
        abstract: abstract,
        body: sample001
      }, {
        id: 2,
        slug: "linux-is-not-windows",
        title: "Linux is Not Windows",
        author: author_josh,
        abstract: abstract,
        body: sample002
      }
    ]
  });
});
