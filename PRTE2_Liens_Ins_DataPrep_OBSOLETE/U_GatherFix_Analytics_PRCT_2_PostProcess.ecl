/* *********************************************************************************************
PRTE2_Liens_Ins_DataPrep.U_GatherFix_Analytics_PRCT_2_PostProcess

--- take what was created in U_GatherFix_Analytics_PRCT_2_Main and now join 
* State-Grouped MAIN file
* State-Grouped PARTY file
--- and create final version of party file that is joined to the already created main file.
********************************************************************************************* */

IMPORT PRTE2_Liens_Ins,PromoteSupers, PRTE2_Common;

//***********************************************************************************************
MainFinal := PRTE2_Liens_Ins_DataPrep.Files.Save_MainWIP_DS;
Prim_Party_DS := PRTE2_Liens_Ins_DataPrep.Files.Save_PartyWIP_DS(joinint<>0);
//***********************************************************************************************

Prim_Party_DS trxParty1(MainFinal L, Prim_Party_DS R) := TRANSFORM
		SELF.tmsid := L.tmsid;
		SELF.rmsid := L.rmsid;
		SELF := R;
END;

Party_Ready := JOIN(MainFinal, Prim_Party_DS,
										left.joinint = right.joinint AND left.agency_state = right.st
										,trxParty1(LEFT,RIGHT)
										,INNER);
build_Party := OUTPUT(Party_Ready,, PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Party_File_Final, OVERWRITE);
Party_Final := PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Party_Final_DS;										
out1 := OUTPUT(CHOOSEN(MainFinal,1000));
out2 := OUTPUT(CHOOSEN(Party_Final,1000));
out3 := OUTPUT(COUNT(MainFinal)+'  '+COUNT(Party_Final));

SEQUENTIAL( build_Party, out1, out2, out3 );
// SEQUENTIAL( out1, out2, out3 );

//***********************************************************************************************