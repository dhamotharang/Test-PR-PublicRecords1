IMPORT PRTE2_Liens_Ins, PRTE2_Liens, PRTE2_Common, ut;


Party_in 	:= PRTE2_Liens.files.SprayParty(TMSID <> '' and DID>''); //Spreadsheet passed blank records

// BAP: experimented with SORT prior to the Choosesets, but still came up with < the requested 2000/state
Party_in_D := DISTRIBUTE(Party_in,hash32(st));
Party_in_S := SORT(Party_in,st,local);
Party_1 := CHOOSESETS(Party_in_S,
               st='AK'=>howMany,st='AL'=>howMany,st='AR'=>howMany,st='AZ'=>howMany,st='CA'=>howMany,st='CO'=>howMany,
							 st='CT'=>howMany,st='DC'=>howMany,st='DE'=>howMany,st='FL'=>howMany,st='GA'=>howMany,st='HI'=>howMany,
							 st='IA'=>howMany,st='ID'=>howMany,st='IL'=>howMany,st='IN'=>howMany,st='KS'=>howMany,st='KY'=>howMany,
							 st='LA'=>howMany,st='MA'=>howMany,st='MD'=>howMany,st='ME'=>howMany,st='MI'=>howMany,st='MN'=>howMany,
							 st='MO'=>howMany,st='MS'=>howMany,st='MT'=>howMany,st='NC'=>howMany,st='ND'=>howMany,st='NE'=>howMany,
							 st='NH'=>howMany,st='NJ'=>howMany,st='NM'=>howMany,st='NV'=>howMany,st='NY'=>howMany,st='OH'=>howMany,
							 st='OK'=>howMany,st='OR'=>howMany,st='PA'=>howMany,st='RI'=>howMany,st='SC'=>howMany,st='SD'=>howMany,
							 st='TN'=>howMany,st='TX'=>howMany,st='UT'=>howMany,st='VA'=>howMany,st='VT'=>howMany,st='WA'=>howMany,
							 st='WI'=>howMany,st='WV'=>howMany,st='WY'=>howMany, 0);
Party := DISTRIBUTE(Party_1,hash32(st));
main_in		:= PRTE2_Liens.files.MainStatus(TMSID <> ''); //Spreadsheet passed blank records
main_in joinEm(Party L, main_in R) := TRANSFORM
		SELF := R;
END;
main := JOIN(Party,main_in,
								left.tmsid = right.tmsid,
								joinEm(left,right),
								INNER
								);


// **********************************************************************************************
AgeBy := 84;
main_dist := DISTRIBUTE(main);

STRING FIXYear(STRING instr) := PRTE2_Liens_Ins.U_GatherFix_BocaPRCT_Cases_Functions.FixYear(instr);
STRING FIXYearWithCheck(STRING fileDate, STRING instr) := PRTE2_Liens_Ins.U_GatherFix_BocaPRCT_Cases_Functions.FIXYearWithCheck(fileDate, instr);
STRING FIXFilingYear(STRING fileDate) := PRTE2_Liens_Ins.U_GatherFix_BocaPRCT_Cases_Functions.FIXFilingYear(fileDate);

main trxMain( main_dist L ) := TRANSFORM
		SELF.process_date := FIXYearWithCheck(L.filing_date,L.process_date);
		SELF.date_vendor_removed := FIXYearWithCheck(L.filing_date,L.date_vendor_removed);
		SELF.orig_filing_date := FIXYearWithCheck(L.filing_date,L.orig_filing_date);
		SELF.orig_filing_time := FIXYearWithCheck(L.filing_date,L.orig_filing_time);
		SELF.filing_date := FIXFilingYear(L.filing_date);
		SELF.vendor_entry_date := FIXYearWithCheck(L.filing_date,L.vendor_entry_date);
		SELF.release_date := FIXYearWithCheck(L.filing_date,L.release_date);
		SELF.judg_satisfied_date := FIXYearWithCheck(L.filing_date,L.judg_satisfied_date);
		SELF.judg_vacated_date := FIXYearWithCheck(L.filing_date,L.judg_vacated_date);
		SELF.effective_date := FIXYearWithCheck(L.filing_date,L.effective_date);
		SELF.lapse_date := FIXYearWithCheck(L.filing_date,L.lapse_date);
		SELF.accident_date := FIXYearWithCheck(L.filing_date,L.accident_date);
		SELF.expiration_date := FIXYearWithCheck(L.filing_date,L.expiration_date);
		SELF := L;
END;
MainNew := PROJECT(main_dist,trxMain(LEFT));

// dataset(layout_filing_status) filing_status;


// BaseParty_IN
party trxParty( party L ) := TRANSFORM
		SELF.date_first_seen := FIXYear(L.date_first_seen);
		SELF.date_last_seen := FIXYear(L.date_last_seen);
		SELF.date_vendor_first_reported := FIXYear(L.date_vendor_first_reported);
		SELF.date_vendor_last_reported := FIXYear(L.date_vendor_last_reported);
		SELF := L;
END;
PartyNew := PROJECT(Party,trxParty(LEFT));

// **********************************************************************************************

STRING dateString := PRTE2_Common.Constants.TodayString+'';
desprayNameMain	:= 'Main_DateFix_'+dateString+'.csv';
Export_Main		:=	SORT(MainNew,tmsid);
desprayNameParty	:= 'Party_DateFix_'+dateString+'.csv';
Export_Party		:=	SORT(PartyNew,tmsid);
LandingZoneIP 	:= PRTE2_Liens_Ins.Constants.LandingZoneIP;
TempCSV1				:= PRTE2_Liens_Ins.Files.FILE_SPRAY+'_1';
TempCSV2				:= PRTE2_Liens_Ins.Files.FILE_SPRAY+'_2';
TempCSV3				:= PRTE2_Liens_Ins.Files.FILE_SPRAY+'_3';
pathFileMain	:= PRTE2_Liens_Ins.Constants.SourcePathForCSV + desprayNameMain;
pathFileParty	:= PRTE2_Liens_Ins.Constants.SourcePathForCSV + desprayNameParty;

PRTE2_Common.DesprayCSV(Export_Main, TempCSV1, LandingZoneIP, pathFileMain);
PRTE2_Common.DesprayCSV(Export_Party, TempCSV2, LandingZoneIP, pathFileParty);


// BaseStatus_in 
/* 
	Status trxStat( Status L );
   		SELF.process_date := FIXYear(L.process_date);
   		SELF := L;
   END;
*/


// BaseMain_IN
