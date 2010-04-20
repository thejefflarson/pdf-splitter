#import <Foundation/Foundation.h>
#import "PDFSplit.h"
#include <unistd.h>

int main (int argc, const char * argv[]) {
  PDFSplit *pdfDoc;
  NSURL *pdfURL;
  NSURL *output;
  CGFloat width;
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

  @try {
	if(argc < 4){
	  [NSException raise:@"TooFewArgs" format:@"You need to include ORIGINAL_FILE OUTPUT_DIR WIDTH in your arguments."];
	}
	pdfURL    = [NSURL fileURLWithPath: [[NSString alloc] initWithCString: argv[1] encoding:NSASCIIStringEncoding]];
	output    = [NSURL fileURLWithPath: [[NSString alloc] initWithCString: argv[2] encoding:NSASCIIStringEncoding]];
	width	  = (CGFloat) atof(argv[3]);
	pdfDoc    = [[PDFSplit alloc] initWithURLOutDirWidth: pdfURL outDir: output width: width];
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
		  @" OUTPUT:\tthe output path where you want to place the pdf images. It\n"
		  @" \t\tshould be a c format string like '%d.png'. The extension specifies\n"
		  @" \t\tthe resulting image's type. Consult the man page for allowed types.\n"
		  @" WIDTH:\t\tthe width of the resulting image\n"
		   cStringUsingEncoding:NSASCIIStringEncoding]
	);
	
  } 
  @finally {
	[pool drain];
	return 0;
  }
}
