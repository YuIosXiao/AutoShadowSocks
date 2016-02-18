#import <Foundation/Foundation.h>
/*
 * Copyright 2014 ZXing authors
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

#ifndef _ZXINGOBJC_ONED_

#define _ZXINGOBJC_ONED_

// OneD

#import "rss/expanded/decoders/ZXAbstractExpandedDecoder.h"
#import "rss/ZXAbstractRSSReader.h"
#import "ZXCodaBarReader.h"
#import "ZXCodaBarWriter.h"
#import "ZXCode128Reader.h"
#import "ZXCode128Writer.h"
#import "ZXCode39Reader.h"
#import "ZXCode39Writer.h"
#import "ZXCode93Reader.h"
#import "ZXEAN13Reader.h"
#import "ZXEAN13Writer.h"
#import "ZXEAN8Reader.h"
#import "ZXEAN8Writer.h"
#import "ZXITFReader.h"
#import "ZXITFWriter.h"
#import "ZXMultiFormatOneDReader.h"
#import "ZXMultiFormatUPCEANReader.h"
#import "ZXOneDimensionalCodeWriter.h"
#import "ZXOneDReader.h"
#import "rss/ZXRSS14Reader.h"
#import "rss/ZXRSSDataCharacter.h"
#import "rss/expanded/ZXRSSExpandedReader.h"
#import "rss/ZXRSSFinderPattern.h"
#import "rss/ZXRSSUtils.h"
#import "ZXUPCAReader.h"
#import "ZXUPCAWriter.h"
#import "ZXUPCEANReader.h"
#import "ZXUPCEANWriter.h"
#import "ZXUPCEReader.h"

// Result Parsers

#import "../client/result/ZXAddressBookAUResultParser.h"
#import "../client/result/ZXAddressBookDoCoMoResultParser.h"
#import "../client/result/ZXAddressBookParsedResult.h"
#import "../client/result/ZXBizcardResultParser.h"
#import "../client/result/ZXBookmarkDoCoMoResultParser.h"
#import "../client/result/ZXCalendarParsedResult.h"
#import "../client/result/ZXEmailAddressParsedResult.h"
#import "../client/result/ZXEmailAddressResultParser.h"
#import "../client/result/ZXEmailDoCoMoResultParser.h"
#import "../client/result/ZXExpandedProductParsedResult.h"
#import "../client/result/ZXExpandedProductResultParser.h"
#import "../client/result/ZXGeoParsedResult.h"
#import "../client/result/ZXGeoResultParser.h"
#import "../client/result/ZXISBNParsedResult.h"
#import "../client/result/ZXISBNResultParser.h"
#import "../client/result/ZXParsedResult.h"
#import "../client/result/ZXParsedResultType.h"
#import "../client/result/ZXProductParsedResult.h"
#import "../client/result/ZXProductResultParser.h"
#import "../client/result/ZXResultParser.h"
#import "../client/result/ZXSMSMMSResultParser.h"
#import "../client/result/ZXSMSParsedResult.h"
#import "../client/result/ZXSMSTOMMSTOResultParser.h"
#import "../client/result/ZXSMTPResultParser.h"
#import "../client/result/ZXTelParsedResult.h"
#import "../client/result/ZXTelResultParser.h"
#import "../client/result/ZXTextParsedResult.h"
#import "../client/result/ZXURIParsedResult.h"
#import "../client/result/ZXURIResultParser.h"
#import "../client/result/ZXURLTOResultParser.h"
#import "../client/result/ZXVCardResultParser.h"
#import "../client/result/ZXVEventResultParser.h"
#import "../client/result/ZXVINParsedResult.h"
#import "../client/result/ZXVINResultParser.h"
#import "../client/result/ZXWifiParsedResult.h"
#import "../client/result/ZXWifiResultParser.h"

#endif
