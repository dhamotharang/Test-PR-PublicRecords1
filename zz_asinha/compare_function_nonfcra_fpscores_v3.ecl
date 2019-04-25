EXPORT compare_function_nonfcra_fpscores_v3(route,current_dt,previous_dt) :=  functionmacro


	 
	 
file_1:= dataset(route + scoring_project_pip.Output_Sample_Names.FP_V3_XML_Generic_FP31505_0_outfile + 'flapsd_' + previous_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout,thor);
file_1a:= dataset(route + scoring_project_pip.Output_Sample_Names.FP_V3_XML_Generic_FP31505_0_outfile + 'flapsd_' + current_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout,thor);

file_2:= dataset(route + scoring_project_pip.Output_Sample_Names.FP_V3_XML_Generic_FP31505_0_outfile + 'fls_' + previous_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout,thor);
file_2a:= dataset(route + scoring_project_pip.Output_Sample_Names.FP_V3_XML_Generic_FP31505_0_outfile + 'fls_' + current_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout,thor);

file_3:= dataset(route + scoring_project_pip.Output_Sample_Names.FP_V3_XML_Generic_FP31505_0_outfile + 'fla_' + previous_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout,thor);
file_3a:= dataset(route + scoring_project_pip.Output_Sample_Names.FP_V3_XML_Generic_FP31505_0_outfile + 'fla_' + current_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout,thor);

file_4:= dataset(route + scoring_project_pip.Output_Sample_Names.FP_V3_XML_Generic_FP31505_0_outfile + 'flaps_' + previous_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout,thor);
file_4a:= dataset(route + scoring_project_pip.Output_Sample_Names.FP_V3_XML_Generic_FP31505_0_outfile + 'flaps_' + current_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout,thor);

file_5:= dataset(route + scoring_project_pip.Output_Sample_Names.FP_V3_XML_Generic_FP31505_0_outfile + 'flapd_' + previous_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout,thor);
file_5a:= dataset(route + scoring_project_pip.Output_Sample_Names.FP_V3_XML_Generic_FP31505_0_outfile + 'flapd_' + current_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout,thor);

file_6:= dataset(route + scoring_project_pip.Output_Sample_Names.FP_V3_XML_Generic_FP31505_0_outfile + 'flasd_' + previous_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout,thor);
file_6a:= dataset(route + scoring_project_pip.Output_Sample_Names.FP_V3_XML_Generic_FP31505_0_outfile + 'flasd_' + current_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout,thor);

file_7:= dataset(route + scoring_project_pip.Output_Sample_Names.FP_V3_XML_Generic_FP31505_0_outfile + 'flpsd_' + previous_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout,thor);
file_7a:= dataset(route + scoring_project_pip.Output_Sample_Names.FP_V3_XML_Generic_FP31505_0_outfile + 'flpsd_' + current_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout,thor);

file_8:= dataset(route + scoring_project_pip.Output_Sample_Names.FP_V3_XML_Generic_FP31505_0_outfile + 'flap_' + previous_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout,thor);
file_8a:= dataset(route + scoring_project_pip.Output_Sample_Names.FP_V3_XML_Generic_FP31505_0_outfile + 'flap_' + current_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout,thor);

file_9:= dataset(route + scoring_project_pip.Output_Sample_Names.FP_V3_XML_Generic_FP31505_0_outfile + 'flps_' + previous_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout,thor);
file_9a:= dataset(route + scoring_project_pip.Output_Sample_Names.FP_V3_XML_Generic_FP31505_0_outfile + 'flps_' + current_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout,thor);

file_10:= dataset(route + scoring_project_pip.Output_Sample_Names.FP_V3_XML_Generic_FP31505_0_outfile + 'flsd_' + previous_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout,thor);
file_10a:= dataset(route + scoring_project_pip.Output_Sample_Names.FP_V3_XML_Generic_FP31505_0_outfile + 'flsd_' + current_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout,thor);

file_11:= dataset(route + scoring_project_pip.Output_Sample_Names.FP_V3_XML_Generic_FP31505_0_outfile + 'flad_' + previous_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout,thor);
file_11a:= dataset(route + scoring_project_pip.Output_Sample_Names.FP_V3_XML_Generic_FP31505_0_outfile + 'flad_' + current_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout,thor);

file_12:= dataset(route + scoring_project_pip.Output_Sample_Names.FP_V3_XML_Generic_FP31505_0_outfile + 'flas_' + previous_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout,thor);
file_12a:= dataset(route + scoring_project_pip.Output_Sample_Names.FP_V3_XML_Generic_FP31505_0_outfile + 'flas_' + current_dt, Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout,thor);


result1  := Scoring_QA_Risk_Indicator_Report.fp_v3_submodels_macro(file_1, file_1a, 'FP_v3_flapsd');
result2  := Scoring_QA_Risk_Indicator_Report.fp_v3_submodels_macro(file_2, file_2a, 'FP_v3_fls');
result3  := Scoring_QA_Risk_Indicator_Report.fp_v3_submodels_macro(file_3, file_3a, 'FP_v3_fla');
result4  := Scoring_QA_Risk_Indicator_Report.fp_v3_submodels_macro(file_4, file_4a, 'FP_v3_flaps');
result5  := Scoring_QA_Risk_Indicator_Report.fp_v3_submodels_macro(file_5, file_5a, 'FP_v3_flapd');
result6  := Scoring_QA_Risk_Indicator_Report.fp_v3_submodels_macro(file_6, file_6a, 'FP_v3_flasd');
result7  := Scoring_QA_Risk_Indicator_Report.fp_v3_submodels_macro(file_7, file_7a, 'FP_v3_flpsd');
result8  := Scoring_QA_Risk_Indicator_Report.fp_v3_submodels_macro(file_8, file_8a, 'FP_v3_flap');
result9  := Scoring_QA_Risk_Indicator_Report.fp_v3_submodels_macro(file_9, file_9a, 'FP_v3_flps');
result10 := Scoring_QA_Risk_Indicator_Report.fp_v3_submodels_macro(file_10, file_10a, 'FP_v3_flsd');
result11 := Scoring_QA_Risk_Indicator_Report.fp_v3_submodels_macro(file_11, file_11a, 'FP_v3_flad');
result12 := Scoring_QA_Risk_Indicator_Report.fp_v3_submodels_macro(file_12, file_12a, 'FP_v3_flas');

combined_result := result1 + result2 + result3 + result4 + result5 + result6 + result7 + result8 + result9 + result10 + result11 + result12; 

return combined_result; 							
endmacro;

