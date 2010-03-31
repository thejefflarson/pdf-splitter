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
	NSImage *image = [[NSImage alloc] initWithData:[page dataRepresentation]];
	
	CGFloat newHeight = _width * bounds.size.height / bounds.size.width;
	NSSize outSize;
	
	NSLog(@"%f %f", _width, newHeight);
	outSize.width  = _width;
	outSize.height = newHeight;
	image.size = outSize;
	NSURL *outFile = [[_outDir URLByAppendingPathComponent:[NSString stringWithFormat:@"%d", index]] URLByAppendingPathExtension:@"tif"];
	[_fm createFileAtPath: [outFile path]  contents:[image TIFFRepresentation] attributes:nil];

  }

  - (void) split{
	[_fm createDirectoryAtPath:  [_outDir path] withIntermediateDirectories: YES attributes: nil error: NULL];
	int pages = [self pageCount];
	for(int i=0; i < pages; i++){
	  [self outPutImageAtIndex: i];
	}
  }

@end
