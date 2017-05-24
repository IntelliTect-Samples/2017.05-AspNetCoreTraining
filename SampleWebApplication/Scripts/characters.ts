module SampleWebApplication {
    export class Character {
        public Name: string;
        public changeCasing(casing: Casing) {
            switch (casing) {
                case Casing.Lower:
                    return this.Name.toLowerCase();
                case Casing.Upper:
                    return this.Name.toUpperCase();
            }
        }
    }

    export enum Casing {
        Lower,
        Upper
    }
}

var character = new SampleWebApplication.Character();
character.Name = "Inigo Montoya";
console.log(character.changeCasing(SampleWebApplication.Casing.Lower));
