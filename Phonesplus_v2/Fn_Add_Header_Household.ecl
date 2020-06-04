/* ************ Function to add records from record not in phonesplus 
for relatives of individuals flagged as included.  The added records are generated
with the did from header and name from watchdog.  The other data is propagated 
from relative's record that exist in phonesplus 
************************** */
import phonesplus, header, Watchdog;

export Fn_Add_Header_Household(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function
//-----Because the data had to be transformed to the old layout, some unused fields
//     were used to store relavant date PhoneModel = Phonetype, GlobalKeyCode = hhid

land_lines := dedup(sort(distribute(phplus_in(in_flag and append_phone_type = 'POTS' and 
                                              did > 0 and hhid > 0), 
						 hash(did)), 
					did, npa+Phone7, -append_best_addr_match_flag, -DateLastSeen, local), 
			 did, npa+Phone7, local) ;

//-------Get did for the rest of the household
households := header.file_hhid_current(ver = 1);

temp_layout := record
unsigned6 main_did;
unsigned6 other_did;
unsigned6 hhid;
string20  fname := '';
string20  lname := '';
string20  mname := '';
end;

temp_layout t_get_household_dids (land_lines le, households ri) := transform 
	self.main_did  := le.did;
	self.other_did := ri.did;
	self.hhid      := (unsigned)le.hhid ;
end;

household_dids := join(distribute(land_lines, hash((unsigned)hhid)),
					   distribute(households, hash((unsigned)hhid)),
					   (unsigned)left.hhid  = (unsigned)right.hhid,
					   t_get_household_dids(left, right),
					   local);

//-------Get names for the rest of the household
Best_f := Watchdog.File_Best;

temp_layout t_get_best_names(household_dids le,  Best_f ri) := transform
	self.fname := ri.fname;
	self.mname := ri.mname;
	self.lname := ri.lname;
	self := le;
end;

get_best_names := join(distribute(household_dids, hash(other_did)),  
					   distribute(Best_f, hash(did)),
					   left.other_did = right.did,
					   t_get_best_names(left, right),
					   local);

//-------Generate a record for the rest of the household 
//-------with the same data as the indiv in Phonesplus, 
//-------but different name and did
 
other_household_members := get_best_names(main_did <> other_did);

recordof(phplus_in) t_other_members_recs(land_lines le, other_household_members ri) := transform
	self.did := ri.other_did;
	self.fname := ri.fname;
	self.mname := ri.mname;
	self.lname := ri.lname;
//----RecordKey = Rules -> bit map to store rules met
	self.rules := le.rules | Translation_Codes.rules_bitmap_code('Hdr-Household');
	self.household_flag := true;  //DF-25784 add indicator that this is a household record
	self.source := le.source; //DF-25784 use source of phones plus relative
	self := le; 
end;

other_members_recs := join(distribute(land_lines, hash(did)), 
				           distribute(other_household_members, hash(main_did)),
						   left.did = right.main_did,
						   t_other_members_recs(left, right),
						   keep (1),
						   local);

//-------Verify the additional dids-phone doesn't exist in phonesplus already
not_in_pplus := join(distribute(other_members_recs, hash(did)), 
					 distribute(phplus_in(did > 0), hash(did)),
					 left.did = right.did and
					 left.npa+left.Phone7 = right.npa+left.Phone7,
					 transform(recordof(phplus_in),
					 self := left),
					 left only,
					 local);


not_in_pplus_dedp := dedup(sort(distribute(not_in_pplus, hash(npa+Phone7)),
													npa+Phone7,
													fname,
													mname,
													lname,
													did,
													prim_range,
													prim_name,
													sec_range,
													zip5,
													local),
													npa+Phone7,
													fname,
													mname,
													lname,
													did,
													prim_range,
													prim_name,
													sec_range,
													zip5,
													local);

pplus_all := phplus_in +  not_in_pplus_dedp;
return pplus_all;
end;
