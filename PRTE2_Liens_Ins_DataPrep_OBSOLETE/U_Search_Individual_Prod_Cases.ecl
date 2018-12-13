// ********************************************************
// PRTE2_Liens_Ins_DataPrep.U_Search_Individual_Prod_Cases
// ********************************************************

// Party := PRTE2_Liens_Ins_DataPrep.U_Production_Files.ReadOnly_Prod_SF_Party_Key(DID<>'000000000000');
// Main := PRTE2_Liens_Ins_DataPrep.U_Production_Files.ReadOnly_Prod_SF_Main_Key;
IMPORT PRTE2_Common,LiensV2;

Add_Foreign_prod	:= PRTE2_Common.Constants.Add_Foreign_prod;
ReadOnly_Prod_SF_PartyKName	:= Add_Foreign_prod('thor_data400::key::liensv2::party::tmsid.rmsid_qa');
ReadOnly_Prod_SF_MainKName		:= Add_Foreign_prod('thor_data400::key::liensv2::main::tmsid.rmsid_qa');
ReadOnly_Prod_SF_PartyDidKName := Add_Foreign_prod('thor_data400::key::liensv2::did_qa');

Partydid := INDEX(LiensV2.key_liens_DID,ReadOnly_Prod_SF_PartyDidKName);
Party2 := INDEX(LiensV2.key_liens_party_ID,ReadOnly_Prod_SF_PartyKName);
Main	:=	INDEX(LiensV2.key_liens_main_ID_FCRA,ReadOnly_Prod_SF_MainKName);											

Party1 := Partydid(did=000000248624);
PSet := SET(Party1,tmsid);
Party1a := Party2(tmsid IN pSet);
OUTPUT(SORT(Party1,tmsid),NAMED('Party_did_Records'));
OUTPUT(SORT(Party1a,tmsid),NAMED('Party_Records'));
Main1 := Main(tmsid IN pSet);
OUTPUT(SORT(Main1,tmsid),,NAMED('Main_Records'));
													
// Party := INDEX(LiensV2.key_liens_party_ID,ReadOnly_Prod_SF_PartyKName);
// Main := INDEX({Prod_Layout_MainKeyI}, Prod_Layout_MainKeyM, ReadOnly_Prod_SF_MainKName);
// OUTPUT(Party(tmsid='HG0001534282097NYRICC1'),NAMED('Party_Records'));
// OUTPUT(Main(tmsid='HG0001534282097NYRICC1'),NAMED('Main_Records'));
