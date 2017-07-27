/*2007-08-15T13:01:17Z (Krishna_p Gummadi)
remove the group name from the persist so that the roxie pipe will take over and doesn't need to run on the 400_2
*/
import did_add, ut, header_slimsort,didville,mdr,header;
new_daily := dataset('~thor_data400::in::utility::sprayed::daily',utilfile.Layout_Util.base,flat);

with_did := record
 utilfile.Layout_DID_Out;
 unsigned6 did_un := 0;
end;

//add src
src_rec := record
header_slimsort.Layout_Source;
with_did;
end;

DID_Add.Mac_Set_Source_Code(new_daily, src_rec, 'UU', new_daily_src)

matchset := ['A','S','P','4','Z'];
did_Add.MAC_Match_Flex
	(new_daily_src, matchset,						
	 ssn, dob, fname, mname,lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st, phone, 
	 did_un, src_rec, false, DID_Score_field,							
	 75, truout_src, true, src)
//remove src
truout := project(truout_src, transform(with_did, self := left));

did_ed := project(truout,transform(utilfile.Layout_DID_Out, self.did := intformat(left.did_un,12,1),self := left))
			: persist('~thor_data400::persist::util_daily_did');

export daily_with_did := did_ed;