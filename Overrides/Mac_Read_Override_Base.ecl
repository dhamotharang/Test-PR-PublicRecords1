Export MAC_Read_Override_Base(datasetname,retval,flag_file_id_field = '\'\'',LexidField='\'\'',RecID1_field='\'\'',RecID2_field='\'\'',RecID3_field='\'\'',RecID4_field='\'\'',useInLayout='true') := macro
Import STD,Overrides,lib_stringlib,faa,FCRA,marriage_divorce_v2,ln_propertyv2,doxie,UCCV2,watercraft,bankruptcyv2,sexoffender,corrections;

#uniquename(basefile_name)
#uniquename(ds)
%basefile_name% := overrides.getfilename(datasetname,'fcra',,false).basefile;
//%basefile_name% := '~thor_data400::base::override::fcra::20191118::proflic_mari_patch';

%ds%:=dataset(stringlib.StringFindReplace(%basefile_name%,'@version@','qa')
							, #IF(STD.Str.ToUpperCase(datasetname) = 'MARRIAGE_MAIN')
							{recordof(marriage_divorce_v2.layout_mar_div_base_slim), string20 flag_file_id},
								#ELSEIF(STD.Str.ToUpperCase(datasetname) = 'AIRCRAFT_DETAILS')
							{recordof(faa.layout_aircraft_info), string20 flag_file_id},
								#ELSEIF(STD.Str.ToUpperCase(datasetname) = 'AIRCRAFT_ENGINE')
							{recordof(faa.layout_engine_info), string20 flag_file_id},
							#ELSEIF(STD.Str.ToUpperCase(datasetname) = 'PILOT_CERTIFICATE')
							{recordof(faa.layout_airmen_certificate_out), string20 flag_file_id},
							#ELSEIF(STD.Str.ToUpperCase(datasetname) = 'UCC_MAIN')
							{string20 flag_file_id,recordof(UCCV2.key_rmsid_main(true))},
								#ELSEIF(STD.Str.ToUpperCase(datasetname) = 'WATERCRAFT_CGUARD')
							{string20 flag_file_id,recordof(watercraft.key_watercraft_cid(true))},
								#ELSEIF(STD.Str.ToUpperCase(datasetname) = 'WATERCRAFT_DETAILS')
							{string20 flag_file_id,recordof(watercraft.key_watercraft_wid(true))},
								#ELSEIF(STD.Str.ToUpperCase(datasetname) = 'ASSESSMENT')
							{string20 flag_file_id,ln_propertyv2.layout_property_common_model_base},
								#ELSEIF(STD.Str.ToUpperCase(datasetname) = 'DEED')
							{string20 flag_file_id,ln_propertyv2.layout_deed_mortgage_common_model_base},	
								#ELSEIF(STD.Str.ToUpperCase(datasetname) = 'OFFENSES')
							{string20 flag_file_id,corrections.layout_Offense - offense_category},
								#ELSEIF(STD.Str.ToUpperCase(datasetname) = 'COURT_OFFENSES')
							{string20 flag_file_id,corrections.layout_CourtOffenses - offense_category},
								#ELSEIF(STD.Str.ToUpperCase(datasetname) = 'PUNISHMENT')
              {string20 flag_file_id,corrections.Layout_CrimPunishment},
							#ELSEIF(STD.Str.ToUpperCase(datasetname) = 'SO_OFFENSES')
              {string20 flag_file_id,recordof(SexOffender.Key_SexOffender_offenses(true))},
							#ELSEIF(STD.Str.ToUpperCase(datasetname) = 'AIRCRAFT')
							 {faa.layout_aircraft_registration_out_Persistent_ID,string20 flag_file_id},
					    #ELSEIF(STD.Str.ToUpperCase(datasetname) = 'BANKRUPT_MAIN')
						   {bankruptcyv2.layout_bankruptcy_main_v3.layout_bankruptcy_main_filing,string20 flag_file_id},
							 #ELSEIF(STD.Str.ToUpperCase(datasetname) = 'BANKRUPT_SEARCH')
						   {bankruptcyv2.layout_bankruptcy_search_v3,string20 flag_file_id},
							  #ELSE
								#expand(case(STD.Str.ToUpperCase(datasetname)
										,'AIRCRAFT' => 'FCRA.key_override_faa.aircraft_rec'
										,'BKSEARCH' => 'FCRA.layout_search_ffid_v3'
										,'BANKRUPT_SEARCH' => 'FCRA.Layout_Override_bk_search'
										,'ATF' => 'FCRA.key_override_atf.atf_rec'
										,'HUNTING_FISHING' => 'FCRA.key_override_hunting_fishing.hunt_rec'
										,'AMERICAN_STUDENT' => 'fcra.Layout_Override_Student_In'
										,'AMERICAN_STUDENT_NEW' => 'fcra.Layout_Override_Student_New'
										,'EMAIL_DATA' => 'FCRA.Layout_Override_Email_Data'
										,'PILOT_REGISTRATION' => 'FCRA.key_override_faa.airmen_rec'
									   ,'PROFLIC_MARI' => 'FCRA.Layout_Override_Proflic_Mari_In'
									  ,'PROPERTY_SEARCH' => 'FCRA.key_override_property.search_override_layout'
										,'SO_MAIN' => 'FCRA.key_override_sexoffender.soff_rec'
										,'UCC_PARTY' => 'FCRA.key_override_ucc.party_rec'
									//,'IBEHAVIOR_CONSUMER' => 'FCRA.key_override_ibehavior.consumer_rec'
									//,'IBEHAVIOR_PURCHASE' => 'FCRA.key_override_ibehavior.purchase_rec'
										,'CONCEALED_WEAPONS' => 'FCRA.key_override_ccw.ccw_rec'
									  ,'WATERCRAFT' => 'FCRA.Key_Override_Watercraft.sid_rec'
										,'DID_DEATH' => 'FCRA.key_override_death_master.Death_rec'
										,'MARRIAGE_SEARCH' => 'FCRA.key_override_marriage.marriage_search_rec'
									//	,'BANKRUPT_MAIN' => 'FCRA.layout_main_ffid_v3'		
									//	,'BANKRUPT_SEARCH' => 'FCRA.layout_search_ffid_v3'		
										,'LIENSV2_MAIN' => 'FCRA.Layout_Override_Liensv2_main'					
										,'LIENSV2_PARTY' => 'FCRA.Layout_Override_Liensv2_party'	
										,'OFFENDERS' => 'FCRA.key_override_crim.offenders_rec'	
										,'OFFENDERS_PLUS' => 'FCRA.key_override_crim.offenders_rec'	
										,'FCRA.Layout_Override_'+datasetname+if(useInLayout,'_in','')
										)
									),
							  #END 	
								#if(STD.Str.ToUpperCase(datasetname) = 'BANKRUPT_SEARCH')
								xml('bk_search/row'),	
								#elseif(STD.Str.ToUpperCase(datasetname) = 'BANKRUPT_MAIN')
								xml('bk_filings/row'),
								#elseif(STD.Str.ToUpperCase(datasetname) = 'LIENSV2_MAIN')
								xml('lien_main/row'),
								#elseif(STD.Str.ToUpperCase(datasetname) = 'LIENSV2_PARTY')
								xml('lien_party/row'),
								#else 
								csv(separator('\t'),quote('\"'),terminator('\r\n')),
								#end 
								opt);
	
#uniquename(dsRecID)

%dsRecID%:=table(%ds%,{
			string20 Datagroup	:=	overrides.Constants.getdatagroup(datasetname)
			,string20 flag_file_id := (string)flag_file_id_field					
		   ,string12 did			:=	(string)LexidField
			,string100 RecID			:=	trim((string)RecID1_field) + trim((string)RecID2_field) + trim((string)RecID3_field) + trim((string)RecID4_field)
			,string100 RecID1 := (string)RecID1_field
			,string100 RecID2 := (string)RecID2_field
			,string100 RecID3 := (string)RecID3_field
			,string100 RecID4 := (string)RecID4_field
			},flag_file_id_field, LexidField,RecID1_field, RecID2_field, RecID3_field, RecID4_field, merge);

retval:=dedup(%dsRecID%,record,all);

endmacro;
