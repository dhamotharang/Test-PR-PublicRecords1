import _Control;
EXPORT TrackID(
								string trackid = ''
								,string location = dops.constants.location
								,string updatedby = thorlib.jobowner()
								,string dopsenv = dops.constants.dopsenvironment
								) := module
	
	export flatrec := record
		
		string location;
		string updatedby;
		string trackid;
		string wuid;
		set of string trackinginfo;
	end;
	
	export trackqasuper := '~thor::track::qa::ids';
	export trackusingsuper := '~thor::track::using::ids';
	export trackdeletesuper := '~thor::track::delete::ids';
	
	export writetofile(set of string trackset) := if (trackset[1] = 'NA' or trackset[2] = 'NA' or trackset[3] = 'NA' , 
																output('No tracking for ' + trackid),
																if (stringlib.stringtouppercase(trackset[2]) NOT IN dops.constants.environmentset or count(trackset) <> 3,
																output('Incorrect values passed to tracking set, should be [<dops datasetname>,<build version>, <environment flag = N - Nonfcra/F - FCRA/B - Boolean>]'),
																	output(dataset([{location, updatedby, trackid, WORKUNIT, trackset}],flatrec),,trackqasuper+'::'+trackid+'_'+WORKUNIT,overwrite)
																	)
																);
																
	export getidfilelist := fileservices.logicalfilelist(regexreplace('~',trackqasuper+'::*',''));	
	
	export addtosuper := nothor(apply
												(
											global(getidfilelist,few),
											fileservices.addsuperfile(trackqasuper,'~'+name)
												));
	
		
	export UpdateTrackingInfo(string l_dsname
										,string l_location
										,string l_cluster
										,string l_buildversion
										,string l_updatedby
										,string l_trackid
										,string l_wuid) := function
	
		InputRec := record
			string datasetname{xpath('datasetname')} := l_dsname;
			string location{xpath('location')} := l_location;
			string cluster{xpath('cluster')} := l_cluster;
			string buildversion{xpath('buildversion')} := l_buildversion;
			string updatedby{xpath('updatedby')} := l_updatedby;
			string trackid{xpath('trackid')} := l_trackid;
			string wuid{xpath('wuid')} := l_wuid;
		end;
	
		outrec := record
			string statuscode {xpath('status/statuscode')};
			string statusdescription {xpath('status/statusdescription')};
		end;
	
		soapresults := SOAPCALL(
				dops.constants.prboca.serviceurl(dopsenv),
				'UpdateTrackingInfo',
				InputRec,
				dataset(outrec),
				xpath('UpdateTrackingInfoResponse/UpdateTrackingInfoResult'),
				//dataset(outrec),
				NAMESPACE('http://lexisnexis.com/'),
				LITERAL,
				SOAPACTION('http://lexisnexis.com/UpdateTrackingInfo'));
	
	
		return soapresults;
		
	end;
	
	export Tracking() := function
	
		gettrackinfo := dataset(trackqasuper,flatrec,thor,opt);
	
		statusresults := record
			string statuscode {xpath('status/statuscode')};
			string statusdescription {xpath('status/statusdescription')};
		end;
		
		results := record
			string trackid;
			string datasetname;
			string clusterflag;
			string buildversion;
			string updatedby;
			string location;
			string wuid;
			dataset(statusresults) sres;
		end;
		
		results getuniqrecs(gettrackinfo l) := transform
			self.trackid := l.trackid;
			self.datasetname := l.trackinginfo[1];
			self.clusterflag := l.trackinginfo[3];
			self.buildversion := l.trackinginfo[2];
			self.updatedby := l.updatedby;
			self.location := l.location;
			self.wuid := l.wuid;
			self.sres := dataset([],statusresults);
		end;
		
		getuniqs := dedup(sort(project(gettrackinfo,getuniqrecs(left)), 
													trackid, datasetname, clusterflag, buildversion, location, -wuid),
											trackid, datasetname, clusterflag, buildversion, location, keep(1));
		
		results updatedops(getuniqs l) := transform
			
			self.sres := UpdateTrackingInfo(l.datasetname
										,l.location
										,l.clusterflag
										,l.buildversion
										,l.updatedby
										,l.trackid
										,l.wuid);
			self := l;
		end;
		
		getresults := project(getuniqs,updatedops(left));
		
		return getresults;
		
	end;
	
	
	export createsupers := sequential(
											if (~fileservices.superfileexists(trackqasuper),
													fileservices.createsuperfile(trackqasuper)),
											if (~fileservices.superfileexists(trackdeletesuper),
													fileservices.createsuperfile(trackdeletesuper))
													);
	
	// to run manually when a job fails.
	export rerun := sequential
														(
															fileservices.clearsuperfile(trackdeletesuper,true),
															
															addtosuper,
															output(Tracking()),
															fileservices.addsuperfile(trackdeletesuper,trackqasuper,,true),
															fileservices.clearsuperfile(trackqasuper)
															
														);	
	
	export run := if (count (getidfilelist) > 0,
									sequential(
											createsupers,
											if (fileservices.getsuperfilesubcount(trackqasuper) > 0,
													output('Another process running'),
													sequential
														(
															fileservices.clearsuperfile(trackdeletesuper,true),
															
															addtosuper,
															output(Tracking()),
															fileservices.addsuperfile(trackdeletesuper,trackqasuper,,true),
															fileservices.clearsuperfile(trackqasuper)
															
															)
													)
											),
											output('Nothing to track')
										);
	
end;