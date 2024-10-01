import { hilog } from '@kit.PerformanceAnalysisKit';

import { Constants } from '../common/Constants';
import { CanteenModel, HomeTabModel } from '../viewmodel/TabItem';
import { initTabTuData, initCanteenSideTabData } from '../viewmodel/TabViewModel';

// console.log("Hins", "Test")

@Component
struct CanteenItem {
  @Prop isSelected: boolean = false;
  canteenName?: string | Resource;
  onClickAction = (): void => {
  }

  build() {
    Text(this.canteenName)
      .fontSize(14)
      .fontColor(this.isSelected ? $r('app.color.side_selected_color') : $r('app.color.side_text_color'))
      .fontFamily(this.isSelected ? $r('app.string.hei_ti_medium') : $r('app.string.hei_ti'))
      .fontWeight(this.isSelected ? FontWeight.Medium : FontWeight.Normal)
      .textAlign(TextAlign.Center)
      .backgroundColor(this.isSelected ? $r('app.color.side_content_color') : '')
      .width(Constants.FULL_WIDTH)
      .height($r('app.float.mainPage_barHeight'))
      .onClick(this.onClickAction)
  }
}

@Entry
@Component
struct Index {
  @State tabArray: Array<HomeTabModel> = initTabTuData();
  @State tabCount: number = this.tabArray.length;
  @State TAB_INDEX_MIDDLE: number = (this.tabCount - 1) / 2;
  @State TAB_INDEX_MENU: number = 1;
  @State currentIndex: number = 0;
  @State iconOffset: number = 0;
  @State initNumber: number = 0;

  private controller: TabsController = new TabsController();

  // Menu
  @State CanteenArray: Array<CanteenModel> = initCanteenSideTabData();
  @State curSelectedCanteen: number = 0;
  private contentScroller: Scroller = new Scroller();
  private canteenScroller: Scroller = new Scroller();

  classifyChangeAction(index: number, isContent: boolean): void {
    if (this.curSelectedCanteen !== index) {
      this.curSelectedCanteen = index;
      if (isContent) {
        this.contentScroller.scrollToIndex(index);
      } else {
        this.canteenScroller.scrollToIndex(index);
      }
    }
}

  @Builder
  Tab(selectImage: Resource, defaultImage: Resource, title: string | Resource, middleMode: boolean, index: number) {
    Column() {
      if (index === this.TAB_INDEX_MIDDLE) {
        // 中间页
        Image(defaultImage)
          .size({ width: Constants.IMAGE_SIZE_MIDDLE, height: Constants.IMAGE_SIZE_MIDDLE }) // 巨型按钮
          .offset({ y: Constants.IMAGE_OFFSET })
      } else {
        // 其他tab页
        Image(this.currentIndex === index ? selectImage : defaultImage)
          .size({ width: Constants.IMAGE_SIZE_TAB, height: Constants.IMAGE_SIZE_TAB })
          .offset({
            y: (this.currentIndex === index && this.currentIndex !== this.TAB_INDEX_MIDDLE)
              ? this.iconOffset : this.initNumber
          })
          .objectFit(ImageFit.Contain)
          .animation({
            duration: Constants.ANIMATION_DURATION,
            curve: Curve.Ease,
            playMode: PlayMode.Normal
          })
      }

      // 中间按钮
      if (!middleMode) {
        Text(title)
          .fontSize($r('app.float.tab_text_font_size'))
          .margin({ top: $r('app.float.margin_tab_text') })
          .fontColor(this.currentIndex === index ? $r('app.color.current_color') : $r('app.color.text_color'))
      }
    } // Column
    .padding({ top: $r('app.float.padding_rudder_tab') })
    .width(Constants.FULL_WIDTH)
    .backgroundColor($r('app.color.tab_color'))
    .height($r('app.float.rudder_barHeight'))
    .translate({ y: Constants.TRANSLATE_BOTTOM })
    .onClick(() => {
      if (index !== this.TAB_INDEX_MIDDLE) {  // 其他Tab
        // 更新用于记录当前所在tab的状态信息
        this.currentIndex = index;
        this.controller.changeIndex(index);
        this.iconOffset = Constants.ICON_OFFSET;
      }
    })
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.BottomStart }) {
        Tabs({ barPosition: BarPosition.End, controller: this.controller }) {
          // 遍历每个tab页面的TabModel

          ForEach(this.tabArray, (item: HomeTabModel, index: number) => {
            // TabContent类比Android中的fragment，可做嵌套布局
            TabContent() {
              if (index === this.TAB_INDEX_MIDDLE) {
                // 中间页内容
              } else if (index === this.TAB_INDEX_MENU) {
                Row() {
                  List({ scroller: this.canteenScroller }) {
                    ForEach(this.CanteenArray, (item: CanteenModel, index?: number) => {
                      ListItem() {
                        CanteenItem({
                          canteenName: item.canteenName,
                          isSelected: this.curSelectedCanteen === index,
                          onClickAction: () => {
                            if (index !== undefined) {
                              this.classifyChangeAction(index, true);
                            }
                          }
                        })
                      }
                    }, (item: CanteenModel, index: number) => JSON.stringify(item) + index)
                  }
                  .height(Constants.MENU_CONTENT_HEIGHT)
                  .width(Constants.MENU_SIDE_TAB_WIDTH)
                  .backgroundColor($r('app.color.side_background_color'))
                  .scrollBar(BarState.Off)
                  .margin({ top: $r('app.float.margin_side_tab_top') })

                  Column() {
                    ForEach(this.CanteenArray, (item: CanteenModel, index: number) => {
                      Text(this.curSelectedCanteen === index ? item.canteenName : '')
                        .fontSize($r('app.float.content_font_size'))
                    },(item: CanteenModel, index: number) => JSON.stringify(item) + index)
                  }
                  .width(Constants.MENU_SIDE_CONTEND_WIDTH)
                }
                .backgroundColor($r('app.color.side_content_color'))
              } else {
                // 填入当前tab标题
                Row() {
                  Text(item.title)
                    .fontSize($r('app.float.content_font_size'))
                }
                .height(Constants.CONTENT_HEIGHT)
                .width(Constants.FULL_WIDTH)
                .justifyContent(FlexAlign.Center)
              }
            }
            .backgroundColor(Color.White)
          }, (item: HomeTabModel, index: number) => JSON.stringify(item) + index)
        }
        .scrollable(false)
        .barHeight(this.initNumber)
        .animationDuration(Constants.ANIMATION_DURATION)

        // 动态布局
        Flex() {
          ForEach(this.tabArray, (item: HomeTabModel, index: number) => {
            this.Tab(item.selectImage, item.defaultImage, item.title, item.middleMode, index)
          }, (item: HomeTabModel, index: number) => JSON.stringify(item) + index)
        }
      } // Stack
    } // Column
    .height(Constants.FULL_HEIGHT)
  }
}