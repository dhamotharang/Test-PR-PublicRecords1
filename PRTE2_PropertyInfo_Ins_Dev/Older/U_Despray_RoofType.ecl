//---------------------------------------------------------------------
// PRTE2_PropertyInfo_Ins_Dev.U_Despray_RoofType
//  - despray the Property Info base file for editing.
//---------------------------------------------------------------------
// NOTE: The CSV name "PropertyInfo_V2" is to indicate we totally altered
//  the main layouts removed gateway and editable_spreadsheet layouts
//---------------------------------------------------------------------

IMPORT PRTE2_Common, ut, PRTE2_PropertyInfo_Ins_Dev, PRTE2_PropertyInfo_Ins;
#workunit('name', 'ALPHA CT PropInfo RoofType Gen');

dateString := ut.GetDate;
LandingZoneIP  := PRTE2_PropertyInfo_Ins.Constants.LandingZoneIP;
TempCSV  := PRTE2_PropertyInfo_Ins.Files.Alpha_Spray_Name;
//----------- Prepare the Alpharetta Export_DS desired ----------------
desprayName := 'PropertyInfo_V3_Prod_GENERATED3_'+dateString+'.csv';

//---------------------------------------------------------------------
// if we spray Nancy's changed data into DEV - then that is the latest data ...
//      we can then read that data, and modify it from Dev and then spray final data into Prod.
//---------------------------------------------------------------------
// DS_IN := SORT(PRTE2_PropertyInfo_Ins.Files.PII_ALPHA_BASE_SF_DS_PROD,st);
DS_IN := SORT(PRTE2_PropertyInfo_Ins.Files.PII_ALPHA_BASE_SF_DS,st);
// Technically if we do exactly 33% of all records that should be the same as by state but just to be safe...
DS_IN_GRP := GROUP(DS_IN,st);
//---------------------------------------------------------------------
GETSRC(STRING S1) := IF(S1='D','FARES','OKCTY');
//--------------------------------------------
DS_IN_GRP transfrmIN2( DS_IN_GRP L, INTEGER CNT ) := TRANSFORM
			tempVendorSrc := L.vendor_source;
			TempRoofType := IF(CNT=1,PRTE2_PropertyInfo_Ins_Dev.Despray_RoofType_Sets.ROOF_TYPE_RANDOM(tempVendorSrc),'');
			SELF.roof_type:= TempRoofType;
			SELF.src_roof_type:= IF(TempRoofType<>'',GETSRC(tempVendorSrc),'');
			SELF := L;
END;
//---------------------------------------------------------------------
EXPORT_DS := UNGROUP(PROJECT(DS_IN_GRP,transfrmIN2(LEFT,COUNTER%3)));
OUTPUT(CHOOSEN(EXPORT_DS,1000));

lzFilePathGatewayFile  := PRTE2_PropertyInfo_Ins.Constants.SourcePathForPIICSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);

/* ******************************************************************************************
to review the base file data after spraying and building

PRTE2_PropertyInfo_Ins.Files.PII_ALPHA_BASE_SF_DS;
W20170427-173454 – just a quick review on the base file.
	newStuff := PRTE2_PropertyInfo_Ins.Files.PII_ALPHA_BASE_SF_DS(roof_type<>'');
	num := COUNT(newStuff);
	OUTPUT(num);
	OUTPUT(newStuff);

to review the key file data after spraying and building
W20170427-173103 – reads the RID key and displays:
	PRTE2_PropertyInfo_Ins_Dev.BWR_View_Address_In_Keys.ecl
	1.	Has Roof_type and OKC only
	2.	Has Roof_type and FARES ONLY
	3.	All records to see blanks as well.
****************************************************************************************** */