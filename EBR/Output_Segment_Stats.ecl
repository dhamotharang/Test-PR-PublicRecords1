export Output_Segment_Stats(segment_code, output_stats) := macro

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Declare value types
//////////////////////////////////////////////////////////////////////////////////////////////
#uniquename(segment_description)
#uniquename(file_in)
#uniquename(file_base)
#uniquename(In_total_records)
#uniquename(Base_total_records)
#uniquename(Base_total_records_With_BDID)
#uniquename(Base_total_records_With_DotID)
#uniquename(Base_total_records_With_DotScore)
#uniquename(Base_total_records_With_DotWeight)
#uniquename(Base_total_records_With_EmpID)
#uniquename(Base_total_records_With_EmpScore)
#uniquename(Base_total_records_With_EmpWeight)
#uniquename(Base_total_records_With_POWID)
#uniquename(Base_total_records_With_POWScore)
#uniquename(Base_total_records_With_POWWeight)
#uniquename(Base_total_records_With_ProxID)
#uniquename(Base_total_records_With_ProxScore)
#uniquename(Base_total_records_With_ProxWeight)
#uniquename(Base_total_records_With_OrgID)
#uniquename(Base_total_records_With_OrgScore)
#uniquename(Base_total_records_With_OrgWeight)
#uniquename(Base_total_records_With_UltID)
#uniquename(Base_total_records_With_UltScore)
#uniquename(Base_total_records_With_UltWeight)
#uniquename(Base_total_records_With_DID)
#uniquename(Base_total_records_With_SSN)
#uniquename(has_did_ssn)

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Set value types
//////////////////////////////////////////////////////////////////////////////////////////////
%segment_description% := ebr.decode_segments(segment_code);
EBR.GetSegmentFile_In(	segment_code,	%file_in%)
EBR.GetSegmentFile_Base(	segment_code,	%file_base%, 'B')

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Segment Stats
//////////////////////////////////////////////////////////////////////////////////////////////
%In_total_records% 										:= count(%file_in%) : global;
%Base_total_records% 									:= count(%file_base%) : global;
%Base_total_records_With_BDID% 				:= count(%file_base%(bdid != 0)) 			: global;
%Base_total_records_With_DotID% 			:= count(%file_base%(DotID != 0)) 		: global;
%Base_total_records_With_DotScore% 		:= count(%file_base%(DotScore != 0)) 	: global;
%Base_total_records_With_DotWeight% 	:= count(%file_base%(DotWeight != 0)) : global;
%Base_total_records_With_EmpID% 			:= count(%file_base%(EmpID != 0)) 		: global;
%Base_total_records_With_EmpScore% 		:= count(%file_base%(EmpScore != 0)) 	: global;
%Base_total_records_With_EmpWeight% 	:= count(%file_base%(EmpWeight != 0)) : global;
%Base_total_records_With_POWID% 			:= count(%file_base%(POWID != 0)) 		: global;
%Base_total_records_With_POWScore% 		:= count(%file_base%(POWScore != 0)) 	: global;
%Base_total_records_With_POWWeight% 	:= count(%file_base%(POWWeight != 0)) : global;
%Base_total_records_With_ProxID% 			:= count(%file_base%(ProxID != 0)) 		: global;
%Base_total_records_With_ProxScore% 	:= count(%file_base%(ProxScore != 0)) : global;
%Base_total_records_With_ProxWeight% 	:= count(%file_base%(ProxWeight != 0)): global;
%Base_total_records_With_OrgID% 			:= count(%file_base%(OrgID != 0)) 		: global;
%Base_total_records_With_OrgScore% 		:= count(%file_base%(OrgScore != 0)) 	: global;
%Base_total_records_With_OrgWeight% 	:= count(%file_base%(OrgWeight != 0)) : global;
%Base_total_records_With_UltID% 			:= count(%file_base%(UltID != 0)) 		: global;
%Base_total_records_With_UltScore% 		:= count(%file_base%(UltScore != 0))  : global;
%Base_total_records_With_UltWeight% 		:= count(%file_base%(UltWeight != 0)) : global;

#if(segment_code = '5610')
%Base_total_records_With_DID% 	:= count(%file_base%(did != 0)) : global;
%Base_total_records_With_SSN% 	:= count(%file_base%(ssn != 0)) : global;
%has_did_ssn%					:= true;
#else
%Base_total_records_With_DID%		:= 0;
%Base_total_records_With_SSN%		:= 0;
%has_did_ssn%					:= false;
#end

output_stats := DATASET([
{segment_code, %segment_description%,%In_total_records%, %Base_total_records%, %Base_total_records_With_BDID%,
%Base_total_records_With_DotID%,%Base_total_records_With_DotScore%,%Base_total_records_With_DotWeight%,
%Base_total_records_With_EmpID%,%Base_total_records_With_EmpScore%,%Base_total_records_With_EmpWeight%, 
%Base_total_records_With_POWScore%,%Base_total_records_With_POWWeight%,%Base_total_records_With_ProxID%,
%Base_total_records_With_ProxID%,%Base_total_records_With_ProxScore%,%Base_total_records_With_ProxWeight%, 
%Base_total_records_With_OrgID%,%Base_total_records_With_OrgScore%,%Base_total_records_With_OrgWeight%, 
%Base_total_records_With_UltID%,%Base_total_records_With_UltScore%,%Base_total_records_With_UltWeight%,
%has_did_ssn%,%Base_total_records_With_DID%, %Base_total_records_With_SSN%}
], ebr.Layout_Segment_Stats);

endmacro;