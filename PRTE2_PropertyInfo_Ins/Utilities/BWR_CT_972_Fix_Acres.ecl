/* **********************************************************************************
PRTE2_PropertyInfo_Ins.Utilities.BWR_Fix_acres_asterisks
Linked to defect ticket CT-972 for Property Data - Acres asterisk.
********************************************************************************** */

IMPORT PRTE2_Common, STD;
IMPORT PRTE2_PropertyInfo_Ins as PII;
#workunit('name', 'ALPHA PRCT PropertyInfo Despray');

dateString := PRTE2_Common.Constants.TodayString;
LandingZoneIP 				:= PII.Constants.LandingZoneIP;
TempCSV								:= PII.Files.Alpha_Spray_Name;
//----------- Prepare the Alpharetta Export_DS desired ----------------
desprayName 							:= 'PropertyInfo_V3_Prod_'+dateString+'.csv';
EXPORT_DS0									:= SORT(PII.Files.PII_ALPHA_BASE_SF_DS_Prod,property_rid);
//---------------------------------------------------------------------
// NOTE: The following is temporary - BC2.1 Data3 will give better fields to fill.
//---------------------------------------------------------------------
appendIfCSZ := PRTE2_Common.Functions.appendIfCSZ;
EXPORT_DS := PROJECT(EXPORT_DS0, 
								TRANSFORM({EXPORT_DS0},
										// had to go in steps because one line was breaking the final value.
										testVal0 := TRIM(LEFT.lot_size,LEFT,RIGHT);
										lotIsBlank := testVal0 = '';
										lotIsAstks := STD.Str.Contains(testVal0,'****',TRUE);
										acIsAstks := STD.Str.Contains(LEFT.acres,'****',TRUE);
										lotInvalid := lotIsBlank or lotIsAstks;
										testVal1 := IF(lotInvalid, '', testVal0);
										testVal := STD.Str.GetNthWord(testVal1,1);
										testAcres := (ABS((INTEGER)testVal)) / 45000.0;
										testAcZero := testAcres = 0;
										calcAcres := TRIM(REALFORMAT(testAcres,14,4),LEFT,RIGHT);
										CompAcres := IF(lotInvalid OR testAcZero,'',calcAcres);
										SELF.acres := IF(acIsAstks,CompAcres,LEFT.acres);
										// SELF.tax_dt_location_influence_code := IF(acIsAstks,LEFT.acres,'');  //just for spotting changed records for audit
										SELF.property_city_state_zip := appendIfCSZ(LEFT.v_city_name,LEFT.st,LEFT.zip);
										SELF := LEFT;
								));
/* **********************************************************************************
Update asterisks and negative numbers in the Acres field (column FM) based on the following formula
If lot size (col FY) > 0, acres = Lot size/45,000
If lot size =blank, acres = blank
Limit acres to <=4 decimal points 
If lot size =negative, then make lot size and acres positive.
********************************************************************************** */								
//---------------------------------------------------------------------
lzFilePathFile	:= PII.Constants.SourcePathForPIICSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathFile);

