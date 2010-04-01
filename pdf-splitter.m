#import <Foundation/Foundation.h>
#import "PDFSplit.h"
#include <unistd.h>

int main (int argc, const char * argv[]) {
  PDFSplit *pdfDoc;
  NSURL *pdfURL;
  NSURL *outputDir;
  CGFloat width;
  NSString *format;
  @try {
	if(argc < 5){
	  [NSException raise:@"TooFewArgs" format:@"You need to include ORIGINAL_FILE OUTPUT_DIR WIDTH FORMAT in your arguments."];
	}
	pdfURL    = [NSURL fileURLWithPath: [[NSString alloc] initWithCString: argv[1] encoding:NSASCIIStringEncoding]];
	outputDir = [NSURL fileURLWithPath: [[NSString alloc] initWithCString: argv[2] encoding:NSASCIIStringEncoding]];
	width	  = (CGFloat) atof(argv[3]);
	format	  = [[NSString alloc] initWithCString: argv[4] encoding:NSASCIIStringEncoding];

	pdfDoc = [[PDFSplit alloc] initWithURLOutDirWidth: pdfURL outDir: outputDir width: width outFormat: format];
	[pdfDoc split];
  }
  @catch (NSException * e) {
	printf("Error: %s\n", [[e reason] cStringUsingEncoding:NSASCIIStringEncoding]);
	printf("%s",
		  [@"\npdf-splitter will split your pdf files and output page images\n"
		  @"using native cocoa libraries for speed and memory management.\n"
		  @"\n"
		  @"USAGE: pdf-splitter ORIGINAL_FILE OUTPUT_DIR WIDTH FORMAT\n"
		  @"\n"
		  @"options:\n"
		  @" ORIGINAL_FILE:\tthe pdf you want to split\n"
		  @" OUTPUT_DIR:\t\tthe directory where you want to place the pdf images\n"
		  @" WIDTH:\t\t\tthe width of the resulting image\n"
		  @" FORMAT:\t\t\tthe output format\n"
		   cStringUsingEncoding:NSASCIIStringEncoding]
	);
	
  } 
  @finally {
	return 0;
  }
}
