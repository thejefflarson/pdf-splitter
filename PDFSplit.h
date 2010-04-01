//
//  PDFSplit.h
//  pdf-splitter
//
//  Created by Jeff Larson on 3/30/10.
//

#import <Cocoa/Cocoa.h>
#import <AppKit/NSImage.h>
#import <Quartz/Quartz.h>

@interface PDFSplit : PDFDocument {
  NSFileManager *_fm;
  NSURL *_outDir;
  CGFloat _width;
  NSString *_outFormat;
  NSDictionary *_formats;
}

- (id) initWithURLOutDirWidth: (NSURL *) url outDir:(NSURL *) outDir width: (CGFloat) width outFormat: outFormat;
- (void) split;
@end
