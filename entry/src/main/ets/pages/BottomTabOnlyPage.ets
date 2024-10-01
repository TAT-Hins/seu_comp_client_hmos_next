import { Constants } from '../common/Constants';
import { hilog } from '@kit.PerformanceAnalysisKit';

@Entry
@Component
struct BottomTabOnlyPage {
  @State currentIndex: number = 0;
  private tabsController: TabsController = new TabsController();

  @Builder
  tabBuilder(title: Resource, index: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === index ? selectedImg : normalImg)
        .width($r('app.float.mainPage_baseTab_size'))
        .height($r('app.float.mainPage_baseTab_size'))
        .objectFit(ImageFit.Contain)
      Text(title)
        .margin({ top: $r('app.float.mainPage_baseTab_top') })
        .fontSize($r('app.float.tab_text_font_size'))
        .fontColor(this.currentIndex === index ? $r('app.color.current_color') : $r('app.color.text_color'))
    }
    .justifyContent(FlexAlign.Center)
    .height($r('app.float.mainPage_barHeight'))
    .width(Constants.FULL_WIDTH)
    .onClick(() => {
      this.currentIndex = index;
      this.tabsController.changeIndex(this.currentIndex);
    })
  }

  @Builder
  tabContentBuilder(text: Resource, index: number, selectedImg: Resource, normalImg: Resource) {
    TabContent() {
      Row() {
        Text(text)
          .height(Constants.CONTENT_HEIGHT)
          .fontSize($r('app.float.content_font_size'))
      }
      .width(Constants.FULL_WIDTH)
      .justifyContent(FlexAlign.Center)
    }
    .padding({ left: $r('app.float.padding_bottom_tab'), right: $r('app.float.padding_bottom_tab') })
    .backgroundColor(Color.White)
    .tabBar(this.tabBuilder(text, index, selectedImg, normalImg))
  }

  build() {
    Tabs({
      barPosition: BarPosition.End,
      controller: this.tabsController
    }) {
      this.tabContentBuilder($r("app.string.hometab_homepage"),
        Constants.TAB_INDEX_ZERO, $r('app.media.activeHome'), $r('app.media.home'))
      this.tabContentBuilder($r("app.string.hometab_message"),
        Constants.TAB_INDEX_ONE, $r('app.media.activeMessage'), $r('app.media.message'))
      this.tabContentBuilder($r("app.string.hometab_mine"),
        Constants.TAB_INDEX_TWO, $r('app.media.activeAccount'), $r('app.media.account'))
    }
    .width(Constants.FULL_WIDTH)
    .backgroundColor($r('app.color.tab_color'))
    .barHeight($r('app.float.mainPage_barHeight'))
    .barMode(BarMode.Fixed)
    .onAnimationStart((index: number, targetIndex: number) => {
      hilog.info(0x0000, 'index', index.toString());
      this.currentIndex = targetIndex;
    })
  }
}