/*  *************************************************************************************************************
Note, this is broken because Kevin says it's hard to define an INDEX layout, and the proper way
to do it is to turn PRTE2_PropertyInfo.NEW_process_build_propertyinfo into a MODULE instead of a FUNCTION
and the export the point at which we define the indexes... then just use that export definition.
*************************************************************************************************************  */
IMPORT PRTE2_PropertyInfo as PII;
IMPORT PRTE2_Common, ut;

PC_Base_Key := RECORD
			PII.Layouts.PC_Base_Layout;
			unsigned8 __internal_fpos__;
END;
KeyName := ut.foreign_prod+'~prte::key::propertyinfo::20140221a::rid';
IDX := index(PC_Base_Key, KeyName);
IDX_DS := pull(IDX)(Property_RID > 0);
output(COUNT(IDX_DS));

output(MAX(IDX_DS,Property_RID));
output(MIN(IDX_DS,Property_RID));
output(CHOOSEN(IDX_DS,1000));

dateString	:= ut.GetDate + '';
desprayName := 'PII_RID_KEY_'+dateString+'.csv';
lzFilePathBaseFile	:= PII.Constants.SourcePathForPIICSV + desprayName;
LandingZoneIP 			:= PII.Constants.LandingZoneIP;
ExportDS 						:= IDX_DS;
TempCSV							:= PII.Files.PII_CSV_FILE + '::' +  WORKUNIT;
// ---------------------------------------------------------------------------------
PRTE2_Common.DesprayCSV(ExportDS, TempCSV, LandingZoneIP, lzFilePathBaseFile);
