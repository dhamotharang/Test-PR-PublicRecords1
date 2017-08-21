import DID_Add, Header_Slimsort, ut, Lib_Stringlib, WatchDog, didville;

// Only DIDing the Sole individual taxpayer's records. All other records taxpayer name contains the 
// Company names instead of individual names.
in_file := Cleaned_Txbus_BDID(trim(Taxpayer_Org_Type,left,right) = 'IS');

ds_rest := Cleaned_Txbus_BDID(trim(Taxpayer_Org_Type,left,right) != 'IS');

Layout_Txbus_WithDID := record
	unsigned6 DID       := 0;
	unsigned1 did_score := 0;
	Txbus.Layouts_Txbus.Layout_BDID;
end;

//#stored('did_add_force','roxi'); // remove or set to 'thor' to put recs through thor

matchSet := ['A','P'];

DID_Add.MAC_Match_Flex             // regular did macro
		(in_file, matchSet, '',
		 '', Taxpayer_fname, Taxpayer_mname, Taxpayer_lname, Taxpayer_name_suffix,
		 Taxpayer_prim_range, Taxpayer_prim_name, Taxpayer_sec_range, Taxpayer_zip5, Taxpayer_st, Taxpayer_phone,
		 DID,
		 Layout_Txbus_WithDID,
		 true, did_score,
		 75,                      //dids with a score below here will be dropped
		 Ds_Txbus_WithDID					
		)

Layout_Base := Txbus.Layouts_Txbus.Layout_base;

Layout_Base tDefault_ssn(Ds_Txbus_WithDID l) := transform
	self.ssn := '';
	self := l;
end;

In_Txbus_WithDidSsn := project(Ds_Txbus_WithDID, tDefault_ssn(left));

did_add.MAC_Add_SSN_By_DID(In_Txbus_WithDidSsn, did, ssn, Out_Txbus_WithDidSsn)

//output(count(Out_Txbus_WithDidSsn(trim(ssn,left,right)<>'')));

Layout_Base tDefault_didSsn(ds_rest l) := transform
	self := l;
	self := [];
end;

fil_records := project(ds_rest, tDefault_didSsn(left));

Ds_Txbus_with_did_ssn := Out_Txbus_WithDidSsn + fil_records;

export Cleaned_Txbus_DID := Ds_Txbus_with_did_ssn : persist(Txbus.Constants.Cluster + 'Persist::Txbus::Cleaned_With_did_ssn_bdid');
