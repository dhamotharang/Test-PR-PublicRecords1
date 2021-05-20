IMPORT Header_Crosswalk;
IMPORT STD;

STRING build_version := STD.Date.DateToString(STD.Date.CurrentDate(), '%Y%m%d');
#WORKUNIT('name', 'Header Crosswalk ' + build_version);

SEQUENTIAL(
  Header_Crosswalk.proc_build(build_version);
  Header_Crosswalk.proc_summary(build_version);
  Header_Crosswalk.proc_build_report(build_version);
  Header_Crosswalk.mod_build_update.proc_update_orbit(build_version);
  Header_Crosswalk.mod_build_update.proc_update_public_records_dops(build_version);
  Header_Crosswalk.proc_replicate_keys(build_version);
) : WHEN(CRON('0 0 * * 6')); // Runs every saturday at midnight