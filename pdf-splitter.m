#import <Foundation/Foundation.h>
#import "PDFSplit.h"


int main (int argc, const char * argv[]) {
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  PDFSplit *pdfDoc;
  NSURL *pdfURL;
  NSURL *outputDir;
  NSNumber *width;
  @try {
	if(argc < 3){
	  [NSException raise:@"TooFewArgs" format:@"TooFewArgs"];
	}
	pdfURL    = [NSURL fileURLWithPath: [[NSString alloc] initWithCString: argv[1] encoding:NSASCIIStringEncoding]];
	outputDir = [NSURL fileURLWithPath: [[NSString alloc] initWithCString: argv[2] encoding:NSASCIIStringEncoding]];
	width	  = [NSNumber numberWithInt: atoi(argv[3])];
	pdfDoc = [[PDFSplit alloc] initWithURLOutDirWidth: pdfURL outDir: outputDir width: width];
	[pdfDoc split];
  }
  @catch (NSException * e) {
	NSLog(@"%@", [e reason]);
	printf("USAGE: pdf-splitter ORIGINAL_FILE OUTPUT_DIR WIDTH");
	
  } 
  @finally {
	[pool drain];
	return 0;
  }
}
