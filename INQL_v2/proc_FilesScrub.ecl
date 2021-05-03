import Versioncontrol, _Control, std;
import Scrubs_Inql_Nonfcra_Accurint, Scrubs_Inql_Nonfcra_Banko, Scrubs_Inql_Nonfcra_Batch;
import Scrubs_Inql_Nonfcra_Bridger, Scrubs_Inql_Nonfcra_Custom, Scrubs_Inql_Nonfcra_Riskwise, Scrubs_Inql_Nonfcra_IDM;
import Scrubs_Inql_fcra_Accurint, Scrubs_Inql_fcra_Batch, Scrubs_Inql_fcra_Riskwise;

EXPORT proc_FilesScrub(boolean isFcra = false) := function

  scrub_nonfcra := sequential(
															Scrubs_Inql_Nonfcra_Accurint.proc_generate_report(true)
														 ,Scrubs_Inql_Nonfcra_Banko.proc_generate_report(true)
														 ,Scrubs_Inql_Nonfcra_Batch.proc_generate_report(true)
														 ,Scrubs_Inql_Nonfcra_Bridger.proc_generate_report(true)
														 ,Scrubs_Inql_Nonfcra_Custom.proc_generate_report(true)
														 ,Scrubs_Inql_Nonfcra_Riskwise.proc_generate_report(true)
														 ,Scrubs_Inql_Nonfcra_IDM.proc_generate_report(true)	
												);
												
  scrub_fcra 		:= sequential(
															Scrubs_Inql_fcra_Accurint.proc_generate_report(true)
														 ,Scrubs_Inql_fcra_Batch.proc_generate_report(true)
														 ,Scrubs_Inql_fcra_Riskwise.proc_generate_report(true)
												);
	
	_scrubs := if(isFCRA,scrub_fcra, scrub_nonfcra);

  return _scrubs;
	
end;
