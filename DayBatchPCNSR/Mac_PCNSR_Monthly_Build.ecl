import _control, Orbit3, Scrubs_PCNSR;

export Mac_PCNSR_Monthly_Build(build_date) := macro

#workunit('name','Yogurt: PCNSR And Build ' + build_date);

// #uniquename(prebuild)
// DayBatchPCNSR.Mac_PCNSR_Monthly_Spray(file_date,build_date,_Control.IPAddress.edata12,_control.TargetGroup.Thor400_84,%prebuild%);
							
#uniquename(get_priority)
#uniquename(build_pcnsr_base)
#uniquename(build_pcnsr_keys)
#uniquename(accept_keys)
#uniquename(email_success)
#uniquename(update_dops)
#uniquename(sample)
#uniquename(strata_stats)

%email_success% := DayBatchPCNSR.mac_Email_Local(build_date);
%build_pcnsr_base% := DayBatchPCNSR.proc_clean_pcnsr;
%build_pcnsr_keys% := DayBatchPCNSR.proc_build_keys(build_date);
%accept_keys% := DayBatchPCNSR.Proc_AcceptSK_ToQA :success(%email_success%),failure(FileServices.sendemail('kgummadi@seisint.com;christopher.brodeur@lexisnexis.com','PCNSR Build Failure',failmessage));
//%strata_stats% := DayBatchPCNSR.Out_Base_PCNSR_Stats(build_date);
%strata_stats% := DayBatchPCNSR.Targus_Base_PCNSR_Stats(build_date);
%update_dops% := roxiekeybuild.updateversion('PCNSRKeys',build_date,'kgummadi@seisint.com;cbrodeur@seisint.com',,'N');
%sample% := output(choosen(DayBatchPCNSR.File_PCNSR_keybuild,100),named('PostProcessMainSample'));
orbit_update := Orbit3.proc_Orbit3_CreateBuild_AddItem('PCNSR',(string)build_date,'N');

sequential(	//%prebuild%,
						%build_PCNSR_base% ,
						%build_PCNSR_keys%,
						%accept_keys%,
						%strata_stats%,
						%update_dops%,
						%sample%,
						Scrubs_PCNSR.fnRunScrubs(build_date,''),
						orbit_update
					)
endmacro;