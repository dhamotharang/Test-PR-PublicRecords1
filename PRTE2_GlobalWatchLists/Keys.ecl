
IMPORT  doxie,mdr;

EXPORT keys := MODULE

//Patriots
EXPORT key_patriot_file_full := INDEX(
	FILES.GWL_Patriot, 
	{pty_key,source,orig_pty_name,orig_vessel_name,country,name_type,cname,title,fname,mname,lname,suffix,a_score,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip}, 
	{Files.GWL_Patriot}, 
	constants.KeyName_Patriot_File + doxie.Version_SuperKey );

//PRCT-386	 
EXPORT key_baddids := INDEX(
	FILES.GWL_Baddids, 
	{did,other_count,first_seen,rel_count, dummy}, 
	{Files.GWL_Baddids}, 
	constants.KeyName_Baddids + doxie.Version_SuperKey );
		
EXPORT key_patriot_bdid_file := INDEX(
	FILES.GWL_patriot_bdid, 
	{bdid}, 
	{Files.GWL_patriot_bdid}, 
	constants.KeyName_bdid_File + doxie.Version_SuperKey );
	
EXPORT key_patriot_did_file := INDEX(
	FILES.GWL_dids, 
	 {did}, 
	 {Files.GWL_dids},
	 constants.KeyName_did_File + doxie.Version_SuperKey );
	 
EXPORT key_annotated_names := INDEX(
	FILES.GWL_Annotated_Names, 
	 {fname,mname,lname, cnt}, 
	 {Files.GWL_Annotated_Names}, 
	 constants.KeyName_Annotated + doxie.Version_SuperKey );
	 
 EXPORT key_patriotbaddies_with_name := INDEX(
	FILES.GWL_Baddies, 
	 {did}, 
	 {FILES.GWL_Baddies}, 
	constants.KeyName_Baddies + doxie.Version_SuperKey );

//GlobalWatchListKeys using "filedate2" 		
 EXPORT key_globalwatchlistsseq := INDEX(FILES.GWL_Seq, {seq},
        {Files.GWL_Seq}, 
	      constants.KeyName_gwl + 'seq_' + doxie.Version_SuperKey);
			
 EXPORT key_globalwatchlistsglobalwatchlists_key := INDEX(files.GWL_vessels_fixed, {pty_key},
        {files.GWL_vessels_fixed}, 
        constants.KeyName_gwl + 'globalwatchlists_key_' + doxie.Version_SuperKey);
	
 EXPORT key_globalwatchlistscountries := INDEX(FILES.GWL_country, {country}, 
        {country,pty_key}, 
        constants.KeyName_gwl + 'countries_' + doxie.Version_SuperKey);
	 
 EXPORT key_globalwatchlists_entities := INDEX(FILES.GWL_entities,{entityid}, 
        {FILES.GWL_entities},
        constants.KeyName_gwl +  doxie.Version_SuperKey + '::entities');
	
 EXPORT key_globalwatchlists_addlinfo := INDEX(FILES.GWL_Addlinfo,{entityid}, 
        {FILES.GWL_Addlinfo}, 
        constants.KeyName_gwl + doxie.Version_SuperKey + '::addlinfo');
	
 EXPORT key_globalwatchlists_address := INDEX(FILES.GWL_Address,{entityid,recordid}, 
        {FILES.GWL_Address}, 
        constants.KeyNAme_gwl + doxie.Version_SuperKey + '::address');
	
	 EXPORT key_globalwatchlists_countries2 := INDEX(FILES.GWL_Countries2,{countryid}, 
	        {FILES.GWL_Countries2}, 
   constants.KeyName_gwl + doxie.Version_SuperKey + '::countries');
	 
	 EXPORT key_globalwatchlists_country_aka := INDEX(FILES.GWL_countryName,{countryid,recordid}, 
	        {FILES.GWL_countryName}, 
	        constants.KeyName_gwl + doxie.Version_SuperKey + '::country_aka');
	
	 EXPORT key_globalwatchlists_country_index := INDEX(FILES.GWL_countryindex,{key,listid}, 
	        {FILES.GWL_countryindex}, 
	        constants.KeyName_gwl + doxie.Version_SuperKey + '::country_index');
	
	 EXPORT key_globalwatchlists_id_numbers := INDEX(FILES.GWL_IDNumbers,{entityid}, 
	        {FILES.GWL_IDNumbers}, 
	        constants.KeyName_gwl + doxie.Version_SuperKey + '::id_numbers');
	
	 EXPORT key_globalwatchlists_name_index := INDEX(FILES.GWL_NameIndex,{key,listid}, 
	        {FILES.GWL_NameIndex}, 
	        constants.KeyName_gwl + doxie.Version_SuperKey + '::name_index');
	
	 EXPORT key_globalwatchlists_names := INDEX(FILES.GWL_Names,{entityid,recordid}, 
	        {FILES.GWL_Names}, 
	        constants.KeyName_gwl + doxie.Version_SuperKey + '::names');
	
//Cloud Keys	
	EXPORT key_patriot_file_delta 	:= INDEX(FILES.Patriot_delta_rid,{record_sid}, {FILES.Patriot_delta_rid},
																				constants.Keyname_Patriot_file_delta + doxie.Version_SuperKey );
	
	EXPORT key_patriot_baddids_delta := INDEX(FILES.Patriot_delta_rid,{record_sid}, {FILES.Patriot_delta_rid},
																				constants.Keyname_Patriot_baddids_delta + doxie.Version_SuperKey );	
	
	EXPORT key_patriot_annotated_names_delta := INDEX(FILES.Patriot_delta_rid,{record_sid}, {FILES.Patriot_delta_rid},
																										constants.Keyname_Patriot_annotated_names_delta + doxie.Version_SuperKey );																				
	
END;