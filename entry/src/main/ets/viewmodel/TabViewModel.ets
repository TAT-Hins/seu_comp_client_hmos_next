import { HomeTabModel, CanteenModel } from './TabItem';

/**
 * 主页tab页面绑定resource信息
 */
const TabTuItemData: HomeTabModel[] = [
  new HomeTabModel($r('app.media.home'), $r('app.media.activeHome'), $r("app.string.hometab_homepage")),
  new HomeTabModel($r('app.media.list'), $r('app.media.activeList'), $r("app.string.hometab_menu")),
  new HomeTabModel($r('app.media.activePlus'), $r('app.media.activePlus'), '', true /*middleMode*/),
  new HomeTabModel($r('app.media.message'), $r('app.media.activeMessage'), $r("app.string.hometab_message")),
  new HomeTabModel($r('app.media.account'), $r('app.media.activeAccount'),$r("app.string.hometab_mine"))
]

/**
 * 菜单Tab页面的餐厅列表
 */
const CanteenData: CanteenModel[] = [
  new CanteenModel(0, $r('app.string.canteen_tao')),
  new CanteenModel(1, $r('app.string.canteen_mei')),
  new CanteenModel(2, $r('app.string.canteen_ju'))
]

/**
 * 返回已创建并初始化绑定好resource的TabModel对象
 *
 * @returns 已创建并初始化的TabModel对象数组
 */
export function initTabTuData(): HomeTabModel[] {
  let tabTuDataArray: HomeTabModel[] = [];
  TabTuItemData.forEach((item: HomeTabModel) => {
    tabTuDataArray.push(new HomeTabModel(item.defaultImage, item.selectImage, item.title, item.middleMode));
  })
  return tabTuDataArray;
}

/**
 * 返回已创建并初始化好的CanteenModel对象
 *
 * @returns 已创建并初始化的CanteenModel对象数组
 */
export function initCanteenSideTabData(): CanteenModel[] {
  let tabDataArray: CanteenModel[] = [];
  CanteenData.forEach((item: CanteenModel) => {
    tabDataArray.push(new CanteenModel(item.canteenId, item.canteenName));
  })
  return tabDataArray;
}
