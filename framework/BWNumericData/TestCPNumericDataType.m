
#import "TestCPNumericDataType.h"
#import "CPNumericDataType.h"

@implementation TestCPNumericDataType
- (void)testEqualToDataType {
    id match = [CPNumericDataType dataType:BWIntegerDataType
                               sampleBytes:sizeof(NSInteger)
                                 byteOrder:NSHostByteOrder()];
    
    STAssertEqualObjects(match, match, @"match equal to match");
    
    STAssertTrue([match isEqualToDataType:
                  [CPNumericDataType dataType:BWIntegerDataType
                                  sampleBytes:sizeof(NSInteger)
                                    byteOrder:NSHostByteOrder()]],
                 @"equal types");
    
    STAssertFalse([match isEqualToDataType:
                   [CPNumericDataType dataType:BWUnsignedIntegerDataType
                                   sampleBytes:sizeof(NSInteger)
                                     byteOrder:NSHostByteOrder()]],
                  @"unequal types");
    
    STAssertFalse([match isEqualToDataType:
                   [CPNumericDataType dataType:BWIntegerDataType
                                   sampleBytes:sizeof(long long)
                                     byteOrder:NSHostByteOrder()]],
                  @"unequal types");
    
    STAssertFalse([match isEqualToDataType:
                   [CPNumericDataType dataType:BWIntegerDataType
                                   sampleBytes:sizeof(NSInteger)
                                     byteOrder:NSHostByteOrder()==NS_LittleEndian?NS_BigEndian:NS_LittleEndian]],
                  @"unequal types");
}

- (void)testCopyEqual {
    id match = [CPNumericDataType dataType:BWIntegerDataType
                               sampleBytes:sizeof(NSInteger)
                                 byteOrder:NSHostByteOrder()];
    STAssertFalse(match == [[match copy] autorelease],
                  @"copy not equal object");
    STAssertTrue([match isEqualToDataType:[[match copy] autorelease]],
                 @"copy equal data type");
}

- (void)testArchivingRoundTrip {
    
    CPNumericDataType* match = [CPNumericDataType dataType:BWIntegerDataType
                               sampleBytes:sizeof(NSInteger)
                                 byteOrder:NSHostByteOrder()];
    CPNumericDataType* test = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:match]];
    
    STAssertEquals(match.dataType, test.dataType, @"data types equal");
    STAssertEquals(match.byteOrder, test.byteOrder, @"byte orders equal");
    STAssertEquals(match.sampleBytes, test.sampleBytes, @"sample bytes equal");
}
@end
