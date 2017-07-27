/*
/*
	Author: 		Gavin Witz
	Date:   		05/06/2009
	Revision:		1.1
	Purpose:		Creates a Build Window Runable that comprises of three joins, and outputs
					those files that match the input CSV file and Bankrupcy Main.	
	Requirements:   N/A
*/
IMPORT bankruptcyv3, Banko,bankruptcyv2,lib_fileservices, lib_stringlib, _control,did_add, ut , fcra;

export fBankoAdditionalEvents() := FUNCTION

filedate := Banko.version;
typeof(Banko.BankoJoinRecord) CourtID_C3CourtID_Rec(recordof(Banko.Layout_BankoFile_FixedRec) L
										,recordof(bankruptcyv3.file_bankruptcyv3_courts) R) := TRANSFORM

	SELF.court_code :=R.moxie_court;
	SELF.Cat_Event := ' ';
	SELF := L;
	
END;

CourtID_C3CourtID_RecJoin := JOIN(Banko.Layout_BankoFile_FixedRec,
					bankruptcyv3.file_bankruptcyv3_courts,
					LEFT.CourtID =  (STRING10) RIGHT.c3courtid,
					CourtID_C3CourtID_Rec(LEFT,RIGHT),LOOKUP);
					

typeof(Banko.BankoJoinRecord) Add_CatEvent_Rec(recordof(Banko.BankoJoinRecord) L
										,recordof(Banko.File_CategoryEvent) R) := TRANSFORM

	SELF.Cat_Event := R.Cat_Event;
	SELF := L;
	
END;

Add_CatEvent_RecJoin := JOIN(CourtID_C3CourtID_RecJoin,
					Banko.File_CategoryEvent,
					LEFT.DRCategoryEventID =  RIGHT.CategoryEventID AND
					RIGHT.Flag = 'TRUE',
					Add_CatEvent_Rec(LEFT,RIGHT),LOOKUP);

Banko_Additional_EventSort := SORT(Add_CatEvent_RecJoin,CaseKey);
Banko_Additional_EventDist := DISTRIBUTE(Banko_Additional_EventSort,HASH32(CaseKey));

BankruptcyV2Sort := SORT(BankruptcyV2.file_bankruptcy_main,case_number);
BankruptcyV2Dist := DISTRIBUTE(BankruptcyV2Sort,HASH32(case_number));


typeof(Banko.BankoJoinRecord) Banko_Additional_EventRec(recordof(Banko_Additional_EventDist) L
										,recordof(BankruptcyV2Dist) R) := TRANSFORM
	SELF := L;
END;

Banko_Additional_EventRecJoin := JOIN(Banko_Additional_EventDist,
					BankruptcyV2Dist,
					LEFT.court_code =  RIGHT.court_code AND
					LEFT.casekey =  RIGHT.case_number, 					
					Banko_Additional_EventRec(LEFT,RIGHT),LOOKUP,local);					
					
			
NonFRCA_Banko_Additional_EventSortRec := SORT(Banko_Additional_EventRecJoin,casekey);
					
//************** FCRA KEYS ****************************/

todaysdate := ut.GetDate;
isFCRA :=true;
get_recs := BankruptcyV2.file_bankruptcy_main(~isFCRA OR fcra.bankrupt_is_ok (todaysdate,date_filed));

FCRA_Banko_Additional_EventSortRec := SORT(NonFRCA_Banko_Additional_EventSortRec,CaseKey);
FCRA_Banko_Additional_EventDist := DISTRIBUTE(FCRA_Banko_Additional_EventSortRec,HASH32(CaseKey));

FCRA_BankruptcyV2Sort := SORT(get_recs,case_number);
FCRA_BankruptcyV2Dist := DISTRIBUTE(FCRA_BankruptcyV2Sort,HASH32(case_number));

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

//******************  OUTPUT JOIN  *********************/


FileServices.Copy('~thor_data400::base::Banko::main','thor400_88','~thor_data400::base::Banko::main_temp');
FileServices.Copy('~thor_data400::base::FCRA::Banko::main','thor400_88','~thor_data400::base::FCRA::Banko::main_temp');

daily_NonFCRA :=DATASET('~thor_data400::base::Banko::main_temp',Banko.BankoJoinRecord,FLAT);
daily_FCRA :=DATASET('~thor_data400::base::FCRA::Banko::main_temp',Banko.BankoJoinRecord,FLAT);

daily_plus_full_NonFCRA := NonFRCA_Banko_Additional_EventSortRec + daily_NonFCRA;
daily_plus_full_FCRA := FCRA_FINAL_Banko_Additional_EventSortRec + daily_FCRA;

OUTPUT(daily_plus_full_NonFCRA,,'~thor_data400::base::Banko::main_'+filedate,overwrite);
OUTPUT(daily_plus_full_FCRA,,'~thor_data400::base::FCRA::Banko::main_'+filedate,overwrite);

//OUTPUT(NonFRCA_Banko_Additional_EventSortRec,,'~thor_data400::base::Banko::main_'+filedate,overwrite);
//OUTPUT(FCRA_FINAL_Banko_Additional_EventSortRec,,'~thor_data400::base::FCRA::Banko::main_'+filedate,overwrite);

CreateBaseSuperFile(filedate);

BUILDINDEX(Banko.Key_Banko_courtcode_casenumber(false),overwrite,NAMED('INDEX'));
BUILDINDEX(Banko.Key_Banko_courtcode_casenumber(true),overwrite,NAMED('INDEX1'));	


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
RETURN OUTPUT('DONE');


END;