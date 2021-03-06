; RUN: llc < %s -mtriple=x86_64-apple-darwin | not grep jmp
; rdar://6647639

	%struct.FetchPlanHeader = type { i8*, i8*, i32, i8*, i8*, i8*, i8*, i8*, %struct.NSObject* (%struct.NSObject*, %struct.objc_selector*, ...)*, %struct.__attributeDescriptionFlags }
	%struct.NSArray = type { %struct.NSObject }
	%struct.NSAutoreleasePool = type { %struct.NSObject, i8*, i8*, i8*, i8* }
	%struct.NSObject = type { %struct.NSObject* }
	%struct.__attributeDescriptionFlags = type <{ i32 }>
	%struct._message_ref_t = type { %struct.NSObject* (%struct.NSObject*, %struct._message_ref_t*, ...)*, %struct.objc_selector* }
	%struct.objc_selector = type opaque
@"\01l_objc_msgSend_fixup_alloc" = external global %struct._message_ref_t, align 16		; <%struct._message_ref_t*> [#uses=2]

define %struct.NSArray* @newFetchedRowsForFetchPlan_MT(%struct.FetchPlanHeader* %fetchPlan, %struct.objc_selector* %selectionMethod, %struct.NSObject* %selectionParameter) ssp {
entry:
	%0 = invoke %struct.NSObject* null(%struct.NSObject* null, %struct._message_ref_t* @"\01l_objc_msgSend_fixup_alloc")
			to label %invcont unwind label %lpad		; <%struct.NSObject*> [#uses=1]

invcont:		; preds = %entry
	%1 = invoke %struct.NSObject* (%struct.NSObject*, %struct.objc_selector*, ...)* @objc_msgSend(%struct.NSObject* %0, %struct.objc_selector* null)
			to label %invcont26 unwind label %lpad		; <%struct.NSObject*> [#uses=0]

invcont26:		; preds = %invcont
	%2 = invoke %struct.NSObject* null(%struct.NSObject* null, %struct._message_ref_t* @"\01l_objc_msgSend_fixup_alloc")
			to label %invcont27 unwind label %lpad		; <%struct.NSObject*> [#uses=0]

invcont27:		; preds = %invcont26
	unreachable

lpad:		; preds = %invcont26, %invcont, %entry
	%pool.1 = phi %struct.NSAutoreleasePool* [ null, %entry ], [ null, %invcont ], [ null, %invcont26 ]		; <%struct.NSAutoreleasePool*> [#uses=0]
        %exn = landingpad {i8*, i32} personality i32 (...)* @__gxx_personality_v0
                 cleanup
	unreachable
}

declare %struct.NSObject* @objc_msgSend(%struct.NSObject*, %struct.objc_selector*, ...)

declare i32 @__gxx_personality_v0(...)
