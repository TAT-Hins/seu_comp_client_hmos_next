// export class TabItem {
//   id: number;
//   name: string | Resource;
//
//   constructor(id: number, name: string | Resource) {
//     this.id = id;
//     this.name = name;
//   }
// }

export class HomeTabModel {
  selectImage: Resource;
  defaultImage: Resource;
  middleMode: boolean;
  title: string | Resource;
  isSelected: boolean = false;

  constructor(selectImage: Resource, defaultImage: Resource, title: string | Resource, middleMode = false) {
    this.selectImage = selectImage;
    this.defaultImage = defaultImage;
    this.title = title;
    this.middleMode = middleMode;
  }
}

export class CanteenModel {
  canteenId: number;
  canteenName: string | Resource;

  constructor(canteenId: number, canteenName: string | Resource) {
    this.canteenId = canteenId;
    this.canteenName = canteenName;
  }
}