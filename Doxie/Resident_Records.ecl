import doxie_raw, doxie_crs,lib_date,ut;
doxie.MAC_Selection_Declare()
doxie.MAC_Header_Field_Declare()

//use all comp address, but if Exclude_ResidentsForAssociatesAddresses_val then exclude those by DID
all_addrs:= doxie.Comp_Addresses((not Exclude_ResidentsForAssociatesAddresses_val) or (did not in set(doxie_crs.associate_summary, person2)));
//don't use residents of address older than 12 months
sys_dt := (string)StringLib.GetDateYYYYMMDD();
ca_entrp :=  all_addrs(LIB_Date.DaysApart((string8)dt_last_seen ,sys_dt)<= 365);
ca:= if(ut.IndustryClass.is_entrp,ca_entrp,all_addrs);

//
doxie.Layout_AddressSearch_plus makelas(ca l) := transform
	self.seq := l.address_Seq_no;
	self.state := l.st;
	self := l;
end;

ca_slim := project(ca, makelas(left));
r := doxie_raw.residents_raw
	(ca_slim,
	dateVal,
  dppa_purpose,
  glb_purpose,
	ssn_mask_value,
	ln_branded_value,
	probation_override_value);
	
ut.PermissionTools.GLB.mac_FilterOutMinors(r,rfil,,,dob)

export Resident_Records := rfil;