/*
Update Logic
There is no special update logic for Address Records.  
The latest received set of Address Records for a Case or Client are considered to be the whole truth,
  always treated as an update/replacement for previous Addresses if any exist.  
For example, if a prior submission had separate Physical and Mailing addresses assigned to a Case, 
  and a single Address Record is submitted for that Case, it becomes the lone Address Record for that case.

To ensure each NCF2 can be validated alone, if the Address Record is related to a Case, 
  that Case/Household Record should be submitted, too.  
If related to a Client, then that Client/Individual Record should be submitted.  
Note that submission of a Client/Individual Record similarly requires its Case/Household Record to be submitted, as well.

If easier to process, sending the entire Case data to update an Address—that is, the Case/Household Record, 
  all Client/Individual Records, and all updated Address Records—can be submitted to update the Address(es).


*/
IMPORT Std;
//temporary fix (used to use coalesce. fix: just use new address
string Coalesce1(string s1, string s2) := s1;
/***
Replace previous address with new address

****/
	$.Layout_Base2 xForm($.Layout_Base2 newbase, $.Layout_Base2 base)	 :=	TRANSFORM
								// Physical Address Fields
								self.Physical_AddressCategory := Coalesce1(newbase.Physical_AddressCategory, base.Physical_AddressCategory);
								self.Physical_Street1 := Coalesce1(newbase.Physical_Street1, base.Physical_Street1);
								self.Physical_Street2 := Coalesce1(newbase.Physical_Street2, base.Physical_Street2);
								self.Physical_City := Coalesce1(newbase.Physical_City, base.Physical_City);
								self.Physical_State := Coalesce1(newbase.Physical_State, base.Physical_State);
								self.Physical_Zip := Coalesce1(newbase.Physical_Zip, base.Physical_Zip);
								// Mailing Address Fields
								self.Mailing_AddressCategory := Coalesce1(newbase.Mailing_AddressCategory, base.Mailing_AddressCategory);
								self.Mailing_Street1 := Coalesce1(newbase.Mailing_Street1, base.Mailing_Street1);
								self.Mailing_Street2 := Coalesce1(newbase.Mailing_Street2, base.Mailing_Street2);
								self.Mailing_City := Coalesce1(newbase.Mailing_City, base.Mailing_City);
								self.Mailing_State := Coalesce1(newbase.Mailing_State, base.Mailing_State);
								self.Mailing_Zip := Coalesce1(newbase.Physical_Zip, base.Mailing_Zip);

								// clean addresses
								self.prim_range := Coalesce1(newbase.prim_range, base.prim_range);
								self.predir := Coalesce1(newbase.predir, base.predir);
								self.prim_name := Coalesce1(newbase.prim_name, base.prim_name);
								self.addr_suffix := Coalesce1(newbase.addr_suffix, base.addr_suffix);
								self.postdir := Coalesce1(newbase.postdir, base.postdir);
								self.unit_desig := Coalesce1(newbase.unit_desig, base.unit_desig);
								self.sec_range := Coalesce1(newbase.sec_range, base.sec_range);
								self.p_city_name := Coalesce1(newbase.p_city_name, base.p_city_name);
								self.v_city_name := Coalesce1(newbase.v_city_name, base.v_city_name);
								self.st := Coalesce1(newbase.st, base.st);
								self.zip := Coalesce1(newbase.zip, base.zip);
								self.zip4 := Coalesce1(newbase.zip4, base.zip4);
								self.cart := Coalesce1(newbase.cart, base.cart);
								self.cr_sort_sz := Coalesce1(newbase.cr_sort_sz, base.cr_sort_sz);
								self.lot := Coalesce1(newbase.lot, base.lot);
								self.lot_order := Coalesce1(newbase.lot_order, base.lot_order);
								self.dbpc := Coalesce1(newbase.dbpc, base.dbpc);
								self.chk_digit := Coalesce1(newbase.chk_digit, base.chk_digit);
								self.rec_type := Coalesce1(newbase.rec_type, base.rec_type);
								self.fips_state := Coalesce1(newbase.fips_state, base.fips_state);
								self.fips_county := Coalesce1(newbase.fips_county, base.fips_county);
								self.geo_lat := Coalesce1(newbase.geo_lat, base.geo_lat);
								self.geo_long := Coalesce1(newbase.geo_long, base.geo_long);
								self.msa := Coalesce1(newbase.msa, base.msa);
								self.geo_blk := Coalesce1(newbase.geo_blk, base.geo_blk);
								self.geo_match := Coalesce1(newbase.geo_match, base.geo_match);
								self.err_stat := Coalesce1(newbase.err_stat, base.err_stat);
						
					self.created := IF(base.addressType='', Std.Date.Today(), base.created);
					self.replaced := IF(newbase.addressType='', base.replaced, Std.Date.Today());
					self := base;
END;

fn_MergeClientAddresses(DATASET($.Layout_Base2) clientAddr, DATASET($.Layout_Base2) current) := FUNCTION

	/*
		Determine which address records are unchanged
		Do not process records that have previously been replaced
	*/
	unchanged := JOIN(current, clientAddr,
							LEFT.CaseId = RIGHT.CaseId AND LEFT.ClientId = RIGHT.ClientId AND
							LEFT.ProgramState = RIGHT.ProgramState and LEFT.ProgramCode = RIGHT.ProgramCode
							and LEFT.GroupId = RIGHT.GroupId,
								TRANSFORM($.Layout_Base2, self := LEFT),
								LEFT ONLY, LOCAL);
								
/*	newAddress := JOIN(current, clientAddr,
							LEFT.CaseId = RIGHT.CaseId AND LEFT.ClientId = RIGHT.ClientId AND
							LEFT.ProgramState = RIGHT.ProgramState and LEFT.ProgramCode = RIGHT.ProgramCode
							and LEFT.GroupId = RIGHT.GroupId,
								xForm(RIGHT, LEFT),
								RIGHT ONLY, LOCAL);*/

	updatedAddress := JOIN(current, clientAddr,
							LEFT.CaseId = RIGHT.CaseId AND LEFT.ClientId = RIGHT.ClientId AND
							LEFT.ProgramState = RIGHT.ProgramState and LEFT.ProgramCode = RIGHT.ProgramCode
							and LEFT.GroupId = RIGHT.GroupId,
								xForm(RIGHT, LEFT),
								INNER, LOCAL);


	return unchanged + updatedAddress;

END;

fn_MergeCaseAddresses(DATASET($.Layout_Base2) caseAddr, DATASET($.Layout_Base2) current) := FUNCTION

	/*
		Determine which address records are unchanged
		Do not process records that have previously been replaced
	*/
	unchanged := JOIN(current, caseAddr,
							LEFT.CaseId = RIGHT.CaseId AND
							LEFT.ProgramState = RIGHT.ProgramState and LEFT.ProgramCode = RIGHT.ProgramCode
							and LEFT.GroupId = RIGHT.GroupId,
								TRANSFORM($.Layout_Base2, self := LEFT),
								LEFT ONLY, LOCAL);
								
/*	newAddress := JOIN(current, caseAddr,
							LEFT.CaseId = RIGHT.CaseId AND
							LEFT.ProgramState = RIGHT.ProgramState and LEFT.ProgramCode = RIGHT.ProgramCode
							and LEFT.GroupId = RIGHT.GroupId,
								xForm(RIGHT, LEFT),
								RIGHT ONLY, LOCAL);*/

	updatedAddress := JOIN(current, caseAddr,
							LEFT.CaseId = RIGHT.CaseId AND
							LEFT.ProgramState = RIGHT.ProgramState and LEFT.ProgramCode = RIGHT.ProgramCode
							and LEFT.GroupId = RIGHT.GroupId,
								xForm(RIGHT, LEFT),
								INNER, LOCAL);


	return unchanged + updatedAddress;


END;
/**
JIRA DF_28954 Only update most recent case/client with new address
**/

EXPORT fn_MergeAddresses(DATASET($.Layout_Base2) newbase, DATASET($.Layout_Base2) base) := FUNCTION

	trecent := table(base, {caseid, clientid, latest := MAX(GROUP, enddate)}, caseid, clientid);
	recent := JOIN(DISTRIBUTE(base, hash32(caseid,clientid)), DISTRIBUTE(trecent, hash32(caseid,clientid)),
						left.caseid=right.caseid AND left.clientid=right.clientid AND left.enddate=right.latest,
						TRANSFORM(nac_V2.layout_base2, self := left), INNER, local);

	notrecent := JOIN(DISTRIBUTE(base, hash32(caseid,clientid)), DISTRIBUTE(trecent, hash32(caseid,clientid)),
						left.caseid=right.caseid AND left.clientid=right.clientid AND left.enddate<>right.latest,
						TRANSFORM(nac_V2.layout_base2, self := left), INNER, local);

	
	// addresses that apply to cases, not clients (ClientId='')
	caseAddr := DISTRIBUTE(newbase(addresstype<>'', ClientId=''), HASH32(CaseID));

	current := DISTRIBUTE(recent,HASH32(CaseID)); 
	
	CaseAddressesUpdated := IF(EXISTS(caseAddr), fn_MergeCaseAddresses(caseAddr, current), current);
	
													
	// addresses that apply to clients (ClientId<>'')
	clientAddr := DISTRIBUTE(newbase(addresstype<>'', ClientId<>''), HASH32(CaseID));
		
	ClientAddressesUpdated := IF(EXISTS(clientAddr), fn_MergeClientAddresses(clientAddr, CaseAddressesUpdated), CaseAddressesUpdated);
	

	return ClientAddressesUpdated + notrecent;

END;