import Official_Records, Lib_FileServices,RoxieKeybuild,orbit_report,dops,Scrubs_Official_Records;
export BWR_Build_All_Moxie_Files := function
#workunit('name','Official Records Build All' );

leMailTarget := 'jtao@seisint.com;skasavajjala@seisint.com';

fSendMail(string pSubject,string pBody)
 := lib_fileservices.fileservices.sendemail(leMailTarget,pSubject,pBody);

filedate := official_records.Version_Development;

official_records.Out_Moxie_Dev_Population_Stats(official_records.File_Moxie_Party_Dev
								               ,official_records.File_Moxie_Document_Dev
								               ,official_records.Version_Development
           									   ,DoTheSTRATAStats)

dops_update := dops.updateversion('OfficialRecordsKeys',filedate,'skasavajjala@seisint.com',,'N');
orbit_report.Orecs_Stats(getretval);
build_all :=
sequential
 (
	sequential(official_records.proc_official_record_document( filedate)
	           ,official_records.proc_official_record_party(filedate)
              ,Official_Records.Out_Moxie_Party
			  ,official_records.Out_Clean_Moxie_Party
			  ,official_records.Name_Moxie_Party_temp_Dev
			  ),
	parallel(
			   Official_Records.Out_Moxie_Party
			  ,Official_Records.Out_Moxie_Document
			
			 ),
	fSendMail('Official Records 1 of 2','Moxie and all Roxie files complete'),
	parallel(
			  // ----
			  parallel(
			   Official_Records.Moxie_Official_Records_Full_File
			  )
		
			 ),
	fSendMail('Official Records 2 of 2','Moxie job complete'),
	
	official_records.Out_Keys,
	official_records.Proc_Build_Autokey,
	fSendMail('Official Records','Key build complete'),
	
	official_records.official_records_party_stats,
	official_records.official_records_document_stats,
	fSendMail('Official Records Stats','Official Records Party and Document Stats Complete'),
	
	DoTheSTRATAStats,
	fSendMail('STRATA','Official Records STRATA Stats Complete'),
	dops_update,
	getretval,
	official_records.QA_Key_Pull,
	official_records.Extract_marriage_divorces,
	Scrubs_Official_Records.fnRunScrubs(filedate,'')

 );
 
 return build_all;
 end;