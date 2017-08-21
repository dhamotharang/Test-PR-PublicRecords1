import did_add, ut, header_slimsort,didville,mdr,header;
export did_nctue_hist(dataset(utilfile.Layout_Util.base) util_uctue) := function

with_did := record
utilfile.Layout_DID_Out;
 unsigned6 did_temp := 0;
end;

//add src
src_rec := record
header_slimsort.Layout_Source;
with_did;
end;

DID_Add.Mac_Set_Source_Code(util_uctue, src_rec, 'UU', util_full_src)

matchset := ['A','S','P','4','Z'];
did_Add.MAC_Match_Flex
	(util_full_src, matchset,						
	 ssn, dob, fname, mname,lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st, phone, 
	 did_temp, src_rec, false, DID_Score_field,							
	 75, out_src, true, src)
	 
//remove src and reformat
did_ed := project(out_src,transform(utilfile.Layout_DID_Out, self.did := intformat(left.did_temp,12,1),self := left));
return did_ed;
end;
