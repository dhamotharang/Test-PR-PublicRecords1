Import Marketing_Best, Address, Doxie, ut, DMA, lib_Stringlib, did_add, Header_Slimsort, didville, NID, AID;
#option('multiplePersistInstances',FALSE);
In_File := Marketing_Best.File_Equifax_Infile;
Layout_normalized := record
	marketing_best.layout_equifax;
	String14 firstName;
	String1	middleInitial;
	String2 suffix;
	String1 gender;
	String2 Age;
	String4 Birth_Year;
	String2 Birth_Month;
	String1 Member_Code_of_Person;
	String1 household_member_cnt;
end;

Layout_normalized normalizeEquifax(In_File L, Unsigned1 cnt) := Transform
	Self.firstName 						:= choose(cnt, L.primary_given_name, L.given_name_2, L.given_name_3, L.given_name_4, L.given_name_5);
	Self.middleInitial 			:= choose(cnt, L.primary_middle_initial, L.middle_initial_2, L.middle_initial_3, L.middle_initial_4, L.middle_initial_5);
	Self.suffix						:= choose(cnt, L.primary_name_suffix,'', '', '', '');
	Self.gender         			:= choose(cnt, L.primary_gender, L.gender_2, L.gender_3, L.gender_4, L.gender_5);
	Self.Age 							:= choose(cnt, L.Age_1, L.Age_2, L.Age_3, L.Age_4, L.Age_5);
	Self.Birth_Year 				:= choose(cnt, L.Birth_Year_1, L.Birth_Year_2, L.Birth_Year_3, L.Birth_Year_4, L.Birth_Year_5);
	Self.Birth_Month 			:= choose(cnt, L.Birth_Month_1, L.Birth_Month_2, L.Birth_Month_3, L.Birth_Month_4, L.Birth_Month_5);
	Self.Member_Code_of_Person 	:= choose(cnt, L.Member_Code_of_Person_1, L.Member_Code_of_Person_2, L.Member_Code_of_Person_3, L.Member_Code_of_Person_4, L.Member_Code_of_Person_5);
	Self.household_member_cnt := choose(cnt, '1', '2', '3', '4', '5');
	Self 				:= L;
	Self := [];
end;

EquifaxNormal := normalize(In_File, 5, normalizeEquifax(Left, Counter));
slimmedEquifax := EquifaxNormal(trim(firstName, Left, Right) <> '' or trim(middleInitial, Left, Right) <>'' or trim(suffix, Left, Right) <> '') : persist('~Persist::TotalSolutions::slimmedEquifax');

Marketing_Best.layout_equifax_base xFormClnNames(slimmedEquifax L) := Transform
	String73 Cln_Name := Stringlib.StringToUpperCase(if(trim(trim(L.firstName, Left, Right) + ' ' +trim(L.Surname, Left, Right), Left, Right) <> '',
																									Address.CleanPerson73(trim(trim(L.Surname, Left, Right) + ' ' +
																																						trim(L.Suffix, Left, Right) + ', ' +
																																						trim(L.firstName, Left, Right) + ' ' +
																																						trim(L.middleInitial, Left, Right), Left, Right)), ''));			
							
	Self.title					:= Cln_Name[1..5];
	Self.fname				:= Cln_Name[6..25];
	Self.mname			:= Cln_Name[26..45];
	Self.lname				:= Cln_Name[46..65];
	Self.name_suffix	:= Cln_Name[66..70];
	Self.name_score		:= Cln_Name[71..73];							
	Self := L; 
	Self := [];
End;
dsClnNames := Project(slimmedEquifax, xFormClnNames(Left)) : persist('~Persist::TotalSolutions::ClnNames');


Lay_AidPrep := Record
Marketing_Best.layout_equifax_base;
String77	prep_addr_line1;
String54	prep_addr_line_last;
AID.Common.xAID	AID;
 unsigned8 	RawAid := 0;
End;

Lay_AidPrep prepAID(dsClnNames L) := transform
AddressLine1 := If(L.Box_Designator_and_Number <> '', Trim(StringLib.StringCleanSpaces(L.Box_Designator_and_Number), Left, Right), 
																								Trim(StringLib.StringCleanSpaces(L.House_Number + ' ' 
																																						+ L.Fraction + ' ' 
																																						+ L.Street_Prefix_Direction + ' ' 
																																						+ L.Contracted_Street_Address	+ ' ' 
																																						+ L.Route_Designator_and_Number	 + ' ' 
																																						+ L.Secondary_Unit_Designation), Left, Right));

Self.prep_addr_line1 := ut.fn_addr_clean_prep(StringLib.StringCleanSpaces( trim(AddressLine1, Left, Right)), 'first');
Self.prep_addr_line_last	:=	ut.fn_addr_clean_prep(StringLib.StringCleanSpaces(if(trim(L.Post_Office_Name, Left, Right) !='',
																										  trim(L.Post_Office_Name, Left, Right) + ', ' + trim(L.State_abbreviation, Left, Right) + ' ' +  trim(L.ZIP_code, Left, Right),
																										  trim(L.State_abbreviation, Left, Right) + ' ' + trim(L.ZIP_code, Left, Right))), 'last');	
Self := L;
Self := [];
end;

preppedAID := project(dsClnNames, prepAID(Left));
// Clean address using the AID maco
HasAddress := trim(preppedAID.prep_addr_line1, Left, Right) <> '' and trim(preppedAID.prep_addr_line_last, Left, Right) <> '';
								
dWith_address	:= preppedAID(HasAddress);
dWithout_address	:= preppedAID(not(HasAddress));

unsigned4	lFlags 	:= AID.Common.eReturnValues.ACECacheRecords;	


AID.MacAppendFromRaw_2Line(dWith_address, prep_addr_line1, prep_addr_line_last, RawAid, dwithAID, lFlags);
withAID := dwithAID : persist('~Persist::TotalSolutions::withAID');

// Populate the clean address fields from the AID cleaned address records
Marketing_Best.layout_equifax_base	popCleanAddr(withAID L) := transform		
Self.prim_range := L.aidwork_acecache.prim_range;
Self.predir := L.aidwork_acecache.predir;
Self.prim_name := L.aidwork_acecache.prim_name;
Self.addr_suffix := L.aidwork_acecache.addr_suffix;
Self.postdir := L.aidwork_acecache.postdir;
Self.unit_desig := L.aidwork_acecache.unit_desig;
Self.sec_range := L.aidwork_acecache.sec_range;
Self.p_city_name := L.aidwork_acecache.p_city_name;
Self.v_city_name := L.aidwork_acecache.v_city_name;
Self.st := L.aidwork_acecache.st;
Self.zip := L.aidwork_acecache.zip5;
Self.zip4 := L.aidwork_acecache.zip4;
Self.cart := L.aidwork_acecache.cart;
Self.cr_sort_sz := L.aidwork_acecache.cr_sort_sz;
Self.lot := L.aidwork_acecache.lot;
Self.lot_order := L.aidwork_acecache.lot_order;
Self.dpbc := L.aidwork_acecache.dbpc;
Self.chk_digit := L.aidwork_acecache.chk_digit;
Self.rec_type := L.aidwork_acecache.rec_type;
Self.ace_fips_st :=  L.aidwork_acecache.county[1..2];
Self.fips_county := L.aidwork_acecache.county[3..5];
Self.geo_lat := L.aidwork_acecache.geo_lat;
Self.geo_long := L.aidwork_acecache.geo_long;
Self.msa := L.aidwork_acecache.msa;
Self.geo_match := L.aidwork_acecache.geo_match;
Self.err_stat := L.aidwork_acecache.err_stat;
// Self.RawAid := L.aidwork_recordid;  //---- uncomment if we want to use this field
Self.telephone := lib_Stringlib.Stringlib.Stringfilter(trim(L.Area_CodeAll_Available, Left, Right) + 
																					trim(L.TelephoneAll_Available, Left, Right), '0123456789');
	
Self := L;		 
Self := [];
end;

// Add back the filtered blank address records to the rest of the file
dsAid := project(withAID, popCleanAddr(Left)) + 
										project(dWithout_address,transform(layout_equifax_base, Self := Left, Self := []));

cleanedAidFile := distribute(dsAid, HASH64(Post_Office_Name)) : persist('~Persist::TotalSolutions::Aid');


matchset :=['A','P','Z'];
did_Add.MAC_Match_Flex(cleanedAidFile, matchset,
												'', '', fname, mname, lname, name_suffix, 
												prim_range, prim_name, sec_range, zip, st, telephone,
												did,   		
												layout_equifax_base,
												false, did_score_field,	//these should default to zero in definition
												75,	  					//dids with a score below here will be dropped 
												DidOutfile);


dsDid := DidOutfile : persist('~Persist::TotalSolutions::Did');
ut.mac_sf_buildprocess(dsDid,'~thor_data400::base::eq_total_source', build_eq_total_source_base, 2);
Export proc_build_equifax_base := sequential(build_eq_total_source_base);
