var SampleWebApplication;
(function (SampleWebApplication) {
    var Character = (function () {
        function Character() {
        }
        Character.prototype.changeCasing = function (casing) {
            switch (casing) {
                case Casing.Lower:
                    return this.Name.toLowerCase();
                case Casing.Upper:
                    return this.Name.toUpperCase();
            }
        };
        return Character;
    }());
    SampleWebApplication.Character = Character;
    var Casing;
    (function (Casing) {
        Casing[Casing["Lower"] = 0] = "Lower";
        Casing[Casing["Upper"] = 1] = "Upper";
    })(Casing = SampleWebApplication.Casing || (SampleWebApplication.Casing = {}));
})(SampleWebApplication || (SampleWebApplication = {}));
var character = new SampleWebApplication.Character();
character.Name = "Inigo Montoya";
console.log(character.changeCasing(SampleWebApplication.Casing.Lower));
//# sourceMappingURL=characters.js.map