import ut, CanadianPhones, PromoteSupers;

CanadianPhones_V2.layoutCanadianWhitepagesBase fnRollupNewUpdates(CanadianPhones_V2.layoutCanadianWhitepagesBase L, CanadianPhones_V2.layoutCanadianWhitepagesBase R) := TRANSFORM

	self.Date_first_reported 			:= (STRING8) ut.min2((integer)L.Date_first_reported,(integer)R.Date_first_reported);
	self.Date_last_reported 			:= (STRING8)ut.max2((integer)L.Date_last_reported,(integer)R.Date_last_reported);
	self.date_first_published 		:= (STRING6)ut.min2((integer)L.date_first_published,(integer)R.date_first_published);
	self.date_last_published 			:= (STRING6)ut.max2((integer)L.date_last_published,(integer)R.date_last_published);
	self.pub_date 								:= (STRING6)ut.max2((integer)L.pub_date,(integer)R.pub_date);
	self.history_flag							:= IF (L.history_flag='C' OR R.history_flag='C', 'C', R.history_flag);
	SELF := L;
	
END;

EXPORT proc_build_base := FUNCTION


	//new Axciom residential
	axciom_res := CanadianPhones_V2.file_axciomCanRes_clean;
	//count(axciom_res);
	//new Axciom business
	axciom_bus := CanadianPhones_V2.file_axciomCanBus_clean;

	//existing record
	base := CanadianPhones_V2.file_CanadianWhitePagesBase;
	
	//Mark all records in existing records  to be historical
	base_hist := PROJECT(base, TRANSFORM({base}, 
	                                     SELF.history_flag :=IF(LEFT.history_flag='U','U','H');
       																 //Added for CCPA-90
																		   SELF.global_sid   := 0;
																		   SELF.record_sid   := 0;
																			 SELF:=LEFT;));

	//Combine updates with existing base
  canadianwp := axciom_res + axciom_bus + base;
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
	//Clean up text string. They were originally in the rollup function however they were also the rollup condition
	CanadianPhones_V2.layoutCanadianWhitepagesBase cleanup(CanadianPhones_V2.layoutCanadianWhitepagesBase L) := TRANSFORM
		self.Lastname									:= ut.CleanSpacesAndUpper(L.Lastname);
		self.Firstname								:= ut.CleanSpacesAndUpper(L.Firstname);
		self.Middlename								:= ut.CleanSpacesAndUpper(L.Middlename);
		self.Generational							:= ut.CleanSpacesAndUpper(L.Generational);
		self.Housenumber							:= ut.CleanSpacesAndUpper(L.Housenumber);
		self.Directional							:= ut.CleanSpacesAndUpper(L.Directional);
		self.Streetname								:= ut.CleanSpacesAndUpper(L.Streetname);
		self.Streetsuffix							:= ut.CleanSpacesAndUpper(L.Streetsuffix);
		self.Suitenumber							:= ut.CleanSpacesAndUpper(L.Suitenumber);
		self.Suburbancity							:= ut.CleanSpacesAndUpper(L.Suburbancity);
		self.Postalcity								:= ut.CleanSpacesAndUpper(L.Postalcity);
		self.Province									:= ut.CleanSpacesAndUpper(L.Province);
		self.Postalcode								:= ut.CleanSpacesAndUpper(L.Postalcode);
		self.city											:= ut.CleanSpacesAndUpper(L.city);
		SELF := L;		
	END;
	canadianwp_cleaned := PROJECT(canadianwp_rollup,cleanup(LEFT));
	
	//DF-16788
	PromoteSupers.MAC_SF_BuildProcess(	canadianwp_rollup,
													CanadianPhones.thor_cluster + 'base::canadianwp_v2',
													bld_base,
													2,,true
												);   

	RETURN bld_base;

END;
