import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:fuodz/models/order.dart';
import 'package:fuodz/view_models/vendor_rating.vm.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/vendor_rating.i18n.dart';

class VendorRatingBottomSheet extends StatelessWidget {
  const VendorRatingBottomSheet({
    Key key,
    this.onSubmitted,
    this.order,
  }) : super(key: key);

  //
  final Order order;
  final Function onSubmitted;

  //
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VendorRatingViewModel>.reactive(
      viewModelBuilder: () =>
          VendorRatingViewModel(context, order, onSubmitted),
      builder: (context, vm, child) {
        return BasePage(
          body: VStack(
            [
              //
              Image.asset(
                AppImages.vendor,
              ).centered(),
              //
              "Did you like provided service?"
                  .i18n
                  .fill([order.vendor.name])
                  .text
                  .center
                  .xl
                  .semiBold
                  .makeCentered()
                  .py12(),
              //
              VxRating(
                size: 40,
                maxRating: 5,
                value: double.parse(vm.rating.toString()),
                stepInt: true,
                selectionColor: Colors.yellow[700],
                onRatingUpdate: vm.updateRating,
              ).centered().py12(),

              //
              CustomTextFormField(
                minLines: 3,
                maxLines: 4,
                textEditingController: vm.reviewTEC,
                labelText: "Comment".i18n,
              ).py12(),

              //
              SafeArea(
                child: CustomButton(
                  title: "Submit".i18n,
                  onPressed: vm.submitRating,
                  loading: vm.isBusy,
                ).centered().py16(),
              ),
            ],
          ).p20().scrollVertical(),
        ).hTwoThird(context);
      },
    );
  }
}
