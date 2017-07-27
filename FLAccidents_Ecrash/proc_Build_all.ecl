import RoxieKeybuild,ut;
export Proc_Build_all(string filedate):= function
updatedops := if(ut.weekday((integer)filedate) <> 'SATURDAY' and ut.weekday((integer)filedate) <> 'SUNDAY',RoxieKeyBuild.updateversion('ECrashKeys',filedate,'skasavajjala@seisint.com'),output('No_dops_update_on_weekends'));

return
sequential(FLAccidents_Ecrash.Spray()
      ,FLAccidents_Ecrash.map_basefile(filedate)
		  ,FLAccidents_Ecrash.proc_build_Ecrash_keys(filedate)
		  ,FLAccidents_Ecrash.Sample_data
		  ,FLAccidents_Ecrash.strata(filedate)
		  ,updatedops);
end;	