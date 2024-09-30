import { BottomTabModel } from './TabItem';

/**
 * 各tab页面绑定resource信息
 */
const TabTuItemData: BottomTabModel[] = [
  new BottomTabModel($r('app.media.home'), $r('app.media.activeHome'), $r('app.string.tab_homepage')),
  new BottomTabModel($r('app.media.list'), $r('app.media.activeList'), $r('app.string.tab_list')),
  new BottomTabModel($r('app.media.activePlus'), $r('app.media.activePlus'), '', true /*middleMode*/),
  new BottomTabModel($r('app.media.message'), $r('app.media.activeMessage'), $r('app.string.tab_message')),
  new BottomTabModel($r('app.media.account'), $r('app.media.activeAccount'),$r("app.string.tab_mine"))
]

/**
 * 返回已创建并初始化绑定好resource的TabModel对象
 *
 * @returns 已创建并初始化的TabModel对象数组
 */
export function initTabTuData(): BottomTabModel[] {
  let tabTuDataArray: BottomTabModel[] = [];
  TabTuItemData.forEach((item: BottomTabModel) => {
    tabTuDataArray.push(new BottomTabModel(item.defaultImage, item.selectImage, item.title, item.middleMode));
  })
  return tabTuDataArray;
}