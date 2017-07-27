export Layout_Segment_Stats := 
record
	STRING4 	code;
	STRING30 	description;
	unsigned4 Total_update_records 								:= 0;
	unsigned4 Total_base_records 									:= 0;
	unsigned4 Total_base_records_with_bdid				:= 0;
	unsigned4 Total_base_records_with_DotID 			:= 0;
	unsigned4 Total_base_records_with_DotScore 		:= 0;
	unsigned4 Total_base_records_with_DotWeight 	:= 0;
	unsigned4 Total_base_records_with_EmpID 			:= 0;
	unsigned4 Total_base_records_with_EmpScore 		:= 0;
	unsigned4 Total_base_records_with_EmpWeight 	:= 0;
	unsigned4 Total_base_records_with_POWID 			:= 0;
	unsigned4 Total_base_records_with_POWScore 		:= 0;
	unsigned4 Total_base_records_with_POWWeight 	:= 0;
	unsigned4 Total_base_records_with_ProxID 			:= 0;
	unsigned4 Total_base_records_with_ProxScore 	:= 0;
	unsigned4 Total_base_records_with_ProxWeight 	:= 0;
	unsigned4 Total_base_records_with_OrgID 			:= 0;
	unsigned4 Total_base_records_with_OrgScore 		:= 0;
	unsigned4 Total_base_records_with_OrgWeight 	:= 0;
	unsigned4 Total_base_records_with_UltID 			:= 0;
	unsigned4 Total_base_records_with_UltScore 		:= 0;
	unsigned4 Total_base_records_with_UltWeight 	:= 0;	
	boolean 	has_did_ssn													:= false;
	unsigned4 Total_base_records_with_did					:= 0;
	unsigned4 Total_base_records_with_ssn					:= 0;
end;
