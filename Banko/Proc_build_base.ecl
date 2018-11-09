#OPTION('allowedClusters','thor400_44,thor400_66');
IMPORT Roxiekeybuild,bankruptcyv3, Banko,bankruptcyv2,lib_fileservices, lib_stringlib, _control,did_add, ut , fcra, dops, STD, Orbit3;


export Proc_build_base(string filedate,boolean newCatEvent = false) := function
/*
/*
	Author: 		Gavin Witz
	Date:   		05/06/2009
	Revision:		1.1
	Purpose:		Creates a Build Window Runable that comprises of three joins, and outputs
					those files that match the input CSV file and Bankrupcy Main.	
	Requirements:   N/A
*/
//filedate := Banko.version;
typeof(Banko.BankoJoinRecord) CourtID_C3CourtID_Rec(recordof(Banko.Layout_BankoFile_FixedRec) L
										,recordof(bankruptcyv3.file_bankruptcyv3_courts) R) := TRANSFORM

	SELF.court_code :=R.moxie_court;
	SELF.district := R.district;
	SELF.boca_court := R.boca_court;
	SELF.CatEvent_Description := ' ';
	SELF.CatEvent_Category := ' ';
	SELF.EnteredDate := filedate; // filedate is now datetime
	SELF := L;
	
END;

CourtID_C3CourtID_RecJoin := JOIN(Banko.Layout_BankoFile_FixedRec,
					bankruptcyv3.file_bankruptcyv3_courts(active = '1'),
					LEFT.CourtID =  (STRING10) RIGHT.c3courtid,
					CourtID_C3CourtID_Rec(LEFT,RIGHT),LOOKUP);
					

typeof(Banko.BankoJoinRecord) Add_CatEvent_Rec(recordof(Banko.BankoJoinRecord) L
										,recordof(Banko.File_CategoryEvent) R) := TRANSFORM

	SELF.CatEvent_Description := R.Description;
	SELF.CatEvent_Category := R.Category;
	SELF := L;
	
END;

Add_CatEvent_RecJoin := JOIN(CourtID_C3CourtID_RecJoin,
					Banko.File_CategoryEvent,
					LEFT.DRCategoryEventID =  RIGHT.CategoryEventID,
					Add_CatEvent_Rec(LEFT,RIGHT),LOOKUP);

// Banko_Additional_EventDist := DISTRIBUTE(Add_CatEvent_RecJoin,HASH32(CaseKey));	
NonFCRA_Banko_Additional_EventSortRec_new := DISTRIBUTE(Add_CatEvent_RecJoin,HASH32(CaseKey));
NonFCRA_Banko_Additional_EventSortRec := Banko.fRemoveDeletes(banko.File_Banko_Base('nonfcra')) + NonFCRA_Banko_Additional_EventSortRec_new;	
// NonFCRA_Banko_Additional_EventSortRec := SORT(Banko_Additional_EventDist,casekey);
					
//************** FCRA KEYS ****************************/

todaysdate := (STRING8)Std.Date.Today();
// isFCRA :=true;
get_recs := BankruptcyV2.file_bankruptcy_main(fcra.bankrupt_is_ok (todaysdate,date_filed));
FCRA_BankruptcyV2Sort := SORT(get_recs,case_number);
FCRA_BankruptcyV2Dist := DISTRIBUTE(FCRA_BankruptcyV2Sort,HASH32(case_number));

FCRA_Banko_Additional_EventSortRec := SORT(NonFCRA_Banko_Additional_EventSortRec,CaseKey);
FCRA_Banko_Additional_EventDist := DISTRIBUTE(FCRA_Banko_Additional_EventSortRec,HASH32(CaseKey));


typeof(Banko.BankoJoinRecord) FCRA_Banko_Additional_EventRec(recordof(FCRA_Banko_Additional_EventDist) L
										,recordof(FCRA_BankruptcyV2Dist) R) := TRANSFORM
	SELF := L;
	
END;

// FCRA_Banko_Additional_EventRecJoin := JOIN(FCRA_Banko_Additional_EventDist,
					// FCRA_BankruptcyV2Dist,
					// LEFT.court_code =  RIGHT.court_code AND
					// LEFT.casekey =  RIGHT.case_number, 					
					// FCRA_Banko_Additional_EventRec(LEFT,RIGHT),LOOKUP,local);					

FCRA_FINAL_Banko_Additional_EventSortRec := JOIN(FCRA_Banko_Additional_EventDist,
					FCRA_BankruptcyV2Dist,
					LEFT.court_code =  RIGHT.court_code AND
					LEFT.casekey =  RIGHT.case_number, 					
					FCRA_Banko_Additional_EventRec(LEFT,RIGHT),LOOKUP,local);							
			
// FCRA_FINAL_Banko_Additional_EventSortRec := SORT(FCRA_Banko_Additional_EventRecJoin,casekey);

// ***************************
// Base files
// RemovedDeletes := Banko.fRemoveDeletes(banko.File_Banko_Base('nonfcra'));

output_nonfcra := output(NonFCRA_Banko_Additional_EventSortRec,,'~thor::base::banko::nonfcra::'+filedate+'::additionalevents',overwrite,__compressed__);

Roxiekeybuild.Mac_SF_BuildProcess_V2(
					NonFCRA_Banko_Additional_EventSortRec,
					'~thor::base::banko::nonfcra','additionalevents',
					filedate,nonfcrabase,,,true,false);

output_fcra := output(FCRA_FINAL_Banko_Additional_EventSortRec,,'~thor::base::banko::fcra::'+filedate+'::additionalevents',overwrite,__compressed__);					

Roxiekeybuild.Mac_SF_BuildProcess_V2(
					FCRA_FINAL_Banko_Additional_EventSortRec,
					'~thor::base::banko::fcra','additionalevents',
					filedate,fcrabase,,,true,false);

//************** FILERING BASE FILE 

distribute_nonfcra := distribute(banko.File_Banko_Base('nonfcra'), hash(docketentryid));	
Filter_NonFCRA := SORT(distribute_nonfcra,docketentryid,-fileddate,-entereddate,local);
DedupFilter_NonFCRA := DEDUP(Filter_NonFCRA,RECORD, EXCEPT caseid,entereddate,pacer_entereddate,fileddate,score,local);

Roxiekeybuild.Mac_SF_BuildProcess_V2(DedupFilter_NonFCRA,					
					'~thor::banko::filter','additionalevents',
					filedate,FilterBase,,,true);	

distribute_fcra := distribute(banko.File_Banko_Base('fcra'), hash(docketentryid));	
Filter_FCRA := SORT(distribute_fcra,docketentryid,-fileddate,-entereddate,local);
DedupFilter_FCRA := DEDUP(Filter_FCRA,RECORD, EXCEPT caseid,entereddate,pacer_entereddate,fileddate,score,local);
					
Roxiekeybuild.Mac_SF_BuildProcess_V2(
					DedupFilter_FCRA,
					'~thor::banko::fcra::filter','additionalevents',
					filedate,FilterFcraBase,,,true);
					
//************** END FILERING BASE FILE 

// Roxie keys	
//	abbreviated case number keys				
roxiekeybuild.mac_sk_buildprocess_v2_local(banko.Key_Banko_courtcode_casenumber(),'foo',
						'~thor_data400::key::banko::' + filedate + '::courtcode.casenumber.caseId.payload',nonfcrakey);
roxiekeybuild.Mac_SK_Move_V3('~thor_data400::key::banko::@version@::courtcode.casenumber.caseId.payload','D',mvnonfcra,filedate);

roxiekeybuild.mac_sk_buildprocess_v2_local(banko.Key_Banko_courtcode_casenumber(true),'foo',
						'~thor_data400::key::banko::fcra::' + filedate + '::courtcode.casenumber.caseId.payload',fcrakey);
roxiekeybuild.Mac_SK_Move_V3('~thor_data400::key::banko::fcra::@version@::courtcode.casenumber.caseId.payload','D',mvfcra,filedate);
//	full case number keys				
roxiekeybuild.mac_sk_buildprocess_v2_local(banko.Key_Banko_courtcode_fullcasenumber(),'foo',
						'~thor_data400::key::banko::' + filedate + '::courtcode.fullcasenumber.caseId.payload',nonfcrafullkey);
roxiekeybuild.Mac_SK_Move_V3('~thor_data400::key::banko::@version@::courtcode.fullcasenumber.caseId.payload','D',mvnonfcrafull,filedate);

roxiekeybuild.mac_sk_buildprocess_v2_local(banko.Key_Banko_courtcode_fullcasenumber(true),'foo',
						'~thor_data400::key::banko::fcra::' + filedate + '::courtcode.fullcasenumber.caseId.payload',fcrafullkey);
roxiekeybuild.Mac_SK_Move_V3('~thor_data400::key::banko::fcra::@version@::courtcode.fullcasenumber.caseId.payload','D',mvfcrafull,filedate);

/* Alert records with low pacer date counts */
//pdatealert :=		Banko.proc_BKevents_stats(filedate).out_all ;

updatedops :=  
							if( dops.GetBuildVersion('BankruptcyV2Keys','B','N','T')[1..8] <> filedate[1..8] and dops.GetBuildVersion('FCRA_BankruptcyKeys','B','F','T')[1..8] <> filedate[1..8],
							sequential(
									dops.updateversion('BKEventsKeys',filedate,'Christopher.Brodeur@lexisnexisrisk.com,John.Freibaum@lexisnexisrisk.com, kevin.reeder@lexisnexisrisk.com, Michael.Gould@lexisnexisrisk.com, Randy.Reyes@lexisnexisrisk.com, Manuel.Tarectecan@lexisnexisrisk.com, intel357@bellsouth.net',,'N',,'Y'),
									dops.updateversion('FCRA_BKEventsKeys',filedate,'Christopher.Brodeur@lexisnexisrisk.com,John.Freibaum@lexisnexisrisk.com, kevin.reeder@lexisnexisrisk.com, Michael.Gould@lexisnexisrisk.com, Randy.Reyes@lexisnexisrisk.com, Manuel.Tarectecan@lexisnexisrisk.com, intel357@bellsouth.net',,'F',,'Y'),
									Banko.Manage_Input_Files(true)
										),
							if (~(ut.Weekday((integer)filedate[1..8]) = 'SATURDAY' or ut.Weekday((integer)filedate[1..8]) = 'SUNDAY'),
								sequential(
									dops.updateversion('BKEventsKeys',filedate,'Christopher.Brodeur@lexisnexisrisk.com,John.Freibaum@lexisnexisrisk.com, kevin.reeder@lexisnexisrisk.com, Michael.Gould@lexisnexisrisk.com, Randy.Reyes@lexisnexisrisk.com, Manuel.Tarectecan@lexisnexisrisk.com',,'N'),
									dops.updateversion('FCRA_BKEventsKeys',filedate,'Christopher.Brodeur@lexisnexisrisk.com,John.Freibaum@lexisnexisrisk.com, kevin.reeder@lexisnexisrisk.com, Michael.Gould@lexisnexisrisk.com, Randy.Reyes@lexisnexisrisk.com, Manuel.Tarectecan@lexisnexisrisk.com',,'F'),
									Banko.Manage_Input_Files(true)
										)
										
									)
							);
							
create_build := sequential(Orbit3.proc_Orbit3_CreateBuild('Bankruptcy Additional Events',filedate,'N'),
                Orbit3.proc_Orbit3_CreateBuild('FCRA Bankruptcy Additional Events',filedate,'F'));

retval := sequential(//if(newCatEvent,Banko.Spray_CatEventLookupTable('edata12','/hds_2/bkevents/archive/process/*CATEVENTDESC',filedate),output('No New CatEvent File')), //If no new cateven file, no spray
						sequential(
							parallel(output_nonfcra,output_fcra),
							parallel(nonfcrabase,fcrabase),Banko.fCheckNewCatEventClasses(filedate)),
					 parallel(FilterBase,FilterFcraBase),notify('BK EVENT FILTER BASE COMPLETE','*'),
					 parallel(nonfcrakey,fcrakey,nonfcrafullkey,fcrafullkey),updatedops,
					 mvnonfcra,mvfcra,mvnonfcrafull,mvfcrafull,
					 if(ut.Weekday((integer)filedate[1..8]) <> 'SATURDAY' and ut.Weekday((integer)filedate[1..8]) <> 'SUNDAY',
					 create_build,
					 output('No Orbit Entries Needed for weekend builds'))
			/* Update DOPS for Package File Release */


		);
		


////////// ALERT RECORDS WITH BAD Court ID //////////
/*
We send of an email once the job is completed, with any courtID misses.
*/
file_in := Banko.Banko_FileDataset;	
counted := (string)count(file_in(_CourtID = ''));

leMailTarget := 'john.freibaum@lexisnexisrisk.com, kevin.reeder@lexisnexisrisk.com, christopher.brodeur@lexisnexisrisk.com, Michael.Gould@lexisnexisrisk.com, Randy.Reyes@lexisnexisrisk.com, Manuel.Tarectecan@lexisnexisrisk.com';
//,Joseph.Lezcano@lexisnexisrisk.com';

fSendMail(string pSubject,string pBody)
 := lib_fileservices.fileservices.sendemail(leMailTarget,pSubject,pBody);


fSendMail('Banko '+ _Control.ThisEnvironment.Name + ' - '+counted+' CourtID delete records received','Data from workunit ' + Thorlib.WUID());

////////////////////////////////////////////////////	

return retval;

end;