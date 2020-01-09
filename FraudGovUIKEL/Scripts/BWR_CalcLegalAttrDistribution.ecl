import FraudgovUIkel;
import std;


EXPORT BWR_CalcLegalAttrDistribution := MODULE
	SHARED ds := FraudgovUIKel.Q__show_Legal.Res0;

		EXPORT fn_macro(dsMac, attributeStr, attribute) := FUNCTIONMACRO
				ds_cnt := COUNT(dsMac);
				RETURN SORT(TABLE(dsMac, {STRING attribute_name := attributeStr, STRING attribute_value := (STRING)attribute, cnt:=COUNT(GROUP), pct_of_file := COUNT(GROUP)/ds_cnt}, attribute), attribute_value);
		ENDMACRO;
		
		shared ds_FirstMoveToCount := fn_macro(ds, 'FirstMoveToCount', First_Move_To_Count_);
		shared ds_MoveToCount := fn_macro(ds, 'MoveToCount', Move_To_Count_);
		shared ds_MoveFromCount := fn_macro(ds, 'MoveFromCount', Move_From_Count_);
		shared ds_MoveSameSeleDiffEmpCount := fn_macro(ds, 'MoveSameSeleDiffEmpCount', Move_Same_Sele_Diff_Emp_Count_);
		shared ds_MoveSameUltDiffSeleEmpCount := fn_macro(ds, 'MoveSameUltDiffSeleEmpCount', Move_Same_Ult_Diff_Sele_Emp_Count_);
		shared ds_SameUltDiffSeleEmployeeCount := fn_macro(ds, 'SameUltDiffSeleEmployeeCount', Same_Ult_Diff_Sele_Employee_Count_);
		
		
		SHARED ds_All := ds_FirstMoveToCount + ds_MoveToCount + ds_MoveFromCount + ds_MoveSameSeleDiffEmpCount + ds_MoveSameUltDiffSeleEmpCount + ds_SameUltDiffSeleEmployeeCount;
		
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
		
		// EXPORT main := dsSeleChecks;
		// EXPORT main := OUTPUT(dsDateChecks, NAMED('dsDateChecks'));
		EXPORT main := SEQUENTIAL(writeFile(ds_All, 'LegalAttrDistributions'));
END;