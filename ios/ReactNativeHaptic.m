/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "ReactNativeHaptic.h"
#import <UIKit/UIKit.h>

@implementation ReactNativeHaptic

{
    UIImpactFeedbackGenerator *impactLight;
    UIImpactFeedbackGenerator *impactMedium;
    UIImpactFeedbackGenerator *impactHeavy;
    UINotificationFeedbackGenerator *notificationSuccess;
    UINotificationFeedbackGenerator *notificationError;
    UINotificationFeedbackGenerator *notificationWarning;
    UISelectionFeedbackGenerator *selectionFeedback;
}
@synthesize bridge = _bridge;

RCT_EXPORT_MODULE()

- (void)setBridge:(RCTBridge *)bridge
{
  _bridge = bridge;
  if ([UIFeedbackGenerator class]) {
      
      selectionFeedback = [UISelectionFeedbackGenerator new];
      
      impactLight = [[UIImpactFeedbackGenerator alloc] init];
      [impactLight initWithStyle:(UIImpactFeedbackStyleLight)];
      [impactLight impactOccurred];
      impactLight = NULL;
      
      impactMedium = [[UIImpactFeedbackGenerator alloc] init];
      [impactMedium initWithStyle:(UIImpactFeedbackStyleMedium)];
      [impactMedium impactOccurred];
      impactMedium = NULL;
      
      impactHeavy = [[UIImpactFeedbackGenerator alloc] init];
      [impactHeavy initWithStyle:(UIImpactFeedbackStyleHeavy)];
      [impactHeavy impactOccurred];
      impactHeavy = NULL;
      
      notificationSuccess = [[UINotificationFeedbackGenerator alloc] init];
      [notificationSuccess initWithStyle:(UINotificationFeedbackStyleSuccess)];
      [notificationSuccess impactOccurred];
      notificationSuccess = NULL;
      
      notificationWarning = [[UINotificationFeedbackGenerator alloc] init];
      [notificationWarning initWithStyle:(UINotificationFeedbackStyleWarning)];
      [notificationWarning impactOccurred];
      notificationWarning = NULL;
      
      notificationError = [[UINotificationFeedbackGenerator alloc] init];
      [notificationError initWithStyle:(UINotificationFeedbackStyleError)];
      [notificationError impactOccurred];
      notificationError = NULL;
      
  }
}

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

RCT_EXPORT_METHOD(generate:(NSString *)type)
{
  if ([type isEqual: @"light"]) {
      [impactLight impactOccurred:UIImpactFeedbackTypeLight];
  } else if ([type isEqual:@"medium"]) {
      [impactMedium impactOccurred:UIImpactFeedbackTypeMedium];
  } else if ([type isEqual:@"heavy"]) {
      [impactHeavy impactOccurred:UIImpactFeedbackTypeHeavy;
  } else if ([type isEqual:@"warning"]) {
    [notificationWarning notificationOccurred:UINotificationFeedbackTypeWarning];
  } else if ([type isEqual:@"success"]) {
      [notificationSuccess notificationOccurred:UINotificationFeedbackTypeSuccess];
  } else if ([type isEqual:@"error"]) {
      [notificationError notificationOccurred:UINotificationFeedbackTypeError];
  } else if ([type isEqual:@"selection"]) {
    [selectionFeedback selectionChanged];
  } 
}

RCT_EXPORT_METHOD(prepare)
{
  // Only calling prepare on one generator, it's sole purpose is to awake the taptic engine
  [_impactFeedback prepare];
}

@end
