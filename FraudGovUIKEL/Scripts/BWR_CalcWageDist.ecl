import FraudgovUIKEL;
import std;


EXPORT BWR_CalcWageDist := MODULE
		SHARED ds := FraudgovUIKel.Q__show_Employers.Res0;

		EXPORT fn_macro(dsMac, attributeStr, attribute) := FUNCTIONMACRO
				ds_cnt := COUNT(dsMac);
				RETURN SORT(TABLE(dsMac, {STRING30 attribute_name := attributeStr, STRING30 attribute_value := (STRING)attribute, cnt:=COUNT(GROUP), pct_of_file := COUNT(GROUP)/ds_cnt}, attribute), attribute_value);
		ENDMACRO;

		SHARED ds_BA_WgQtrCntEv := fn_macro(ds, 'BA_WgQtrCntEv', B_A___Wg_Qtr_Cnt_Ev_);
		SHARED ds_BA_QtlyWgsTotA1Qc := fn_macro(ds, 'BA_QtlyWgsTotA1Qc', B_A___Qtly_Wgs_Tot_A1_Qc_);
		SHARED ds_BA_QtlyWgsTotA2Qc := fn_macro(ds, 'BA_QtlyWgsTotA2Qc', B_A___Qtly_Wgs_Tot_A2_Qc_);
		SHARED ds_BA_QtlyWgsTotA3Qc := fn_macro(ds, 'BA_QtlyWgsTotA3Qc', B_A___Qtly_Wgs_Tot_A3_Qc_);
		SHARED ds_BA_QtlyWgsTotA4Qc := fn_macro(ds, 'BA_QtlyWgsTotA4Qc', B_A___Qtly_Wgs_Tot_A4_Qc_);
		SHARED ds_BA_QtlyWgsTotA5Qc := fn_macro(ds, 'BA_QtlyWgsTotA5Qc', B_A___Qtly_Wgs_Tot_A5_Qc_);
		SHARED ds_BA_YrlyWgsTotA1Qc:= fn_macro(ds, 'BA_YrlyWgsTotA1Qc', B_A___Yrly_Wgs_Tot_A1_Qc_);
		SHARED ds_BA_YrlyWgsTotA5Qc:= fn_macro(ds, 'BA_YrlyWgsTotA5Qc', B_A___Yrly_Wgs_Tot_A5_Qc_);
		
		SHARED ds_BA_QtlyEmplCntA1Qc := fn_macro(ds, 'BA_QtlyEmplCntA1Qc', B_A___Qtly_Empl_Cnt_A1_Qc_);
		SHARED ds_BA_QtlyEmplCntA2Qc:= fn_macro(ds, 'BA_QtlyEmplCntA2Qc', B_A___Qtly_Empl_Cnt_A2_Qc_);
		SHARED ds_BA_QtlyEmplCntA3Qc:= fn_macro(ds, 'BA_QtlyEmplCntA3Qc', B_A___Qtly_Empl_Cnt_A3_Qc_);
		SHARED ds_BA_QtlyEmplCntA4Qc:= fn_macro(ds, 'BA_QtlyEmplCntA4Qc', B_A___Qtly_Empl_Cnt_A4_Qc_);
		SHARED ds_BA_QtlyEmplCntA5Qc:= fn_macro(ds, 'BA_QtlyEmplCntA5Qc', B_A___Qtly_Empl_Cnt_A5_Qc_);
		SHARED ds_BA_YrlyEmplCntA1Qc:= fn_macro(ds, 'BA_YrlyEmplCntA1Qc', B_A___Yrly_Empl_Cnt_A1_Qc_);
		SHARED ds_BA_YrlyEmplCntA5Qc:= fn_macro(ds, 'BA_YrlyEmplCntA5Qc', B_A___Yrly_Empl_Cnt_A5_Qc_);



		SHARED ds_all := ds_BA_WgQtrCntEv + ds_BA_QtlyWgsTotA1Qc + ds_BA_QtlyWgsTotA2Qc + ds_BA_QtlyWgsTotA3Qc +
										 ds_BA_QtlyWgsTotA4Qc + ds_BA_QtlyWgsTotA5Qc + ds_BA_YrlyWgsTotA1Qc + ds_BA_YrlyWgsTotA5Qc + 
										 ds_BA_QtlyEmplCntA1Qc + ds_BA_QtlyEmplCntA2Qc + ds_BA_QtlyEmplCntA3Qc + ds_BA_QtlyEmplCntA4Qc +
										 ds_BA_QtlyEmplCntA5Qc + ds_BA_YrlyEmplCntA1Qc + ds_BA_YrlyEmplCntA5Qc;
							
		EXPORT writeFile(dsMac, reportName) := FUNCTIONMACRO
			// If landing zone is on the same server as the Dali
			daliserver := std.system.Thorlib.DaliServer();
			cpos := std.Str.Find(daliserver, ':', 1)-1;
			lzip := daliserver[1..cpos];
			lz_dir := FraudGovUIKEL.Scripts.Utils.FilePaths.LZ_Dir;
			file_path := FraudGovUIKEL.Scripts.Utils.FilePaths.LogicalPath;
			thor_file := file_path + reportName;
			lz_path := lz_dir + reportName + '.csv';
			thor_out := OUTPUT(dsMac,, thor_file, CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"')), OVERWRITE);
			RETURN SEQUENTIAL(std.file.CreateExternalDirectory(lzip, lz_dir), thor_out, std.file.Despray(thor_file, lzip,lz_path,,,,true));
		ENDMACRO;

		EXPORT main := SEQUENTIAL(writeFile(ds_All, 'WagesDistribution'));
											
END;