import Orbit_report,Watercraft, Lib_FileServices, doxie_build, watercraftv2_services,ut,RoxieKeyBuild, Watercraft_infutor, Watercraft_preprocess, DOPS;

/*Folderdate and InfolinkQtr are for spray process.
  Folderdate is where files are located, ie: '14q2' or '14q3'.  InfolinkQtr is in filename, ie: WI2014_Q3.  'Q3' would be the InfolinkQtr.*/
export proc_build_all(string filedate, string folderdate, string InfolinkQtr, string emailList='') := function

#workunit('name','Watercraft Build ' + filedate);


eMail_Recipient := 'Sudhir.Kasavajjala@lexisnexis.com';
leMailTarget    := 'RoxieBuilds@seisint.com,'+eMail_Recipient;


//  These build process have been added to SCRUBS - Bug# 168693
/*
ut.MAC_SF_BuildProcess(Watercraft.Out_Coastguard_Base_Dev
											 ,Watercraft.Cluster + 'base::watercraft_coastguard'
											 ,aCoastguardBaseFile,2,,true);										 
											 
ut.MAC_SF_BuildProcess(Watercraft.Persist_Main_Joined
											 ,Watercraft.Cluster + 'base::watercraft_main'
											 ,aMainBaseFile,2,,true);
											 
ut.MAC_SF_BuildProcess(Out_Search_Base_Dev
											 ,Watercraft.Cluster +'base::watercraft_search'
											 ,aSearchBaseFile,2,,true);	
*/								 

orbit_report.Watercraft_Stats(getretval);


return sequential
 (
 /* Infutor spray is called from script*/
	//Watercraft_infutor.proc_spray_Infutor(filedate),
	Watercraft_preprocess.proc_build_raw_input(filedate,folderdate,InfolinkQtr), //New clean raw input process using ECL
	Watercraft.file_infutor_in,
//Builds base files and runs scrubs process	
		Watercraft.proc_Scrubs_Coastguard(filedate,emailList),
		Watercraft.proc_Scrubs_Main(filedate,emailList),
		Watercraft.proc_Scrubs_Search(filedate,emailList),
	//Lib_FileServices.FileServices.SendEmail(eMail_Recipient,'Watercraft Build 1 of 4','Watercraft Build - Data Complete'),
	parallel
	 (
		Watercraft.Out_Search_Base_Dev_Stats,
		Watercraft.Out_Main_Base_Dev_Stats,
		Watercraft.Out_Coastguard_Base_Dev_Stats,
		Watercraft.fn_Out_Base_Dev_Stats(filedate),
		Watercraft.coverage,
		Watercraft.SampleQAFile
	 ),
	//Lib_FileServices.FileServices.SendEmail(eMail_Recipient,'Watercraft Build 2 of 4','Watercraft Build - Stats Complete'),
	watercraft.proc_build_keys(filedate),
	watercraftv2_services.proc_autokeybuild(filedate),
	watercraft.Proc_Build_Boolean_key(filedate),
	watercraft.Proc_AcceptSK_toQA,
	//Lib_FileServices.FileServices.SendEmail(eMail_Recipient,'Watercraft Build 3 of 4','Watercraft Build - Keys Complete'),
  Lib_FileServices.FileServices.SendEmail(leMailTarget,'Watercraft Build Succeeded ' + filedate,
	         'keys: 1)  thor_data400::key::watercraft::'+filedate+'::cid \n' + 
				   '      2)  thor_data400::key::watercraft::'+filedate+'::bdid \n' + 
				   '      3)  thor_data400::key::watercraft::'+filedate+'::did \n' + 
				   '      4)  thor_data400::key::watercraft::'+filedate+'::sid \n' + 
				   '      5)  thor_data400::key::watercraft::'+filedate+'::wid \n' + 
				   '      6)  thor_data400::key::watercraft::'+filedate+'::hullnum \n' + 
				   '      7)  thor_data400::key::watercraft::'+filedate+'::offnum \n' + 
				   '      8)  thor_data400::key::watercraft::'+filedate+'::vslnam \n' +
					 '      9)  thor_data400::key::watercraft::'+filedate+'::linkids \n' +
					 '      10) thor_data400::key::watercraft::'+filedate+'::Source_Rec_Id \n' +
				   '      11) thor_data400::key::watercraft::'+filedate+'::autokey::address \n' +
				   '      12) thor_data400::key::watercraft::'+filedate+'::autokey::addressb2 \n' +
				   '      13) thor_data400::key::watercraft::'+filedate+'::autokey::citystname \n' +
				   '      14) thor_data400::key::watercraft::'+filedate+'::autokey::citystnameb2 \n' +
				   '      15) thor_data400::key::watercraft::'+filedate+'::autokey::fein2 \n' +
				   '      16) thor_data400::key::watercraft::'+filedate+'::autokey::name \n' +
				   '      17) thor_data400::key::watercraft::'+filedate+'::autokey::nameb2 \n' +
				   '      18) thor_data400::key::watercraft::'+filedate+'::autokey::namewords2 \n' +
				   '      19) thor_data400::key::watercraft::'+filedate+'::autokey::payload \n' +
				   '      20) thor_data400::key::watercraft::'+filedate+'::autokey::phone2 \n' +
				   '      21) thor_data400::key::watercraft::'+filedate+'::autokey::phoneb2 \n' +
				   '      22) thor_data400::key::watercraft::'+filedate+'::autokey::ssn2 \n' +
				   '      23) thor_data400::key::watercraft::'+filedate+'::autokey::stname \n' +
				   '      24) thor_data400::key::watercraft::'+filedate+'::autokey::stnameb2 \n' +
				   '      25) thor_data400::key::watercraft::'+filedate+'::autokey::zip \n' +
				   '      26) thor_data400::key::watercraft::'+filedate+'::autokey::zipb2 \n' +
				   'have been built and ready to be deployed to QA.'),
					 DOPS.updateversion('WatercraftKeys',filedate,'skasavajjala@seisint.com',,'N|B'),
					 DOPS.updateversion('FCRA_WatercraftKeys',filedate,'skasavajjala@seisint.com',,'F'),
				   getretval
  );
	
end;