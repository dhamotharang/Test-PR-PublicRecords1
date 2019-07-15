import RoxieKeybuild, _control,tools, Orbit3, scrubs, scrubs_EBR;

// -- NOTE: EBR_Init_Flag determines if the base file is being included as input.
// --	To include BASE FILE set to false
// -- To include IN FILE set to true
export Proc_Build_All(string filedate) := function
MapRawData				:= Proc_Map_RawData(filedate) 			: success(output('All EBR input files have been mapped successfully'));
build_bases				:= Proc_Build_Base_Files						: success(output('All EBR base files created successfully'));
scrub_0010_base   := Scrubs.ScrubsPlus('EBR','Scrubs_EBR','Scrubs_EBR_Base_0010','Base_0010' ,filedate,EBR.Email_Notification_Lists.ScrubsPlus,false);
scrub_1000_base   := Scrubs.ScrubsPlus('EBR','Scrubs_EBR','Scrubs_EBR_Base_1000','Base_1000' ,filedate,EBR.Email_Notification_Lists.ScrubsPlus,false);
scrub_2000_base   := Scrubs.ScrubsPlus('EBR','Scrubs_EBR','Scrubs_EBR_Base_2000','Base_2000' ,filedate,EBR.Email_Notification_Lists.ScrubsPlus,false);
scrub_2015_base   := Scrubs.ScrubsPlus('EBR','Scrubs_EBR','Scrubs_EBR_Base_2015','Base_2015' ,filedate,EBR.Email_Notification_Lists.ScrubsPlus,false);
scrub_2020_base   := Scrubs.ScrubsPlus('EBR','Scrubs_EBR','Scrubs_EBR_Base_2020','Base_2020' ,filedate,EBR.Email_Notification_Lists.ScrubsPlus,false);
scrub_2025_base   := Scrubs.ScrubsPlus('EBR','Scrubs_EBR','Scrubs_EBR_Base_2025','Base_2025' ,filedate,EBR.Email_Notification_Lists.ScrubsPlus,false);
scrub_4010_base   := Scrubs.ScrubsPlus('EBR','Scrubs_EBR','Scrubs_EBR_Base_4010','Base_4010' ,filedate,EBR.Email_Notification_Lists.ScrubsPlus,false);
scrub_4020_base   := Scrubs.ScrubsPlus('EBR','Scrubs_EBR','Scrubs_EBR_Base_4020','Base_4020' ,filedate,EBR.Email_Notification_Lists.ScrubsPlus,false);
scrub_4030_base   := Scrubs.ScrubsPlus('EBR','Scrubs_EBR','Scrubs_EBR_Base_4030','Base_4030' ,filedate,EBR.Email_Notification_Lists.ScrubsPlus,false);
scrub_4500_base   := Scrubs.ScrubsPlus('EBR','Scrubs_EBR','Scrubs_EBR_Base_4500','Base_4500' ,filedate,EBR.Email_Notification_Lists.ScrubsPlus,false);
scrub_4510_base   := Scrubs.ScrubsPlus('EBR','Scrubs_EBR','Scrubs_EBR_Base_4510','Base_4510' ,filedate,EBR.Email_Notification_Lists.ScrubsPlus,false);
scrub_5000_base   := Scrubs.ScrubsPlus('EBR','Scrubs_EBR','Scrubs_EBR_Base_5000','Base_5000' ,filedate,EBR.Email_Notification_Lists.ScrubsPlus,false);
scrub_5600_base   := Scrubs.ScrubsPlus('EBR','Scrubs_EBR','Scrubs_EBR_Base_5600','Base_5600' ,filedate,EBR.Email_Notification_Lists.ScrubsPlus,false);
scrub_5610_base   := Scrubs.ScrubsPlus('EBR','Scrubs_EBR','Scrubs_EBR_Base_5610','Base_5610' ,filedate,EBR.Email_Notification_Lists.ScrubsPlus,false);
scrub_6000_base   := Scrubs.ScrubsPlus('EBR','Scrubs_EBR','Scrubs_EBR_Base_6000','Base_6000' ,filedate,EBR.Email_Notification_Lists.ScrubsPlus,false);
scrub_6500_base   := Scrubs.ScrubsPlus('EBR','Scrubs_EBR','Scrubs_EBR_Base_6500','Base_6500' ,filedate,EBR.Email_Notification_Lists.ScrubsPlus,false);
scrub_6510_base   := Scrubs.ScrubsPlus('EBR','Scrubs_EBR','Scrubs_EBR_Base_6510','Base_6510' ,filedate,EBR.Email_Notification_Lists.ScrubsPlus,false);
scrub_7010_base   := Scrubs.ScrubsPlus('EBR','Scrubs_EBR','Scrubs_EBR_Base_7010','Base_7010' ,filedate,EBR.Email_Notification_Lists.ScrubsPlus,false);
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
	,parallel( scrub_0010_base
						,scrub_1000_base
						,scrub_2000_base
						,scrub_2015_base
						,scrub_2020_base
						,scrub_2025_base
						,scrub_4010_base
						,scrub_4020_base
						,scrub_4030_base
						,scrub_4500_base
						,scrub_4510_base
						,scrub_5000_base
						,scrub_5600_base
						,scrub_5610_base
						,scrub_6000_base
						,scrub_6500_base
						,scrub_6510_base
						,scrub_7010_base)
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
