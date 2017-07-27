export proc_build_BK_all(filedate)
 :=
  macro

	import BankruptcyV2,RoxieKeyBuild;

	BankruptcyV2.proc_BK_stats(filedate,zRunStatsReference)			
	
	Proc_Build_Base				:= BankruptcyV2.proc_build_base		       : success(output('Bankruptcy Base Files created successfully.'));
	Proc_Build_Keys				:= BankruptcyV2.proc_build_keys(filedate)  : success(output('Keys created successfully.'));
	Proc_Accept_to_QA			:= BankruptcyV2.Proc_Accept_SK_To_QA	   : success(BankruptcyV2.Mac_Email_Local(filedate)), failure(FileServices.sendemail('akayttala@seisint.com', 'BankruptcyV2 Build Failure', failmessage));
	proc_BK_Stats			    := zRunStatsReference					   : success(output('Stats created successfully.'));
	new_records_sample_for_qa	:= BankruptcyV2.New_records_sample; 
	
	sequential(
		 Proc_Build_Base
		,Proc_Build_Keys
		,Proc_Accept_to_QA
		,new_records_sample_for_qa
		,proc_BK_Stats
	);

  endmacro
 ;