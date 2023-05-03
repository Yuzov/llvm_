; RUN: llc < %s -mtriple=x86_64-undermydesk-freebsd8.0 -relocation-model=pic -frame-pointer=all
; PR4225

define void @sha256_block1(ptr nocapture %arr, ptr nocapture %in, i64 %num) nounwind {
entry:
	br i1 undef, label %while.end, label %bb.nph

bb.nph:		; preds = %entry
	br label %while.body

while.body:		; preds = %for.end, %bb.nph
	%indvar2787 = phi i64 [ 0, %bb.nph ], [ %indvar.next2788, %for.end ]		; <i64> [#uses=2]
	%tmp2791 = mul i64 %indvar2787, 44		; <i64> [#uses=0]
	%ctg22996 = getelementptr i8, ptr %in, i64 0		; <ptr> [#uses=1]
	%conv = zext i32 undef to i64		; <i64> [#uses=1]
	%conv11 = zext i32 undef to i64		; <i64> [#uses=1]
	%tmp18 = load i32, ptr undef		; <i32> [#uses=1]
	%conv19 = zext i32 %tmp18 to i64		; <i64> [#uses=1]
	%tmp30 = load i32, ptr undef		; <i32> [#uses=1]
	%conv31 = zext i32 %tmp30 to i64		; <i64> [#uses=4]
	%ptrincdec3065 = load i8, ptr null		; <i8> [#uses=1]
	%conv442709 = zext i8 %ptrincdec3065 to i64		; <i64> [#uses=1]
	%shl45 = shl i64 %conv442709, 16		; <i64> [#uses=1]
	%conv632707 = zext i8 undef to i64		; <i64> [#uses=1]
	%or = or i64 %shl45, 0		; <i64> [#uses=1]
	%or55 = or i64 %or, %conv632707		; <i64> [#uses=1]
	%or64 = or i64 %or55, 0		; <i64> [#uses=1]
	%shr85 = lshr i64 %conv31, 25		; <i64> [#uses=0]
	%add = add i64 %conv11, 1508970993		; <i64> [#uses=1]
	%add95 = add i64 %add, 0		; <i64> [#uses=1]
	%add98 = add i64 %add95, 0		; <i64> [#uses=1]
	%add99 = add i64 %add98, %or64		; <i64> [#uses=1]
	%add134 = add i64 %add99, 0		; <i64> [#uses=4]
	store i32 undef, ptr undef
	%shl187 = shl i64 %add134, 21		; <i64> [#uses=0]
	%and203 = and i64 %add134, %conv31		; <i64> [#uses=1]
	%xor208 = xor i64 0, %and203		; <i64> [#uses=1]
	%add212 = add i64 0, %xor208		; <i64> [#uses=1]
	%add213 = add i64 %add212, 0		; <i64> [#uses=1]
	%add248 = add i64 %add213, 0		; <i64> [#uses=3]
	%conv2852690 = zext i8 undef to i64		; <i64> [#uses=1]
	%or277 = or i64 0, %conv2852690		; <i64> [#uses=1]
	%or286 = or i64 %or277, 0		; <i64> [#uses=1]
	%neg319 = xor i64 %add248, 4294967295		; <i64> [#uses=1]
	%and321 = and i64 %neg319, %conv31		; <i64> [#uses=1]
	%xor322 = xor i64 %and321, 0		; <i64> [#uses=1]
	%add314 = add i64 %conv, 2870763221		; <i64> [#uses=1]
	%add323 = add i64 %add314, %or286		; <i64> [#uses=1]
	%add326 = add i64 %add323, %xor322		; <i64> [#uses=1]
	%add327 = add i64 %add326, 0		; <i64> [#uses=2]
	%add362 = add i64 %add327, %conv19		; <i64> [#uses=4]
	%add365 = add i64 0, %add327		; <i64> [#uses=3]
	%shl409 = shl i64 %add362, 26		; <i64> [#uses=0]
	%and431 = and i64 %add362, %add248		; <i64> [#uses=1]
	%neg433 = xor i64 %add362, -1		; <i64> [#uses=1]
	%and435 = and i64 %add134, %neg433		; <i64> [#uses=1]
	%xor436 = xor i64 %and431, %and435		; <i64> [#uses=1]
	%add428 = add i64 %conv31, 3624381080		; <i64> [#uses=1]
	%add437 = add i64 %add428, 0		; <i64> [#uses=1]
	%add440 = add i64 %add437, %xor436		; <i64> [#uses=1]
	%add441 = add i64 %add440, 0		; <i64> [#uses=1]
	%shl443 = shl i64 %add365, 30		; <i64> [#uses=1]
	%and445 = lshr i64 %add365, 2		; <i64> [#uses=1]
	%shr446 = and i64 %and445, 1073741823		; <i64> [#uses=1]
	%or447 = or i64 %shr446, %shl443		; <i64> [#uses=1]
	%xor461 = xor i64 0, %or447		; <i64> [#uses=1]
	%add473 = add i64 %xor461, 0		; <i64> [#uses=1]
	%add479 = add i64 %add473, %add441		; <i64> [#uses=3]
	%conv4932682 = zext i8 undef to i64		; <i64> [#uses=1]
	%shl494 = shl i64 %conv4932682, 16		; <i64> [#uses=1]
	%ptrincdec4903012 = load i8, ptr null		; <i8> [#uses=1]
	%conv5032681 = zext i8 %ptrincdec4903012 to i64		; <i64> [#uses=1]
	%shl504 = shl i64 %conv5032681, 8		; <i64> [#uses=1]
	%ptrincdec5003009 = load i8, ptr null		; <i8> [#uses=1]
	%conv5132680 = zext i8 %ptrincdec5003009 to i64		; <i64> [#uses=1]
	%or495 = or i64 %shl494, 0		; <i64> [#uses=1]
	%or505 = or i64 %or495, %conv5132680		; <i64> [#uses=1]
	%or514 = or i64 %or505, %shl504		; <i64> [#uses=1]
	store i32 undef, ptr undef
	%or540 = or i64 undef, 0		; <i64> [#uses=0]
	%add542 = add i64 %add134, 310598401		; <i64> [#uses=1]
	%add551 = add i64 %add542, %or514		; <i64> [#uses=1]
	%add554 = add i64 %add551, 0		; <i64> [#uses=1]
	%add555 = add i64 %add554, 0		; <i64> [#uses=1]
	%or561 = or i64 undef, undef		; <i64> [#uses=1]
	%or567 = or i64 undef, undef		; <i64> [#uses=1]
	%and572 = lshr i64 %add479, 22		; <i64> [#uses=1]
	%shr573 = and i64 %and572, 1023		; <i64> [#uses=1]
	%or574 = or i64 %shr573, 0		; <i64> [#uses=1]
	%xor568 = xor i64 %or567, %or574		; <i64> [#uses=1]
	%xor575 = xor i64 %xor568, %or561		; <i64> [#uses=1]
	%add587 = add i64 %xor575, 0		; <i64> [#uses=1]
	%add593 = add i64 %add587, %add555		; <i64> [#uses=1]
	%ptrincdec6043000 = load i8, ptr null		; <i8> [#uses=1]
	%conv6172676 = zext i8 %ptrincdec6043000 to i64		; <i64> [#uses=1]
	%shl618 = shl i64 %conv6172676, 8		; <i64> [#uses=1]
	%ptrincdec6142997 = load i8, ptr %ctg22996		; <i8> [#uses=1]
	%conv6272675 = zext i8 %ptrincdec6142997 to i64		; <i64> [#uses=1]
	%or619 = or i64 0, %conv6272675		; <i64> [#uses=1]
	%or628 = or i64 %or619, %shl618		; <i64> [#uses=1]
	%add656 = add i64 %add248, 607225278		; <i64> [#uses=1]
	%add665 = add i64 %add656, %or628		; <i64> [#uses=1]
	%add668 = add i64 %add665, 0		; <i64> [#uses=1]
	%add669 = add i64 %add668, 0		; <i64> [#uses=1]
	%and699 = and i64 %add479, %add365		; <i64> [#uses=1]
	%xor700 = xor i64 0, %and699		; <i64> [#uses=1]
	%add701 = add i64 0, %xor700		; <i64> [#uses=1]
	%add707 = add i64 %add701, %add669		; <i64> [#uses=4]
	%ptrincdec6242994 = load i8, ptr null		; <i8> [#uses=1]
	%conv7122673 = zext i8 %ptrincdec6242994 to i64		; <i64> [#uses=1]
	%shl713 = shl i64 %conv7122673, 24		; <i64> [#uses=1]
	%conv7412670 = zext i8 undef to i64		; <i64> [#uses=1]
	%or723 = or i64 0, %shl713		; <i64> [#uses=1]
	%or733 = or i64 %or723, %conv7412670		; <i64> [#uses=1]
	%or742 = or i64 %or733, 0		; <i64> [#uses=2]
	%conv743 = trunc i64 %or742 to i32		; <i32> [#uses=1]
	store i32 %conv743, ptr undef
	%xor762 = xor i64 undef, 0		; <i64> [#uses=0]
	%add770 = add i64 %add362, 1426881987		; <i64> [#uses=1]
	%add779 = add i64 %add770, %or742		; <i64> [#uses=1]
	%add782 = add i64 %add779, 0		; <i64> [#uses=1]
	%add783 = add i64 %add782, 0		; <i64> [#uses=1]
	%shl785 = shl i64 %add707, 30		; <i64> [#uses=1]
	%and787 = lshr i64 %add707, 2		; <i64> [#uses=1]
	%shr788 = and i64 %and787, 1073741823		; <i64> [#uses=1]
	%or789 = or i64 %shr788, %shl785		; <i64> [#uses=1]
	%shl791 = shl i64 %add707, 19		; <i64> [#uses=0]
	%xor803 = xor i64 0, %or789		; <i64> [#uses=1]
	%and813 = and i64 %add593, %add479		; <i64> [#uses=1]
	%xor814 = xor i64 0, %and813		; <i64> [#uses=1]
	%add815 = add i64 %xor803, %xor814		; <i64> [#uses=1]
	%add821 = add i64 %add815, %add783		; <i64> [#uses=1]
	%add1160 = add i64 0, %add707		; <i64> [#uses=0]
	%add1157 = add i64 undef, undef		; <i64> [#uses=0]
	%ptrincdec11742940 = load i8, ptr null		; <i8> [#uses=1]
	%conv11872651 = zext i8 %ptrincdec11742940 to i64		; <i64> [#uses=1]
	%shl1188 = shl i64 %conv11872651, 8		; <i64> [#uses=1]
	%or1198 = or i64 0, %shl1188		; <i64> [#uses=1]
	store i32 undef, ptr undef
	%add1226 = add i64 %or1198, 3248222580		; <i64> [#uses=1]
	%add1235 = add i64 %add1226, 0		; <i64> [#uses=1]
	%add1238 = add i64 %add1235, 0		; <i64> [#uses=1]
	%add1239 = add i64 %add1238, 0		; <i64> [#uses=1]
	br label %for.cond

for.cond:		; preds = %for.body, %while.body
	%add821.pn = phi i64 [ %add821, %while.body ], [ undef, %for.body ]		; <i64> [#uses=0]
	%add1239.pn = phi i64 [ %add1239, %while.body ], [ 0, %for.body ]		; <i64> [#uses=0]
	br i1 undef, label %for.end, label %for.body

for.body:		; preds = %for.cond
	br label %for.cond

for.end:		; preds = %for.cond
	%indvar.next2788 = add i64 %indvar2787, 1		; <i64> [#uses=1]
	br i1 undef, label %while.end, label %while.body

while.end:		; preds = %for.end, %entry
	ret void
}

define void @sha256_block2(ptr nocapture %arr, ptr nocapture %in, i64 %num) nounwind {
entry:
	br i1 undef, label %while.end, label %bb.nph

bb.nph:		; preds = %entry
	%arrayidx5 = getelementptr i32, ptr %arr, i64 1		; <ptr> [#uses=1]
	%arrayidx9 = getelementptr i32, ptr %arr, i64 2		; <ptr> [#uses=2]
	%arrayidx13 = getelementptr i32, ptr %arr, i64 3		; <ptr> [#uses=2]
	%arrayidx25 = getelementptr i32, ptr %arr, i64 6		; <ptr> [#uses=1]
	%arrayidx29 = getelementptr i32, ptr %arr, i64 7		; <ptr> [#uses=1]
	br label %while.body

while.body:		; preds = %for.end, %bb.nph
	%tmp3 = load i32, ptr %arr		; <i32> [#uses=2]
	%conv = zext i32 %tmp3 to i64		; <i64> [#uses=1]
	%tmp10 = load i32, ptr %arrayidx9		; <i32> [#uses=1]
	%conv11 = zext i32 %tmp10 to i64		; <i64> [#uses=1]
	%tmp14 = load i32, ptr %arrayidx13		; <i32> [#uses=3]
	%conv15 = zext i32 %tmp14 to i64		; <i64> [#uses=2]
	%tmp18 = load i32, ptr undef		; <i32> [#uses=2]
	%conv19 = zext i32 %tmp18 to i64		; <i64> [#uses=1]
	%conv23 = zext i32 undef to i64		; <i64> [#uses=1]
	%tmp26 = load i32, ptr %arrayidx25		; <i32> [#uses=1]
	%conv27 = zext i32 %tmp26 to i64		; <i64> [#uses=1]
	%tmp30 = load i32, ptr %arrayidx29		; <i32> [#uses=2]
	%conv31 = zext i32 %tmp30 to i64		; <i64> [#uses=5]
	%shl72 = shl i64 %conv31, 26		; <i64> [#uses=1]
	%shr = lshr i64 %conv31, 6		; <i64> [#uses=1]
	%or74 = or i64 %shl72, %shr		; <i64> [#uses=1]
	%shr85 = lshr i64 %conv31, 25		; <i64> [#uses=0]
	%xor87 = xor i64 0, %or74		; <i64> [#uses=1]
	%and902706 = and i32 %tmp30, %tmp3		; <i32> [#uses=1]
	%and90 = zext i32 %and902706 to i64		; <i64> [#uses=1]
	%xor94 = xor i64 0, %and90		; <i64> [#uses=1]
	%add = add i64 %conv11, 1508970993		; <i64> [#uses=1]
	%add95 = add i64 %add, %xor94		; <i64> [#uses=1]
	%add98 = add i64 %add95, %xor87		; <i64> [#uses=1]
	%add99 = add i64 %add98, 0		; <i64> [#uses=2]
	%xor130 = zext i32 undef to i64		; <i64> [#uses=1]
	%add134 = add i64 %add99, %conv27		; <i64> [#uses=2]
	%add131 = add i64 %xor130, 0		; <i64> [#uses=1]
	%add137 = add i64 %add131, %add99		; <i64> [#uses=5]
	%conv1422700 = zext i8 undef to i64		; <i64> [#uses=1]
	%shl143 = shl i64 %conv1422700, 24		; <i64> [#uses=1]
	%ptrincdec1393051 = load i8, ptr undef		; <i8> [#uses=1]
	%conv1512699 = zext i8 %ptrincdec1393051 to i64		; <i64> [#uses=1]
	%shl152 = shl i64 %conv1512699, 16		; <i64> [#uses=1]
	%conv1712697 = zext i8 undef to i64		; <i64> [#uses=1]
	%or153 = or i64 %shl152, %shl143		; <i64> [#uses=1]
	%or163 = or i64 %or153, %conv1712697		; <i64> [#uses=1]
	%or172 = or i64 %or163, 0		; <i64> [#uses=1]
	%and203 = and i64 %add134, %conv31		; <i64> [#uses=1]
	%xor208 = xor i64 0, %and203		; <i64> [#uses=1]
	%add200 = add i64 0, 2453635748		; <i64> [#uses=1]
	%add209 = add i64 %add200, %or172		; <i64> [#uses=1]
	%add212 = add i64 %add209, %xor208		; <i64> [#uses=1]
	%add213 = add i64 %add212, 0		; <i64> [#uses=2]
	%shl228 = shl i64 %add137, 10		; <i64> [#uses=1]
	%and230 = lshr i64 %add137, 22		; <i64> [#uses=1]
	%shr231 = and i64 %and230, 1023		; <i64> [#uses=1]
	%or232 = or i64 %shr231, %shl228		; <i64> [#uses=1]
	%xor226 = xor i64 0, %or232		; <i64> [#uses=1]
	%xor233 = xor i64 %xor226, 0		; <i64> [#uses=1]
	%and2362695 = zext i32 undef to i64		; <i64> [#uses=1]
	%xor240 = and i64 %add137, %and2362695		; <i64> [#uses=1]
	%and2432694 = and i32 %tmp18, %tmp14		; <i32> [#uses=1]
	%and243 = zext i32 %and2432694 to i64		; <i64> [#uses=1]
	%xor244 = xor i64 %xor240, %and243		; <i64> [#uses=1]
	%add248 = add i64 %add213, %conv23		; <i64> [#uses=2]
	%add245 = add i64 %xor233, %xor244		; <i64> [#uses=1]
	%add251 = add i64 %add245, %add213		; <i64> [#uses=1]
	%conv2752691 = zext i8 undef to i64		; <i64> [#uses=1]
	%shl276 = shl i64 %conv2752691, 8		; <i64> [#uses=0]
	%and317 = and i64 %add248, %add134		; <i64> [#uses=1]
	%neg319 = xor i64 %add248, 4294967295		; <i64> [#uses=1]
	%and321 = and i64 %neg319, %conv31		; <i64> [#uses=1]
	%xor322 = xor i64 %and321, %and317		; <i64> [#uses=1]
	%add314 = add i64 %conv, 2870763221		; <i64> [#uses=1]
	%add323 = add i64 %add314, 0		; <i64> [#uses=1]
	%add326 = add i64 %add323, %xor322		; <i64> [#uses=1]
	%add327 = add i64 %add326, 0		; <i64> [#uses=2]
	%and3502689 = xor i64 %add137, %conv15		; <i64> [#uses=1]
	%xor354 = and i64 %add251, %and3502689		; <i64> [#uses=1]
	%and357 = and i64 %add137, %conv15		; <i64> [#uses=1]
	%xor358 = xor i64 %xor354, %and357		; <i64> [#uses=1]
	%add362 = add i64 %add327, %conv19		; <i64> [#uses=1]
	%add359 = add i64 0, %xor358		; <i64> [#uses=1]
	%add365 = add i64 %add359, %add327		; <i64> [#uses=1]
	%add770 = add i64 %add362, 1426881987		; <i64> [#uses=1]
	%add779 = add i64 %add770, 0		; <i64> [#uses=1]
	%add782 = add i64 %add779, 0		; <i64> [#uses=1]
	%add783 = add i64 %add782, 0		; <i64> [#uses=2]
	%add818 = add i64 %add783, %add365		; <i64> [#uses=1]
	%add821 = add i64 0, %add783		; <i64> [#uses=1]
	store i32 undef, ptr undef
	%add1046 = add i64 undef, undef		; <i64> [#uses=1]
	%add1160 = add i64 undef, undef		; <i64> [#uses=1]
	store i32 0, ptr undef
	%add1235 = add i64 0, %add818		; <i64> [#uses=1]
	%add1238 = add i64 %add1235, 0		; <i64> [#uses=1]
	%add1239 = add i64 %add1238, 0		; <i64> [#uses=1]
	br label %for.cond

for.cond:		; preds = %for.body, %while.body
	%h.0 = phi i64 [ undef, %while.body ], [ %add2035, %for.body ]		; <i64> [#uses=1]
	%g.0 = phi i64 [ %add1046, %while.body ], [ undef, %for.body ]		; <i64> [#uses=1]
	%f.0 = phi i64 [ %add1160, %while.body ], [ undef, %for.body ]		; <i64> [#uses=1]
	%add821.pn = phi i64 [ %add821, %while.body ], [ undef, %for.body ]		; <i64> [#uses=0]
	%add1239.pn2648 = phi i64 [ %add1239, %while.body ], [ undef, %for.body ]		; <i64> [#uses=0]
	%d.0 = phi i64 [ undef, %while.body ], [ %add2038, %for.body ]		; <i64> [#uses=2]
	br i1 undef, label %for.end, label %for.body

for.body:		; preds = %for.cond
	%conv1390 = zext i32 undef to i64		; <i64> [#uses=1]
	%add1375 = add i64 0, %h.0		; <i64> [#uses=1]
	%add1384 = add i64 %add1375, 0		; <i64> [#uses=1]
	%add1391 = add i64 %add1384, %conv1390		; <i64> [#uses=1]
	%add1392 = add i64 %add1391, 0		; <i64> [#uses=2]
	%or1411 = or i64 0, undef		; <i64> [#uses=1]
	%xor1405 = xor i64 0, %or1411		; <i64> [#uses=1]
	%xor1412 = xor i64 %xor1405, 0		; <i64> [#uses=1]
	%add1427 = add i64 %add1392, %d.0		; <i64> [#uses=1]
	%add1424 = add i64 %xor1412, 0		; <i64> [#uses=1]
	%add1430 = add i64 %add1424, %add1392		; <i64> [#uses=5]
	%tmp1438 = load i32, ptr undef		; <i32> [#uses=1]
	%conv1439 = zext i32 %tmp1438 to i64		; <i64> [#uses=4]
	%shl1441 = shl i64 %conv1439, 25		; <i64> [#uses=1]
	%shr1444 = lshr i64 %conv1439, 7		; <i64> [#uses=1]
	%or1445 = or i64 %shl1441, %shr1444		; <i64> [#uses=1]
	%shr1450 = lshr i64 %conv1439, 18		; <i64> [#uses=1]
	%or1451 = or i64 0, %shr1450		; <i64> [#uses=1]
	%shr1454 = lshr i64 %conv1439, 3		; <i64> [#uses=1]
	%xor1452 = xor i64 %or1451, %shr1454		; <i64> [#uses=1]
	%xor1455 = xor i64 %xor1452, %or1445		; <i64> [#uses=1]
	%conv1464 = zext i32 undef to i64		; <i64> [#uses=4]
	%shl1466 = shl i64 %conv1464, 15		; <i64> [#uses=1]
	%shr1469 = lshr i64 %conv1464, 17		; <i64> [#uses=1]
	%or1470 = or i64 %shl1466, %shr1469		; <i64> [#uses=1]
	%shr1475 = lshr i64 %conv1464, 19		; <i64> [#uses=1]
	%or1476 = or i64 0, %shr1475		; <i64> [#uses=1]
	%shr1479 = lshr i64 %conv1464, 10		; <i64> [#uses=1]
	%xor1477 = xor i64 %or1476, %shr1479		; <i64> [#uses=1]
	%xor1480 = xor i64 %xor1477, %or1470		; <i64> [#uses=1]
	%tmp1499 = load i32, ptr null		; <i32> [#uses=1]
	%conv1500 = zext i32 %tmp1499 to i64		; <i64> [#uses=1]
	%add1491 = add i64 %conv1500, 0		; <i64> [#uses=1]
	%add1501 = add i64 %add1491, %xor1455		; <i64> [#uses=1]
	%add1502 = add i64 %add1501, %xor1480		; <i64> [#uses=1]
	%conv1504 = and i64 %add1502, 4294967295		; <i64> [#uses=1]
	%tmp1541 = load i32, ptr undef		; <i32> [#uses=1]
	%conv1542 = zext i32 %tmp1541 to i64		; <i64> [#uses=1]
	%add1527 = add i64 %conv1542, %g.0		; <i64> [#uses=1]
	%add1536 = add i64 %add1527, 0		; <i64> [#uses=1]
	%add1543 = add i64 %add1536, %conv1504		; <i64> [#uses=1]
	%add1544 = add i64 %add1543, 0		; <i64> [#uses=1]
	%shl1546 = shl i64 %add1430, 30		; <i64> [#uses=1]
	%and1548 = lshr i64 %add1430, 2		; <i64> [#uses=1]
	%shr1549 = and i64 %and1548, 1073741823		; <i64> [#uses=1]
	%or1550 = or i64 %shr1549, %shl1546		; <i64> [#uses=1]
	%shl1552 = shl i64 %add1430, 19		; <i64> [#uses=1]
	%or1556 = or i64 0, %shl1552		; <i64> [#uses=1]
	%shl1559 = shl i64 %add1430, 10		; <i64> [#uses=1]
	%or1563 = or i64 0, %shl1559		; <i64> [#uses=1]
	%xor1557 = xor i64 %or1556, %or1563		; <i64> [#uses=1]
	%xor1564 = xor i64 %xor1557, %or1550		; <i64> [#uses=1]
	%add1576 = add i64 %xor1564, 0		; <i64> [#uses=1]
	%add1582 = add i64 %add1576, %add1544		; <i64> [#uses=3]
	store i32 undef, ptr undef
	%tmp1693 = load i32, ptr undef		; <i32> [#uses=1]
	%conv1694 = zext i32 %tmp1693 to i64		; <i64> [#uses=1]
	%add1679 = add i64 %conv1694, %f.0		; <i64> [#uses=1]
	%add1688 = add i64 %add1679, 0		; <i64> [#uses=1]
	%add1695 = add i64 %add1688, 0		; <i64> [#uses=1]
	%add1696 = add i64 %add1695, 0		; <i64> [#uses=1]
	%shl1698 = shl i64 %add1582, 30		; <i64> [#uses=0]
	%shl1704 = shl i64 %add1582, 19		; <i64> [#uses=0]
	%add1734 = add i64 0, %add1696		; <i64> [#uses=1]
	%add1983 = add i64 0, %add1427		; <i64> [#uses=1]
	%add1992 = add i64 %add1983, 0		; <i64> [#uses=1]
	%add1999 = add i64 %add1992, 0		; <i64> [#uses=1]
	%add2000 = add i64 %add1999, 0		; <i64> [#uses=2]
	%and2030 = and i64 %add1734, %add1582		; <i64> [#uses=1]
	%xor2031 = xor i64 0, %and2030		; <i64> [#uses=1]
	%add2035 = add i64 %add2000, %add1430		; <i64> [#uses=1]
	%add2032 = add i64 0, %xor2031		; <i64> [#uses=1]
	%add2038 = add i64 %add2032, %add2000		; <i64> [#uses=1]
	store i32 0, ptr undef
	br label %for.cond

for.end:		; preds = %for.cond
	store i32 undef, ptr %arrayidx5
	store i32 undef, ptr %arrayidx9
	%d.02641 = trunc i64 %d.0 to i32		; <i32> [#uses=1]
	%conv2524 = add i32 %tmp14, %d.02641		; <i32> [#uses=1]
	store i32 %conv2524, ptr %arrayidx13
	%exitcond2789 = icmp eq i64 undef, %num		; <i1> [#uses=1]
	br i1 %exitcond2789, label %while.end, label %while.body

while.end:		; preds = %for.end, %entry
	ret void
}
