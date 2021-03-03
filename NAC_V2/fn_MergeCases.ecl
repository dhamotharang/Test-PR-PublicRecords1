IMPORT Std;
/*

Update Logic
There is no special update logic for Case records.  
Because there are no dates, addresses, clients, and there is essentially little to impact other data, 
   they can be sent at any time.  

It is expected that if there are updates to previous Case records, it would be for the purpose of amending allotment amounts, 
  phone number(s), or email address information.

*/

EXPORT fn_MergeCases(DATASET($.Layout_Base2) newbase, DATASET($.Layout_Base2) base) := FUNCTION

	c1 := DISTRIBUTE(newbase, HASH32(CaseID)); 
	// find most recent version
	cases := DEDUP(SORT(c1, CaseId,ProgramState,ProgramCode,GroupId,-$.fn_lfnversion(filename), local),
									CaseId,ProgramState,ProgramCode,GroupId, local);

	baseCases := DISTRIBUTE(base,	HASH32(CaseId));

	updated := JOIN(baseCases, cases, 
							LEFT.CaseId = right.CaseId AND 
							LEFT.ProgramState = RIGHT.ProgramState and LEFT.ProgramCode = RIGHT.ProgramCode and LEFT.GroupId = RIGHT.GroupId,
							TRANSFORM($.Layout_Base2,
								self.case_Monthly_Allotment := IF(RIGHT.ProgramState='',LEFT.case_Monthly_Allotment,RIGHT.case_Monthly_Allotment);
								self.RegionCode := IF(RIGHT.ProgramState='',LEFT.RegionCode,RIGHT.RegionCode);
								self.CountyCode := IF(RIGHT.ProgramState='',LEFT.CountyCode,RIGHT.CountyCode);
								self.CountyName := IF(RIGHT.ProgramState='',LEFT.CountyName,RIGHT.CountyName);
								self.case_Phone1 := IF(RIGHT.ProgramState='',LEFT.case_Phone1,RIGHT.case_Phone1);
								self.case_Phone2 := IF(RIGHT.ProgramState='',LEFT.case_Phone2,RIGHT.case_Phone2);
								self.case_Email := IF(RIGHT.ProgramState='',LEFT.case_Email,RIGHT.case_Email);
								
								self.Created := LEFT.Created;
								self.Updated := IF(RIGHT.ProgramState='',LEFT.Updated,Std.Date.Today());
								self.FileName := IF(LEFT.FileName<>'',LEFT.FileName, right.FileName);	// keep original filename
								self.NCF_FileDate := IF(RIGHT.NCF_FileDate=0,LEFT.NCF_FileDate, right.NCF_FileDate);
								self.NCF_FileTime := IF(RIGHT.NCF_FileTime='',LEFT.NCF_FileTime, right.NCF_FileTime);
								//self.GroupId := IF(RIGHT.GroupId='',LEFT.GroupId,RIGHT.GroupId);
								//*** Update addresses
								self.addresstype := Coalesce(RIGHT.addresstype, LEFT.addresstype);
								// Physical Address Fields
								self.Physical_AddressCategory := Coalesce(RIGHT.Physical_AddressCategory, LEFT.Physical_AddressCategory);
								self.Physical_Street1 := Coalesce(RIGHT.Physical_Street1, LEFT.Physical_Street1);
								self.Physical_Street2 := Coalesce(RIGHT.Physical_Street2, LEFT.Physical_Street2);
								self.Physical_City := Coalesce(RIGHT.Physical_City, LEFT.Physical_City);
								self.Physical_State := Coalesce(RIGHT.Physical_State, LEFT.Physical_State);
								self.Physical_Zip := Coalesce(RIGHT.Physical_Zip, LEFT.Physical_Zip);
								// Mailing Address Fields
								self.Mailing_AddressCategory := Coalesce(RIGHT.Mailing_AddressCategory, LEFT.Mailing_AddressCategory);
								self.Mailing_Street1 := Coalesce(RIGHT.Mailing_Street1, LEFT.Mailing_Street1);
								self.Mailing_Street2 := Coalesce(RIGHT.Mailing_Street2, LEFT.Mailing_Street2);
								self.Mailing_City := Coalesce(RIGHT.Mailing_City, LEFT.Mailing_City);
								self.Mailing_State := Coalesce(RIGHT.Mailing_State, LEFT.Mailing_State);
								self.Mailing_Zip := Coalesce(RIGHT.Physical_Zip, LEFT.Mailing_Zip);

								// clean addresses
								self.prim_range := Coalesce(RIGHT.prim_range, LEFT.prim_range);
								self.predir := Coalesce(RIGHT.predir, LEFT.predir);
								self.prim_name := Coalesce(RIGHT.prim_name, LEFT.prim_name);
								self.addr_suffix := Coalesce(RIGHT.addr_suffix, LEFT.addr_suffix);
								self.postdir := Coalesce(RIGHT.postdir, LEFT.postdir);
								self.unit_desig := Coalesce(RIGHT.unit_desig, LEFT.unit_desig);
								self.sec_range := Coalesce(RIGHT.sec_range, LEFT.sec_range);
								self.p_city_name := Coalesce(RIGHT.p_city_name, LEFT.p_city_name);
								self.v_city_name := Coalesce(RIGHT.v_city_name, LEFT.v_city_name);
								self.st := Coalesce(RIGHT.st, LEFT.st);
								self.zip := Coalesce(RIGHT.zip, LEFT.zip);
								self.zip4 := Coalesce(RIGHT.zip4, LEFT.zip4);
								self.cart := Coalesce(RIGHT.cart, LEFT.cart);
								self.cr_sort_sz := Coalesce(RIGHT.cr_sort_sz, LEFT.cr_sort_sz);
								self.lot := Coalesce(RIGHT.lot, LEFT.lot);
								self.lot_order := Coalesce(RIGHT.lot_order, LEFT.lot_order);
								self.dbpc := Coalesce(RIGHT.dbpc, LEFT.dbpc);
								self.chk_digit := Coalesce(RIGHT.chk_digit, LEFT.chk_digit);
								self.rec_type := Coalesce(RIGHT.rec_type, LEFT.rec_type);
								self.fips_state := Coalesce(RIGHT.fips_state, LEFT.fips_state);
								self.fips_county := Coalesce(RIGHT.fips_county, LEFT.fips_county);
								self.geo_lat := Coalesce(RIGHT.geo_lat, LEFT.geo_lat);
								self.geo_long := Coalesce(RIGHT.geo_long, LEFT.geo_long);
								self.msa := Coalesce(RIGHT.msa, LEFT.msa);
								self.geo_blk := Coalesce(RIGHT.geo_blk, LEFT.geo_blk);
								self.geo_match := Coalesce(RIGHT.geo_match, LEFT.geo_match);
								self.err_stat := Coalesce(RIGHT.err_stat, LEFT.err_stat);
								//*** END Update addresses
								
								self := left;
						),
							LEFT OUTER, LOCAL);
/*							
	new := JOIN(baseCases, cases, 
							LEFT.CaseId = right.CaseId AND 
							LEFT.ProgramState = RIGHT.ProgramState and LEFT.ProgramCode = RIGHT.ProgramCode and LEFT.GroupId = RIGHT.GroupId,
							TRANSFORM($.Layout_Base2,
								self := right;
						),
						RIGHT ONLY, LOCAL);

							
		notcurrent := base(StartDate > std.date.Today() OR EndDate < std.date.Today());
*/
									
	return updated;

END;