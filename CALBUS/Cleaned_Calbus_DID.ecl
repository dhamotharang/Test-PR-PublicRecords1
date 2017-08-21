import DID_Add, Header_Slimsort, ut, Lib_Stringlib, WatchDog, didville;

// Only DIDing the individual's owners.
in_file := Cleaned_Calbus_BDID(trim(Ownership_Code,left,right) in Calbus.Constants.OwnerShip_Code_Check);

ds_rest := Cleaned_Calbus_BDID(trim(Ownership_Code,left,right) not in Calbus.Constants.OwnerShip_Code_Check);

Layout_Calbus_WithDID := record
	unsigned6 DID       := 0;
	unsigned1 did_score := 0;
	Calbus.Layouts_Calbus.Layout_BDID;
end;

//#stored('did_add_force','roxi'); // remove or set to 'thor' to put recs through thor

matchSet := ['A'];

DID_Add.MAC_Match_Flex             // regular did macro
		(in_file, matchSet, '',
		 '', Owner_fname, Owner_mname, Owner_lname, Owner_name_suffix,
		 Business_prim_range, Business_prim_name, Business_sec_range, Business_zip5, Business_st, '',
		 DID,
		 Layout_Calbus_WithDID,
		 true, did_score,
		 75,                      //dids with a score below here will be dropped
		 Ds_Calbus_WithDID					
		)

Layout_Base := Calbus.Layouts_Calbus.Layout_base;

Layout_Base tDefault_ssn(Ds_Calbus_WithDID l) := transform
	self.ssn               := '';
	self.Owner_title       := if(l.did = 0 and l.bdid != 0, '', l.Owner_title);
	self.Owner_fname       := if(l.did = 0 and l.bdid != 0, '', l.Owner_fname);
	self.Owner_lname       := if(l.did = 0 and l.bdid != 0, '', l.Owner_lname);
	self.Owner_mname       := if(l.did = 0 and l.bdid != 0, '', l.Owner_mname);
	self.Owner_name_suffix := if(l.did = 0 and l.bdid != 0, '', l.Owner_name_suffix);
	self.Owner_name_score  := if(l.did = 0 and l.bdid != 0, '', l.Owner_name_score);
	self                   := l;
end;

In_Calbus_WithDidSsn := project(Ds_Calbus_WithDID, tDefault_ssn(left));

did_add.MAC_Add_SSN_By_DID(In_Calbus_WithDidSsn, did, ssn, Out_Calbus_WithDidSsn)

//output(count(Out_Calbus_WithDidSsn(trim(ssn,left,right)<>'')));

// Get the records to the same form as the records that went through the DID & SSN process.
Layout_Base tDefault_didSsn(ds_rest l) := transform
	self := l;
	self := [];
end;

fil_records := project(ds_rest, tDefault_didSsn(left));

Ds_Calbus_with_did_ssn := Out_Calbus_WithDidSsn + fil_records;

export Cleaned_Calbus_DID := Ds_Calbus_with_did_ssn : persist(Calbus.Constants.Cluster + 'Persist::Calbus::Cleaned_With_did_ssn_bdid');