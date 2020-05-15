IMPORT lib_fileservices,data_services,STD;

EXPORT GrowthCheck(string filedate) := module

EXPORT mac_calculatestats(dataset(recordof(overrides.File_Override_Orphans.orphan_rec)) in_base) := function

	statsout := sort(table(in_base,{datagroup,	 CountGroup	:= COUNT(GROUP)},datagroup, few),datagroup);
	
	return statsout;
 
	end;
	
EXPORT Stats_Layout	:= RECORD
				string datagroup;
				string CurrVersion;
				string PrevVersion;
				string CurrCount;
				string PrevCount;
				string DelTaResults;
				string DelTaPassed;
				string OrphansValidated;
			END;

orphans_ds := dataset(data_services.foreign_prod + 'thor_data400::lookup::override::' + filedate + '::orphans', overrides.File_Override_Orphans.orphan_rec, thor);
orphans_ds_old := overrides.File_Override_Orphans.orphan_file;
	
	statscal_new := mac_calculatestats(orphans_ds);
  statscal_old := mac_calculatestats(orphans_ds_old);
	
statsout_new := project(statscal_new, transform(Stats_Layout, self.CurrVersion := filedate,
self.CurrCount := (string)left.countgroup, self := left, self := []));
	
sc 			:= nothor(fileservices.superfilecontents(data_services.foreign_prod + 'thor_data400::lookup::override::orphans'))[1].name;
		findex 	:= stringlib.stringfind(sc, '::', 3)+2;
		lindex 	:= stringlib.stringfind(sc, '::', 4)-1;
		
father_filedate := sc[findex..lindex];

statsout_old := project(statscal_old, transform(Stats_Layout, self.CurrVersion := father_filedate,
self.PrevCount := (string)left.countgroup, self := left, self := []));

overrides.mac_orphans_validate(gong,'gong',orphans_ds, dsout_gong,did,persistent_record_id);
overrides.mac_orphans_validate(american_student_new,'student_new',orphans_ds,dsout_student_new,did,key);
overrides.mac_orphans_validate(alloy,'alloy',orphans_ds,dsout_alloy,did,sequence_number,key_code,rawaid);
overrides.mac_orphans_validate(infutor,'infutor',orphans_ds,dsout_infutor,did,persistent_record_id);
overrides.mac_orphans_validate(paw,'paw',orphans_ds,dsout_paw,did,contact_id);
overrides.mac_orphans_validate(email_data,'email_data',orphans_ds,dsout_email_data,did,email_rec_key);
overrides.mac_orphans_validate(PROFLIC,'proflic',orphans_ds,dsout_proflic,did,prolic_key);
overrides.mac_orphans_validate(PROFLIC_Mari,'proflic_mari',orphans_ds,dsout_proflic_mari,did,persistent_record_id);
overrides.mac_orphans_validate(hunting_fishing,'hunting_fishing',orphans_ds,dsout_hunting_fishing,did_out,persistent_record_id);
overrides.mac_orphans_validate(bankrupt_main,'bankrupt_main',orphans_ds,dsout_bankrupt_main,,tmsid,court_code,case_number);
overrides.mac_orphans_validate(bankrupt_search,'bankrupt_search',orphans_ds,dsout_bankrupt_search,did,tmsid,name_type,did);
overrides.mac_orphans_validate(liensv2_main,'liensv2_main',orphans_ds,dsout_liensv2_main,,persistent_record_id);
overrides.mac_orphans_validate(liensv2_party,'liensv2_party',orphans_ds,dsout_liensv2_party,did,persistent_record_id);

//scale count and also take into account new orphans from new datagroup
statsout_new tCalculateDelTaStats(statsout_new L ,statsout_old R):= transform
                    Self.DelTaResults:= if((unsigned)R.PrevCount = 0,(string)((real)L.CurrCount/100),
										//if((unsigned)L.PrevCount < 10, (string)((((real)L.CurrCount-(real)R.PrevCount)/(real)R.PrevCount)*10), 
										(string)((((real)L.CurrCount-(real)R.PrevCount)/(real)R.PrevCount)*100));
                    Self.CurrVersion:=L.CurrVersion;
                    Self.PrevVersion:=R.CurrVersion;
										Self.PrevCount:=R.PrevCount;
                    Self.DelTaPassed:= if(Self.DelTaResults < overrides.Constants.statsAlert_threshold, 'Y', 'N');
										Self.OrphansValidated := map(L.datagroup = overrides.Constants.GONG and  count(dsout_gong) = 0 => 'Y',
										                   L.datagroup = overrides.Constants.STUDENT_NEW and  count(dsout_student_new) = 0 => 'Y', 
												               L.datagroup = overrides.Constants.ALLOY and  count(dsout_alloy) = 0 => 'Y', 
							 												 L.datagroup = overrides.Constants.INFUTOR and  count(dsout_infutor) = 0 => 'Y', 
							 												 L.datagroup = overrides.Constants.PAW and  count(dsout_paw) = 0 => 'Y', 
							 												 L.datagroup = overrides.Constants.EMAIL_DATA and  count(dsout_email_data) = 0 => 'Y', 
							 												 L.datagroup = overrides.Constants.PROFLIC and  count(dsout_proflic) = 0 => 'Y', 
							 												 L.datagroup = overrides.Constants.PROFLIC_MARI and  count(dsout_proflic_mari) = 0 => 'Y', 
							 												 L.datagroup = overrides.Constants.HUNTING_FISHING and  count(dsout_hunting_fishing) = 0 => 'Y',
																			 L.datagroup = overrides.Constants.BANKRUPT_MAIN and  count(dsout_bankrupt_main) = 0 => 'Y',
							 												 L.datagroup = overrides.Constants.BANKRUPT_SEARCH and  count(dsout_bankrupt_search) = 0 => 'Y',
							 												 L.datagroup = overrides.Constants.LIENSV2_MAIN and  count(dsout_liensv2_main) = 0 => 'Y',
							 												 L.datagroup = overrides.Constants.LIENSV2_PARTY and  count(dsout_liensv2_party) = 0 => 'Y',

																			
																			
																			'N');
                    Self:=L;
                end;
								
NewDeltaStat:=join(statsout_new,statsout_old,Left.datagroup=Right.datagroup,tCalculateDelTaStats(left,right));
	
Publish:=output(NewDeltaStat,,'~thor_data400::DeltaStats::OrphanFileStats::'+workunit,thor,compressed,overwrite);

AddFile:=sequential(STD.FILE.StartSuperFileTransaction(),
                      STD.FILE.AddSuperFile('~thor_data400::DeltaStats::OrphanFileStats','~thor_data400::DeltaStats::OrphanFileStats::'+workunit),
                      STD.File.FinishSuperFileTransaction()
                     );
	
export BuildStats := 				sequential(Publish,AddFile);		

DeltaAlerts := exists(dataset('~thor_data400::DeltaStats::OrphanFileStats', Stats_Layout, thor)(DelTaPassed = 'N'));
ValidAlerts := exists(dataset('~thor_data400::DeltaStats::OrphanFileStats', Stats_Layout, thor)(OrphansValidated = 'N'));

export StatsAlerts := DeltaAlerts or ValidAlerts;
		
end;
	
