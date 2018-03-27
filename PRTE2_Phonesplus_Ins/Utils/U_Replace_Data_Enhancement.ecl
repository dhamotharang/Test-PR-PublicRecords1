/* --------------------------------------------------------------------------------
  PRTE2_Phonesplus_Ins.U_Replace_Data_Enhancement
  This is to enhance the data field that Aaron suggested we fix
			GLB_DPPA_FLAG - always populate with a "G"
			ACTIVEFLAG - always populate with BLANK ""
			CONFIDENCESCORE - always populate with 11 not random score
W20160526-120838 - run to convert data via despray, then sprayed into Dev and Prod
  -------------------------------------------------------------------------------- */

IMPORT ut, PRTE2_Phonesplus_Ins, PRTE2_Common;
#workunit('name', 'Boca PRTE2 PhonesPlus Despray');

dateString			:= ut.GetDate;

desprayName := 'PhonesPlus_Aaron_enhance_'+dateString+'.csv';
// --------------------------------------------------------
EXPORT_DS0		:=	SORT(PRTE2_Phonesplus_Ins.Files.PhonesPlus_Base_SF_DS_PROD,l_did); //Prod file.
// --------------------------------------------------------
EXPORT_DS0 xForm1( EXPORT_DS0 L, INTEGER CNTR) := TRANSFORM
	SELF.GLB_DPPA_FLAG := 'G';
	SELF.ACTIVEFLAG := '';
	SELF.CONFIDENCESCORE := 11;
	SELF := L;
END;
EXPORT_DS1 := PROJECT( EXPORT_DS0, xForm1(LEFT,COUNTER) );
EXPORT_DS	:= SORT(EXPORT_DS1,l_did);
// --------------------------------------------------------
OUTPUT(EXPORT_DS);
OUTPUT(COUNT(EXPORT_DS0));
OUTPUT(COUNT(EXPORT_DS));
// ----------------------------

// --------------------------------------------------------------------------------
LandingZoneIP 	:= PRTE2_Phonesplus_Ins.Constants.LandingZoneIP;
TempCSV					:= PRTE2_Phonesplus_Ins.Files.FILE_DESPRAY_CSV + '::' +  WORKUNIT;
lzFilePathGatewayFile	:= PRTE2_Phonesplus_Ins.Constants.SourcePathForCSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);
