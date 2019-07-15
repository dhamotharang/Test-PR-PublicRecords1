/* ************************************************************************************
PRTE2_Gong_Ins.Proc_Build_Compatible_Base
	Not much here because we controlled the names of our common fields to avoid transform complexity.

This will transform the Alpha CSV layout base file into a base file compatible with Boca Builds.
************************************************************************************ */

IMPORT PRTE2_Common,PromoteSupers;

EXPORT Proc_Build_Compatible_Base := FUNCTION

		AlphaNewBase := Files.Gong_Base_CSV_DS;			// CRITICAL - the fn_Spray has to commit this first.
		AppendIF3 := PRTE2_Common.Functions.AppendIF3;

		newConvertedBase := PROJECT(AlphaNewBase,
														TRANSFORM({Layouts.Boca_Base_Layout},
														SELF.cust_name := LEFT.xSponsor,
														SELF.bug_num := LEFT.xBug_Num,
														SELF.listed_name := AppendIF3(LEFT.name_first,LEFT.name_middle,LEFT.name_last);
														SELF := LEFT;
														));


		PromoteSupers.Mac_SF_BuildProcess(newConvertedBase, Files.Gong_Base_SF, BuildBCBase);
		
		RETURN SEQUENTIAL(BuildBCBase);
END;