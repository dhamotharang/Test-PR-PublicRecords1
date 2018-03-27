// Despray the LNProperty file for Alpharetta but during the despray, fix some of the code fields
// the stringLib.findString didn't work first try in the join so we MIGHT have some name dup problems, don't have time to experiment

IMPORT PRTE2_LNProperty as LNP;
IMPORT PRTE2_Common, ut;
IMPORT prte_csv,PRTE2_Header_Ins;

#workunit('name', 'Boca CT LNProperty Despray');

dateString	:= ut.GetDate;
HeaderDS := PRTE2_Header_Ins.Files.HDR_BASE_ALPHA_DS;

LNP.Layouts_V2.LN_spreadsheet U_Fix_HDR_Fields_Xform(Layouts_V2.LN_spreadsheet L, HeaderDS R) := TRANSFORM
		SELF.ssn := (STRING)R.ssn;
		SELF.did := (STRING)R.did;
		SELF.dob := (STRING)R.dob;
		SELF  := L;
		SELF  := [];
END;

TempCSV							:= LNP.Files.LNP_CSV_FILE + '::' +  WORKUNIT;
LandingZoneIP 			:= LNP.Constants.LandingZoneIP;

desprayName 				:= 'LN_Property_HDRFix_DEV_V3_'+dateString+'.csv';
LNP_Base_SF_DS			:= LNP.Files.LNP_Scramble_SF_DS;

EXPORT_DS 					:= JOIN(LNP_Base_SF_DS, HeaderDS
													,LEFT.fname = RIGHT.fname 
														AND LEFT.lname = RIGHT.lname
														AND LEFT.st = RIGHT.st
														// AND stringlib.stringfind(LEFT.address,RIGHT.prim_name,1) > 0
													,U_Fix_HDR_Fields_Xform(LEFT,RIGHT)
													,LEFT OUTER
													);

lzFilePathGatewayFile	:= LNP.Constants.SourcePathForLNPCSV + desprayName;
PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);