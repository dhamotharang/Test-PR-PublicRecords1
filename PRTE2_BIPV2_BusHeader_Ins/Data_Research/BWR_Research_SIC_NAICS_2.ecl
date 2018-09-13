/* ************************************************************************************************
PRTE2_BIPV2_BusHeader_Ins.Data_Research.BWR_Research_SIC_NAICS_2

After further research - they have junk codes in the naics_code column.   We can't use this.
************************************************************************************************ */

IMPORT PRTE2_BIPV2_BusHeader_Ins, PRTE2_BIPV2_BusHeader_Ins.Data_Research,std;

// Codes.File_SIC4_Codes;
// Codes.File_NAICS_Codes;
// Codes.Key_SIC4;
// Codes.Key_NAICS;

EXPORT_DS0 := PRTE2_BIPV2_BusHeader_Ins.Data_Research.Files.sic_naics_StudyDS1;
EXPORT_DS0b := EXPORT_DS0((INTEGER)naics_code<>0 AND naics_code<>'000001');
EXPORT_DS0c := EXPORT_DS0b(std.Str.find(naics_code,'/')=0);
EXPORT_DS1 := EXPORT_DS0c((STRING)(INTEGER)naics_code = naics_code);
COUNT(EXPORT_DS1);

OUTPUT(EXPORT_DS1,NAMED('EXPORT_DS1'));
CHOOSEN(EXPORT_DS1(sic_code[1..2]='07'),500);
CHOOSEN(EXPORT_DS1(sic_code='0115'),500);

SICLOOKUP 		:= PRTE2_BIPV2_BusHeader_Ins.Data_Research.Files.SIC4_Lookup_Base;
NAICSLOOKUP 	:= PRTE2_BIPV2_BusHeader_Ins.Data_Research.Files.NAICS_Base;
EXPORT_DS2 		:= join(EXPORT_DS1,SICLOOKUP,
												LEFT.sic_code = RIGHT.sic4_code,
														TRANSFORM({EXPORT_DS1},
														SELF.SIC_Desc := RIGHT.sic4_description,
														SELF := LEFT)
										,left outer
										);
OUTPUT(SICLOOKUP,NAMED('SICLOOKUP'));
OUTPUT(EXPORT_DS2,NAMED('EXPORT_DS2'));
// ckout := ['0723','0742','0752','0762','0781','0782'];
// OUTPUT(EXPORT_DS2(sic_code in ckout),NAMED('EXPORT_DS2xx'));
										
EXPORT_DS3 		:= join(EXPORT_DS2,NAICSLOOKUP,
												(INTEGER)LEFT.naics_code = (INTEGER)RIGHT.naics_code,
														TRANSFORM({EXPORT_DS2},
														SELF.naics_desc := RIGHT.naics_description,
														SELF := LEFT)
										,left outer
										);
EXPORT_DS := EXPORT_DS3(naics_desc<>'');
COUNT(EXPORT_DS1(naics_code='111219'));
COUNT(EXPORT_DS(naics_code='111219'));

// The above shows me that they have nonsense naics_codes in here...

OUTPUT(NAICSLOOKUP,NAMED('NAICSLOOKUP'));
OUTPUT(CHOOSEN(EXPORT_DS,1000),NAMED('EXPORT_DS'));
// ckout2 := [115115,212221,311999,321999,325314,333111,339914,339999,442299,444220,445000,446191,448140,452990,484210,511199,531390,541330,561499,722211,722213,812930,813910];
// OUTPUT(EXPORT_DS((INTEGER)naics_code IN Ckout2),NAMED('EXPORT_DSxx'));

// fileVersion := PRTE2_Common.Constants.TodayString+'';
// TempCSV			:= '~prct::research::bipv2::business_header_' +  WORKUNIT;
// Constants := PRTE2_BIPV2_BusHeader_Ins.Data_Research.Constants;
// desprayName 		:= 'BIPHeader_SIC4_to_NAICS_'+fileVersion+'.csv';
// LandingZoneIP 	:= PRTE2_Common.Constants.InsLandingZone;
// lzFilePathGatewayFile	:= Constants.SourcePathForCSV + desprayName;

// PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);