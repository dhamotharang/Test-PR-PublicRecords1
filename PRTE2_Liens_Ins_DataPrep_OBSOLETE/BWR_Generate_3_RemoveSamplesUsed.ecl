/* ************************************************************************************
PRTE2_Liens_Ins_DataPrep.BWR_Generate_3_RemoveSamplesUsed

*******************************  WIP!!! ********************************************
Follow up on BWR_Generate_2_From_IHDR_Records and remove records generated from the Prod Samples
so that samples can be reused again but not duplicate the sample data.


************************************************************************************ */

IMPORT PRTE2_Liens_Ins_DataPrep, PRTE2_Common, LiensV2_preprocess, PRTE2_Liens_Ins, PRTE2_X_Ins_DataCleanse, STD, ut, Address;



/*		Move this into separate post-process
//---------------------------------------------------------- perform maintenance on the production samples
ProdRemainParty := JOIN(PartyBocaHit_All,GatheredParties,				// remove both hits and no hits used.
											LEFT.joinint = RIGHT.joinint,
													TRANSFORM({GatheredParties},
														SELF := RIGHT),
											RIGHT ONLY);
ProdRemainMain := JOIN(MainRelated,GatheredMains,				// remove both hits and no hits used.
											LEFT.joinint = RIGHT.joinint,
													TRANSFORM({GatheredMains},
														SELF := RIGHT),
											RIGHT ONLY);

OUTPUT(ProdRemainParty,NAMED('PartyRemain'));	//
OUTPUT(ProdRemainMain,NAMED('MainRemain'));	//
OUTPUT(COUNT(GatheredParties)+' and '+COUNT(ProdRemainParty),NAMED('CNTPartyRemain'));
OUTPUT(COUNT(GatheredMains)+' and '+COUNT(ProdRemainMain),NAMED('CNTMainRemain'));


// PromoteSupers.Mac_SF_BuildProcess(SORT(Party_F,tmsid), Files.Save_ProdParty_Name, buildBase1,2);
// PromoteSupers.Mac_SF_BuildProcess(Main_F, Files.Save_ProdMain_Name, buildBase2,2);
*/