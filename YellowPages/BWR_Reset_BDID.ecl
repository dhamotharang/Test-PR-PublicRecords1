#workunit('name', 'Yellow Pages Base Reset BDID ' + yellowpages.YellowPages_Reset_Date);

// Change yellowpages.YellowPages_Reset_Date to current date(make sure it is different from 
// yellowpages.YellowPages_Build_Date attribute
// Also change Flags.IsResettingBDID to true

reset_base 		:= yellowpages.Proc_Reset_BDID 		: success(output('yellow pages reset bdid base file created.'));
build_keys 		:= yellowpages.proc_build_keys 		: success(output('yellow pages keys created.'));
accept_QA		:= Proc_Accept_To_QA				: success(output('Yellowpages keys accepted to QA'));
build_output	:= Proc_Build_Output_File			: success(output('yellow pages output File created.'));
State_stats		:= Query_YellowPages_State_Stats	: success(output('yellow pages State Stats finished.'));
Field_stats		:= Query_YP_Field_Stats 			: success(output('yellow pages Field Stats finished.'));


sequential(

			 reset_base
			,build_keys
			,accept_QA
			,build_output
			,State_stats
			,Field_stats
);