import ut, advo, VersionControl,RoxieKeybuild,uspis_hotlist,scrubs,_Control, Orbit3, tools, std, strata;
export Build_all(

	 string 		pversion
	,string     pAdvoversion
	,string 		pAdvoSprayDirectory				= '/data/hds_180/advo/spray'
	,string 		pUSPISSprayDirectory			= '/data/hds_180/uspis_hotlist/out'
	,string     pSourceIP                 = _Control.IPAddress.bctlpedata11
	,boolean		pSkipAdvo									= false
	,boolean		pSkipUSPIS								= true
	,unsigned8	paprox_expected_rec_num		= 150000000
	,string			emailList									=	''

) :=
function
//********************************Apply Scrubs before building the base file***************************
  file_to_scrub := 	Build_base(pversion,pAdvoversion,Files().Input.using,Files().Base.qa);
//Transform to the layout that scrubs is expecting	
	file_to_scrub_t := project( file_to_scrub , Advo.Layout_Scrubs);
//Apply Scrubs
	
//Submits stats to Orbit
	submit_stats := Scrubs.ScrubsPlus_PassFile(file_to_scrub_t,'ADVO','ADVO','Scrubs_ADVO','',pversion,emailList,false);

  //append bitmap to base
  dbuildbase := dataset('~thor_data::Scrubs_ADVO::Scrubs_Bits',Advo.Layout_Scrubs,thor);
	VersionControl.macBuildNewLogicalFile(filenames(pversion).base.new,dbuildbase,BuildAdvoBase	,pShouldExport := false);
	// BuildAdvoBase:=output(dbuildbase,,'~thor_data400::base::ADVO::ScrubsTest::20170215',thor,overwrite);
//*****************************************************************************************************	

  // DF-21511 Show counts of blanked out fields in thor_data400::key::avm_v2::fcra::@version@::address
  cnt_advo_addr_history_fcra := OUTPUT(strata.macf_pops(ADVO.Key_Addr1_FCRA_history,,,,,,FALSE,['college_end_suppression_date','college_start_suppression_date', 
																																													                        'seasonal_end_suppression_date','seasonal_start_suppression_date']));
  cnt_advo_addr_fcra 					:= OUTPUT(strata.macf_pops(ADVO.Key_Addr1_FCRA,,,,,,FALSE,['college_end_suppression_date','college_start_suppression_date', 
																																													                        'seasonal_end_suppression_date','seasonal_start_suppression_date']));

	build_Advo :=
	sequential(
		 Create_Supers()
		,if(pAdvoSprayDirectory != '' and count(nothor(fileservices.superfilecontents(Filenames().Input.using))) = 0,VersionControl.fSprayInputFiles(Advo.Spray(pAdvoSprayDirectory),pEmailSubjectDataset := 'Advo ' + pversion),output('pAdvoSprayDirectory is blank, skipping spray' ))
    ,promote().sprayed2using		
		,if( count(Files().Input.using		) < paprox_expected_rec_num, FAIL(_Dataset().Name + ' ERROR: Not all input files have been loaded.....PLEASE VERIFY'))	
		,submit_stats
		,BuildAdvoBase
		,Promote(pversion,'base').new2built
		,Build_keys(pversion)
		,Strata_Stat_Advo(pversion,files().base.built)
		,Promote().using2used
		,Promote().built2qa
		,cnt_advo_addr_history_fcra, cnt_advo_addr_fcra

	);
	
	return sequential(
	
		 if(pSkipAdvo = false
			,build_Advo
			,Rename_Keys(pversion, false)
		 )
		,USPIS_HotList.Build_All(pversion,pUSPISSprayDirectory,pSkipUSPIS := pSkipUSPIS).all
		,Send_Email(pversion).Roxie.all_packages
	);
end;