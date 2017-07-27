export mac_chain_child (infile,old_field,new_field,outfile) := macro
//****** Join the patchfile to itself where one record's new ID is another record's old ID.
//       This is the situation that we want to remove, so the transform will make a new record with
//		 with the new ID of the right (newer) record.

#uniquename(MRP_j)
%MRP_j% := join(infile,infile(old_field>new_field),left.new_field=right.old_field,%MRP_tra%(left,right),left outer,hash);

//****** Get rid of duplicate mappings.
outfile := dedup(%MRP_j%(old_field<>new_field),old_field,new_field,all);

endmacro;