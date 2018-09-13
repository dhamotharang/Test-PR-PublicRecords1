/* ************************************************************************************************
PRTE2_BIPV2_BusHeader_Ins.Data_Research.BWR_Research_SIC_NAICS
W20180817-144727
************************************************************************************************ */

IMPORT PRTE2_BIPV2_BusHeader_Ins, PRTE2_BIPV2_BusHeader_Ins.Data_Research, PRTE2_Common_DevOnly, PRTE2_Common;

DSAll := PRTE2_BIPV2_BusHeader_Ins.Data_Research.Files.BIPHeaderKeyLinkIDsLiveView;

DS_Sic_Naics := DSAll(TRIM(sic_code)<>'' AND TRIM(naics_code)<>'');
OUTPUT(COUNT(DS_Sic_Naics),NAMED('C_DS_Sic_Naics'));
OUTPUT(DS_Sic_Naics,NAMED('DS_Sic_Naics'));
DS_Sic_NaicsDIST := DISTRIBUTE(DS_Sic_Naics,HASH(sic_code,naics_code));
DS_Sic_NaicsDedup := DEDUP(SORT(DS_Sic_NaicsDIST,sic_code,naics_code,LOCAL),sic_code,naics_code,LOCAL);
OUTPUT(COUNT(DS_Sic_NaicsDedup),NAMED('C_DS_Sic_NaicsDedup'));
OUTPUT(DS_Sic_NaicsDedup,NAMED('DS_Sic_NaicsDedup'));


EXPORT_DS1	  := PROJECT(DS_Sic_NaicsDedup,PRTE2_BIPV2_BusHeader_Ins.Data_Research.Layouts.Sic_NAICS_Layout);
OUTPUT(EXPORT_DS1,,PRTE2_BIPV2_BusHeader_Ins.Data_Research.Files.sic_naics_Study_Name+'1');
// That OUTPUT creates PRTE2_BIPV2_BusHeader_Ins.Data_Research.Files.sic_naics_StudyDS1;

// SICLOOKUP 		:= PRTE2_BIPV2_BusHeader_Ins.Data_Research.Files.SIC4_Lookup_Base;
// NAICSLOOKUP 	:= PRTE2_BIPV2_BusHeader_Ins.Data_Research.Files.NAICS_Base;
// EXPORT_DS2 		:= join(EXPORT_DS1,SICLOOKUP,
												// LEFT.sic_code = RIGHT.sic4_code,
														// TRANSFORM({EXPORT_DS1},
														// SELF.SIC_Desc := RIGHT.sic4_description,
														// SELF := LEFT)
										// ,left outer
										// );
// EXPORT_DS 		:= join(EXPORT_DS2,NAICSLOOKUP,
												// LEFT.naics_code = RIGHT.naics_code,
														// TRANSFORM({EXPORT_DS2},
														// SELF.NAICS_Desc := RIGHT.naics_description,
														// SELF := LEFT)
										// ,left outer
										// );
// OUTPUT(COUNT(EXPORT_DS),NAMED('EXPORT_DS'));

// fileVersion := PRTE2_Common.Constants.TodayString+'';
// TempCSV			:= '~prct::research::bipv2::business_header_' +  WORKUNIT;
// Constants := PRTE2_BIPV2_BusHeader_Ins.Data_Research.Constants;
// desprayName 		:= 'BIPHeader_SIC4_to_NAICS_'+fileVersion+'.csv';
// LandingZoneIP 	:= PRTE2_Common.Constants.InsLandingZone;
// lzFilePathGatewayFile	:= Constants.SourcePathForCSV + desprayName;

// PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);