
// This macro will copy the portfolio base file from thorwatch to the 400 only if 
// the most current version does not reside in 400 environment yet.  This is needed
// as we will be leaving the portfolio update process on thorwatch for the time being.

EXPORT mac_copy_portfolio_base(pseudo_environment) := MACRO
import Data_Services;
	// FOREIGN FILE INFO
	fn_r3_super_local := '~thor_10_219::base::account_monitoring::prod::portfolio::base' : INDEPENDENT;
	fn_r3_super := Data_Services.foreign_r3_OSS+'thor_10_219::base::account_monitoring::prod::portfolio::base' : INDEPENDENT;
	fn_r3_logical_wu := TRIM(REGEXFIND('base::account_monitoring::prod::portfolio::(basew.*)',
																		 NOTHOR(FileServices.GetSuperFileSubName(fn_r3_super, 1)),
																		 1,
																		 NOCASE),left,right) : INDEPENDENT;
																		 
	// LOCAL FILE INFO
	fn_cluster := AccountMonitoring.constants.FILENAME_CLUSTER : INDEPENDENT;
	fn_super := fn_cluster+'base::account_monitoring::'+pseudo_environment+'::portfolio::base' : INDEPENDENT;
	fn_logical_wu := TRIM(REGEXFIND('base::account_monitoring::'+pseudo_environment+'::portfolio::(basew.*)::',
																	NOTHOR(FileServices.GetSuperFileSubName(fn_super, 1)),
																	1,
																	NOCASE),left,right);
	fn_logical := fn_cluster+'base::account_monitoring::'+pseudo_environment+'::portfolio::'+fn_r3_logical_wu+'::'+thorlib.wuid() : INDEPENDENT;
	fn_logical_foreign_copy := fn_cluster+'base::account_monitoring::'+pseudo_environment+'::portfolio::base_foreign_copy::'+thorlib.wuid() : INDEPENDENT;

	// PORTFOLIO DISTRIBUTION
	ds := DATASET(fn_logical_foreign_copy, AccountMonitoring.layouts.portfolio.base, THOR);
	ds_dist := DISTRIBUTE(ds, HASH32(pid,rid));

	// SEQUENTIAL STEPS
	step1 := NOTHOR(FileServices.Copy(fn_r3_super_local,
																		AccountMonitoring.constants.SPRAY_GROUPNAME,
																		fn_logical_foreign_copy,
																		'10.173.219.13:7070',,,,TRUE,,,TRUE));
	step2 := OUTPUT(ds_dist,,fn_logical,COMPRESSED);
	step3 := AccountMonitoring.Utilities.fn_update_superfiles(fn_super, fn_logical, TRUE, TRUE);
	step4 := NOTHOR(FileServices.DeleteLogicalFile(fn_logical_foreign_copy));
	complete_copy := NOTHOR(OUTPUT('MAC_COPY_PORTFOLIO_BASE => R3 BASE FILE COPY WAS REQUIRED'));
	complete_nocopy := NOTHOR(OUTPUT('MAC_COPY_PORTFOLIO_BASE => R3 BASE FILE COPY WAS NOT REQUIRED'));

	// ONLY COPY FILE IF NEWER FOREIGN PORTFOLIO BASE FILE EXISTS
	CopyPortfolioBase := IF(AccountMonitoring.constants.SPRAY_GROUPNAME = 'thor_10_219' OR fn_r3_logical_wu = fn_logical_wu,
													complete_nocopy,
													SEQUENTIAL(step1, step2, step3, step4, complete_copy));
ENDMACRO;