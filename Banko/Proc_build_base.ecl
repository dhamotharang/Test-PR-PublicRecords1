IMPORT Roxiekeybuild,bankruptcyv3, Banko,bankruptcyv2,lib_fileservices, lib_stringlib, _control,did_add, ut , fcra;

export Proc_build_base(string filedate) := function
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
	SELF.EnteredDate := filedate + ut.getTime();
	SELF := L;
	
END;

CourtID_C3CourtID_RecJoin := JOIN(Banko.Layout_BankoFile_FixedRec,
					bankruptcyv3.file_bankruptcyv3_courts,
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

Banko_Additional_EventDist := DISTRIBUTE(Add_CatEvent_RecJoin,HASH32(CaseKey));	
NonFCRA_Banko_Additional_EventSortRec := SORT(Banko_Additional_EventDist,casekey);
					
//************** FCRA KEYS ****************************/

todaysdate := ut.GetDate;
isFCRA :=true;
get_recs := BankruptcyV2.file_bankruptcy_main(~isFCRA OR fcra.bankrupt_is_ok (todaysdate,date_filed));
FCRA_BankruptcyV2Sort := SORT(get_recs,case_number);
FCRA_BankruptcyV2Dist := DISTRIBUTE(FCRA_BankruptcyV2Sort,HASH32(case_number));

FCRA_Banko_Additional_EventSortRec := SORT(banko.File_Banko_Base('nonfcra'),CaseKey);
FCRA_Banko_Additional_EventDist := DISTRIBUTE(FCRA_Banko_Additional_EventSortRec,HASH32(CaseKey));


typeof(Banko.BankoJoinRecord) FCRA_Banko_Additional_EventRec(recordof(FCRA_Banko_Additional_EventDist) L
										,recordof(FCRA_BankruptcyV2Dist) R) := TRANSFORM
	SELF := L;
	
END;

FCRA_Banko_Additional_EventRecJoin := JOIN(FCRA_Banko_Additional_EventDist,
					FCRA_BankruptcyV2Dist,
					LEFT.court_code =  RIGHT.court_code AND
					LEFT.casekey =  RIGHT.case_number, 					
					FCRA_Banko_Additional_EventRec(LEFT,RIGHT),LOOKUP,local);					
					
			
FCRA_FINAL_Banko_Additional_EventSortRec := SORT(FCRA_Banko_Additional_EventRecJoin,casekey);

// ***************************
// Base files

Roxiekeybuild.Mac_SF_BuildProcess_V2(
					NonFCRA_Banko_Additional_EventSortRec + banko.File_Banko_Base('nonfcra'),
					'~thor_data400::base::banko::nonfcra','additionalevents',
					filedate,nonfcrabase);
Roxiekeybuild.Mac_SF_BuildProcess_V2(
					FCRA_FINAL_Banko_Additional_EventSortRec,
					'~thor_data400::base::banko::fcra','additionalevents',
					filedate,fcrabase);

//************** FILERING BASE FILE 
	
Filter_NonFCRA := SORT(banko.File_Banko_Base('nonfcra'),docketentryid,-fileddate,-entereddate);
DedupFilter_NonFCRA := DEDUP(Filter_NonFCRA,RECORD, EXCEPT caseid,entereddate,pacer_entereddate,fileddate,score,drcategoryeventid,catevent_description,catevent_category);

Roxiekeybuild.Mac_SF_BuildProcess_V2(DedupFilter_NonFCRA,					
					'~thor_data400::banko::filter','additionalevents',
					filedate,FilterBase);	
			
Filter_FCRA := SORT(banko.File_Banko_Base('fcra'),docketentryid,-fileddate,-entereddate);
DedupFilter_FCRA := DEDUP(Filter_FCRA,RECORD, EXCEPT caseid,entereddate,pacer_entereddate,fileddate,score,drcategoryeventid,catevent_description,catevent_category);
					
Roxiekeybuild.Mac_SF_BuildProcess_V2(
					DedupFilter_FCRA,
					'~thor_data400::banko::fcra::filter','additionalevents',
					filedate,FilterFcraBase);
					
//************** END FILERING BASE FILE 

// Roxie keys					
roxiekeybuild.mac_sk_buildprocess_v2_local(banko.Key_Banko_courtcode_casenumber(),'foo',
						'~thor_data400::key::banko::' + filedate + '::courtcode.casenumber.caseId.payload',nonfcrakey);
roxiekeybuild.Mac_SK_Move_V3('~thor_data400::key::banko::@version@::courtcode.casenumber.caseId.payload','D',mvnonfcra,filedate);

roxiekeybuild.mac_sk_buildprocess_v2_local(banko.Key_Banko_courtcode_casenumber(true),'foo',
						'~thor_data400::key::banko::fcra::' + filedate + '::courtcode.casenumber.caseId.payload',fcrakey);
roxiekeybuild.Mac_SK_Move_V3('~thor_data400::key::banko::fcra::@version@::courtcode.casenumber.caseId.payload','D',mvfcra,filedate);


retval := sequential(sequential(parallel(nonfcrabase,fcrabase),Banko.fCheckNewCatEventClasses(filedate)),
					 parallel(FilterBase,FilterFcraBase),
					 parallel(nonfcrakey,fcrakey),
					 mvnonfcra,mvfcra,
			/* Update DOPS for Package File Release */
		RoxieKeybuild.updateversion('BKEventsKeys',filedate,'Gavin.Witz@lexisNexis.com,Christopher.Brodeur@lexisNexis.com,John.Freibaum@lexisNexis.com'),
		RoxieKeybuild.updateversion('FCRA_BKEventsKeys',filedate,'Gavin.Witz@lexisNexis.com,Christopher.Brodeur@lexisNexis.com,John.Freibaum@lexisNexis.com'));



////////// ALERT RECORDS WITH BAD Court ID //////////
/*
We send of an email once the job is completed, with any courtID misses.
*/
file_in := Banko.Banko_FileDataset;	
counted := (string)count(file_in(_CourtID = ''));

leMailTarget := 'Gavin.Witz@lexisnexis.com';
//,Joseph.Lezcano@lexisnexis.com';

fSendMail(string pSubject,string pBody)
 := lib_fileservices.fileservices.sendemail(leMailTarget,pSubject,pBody);


fSendMail('Banko '+ _Control.ThisEnvironment.Name + ' - '+counted+' CourtID Translation Issues','Data from workunit ' + Thorlib.WUID());

////////////////////////////////////////////////////	

return retval;

end;