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

	$.Layout_Base2 xForm($.Layout_Base2 newbase, $.Layout_Base2 base)	 :=	TRANSFORM
								// Physical Address Fields
								self.Physical_AddressCategory := Coalesce(newbase.Physical_AddressCategory, base.Physical_AddressCategory);
								self.Physical_Street1 := Coalesce(newbase.Physical_Street1, base.Physical_Street1);
								self.Physical_Street2 := Coalesce(newbase.Physical_Street2, base.Physical_Street2);
								self.Physical_City := Coalesce(newbase.Physical_City, base.Physical_City);
								self.Physical_State := Coalesce(newbase.Physical_State, base.Physical_State);
								self.Physical_Zip := Coalesce(newbase.Physical_Zip, base.Physical_Zip);
								// Mailing Address Fields
								self.Mailing_AddressCategory := Coalesce(newbase.Mailing_AddressCategory, base.Mailing_AddressCategory);
								self.Mailing_Street1 := Coalesce(newbase.Mailing_Street1, base.Mailing_Street1);
								self.Mailing_Street2 := Coalesce(newbase.Mailing_Street2, base.Mailing_Street2);
								self.Mailing_City := Coalesce(newbase.Mailing_City, base.Mailing_City);
								self.Mailing_State := Coalesce(newbase.Mailing_State, base.Mailing_State);
								self.Mailing_Zip := Coalesce(newbase.Physical_Zip, base.Mailing_Zip);

								// clean addresses
								self.prim_range := Coalesce(newbase.prim_range, base.prim_range);
								self.predir := Coalesce(newbase.predir, base.predir);
								self.prim_name := Coalesce(newbase.prim_name, base.prim_name);
								self.addr_suffix := Coalesce(newbase.addr_suffix, base.addr_suffix);
								self.postdir := Coalesce(newbase.postdir, base.postdir);
								self.unit_desig := Coalesce(newbase.unit_desig, base.unit_desig);
								self.sec_range := Coalesce(newbase.sec_range, base.sec_range);
								self.p_city_name := Coalesce(newbase.p_city_name, base.p_city_name);
								self.v_city_name := Coalesce(newbase.v_city_name, base.v_city_name);
								self.st := Coalesce(newbase.st, base.st);
								self.zip := Coalesce(newbase.zip, base.zip);
								self.zip4 := Coalesce(newbase.zip4, base.zip4);
								self.cart := Coalesce(newbase.cart, base.cart);
								self.cr_sort_sz := Coalesce(newbase.cr_sort_sz, base.cr_sort_sz);
								self.lot := Coalesce(newbase.lot, base.lot);
								self.lot_order := Coalesce(newbase.lot_order, base.lot_order);
								self.dbpc := Coalesce(newbase.dbpc, base.dbpc);
								self.chk_digit := Coalesce(newbase.chk_digit, base.chk_digit);
								self.rec_type := Coalesce(newbase.rec_type, base.rec_type);
								self.fips_state := Coalesce(newbase.fips_state, base.fips_state);
								self.fips_county := Coalesce(newbase.fips_county, base.fips_county);
								self.geo_lat := Coalesce(newbase.geo_lat, base.geo_lat);
								self.geo_long := Coalesce(newbase.geo_long, base.geo_long);
								self.msa := Coalesce(newbase.msa, base.msa);
								self.geo_blk := Coalesce(newbase.geo_blk, base.geo_blk);
								self.geo_match := Coalesce(newbase.geo_match, base.geo_match);
								self.err_stat := Coalesce(newbase.err_stat, base.err_stat);
						
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

EXPORT fn_MergeAddresses(DATASET($.Layout_Base2) newbase, DATASET($.Layout_Base2) base) := FUNCTION
	
	// addresses that apply to cases, not clients (ClientId='')
	caseAddr := DISTRIBUTE(newbase(addresstype<>'', ClientId=''), HASH32(CaseID));

	current := DISTRIBUTE(base,HASH32(CaseID)); 
	
	CaseAddressesUpdated := IF(EXISTS(caseAddr), fn_MergeCaseAddresses(caseAddr, current), current);
	
													
	// addresses that apply to clients (ClientId<>'')
	clientAddr := DISTRIBUTE(newbase(addresstype<>'', ClientId<>''), HASH32(CaseID));
		
	ClientAddressesUpdated := IF(EXISTS(clientAddr), fn_MergeClientAddresses(clientAddr, CaseAddressesUpdated), CaseAddressesUpdated);
	

	return ClientAddressesUpdated;

END;