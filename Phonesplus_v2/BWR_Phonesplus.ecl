import Cellphone,Phonesplus, lib_FileServices, RoxieKeyBuild,infutorcid, phonesplus_v2, ut,buildlogger;
export BWR_Phonesplus(string pversion,string emailList='', string tversion):=function

e_mail_success := FileServices.sendemail
('john.freibaum@lexisnexis.com;qualityassurance@seisint.com;Sudhir.Kasavajjala@lexisnexis.com;aherzberg@lexisnexis.com;kevin.reeder@lexisnexis.com','PHONESPLUS/QSENT '+ pversion +' weekly sample available ','at ' + thorlib.WUID());

e_mail_failure := FileServices.sendemail
('john.freibaum@lexisnexis.com;Sudhir.Kasavajjala@lexisnexis.com;aherzberg@lexisnexis.com;kevin.reeder@lexisnexis.com','Phonesplus/Qsent Build Failure',failmessage+'at ' + thorlib.WUID());

phonesplus_dops_update  := sequential(
																			RoxieKeybuild.updateversion('PhonesPlusV2Keys',pversion,'john.freibaum@lexisneis.com',,'N'),
																			//CCPA-5 comment out for 4/9RR
																			// RoxieKeybuild.updateversion('QsentKeys',pversion,'john.freibaum@lexisneis.com',,'N'));
																			);
																														
phonesplus_idops_update := sequential(RoxieKeybuild.updateversion('PhonesPlusKeys',pversion,'john.freibaum@lexisneis.com',,'N',,,'A'),
																			RoxieKeybuild.updateversion('PhonesPlusV2Keys',pversion,'john.freibaum@lexisneis.com',,'N',,,'A'),
																			//CCPA-5 comment out for 4/9RR
																			// RoxieKeybuild.updateversion('QsentKeys',pversion,'john.freibaum@lexisneis.com',,'N',,,'A'));
																			);

addHeaderKeyBuilding 		:= if(fileservices.getsuperfilesubcount('~thor_data400::Base::HeaderKey_Building')>0, 
															output('Nothing added to thor_data400::Base::HeaderKey_Building'), 
															fileservices.addsuperfile('~thor_data400::Base::HeaderKey_Building','~thor_data400::Base::Header_prod',,true));

clearHeaderKeyBuilding 	:= FileServices.ClearSuperFile('~thor_data400::Base::HeaderKey_Building');

BuildAll:= sequential
       (
			 	BuildLogger.BuildStart(false),
				BuildLogger.PrepStart(false),
	  		Phonesplus_v2.Spray_Telcordia(tversion);  
				Phonesplus.spray_NeustarInputFile(pversion),     		
				addHeaderKeyBuilding,
				BuildLogger.PrepEnd(false),
				BuildLogger.BaseStart(false),
				Phonesplus_v2.Proc_build_base(pversion,emailList),
				BuildLogger.BaseEnd(false),
				Phonesplus.proc_personheaderlookup_build(pversion),
				BuildLogger.KeyStart(false),
				Phonesplus_v2.Proc_build_Phonesplus_keys(pversion),
				Phonesplus_v2.Proc_build_Royalty_keys(pversion),			
				Phonesplus.proc_create_phonesplus_relationships(pversion),
				Phonesplus_v2.Proc_Build_Iverification(pversion),
				Phonesplus_v2.Proc_Build_Scoring_Keys(pversion),
				// Phonesplus.Qsent_DID(pversion),			//CCPA-5 comment out for 4/9RR
				// Phonesplus.proc_build_qsent_keys(pversion),		//CCPA-5 comment out for 4/9RR
				clearHeaderKeyBuilding,
				BuildLogger.KeyEnd(false),
				BuildLogger.PostStart(false),
				phonesplus_dops_update,
				Phonesplus_v2.Proc_Build_Surname_File(pversion),
				Phonesplus_v2.Fn_Extract_LeadsEnhancementforDeathofInsured(pversion),	
	parallel
		   (Phonesplus.sample_PhonesplusBase,
				Phonesplus_v2.Strata_Phonesplus(pversion),
				// Phonesplus.sample_QsentBase,			//CCPA-5 comment out for 4/9RR
			  // Phonesplus.strata_popFileQsentBase(pversion),						//CCPA-5 comment out for 4/9RR
			  phonesplus.proc_build_stats),
				BuildLogger.PostEnd(false),
				BuildLogger.BuildEnd(false),
				):success(e_mail_success), FAILURE(e_mail_failure);

	return BuildAll;			
/*______Comments________________________________________________________________________________________________________________________________________________________________*/			
/*On Hold and no longer updating*/
			/*Phonesplus.proc_build_phonesplus_keys(pversion), 		The keys are nolonger being updated. They have been removed from the Roxie Release package (JBF)
			phonesplus_idops_update,	"On hold"					
			Phonesplus_v2.Proc_OrbitI_CreateBuild(pversion,'nonfcra','PP');		"On hold" 
			Phonesplus_v2.Proc_OrbitI_CreateBuild(pversion,'nonfcra','QS');		"On hold"
			Phonesplus_v2.Proc_OrbitI_CreateBuild(pversion,'nonfcra','PPV2');	"On hold"  */
			
			/*2011-03-17T14:09:50Z (jfreibaum_prod)
			c:\Documents and Settings\jfreibaum\Application Data\LexisNexis\querybuilder\jfreibaum_prod\Prod_400\Phonesplus_v2\BWR_Phonesplus\2011-03-17T14_09_50Z.ecl*/

			/*2010-11-23T20:56:12Z (aherzberg)
			c:\SuperComputer\Dataland\QueryBuilder\workspace\aherzberg\dataland\Phonesplus_v2\BWR_Phonesplus\2010-11-23T20_56_12Z.ecl*/

/*______________________________________________________________________________________________________________________________________________________________________________*/

	end;