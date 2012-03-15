
define(["../DocumentStore"], function(DocumentStore) {
  var records;
  records = DocumentStore.query();
  return doh.register("citeplasm/model/DocumentStore", [
    {
      name: "It should contain two records.",
      runTest: function(t) {
        return t.is(2, records.length);
      }
    }, {
      name: "It should follow the dojo.store API.",
      runTest: function(t) {
        var one;
        one = DocumentStore.get(1);
        return t.is("joshdmiller", one.author.uid);
      }
    }
  ]);
});
