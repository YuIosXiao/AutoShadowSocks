#import <Foundation/Foundation.h>
/*
 * Copyright 2012 ZXing authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef _ZXINGOBJC_CORE_

#define _ZXINGOBJC_CORE_

// Client
#import "../client/ZXCapture.h"
#import "../client/ZXCaptureDelegate.h"
#import "../client/ZXCGImageLuminanceSource.h"
#import "../client/ZXImage.h"

// Common
#import "../common/ZXBitArray.h"
#import "../common/ZXBitMatrix.h"
#import "../common/ZXBitSource.h"
#import "../common/ZXBoolArray.h"
#import "../common/ZXByteArray.h"
#import "../common/ZXCharacterSetECI.h"
#import "../common/ZXDecoderResult.h"
#import "../common/ZXDefaultGridSampler.h"
#import "../common/ZXDetectorResult.h"
#import "../common/reedsolomon/ZXGenericGF.h"
#import "../common/ZXGlobalHistogramBinarizer.h"
#import "../common/ZXGridSampler.h"
#import "../common/ZXHybridBinarizer.h"
#import "../common/ZXIntArray.h"
#import "../common/detector/ZXMathUtils.h"
#import "../common/detector/ZXMonochromeRectangleDetector.h"
#import "../common/ZXPerspectiveTransform.h"
#import "../common/reedsolomon/ZXReedSolomonDecoder.h"
#import "../common/reedsolomon/ZXReedSolomonEncoder.h"
#import "../common/ZXStringUtils.h"
#import "../common/detector/ZXWhiteRectangleDetector.h"

// Core
#import "ZXBarcodeFormat.h"
#import "ZXBinarizer.h"
#import "ZXBinaryBitmap.h"
#import "ZXByteMatrix.h"
#import "ZXDecodeHints.h"
#import "ZXDimension.h"
#import "ZXEncodeHints.h"
#import "ZXErrors.h"
#import "ZXInvertedLuminanceSource.h"
#import "ZXLuminanceSource.h"
#import "ZXPlanarYUVLuminanceSource.h"
#import "ZXReader.h"
#import "ZXResult.h"
#import "ZXResultMetadataType.h"
#import "ZXResultPoint.h"
#import "ZXResultPointCallback.h"
#import "ZXRGBLuminanceSource.h"
#import "ZXWriter.h"

// Multi
#import "../multi/ZXByQuadrantReader.h"
#import "../multi/ZXGenericMultipleBarcodeReader.h"
#import "../multi/ZXMultipleBarcodeReader.h"

#endif
