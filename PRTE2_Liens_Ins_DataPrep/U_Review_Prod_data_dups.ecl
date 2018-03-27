// ********************************************************
// PRTE2_Liens_Ins_DataPrep.U_Review_Prod_data_dups
// ********************************************************

IMPORT PRTE2_Common, PRTE2_Liens_Ins_DataPrep, PRTE2_Liens_Ins, LiensV2;

Add_Foreign_prod	:= PRTE2_Common.Constants.Add_Foreign_prod;
ReadOnly_Prod_SF_PartyKName	:= Add_Foreign_prod('thor_data400::key::liensv2::party::tmsid.rmsid_qa');
ReadOnly_Prod_SF_MainKName		:= Add_Foreign_prod('thor_data400::key::liensv2::main::tmsid.rmsid_qa');
ReadOnly_Prod_SF_PartyDidKName := Add_Foreign_prod('thor_data400::key::liensv2::did_qa');

PartyDidKey := INDEX(LiensV2.key_liens_DID,ReadOnly_Prod_SF_PartyDidKName);
PartyTmsKey := INDEX(LiensV2.key_liens_party_ID,ReadOnly_Prod_SF_PartyKName);
MainKey	:=	INDEX(LiensV2.key_liens_main_ID_FCRA,ReadOnly_Prod_SF_MainKName);			
// PartyCN := PartyDidKey(DID>0);	// This DID key will not have BDID records.
DSPartial := CHOOSEN(PartyDidKey(rmsid[3]='R' and tmsid[1]='H'),200000);
Dups := TABLE(DSPartial,{did,Cnt := COUNT(GROUP)},did)(Cnt>1);
PartyDIDsI := SET(Dups,did);
PartyRecs1 := PartyDidKey(did IN PartyDIDsI AND rmsid[3]='R' AND tmsid[1]='H');
PartyTmsIDs := SET(PartyRecs1,tmsid);

// OUTPUT(COUNT(PartyDIDsI));		// 36774
// OUTPUT(COUNT(PartyTmsIDs));		//180567

// DID=0 can happen when a state puts a lien on a person, two party records or a business sues a person, etc. Then did=0 on 1 or more records 
// Main is events not business or people so don't need to filter (and doesn't have did or bdid).
PartyDups := PartyTmsKey(tmsid IN PartyTmsIDs AND (INTEGER)DID>0);
MainDups  := MainKey(tmsid IN PartyTmsIDs);

dateString := PRTE2_Common.Constants.TodayString+'';
desprayNameMain	:= 'Liens_Main_Dups_Gather3h_'+dateString+'.csv';
desprayNameParty	:= 'Liens_Party_Dups_Gather3h_'+dateString+'.csv';

LandingZoneIP 	:= PRTE2_Liens_Ins.Constants.LandingZoneIP;
TempCSV1				:= PRTE2_Liens_Ins.Files.FILE_SPRAY+'_1';
TempCSV2				:= PRTE2_Liens_Ins.Files.FILE_SPRAY+'_2';
pathFile				:= PRTE2_Liens_Ins.Constants.SourcePathForCSV;

MainSort := SORT(MainDups,tmsid,rmsid,orig_filing_date);
PartySort := SORT(PartyDups,tmsid,rmsid,date_first_seen);
OUTPUT(CHOOSEN(PartySort,2000),NAMED('Duped_Party_Records'));
OUTPUT(CHOOSEN(MainSort,2000),NAMED('Duped_Main_Records'));
PRTE2_Common.DesprayCSV(MainSort, TempCSV1, LandingZoneIP, pathFile+desprayNameMain);
PRTE2_Common.DesprayCSV(PartySort, TempCSV2, LandingZoneIP, pathFile+desprayNameParty);
