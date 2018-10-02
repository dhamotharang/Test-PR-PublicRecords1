import RoxieKeybuild, _control,tools, Orbit3;
// -- NOTE: EBR_Init_Flag determines if the base file is being included as input.
// --	To include BASE FILE set to false
// -- To include IN FILE set to true
export Proc_Build_All(string filedate) := function
MapRawData				:= Proc_Map_RawData(filedate) 			: success(output('All EBR input files have been mapped successfully'));
build_bases				:= Proc_Build_Base_Files						: success(output('All EBR base files created successfully'));
build_keys				:= Proc_Build_Keys(filedate)				: success(output('All EBR keys created successfully'));
build_autokeys		:= Proc_Buildautokeys(filedate)			: success(output('EBR autokeys created successfully'));
run_stats					:= Query_BDID_Stats								  : success(output('BDID Stats completed successfully'));
superfiles_clear 	:= Clear_All_Input_Superfiles 			: success(output('Cleared all input superfiles'));
accept_sk_to_qa		:= Proc_Accept_SK_to_QA;
accept_sk_to_qa_LD:= Proc_Accept_SK_to_QA_LinkIDs;
output_new_recs		:= Query_New_Records;
send_email 				:= Send_Build_Completion_Email(filedate);
updatedops    	  := RoxieKeyBuild.updateversion('EBRKeys',filedate,_Control.MyInfo.EmailAddressNotify,,'N');
orbit_update := Orbit3.proc_Orbit3_CreateBuild_AddItem('EBR',(filedate),'N'); 



retval := sequential(
 	MapRawData
	,build_bases
	,build_keys
	,build_autokeys
	,updatedops
 ,orbit_update
	,run_stats
	,superfiles_clear
	,output_new_recs
	,accept_sk_to_qa
	,accept_sk_to_qa_LD	//move LinkIDS to QA
	,Out_Population_Stats(filedate).All
	,send_email
);

return retval;

end;
