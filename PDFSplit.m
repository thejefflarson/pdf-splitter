//
//  PDFSplit.m
//  pdf-splitter
//
//  Created by Jeff Larson on 3/30/10.
//

#import "PDFSplit.h"


@implementation PDFSplit


  - (id) initWithURLOutDirWidth: (NSURL *) url outDir:(NSURL *) outDir width: (CGFloat) width{
	_fm     = [[NSFileManager alloc] init];
	_outDir = outDir;
	_width  = (CGFloat) width;
	return [self initWithURL:url];
  }

  - (void) outPutImageAtIndex: (int) index{
	PDFPage *page  = [self pageAtIndex:index];
	NSRect bounds = [page boundsForBox: kPDFDisplayBoxMediaBox];
	
	CGFloat newHeight = _width * bounds.size.height / bounds.size.width;
	NSRect outSize;
	NSLog(@"%f %f", _width, newHeight);
	outSize.origin.x = 0;
	outSize.origin.y = 0;
	outSize.size.width  = _width;
	outSize.size.height = newHeight;

	NSBitmapImageRep *bitmap = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes: NULL pixelsWide: _width 
								 pixelsHigh: newHeight bitsPerSample: 8 samplesPerPixel: 4 hasAlpha: NO isPlanar: NO
								 colorSpaceName:NSDeviceCMYKColorSpace bytesPerRow:0  bitsPerPixel:0 ];
	
	NSGraphicsContext *nsContext = [NSGraphicsContext graphicsContextWithBitmapImageRep:bitmap];	
	[NSGraphicsContext saveGraphicsState];
	[NSGraphicsContext setCurrentContext: nsContext];
	[page setBounds:outSize forBox: kPDFDisplayBoxCropBox];
	[page drawWithBox: kPDFDisplayBoxCropBox];
	[NSGraphicsContext restoreGraphicsState];
	

	
	NSURL *outFile = [[_outDir URLByAppendingPathComponent:[NSString stringWithFormat:@"%d", index]] URLByAppendingPathExtension:@"gif"];
	[_fm createFileAtPath: [outFile path]  contents: [bitmap representationUsingType:NSGIFFileType properties:nil] attributes:nil];

  }

  - (void) split{
	[_fm createDirectoryAtPath:  [_outDir path] withIntermediateDirectories: YES attributes: nil error: NULL];
	int pages = [self pageCount];
	for(int i=0; i < pages; i++){
	  [self outPutImageAtIndex: i];
	}
  }

@end
