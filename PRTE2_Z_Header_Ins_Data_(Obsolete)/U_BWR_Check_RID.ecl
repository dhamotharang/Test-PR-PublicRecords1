/* ************************************************************************************
PRTE2_Header_Ins_Data_Work.U_BWR_Check_RID
Quick view of the MERGED HDR file to spot any DUP RIDS.
************************************************************************************ */
Import PRTE2_Alpha_Data,PRTE2_Header_Ins;

// IHDR_Chosen := SORT(PRTE2_Alpha_Data.Files_Alpha.PS_Merged_Headers_DS,did);
IHDR_Chosen := SORT(PRTE2_Header_Ins.Files.HDR_BASE_ALPHA_DS,did);
IHDRSort    := SORT(IHDR_Chosen,rid);
IHDRDedup  := DEDUP(IHDRSort,rid);

R1 := RECORD
		// IHDR_Chosen.did;
		IHDR_Chosen.rid;
		rid_duplicates := COUNT(GROUP);
END;
T1 := TABLE(IHDR_Chosen, R1,  rid);

OUTPUT(choosen(T1(rid_duplicates>1),5000));

// SrchSET := [3359,3530,3639,4035,4826];
// OUTPUT(SORT(IHDR_Chosen(rid in SrchSET),did,rid));