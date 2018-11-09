import ut, _validate, address, did_add,aid, std, nac, SALT32;

EXPORT Update_Base (string version, boolean pUseProd = false, boolean pUseDelta = false) := MODULE
	
	shared int_files_modname := Bair.Files_Intermediary(pUseProd);
	
	shared DataPro := Bair.files().dataprovider_base.built;
	
	shared Today := (string8)std.date.today() : INDEPENDENT;
	
	EXPORT MAC_AddressLookup(pUseDelta = false) := FUNCTIONMACRO
		
#if(pUseDelta)
		addrLkpCurr := Bair.Files(version, pUseProd).event_address_lookup_input;
		addrLkpPrev := Bair.files().AddressLookup_Base.Built;
		base_r 	  	:= dedup(distribute(addrLkpPrev + addrLkpCurr, hash(dataProviderID, address)), dataProviderID, address, all, local);
		
#else
		base_r := Bair.files().AddressLookup_Base.Built;
#end
		return base_r;
		
	ENDMACRO;
	
	EXPORT AddressLookup_base := FUNCTION
		base_f := if(pUseDelta, MAC_AddressLookup(true), MAC_AddressLookup(false));
		return base_f;
	END;
	
	EXPORT MAC_AgencyDeletes(pUseDelta = false) := FUNCTIONMACRO
		
#if(pUseDelta)
		agencyDelCurr := Bair.AgencyDeletes.eids_to_delete;
		agencyDelPrev := Bair.files().AgencyDeletes_base.Built;
		base_r 	  		:= dedup(agencyDelPrev + agencyDelCurr, eid, all);
		
#else
		base_r := dataset([], Bair.layouts.AgencyDeletes_Base);
#end
		return base_r;
		
	ENDMACRO;
	
	EXPORT AgencyDeletes_base := FUNCTION
		base_f := if(pUseDelta, MAC_AgencyDeletes(true), MAC_AgencyDeletes(false));
		return base_f;
	END;
	
	EXPORT MAC_CrimeTypeLookup(pUseDelta = false) := FUNCTIONMACRO
#if(pUseDelta)
		agencycrimes := Bair.Files(version, pUseProd).event_dbo_AgencyCrimeTypeLookup_input;
		base_r := if(count(agencycrimes) <> 0
								,project(agencycrimes, transform({agencycrimes}, self.crime := trim(left.crime, left, right); self := left))
								,Bair.files().AgencyCrimeLookup_Base.built);
#else
	base_r := Bair.files().AgencyCrimeLookup_Base.built;
#end
	return distribute(base_r, hash(dataproviderid, crime));
		
	ENDMACRO;
	
	EXPORT AgencyCrimeTypeLookup_base := FUNCTION
		base_f := if(pUseDelta, MAC_CrimeTypeLookup(true), MAC_CrimeTypeLookup(false));
		return base_f;
	END;
	
	EXPORT MAC_CfsTypeLookup(pUseDelta = false) := FUNCTIONMACRO
#if(pUseDelta)		
		agencycfstype := Bair.Files(version, pUseProd).cfs_dbo_AgencyCfsTypeLookup_Input;
		base_r := if(count(agencycfstype) <> 0
								,project(agencycfstype, transform({agencycfstype}, self.agencytype := trim(left.agencytype, left, right); self := left))
								,Bair.files().AgencyCfsLookup_Base.built);
#else
		base_r := Bair.files().AgencyCfsLookup_Base.built;
#end		
		return distribute(base_r, hash(dataproviderid, agencyType));
		
	ENDMACRO;
	
	EXPORT AgencyCfsTypeLookup_base := FUNCTION
		base_f := if(pUseDelta, MAC_CfsTypeLookup(true), MAC_CfsTypeLookup(false));
		return base_f;
	END;
	
	EXPORT MAC_DataProviderLoc(pUseDelta = false) := FUNCTIONMACRO
#if(pUseDelta)
		stdDataProviderLoc := Bair.Files(version, pUseProd).event_dbo_data_provider_location_input;
		base_r := if(count(stdDataProviderLoc) <> 0
								,stdDataProviderLoc
								,Bair.files().DataProviderLoc_Base.built);
#else
		base_r := Bair.files().DataProviderLoc_Base.built;
#end
		return base_r;
		
	ENDMACRO;
	
	EXPORT DataProviderLoc_base := FUNCTION
		base_f := if(pUseDelta, MAC_DataProviderLoc(true), MAC_DataProviderLoc(false));
		return base_f;
	END;
	
	EXPORT MAC_DataProviderImp(pUseDelta = false) := FUNCTIONMACRO
#if(pUseDelta)
		stdDataProviderImp := Bair.Files(version, pUseProd).event_dbo_data_provider_import_input;
		base_r := if(count(stdDataProviderImp) <> 0
								,stdDataProviderImp
								,Bair.files().DataProviderImp_Base.built);
#else
		base_r := Bair.files().DataProviderImp_Base.built;
#end
		return base_r;
		
	ENDMACRO;
	
	EXPORT DataProviderImp_base := FUNCTION
		base_f := if(pUseDelta, MAC_DataProviderImp(true), MAC_DataProviderImp(false));
		return base_f;
	END;
	
	EXPORT MAC_JOININPUTS_CFS(pPrepped = false) := FUNCTIONMACRO
	
		stdcfs_2				:= Bair.Standardize_Input(version, pUseProd, pPrepped).cfs_2;
		stdcfs_off_2		:= Bair.Standardize_Input(version, pUseProd, pPrepped).cfs_officers_2;
		stdDataProvider := Bair.Standardize_Input(version, pUseProd).Event_data_provider;
		
		DataProvider
				:= if(count(stdDataProvider) <> 0, stdDataProvider, Bair.files().dataprovider_base.built);
		
		JoinInputs
				:= join( distribute(stdcfs_2, hash(event_number, ori))
								,distribute(stdcfs_off_2, hash(event_number, ori))
								,left.event_number = right.event_number and left.ori = right.ori
								,left outer
								,local);
		
		CFSjoinDP
				:= join( JoinInputs
								,DataProvider
								,left.ORI = right.data_provider_id
								,lookup
								,LEFT OUTER);
											
		base_cfs
				:= distribute(project(CFSjoinDP
										,transform(Bair.layouts.dbo_cfs_Base
											,SELF.eid 	:= trim('CFS' + (string)(unsigned8)hash64(trim(left.event_number, left, right) + ':' + left.ORI), left, right);
											SELF.ts 		:= (unsigned6)regexreplace('-', ut.GetTimeDate(), '');
											_latitude 	:= LEFT.y_coordinate;
											_longitude  := LEFT.x_coordinate;
											SELF.gh12 	:= IF(Bair.Build_GeoHash.isValidCoord(_latitude, _longitude), SALT32.Fn_LatLongEncode(_latitude,_longitude,12), '');
											SELF.etype	:= 2;
											SELF.accuracy  := MAP(
																 left.accuracy_code =6 => 'Street'
																,left.accuracy_code =7 => 'Intersection'
																,left.accuracy_code =8 => 'Address'
																,''
																);			
											SELF 			:= LEFT;))
							,hash(eid));
											
		return base_cfs;
		
	ENDMACRO;
	
	EXPORT MAC_CFS(pUseDelta = false) := FUNCTIONMACRO		
		#uniquename(deltaFN)
		%deltaFN%			:= Bair.Filenames('',pUseProd,true).dbo_cfs_Base.built;
		#uniquename(linkflags)
		%linkflags% 	:= 'left.eid = right.eid,left only, local';
		#uniquename(prev_deltas)
		%prev_deltas% := Bair.Files('', pUseProd, true).cfs_base.built;
		#uniquename(int_deltas)
		%int_deltas%  := int_files_modname.cfs_d;
		#uniquename(res)
		#uniquename(nightly_w_prep)
		
#if(pUseDelta)		
		
		#uniquename(deltas)
		%deltas%
				:= join( %prev_deltas%
								 ,Bair.AgencyDeletes.eids_to_delete(regexfind('^CFS', eid))
								 ,left.eid = right.eid
								 ,left only
								 ,lookup);
							
		#uniquename(base_nightly_f)				
		%base_nightly_f% 	:= MAC_JOININPUTS_CFS(FALSE);
		
		#uniquename(base_prep_f)				
		%base_prep_f% 	  := MAC_JOININPUTS_CFS(TRUE);
											
		delta_superfile_subcnt 	:= nothor(STD.File.GetSuperFileSubCount(%deltaFN%));
		
		Bair.MAC_Join(%nightly_w_prep%,%base_nightly_f%,%base_prep_f%,%linkflags%);
		Bair.MAC_Join(%res%,%deltas%,%nightly_w_prep%,%linkflags%);
		
		base_r_ := if(delta_superfile_subcnt >= 1, %res%, %nightly_w_prep%);
		
#else	//Full Update on 7th day	
		#uniquename(full_base)
		%full_base%	:= DISTRIBUTE(Bair.files().cfs_Base.Built, hash(eid));
		
		#uniquename(new_base)
		%new_base%
				:= join(%full_base%,		
								Bair.files().AgencyDeletes_base.Built(regexfind('^CFS', eid)),
								left.eid = right.eid,
								left only,
								lookup,
								local);
						
		Bair.MAC_Join(%res%,%new_base%,%int_deltas%,%linkflags%);		
		base_r_ 	:= %res%;
#end

	  base_r 	:= join(base_r_, DataPro, left.data_provider_id = right.data_provider_id
										,transform({base_r_}
											,self.data_provider_ori := if(left.data_provider_id = right.data_provider_id, right.data_provider_ori, left.data_provider_ori);
											,self.data_provider_name := if(left.data_provider_id = right.data_provider_id, right.data_provider_name, left.data_provider_name);
											self := left; 
											)
										,lookup
										,LEFT OUTER
										);

		return DISTRIBUTE(dedup(base_r, record, all), hash(eid));
	ENDMACRO;
	
	EXPORT CFS_base := FUNCTION
		base_f := if(pUseDelta, MAC_CFS(true), MAC_CFS(false));
		return base_f;
	END;
	
	EXPORT MAC_JOININPUTS_MO_UDF(pPrepped = false) := FUNCTIONMACRO
	
		stdmo_udf 	:= Bair.Standardize_Input(version, pUseProd, pPrepped).mo_udf;
		base_mo_udf := distribute(project(stdmo_udf
											,transform(Bair.layouts.mo_udf_Base,
												self.eid 		:= trim('EVE' + (string)(unsigned8)hash64(trim(left.ir_number, left, right) + ':' + left.ORI), left, right);
												SELF.ts 		:= (unsigned6)regexreplace('-', ut.GetTimeDate(), '');
												self.crime	:= (unsigned8)hash64(trim(left.crime, left, right));
												self 				:= left;))
										,hash(eid, crime));
		return base_mo_udf;
		
	ENDMACRO;
	
	EXPORT MAC_MO_UDF(pUseDelta = false) := FUNCTIONMACRO
		#uniquename(deltaFN)
		%deltaFN%			:= Bair.Filenames('',pUseProd,true).event_dbo_mo_udf_Base.built;
		#uniquename(linkflags)
		%linkflags% 	:= 'left.eid = right.eid, left only, local';
		#uniquename(prev_deltas)
		%prev_deltas% := Bair.files('', pUseProd, true).mo_udf_Base.Built;
		#uniquename(int_deltas)
		%int_deltas%  := int_files_modname.mo_udf_d;
		#uniquename(res)
		#uniquename(nightly_w_prep)
		
#if(pUseDelta)
		
		#uniquename(deltas)
		%deltas%
				:= distribute(join(%prev_deltas%
										 ,Bair.AgencyDeletes.eids_to_delete(regexfind('^EVE', eid))
										 ,left.eid = right.eid
										 ,left only
										 ,lookup), hash(eid, crime));
		
		#uniquename(base_nightly_f)
		%base_nightly_f% := MAC_JOININPUTS_MO_UDF(false);
		
		#uniquename(base_prep_f)
		%base_prep_f% := MAC_JOININPUTS_MO_UDF(true);
		
		delta_superfile_subcnt 	:= nothor(STD.File.GetSuperFileSubCount(%deltaFN%));
		
		Bair.MAC_Join(%nightly_w_prep%,%base_nightly_f%,%base_prep_f%,%linkflags%);
		Bair.MAC_Join(%res%,%deltas%,%nightly_w_prep%,%linkflags%);
		
		base_r := if(delta_superfile_subcnt >= 1, %res%, %nightly_w_prep%);
		
#else	//Full Update on 7th day	
		#uniquename(full_base)
			%full_base%	:= DISTRIBUTE(Bair.files().mo_udf_Base.Built, hash(eid));
			
		#uniquename(new_base)
		%new_base% := join(	%full_base%,
												Bair.files().AgencyDeletes_base.Built(regexfind('^EVE', eid)),
												left.eid = right.eid,
												left only,
												lookup,
												local);
												
		Bair.MAC_Join(%res%,%new_base%,%int_deltas%,%linkflags%);		
		base_r 			:= %res%;
#end
		return distribute(dedup(base_r, record, all), hash(eid));
	ENDMACRO;
	
	EXPORT MO_UDF_base := FUNCTION
		base_f := if(pUseDelta, MAC_MO_UDF(true), MAC_MO_UDF(false));
		return base_f;
	END;
	
		
	EXPORT MAC_JOININPUTS_PERSONS_UDF(pPrepped = false) := FUNCTIONMACRO
	
		stdpersons_udf 	:= Bair.Standardize_Input(version, pUseProd, pPrepped).persons_udf;
		base_persons_udf
				:= distribute( project(stdpersons_udf
											,transform(Bair.layouts.persons_udf_Base
												,self.eid 		:= trim('EVE' + (string)(unsigned8)hash64(trim(left.ir_number, left, right) + ':' + left.ORI), left, right);
												SELF.ts 		  := (unsigned6)regexreplace('-', ut.GetTimeDate(), '');
												self 					:= left;))
										,hash(eid));
		return base_persons_udf;
		
	ENDMACRO;
	
	EXPORT MAC_PERSONS_UDF(pUseDelta = false) := FUNCTIONMACRO
		#uniquename(deltaFN)
		%deltaFN%			:= Bair.Filenames('',pUseProd,true).event_dbo_persons_udf_Base.built;
		#uniquename(linkflags)
		%linkflags% 	:= 'left.eid = right.eid, left only, local';
		#uniquename(prev_deltas)
		%prev_deltas% := Bair.files('', pUseProd, true).persons_udf_Base.Built;
		#uniquename(int_deltas)
		%int_deltas%  := int_files_modname.per_udf_d;
		#uniquename(res)
		#uniquename(nightly_w_prep)
		
#if(pUseDelta)		
		
		#uniquename(deltas)
		%deltas%
				:= join(%prev_deltas%
							 ,Bair.AgencyDeletes.eids_to_delete(regexfind('^EVE', eid))
							 ,left.eid = right.eid
							 ,left only
							 ,lookup);
					 
		#uniquename(base_nightly_f)
		%base_nightly_f% 	:= MAC_JOININPUTS_PERSONS_UDF(false);
		
		#uniquename(base_prep_f)
		%base_prep_f% 		:= MAC_JOININPUTS_PERSONS_UDF(true);
										
		delta_superfile_subcnt 	:= nothor(STD.File.GetSuperFileSubCount(%deltaFN%));
		
		Bair.MAC_Join(%nightly_w_prep%,%base_nightly_f%,%base_prep_f%,%linkflags%);
		Bair.MAC_Join(%res%,%deltas%,%nightly_w_prep%,%linkflags%);
		
		base_r := if(delta_superfile_subcnt >= 1, %res%, %nightly_w_prep%);
		
#else	//Full Update on 7th day	
		#uniquename(full_base)
		%full_base%	:= DISTRIBUTE(Bair.files().persons_udf_Base.Built, hash(eid));
		
		#uniquename(new_base)
		%new_base%
				:= join(%full_base%,
								Bair.files().AgencyDeletes_base.Built(regexfind('^EVE', eid)),
								left.eid = right.eid,
								left only,
								lookup,
								local);
		Bair.MAC_Join(%res%,%new_base%,%int_deltas%,%linkflags%);		
		base_r 			:= %res%;
#end
		return DISTRIBUTE(dedup(base_r, record, all), hash(eid));
	ENDMACRO;
	
	EXPORT PERSONS_UDF_base := FUNCTION
		base_f := if(pUseDelta, MAC_PERSONS_UDF(true), MAC_PERSONS_UDF(false));
		return base_f;
	END;
	
	EXPORT MAC_JOININPUTS_MO(pPrepped = false) := FUNCTIONMACRO
	
		stdmo								:= Bair.Standardize_Input(version, pUseProd, pPrepped).Event_mo;
		stdDataProvider 		:= Bair.Standardize_Input(version, pUseProd).Event_data_provider;
		stdDataProviderLoc	:= Bair.Files(version, pUseProd).event_dbo_data_provider_location_input;
		
		DataProvider 		:= if(count(stdDataProvider) <> 0, stdDataProvider, Bair.files().dataprovider_base.built);
		DataProviderLoc := if(count(stdDataProviderLoc) <> 0, stdDataProviderLoc, Bair.files().dataproviderloc_base.built);
		
		DP := join(DataProvider, DataProviderLoc, left.data_provider_id = right.dataProviderID, lookup, LEFT OUTER);
		
		moJoinDP	:= join(stdmo, DP, left.ORI = right.data_provider_id, lookup, LEFT OUTER);
					
		base_mo
				:= distribute( project(moJoinDP
											,transform(Bair.layouts.dbo_event_mo_final_Base
												,self.eid 		:= trim('EVE' + (string)(unsigned8)hash64(trim(left.ir_number, left, right) + ':' + left.ORI), left, right);
												SELF.ts 			:= (unsigned6)regexreplace('-', ut.GetTimeDate(), '');
												_latitude 		:= LEFT.y_coordinate;
												_longitude 		:= LEFT.x_coordinate;
												SELF.gh12 		:= IF(Bair.Build_GeoHash.isValidCoord(_latitude, _longitude), SALT32.Fn_LatLongEncode(_latitude,_longitude,12), '');
												self.etype 		:= 1;
												self.companions := left.companions;
												SELF.accuracy := MAP(
																		 left.accuracy_code =6 => 'Street'
																		,left.accuracy_code =7 => 'Intersection'
																		,left.accuracy_code =8 => 'Address'
																		,''
																		);
												self 					:= left;))
										,hash(eid));
		return base_mo;
		
	ENDMACRO;
	
	EXPORT MAC_MO(pUseDelta = false) := FUNCTIONMACRO
		#uniquename(deltaFN)
		%deltaFN%			:= Bair.Filenames('',pUseProd,true).dbo_event_mo_Base.built;
		#uniquename(linkflags)
		%linkflags% := 'left.eid = right.eid,left only, local';
		#uniquename(prev_deltas)
		%prev_deltas% := Bair.files('', pUseProd, true).mo_Base.Built;
		#uniquename(int_deltas)
		%int_deltas%  := int_files_modname.mo_d;
		#uniquename(res)
		#uniquename(nightly_w_prep)
		
#if(pUseDelta)		
		
		#uniquename(deltas)
		%deltas%
				:= join(%prev_deltas%
							 ,Bair.AgencyDeletes.eids_to_delete(regexfind('^EVE', eid))
							 ,left.eid = right.eid
							 ,left only
							 ,lookup);
					 
		#uniquename(base_nightly_f)
		%base_nightly_f%  := MAC_JOININPUTS_MO(false);
		
		#uniquename(base_prep_f)
		%base_prep_f% 		:= MAC_JOININPUTS_MO(true);
											
		delta_superfile_subcnt 	:= NOTHOR(STD.File.GetSuperFileSubCount(%deltaFN%));
		
		Bair.MAC_Join(%nightly_w_prep%,%base_nightly_f%,%base_prep_f%,%linkflags%);
		Bair.MAC_Join(%res%,%deltas%,%nightly_w_prep%,%linkflags%);
		
		base_r_ := if(delta_superfile_subcnt >= 1, %res%, %nightly_w_prep%);
		
#else
		#uniquename(full_base)
			%full_base%	:= DISTRIBUTE(Bair.files().mo_Base.Built,hash(eid));
			
		#uniquename(new_base)
			%new_base%
				:= join(%full_base%,
								Bair.files().AgencyDeletes_base.Built(regexfind('^EVE', eid)),
								left.eid = right.eid,
								left only,
								lookup,
								local);
		Bair.MAC_Join(%res%,%new_base%,%int_deltas%,%linkflags%);		
		base_r_	:= %res%;
#end
		base_r 	:= join(base_r_, DataPro, left.data_provider_id = right.data_provider_id
										,transform({base_r_}
											,self.data_provider_ori := if(left.data_provider_id = right.data_provider_id, right.data_provider_ori, left.data_provider_ori);
											,self.data_provider_name := if(left.data_provider_id = right.data_provider_id, right.data_provider_name, left.data_provider_name);
											self := left; 
											)
										,lookup
										,LEFT OUTER
										);
		return DISTRIBUTE(dedup(base_r, record, all),hash(eid));
	ENDMACRO;
	
	EXPORT MO_base := FUNCTION
		base_f := if(pUseDelta, MAC_MO(true), MAC_MO(false));
		return base_f;
	END;
	
	EXPORT MAC_JOININPUTS_PERSONS(pPrepped = false) := FUNCTIONMACRO
	
		stdpersons					:= Bair.Standardize_Input(version, pUseProd, pPrepped).Event_persons;
		stdDataProvider 		:= Bair.Standardize_Input(version, pUseProd).Event_data_provider;
		stdDataProviderLoc	:= Bair.Files(version, pUseProd).event_dbo_data_provider_location_input;
		
		DataProvider 		:= if(count(stdDataProvider) <> 0, stdDataProvider, Bair.files().dataprovider_base.built);
		DataProviderLoc := if(count(stdDataProviderLoc) <> 0, stdDataProviderLoc, Bair.files().dataproviderloc_base.built);
		
		DP := join(DataProvider, DataProviderLoc, left.data_provider_id = right.dataProviderID, lookup, LEFT OUTER);
		
		personsJoinDP := join(stdpersons, DP, left.ORI = right.data_provider_id, lookup, LEFT OUTER);
					
		base_persons
				:= distribute(project(personsJoinDP, transform(Bair.layouts.dbo_event_persons_final_Base,
											self.eid 							:= trim('EVE' + (string)(unsigned8)hash64(trim(left.ir_number, left, right) + ':' + left.ORI), left, right);
											SELF.ts 							:= (unsigned6)regexreplace('-', ut.GetTimeDate(), '');
											_latitude 						:= LEFT.persons_x_coordinate;
											_longitude 						:= LEFT.persons_y_coordinate;
											SELF.gh12 						:= IF(Bair.Build_GeoHash.isValidCoord(_latitude, _longitude), SALT32.Fn_LatLongEncode(_latitude,_longitude,12), '');
											self.etype 						:= 1;
											SELF.persons_accuracy := MAP(left.persons_accuracy_code =6 => 'Street'
																									,left.persons_accuracy_code =7 => 'Intersection'
																									,left.persons_accuracy_code =8 => 'Address'
																									,'');
											self.base64 					:= if(pPrepped, true, false);
											SELF 									:= left;))
						,hash(eid));
		return base_persons;
		
	ENDMACRO;
	
	EXPORT MAC_EventPersons(pUseDelta = false) := FUNCTIONMACRO
		#uniquename(deltaFN)
		%deltaFN%			:= Bair.Filenames('',pUseProd,true).dbo_event_persons_Base.built;
		#uniquename(linkflags)
		%linkflags% 	:= 'left.eid = right.eid,left only, local';
		#uniquename(prev_deltas)
		%prev_deltas% := distribute(Bair.files('', pUseProd, true).persons_Base.Built, hash(eid));
		#uniquename(int_deltas)
		%int_deltas%  := int_files_modname.per_d;
		#uniquename(res)
		#uniquename(nightly_w_prep)
		
#if(pUseDelta)
		
		#uniquename(deltas)
		// %deltas% := join(%prev_deltas%
		%deltas% := join(%prev_deltas% - %prev_deltas%(ir_number = '100001421' and ori = 581)
										 ,Bair.AgencyDeletes.eids_to_delete(regexfind('^EVE', eid))
										 ,left.eid = right.eid
										 ,left only
										 ,lookup);
					 
		#uniquename(base_nightly_f)
		%base_nightly_f%  := MAC_JOININPUTS_PERSONS(false);
		
		#uniquename(base_prep_f)
		%base_prep_f% 		:= MAC_JOININPUTS_PERSONS(true);	
									
		delta_superfile_subcnt 	:= nothor(STD.File.GetSuperFileSubCount(%deltaFN%));
		
		Bair.MAC_Join(%nightly_w_prep%,%base_nightly_f%,%base_prep_f%,%linkflags%);
		Bair.MAC_Join(%res%,%deltas%,%nightly_w_prep%,%linkflags%);
		
		base_r_ := if(delta_superfile_subcnt >= 1, %res%, %nightly_w_prep%);
		
#else		
		#uniquename(full_base)
		%full_base%	:= DISTRIBUTE(Bair.files().persons_Base.Built, hash(eid));
			
		#uniquename(new_base)
		%new_base%
				:= join(%full_base%,
								Bair.files().AgencyDeletes_base.Built(regexfind('^EVE', eid)),
								left.eid = right.eid,
								left only,
								lookup,
								local);
		Bair.MAC_Join(%res%,%new_base%,%int_deltas%,%linkflags%);
		base_r_ := %res%;
				
#end
		UpdateBase_w_DP 	:= join(base_r_, DataPro, left.data_provider_id = right.data_provider_id
										,transform({base_r_}
											,self.data_provider_ori := if(left.data_provider_id = right.data_provider_id, right.data_provider_ori, left.data_provider_ori);
											,self.data_provider_name := if(left.data_provider_id = right.data_provider_id, right.data_provider_name, left.data_provider_name);
											self := left; 
											)
										,lookup
										,LEFT OUTER
										);
										
		base_r 	:= Bair.PatchEventStamps.UpdatePer(UpdateBase_w_DP);
		return DISTRIBUTE(dedup(base_r, record, all), hash(eid));
		
	ENDMACRO;
	
	EXPORT PERSONS_base := FUNCTION
		base_f := if(pUseDelta, MAC_EventPersons(true), MAC_EventPersons(false));
		return base_f;
	END;
	
	EXPORT MAC_JOININPUTS_VEHICLE(pPrepped = false) := FUNCTIONMACRO
	
		stdvehicle					:= Bair.Standardize_Input(version, pUseProd, pPrepped).Event_vehicle;
		stdDataProvider 		:= Bair.Standardize_Input(version, pUseProd).Event_data_provider;
		stdDataProviderLoc	:= Bair.Files(version, pUseProd).event_dbo_data_provider_location_input;
		
		DataProvider 		:= if(count(stdDataProvider) <> 0, stdDataProvider, Bair.files().dataprovider_base.built);
		DataProviderLoc := if(count(stdDataProviderLoc) <> 0, stdDataProviderLoc, Bair.files().dataproviderloc_base.built);
		
		DP := join(DataProvider, DataProviderLoc, left.data_provider_id = right.dataProviderID, lookup, LEFT OUTER);
		
		vehicleJoinDP := join(stdvehicle, DP, left.ORI = right.data_provider_id, lookup, LEFT OUTER);
					
		base_vehicle
				:= distribute(project(vehicleJoinDP,
											transform(Bair.layouts.dbo_event_vehicle_final_Base
												,self.eid 						:= trim('EVE' + (string)(unsigned8)hash64(trim(left.ir_number, left, right) + ':' + left.ORI), left, right);
												SELF.ts 							:= (unsigned6)regexreplace('-', ut.GetTimeDate(), '');
												_latitude 						:= LEFT.vehicle_y_coordinate;
												_longitude 						:= LEFT.vehicle_x_coordinate;
												SELF.gh12 						:= IF(Bair.Build_GeoHash.isValidCoord(_latitude, _longitude), SALT32.Fn_LatLongEncode(_latitude,_longitude,12), '');
												SELF.etype 						:= 1;
												SELF.vehicle_accuracy := MAP(left.vehicle_accuracy_code =6 => 'Street'
																											,left.vehicle_accuracy_code =7 => 'Intersection'
																											,left.vehicle_accuracy_code =8 => 'Address'
																											,'');
												SELF 									:= LEFT;))
										,hash(eid));
		return base_vehicle;
		
	ENDMACRO;
	
	EXPORT MAC_EventVehicle(pUseDelta = false) := FUNCTIONMACRO
		#uniquename(deltaFN)
		%deltaFN%			:= Bair.Filenames('',pUseProd,true).dbo_event_vehicle_Base.built;
		#uniquename(linkflags)
		%linkflags% 	:= 'left.eid = right.eid,left only, local';
		#uniquename(prev_deltas)
		%prev_deltas% := Bair.files('', pUseProd, true).vehicle_Base.Built;
		#uniquename(int_deltas)
		%int_deltas%  := int_files_modname.veh_d;
		#uniquename(res)
		#uniquename(nightly_w_prep)
		
#if(pUseDelta)

		#uniquename(deltas)
			%deltas%
				:= join(%prev_deltas%
							 ,Bair.AgencyDeletes.eids_to_delete(regexfind('^EVE', eid))
							 ,left.eid = right.eid
							 ,left only
							 ,lookup);
					 
		#uniquename(base_nightly_f)
		%base_nightly_f%  := MAC_JOININPUTS_VEHICLE(false);
		
		#uniquename(base_prep_f)
		%base_prep_f% 		:= MAC_JOININPUTS_VEHICLE(true);
									
		delta_superfile_subcnt 	:= NOTHOR(STD.File.GetSuperFileSubCount(%deltaFN%));
		
		Bair.MAC_Join(%nightly_w_prep%,%base_nightly_f%,%base_prep_f%,%linkflags%);
		Bair.MAC_Join(%res%,%deltas%,%nightly_w_prep%,%linkflags%);
		
		base_r_ := if(delta_superfile_subcnt >= 1, %res%, %nightly_w_prep%);
		
#else
		#uniquename(full_base)
		%full_base%	:= DISTRIBUTE(Bair.files().vehicle_Base.Built, hash(eid));
		
		#uniquename(new_base)
		%new_base%
				:= join(%full_base%,
								Bair.files().AgencyDeletes_base.Built(regexfind('^EVE', eid)),
								left.eid = right.eid,
								left only,
								lookup,
								local);
								
		Bair.MAC_Join(%res%,%new_base%,%int_deltas%,%linkflags%);		
		base_r_	:= %res%;
#end
		UpdateBase_w_DP 	:= join(base_r_, DataPro, left.data_provider_id = right.data_provider_id
										,transform({base_r_}
											,self.data_provider_ori := if(left.data_provider_id = right.data_provider_id, right.data_provider_ori, left.data_provider_ori);
											,self.data_provider_name := if(left.data_provider_id = right.data_provider_id, right.data_provider_name, left.data_provider_name);
											self := left; 
											)
										,lookup
										,LEFT OUTER
										);
		base_r	:= Bair.PatchEventStamps.UpdateVeh(UpdateBase_w_DP);
		return DISTRIBUTE(dedup(base_r, record, all), hash(eid));
	ENDMACRO;
	
	EXPORT VEHICLE_base := FUNCTION
		base_f := if(pUseDelta, MAC_EventVehicle(true), MAC_EventVehicle(false));
		return base_f;
	END;
	
	EXPORT MAC_Group_Access(pUseDelta = false) := FUNCTIONMACRO	
		stdgroup_access	:= Bair.Standardize_Input(version, pUseProd).event_group_access;
		stdDataProvider := Bair.Standardize_Input(version, pUseProd).Event_data_provider;
		
		DataProvider 		:= if(count(stdDataProvider) <> 0, stdDataProvider, Bair.files().dataprovider_base.built);
		
#if(pUseDelta)
		new_base_d
				:= join(stdgroup_access, DataProvider, left.ori = right.data_provider_ori, left outer);
		base_r
				:= if(count(new_base_d) <> 0
							,project(new_base_d, Bair.layouts.event_group_access_Base)
							,Bair.files().group_access_base.built);
#else
		base_r := Bair.files().group_access_base.built;
#end
		return base_r;

	ENDMACRO;
	
	EXPORT GROUP_ACCESS_base := FUNCTION
		base_f := if(pUseDelta, MAC_Group_Access(true), MAC_Group_Access(false));
		return base_f;
	END;	
	
	EXPORT MAC_Intel(pUseDelta = false) := FUNCTIONMACRO
	
		#uniquename(deltaFN)
		%deltaFN%			:= Bair.Filenames('',pUseProd,true).dbo_intel_Base.built;
		#uniquename(linkflags)
		%linkflags% := 'left.eid = right.eid,left only, local';
		#uniquename(prev_deltas)
		%prev_deltas% := Bair.files('', pUseProd, true).intel_Base.Built;
		#uniquename(int_deltas)
		%int_deltas%  := int_files_modname.int_d;
		#uniquename(res)
		
#if(pUseDelta)
		stdIncident 				:= Bair.Standardize_Input(version, pUseProd).intel_incident;
		stdIncidentNotes 		:= Bair.Standardize_Input(version, pUseProd).intel_incident_notes;
		stdEntity 					:= Bair.Standardize_Input(version, pUseProd).intel_entity;
		stdEntityNotes 			:= Bair.Standardize_Input(version, pUseProd).intel_entity_notes;
		stdReportingOfficer := dedup(Bair.Standardize_Input(version, pUseProd).intel_reporting_officer, all);
		stdVehicleNotes 		:= Bair.Standardize_Input(version, pUseProd).intel_vehicle_notes;
		stdEntityPhoto			:= Bair.Standardize_Input(version, pUseProd).intel_entity_photo;
		stdDataProvider 		:= Bair.Standardize_Input(version, pUseProd).Event_data_provider;
		
		DataProvider 		:= if(count(stdDataProvider) <> 0, stdDataProvider, Bair.files().dataprovider_base.built);
				
		Incident_W_IncidentNotes
				:= join(stdIncident
							 ,stdIncidentNotes
							 ,left.notes_id = right.id
							 ,left outer);
		incident_view
				:= join(Incident_W_IncidentNotes
							 ,stdReportingOfficer
							 ,left.reporting_officer_id = right.id
							 ,left outer
							 ,keep(1));
							 
		Entity_W_EntityNotes
				:= join(stdEntity
							 ,stdEntityNotes
							 ,left.entity_notes_id = right.id
							 ,left outer);
		Entity_W_EntityNotes_W_EntityPhoto
				:= join(Entity_W_EntityNotes
							 ,stdEntityPhoto
							 ,left.ENTITY_PHOTO_ID = right.id
							 ,left outer);
		entity_view
				:= join(Entity_W_EntityNotes_W_EntityPhoto
							 ,stdVehicleNotes
							 ,left.vehicle_notes_id = right.id
							 ,left outer);
		intel
				:= join(incident_view
							 ,entity_view
							 ,left.id = right.incident_id
							 ,full outer);
							 
		new_base_d
				:= join( intel
								,DataProvider
								,left.dataProviderId = right.data_provider_id
								,lookup
								,LEFT OUTER);		
									
		new_base_f
				:= project(new_base_d
									,transform(Bair.layouts.dbo_intel_Base
										,self.eid 	:= trim('INT' + (string)(unsigned8)hash64(trim((string)left.id, left, right)), left, right);
										SELF.ts 		:= (unsigned6)regexreplace('-', ut.GetTimeDate(), '');
										_latitude 	:= LEFT.y;
										_longitude 	:= LEFT.x;
										SELF.gh12 	:= IF(Bair.Build_GeoHash.isValidCoord(_latitude, _longitude), SALT32.Fn_LatLongEncode(_latitude,_longitude,12), '');
										SELF.etype 	:= 5;
										SELF.id 		:= LEFT.entity_id;
										SELF 				:= LEFT;));
		
		#uniquename(base_f)
		%base_f% := distribute(dedup(new_base_f, record
				,except duration_since, ts, src, dt_vendor_first_reported, dt_vendor_last_reported, dt_first_seen, dt_last_seen, record_type
				,all), hash(eid));
		
		delta_superfile_subcnt 	:= NOTHOR(STD.File.GetSuperFileSubCount(%deltaFN%));
		Bair.MAC_Join(%res%,%prev_deltas%,%base_f%,%linkflags%);
		
		base_r_ := if(delta_superfile_subcnt >= 1, %res%, %base_f%);		
#else
		#uniquename(full_base)
		%full_base%	:= DISTRIBUTE(Bair.files().intel_Base.Built, hash(eid));
		
		#uniquename(new_base)
		%new_base% := %full_base%;
												
		Bair.MAC_Join(%res%,%new_base%,%int_deltas%,%linkflags%);		
		base_r_ := %res%;
#end
		int_base := project(base_r_, transform(Bair.layouts.dbo_intel_Base,
									clean_update_date := (unsigned4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(LEFT.update_date,'.>$!%*@=?&\''),left,right));
									duration := if(clean_update_date > LEFT.clean_incident_entry_date
											,Bair.DurationApart((string8)clean_update_date, Today)
											,Bair.DurationApart((string8)LEFT.clean_incident_entry_date, Today));
									self.duration_since	:= if(duration[1].failed = false and (clean_update_date <> 0 or LEFT.clean_incident_entry_date <> 0)
											,duration[1].yrs + if(duration[1].yrs > 1, ' years ', ' year ') + duration[1].mons + if(duration[1].mons > 1, ' months ', ' month ') + duration[1].days + if(duration[1].days > 1, ' days', ' day')
											,'');
									SELF 	:= LEFT;));
		base_r 	:= join(int_base, DataPro, left.data_provider_id = right.data_provider_id
										,transform({base_r_}
											,self.data_provider_ori := if(left.data_provider_id = right.data_provider_id, right.data_provider_ori, left.data_provider_ori);
											,self.data_provider_name := if(left.data_provider_id = right.data_provider_id, right.data_provider_name, left.data_provider_name);
											self := left; 
											)
										,lookup
										,LEFT OUTER
										);
		return distribute(dedup(base_r, record, all), hash(eid));
	ENDMACRO;
	
	EXPORT INTEL_base := FUNCTION
		base_f := if(pUseDelta, MAC_Intel(true), MAC_Intel(false));
		return base_f;
	END;
	
	EXPORT MAC_JOININPUTS_OFFENDERS(pPrepped = false) := FUNCTIONMACRO
	
		stdoff 					:= Bair.Standardize_Input(version, pUseProd, pPrepped).offenders_offender;
		stdoff_class 		:= Bair.Standardize_Input(version, pUseProd, pPrepped).offenders_offender_classification;
		// stdclass 				:= Bair.Standardize_Input(version, pUseProd, pPrepped).offenders_classification;			
		stdclass 				:= bair.files().offenders_class_Base.built;			
		stdDataProvider := Bair.Standardize_Input(version, pUseProd).Event_data_provider;
		
		DataProvider 		:= if(count(stdDataProvider) <> 0, stdDataProvider, Bair.files().dataprovider_base.built);
		
		class 
				:= join(stdoff_class
							,stdclass
   						,left.classification = right.classification_code
							,lookup
   						,left outer);
		
		OffJoinClass
				:= join(distribute(stdoff, hash(agency_offender_id, ori))
											,distribute(class, hash(agency_offender_id, ori))
   										,left.agency_offender_id = right.agency_offender_id and left.ori = right.ori
   										,left outer
   										,local);
		
		OffJoinDP
				:= join(OffJoinClass
									,DataProvider
									,left.ori = right.data_provider_id
									,lookup
									,LEFT OUTER);
		
		base_offenders
				:= distribute(project(OffJoinDP, transform(Bair.layouts.dbo_Offenders_Base,
												self.eid 		:= trim('OFF' + (string)(unsigned8)hash64(trim(left.agency_offender_id, left, right) + ':' + left.data_provider_id), left, right);
												SELF.ts 		:= (unsigned6)regexreplace('-', ut.GetTimeDate(), '');
												_latitude 	:= LEFT.y_coordinate;
												_longitude 	:= LEFT.x_coordinate;
												SELF.gh12 	:= IF(Bair.Build_GeoHash.isValidCoord(_latitude, _longitude), SALT32.Fn_LatLongEncode(_latitude,_longitude,12), ''),
												SELF.etype 	:= 7;
												SELF 				:= LEFT;))
									,hash(eid));
									
		return base_offenders;
		
	ENDMACRO;
	
	EXPORT MAC_Offenders(pUseDelta = false) := FUNCTIONMACRO
		#uniquename(deltaFN)
		%deltaFN%			:= Bair.Filenames('',pUseProd,true).dbo_offenders_Base.built;
		#uniquename(linkflags)
		%linkflags% := 'left.eid = right.eid,left only, local';
		#uniquename(prev_deltas)
		%prev_deltas% := Bair.files('', pUseProd, true).offenders_Base.Built;
		#uniquename(int_deltas)
		%int_deltas%  := int_files_modname.off_d;
		#uniquename(full_base)
		%full_base%	:= DISTRIBUTE(Bair.files().offenders_Base.Built, hash(eid));
		#uniquename(res)
		#uniquename(nightly_w_prep)
		
#if(pUseDelta)		
		#uniquename(deltas)
		%deltas% := join(%prev_deltas%
										 ,Bair.AgencyDeletes.eids_to_delete(regexfind('^OFF', eid))
										 ,left.eid = right.eid
										 ,left only
										 ,lookup);
					 
		#uniquename(base_nightly_f)
		%base_nightly_f% 	:= MAC_JOININPUTS_OFFENDERS(false);
		
		#uniquename(base_prep_f)
		%base_prep_f% 		:= MAC_JOININPUTS_OFFENDERS(true);
									
		delta_superfile_subcnt 	:= nothor(STD.File.GetSuperFileSubCount(%deltaFN%));
		
		#uniquename(off_delta)
		Bair.MAC_Join(%off_delta%,%base_nightly_f%,%base_prep_f%,%linkflags%);
		
		#uniquename(nonSexOffenders)
		%nonSexOffenders% := %off_delta%(ut.CleanSpacesAndUpper(classification) <> 'SEX');
		
		#uniquename(jSO_w_delta)
		%jSO_w_delta% := join(%off_delta%(ut.CleanSpacesAndUpper(classification) = 'SEX')
			 ,%deltas%(ut.CleanSpacesAndUpper(classification) = 'SEX')
			 ,left.eid = right.eid and left.expiration_date = right.expiration_date and left.classification_date = right.classification_date
			 ,transform({%off_delta%}
					,self.dt_vendor_first_reported := if(left.eid = right.eid, right.dt_vendor_first_reported, left.dt_vendor_first_reported)
					,self.dt_vendor_last_reported := if(left.eid = right.eid and left.x_coordinate = right.x_coordinate and left.y_coordinate = right.y_coordinate, right.dt_vendor_last_reported, left.dt_vendor_last_reported)
					,self := left;)
			 ,keep(1)
			 ,left outer
			 ,local
			 );
														 
		#uniquename(sexOffenders)
		%sexOffenders% := join(%jSO_w_delta%													
											 ,%full_base%(ut.CleanSpacesAndUpper(classification) = 'SEX')
											 ,left.eid = right.eid and left.expiration_date = right.expiration_date and left.classification_date = right.classification_date
											 ,transform({%off_delta%}
													,self.dt_vendor_first_reported := if(left.eid = right.eid, right.dt_vendor_first_reported, left.dt_vendor_first_reported)
													,self.dt_vendor_last_reported := if(left.eid = right.eid and left.x_coordinate = right.x_coordinate and left.y_coordinate = right.y_coordinate, right.dt_vendor_last_reported, left.dt_vendor_last_reported)
													,self := left;)
											 ,keep(1)
											 ,left outer
											 ,local
											 );
					 
		%nightly_w_prep% := %sexOffenders% + %nonSexOffenders%;
		
		Bair.MAC_Join(%res%,%deltas%,%nightly_w_prep%,%linkflags%);
		
		base_r_ := if(delta_superfile_subcnt >= 1, %res%, %nightly_w_prep%);
		
#else
		#uniquename(new_base)
		%new_base%
				:= join(%full_base%,
								Bair.files().AgencyDeletes_base.Built(regexfind('^OFF', eid)),
								left.eid = right.eid,
								left only,
								lookup);
												
		Bair.MAC_Join(%res%,%new_base%,%int_deltas%,%linkflags%);	
		base_r_ := %res%;
#end
		base_r 	:= join(base_r_, DataPro, left.data_provider_id = right.data_provider_id
										,transform({base_r_}
											,self.data_provider_ori := if(left.data_provider_id = right.data_provider_id, right.data_provider_ori, left.data_provider_ori);
											,self.data_provider_name := if(left.data_provider_id = right.data_provider_id, right.data_provider_name, left.data_provider_name);
											self := left; 
											)
										,lookup
										,LEFT OUTER
										);
		return DISTRIBUTE(dedup(base_r, record, all), hash(eid));
		
	ENDMACRO;
	
	EXPORT OFFENDERS_base := FUNCTION
		base_f := if(pUseDelta, MAC_Offenders(true), MAC_Offenders(false));
		return base_f;
	END;
	
	EXPORT MAC_JOININPUTS_CRASH(pPrepped = false) := FUNCTIONMACRO
	
		stdcrash		 		:= Bair.Standardize_Input(version, pUseProd, pPrepped).crash;
		stdperson				:= Bair.Standardize_Input(version, pUseProd, pPrepped).crash_person;
		stdvehicle			:= Bair.Standardize_Input(version, pUseProd, pPrepped).crash_vehicle;
		stdDataProvider := Bair.Standardize_Input(version, pUseProd).Event_data_provider;
		
		DataProvider 		:= if(count(stdDataProvider) <> 0, stdDataProvider, Bair.files().dataprovider_base.built);
		
		crash_view	
				:= join(distribute(stdcrash, hash(ori))
											,distribute(DataProvider, hash(data_provider_id))
											,left.ori = right.data_provider_id
											,left outer
											,local);
		
		crashRec := RECORD
			crash_view;
			Bair.layouts.crash_dbo_person_Base - [ori, case_number];
			Bair.layouts.crash_dbo_vehicle_Base - [ori, case_number];
			string1  sourceP := '';
			string1  sourceV := '';
		END;
		
		crash_view_with_person
				:= join(distribute(crash_view, hash(case_number, ori))
								 ,distribute(stdperson, hash(case_number, ori))
								 ,left.case_number = right.case_number and left.ori = right.ori
							   ,transform(crashRec
													,self.sourceP	:= if(left.case_number = right.case_number, 'P', '')
													,self.data_provider_id := left.ori
													,self:=left
													,self:=right
													,self:=[])
								 ,left outer
								 ,local);
		
		crash_view_with_vehicle
				:= join(distribute(crash_view, hash(case_number, ori))
								 ,distribute(stdvehicle, hash(case_number, ori))
								 ,left.case_number = right.case_number and left.ori = right.ori
								 ,transform(crashRec
													,self.sourceV	:= if(left.case_number = right.case_number, 'V', '')
													,self.vehicleId	:= if(left.case_number = right.case_number, right.veh_id, 0)
													,self.data_provider_id := left.ori
													,self:=left
													,self:=right
													,self:=[];)
								 ,left outer
								 ,local);
		
		base_crash_d
				:= crash_view_with_person + crash_view_with_vehicle;
								
		base_crash
				:= distribute(project(base_crash_d, transform(Bair.layouts.dbo_crash_Base,
											SELF.eid 				:= trim('CRA' + (string)(unsigned8)hash64(trim(left.case_number, left, right) + ':' + left.data_provider_id), left, right),
											SELF.ts 				:= (unsigned6)regexreplace('-', ut.GetTimeDate(), '');
											_latitude 			:= LEFT.y;
											_longitude 			:= LEFT.x;
											SELF.gh12 			:= IF(Bair.Build_GeoHash.isValidCoord(_latitude, _longitude), SALT32.Fn_LatLongEncode(_latitude,_longitude,12), '');
											SELF.etype 			:= 3;
											SELF 						:= LEFT;))
									,hash(eid));
									
		return base_crash;
		
	ENDMACRO;
	
	EXPORT MAC_Crash(pUseDelta = false) := FUNCTIONMACRO
		
		#uniquename(deltaFN)
		%deltaFN%			:= Bair.Filenames('',pUseProd,true).dbo_crash_Base.built;
		#uniquename(linkflags)
		%linkflags% := 'left.eid = right.eid,left only, local';
		#uniquename(prev_deltas)
		%prev_deltas% := Bair.files('', pUseProd, true).crash_Base.Built;
		#uniquename(int_deltas)
		%int_deltas%  := int_files_modname.cra_d;
		#uniquename(res)
		#uniquename(nightly_w_prep)
		
#if(pUseDelta)

		#uniquename(deltas)
		%deltas% := join(%prev_deltas%
										 ,Bair.AgencyDeletes.eids_to_delete(regexfind('^CRA', eid))
										 ,left.eid = right.eid
										 ,left only
										 ,lookup);
		
		#uniquename(base_nightly_f)
		%base_nightly_f% := MAC_JOININPUTS_CRASH(false);
		
		#uniquename(base_prep_f)
		%base_prep_f% 	 := MAC_JOININPUTS_CRASH(true);
									
		delta_superfile_subcnt 	:= nothor(STD.File.GetSuperFileSubCount(%deltaFN%));
		
		Bair.MAC_Join(%nightly_w_prep%,%base_nightly_f%,%base_prep_f%,%linkflags%);
		Bair.MAC_Join(%res%,%deltas%,%nightly_w_prep%,%linkflags%);
		
		base_r_ := if(delta_superfile_subcnt >= 1, %res%, %nightly_w_prep%);

#else		
		#uniquename(full_base)
		%full_base%	:= DISTRIBUTE(Bair.files().crash_Base.Built, hash(eid));
		
		#uniquename(new_base)
		%new_base%
				:= join(%full_base%,
								Bair.files().AgencyDeletes_base.Built(regexfind('^CRA', eid)),
								left.eid = right.eid,
								left only,
								lookup,
								local);
												
		Bair.MAC_Join(%res%,%new_base%,%int_deltas%,%linkflags%);		
		base_r_ := %res%;
#end
		base_r 	:= join(base_r_, DataPro, left.data_provider_id = right.data_provider_id
										,transform({base_r_}
											,self.data_provider_ori := if(left.data_provider_id = right.data_provider_id, right.data_provider_ori, left.data_provider_ori);
											,self.data_provider_name := if(left.data_provider_id = right.data_provider_id, right.data_provider_name, left.data_provider_name);
											self := left; 
											)
										,lookup
										,LEFT OUTER
										);
		return DISTRIBUTE(dedup(base_r, record, all), hash(eid));
		
	ENDMACRO;
	
	EXPORT CRASH_base := FUNCTION
		base_f := if(pUseDelta, MAC_Crash(true), MAC_Crash(false));
		return base_f;
	END;
	
	EXPORT MAC_JOININPUTS_LPR(pPrepped = false) := FUNCTIONMACRO
	
		stdlpr 					:= Bair.Standardize_Input(version, pUseProd, pPrepped).lpr_licenseplateevent;
		stdDataProvider := Bair.Standardize_Input(version, pUseProd).Event_data_provider;
		
		DataProvider 		:= if(count(stdDataProvider) <> 0, stdDataProvider, Bair.files().dataprovider_base.built);
		
		LPRjoinDP
				:= join( stdlpr
								,DataProvider
								,left.ORI = right.data_provider_id
								,lookup
								,LEFT OUTER);
								
		base_lpr
				:= distribute(project(LPRjoinDP
										,transform(Bair.layouts.lpr_dbo_LicensePlateEvent_Base
												,self.eid 	:= trim('LPR' + (string)(unsigned8)hash64(trim(left.EventNumber, left, right) + ':' + left.data_provider_id), left, right);
												SELF.ts 		:= (unsigned6)regexreplace('-', ut.GetTimeDate(), '');
												_latitude   := LEFT.y_coordinate;
												_longitude  := LEFT.x_coordinate;
												SELF.gh12  	:= IF(Bair.Build_GeoHash.isValidCoord(_latitude, _longitude), SALT32.Fn_LatLongEncode(_latitude,_longitude,12), '');
												self.etype 	:= 4;
												self.base64 := if(pPrepped, left.base64, false);
												self := left;))
					,hash(eid));
									
		return base_lpr;
		
	ENDMACRO;
	
	EXPORT MAC_Lpr(pUseDelta = false) := FUNCTIONMACRO		
		#uniquename(deltaFN)
		%deltaFN%			:= Bair.Filenames('',pUseProd,true).lpr_dbo_licenseplateevent_Base.built;
		#uniquename(linkflags)
		%linkflags% := 'left.eid = right.eid,left only, local';
		#uniquename(prev_deltas)
		%prev_deltas% := Bair.files('', pUseProd, true).lpr_Base.Built;
		#uniquename(int_deltas)
		%int_deltas%  := int_files_modname.lpr_d;
		#uniquename(res)
		#uniquename(nightly_w_prep)
		
#if(pUseDelta)
		
		#uniquename(deltas)
		%deltas% := join(%prev_deltas%
										 ,Bair.AgencyDeletes.eids_to_delete(regexfind('^LPR', eid))
										 ,left.eid = right.eid
										 ,left only
										 ,lookup);
					 
		#uniquename(base_nightly_f)
		%base_nightly_f% := MAC_JOININPUTS_LPR(FALSE);
		
		#uniquename(base_prep_f)
		%base_prep_f% 	 := MAC_JOININPUTS_LPR(TRUE);
								
		delta_superfile_subcnt := NOTHOR(STD.File.GetSuperFileSubCount(%deltaFN%));
		
		Bair.MAC_Join(%nightly_w_prep%,%base_nightly_f%,%base_prep_f%,%linkflags%);
		Bair.MAC_Join(%res%,%deltas%,%nightly_w_prep%,%linkflags%);
		
		base_r_ := if(delta_superfile_subcnt >= 1, %res%, %nightly_w_prep%);

#else		
		#uniquename(full_base)
		%full_base%	:= DISTRIBUTE(Bair.files().lpr_Base.Built, hash(eid));
		
		#uniquename(new_base)
		%new_base%
				:= join(%full_base%,
								Bair.files().AgencyDeletes_base.Built(regexfind('^LPR', eid)),
								left.eid = right.eid,
								left only,
								lookup,
								local);
												
		Bair.MAC_Join(%res%,%new_base%,%int_deltas%,%linkflags%);		
		base_r_	:= %res%;
#end
		base_r 	:= join(base_r_, DataPro, left.data_provider_id = right.data_provider_id
										,transform({base_r_}
											,self.data_provider_ori := if(left.data_provider_id = right.data_provider_id, right.data_provider_ori, left.data_provider_ori);
											,self.data_provider_name := if(left.data_provider_id = right.data_provider_id, right.data_provider_name, left.data_provider_name);
											self := left; 
											)
										,lookup
										,LEFT OUTER
										);
		return DISTRIBUTE(dedup(base_r, record, all), hash(eid));
	ENDMACRO;
	
	EXPORT LPR_base := FUNCTION
		base_f  := if(pUseDelta, MAC_Lpr(true), MAC_Lpr(false));
		return base_f;
	END;
	
	EXPORT MAC_Shotspotter(pUseDelta = false) := FUNCTIONMACRO
	
		#uniquename(deltaFN)
		%deltaFN%			:= Bair.Filenames('',pUseProd,true).gunop_dbo_shot_incident_Base.built;
		#uniquename(linkflags)
		%linkflags% := 'left.eid = right.eid,left only, local';
		#uniquename(prev_deltas)
		%prev_deltas% := Bair.files('', pUseProd, true).shotspotter_Base.Built;
		#uniquename(int_deltas)
		%int_deltas%  := int_files_modname.shot_d;
		#uniquename(res)
#if(pUseDelta)
		stdShotIncident := Bair.Standardize_Input(version, pUseProd).gunop_shot_incident;
		stdDataProvider := Bair.Standardize_Input(version, pUseProd).Event_data_provider;
		
		DataProvider 		:= if(count(stdDataProvider) <> 0, stdDataProvider, Bair.files().dataprovider_base.built);
		
		new_base_d
				:= join( stdShotIncident
								,DataProvider
								,left.data_provider_id = right.data_provider_id
								,lookup
								,LEFT OUTER);
											
		#uniquename(base_f)
		%base_f%
				:= distribute(project(new_base_d,
							transform(Bair.layouts.gunop_dbo_shot_incident_Base
									,self.eid   := trim('SHO' + (string)(unsigned8)hash64(trim((string)left.shot_id, left, right)), left, right);
									 SELF.ts 		:= (unsigned6)regexreplace('-', ut.GetTimeDate(), '');
									_latitude 	:= LEFT.y_coordinate;
									_longitude 	:= LEFT.x_coordinate;	
									SELF.gh12 	:= IF(Bair.Build_GeoHash.isValidCoord(_latitude, _longitude), SALT32.Fn_LatLongEncode(_latitude,_longitude,12), '');
									self.etype 	:= 6
									,self 			:= left;)),
								hash(eid));
					
		delta_superfile_subcnt := NOTHOR(STD.File.GetSuperFileSubCount(%deltaFN%));
		Bair.MAC_Join(%res%,%prev_deltas%,%base_f%,%linkflags%);
		base_r_ := if(delta_superfile_subcnt >= 1, %res%, %base_f%);
#else
		#uniquename(full_base)
		%full_base%	:= DISTRIBUTE(Bair.files().shotspotter_Base.Built, hash(eid));
		
		#uniquename(new_base)
		%new_base% 	:= %full_base%;
		
		Bair.MAC_Join(%res%,%new_base%,%int_deltas%,%linkflags%);		
		base_r_ 			:= dedup(sort(%res%, -raids_record_id), record, except raids_record_id, all);
#end
		base_r 	:= join(base_r_, DataPro, left.data_provider_id = right.data_provider_id
										,transform({base_r_}
											,self.data_provider_ori := if(left.data_provider_id = right.data_provider_id, right.data_provider_ori, left.data_provider_ori);
											,self.data_provider_name := if(left.data_provider_id = right.data_provider_id, right.data_provider_name, left.data_provider_name);
											self := left; 
											)
										,lookup
										,LEFT OUTER
										);
		return DISTRIBUTE(dedup(base_r_, record, all), hash(eid));
	ENDMACRO;
	
	EXPORT SHOTSPOTTER_base := FUNCTION
		base_f := if(pUseDelta, MAC_Shotspotter(true), MAC_Shotspotter(false));
		return base_f;
	END;
	
	EXPORT MAC_DataProvider(pUseDelta = false) := FUNCTIONMACRO
#if(pUseDelta)
		stdDataProvider := Bair.Standardize_Input(version, pUseProd).Event_data_provider;
		base_r := if(count(stdDataProvider) <> 0
								,stdDataProvider
								,Bair.files().dataprovider_base.built);
#else
		base_r := Bair.files().dataprovider_base.built;
#end		
		return dedup(base_r, record, all);
	ENDMACRO;
	
	EXPORT DataProvider_base := FUNCTION
		base_f := if(pUseDelta, MAC_DataProvider(true), MAC_DataProvider(false));
		return base_f;
	END;

	EXPORT MAC_Notes(pUseDelta = false) := FUNCTIONMACRO
		
		NotesRec := RECORD
			UNSIGNED1 numRows;
			Bair.layouts.Notes_Base;
		END;

		mxLength:=150000;

		Notes_Base_P
				:= 	project(Bair.files('', pUseProd, pUseDelta).MO_base.built(Synopsis_of_Crime <> ''), transform(NotesRec,
													self.numRows		:= length(left.Synopsis_of_Crime)/mxLength + 1;
													self.eid 				:= left.eid;
													self.ReferId 		:= left.mostamp;
													self.Note_Type 	:= 1;
													self.NoteLen		:= 0;
													self.Notes 			:= trim(left.Synopsis_of_Crime)))
											+ 
						project(Bair.files('', pUseProd, pUseDelta).PERSONS_base.built(persons_notes <> ''), transform(NotesRec,
													self.numRows		:= length(left.persons_notes)/mxLength + 1;
													self.eid 				:= left.eid;
													self.ReferId 		:= left.personstamp;
													self.Note_Type 	:= 2;
													self.NoteLen		:= 0;
													self.Notes 			:= trim(left.persons_notes)))
											+
						project(Bair.files('', pUseProd, pUseDelta).VEHICLE_base.built(description <> ''), transform(NotesRec,
													self.numRows		:= length(left.description)/mxLength + 1;
													self.eid 				:= left.eid;
													self.ReferId 		:= left.vehiclestamp;
													self.Note_Type 	:= 3;
													self.NoteLen		:= 0;
													self.Notes 			:= trim(left.description)))
											+
						project(Bair.files('', pUseProd, pUseDelta).CFS_base.built(dispatcher_comments <> ''), transform(NotesRec,
													self.numRows		:= length(left.dispatcher_comments)/mxLength + 1;
													self.eid 				:= left.eid;
													self.ReferId 		:= 0;
													self.Note_Type 	:= 4;
													self.NoteLen		:= 0;
													self.Notes 			:= trim(left.dispatcher_comments)))
											+
						project(Bair.files('', pUseProd, pUseDelta).CFS_base.built(synopsis <> ''), transform(NotesRec,
													self.numRows		:= length(left.synopsis)/mxLength + 1;
													self.eid 				:= left.eid;
													self.ReferId 		:= left.cfs_officers_id;
													self.Note_Type 	:= 5;
													self.NoteLen		:= 0;
													self.Notes 			:= trim(left.synopsis)))
											+
						project(Bair.files('', pUseProd, pUseDelta).CRASH_base.built(narrative <> ''), transform(NotesRec,
													self.numRows		:= length(left.narrative)/mxLength + 1;
													self.eid 				:= left.eid;
													self.ReferId 		:= 0;
													self.Note_Type 	:= 6;
													self.NoteLen		:= 0;
													self.Notes 			:= trim(left.narrative)))
											+
						project(Bair.Files('', pUseProd, pUseDelta).Shotspotter_Base.built(shot_incident_notes <> ''), transform(NotesRec,
													self.numRows		:= length(left.shot_incident_notes)/mxLength + 1;																	
													self.eid   			:= left.eid;
													self.ReferId 		:= 0;
													self.Note_Type 	:= 7;
													self.NoteLen		:= 0;
													self.Notes 			:= trim(left.shot_incident_notes)))
											+
						project(Bair.files('', pUseProd, pUseDelta).OFFENDERS_base.built(offender_notes <> ''), transform(NotesRec,
													self.numRows		:= length(left.offender_notes)/mxLength + 1;
													self.eid 				:= left.eid;
													self.ReferId 		:= 0;
													self.Note_Type 	:= 8;
													self.NoteLen		:= 0;
													self.Notes 			:= trim(left.offender_notes)))
											+
						project(Bair.Files('', pUseProd, pUseDelta).Intel_Base.built(incident_notes <> ''), transform(NotesRec,
													self.numRows		:= length(left.incident_notes)/mxLength + 1;
													self.eid 				:= left.eid;
													self.Note_Type 	:= 9;
													self.ReferId 		:= 0;
													self.NoteLen		:= 0;
													self.Notes 			:= trim(left.incident_notes)))
											+
						project(Bair.Files('', pUseProd, pUseDelta).Intel_Base.built(entity_notes <> ''), transform(NotesRec,
													self.numRows		:= length(left.entity_notes)/mxLength + 1;
													self.eid 				:= left.eid;
													self.ReferId 		:= 0;
													self.Note_Type 	:= 10;
													self.NoteLen		:= 0;
													self.Notes 			:= trim(left.entity_notes)))
											+
						project(Bair.Files('', pUseProd, pUseDelta).Intel_Base.built(vehicle_notes <> ''), transform(NotesRec,
													self.numRows		:= length(left.vehicle_notes)/mxLength + 1;
													self.eid 				:= left.eid;
													self.ReferId 		:= 0;
													self.Note_Type 	:= 11;
													self.NoteLen		:= 0;
													self.Notes 			:= trim(left.vehicle_notes)))
													;

		Bair.layouts.Notes_Base NormIt(NotesRec L, INTEGER C) := TRANSFORM
			SELF.NoteLen := CHOOSE(C
														,length(trim(L.Notes[..mxLength]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.Notes[mxLength*(C-1)+1..]))
														 );
			SELF.seq := C;
			SELF.Notes := CHOOSE(C
														,trim(L.Notes[..mxLength])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..mxLength*C])
														,trim(L.Notes[mxLength*(C-1)+1..])
														 );
			SELF := L;
		END;

		base_f0 := NORMALIZE(Notes_Base_P(LENGTH(eid)	> 3 and notes <> ''), LEFT.numRows, NormIt(LEFT,COUNTER));
		base_r  := dedup(distribute(base_f0, hash(Eid)), all, local);
		return base_r;
		
	ENDMACRO;
	
	EXPORT Notes_base := FUNCTION
		base_f  := if(pUseDelta, MAC_Notes(true), MAC_Notes(false));
		return base_f;
	END;
	
	EXPORT MAC_Images(pUseDelta = false) := FUNCTIONMACRO
		import Std,lib_stringlib;
		
		DATA FromHexPairs(STRING hex_pairs) := lib_stringlib.StringLib.String2Data(hex_pairs);
	
		Images_Base_P
				:= 	project(Bair.files('', pUseProd, pUseDelta).LPR_base.built(PlateImage <> ''), transform(Bair.layouts.Images_Base,
									base64img 			:= if(left.base64, left.PlateImage, Std.Str.EncodeBase64(FromHexPairs(left.PlateImage)));
									self.eid 				:= left.eid;
									self.Image_Type := 1;
									self.ImageLen 	:= length(base64img);
									self.Photo 			:= trim(base64img)))
							+
						project(Bair.files('', pUseProd, pUseDelta).LPR_base.built(OverviewImage <> ''), transform(Bair.layouts.Images_Base,
									base64img 			:= if(left.base64, left.OverviewImage, Std.Str.EncodeBase64(FromHexPairs(left.OverviewImage)));
									self.eid 				:= left.eid;
									self.Image_Type := 2;
									self.ImageLen 	:= length(base64img);
									self.Photo 			:= trim(base64img)))
							+																
						project(Bair.files('', pUseProd, pUseDelta).OFFENDERS_PICTURE_Base.built(picture_image <> ''), transform(Bair.layouts.Images_Base,
									base64img 			:= if(left.base64, left.picture_image, Std.Str.EncodeBase64(FromHexPairs(left.picture_image)));
									self.eid 				:= left.eid;
									self.Image_Type := 3;
									self.ImageLen 	:= length(base64img);
									self.Photo 			:= trim(base64img)))
							+
						project(Bair.files('', pUseProd, pUseDelta).PERSONS_base.built(picture <> ''), transform(Bair.layouts.Images_Base,
									base64img 			:= if(left.base64, left.picture, Std.Str.EncodeBase64(FromHexPairs(left.picture)));
									self.eid 				:= left.eid;
									self.Image_Type := 4;
									self.ImageLen 	:= length(base64img);
									self.Photo 			:= trim(base64img)))
							+
						project(Bair.files('', pUseProd, pUseDelta).Intel_Base.built(photo <> ''), transform(Bair.layouts.Images_Base,
									base64img 			:= Std.Str.EncodeBase64(FromHexPairs(left.photo));
									self.eid 				:= left.eid;
									self.Image_Type := 5;
									self.ImageLen 	:= length(base64img);
									self.Photo 			:= trim(base64img)));
								
		base_f0	:= Images_Base_P(LENGTH(eid)	> 3 and Photo <> '');
		base_r  := dedup(distribute(base_f0, hash(Eid)), all, local);
		
		return base_r;				
	ENDMACRO;
	
	EXPORT Images_base := FUNCTION
		base_f  := if(pUseDelta, MAC_Images(true), MAC_Images(false));
		return base_f;
	END;
	
	EXPORT MAC_JOININPUTS_OFF_PIC(pPrepped = false) := FUNCTIONMACRO
	
		stdOffPicture	:= Bair.Standardize_Input(version, pUseProd, pPrepped).offenders_picture;		
		base_off_pic
				:= project(stdOffPicture
								,transform(Bair.layouts.dbo_offenders_Picture_Base
										,self.eid := trim('OFF' + (string)(unsigned8)hash64(trim(left.agency_offender_id, left, right) + ':' + left.ori), left, right)
										,SELF.ts 		:= (unsigned6)regexreplace('-', ut.GetTimeDate(), '')
										,self.base64 := if(pPrepped, true, false)
										,self := left;										
										));
								
		return DISTRIBUTE(base_off_pic, hash(eid));
		
	ENDMACRO;
	
	EXPORT MAC_Offenders_Picture(pUseDelta = false) := FUNCTIONMACRO
	
		#uniquename(deltaFN)
		%deltaFN%			:= Bair.Filenames('',pUseProd,true).dbo_offenders_Picture_Base.built;
		#uniquename(linkflags)
		%linkflags% := 'left.eid = right.eid,left only, local';
		#uniquename(prev_deltas)
		%prev_deltas% := Bair.files('', pUseProd, true).offenders_picture_Base.Built;
		#uniquename(int_deltas)
		%int_deltas%  := int_files_modname.off_pic_d;
		#uniquename(res)
		#uniquename(nightly_w_prep)
		
#if(pUseDelta)
		
		#uniquename(deltas)
		%deltas%
				:= join(%prev_deltas%
							 ,Bair.AgencyDeletes.eids_to_delete(regexfind('^OFF', eid))
							 ,left.eid = right.eid
							 ,left only
							 ,lookup);
					 
		#uniquename(base_nightly_f)
		%base_nightly_f% 	:= MAC_JOININPUTS_OFF_PIC(FALSE);
		
		#uniquename(base_prep_f)
		%base_prep_f% 		:= MAC_JOININPUTS_OFF_PIC(TRUE);
											
		delta_superfile_subcnt 	:= nothor(STD.File.GetSuperFileSubCount(%deltaFN%));
		
		Bair.MAC_Join(%nightly_w_prep%,%base_nightly_f%,%base_prep_f%,%linkflags%);
		Bair.MAC_Join(%res%,%deltas%,%nightly_w_prep%,%linkflags%);
		
		base_r := if(delta_superfile_subcnt >= 1, %res%, %nightly_w_prep%);
		
#else	//Full Update on 7th day	
		#uniquename(full_base)
		%full_base%	:= DISTRIBUTE(Bair.files().offenders_picture_Base.Built, hash(eid));
		
		#uniquename(new_base)
		%new_base%
				:= join(%full_base%,
								Bair.files().AgencyDeletes_base.Built(regexfind('^OFF', eid)),
								left.eid = right.eid,
								left only,
								lookup,
								local);
		Bair.MAC_Join(%res%,%new_base%,%int_deltas%,%linkflags%);		
		base_r 			:= %res%;
#end
		return DISTRIBUTE(dedup(base_r, record, all), hash(eid));

	ENDMACRO;
	
	EXPORT Offenders_Picture_base := FUNCTION
		base_f := if(pUseDelta, MAC_Offenders_Picture(true), MAC_Offenders_Picture(false));
		return base_f;
	END;
	
	EXPORT MAC_Classification(pUseDelta = false) := FUNCTIONMACRO
		cfsagency := dedup(table(Bair.files().AgencyCfsLookup_Base.built, {DataproviderId, agencytype, type, updateDate}), DataproviderId, agencytype, all);
		crimetype := dedup(table(Bair.files().AgencyCrimeLookup_Base.built, {DataproviderId, crime, type, updateDate}), DataproviderId, crime, all);
		
		cfs_agency_lookup 		:= join(cfsagency, Bair.files().event_helper_ucr_group_classifications_input(mode = 2), left.type = right.name, lookup);
		events_agency_lookup 	:= join(crimetype, Bair.files().event_helper_ucr_group_classifications_input(mode = 1), left.type = right.name, lookup);
		DataProvider					:= Bair.files().DataProvider_Base.built;
		
#if(pUseDelta)		
		base_r
				:= join(events_agency_lookup
									,DataProvider
									,left.DataproviderId = right.data_provider_id
									,transform(Bair.layouts.ClassificationLayout
											,self.mode 				:= 1
											,self.ucr_group 	:= left.ucr_group_id
											,self.ori 				:= right.data_provider_ori
											,self.agencytype 	:= ''
											,self.crime 			:= left.crime
											,self.last_update := left.updateDate
											)
									,lookup
									,left outer)
								+
					 join(cfs_agency_lookup
									,DataProvider
									,left.DataproviderId = right.data_provider_id
									,transform(Bair.layouts.ClassificationLayout
											,self.mode 				:= 2
											,self.ucr_group 	:= left.ucr_group_id
											,self.ori 				:= right.data_provider_ori
											,self.agencytype 	:= left.agencytype
											,self.crime 			:= ''
											,self.last_update := left.updateDate
											)
									,lookup
									,left outer);		
#else
		base_r := Bair.files().Classification_base.built;
#end
		return dedup(base_r, record, all);

	ENDMACRO;
	
	EXPORT Classification_base := FUNCTION
		base_f := if(pUseDelta, MAC_Classification(true), MAC_Classification(false));
		return base_f;
	END;

END;