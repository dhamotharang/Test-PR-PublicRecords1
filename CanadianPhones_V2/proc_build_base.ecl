import ut, CanadianPhones, PromoteSupers, did_add, doxie, Suppress;

CanadianPhones_V2.layoutCanadianWhitepagesBase fnRollupNewUpdates(CanadianPhones_V2.layoutCanadianWhitepagesBase L, CanadianPhones_V2.layoutCanadianWhitepagesBase R) := TRANSFORM

	self.Date_first_reported 			:= (STRING8) ut.min2((integer)L.Date_first_reported,(integer)R.Date_first_reported);
	self.Date_last_reported 			:= max(L.Date_last_reported,R.Date_last_reported);
	self.date_first_published 		:= (STRING6)ut.min2((integer)L.date_first_published,(integer)R.date_first_published);
	self.date_last_published 			:= max(L.date_last_published,R.date_last_published);
	self.pub_date 								:= max(L.pub_date,R.pub_date);
	self.history_flag							:= IF (L.history_flag='C' OR R.history_flag='C', 'C', R.history_flag);
	SELF := L;
	
END;

EXPORT proc_build_base := FUNCTION

//No new Axciom records so all will be marked historical 
	//new Axciom residential
	// axciom_res := CanadianPhones_V2.file_axciomCanRes_clean;
	//count(axciom_res);
	//new Axciom business
	//axciom_bus := CanadianPhones_V2.file_axciomCanBus_clean;
	
//New Infutor file mapping
	InfBase	:= CanadianPhones_V2.file_InfutorWP_v2;

	//existing record
	base := CanadianPhones_V2.file_CanadianWhitePagesBase;
	
	//Mark all records in existing records  to be historical
	base_hist := PROJECT(base, TRANSFORM({base}, 
	                                     SELF.history_flag :=IF(LEFT.history_flag='U','U','H');;
																			 SELF:=LEFT;));

	//Combine updates with existing base
  canadianwp := InfBase + base_hist;
	canadianwp_sort := sort(distribute(canadianwp,hash(phonenumber,
																										 Lastname,
																										 Middlename,
																										 Firstname)),
   												Phonenumber,
   												Lastname,
   												Firstname,
   												Middlename,
   												Generational,
   												Housenumber,
   												Directional,
   												Streetname,
   												Streetsuffix,
   												Suitenumber,
   												Postalcity,
   												Province,
   												Postalcode,
   												Phonetypeflag,
   												vendor,
   												Source_file,
   												Company_name,
   												Record_use_indicator,
   												LOCAL);
   
	canadianwp_rollup := ROLLUP(canadianwp_sort, 
															fnRollupNewUpdates(LEFT, RIGHT),
															Phonenumber,
															Lastname,
															Firstname,
															Middlename,
															Generational,
															Housenumber,
															Directional,
															Streetname,
															Streetsuffix,
															Suitenumber,
															Postalcity,
															Province,
															Postalcode,
															Phonetypeflag,
															vendor,
															Source_file,
															Company_name,
															Record_use_indicator,
															LOCAL);
	
	//CCPA-1030
	matchset := ['A', 'Z'];
	did_add.MAC_Match_Flex(canadianwp_rollup, matchset, '', '', fname, mname, lname, name_suffix, 
  prim_range, prim_name, sec_range, zip, state, '' , did, CanadianPhones_V2.layoutCanadianWhitepagesBase, TRUE, DID_Score,75, dCanadianPhonesWDID);

	//DF-16788
	PromoteSupers.MAC_SF_BuildProcess(dCanadianPhonesWDID,
													CanadianPhones.thor_cluster + 'base::canadianwp_v2',
													bld_base,
													2,,true
												);   

	RETURN bld_base;

END;
