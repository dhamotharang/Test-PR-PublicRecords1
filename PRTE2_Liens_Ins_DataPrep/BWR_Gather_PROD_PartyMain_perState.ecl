/* ************************************************************************************************************
PRTE2_Liens_Ins_DataPrep.BWR_Gather_PROD_PartyMain_perState
NOTE: for purposes of just doing data prep and research, I am only using 2 generations of SFs

This should gather a Party with potentially multiple Party with 1 DID, each of which should have the same JoinInt
The Main file has JoinInt but I think it's pointless since they join on the tmsid

A merging program should be able to take IHDR records and join on these by JoinInt + State and merge those with the fake people (still need PII removed)
Then join on tmsid to create new main records to go with those Party records tied to fake people.
Final steps are to replace tmsids and other PII fields without breaking the Party/Main joins.

****************** ?????????????  Maybe should ask Terri if specific types (sources) of Lien data is better
	Different sources have different rules on the tmsid -> rmsid formatting, etc.
************************************************************************************************************ */
IMPORT PRTE2_Liens_Ins_DataPrep,PRTE2_Common,LiensV2,PromoteSupers;

Layouts 	:= PRTE2_Liens_Ins_DataPrep.Layouts;
Files			:= PRTE2_Liens_Ins_DataPrep.Files;
howMany := 500;		// how many cases per state
Add_Foreign_prod	:= PRTE2_Common.Constants.Add_Foreign_prod;
ReadOnly_Prod_SF_PartyKName	:= Add_Foreign_prod('thor_data400::key::liensv2::party::tmsid.rmsid_qa');
ReadOnly_Prod_SF_MainKName		:= Add_Foreign_prod('thor_data400::key::liensv2::main::tmsid.rmsid_qa');
ReadOnly_Prod_SF_PartyDidKName := Add_Foreign_prod('thor_data400::key::liensv2::did_qa');

Partydid := INDEX(LiensV2.key_liens_DID,ReadOnly_Prod_SF_PartyDidKName);
PartyKey := INDEX(LiensV2.key_liens_party_ID,ReadOnly_Prod_SF_PartyKName);
Main	:=	INDEX(LiensV2.key_liens_main_ID_FCRA,ReadOnly_Prod_SF_MainKName);				
// s/b valid DID, try to get some recent ones, and no company names (people desired)
Party_DS := PartyKey((INTEGER)did>0 AND date_vendor_last_reported[1..4] > '2010' AND cname='' );
OUTPUT(SORT(Party_DS,tmsid),NAMED('Party_Records00'));
Party_0 := CHOOSESETS(Party_DS,
							 st='AK'=>howMany,st='AL'=>howMany,st='AR'=>howMany,st='AZ'=>howMany,st='CA'=>howMany,st='CO'=>howMany,
							 st='CT'=>howMany,st='DC'=>howMany,st='DE'=>howMany,st='FL'=>howMany,st='GA'=>howMany,st='HI'=>howMany,
							 st='IA'=>howMany,st='ID'=>howMany,st='IL'=>howMany,st='IN'=>howMany,st='KS'=>howMany,st='KY'=>howMany,
							 st='LA'=>howMany,st='MA'=>howMany,st='MD'=>howMany,st='ME'=>howMany,st='MI'=>howMany,st='MN'=>howMany,
							 st='MO'=>howMany,st='MS'=>howMany,st='MT'=>howMany,st='NC'=>howMany,st='ND'=>howMany,st='NE'=>howMany,
							 st='NH'=>howMany,st='NJ'=>howMany,st='NM'=>howMany,st='NV'=>howMany,st='NY'=>howMany,st='OH'=>howMany,
							 st='OK'=>howMany,st='OR'=>howMany,st='PA'=>howMany,st='RI'=>howMany,st='SC'=>howMany,st='SD'=>howMany,
							 st='TN'=>howMany,st='TX'=>howMany,st='UT'=>howMany,st='VA'=>howMany,st='VT'=>howMany,st='WA'=>howMany,
							 st='WI'=>howMany,st='WV'=>howMany,st='WY'=>howMany, 0);
OUTPUT(SORT(Party_0,tmsid),NAMED('Party_Records0'));
PSet0 := SET(Party_0,(unsigned6)did);	
Party_1 := Partydid(did in PSet0);
PSet := SET(Party_1,tmsid);
Party_2 := PartyKey(tmsid IN pSet AND (unsigned6)did <> 0 AND TRIM(cname)='');
Main_2 := Main(tmsid IN pSet);
OUTPUT(COUNT(Party_0));
OUTPUT(COUNT(Party_1));
OUTPUT(COUNT(Party_2));
OUTPUT(COUNT(Main_2));
OUTPUT(SORT(Party_2,tmsid),NAMED('Party_Records'));
OUTPUT(SORT(Main_2,tmsid),,NAMED('Main_Records'));
// Number JOININT by state because we want to match IHDR states to test case states
// PROBLEM - there are multiple party with the same DID

//WIP???  Dedup to 1 rec per Lexid, then numbers the deduped records after initial?
Party_2_a := PROJECT(Party_2,TRANSFORM(Layouts.BasePartyInJoin,SELF.JoinInt := COUNTER,SELF := LEFT));
// PartyJoinable := PROJECT(Party_2,TRANSFORM(Layouts.BasePartyInJoin,SELF.JoinInt := COUNTER, SELF := LEFT));
												
Party_2_1did := DEDUP(SORT(Party_2_a,did),did);
SetSelected := SET(Party_2_1did,JoinInt);
Party_2_remaining := Party_2_a(JoinInt not in SetSelected);		// if too many for the set we'll have to rewrite with a left only join.

// Number the single DID records 1-n per state
Party_2_G := GROUP(SORT(Party_2_1did,st),st);
Layouts.BasePartyInJoin	trxParty(Party_2_G L,INTEGER cnt) := TRANSFORM
		SELF.JoinInt := cnt;
		SELF := L;
		SELF := [];
END;
Party_3_UG := UNGROUP(PROJECT(Party_2_G,trxParty(LEFT,COUNTER)));
// now assign the same JoinInt to any multiple party records (remaining) with matching DIDs 
// there may be Party_3_UG records with no matching Party_2_remaining, 
//     but every record in Party_2_remaining should have a match in Party_3_UG
Party_3_Remain := JOIN(Party_2_remaining ,Party_3_UG,
										LEFT.did = RIGHT.did,
										TRANSFORM({Party_2_remaining},SELF.JoinInt := RIGHT.JoinInt, SELF := LEFT),
										LEFT OUTER);
OUTPUT(COUNT(Party_2_remaining)+' and '+COUNT(Party_3_Remain));
PartyJoinable := SORT(Party_3_UG+Party_3_Remain,st,joinint);
OUTPUT(COUNT(Party_2)+' and '+COUNT(PartyJoinable));

bangIF(STRING S1) := IF(TRIM(S1)='','',' !'+S1);
appendFSFields(STRING S1, STRING S2) := IF(TRIM(S1)='',' '+S2,S1+bangIF(S2));

// I think JOININT is wasted on the main - we'll map on the tmsid
MainJoinable := SORT(PROJECT(Main_2,TRANSFORM(Layouts.BaseMainInJoin,
																	SELF.JoinInt := COUNTER, 
																	SELF.Filing_status := LEFT.Filing_status[1].Filing_status+' !'+LEFT.Filing_status[1].Filing_status_desc,
																	SELF := LEFT, SELF := []))
											,tmsid);
Party_F := DISTRIBUTE(SORT(PartyJoinable,st),hash32(st));
Main_F 	:= DISTRIBUTE(MainJoinable,hash32(tmsid));
		
PromoteSupers.Mac_SF_BuildProcess(SORT(Party_F,tmsid), Files.Save_ProdParty_Name, buildBase1,2);
PromoteSupers.Mac_SF_BuildProcess(Main_F, Files.Save_ProdMain_Name, buildBase2,2);
SEQUENTIAL(buildBase1,buildBase2);
OUTPUT(Files.Save_ProdParty_DS);
OUTPUT(Files.Save_ProdMain_DS);
