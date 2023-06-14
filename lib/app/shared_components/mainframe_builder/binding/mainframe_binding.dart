part of mainframe_builder;


class MainFrameBinding extends Bindings {
@override
void dependencies() {
  Get.lazyPut<MainFrameController>(() => MainFrameController());
  }
}
