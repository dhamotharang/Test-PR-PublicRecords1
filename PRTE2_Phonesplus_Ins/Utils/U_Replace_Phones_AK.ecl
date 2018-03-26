// --------------------------------------------------------------------------------
//  PRTE2_Phonesplus_Ins.U_Replace_Phones_AK
//  This is for despraying base data to csv file with new phone numbers
// --------------------------------------------------------------------------------

IMPORT ut, PRTE2_Phonesplus_Ins, PRTE2_Common;
#workunit('name', 'Boca PRTE2 PhonesPlus Despray');

dateString			:= ut.GetDate;

desprayName := 'PhonesPlus_AK_Phones_'+dateString+'.csv';
EXPORT_DS0		:=	SORT(PRTE2_Phonesplus_Ins.Files.PhonesPlus_Base_SF_DS_PROD,l_did); //Prod file.
EXPORT_DS1a		:= 	EXPORT_DS0(cellphone[1]='1');
EXPORT_DS1b		:=	EXPORT_DS0(cellphone[1]<>'1');
OUTPUT(COUNT(EXPORT_DS1b));
// --------------------------------------------------------------------------------
CellPhones := PRTE2_Phonesplus_Ins.U_Alaska_Phones('Y','9072000000');
HomePhones := PRTE2_Phonesplus_Ins.U_Alaska_Phones('N','9072120000');
// --------------------------------------------------------
// we had to do iterate where L=previous record so the prev phone assigned becomes the seed for getNextNumber
EXPORT_DS1a xForm1( EXPORT_DS1a L, EXPORT_DS1a R, INTEGER CNTR) := TRANSFORM
	tmpCell := IF(CNTR=1,'',L.cellphone);
	SELF.cellphone := CellPhones.String10NextPhone(tmpCell);
	SELF := R;
END;
EXPORT_DS1c := ITERATE(EXPORT_DS1a, xForm1(LEFT,RIGHT,COUNTER) );
EXPORT_DS2	:= SORT(EXPORT_DS1b+EXPORT_DS1c,l_did);
// --------------------------------------------------------
EXPORT_DS2a		:= 	EXPORT_DS2(homephone[1]='1');
EXPORT_DS2b		:=	EXPORT_DS2(homephone[1]<>'1');
OUTPUT(COUNT(EXPORT_DS2b));
EXPORT_DS0 xForm2( EXPORT_DS2a L, EXPORT_DS2a R, INTEGER CNTR) := TRANSFORM
	tmpHome := IF(CNTR=1,'',L.homephone);
	SELF.homephone := HomePhones.String10NextPhone(tmpHome);
	SELF := R;
END;
EXPORT_DS2c := ITERATE(EXPORT_DS2a, xForm2(LEFT,RIGHT,COUNTER) );
EXPORT_DS		:= SORT(EXPORT_DS2b+EXPORT_DS2c,l_did);

OUTPUT(EXPORT_DS);
OUTPUT(COUNT(EXPORT_DS0));
OUTPUT(COUNT(EXPORT_DS));
// ----------------------------

// --------------------------------------------------------------------------------
LandingZoneIP 	:= PRTE2_Phonesplus_Ins.Constants.LandingZoneIP;
TempCSV					:= PRTE2_Phonesplus_Ins.Files.FILE_DESPRAY_CSV + '::' +  WORKUNIT;
lzFilePathGatewayFile	:= PRTE2_Phonesplus_Ins.Constants.SourcePathForCSV + desprayName;

// PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);
