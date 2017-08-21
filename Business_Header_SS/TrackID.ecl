import _Control,dops;
EXPORT TrackID(
								string trackid
								,string location = dops.constants.location
								,string updatedby = thorlib.jobowner()
								
								) := module
	
	export flatrec := record
		
		string location;
		string updatedby;
		string trackid;
		string wuid;
		set of string trackinginfo;
	end;
	
	export trackqasuper := '~thor::track::qa::ids';
	
	export writetofile(set of string trackset) := if (_Control.ThisEnvironment.Name = 'Dataland',
																								output('No tracking in dev'),
																			if (trackset[1] = 'NA' or trackset[2] = 'NA' or trackset[3] = 'NA' , 
																output('No tracking for ' + trackid),
																if (stringlib.stringtouppercase(trackset[3]) NOT IN dops.constants.environmentset or count(trackset) <> 3,
																output('Incorrect values passed to tracking set, should be [<dops datasetname>,<build version>, <environment flag = N - Nonfcra/F - FCRA/B - Boolean>]'),
																	output(dataset([{location, updatedby, trackid, WORKUNIT, trackset}],flatrec),,trackqasuper+'::'+trackid+'_'+WORKUNIT,overwrite)
																	)
																)
																);
	
	
end;