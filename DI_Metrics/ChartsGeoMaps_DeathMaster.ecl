//----- Death Master Chart by State & DID -- Run this in PROD!! -----//

IMPORT _control,Header, data_services, STD, ut;
export ChartsGeoMaps_DeathMaster(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

Base_Death_SSA := Header.File_DID_Death_MasterV3_ssa;
ddp_Death_SSA_DIDs := dedup(sort(distribute(Base_Death_SSA, hash(did)), did, local), did, local);
tbl_ddp_Death_SSA_DIDs := table(ddp_Death_SSA_DIDs, {state, did_count := count(group)}, state, few);

//Despray CSV to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_death_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_DeathChart_ByStateLexID_'+ filedate +'.csv',
																						pHostname, 
																						pTarget+ '/tbl_ChartsGeoMaps_DeathChart_ByStateLexID_'+ filedate +'.csv'
																						,,,,true);

////Jessica's last wuid: W20190219-131841-Prod

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
					output(sort(tbl_ddp_Death_SSA_DIDs, state),,'~thor_data400::data_insight::data_metrics::tbl_ChartsGeoMaps_DeathChart_ByStateLexID_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
					,despray_death_tbl):
					Success(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_DeathMaster Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'ChartsGeoMaps Group: ChartsGeoMaps_DeathMaster Build Failed', workunit + filedate + '\n' + FAILMESSAGE)
													);
return email_alert;

end;