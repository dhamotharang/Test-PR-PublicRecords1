IMPORT Data_Services, STD;

	ToSupressSet := set(FLAccidents_Ecrash.Infiles.suppress_incidents,Incident_ID);
	Incidents  		:= dedup(FLAccidents_Ecrash.Infiles.tincident	,all);
	IncidentsSuppressed := Incidents(~(trim(case_identifier,left,right) in  FLAccidents_Ecrash.Suppress_Id and source_id in ['EA', 'TF']) and 
																										(trim(report_id,left,right) not in FLAccidents_Ecrash.Suppress_report_d) and 
																										(trim(incident_id,left,right) not in FLAccidents_Ecrash.supress_incident_id) and
																										(trim(incident_id,left,right) not in ToSupressSet)
																									);
																													
	export IncidentsAfterSuppression := join(IncidentsSuppressed, Files_eCrash.DS_BASE_ECRASH_DELETES, 
																												trim(left.case_identifier,left,right) = trim(right.case_identifier,left,right) and 
																												trim(left.State_Report_Number,left,right) = trim(right.State_Report_Number,left,right) and 
																												trim(left.Source_ID ,left,right)= trim(right.Source_ID ,left,right)and 
																												trim(left.Loss_State_Abbr,left,right) = trim(right.Loss_State_Abbr,left,right) and 
																												trim(left.Crash_Date,left,right) = STD.Str.FilterOut(trim(right.Crash_Date,left,right),'-') and 
																												trim(left.Agency_ID,left,right) = trim(right.Agency_ID,left,right) and 
																												trim(left.Work_Type_ID ,left,right)= trim(right.Work_Type_ID,left,right)  , many lookup , left only ):persist('~thor_data::persist::eCrash_IncidentsAfterSuppression');

