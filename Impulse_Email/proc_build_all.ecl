import PromoteSupers;

export proc_build_all(string file_date, string version_date, string spray_cluster) := function
	
	//email := FileServices.sendemail('qualityassurance@seisint.com','Impulse Email SAMPLE READY','at ' + thorlib.WUID());
	email := FileServices.sendemail('john.freibaum@lexisnexis.com,Randy.Reyes@lexisnexis.com,Abednego.Escobal@lexisnexis.com','Impulse Email SAMPLE READY','at ' + thorlib.WUID());
	
	#workunit('name','Impulse Email Build - ' + file_date + ': v' + version_date);
	
	PromoteSupers.MAC_SF_BuildProcess(proc_build_base(file_date),Impulse_Email.cluster + 'base::impulse_email',buildBase,3);
	
	proc_build_stats(file_date, zRunStatsReference);

	return sequential(spray_Impulse_Email(file_date, version_date, spray_cluster), buildBase, zRunStatsReference, new_record_sample(file_date), email, proc_build_keys(version_date));

end;