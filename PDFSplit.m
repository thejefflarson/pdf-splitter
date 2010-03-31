//
//  PDFSplit.m
//  pdf-splitter
//
//  Created by Jeff Larson on 3/30/10.
//

#import "PDFSplit.h"


@implementation PDFSplit


  - (id) initWithURLOutDirWidth: (NSURL *) url outDir:(NSURL *) outDir width: (NSNumber *) width{
	_fm     = [[NSFileManager alloc] init];
	_outDir = outDir;
	_width  = width;
	return [self initWithURL:url];
  }

  - (void) outPutImageAtIndex: (int) index{
	
  }

  - (void) split{
	[_fm createDirectoryAtPath:  [_outDir path] withIntermediateDirectories: YES attributes: nil error: NULL];
	int pages = [self pageCount];
	for(int i=0; i < pages; i++){
	  [self outPutImageAtIndex: i];
	}
  }
  
  - (void) dealloc{
	[_fm release];
	[_outDir release];
	[_width release];
	[super dealloc];
  }
@end
