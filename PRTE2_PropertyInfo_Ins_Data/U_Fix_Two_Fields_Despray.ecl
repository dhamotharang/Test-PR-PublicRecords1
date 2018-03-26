// EXPORT U_Fix_Two_Fields_Despray 
//---------------------------------------------------------------------
// PRTE2_PropertyInfo.BWR_Despray_Base
//  - despray the Property Info base file for editing.
//---------------------------------------------------------------------
// NOTE: The CSV name "PropertyInfo_V2" is to indicate we totally altered
//  the main layouts removed gateway and editable_spreadsheet layouts
//---------------------------------------------------------------------

IMPORT PRTE2_Common, ut;
IMPORT PRTE2_PropertyInfo as PII;
#workunit('name', 'Boca CT PropertyInfo Despray');

dateString := ut.GetDate;
LandingZoneIP 				:= PII.Constants.LandingZoneIP;
TempCSV								:= PII.Files.PII_CSV_FILE + '::' +  WORKUNIT;
//----------- Prepare the Alpharetta Export_DS desired ----------------
desprayName 					:= 'PropertyInfo_V2_Prod_Fix2Fields_'+dateString+'.csv';
DS_IN									:= SORT(PII.Files.PII_ALPHA_BASE_SF_DS_Prod,property_rid);
// The new above expanded Alpha layouts now match the Boca layout below
//---------------------------------------------------------------------
GETSRC(STRING S1) := IF(S1='D','FARES','OKCTY');
//--------------------------------------------
DS_IN transfrmIN2( DS_IN L, INTEGER CNT ) := TRANSFORM		
			SELF.frame_type 		:= IF(CNT=1,PRTE2_PropertyInfo.U_Localized_Averages_Sets.FRAME_RANDOM,'');
			SELF.src_frame_type	:= IF(CNT=1,GETSRC(L.vendor_source),'');
			SELF.fuel_type			:= IF(CNT<>1,PRTE2_PropertyInfo.U_Localized_Averages_Sets.FUEL_TYPE_RANDOM,'');
			SELF.src_fuel_type	:= IF(CNT<>1,GETSRC(L.vendor_source),'');
			SELF := L;
END;
//---------------------------------------------------------------------
EXPORT_DS := PROJECT(DS_IN,transfrmIN2(LEFT,COUNTER%2));
OUTPUT(CHOOSEN(EXPORT_DS,300));
lzFilePathGatewayFile	:= PII.Constants.SourcePathForPIICSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);


//---------------------------------------------------------------------
// OBSOLETE - we previously had the "gateway" layout and the editable (left off code groups 21-85)
// Now that we transformed all those code groups into actual field values, we just use the main "expanded" file layout (above)
// PII_Base_SF_DS				:= PII.Files.PII_ALPHA_BASE_SF_DS_Prod;
// EXPORT_DS 						:= PROJECT(PII_Base_SF_DS,PII.Transforms.Gateway_Reduce(LEFT));
//---------------------------------------------------------------------

