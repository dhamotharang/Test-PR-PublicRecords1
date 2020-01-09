import FraudgovUIKEL;
import std;


EXPORT BWR_CalcTaxLiabHistDist := MODULE
		SHARED ds := FraudgovUIKel.Q__show_Employers.Res0;

		EXPORT fn_macro(dsMac, attributeStr, attribute) := FUNCTIONMACRO
				ds_cnt := COUNT(dsMac);
				RETURN SORT(TABLE(dsMac, {STRING30 attribute_name := attributeStr, STRING30 attribute_value := (STRING)attribute, cnt:=COUNT(GROUP), pct_of_file := COUNT(GROUP)/ds_cnt}, attribute), attribute_value);
		ENDMACRO;

		SHARED ds_BA_QtlyTaxRtEchoA1Qc := fn_macro(ds, 'BA_QtlyTaxRtEchoA1Qc', B_A___Qtly_Tax_Rt_Echo_A1_Qc_);
		SHARED ds_BA_QtlyTaxRtEchoA2Qc := fn_macro(ds, 'BA_QtlyTaxRtEchoA2Qc', B_A___Qtly_Tax_Rt_Echo_A2_Qc_);
		SHARED ds_BA_QtlyTaxRtEchoA3Qc := fn_macro(ds, 'BA_QtlyTaxRtEchoA3Qc', B_A___Qtly_Tax_Rt_Echo_A3_Qc_);
		SHARED ds_BA_QtlyTaxRtEchoA4Qc := fn_macro(ds, 'BA_QtlyTaxRtEchoA4Qc', B_A___Qtly_Tax_Rt_Echo_A4_Qc_);
		SHARED ds_BA_QtlyTaxRtEchoA5Qc := fn_macro(ds, 'BA_QtlyTaxRtEchoA5Qc', B_A___Qtly_Tax_Rt_Echo_A5_Qc_);
		SHARED ds_BA_YrlyTaxRtAvgA1Qc:= fn_macro(ds, 'BA_YrlyTaxRtAvgA1Qc', B_A___Yrly_Tax_Rt_Avg_A1_Qc_);
		SHARED ds_BA_YrlyTaxRtAvgA5Qc:= fn_macro(ds, 'BA_YrlyTaxRtAvgA5Qc', B_A___Yrly_Tax_Rt_Avg_A5_Qc_);


		SHARED ds_all := ds_BA_QtlyTaxRtEchoA1Qc + ds_BA_QtlyTaxRtEchoA2Qc + ds_BA_QtlyTaxRtEchoA3Qc + ds_BA_QtlyTaxRtEchoA4Qc +
										 ds_BA_QtlyTaxRtEchoA5Qc + ds_BA_YrlyTaxRtAvgA1Qc + ds_BA_YrlyTaxRtAvgA5Qc;
							
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

		EXPORT main := SEQUENTIAL(writeFile(ds_All, 'TaxLiabHistory'));
											
END;