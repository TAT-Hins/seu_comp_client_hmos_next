import { Constants } from '../common/Constants';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { BottomTabModel } from '../viewmodel/TabItem';
import { initTabTuData } from '../viewmodel/TabViewModel';

console.log("Hins", "Test")

@Entry
@Component
struct Index {
  @State tabArray: Array<BottomTabModel> = initTabTuData();
  @State currentIndex: number = 0;
  @State iconOffset: number = 0;
  @State initNumber: number = 0;

  private controller: TabsController = new TabsController();

  @Builder
  Tab(selectImage: Resource, defaultImage: Resource, title: string | Resource, middleMode: boolean, index: number) {
    Column() {
      if (index === Constants.TAB_INDEX_TWO) {
        // 中间页
        Image(defaultImage)
          .size({ width: Constants.IMAGE_SIZE_MIDDLE, height: Constants.IMAGE_SIZE_MIDDLE })
          .offset({ y: Constants.IMAGE_OFFSET })
      } else {
        // 其他tab页
        Image(this.currentIndex === index ? selectImage : defaultImage)
          .size({ width: Constants.IMAGE_SIZE_TAB, height: Constants.IMAGE_SIZE_TAB })
          .offset({
            y: (this.currentIndex === index && this.currentIndex !== Constants.TAB_INDEX_TWO)
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
      // 中间按钮
      if (index !== Constants.TAB_INDEX_TWO) {
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
          ForEach(this.tabArray, (item: BottomTabModel, index: number) => {
            // 遍历每个tab页面的TabModel
            if (index === Constants.TAB_INDEX_TWO) {
              // 中间页内容
              TabContent() {
              }
              .backgroundColor(Color.White)
            } else {
              // 各页内容
              TabContent() {
                // 填入当前tab标题
                Row() {
                  Text(item.title)
                    .fontSize($r('app.float.content_font_size'))
                }
                .height(Constants.CONTENT_HEIGHT)
                .width(Constants.FULL_WIDTH)
                .justifyContent(FlexAlign.Center)
              }
              .backgroundColor(Color.White)
            }
          }, (item: BottomTabModel, index: number) => JSON.stringify(item) + index)
        }
        .scrollable(false)
        .barHeight(this.initNumber)
        .animationDuration(Constants.ANIMATION_DURATION)

        // 动态布局
        Flex() {
          ForEach(this.tabArray, (item: BottomTabModel, index: number) => {
            this.Tab(item.selectImage, item.defaultImage, item.title, item.middleMode, index)
          }, (item: BottomTabModel, index: number) => JSON.stringify(item) + index)
        }
      } // Stack
    } // Column
    .height(Constants.FULL_HEIGHT)
  }
}