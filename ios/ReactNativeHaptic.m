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

    // TODO: Sigh...this is just terrible work. We should only be creating generators for the one requested, not all of them.
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
      impactLight = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
      impactMedium = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
      impactHeavy = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy];
      notificationSuccess = [[UINotificationFeedbackGenerator alloc] init];
      notificationWarning = [[UINotificationFeedbackGenerator alloc] init];
      notificationError = [[UINotificationFeedbackGenerator alloc] init];
  }
}

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

RCT_EXPORT_METHOD(generate:(NSString *)type)
{
  if ([type isEqual: @"light"]) {
      [impactLight impactOccurred];
  } else if ([type isEqual:@"medium"]) {
      [impactMedium impactOccurred];
  } else if ([type isEqual:@"heavy"]) {
      [impactHeavy impactOccurred];
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
  [impactLight prepare];
}
    
RCT_EXPORT_METHOD(done)
{
    impactLight = nil;
    impactMedium = nil;
    impactHeavy = nil;
    notificationSuccess = nil;
    notificationWarning = nil;
    notificationError = nil;
    selectionFeedback = nil;
}

@end
