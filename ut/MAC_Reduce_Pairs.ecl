export MAC_Reduce_Pairs(infile,new_field,old_field,flag_field,req_layout,outfile) := macro
// The output from this macro should not need to be further deduped
// In particular it can roll straight into PatchId

#uniquename(MRP_di)
%MRP_di% := distribute(infile,hash(old_field));
#uniquename(MRP_Close)
req_layout %MRP_Close%(infile MRl,infile MRr) := transform
  self.old_field := MRl.new_field;
  self.new_field := MRr.new_field;
  self.flag_field := 98;
  end;

// This piece performs the pair-part of the transitive closure
// Specifically if we have
// 3 -- 1
// 3 -- 2
// then this inserts
// 2 -- 1
#uniquename(sec_pairs)
%sec_pairs% := join(%MRP_di%,%MRP_di%,left.old_field=right.old_field and
                                left.new_field > right.new_field,%MRP_Close%(left,right),local);

// %sec_pairs% could be huge so try to dedup globally before attempting the
// sorted dedup
#uniquename(upairs)
%upairs% := dedup(infile+%sec_pairs%,old_field,new_field,all);

#uniquename(res)
%res% := distribute(%upairs%,hash(old_field));

// Now we are going to attempt a grand-parent cross 
// IOW
// 6 - 2
// 6 - 5
// 5 - 4
// 4 - 3 (initial) will have become
// 5 - 3

// 6 - 2
// 6 - 5
// 5 - 2 ** New record
// 5 - 4
// 4 - 3
// 5 - 3

// we are now aiming to create
// 6 - 2
// 6 - 5
// 5 - 2 ** Older New record
// 5 - 4
// 4 - 3
// 5 - 3
// 3 - 2 ** New record, using 5 as parent

#uniquename(tert_pairs)
%tert_pairs% := join(%res%,%res%,left.old_field=right.old_field and
                           left.new_field > right.new_field,%MRP_Close%(left,right),local);

// %tert_pairs% could be huge so try to dedup globally before attempting the
// sorted dedup
#uniquename(new_upairs)
%new_upairs% := dedup(%res%+%tert_pairs%,old_field,new_field,all);

#uniquename(res1)
%res1% := distribute(%new_upairs%,hash(old_field));

/*  Temporarily disable Tertiary Pairs
//****** Sort the groups of old_fields by new_field
%sres% := sort(%res1%,old_field,new_field,local);
*/

#uniquename(sres)
%sres% := sort(%res%,old_field,new_field,local);

//****** Map each old field down to the lowest possible new field
#uniquename(dres)
%dres% := dedup(%sres%,old_field,local);

//-- Transform used to apply transitive closure to patchfile
//   If the right new_field is not zero, then use it.  Otherwise, keep the left new_field.
//	 Flag_field will keep the left flag field or take a 99 if we replaced the new_field.
#uniquename(MRP_tra)
req_layout %MRP_tra%(infile l, infile rec) := transform
  self.old_field := l.old_field;
  self.new_field := if (rec.new_field=0,l.new_field,rec.new_field);
  self.flag_field := if(rec.new_field=0,l.flag_field,99);
  end;

#uniquename(mrp1)
#uniquename(mrp2)
#uniquename(mrp3)
ut.mac_chain_child(%dres%,old_field,new_field,%mrp1%)
ut.mac_chain_child(%mrp1%,old_field,new_field,%mrp2%)
ut.mac_chain_child(%mrp2%,old_field,new_field,%mrp3%)
//****** Return valid records
outfile := %mrp3%;

endmacro;