import Watercraft, Lib_FileServices, doxie_build, watercraftv2_services;

#workunit('name','Watercraft Build ' + Watercraft.Version_Development);


eMail_Recipient := 'jtrost@seisint.com,khumayun@seisint.com';
leMailTarget    := 'RoxieBuilds@seisint.com,'+eMail_Recipient;

sequential
 (
	parallel
	 (
		Watercraft.Out_Coastguard_Base_Dev,
		Watercraft.Out_Main_Base_Dev,
		Watercraft.Out_Search_Base_Dev
	 ),
	//Lib_FileServices.FileServices.SendEmail(eMail_Recipient,'Watercraft Build 1 of 4','Watercraft Build - Data Complete'),
	parallel
	 (
		Watercraft.Out_Search_Base_Dev_Stats,
		Watercraft.Out_Main_Base_Dev_Stats,
		Watercraft.Out_Coastguard_Base_Dev_Stats,
		Watercraft.Out_Base_Dev_Stats,
		Watercraft.coverage
	 ),
	//Lib_FileServices.FileServices.SendEmail(eMail_Recipient,'Watercraft Build 2 of 4','Watercraft Build - Stats Complete'),
	//parallel
	// (
	//	Watercraft.Out_Search_Base_Dev_Keys,
	//	Watercraft.Out_Main_Base_Dev_Keys,
	//	Watercraft.Out_Coastguard_Base_Dev_Keys
	// ),
	//Lib_FileServices.FileServices.SendEmail(eMail_Recipient,'Watercraft Build 3 of 4','Watercraft Build - Keys Complete'),
	watercraft.proc_build_keys(watercraft.Version_Development),
	if(Watercraft.Constants.BUILD_BID_KEY_FLAG,watercraft.proc_build_keys_bid(watercraft.Version_Development)),
	watercraftv2_services.proc_autokeybuild(watercraft.Version_Development),
	if(Watercraft.Constants.BUILD_BID_KEY_FLAG,watercraftv2_services.proc_autokeybuild_bid(watercraft.Version_Development)),
	watercraft.Proc_Build_Boolean_key(watercraft.Version_Development),
	watercraft.Proc_AcceptSK_toQA,
	if(Watercraft.Constants.BUILD_BID_KEY_FLAG,watercraft.Proc_AcceptSK_toQA_Bid),
    Lib_FileServices.FileServices.SendEmail(leMailTarget,'Watercraft Build Succeeded ' + watercraft.Version_Development,
	               'keys: 1) thor_data400::key::watercraft::'+watercraft.Version_Development+'_cid \n' + 
				   '      2) thor_data400::key::watercraft::'+watercraft.Version_Development+'_bdid \n' + 
				   '      3) thor_data400::key::watercraft::'+watercraft.Version_Development+'_did \n' + 
				   '      4) thor_data400::key::watercraft::'+watercraft.Version_Development+'_sid \n' + 
				   '      5) thor_data400::key::watercraft::'+watercraft.Version_Development+'_wid \n' + 
				   '      6) thor_data400::key::watercraft::'+watercraft.Version_Development+'_hullnum \n' + 
				   '      7) thor_data400::key::watercraft::'+watercraft.Version_Development+'_offnum \n' + 
				   '      8) thor_data400::key::watercraft::'+watercraft.Version_Development+'_vslnam \n' +
				   '      9) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::address \n' +
				   '      10) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::addressb2 \n' +
				   '      11) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::citystname \n' +
				   '      12) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::citystnameb2 \n' +
				   '      13) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::fein2 \n' +
				   '      14) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::name \n' +
				   '      15) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::nameb2 \n' +
				   '      16) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::namewords2 \n' +
				   '      17) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::payload \n' +
				   '      18) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::phone2 \n' +
				   '      19) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::phoneb2 \n' +
				   '      20) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::ssn2 \n' +
				   '      21) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::stname \n' +
				   '      22) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::stnameb2 \n' +
				   '      23) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::zip \n' +
				   '      24) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::zipb2 \n' +
			if(Watercraft.Constants.BUILD_BID_KEY_FLAG,		         
					 'BID keys: 1) thor_data400::key::watercraft::'+watercraft.Version_Development+'_bid \n' + 
				   '      2) thor_data400::key::watercraft::'+watercraft.Version_Development+'_sid_bid \n' + 
				   '      3) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::bid::address \n' +
				   '      4) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::bid::addressb2 \n' +
				   '      5) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::bid::citystname \n' +
				   '      6) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::bid::citystnameb2 \n' +
				   '      7) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::bid::fein2 \n' +
				   '      8) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::bid::name \n' +
				   '      9) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::bid::nameb2 \n' +
				   '      10) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::bid::namewords2 \n' +
				   '      11) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::bid::payload \n' +
				   '      12) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::bid::phone2 \n' +
				   '      13) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::bid::phoneb2 \n' +
				   '      14) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::bid::ssn2 \n' +
				   '      15) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::bid::stname \n' +
				   '      16) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::bid::stnameb2 \n' +
				   '      17) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::bid::zip \n' +
				   '      18) thor_data400::key::watercraft::'+watercraft.Version_Development+'::autokey::bid::zipb2 \n','') +
				   '      have been built and ready to be deployed to QA.')		
  )
	
