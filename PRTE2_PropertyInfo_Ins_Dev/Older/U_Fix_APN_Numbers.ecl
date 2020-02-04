/* **********************************************************************************
Despray and run thru a process to fix some of the APN numbers that looks pretty ugly

********************************************************************************** */

IMPORT PRTE2_Common, ut;
IMPORT PRTE2_PropertyInfo_Ins as PII;
IMPORT PRTE2_Common as Common;

#workunit('name', 'ALPHA PRCT PropertyInfo Despray');

Layouts := PRTE2_PropertyInfo_Ins.Layouts;
dateString := PRTE2_Common.Constants.TodayString;
LandingZoneIP 				:= PII.Constants.LandingZoneIP;
TempCSV								:= PII.Files.Alpha_Spray_Name;
//---------------------------------------------------------------------
Pick1(STRING s1,STRING s2) := IF(s1='',s2,s1);
appendIFDot2(STRING s1,STRING s2) := IF(TRIM(s1)<>'' AND TRIM(S2)<>'', TRIM(s1)+'.'+TRIM(s2),Pick1(s1,s2));
appendIFDot4(STRING s1,STRING s2,STRING s3,STRING s4) := appendIFDot2(appendIFDot2(s1,s2),appendIFDot2(s3,s4));

GETSRC(STRING S1) := IF(S1='D', 'FARES', 'OKCTY');
isBlank(STRING Val) := TRIM(Val)='' OR TRIM(Val)='0';
checkFixSrc(STRING Value, STRING VSrc) := IF(isBlank(Value), '', GETSRC(VSrc));
checkFixSrcPct(udecimal5_2 Value, STRING VSrc) := IF(Value=0, '', GETSRC(VSrc));
//---------------------------------------------------------------------

Layouts.AlphaPropertyCSVRec spreadsheet_clean(Layouts.AlphaPropertyCSVRec L) := TRANSFORM
		cleanAddress	:= Common.Clean_Address.FromLine(L.property_street_address, L.p_city_name, L.st, L.zip, L.zip4);
		hasProblem1 := STD.STR.Find(TRIM(L.fares_unformatted_apn),' .') + STD.STR.Find(TRIM(L.fares_unformatted_apn),'. ') > 0;
		hasProblem2 := hasProblem1 AND STD.STR.Find(L.fares_unformatted_apn,'-') >0;
		hasProblem3 := STD.STR.Find(TRIM(L.fares_unformatted_apn),' ') >0;
		someProblem := hasProblem1 or hasProblem2 or hasProblem3;
		ridString := (STRING)L.Property_Rid;
		apnTmp := appendIFDot4(ridString[1..3],cleanAddress.cart,cleanAddress.lot,cleanAddress.fips_county)+cleanAddress.geo_long[3..];
		fixedAPN0 := STD.STR.FindReplace(TRIM(L.fares_unformatted_apn),'.-','-');
		fixedAPN1 := STD.STR.FindReplace(fixedAPN0,'-.','-');
		fixedAPN2 := STD.STR.FindReplace(fixedAPN1,' ','-');
		fixedAPN3 := STD.STR.FindReplace(fixedAPN2,'--','-');
		fixedAPN4 := STD.STR.FindReplace(fixedAPN3,'.-','-');
		fixedAPN5 := STD.STR.FindReplace(fixedAPN4,'-.','-');
		fixedAPN := STD.STR.FindReplace(fixedAPN5,'--','-')[1..25];
		fix1 := IF(hasProblem1,apnTmp,L.fares_unformatted_apn);
		fix2 := IF(hasProblem2,fixedAPN,L.fares_unformatted_apn);
		fix3 := IF(hasProblem3,fixedAPN,L.fares_unformatted_apn);
		fixFinal := IF(hasProblem2,fix2,IF(hasProblem1,fix1,fix3));
		SELF.fares_unformatted_apn := IF(someProblem,fixFinal,L.fares_unformatted_apn);
		hasAPNN := L.apn_number <> '';
		SELF.apn_number := IF(hasAPNN and someProblem,fixFinal,L.apn_number);
		SELF := L;
END;
// desprayName 							:= 'PropertyInfo_V3_AfterAdds1_'+dateString+'.csv';
// EXPORT_DS 								:= SORT(PII.Files.PII_ALPHA_BASE_SF_DS,property_rid);
desprayName 							:= 'PropertyInfo_V3_AfterAdds2_'+dateString+'.csv';
EXPORT_DS 								:= SORT(PROJECT(PII.Files.PII_ALPHA_BASE_SF_DS,spreadsheet_clean(LEFT)),property_rid);
//---------------------------------------------------------------------
lzFilePathFile	:= PII.Constants.SourcePathForPIICSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathFile);

