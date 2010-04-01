//
//  PDFSplit.m
//  pdf-splitter
//
//  Created by Jeff Larson on 3/30/10.
//

#import "PDFSplit.h"


@implementation PDFSplit


- (id) initWithURLOutDirWidth: (NSURL *) url outDir:(NSURL *) outDir width: (CGFloat) width outFormat: (NSString *) outFormat{
	_fm        = [[NSFileManager alloc] init];
	_outDir    = outDir;
	_outFormat = outFormat;
	_width     = (CGFloat) width;
    _formats   = [NSDictionary dictionaryWithObjectsAndKeys:
				  [NSNumber numberWithInt: NSBMPFileType], @"gif",
				  [NSNumber numberWithInt: NSTIFFFileType], @"tiff", 
				  [NSNumber numberWithInt: NSJPEGFileType], @"jpeg", 
				  [NSNumber numberWithInt: NSPNGFileType], @"png",
				  [NSNumber numberWithInt: NSBMPFileType], @"bmp", 
				  [NSNumber numberWithInt: NSJPEG2000FileType], @"jpeg2000", 
				  nil];
	return [self initWithURL:url];
  }

  - (int) format: (NSString *) fmt{
	return [[_formats objectForKey:fmt] intValue];
  }

  - (void) outPutImageAtIndex: (int) index{
	PDFPage *page  = [self pageAtIndex:index];
	NSRect bounds = [page boundsForBox: kPDFDisplayBoxMediaBox];
	
	CGFloat newHeight = _width * bounds.size.height / bounds.size.width;
	NSRect outSize;
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
	NSAffineTransform *xform = [NSAffineTransform transform];
	[xform scaleXBy:(outSize.size.width/bounds.size.width) yBy:(outSize.size.height/bounds.size.height)];
	[xform concat];
	[page drawWithBox: kPDFDisplayBoxCropBox];
	[NSGraphicsContext restoreGraphicsState];
	
	NSURL *outFile = [[_outDir URLByAppendingPathComponent:[NSString stringWithFormat:@"%d", index+1]] URLByAppendingPathExtension:_outFormat];
	[_fm createFileAtPath: [outFile path]  contents: [bitmap representationUsingType:[self format:_outFormat] properties:nil] attributes:nil];
	
	
	[bitmap release];
  }
  


- (void) split{
	[_fm createDirectoryAtPath:  [_outDir path] withIntermediateDirectories: YES attributes: nil error: NULL];
	int pages = [self pageCount];

	for(int i=0; i < pages; i++){
	  NSAutoreleasePool *subPool = [[NSAutoreleasePool alloc] init];
	  [self outPutImageAtIndex: i];
	  [subPool release];
	}
  }

  - (void) dealloc{
	[_fm release];
	[_outFormat release];
	[_formats release];
	[_outDir release];
	[super dealloc];
  }

@end
