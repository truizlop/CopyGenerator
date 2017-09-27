//
//  XCSourceEditorCommandInvocationExtension.swift
//  CopyEditorExtension
//
//  Created by Tomás Ruiz López on 26/9/17.
//  Copyright © 2017 Tomás Ruiz López. All rights reserved.
//

import Foundation
import XcodeKit

extension XCSourceEditorCommandInvocation {
    var selectedText : [String] {
        if let selection = self.buffer.selections.firstObject as? XCSourceTextRange {
            if selection.start.line == selection.end.line {
                return [String(
                    (self.buffer.lines[selection.start.line] as! String).utf8
                        .prefix(selection.end.column)
                        .dropFirst(selection.start.column)
                    )!]
            } else {
                return [String((self.buffer.lines[selection.start.line] as! String).utf8.dropFirst(selection.start.column))!]
                    + ((selection.start.line+1)..<selection.end.line).map { self.buffer.lines[$0] as! String }
                    + [String((self.buffer.lines[selection.end.line] as! String).utf8.prefix(selection.end.column))!]
            }
        }
        return []
    }
}
