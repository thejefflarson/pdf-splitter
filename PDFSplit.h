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
  NSString *_outFormat;
  CGFloat _width;
  NSDictionary *_formats;
}

- (id) initWithURLOutDirWidth: (NSURL *) url outDir:(NSURL *) outDir width: (CGFloat) width;
- (void) split;
@end
