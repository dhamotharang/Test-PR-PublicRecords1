/* W20080318-143609
Providers Ingenix
*/

dsProvider := Ingenix_NatlProf.Basefile_Provider_Did;

NewProvLayout := record 
  string8 dt_fseen;
  string8 dt_lseen;
  string8 dt_freport;
  string8 dt_lreport;
  end;

NewProvLayout createSlimFile(ingenix_natlprof.Layout_provider_base InputRecord) := transform
	self.dt_fseen 		:= if (InputRecord.dt_first_seen = '',
														'999999',
														InputRecord.dt_first_seen);
	self.dt_freport 	:= if (InputRecord.dt_vendor_first_reported = '',
														'999999',
														InputRecord.dt_vendor_first_reported);
  self.dt_lseen 		:= if (InputRecord.dt_last_seen = '',
														'0',
														InputRecord.dt_last_seen);
	self.dt_lreport		:= if (InputRecord.dt_vendor_last_reported = '',
														'0',
														InputRecord.dt_vendor_last_reported);
end;	

slimProv := project(dsProvider,createSlimFile(left));

rDev := record
	integer4 Total  := count(group);
	string8 MinDateFirstSeen 			:= if (min(group,slimProv.dt_fseen) = '999999','0', min(group,slimProv.dt_fseen));
  string8 MaxDateLastSeen 			:= max(group,slimProv.dt_lseen);
	string8 MinDateFirstReported 	:= if (min(group,slimProv.dt_freport) = '999999','0', min(group,slimProv.dt_freport));
  string8 MaxDateLastReported		:= max(group,slimProv.dt_lreport);	
  end;

output(dsProvider);

dDevTable := table(slimProv,rDev,few);
output(dDevTable);