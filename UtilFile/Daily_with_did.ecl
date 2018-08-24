/*2007-08-15T13:01:17Z (Krishna_p Gummadi)
remove the group name from the persist so that the roxie pipe will take over and doesn't need to run on the 400_2
*/
import did_add, ut, header_slimsort,didville,mdr,header,risk_indicators;

export daily_with_did(dataset(UtilFile.layout_util.base) new_daily) := module

with_did := record
 utilfile.Layout_Util.base;
 unsigned6 did_un := 0;
end;

//add src
src_rec := record
header_slimsort.Layout_Source;
with_did;
end;

DID_Add.Mac_Set_Source_Code(new_daily, src_rec, 'UU', new_daily_src_)
new_daily_src := dedup(sort(distribute(new_daily_src_, hash(exchange_serial_number)), record, local), record, local);

matchset := ['A','S','P','4','Z'];
did_Add.MAC_Match_Flex
	(new_daily_src, matchset,						
	 ssn, dob, fname, mname,lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st, phone, 
	 did_un, src_rec, false, DID_Score_field,							
	 75, truout_src, true, src)

//remove src
truout := project(truout_src, transform(utilfile.Layout_Util.base, self.did := intformat(left.did_un,12,1),self := left)):persist('~thor_data400::persist::util_daily_did');

//checking and correction invalid dates on billing addresses
shared validate_dates := utilfile.fn_invalid_dates_daily_correction(truout);

export base := validate_dates;

did_ed := project(validate_dates,transform(utilfile.Layout_DID_Out, self := left));

header.Mac_Apply_Title(did_ed, title, fname, mname, apply_title)

export did := apply_title;

end;