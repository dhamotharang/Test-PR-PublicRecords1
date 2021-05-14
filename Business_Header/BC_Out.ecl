IMPORT Business_Header, ut, lib_fileservices, header_services, NID, Suppress;

export bc_out(

	dataset(Layout_Business_Contact_Full_new)	pBc_plus	= Files().Base.Business_Contacts_Plus.Built

) := 
function

// Rollup Combined Contacts by BDID, Company across sources
// This code moved from BC_Init to preserve contacts by source code in base

bc := pBc_plus;

// Filter out EBR only BDIDS
//macFilterPassedBdids(bc, bdid, QueryGetEBROnlyBdids, bc_EBR_Filtered);
bc_Filtered := filters.outs.business_contacts(bc);

//////////////////////////////////////////////
//  Fix the future/invalid dates for output
//////////////////////////////////////////////
business_header.Layout_Business_Contact_Full fixbcdates(bc L) := transform
  self.dt_first_seen := map(validatedate((string8)L.dt_first_seen) = '' => 0, 
							L.dt_first_seen);
  self.dt_last_seen :=  map(validatedate((string8)L.dt_last_seen) = ''  => self.dt_first_seen, 
							L.dt_last_seen < self.dt_first_seen => self.dt_first_seen,
							L.dt_last_seen);
  self := L;
end;
bc_date_fix := project(if(Flags.Out.ShouldFilter, bc_Filtered, bc), fixbcdates(left));




Business_Contacts_Dist := DISTRIBUTE(bc_date_fix, HASH(bdid, TRIM(ut.CleanCompany(company_name)), TRIM(lname), zip));
Business_Contacts_Sort := SORT(Business_Contacts_Dist, bdid, ut.CleanCompany(company_name), company_title,
    lname, NID.PreferredFirstVersionedStr(fname, NID.version), mname, name_suffix, zip, prim_name, prim_range, company_zip, company_prim_name, company_prim_range, IF(phone<>0,0,1), Business_Header.Map_Source_Hierarchy(source), if(vendor_id <> '', 0, 1), LOCAL);
Business_Contacts_Grpd := GROUP(Business_Contacts_Sort, bdid, ut.CleanCompany(company_name), company_title,
    lname, NID.PreferredFirstVersionedStr(fname, NID.version), mname, name_suffix, zip, prim_name, prim_range, company_zip, company_prim_name, company_prim_range, LOCAL);

Business_Header.Layout_Business_Contact_Full RollupContacts(Business_Header.Layout_Business_Contact_Full L, Business_Header.Layout_Business_Contact_Full R) := TRANSFORM
SELF.dt_first_seen := ut.EarliestDate(L.dt_first_seen, R.dt_first_seen);
SELF.dt_last_seen := ut.LatestDate(L.dt_last_seen, R.dt_last_seen);
SELF.company_phone := IF(L.company_phone = 0, R.company_phone, L.company_phone);
SELF.company_fein := IF(L.company_fein = 0, R.company_fein, L.company_fein);
SELF := L;
END;

Business_Contacts_Rollup := GROUP(ROLLUP(Business_Contacts_Grpd, TRUE, RollupContacts(LEFT,RIGHT)));

// Rollup Contacts base to discard blank company addresses if contact and current clean name name, source, vendor_id exists with an address
BC_Base_Dist := distribute(Business_Contacts_Rollup,
                  hash(source, trim(vendor_id), trim(ut.CleanCompany(company_name))));

BC_Base_Sort := sort(BC_Base_Dist, source, vendor_id, ut.CleanCompany(company_name),
                     NID.PreferredFirstVersionedStr(fname, NID.version), mname, lname, name_suffix, company_title, zip, prim_name, prim_range,
					 if(record_type = 'C', 0, 1), if(company_zip <> 0, 0, 1), local);

BC_Base_Rollup := rollup(BC_Base_Sort,
                             left.source = right.source and
                             left.vendor_id <> '' and right.vendor_id <> '' and left.vendor_id = right.vendor_id and
							 ut.CleanCompany(left.company_name) = ut.CleanCompany(right.company_name) and
							 NID.PreferredFirstVersionedStr(left.fname, NID.version) = NID.PreferredFirstVersionedStr(right.fname, NID.version) and
							 ut.NNEQ(left.mname, right.mname) and
							 left.lname = right.lname and
							 ut.NNEQ(left.name_suffix, right.name_suffix) and
							 left.company_title = right.company_title and
							 left.zip = right.zip and
							 left.prim_name = right.prim_name and
							 left.prim_range = right.prim_range and
                             right.company_zip = 0,
							 Business_Header.TRA_Merge_Business_Contacts_Base(left, right),
							 local);


// Project Business Contacts File into Accurint format
Business_Header.Layout_Business_Contact_Out FormatOutput(Business_Header.Layout_Business_Contact_Full L) := TRANSFORM
SELF.bdid := IF(L.bdid <> 0, (STRING12)INTFORMAT(L.bdid, 12, 1), '');
SELF.did := IF(L.did <> 0, (STRING12)INTFORMAT(L.did, 12, 1), '');
SELF.ssn := IF(L.ssn <> 0, (STRING9)INTFORMAT(L.ssn, 9, 1), '');
SELF.dt_first_seen := IF(L.dt_first_seen <> 0, (STRING8)L.dt_first_seen, '');
SELF.dt_last_seen := IF(L.dt_last_seen <> 0, (STRING8)L.dt_last_seen, '');
SELF.company_zip := IF(L.company_zip <> 0, (STRING5)INTFORMAT(L.company_zip, 5, 1), '');
SELF.company_zip4 := IF(L.company_zip4 <> 0, (STRING4)INTFORMAT(L.company_zip4, 4, 1), '');
SELF.zip := IF(L.zip <> 0, (STRING5)INTFORMAT(L.zip, 5, 1), '');
SELF.zip4 := IF(L.zip4 <> 0, (STRING4)INTFORMAT(L.zip4, 4, 1), '');
SELF.phone := IF(L.phone <> 0, (STRING10)INTFORMAT(L.phone, 10, 1), '');
SELF.company_title := IF(L.source='F' AND L.company_title='OWNER', 'CONTACT', 
						IF(L.company_title != '', L.company_title, L.company_department));
self.name_suffix := if ( ut.is_unk(l.name_suffix),'',l.name_suffix);
self.DPPA_State := if(L.dppa, L.vendor_id[1..2], '');
SELF := L;
END;


//**********************************************
//*   BDID + Address
//**********************************************

in_hdr := PROJECT(BC_Base_Rollup, FormatOutput(LEFT));

full_out_suppress := project(Business_Header.Prep_Build.applyDidAddressBusiness_sup(in_hdr), Business_Header.Layout_Business_Contact_Out);


//**********************************************
//*   BDID + Address
//**********************************************


//**********************************************
//*   BDID Only
//**********************************************
Suppression_Layout := Suppress.applyRegulatory.layout_in;

header_services.Supplemental_Data.mac_verify('businesscontactsall_sup.txt', Suppression_Layout, contacts_all_supp_ds_func);
 
Contacts_All_Suppression_In := contacts_all_supp_ds_func();

dContactsAllSuppressedIn := project(Contacts_All_Suppression_In, Suppress.applyRegulatory.in_to_out(left));

rHashBDID := Suppress.applyRegulatory.layout_out;

rFullOut_HashBDID := record
 Business_Header.Layout_Business_Contact_Out;
 rHashBDID;
end;

rFullOut_HashBDID tHashBDID(Business_Header.Layout_Business_Contact_Out l) := transform                            
 self.hval := hashmd5(l.bdid);
 self := l;
end;

dContactAllHeader_withMD5 := project(full_out_suppress, tHashBDID(left));

Business_Header.Layout_Business_Contact_Out tContactAllSuppress(dContactAllHeader_withMD5 l) := transform
 self := l;
end;

contact_all_full_out_suppress := join(dContactAllHeader_withMD5,
																			dContactsAllSuppressedIn,
																			left.hval = right.hval,
																			tContactAllSuppress(left),
																			left only,
																			lookup);

//**********************************************
//*   BDID Only
//**********************************************



//**********************************************
//*   BDID + DID
//**********************************************

header_services.Supplemental_Data.mac_verify('businesscontacts_sup.txt', Suppression_Layout, contact_supp_ds_func);
 
Contact_Suppression_In := contact_supp_ds_func();

dContactSuppressedIn := project(Contact_Suppression_In, Suppress.applyRegulatory.in_to_out(left));

rHashBDIDDID := Suppress.applyRegulatory.layout_out;

rFullOut_HashBDIDDID := record
 Business_Header.Layout_Business_Contact_Out;
 rHashBDIDDID;
end;

rFullOut_HashBDIDDID tHashBDIDDID(Business_Header.Layout_Business_Contact_Out l) := transform                            
 self.hval := hashmd5(l.bdid, l.did);
 self := l;
end;

dContactHeader_withMD5 := project(contact_all_full_out_suppress, tHashBDIDDID(left));

Business_Header.Layout_Business_Contact_Out tContactSuppress(dContactHeader_withMD5 l) := transform
 self := l;
end;

contact_full_out_suppress := join(dContactHeader_withMD5,
																			dContactSuppressedIn,
																			left.hval = right.hval,
																			tContactSuppress(left),
																			left only,
																			lookup);

//**********************************************
//*   BDID + DID
//**********************************************


return Business_Header.Prep_Build.applyBusinessContactInj(contact_full_out_suppress);

end;