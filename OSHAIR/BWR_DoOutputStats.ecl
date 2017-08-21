import lib_stringlib;

////////////// CURRENT VERSION
cversion := '20121010';//'20080220c';
////////////// PREVIOUS VERSION
pversion := '20120710';//'20070606';

////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////

acci := OSHAIR.file_out_accident_cleaned;
haza := OSHAIR.file_out_hazardous_substance_cleaned;
insp := OSHAIR.file_out_inspection_cleaned;
opti := OSHAIR.file_out_optional_info_cleaned;prog := OSHAIR.file_out_program_cleaned;
acti := OSHAIR.file_out_related_activity_cleaned;
viol := OSHAIR.file_out_violations_cleaned;

////////////// NEW KEYS

now := dataset('~thor_data400::base::oshair::'+cversion+'::inspection', OSHAIR.layout_OSHAIR_inspection_clean, flat);

then := dataset('~thor_data400::base::oshair::'+pversion+'::inspection', OSHAIR.layout_OSHAIR_inspection_clean, flat);

OSHAIR.layout_OSHAIR_inspection_clean compare(OSHAIR.layout_OSHAIR_inspection_clean l) := transform
	self := l;
end;

newkeys := table(join(now, then, left.activity_number = right.activity_number, compare(left), left outer), {activity_number});

///////////// Record Counts
cntINSP := 'Inspection Records: ' + (string)count(insp);

cntHAZA := 'Hazardous Substance Records: '+ (string)count(haza);

cntACCI := 'Accident Records: '+ (string)count(acci);

cntOPTI := 'Optional Information Records: '+ (string)count(opti);

cntPROG := 'Program Records: '+ (string)count(prog);

cntACTI := 'Related Activity Records: '+ (string)count(acti);

cntVIOL := 'Violation Records: '+ (string)count(viol);

cntTable := dataset([{cntINSP},{cntHAZA},{cntACCI},{cntOPTI},{cntPROG},{cntACTI},{cntVIOL}], {string input});

/////////// POPULATIONS
pop_INSP := record
STRING115 HEADERFIELD := 'INSPECTION POPULATION STATS';
STRING115 Continuation_Flag := 'Continuation_Flag: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Continuation_Flag, '0')<>'',100,0)) + '%';
STRING115 History_Flag := 'History_Flag: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.History_Flag, '0')<>'',100,0)) + '%';
STRING115 History_Desc := 'History_Desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.History_Desc, '0')<>'',100,0)) + '%';
STRING115 Last_Activity_Date := 'Last_Activity_Date: ' + (string)AVE(group,IF(insp.Last_Activity_Date<>0,100,0)) + '%';
STRING115 Fed_State_Flag := 'Fed_State_Flag: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Fed_State_Flag, '0')<>'',100,0)) + '%';
STRING115 Previous_Activity_Type := 'Previous_Activity_Type: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Previous_Activity_Type, '0')<>'',100,0)) + '%';
STRING115 Prev_Activity_Type_Desc := 'Prev_Activity_Type_Desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Prev_Activity_Type_Desc, '0')<>'',100,0)) + '%';
STRING115 Previous_Activity_Number := 'Previous_Activity_Number: ' + (string)AVE(group,IF(insp.Previous_Activity_Number<>0,100,0)) + '%';
STRING115 Activity_Number := 'Activity_Number: ' + (string)AVE(group,IF(insp.Activity_Number<>0,100,0)) + '%';
STRING115 Region_Code := 'Region_Code: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Region_Code, '0')<>'',100,0)) + '%';
STRING115 Area_Code := 'Area_Code: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Area_Code, '0')<>'',100,0)) + '%';
STRING115 Office_Code := 'Office_Code: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Office_Code, '0')<>'',100,0)) + '%';
STRING115 Compliance_Officer_ID := 'Compliance_Officer_ID: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Compliance_Officer_ID, '0')<>'',100,0)) + '%';
STRING115 Compliance_Officer_Job_Title := 'Compliance_Officer_Job_Title: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Compliance_Officer_Job_Title, '0')<>'',100,0)) + '%';
STRING115 Compl_Officer_Job_Title_Desc := 'Compl_Officer_Job_Title_Desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Compl_Officer_Job_Title_Desc, '0')<>'',100,0)) + '%';
STRING115 Hist_Area := 'Hist_Area: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Hist_Area, '0')<>'',100,0)) + '%';
STRING115 Hist_Report_Number := 'Hist_Report_Number: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Hist_Report_Number, '0')<>'',100,0)) + '%';
STRING115 Inspected_Site_Name := 'Inspected_Site_Name: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Inspected_Site_Name, '0')<>'',100,0)) + '%';
STRING115 Inspected_Site_Street := 'Inspected_Site_Street: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Inspected_Site_Street, '0')<>'',100,0)) + '%';
STRING115 Inspected_Site_State := 'Inspected_Site_State: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Inspected_Site_State, '0')<>'',100,0)) + '%';
STRING115 Inspected_Site_Zip := 'Inspected_Site_Zip: ' + (string)AVE(group,IF(insp.Inspected_Site_Zip<>0,100,0)) + '%';
STRING115 Inspected_Site_City_Code := 'Inspected_Site_City_Code: ' + (string)AVE(group,IF(insp.Inspected_Site_City_Code<>0,100,0)) + '%';
STRING115 Inspected_Site_City_Name := 'Inspected_Site_City_Name: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Inspected_Site_City_Name, '0')<>'',100,0)) + '%';
STRING115 Inspected_Site_County_Code := 'Inspected_Site_County_Code: ' + (string)AVE(group,IF(insp.Inspected_Site_County_Code<>0,100,0)) + '%';
STRING115 DUNS_Number := 'DUNS_Number: ' + (string)AVE(group,IF(insp.DUNS_Number<>0,100,0)) + '%';
STRING115 Host_Establishment_key := 'Host_Establishment_key: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Host_Establishment_key, '0')<>'',100,0)) + '%';
STRING115 Owner_Type := 'Owner_Type: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Owner_Type, '0')<>'',100,0)) + '%';
STRING115 Own_Type_Desc := 'Own_Type_Desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Own_Type_Desc, '0')<>'',100,0)) + '%';
STRING115 Owner_Code := 'Owner_Code: ' + (string)AVE(group,IF(insp.Owner_Code<>0,100,0)) + '%';
STRING115 Advance_Notice_Flag := 'Advance_Notice_Flag: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Advance_Notice_Flag, '0')<>'',100,0)) + '%';
STRING115 Inspection_Opening_Date := 'Inspection_Opening_Date: ' + (string)AVE(group,IF(insp.Inspection_Opening_Date<>0,100,0)) + '%';
STRING115 Inspection_Close_Date := 'Inspection_Close_Date: ' + (string)AVE(group,IF(insp.Inspection_Close_Date<>0,100,0)) + '%';
STRING115 Safety_Health_Flag := 'Safety_Health_Flag: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Safety_Health_Flag, '0')<>'',100,0)) + '%';
STRING115 SIC_Code := 'SIC_Code: ' + (string)AVE(group,IF(insp.SIC_Code<>0,100,0)) + '%';
STRING115 SIC_Guide := 'SIC_Guide: ' + (string)AVE(group,IF(insp.SIC_Guide<>0,100,0)) + '%';
STRING115 SIC_Inspected := 'SIC_Inspected: ' + (string)AVE(group,IF(insp.SIC_Inspected<>0,100,0)) + '%';
STRING115 NAICS_Code := 'NAICS_Code: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.NAICS_Code, '0')<>'',100,0)) + '%';
STRING115 NAICS_Secondary_Code := 'NAICS_Secondary_Code: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.NAICS_Secondary_Code, '0')<>'',100,0)) + '%';
STRING115 NAIC_Inspected := 'NAIC_Inspected: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.NAIC_Inspected, '0')<>'',100,0)) + '%';
STRING115 Inspection_Type := 'Inspection_Type: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Inspection_Type, '0')<>'',100,0)) + '%';
STRING115 Insp_Type_Desc := 'Insp_Type_Desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Insp_Type_Desc, '0')<>'',100,0)) + '%';
STRING115 Inspection_Scope := 'Inspection_Scope: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Inspection_Scope, '0')<>'',100,0)) + '%';
STRING115 Insp_Scope_Desc := 'Insp_Scope_Desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Insp_Scope_Desc, '0')<>'',100,0)) + '%';
STRING115 Number_In_Establishment := 'Number_In_Establishment: ' + (string)AVE(group,IF(insp.Number_In_Establishment<>0,100,0)) + '%';
STRING115 Number_Covered := 'Number_Covered: ' + (string)AVE(group,IF(insp.Number_Covered<>0,100,0)) + '%';
STRING115 Number_Total_Employees := 'Number_Total_Employees: ' + (string)AVE(group,IF(insp.Number_Total_Employees<>0,100,0)) + '%';
STRING115 Walk_Around_Flag := 'Walk_Around_Flag: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Walk_Around_Flag, '0')<>'',100,0)) + '%';
STRING115 Employees_Interviewed_Flag := 'Employees_Interviewed_Flag: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Employees_Interviewed_Flag, '0')<>'',100,0)) + '%';
STRING115 Union_Flag := 'Union_Flag: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Union_Flag, '0')<>'',100,0)) + '%';
STRING115 Closed_Case_Flag := 'Closed_Case_Flag: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Closed_Case_Flag, '0')<>'',100,0)) + '%';
STRING115 Why_No_Inspection_Code := 'Why_No_Inspection_Code: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Why_No_Inspection_Code, '0')<>'',100,0)) + '%';
STRING115 Close_Case_Date := 'Close_Case_Date: ' + (string)AVE(group,IF(insp.Close_Case_Date<>0,100,0)) + '%';
STRING115 Safety_PG_Manufacturing_Insp_Flag := 'Safety_PG_Manufacturing_Insp_Flag: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Safety_PG_Manufacturing_Insp_Flag, '0')<>'',100,0)) + '%';
STRING115 Safety_PG_Construction_Insp_Flag := 'Safety_PG_Construction_Insp_Flag: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Safety_PG_Construction_Insp_Flag, '0')<>'',100,0)) + '%';
STRING115 Safety_PG_Maritime_Insp_Flag := 'Safety_PG_Maritime_Insp_Flag: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Safety_PG_Maritime_Insp_Flag, '0')<>'',100,0)) + '%';
STRING115 Health_PG_Manufacturing_Insp_Flag := 'Health_PG_Manufacturing_Insp_Flag: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Health_PG_Manufacturing_Insp_Flag, '0')<>'',100,0)) + '%';
STRING115 Health_PG_Construction_Insp_Flag := 'Health_PG_Construction_Insp_Flag: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Health_PG_Construction_Insp_Flag, '0')<>'',100,0)) + '%';
STRING115 Health_PG_Maritime_Insp_Flag := 'Health_PG_Maritime_Insp_Flag: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Health_PG_Maritime_Insp_Flag, '0')<>'',100,0)) + '%';
STRING115 Migrant_Farm_Insp_Flag := 'Migrant_Farm_Insp_Flag: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Migrant_Farm_Insp_Flag, '0')<>'',100,0)) + '%';
STRING115 Antic_Served := 'Antic_Served: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Antic_Served, '0')<>'',100,0)) + '%';
STRING115 First_Denial_Date := 'First_Denial_Date: ' + (string)AVE(group,IF(insp.First_Denial_Date<>0,100,0)) + '%';
STRING115 Last_Reenter_Date := 'Last_Reenter_Date: ' + (string)AVE(group,IF(insp.Last_Reenter_Date<>0,100,0)) + '%';
STRING115 bls_Loss_Workday_Injury_Rate := 'bls_Loss_Workday_Injury_Rate: ' + (string)AVE(group,IF(insp.bls_Loss_Workday_Injury_Rate<>0,100,0)) + '%';
STRING115 Informal_SH_Program_Init_Flag := 'Informal_SH_Program_Init_Flag: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Informal_SH_Program_Init_Flag, '0')<>'',100,0)) + '%';
STRING115 Informal_Data_Required := 'Informal_Data_Required: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Informal_Data_Required, '0')<>'',100,0)) + '%';
STRING115 Penalties_Due_Date := 'Penalties_Due_Date: ' + (string)AVE(group,IF(insp.Penalties_Due_Date<>0,100,0)) + '%';
STRING115 FTA_Due_Date := 'FTA_Due_Date: ' + (string)AVE(group,IF(insp.FTA_Due_Date<>0,100,0)) + '%';
STRING115 Due_Date_Type := 'Due_Date_Type: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.Due_Date_Type, '0')<>'',100,0)) + '%';
STRING115 PA_Prep_Time := 'PA_Prep_Time: ' + (string)AVE(group,IF(insp.PA_Prep_Time<>0,100,0)) + '%';
STRING115 PA_Travel_Time := 'PA_Travel_Time: ' + (string)AVE(group,IF(insp.PA_Travel_Time<>0,100,0)) + '%';
STRING115 PA_On_site_Time := 'PA_On_site_Time: ' + (string)AVE(group,IF(insp.PA_On_site_Time<>0,100,0)) + '%';
STRING115 PA_Tech_supp_Time := 'PA_Tech_supp_Time: ' + (string)AVE(group,IF(insp.PA_Tech_supp_Time<>0,100,0)) + '%';
STRING115 PA_Report_prep_Time := 'PA_Report_prep_Time: ' + (string)AVE(group,IF(insp.PA_Report_prep_Time<>0,100,0)) + '%';
STRING115 PA_Other_conf_Time := 'PA_Other_conf_Time: ' + (string)AVE(group,IF(insp.PA_Other_conf_Time<>0,100,0)) + '%';
STRING115 PA_Litigation_Time := 'PA_Litigation_Time: ' + (string)AVE(group,IF(insp.PA_Litigation_Time<>0,100,0)) + '%';
STRING115 PA_Denial_Time := 'PA_Denial_Time: ' + (string)AVE(group,IF(insp.PA_Denial_Time<>0,100,0)) + '%';
STRING115 PA_Sum_hours := 'PA_Sum_hours: ' + (string)AVE(group,IF(insp.PA_Sum_hours<>0,100,0)) + '%';
STRING115 Earliest_Contest_Date := 'Earliest_Contest_Date: ' + (string)AVE(group,IF(insp.Earliest_Contest_Date<>0,100,0)) + '%';
STRING115 Remitted_Penalty_Amount := 'Remitted_Penalty_Amount: ' + (string)AVE(group,IF(insp.Remitted_Penalty_Amount<>0,100,0)) + '%';
STRING115 Remitted_FTA_Amount := 'Remitted_FTA_Amount: ' + (string)AVE(group,IF(insp.Remitted_FTA_Amount<>0,100,0)) + '%';
STRING115 Total_Penalties := 'Total_Penalties: ' + (string)AVE(group,IF(insp.Total_Penalties<>0,100,0)) + '%';
STRING115 Total_FTA := 'Total_FTA: ' + (string)AVE(group,IF(insp.Total_FTA<>0,100,0)) + '%';
STRING115 Total_Violations := 'Total_Violations: ' + (string)AVE(group,IF(insp.Total_Violations<>0,100,0)) + '%';
STRING115 Total_Serious_Violations := 'Total_Serious_Violations: ' + (string)AVE(group,IF(insp.Total_Serious_Violations<>0,100,0)) + '%';
STRING115 Number_Program := 'Number_Program: ' + (string)AVE(group,IF(insp.Number_Program<>0,100,0)) + '%';
STRING115 Number_Rel_Activity := 'Number_Rel_Activity: ' + (string)AVE(group,IF(insp.Number_Rel_Activity<>0,100,0)) + '%';
STRING115 Number_Optional_Info := 'Number_Optional_Info: ' + (string)AVE(group,IF(insp.Number_Optional_Info<>0,100,0)) + '%';
STRING115 Number_Debt := 'Number_Debt: ' + (string)AVE(group,IF(insp.Number_Debt<>0,100,0)) + '%';
STRING115 Number_Violations := 'Number_Violations: ' + (string)AVE(group,IF(insp.Number_Violations<>0,100,0)) + '%';
STRING115 Number_Event := 'Number_Event: ' + (string)AVE(group,IF(insp.Number_Event<>0,100,0)) + '%';
STRING115 Number_Hazardous_Substance := 'Number_Hazardous_Substance: ' + (string)AVE(group,IF(insp.Number_Hazardous_Substance<>0,100,0)) + '%';
STRING115 Number_Accident := 'Number_Accident: ' + (string)AVE(group,IF(insp.Number_Accident<>0,100,0)) + '%';
STRING115 Number_Admin_Pay := 'Number_Admin_Pay: ' + (string)AVE(group,IF(insp.Number_Admin_Pay<>0,100,0)) + '%';
STRING115 cname := 'cname: ' + (string)AVE(group,IF(stringlib.stringfilterout(insp.cname, '0')<>'',100,0)) + '%';
STRING115 bdid := 'bdid: ' + (string)AVE(group,IF(insp.bdid<>0,100,0)) + '%';
STRING115 BDID_score := 'BDID_score: ' + (string)AVE(group,IF(insp.BDID_score<>0,100,0)) + '%';
end;


pop_acci := record
STRING115 HEADERFIELD := 'ACCIDENT POPULATION STATS';
STRING115 Activity_Number := 'Activity Number: ' + (string)AVE(group,IF(acci.Activity_Number<>0,100,0)) + '%';
STRING115 Name := 'Name: ' + (string)AVE(group,IF(stringlib.stringfilterout(acci.Name, '0')<>'',100,0)) + '%';
STRING115 Related_Inspection_Number := 'Related_Inspection_Number: ' + (string)AVE(group,IF(acci.Related_Inspection_Number<>0,100,0)) + '%';
STRING115 Sex := 'Sex: ' + (string)AVE(group,IF(stringlib.stringfilterout(acci.Sex, '0')<>'',100,0)) + '%';
STRING115 Age := 'Age: ' + (string)AVE(group,IF(acci.Age<>0,100,0)) + '%';
STRING115 Degree_of_Injury := 'Degree_of_Injury: ' + (string)AVE(group,IF(stringlib.stringfilterout(acci.Degree_of_Injury, '0')<>'',100,0)) + '%';
STRING115 Nature_of_Injury := 'Nature_of_Injury: ' + (string)AVE(group,IF(stringlib.stringfilterout(acci.Nature_of_Injury, '0')<>'',100,0)) + '%';
STRING115 Part_of_Body := 'Part_of_Body: ' + (string)AVE(group,IF(stringlib.stringfilterout(acci.Part_of_Body, '0')<>'',100,0)) + '%';
STRING115 Source_of_Injury := 'Source_of_Injury: ' + (string)AVE(group,IF(stringlib.stringfilterout(acci.Source_of_Injury, '0')<>'',100,0)) + '%';
STRING115 Event_Type := 'Event_Type: ' + (string)AVE(group,IF(stringlib.stringfilterout(acci.Event_Type, '0')<>'',100,0)) + '%';
STRING115 Environmental_Factor := 'Environmental_Factor: ' + (string)AVE(group,IF(stringlib.stringfilterout(acci.Environmental_Factor, '0')<>'',100,0)) + '%';
STRING115 Human_Factor := 'Human_Factor: ' + (string)AVE(group,IF(stringlib.stringfilterout(acci.Human_Factor, '0')<>'',100,0)) + '%';
STRING115 Task_Assigned := 'Task_Assigned: ' + (string)AVE(group,IF(stringlib.stringfilterout(acci.Task_Assigned, '0')<>'',100,0)) + '%';
STRING115 Hazardous_Substance := 'Hazardous_Substance: ' + (string)AVE(group,IF(stringlib.stringfilterout(acci.Hazardous_Substance, '0')<>'',100,0)) + '%';
STRING115 Occupation_Code := 'Occupation_Code: ' + (string)AVE(group,IF(stringlib.stringfilterout(acci.Occupation_Code, '0')<>'',100,0)) + '%';
STRING115 Deg_of_Injury_Desc := 'Deg_of_Injury_Desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(acci.Deg_of_Injury_Desc, '0')<>'',100,0)) + '%';
STRING115 Nat_of_Inj_Desc := 'Nat_of_Inj_Desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(acci.Nat_of_Inj_Desc, '0')<>'',100,0)) + '%';
STRING115 Part_of_Body_Desc := 'Part_of_Body_Desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(acci.Part_of_Body_Desc, '0')<>'',100,0)) + '%';
STRING115 Src_of_Inj_Desc := 'Src_of_Inj_Desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(acci.Src_of_Inj_Desc, '0')<>'',100,0)) + '%';
STRING115 Event_Desc := 'Event_Desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(acci.Event_Desc, '0')<>'',100,0)) + '%';
STRING115 Env_Factor_Desc := 'Env_Factor_Desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(acci.Env_Factor_Desc, '0')<>'',100,0)) + '%';
STRING115 Human_Factor_Desc := 'Human_Factor_Desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(acci.Human_Factor_Desc, '0')<>'',100,0)) + '%';
STRING115 Task_Assigned_Desc := 'Task_Assigned_Desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(acci.Task_Assigned_Desc, '0')<>'',100,0)) + '%';
STRING115 Hazardous_Sub_Desc := 'Hazardous_Sub_Desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(acci.Hazardous_Sub_Desc, '0')<>'',100,0)) + '%';
STRING115 Occupation_Desc := 'Occupation_Desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(acci.Occupation_Desc, '0')<>'',100,0)) + '%';

end;


pop_HAZA := record
STRING115 HEADERFIELD := 'HAZARD POPULATION STATS';
STRING115 Activity_Number := 'Activity_Number: ' + (string)AVE(group,IF(haza.Activity_Number<>0,100,0)) + '%';
STRING115 Citation_Number := 'Citation_Number: ' + (string)AVE(group,IF(stringlib.stringfilterout(haza.Citation_Number, '0')<>'',100,0)) + '%';
STRING115 Item_Number := 'Item_Number: ' + (string)AVE(group,IF(stringlib.stringfilterout(haza.Item_Number, '0')<>'',100,0)) + '%';
STRING115 Item_group := 'Item_group: ' + (string)AVE(group,IF(stringlib.stringfilterout(haza.Item_group, '0')<>'',100,0)) + '%';
STRING115 Hazardous_Substance_1 := 'Hazardous_Substance_1: ' + (string)AVE(group,IF(stringlib.stringfilterout(haza.Hazardous_Substance_1, '0')<>'',100,0)) + '%';
STRING115 Hazardous_Substance_2 := 'Hazardous_Substance_2: ' + (string)AVE(group,IF(stringlib.stringfilterout(haza.Hazardous_Substance_2, '0')<>'',100,0)) + '%';
STRING115 Hazardous_Substance_3 := 'Hazardous_Substance_3: ' + (string)AVE(group,IF(stringlib.stringfilterout(haza.Hazardous_Substance_3, '0')<>'',100,0)) + '%';
STRING115 Hazardous_Substance_4 := 'Hazardous_Substance_4: ' + (string)AVE(group,IF(stringlib.stringfilterout(haza.Hazardous_Substance_4, '0')<>'',100,0)) + '%';
STRING115 Hazardous_Substance_5 := 'Hazardous_Substance_5: ' + (string)AVE(group,IF(stringlib.stringfilterout(haza.Hazardous_Substance_5, '0')<>'',100,0)) + '%';
STRING115 Hazardous_Sub_Desc_1 := 'Hazardous_Sub_Desc_1: ' + (string)AVE(group,IF(stringlib.stringfilterout(haza.Hazardous_Sub_Desc_1, '0')<>'',100,0)) + '%';
STRING115 Hazardous_Sub_Desc_2 := 'Hazardous_Sub_Desc_2: ' + (string)AVE(group,IF(stringlib.stringfilterout(haza.Hazardous_Sub_Desc_2, '0')<>'',100,0)) + '%';
STRING115 Hazardous_Sub_Desc_3 := 'Hazardous_Sub_Desc_3: ' + (string)AVE(group,IF(stringlib.stringfilterout(haza.Hazardous_Sub_Desc_3, '0')<>'',100,0)) + '%';
STRING115 Hazardous_Sub_Desc_4 := 'Hazardous_Sub_Desc_4: ' + (string)AVE(group,IF(stringlib.stringfilterout(haza.Hazardous_Sub_Desc_4, '0')<>'',100,0)) + '%';
STRING115 Hazardous_Sub_Desc_5 := 'Hazardous_Sub_Desc_5: ' + (string)AVE(group,IF(stringlib.stringfilterout(haza.Hazardous_Sub_Desc_5, '0')<>'',100,0)) + '%';
end;


pop_OPTI := record
STRING115 HEADERFIELD := 'OPTIONAL POPULATION STATS';
STRING115 Activity_Number := 'Activity_Number: ' + (string)AVE(group,IF(opti.Activity_Number<>0,100,0)) + '%';
STRING115 Opt_Type := 'Opt_Type: ' + (string)AVE(group,IF(stringlib.stringfilterout(opti.Opt_Type, '0')<>'',100,0)) + '%';
STRING115 Opt_ID := 'Opt_ID: ' + (string)AVE(group,IF(stringlib.stringfilterout(opti.Opt_ID, '0')<>'',100,0)) + '%';
STRING115 Opt_Value := 'Opt_Value: ' + (string)AVE(group,IF(stringlib.stringfilterout(opti.Opt_Value, '0')<>'',100,0)) + '%';
STRING115 Opt_Desc := 'Opt_Desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(opti.Opt_Desc, '0')<>'',100,0)) + '%';
end;


pop_PROG := record
STRING115 HEADERFIELD := 'PROGRAM POPULATION STATS';
STRING115 Activity_Number := 'Activity_Number: ' + (string)AVE(group,IF(prog.Activity_Number<>0,100,0)) + '%';
STRING115 Program_Type := 'Program_Type: ' + (string)AVE(group,IF(stringlib.stringfilterout(prog.Program_Type, '0')<>'',100,0)) + '%';
STRING115 Program_Value := 'Program_Value: ' + (string)AVE(group,IF(stringlib.stringfilterout(prog.Program_Value, '0')<>'',100,0)) + '%';
end;


pop_ACTI := record
STRING115 HEADERFIELD := 'ACTIVITY POPULATION STATS';
STRING115 Activity_Number := 'Activity_Number: ' + (string)AVE(group,IF(acti.Activity_Number<>0,100,0)) + '%';
STRING115 Rel_Activity_item_Number := 'Rel_Activity_item_Number: ' + (string)AVE(group,IF(stringlib.stringfilterout(acti.Rel_Activity_item_Number, '0')<>'',100,0)) + '%';
STRING115 Rel_Activity_Type := 'Rel_Activity_Type: ' + (string)AVE(group,IF(stringlib.stringfilterout(acti.Rel_Activity_Type, '0')<>'',100,0)) + '%';
STRING115 Rel_Activity_Number := 'Rel_Activity_Number: ' + (string)AVE(group,IF(acti.Rel_Activity_Number<>0,100,0)) + '%';
STRING115 Rel_Activity_Safety_Flag := 'Rel_Activity_Safety_Flag: ' + (string)AVE(group,IF(stringlib.stringfilterout(acti.Rel_Activity_Safety_Flag, '0')<>'',100,0)) + '%';
STRING115 Rel_Activity_Health_Flag := 'Rel_Activity_Health_Flag: ' + (string)AVE(group,IF(stringlib.stringfilterout(acti.Rel_Activity_Health_Flag, '0')<>'',100,0)) + '%';
STRING115 Rel_Activity_Desc := 'Rel_Activity_Desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(acti.Rel_Activity_Desc, '0')<>'',100,0)) + '%';
end;


pop_VIOL := record
STRING115 HEADERFIELD := 'VIOLATION POPULATION STATS';
STRING115 Activity_Number := 'Activity_Number: ' + (string)AVE(group,IF(viol.Activity_Number<>0,100,0)) + '%';
STRING115 Delete_Flag := 'Delete_Flag: ' + (string)AVE(group,IF(stringlib.stringfilterout(viol.Delete_Flag, '0')<>'',100,0)) + '%';
STRING115 Issuance_Date := 'Issuance_Date: ' + (string)AVE(group,IF(viol.Issuance_Date<>0,100,0)) + '%';
STRING115 Citation_Number := 'Citation_Number: ' + (string)AVE(group,IF(stringlib.stringfilterout(viol.Citation_Number, '0')<>'',100,0)) + '%';
STRING115 Item_Number := 'Item_Number: ' + (string)AVE(group,IF(stringlib.stringfilterout(viol.Item_Number, '0')<>'',100,0)) + '%';
STRING115 Item_group := 'Item_group: ' + (string)AVE(group,IF(stringlib.stringfilterout(viol.Item_group, '0')<>'',100,0)) + '%';
STRING115 Emphasis := 'Emphasis: ' + (string)AVE(group,IF(stringlib.stringfilterout(viol.Emphasis, '0')<>'',100,0)) + '%';
STRING115 Gravity := 'Gravity: ' + (string)AVE(group,IF(stringlib.stringfilterout(viol.Gravity, '0')<>'',100,0)) + '%';
STRING115 Current_Penalty := 'Current_Penalty: ' + (string)AVE(group,IF(viol.Current_Penalty<>0,100,0)) + '%';
STRING115 Initial_Penalty := 'Initial_Penalty: ' + (string)AVE(group,IF(viol.Initial_Penalty<>0,100,0)) + '%';
STRING115 Violation_Type := 'Violation_Type: ' + (string)AVE(group,IF(stringlib.stringfilterout(viol.Violation_Type, '0')<>'',100,0)) + '%';
STRING115 Initial_Violation_Type := 'Initial_Violation_Type: ' + (string)AVE(group,IF(stringlib.stringfilterout(viol.Initial_Violation_Type, '0')<>'',100,0)) + '%';
STRING115 Fed_State_Standard := 'Fed_State_Standard: ' + (string)AVE(group,IF(stringlib.stringfilterout(viol.Fed_State_Standard, '0')<>'',100,0)) + '%';
STRING115 Abatement_Date := 'Abatement_Date: ' + (string)AVE(group,IF(viol.Abatement_Date<>0,100,0)) + '%';
STRING115 Number_Instances := 'Number_Instances: ' + (string)AVE(group,IF(viol.Number_Instances<>0,100,0)) + '%';
STRING115 Related_Event_Code := 'Related_Event_Code: ' + (string)AVE(group,IF(stringlib.stringfilterout(viol.Related_Event_Code, '0')<>'',100,0)) + '%';
STRING115 Number_Exposed := 'Number_Exposed: ' + (string)AVE(group,IF(viol.Number_Exposed<>0,100,0)) + '%';
STRING115 Abatement_Complete := 'Abatement_Complete: ' + (string)AVE(group,IF(stringlib.stringfilterout(viol.Abatement_Complete, '0')<>'',100,0)) + '%';
STRING115 Earliest_Contest_Date := 'Earliest_Contest_Date: ' + (string)AVE(group,IF(viol.Earliest_Contest_Date<>0,100,0)) + '%';
STRING115 Violation_Contest := 'Violation_Contest: ' + (string)AVE(group,IF(stringlib.stringfilterout(viol.Violation_Contest, '0')<>'',100,0)) + '%';
STRING115 Penalty_Contest := 'Penalty_Contest: ' + (string)AVE(group,IF(stringlib.stringfilterout(viol.Penalty_Contest, '0')<>'',100,0)) + '%';
STRING115 Abatement_Employer_Contest := 'Abatement_Employer_Contest: ' + (string)AVE(group,IF(stringlib.stringfilterout(viol.Abatement_Employer_Contest, '0')<>'',100,0)) + '%';
STRING115 Abatement_Employee_Contest := 'Abatement_Employee_Contest: ' + (string)AVE(group,IF(stringlib.stringfilterout(viol.Abatement_Employee_Contest, '0')<>'',100,0)) + '%';
STRING115 Final_Order_Date := 'Final_Order_Date: ' + (string)AVE(group,IF(viol.Final_Order_Date<>0,100,0)) + '%';
STRING115 Pet_To_Modify_Abatement := 'Pet_To_Modify_Abatement: ' + (string)AVE(group,IF(stringlib.stringfilterout(viol.Pet_To_Modify_Abatement, '0')<>'',100,0)) + '%';
STRING115 Citation_Amended := 'Citation_Amended: ' + (string)AVE(group,IF(stringlib.stringfilterout(viol.Citation_Amended, '0')<>'',100,0)) + '%';
STRING115 Informal_Settlement_Aggreement := 'Informal_Settlement_Aggreement: ' + (string)AVE(group,IF(stringlib.stringfilterout(viol.Informal_Settlement_Aggreement, '0')<>'',100,0)) + '%';
STRING115 Disposition_Event := 'Disposition_Event: ' + (string)AVE(group,IF(stringlib.stringfilterout(viol.Disposition_Event, '0')<>'',100,0)) + '%';
STRING115 FTA_Inspection_Number := 'FTA_Inspection_Number: ' + (string)AVE(group,IF(viol.FTA_Inspection_Number<>0,100,0)) + '%';
STRING115 FTA_Penalty := 'FTA_Penalty: ' + (string)AVE(group,IF(viol.FTA_Penalty<>0,100,0)) + '%';
STRING115 FTA_Issuance_Date := 'FTA_Issuance_Date: ' + (string)AVE(group,IF(viol.FTA_Issuance_Date<>0,100,0)) + '%';
STRING115 FTA_Contest_Date := 'FTA_Contest_Date: ' + (string)AVE(group,IF(viol.FTA_Contest_Date<>0,100,0)) + '%';
STRING115 FTA_Ammended := 'FTA_Ammended: ' + (string)AVE(group,IF(stringlib.stringfilterout(viol.FTA_Ammended, '0')<>'',100,0)) + '%';
STRING115 FTA_ISA := 'FTA_ISA: ' + (string)AVE(group,IF(stringlib.stringfilterout(viol.FTA_ISA, '0')<>'',100,0)) + '%';
STRING115 FTA_Disposition_Event := 'FTA_Disposition_Event: ' + (string)AVE(group,IF(stringlib.stringfilterout(viol.FTA_Disposition_Event, '0')<>'',100,0)) + '%';
STRING115 FTA_Final_Order_Date := 'FTA_Final_Order_Date: ' + (string)AVE(group,IF(viol.FTA_Final_Order_Date<>0,100,0)) + '%';
STRING115 Hazard_Category := 'Hazard_Category: ' + (string)AVE(group,IF(stringlib.stringfilterout(viol.Hazard_Category, '0')<>'',100,0)) + '%';
STRING115 Abatement_Verify_Date := 'Abatement_Verify_Date: ' + (string)AVE(group,IF(viol.Abatement_Verify_Date<>0,100,0)) + '%';
STRING115 Violation_Desc := 'Violation_Desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(viol.Violation_Desc, '0')<>'',100,0)) + '%';
STRING115 Related_Event_Desc := 'Related_Event_Desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(viol.Related_Event_Desc, '0')<>'',100,0)) + '%';
STRING115 Abatement_Comp_Desc := 'Abatement_Comp_Desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(viol.Abatement_Comp_Desc, '0')<>'',100,0)) + '%';
STRING115 Disposition_Event_Desc := 'Disposition_Event_Desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(viol.Disposition_Event_Desc, '0')<>'',100,0)) + '%';
STRING115 FTA_Disposition_Event_Desc := 'FTA_Disposition_Event_Desc: ' + (string)AVE(group,IF(stringlib.stringfilterout(viol.FTA_Disposition_Event_Desc, '0')<>'',100,0)) + '%';
end;

tINSP := table(insp, pop_insp, few);
tACCI := table(acci, pop_acci, few);
tOPTI := table(opti, pop_opti, few);
tVIOL := table(viol, pop_viol, few);
tHAZA := table(haza, pop_haza, few);
tPROG := table(prog, pop_prog, few);
tACTI := table(acti, pop_acti, few);

/////////// DATES

InspODT := sort(table(insp, {Inspection_Opening_Date, decimal10 amount := count(group)}, Inspection_Opening_Date, few), record);
minO := min(InspODT(Inspection_Opening_Date > 0),Inspection_Opening_Date);
maxO := max(InspODT,Inspection_Opening_Date);
title1 := 'Inspection Opening Dates: '+ minO + '-' + maxO;

InspCDT := sort(table(insp, {Inspection_Close_Date, amount := count(group)}, Inspection_Close_Date, few), record);
minC := min(InspCDT(Inspection_Close_Date > 0),Inspection_Close_Date);
maxC := max(InspCDT,Inspection_Close_Date);
title2 := 'Inspection Close Dates: '+ minC + '-' + maxC;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// OUTPUTS          OUTPUTS          OUTPUTS          OUTPUTS          OUTPUTS          OUTPUTS          OUTPUTS          
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

parallel(
output(choosen(newkeys, 300), named('NEW_ACTIVITY_NUMBERS_TABLE')),
output(cntTable, named('Counts_Per_Base_File')),
output(tINSP, named('INSPECTION_POPULATION_TABLE')),
output(tACCI, named('ACCIDENT_POPULATION_TABLE')),
output(tOPTI, named('OPTIONAL_POPULATION_TABLE')),
output(tVIOL, named('VIOLATION_POPULATION_TABLE')),
output(tHAZA, named('HAZARD_POPULATION_TABLE')),
output(tPROG, named('PROGRAM_POPULATION_TABLE')),
output(tACTI, named('ACTIVITY_POPULATION_TABLE')),
sequential(output(title1), output(InspODT, all)),
sequential(output(title2), output(InspCDT, all))
);

