import Versioncontrol, _Control, std;
import Scrubs_Inql_Nfcra_Accurint, Scrubs_Inql_Nfcra_Banko, Scrubs_Inql_Nfcra_Batch;
import Scrubs_Inql_Nfcra_Bridger, Scrubs_Inql_Nfcra_Custom, Scrubs_Inql_Nfcra_Riskwise, Scrubs_Inql_Nfcra_IDM;
import Scrubs_Inql_fcra_Accurint, Scrubs_Inql_fcra_Batch, Scrubs_Inql_fcra_Riskwise;

EXPORT proc_FilesScrub(boolean isFcra = false) := function

  scrub_nonfcra := sequential(
															Scrubs_Inql_Nfcra_Accurint.proc_generate_report(true)
														 ,Scrubs_Inql_Nfcra_Banko.proc_generate_report(true)
														 ,Scrubs_Inql_Nfcra_Batch.proc_generate_report(true)
														 ,Scrubs_Inql_Nfcra_Bridger.proc_generate_report(true)
														 ,Scrubs_Inql_Nfcra_Custom.proc_generate_report(true)
														 ,Scrubs_Inql_Nfcra_Riskwise.proc_generate_report(true)
														 ,Scrubs_Inql_Nfcra_IDM.proc_generate_report(true)	
												);
												
  scrub_fcra 		:= sequential(
															Scrubs_Inql_fcra_Accurint.proc_generate_report(true)
														 ,Scrubs_Inql_fcra_Batch.proc_generate_report(true)
														 ,Scrubs_Inql_fcra_Riskwise.proc_generate_report(true)
												);
	
	_scrubs := if(isFCRA,scrub_fcra, scrub_nonfcra);

  return _scrubs;
	
end;
