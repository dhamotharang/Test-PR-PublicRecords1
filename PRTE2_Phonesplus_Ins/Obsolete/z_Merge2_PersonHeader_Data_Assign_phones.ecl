IMPORT PRTE2_Phonesplus_Ins, PRTE2_Header_Ins, ut, PRTE2_Common,PRTE2_Common_DevOnly;
// *** Same as PRTE2_Phonesplus_Ins.z_Merge_PersonHeader_Data_3 except all cell phones not every 5th ***
// Phase 3 - Assign Cell Phone Numbers for every record.
//           (homephone numbers came from the alpha person header base)

#workunit('name', 'Boca CT Header Despray');

STRING fileVersion := ut.GetDate+'';
xdate	:= ut.GetDate;
CSV_NAME := 'PhonesPlus_Alpha_New_Export_'+xdate+'.csv';

DSPLayout := PRTE2_Phonesplus_Ins.Layouts.Alpha_CSV_Layout;

DSP := PRTE2_Phonesplus_Ins.Files.PhonesPlus_Base_SF_DS;
DSH := PRTE2_Header_Ins.files.HDR_BASE_ALPHA_DS;
lzFilePathGatewayFile	:= PRTE2_Phonesplus_Ins.Constants.SourcePathForCSV + CSV_NAME;
TempCSV								:= PRTE2_Phonesplus_Ins.Files.FILE_SPRAY;
// MIN() and MAX(DSH,phone);
// 1005550100 - 1045559020
PhoneGenerator := PRTE2_Common_DevOnly.Fake_Phones('1115550100');
DSP XForm (DSP L, DSP R, CNT) := TRANSFORM
	SELF.cellphone			:= PhoneGenerator.String10NextPhone(L.cellphone);
	SELF := R;
END;

NEXTDS := ITERATE(DSP,XForm(LEFT,RIGHT,COUNTER));
EXPORT_DS := SORT(NEXTDS,l_did);
sprayIt := PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, PRTE2_Phonesplus_Ins.Constants.LandingZoneIP, lzFilePathGatewayFile);
writeIt := OUTPUT(EXPORT_DS,,TmpFN,overwrite);
SEQUENTIAL(sprayIt, writeIt);
