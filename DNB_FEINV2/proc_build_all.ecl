﻿IMPORT RoxieKeybuild, Scrubs, ut, STD, Scrubs_DNB_FEIN, dops;

EXPORT proc_build_all(filedate,addresses,retval) := MACRO

	//import DNB_FEINv2,RoxieKeyBuild;
	#uniquename(zRunStatsReference)
	DNB_FEINV2.proc_dnbfein_stats(filedate,%zRunStatsReference%);
	#uniquename(Proc_Build_Base)
	#uniquename(Proc_Scrub_Base)
	#uniquename(Proc_Build_keys)
	#uniquename(Proc_accept_to_QA)
	#uniquename(new_records_sample_for_qa)
	#uniquename(Proc_dnbfein_Base)
	#uniquename(build_boolean_key)
	#uniquename(Proc_Update_RoxiePage)

	%Proc_Build_Base% := DNB_FEINv2.proc_build_main_base(filedate): SUCCESS(OUTPUT('Dnb_Fein Base Files created successfully.'));

	%Proc_Scrub_Base% := Scrubs.ScrubsPlus(
		'DNB_FEIN',
		'Scrubs_DNB_FEIN',
		'Scrubs_DNB_FEIN_Base',
		'Base',
		filedate,
		DNB_FEINv2.Email_Notification_Lists(addresses).ScrubsPlus,
		false
	): SUCCESS(OUTPUT('Dnb_Fein Base Files scrubbed successfully.'));

	%Proc_Build_Keys% := DNB_FEINv2.proc_build_keys(filedate): SUCCESS(OUTPUT('Dnb_Fein Keys created successfully.'));

	%Proc_Accept_to_QA% := DNB_FEINv2.proc_AcceptSK_ToQA: SUCCESS(DNB_FEINv2.Mac_Email_Local(addresses,filedate)), 
		FAILURE(
			STD.System.Email.SendEmail(
				DNB_FEINv2.Email_Notification_Lists(addresses).BuildFailure,
				'DNB_FEIN Build Failure',
				failmessage
			)
		);

	//%proc_dnbfein_Stats% := %zRunStatsReference%: SUCCESS(OUTPUT('Dnb_Fein Stats created successfully.'));

	%new_records_sample_for_qa% := DNB_FEINv2.New_records_sample: SUCCESS(DNB_FEINv2.Send_Email(filedate,addresses).Build_Completion);

	%build_boolean_key% := DNB_FEINv2.Proc_Build_Boolean_keys(filedate);

	// %Proc_Update_RoxiePage% := RoxieKeybuild.updateversion('DNBFEINV2Keys', filedate, DNB_FEINv2.Email_Notification_Lists(addresses).Roxie,,'N|B');

	%Proc_Update_RoxiePage% := dops.updateversion(
		'DNBFEINV2Keys',
		filedate,
		DNB_FEINv2.Email_Notification_Lists(addresses).Roxie,,
		'N|B'
	);

	retval := SEQUENTIAL(
		%Proc_Build_Base%,
		%Proc_Scrub_Base%,
		%Proc_Build_Keys%,
		%build_boolean_key%,
		%Proc_Accept_to_QA%,
		%Proc_Update_RoxiePage%,
		%new_records_sample_for_qa%,
		%zRunStatsReference%
	);

ENDMACRO;
