//
//  SourceEditorCommand.swift
//  CopyEditorExtension
//
//  Created by Tomás Ruiz López on 25/9/17.
//  Copyright © 2017 Tomás Ruiz López. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        
        if let selection = invocation.buffer.selections.firstObject as? XCSourceTextRange {
            let code = generateInitializers(forFile: invocation.buffer.lines as! [String], withSelection: invocation.selectedText)
            let targetRange = selection.end.line + 1..<selection.end.line + 1 + code.count
            invocation.buffer.lines.insert(code, at: IndexSet(integersIn: targetRange))
        }
            
        completionHandler(nil)
    }
    
    
}
