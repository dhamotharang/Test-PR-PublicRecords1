import PRTE_CSV;

export Proc_Build_Override_Pii_Keys(string filedate) := function

// CSV files to read

Override_Pii_did_ds := PRTE_CSV.Override_Pii.dthor_data400__key__override__pii__did;
Override_Pii_ssn_ds := PRTE_CSV.Override_Pii.dthor_data400__key__override__pii__ssn;

// Project to a dataset so it can be used in index action

Override_Pii_did_recs := record
PRTE_CSV.Override_Pii.rthor_data400__key__override__pii__did // record set of the did csv file
end;

Override_Pii_ssn_recs := record
PRTE_CSV.Override_Pii.rthor_data400__key__override__pii__ssn // record set of the ssn csv file
end;

proj_ds_did := project(Override_Pii_did_ds,Override_Pii_did_recs);
proj_ds_ssn := project(Override_Pii_ssn_ds,Override_Pii_ssn_recs);

// index definition - determine the key fields from "view data file" of regular nonfcra key

bld_idx_did := index(proj_ds_did, {s_did},{proj_ds_did}, '~prte::key::override::pii::'+filedate+'::did');
bld_idx_ssn := index(proj_ds_ssn, {ssn},{proj_ds_ssn}, '~prte::key::override::pii::'+filedate+'::ssn');

return sequential(build(bld_idx_did, update),                                                               // build index
                  build(bld_idx_ssn, update),                                                               // build index
				// updates PRTE dops 
				PRTE.UpdateVersion('OverrideKeys',			                                            //	Package name
																filedate,								//	Package version
																'Anantha.Venkatachalam@lexisnexis.com',	//	Who to email with specifics
																'B',									//	B = Boca, A = Alpharetta
																'N',									//	N = Non-FCRA, F = FCRA, B= both FCRA and NonFCRA
																'N'										//	N = Do not also include boolean, Y = Include boolean, too
																));

end;