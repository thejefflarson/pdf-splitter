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
  NSNumber *_width;
}

- (id) initWithURLOutDirWidth: (NSURL *) url outDir:(NSURL *) outDir width: (NSNumber *) width;
- (void) split;
@end
