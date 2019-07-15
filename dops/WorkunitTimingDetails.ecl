import STD,lib_workunitservices,lib_stringlib;
EXPORT WorkunitTimingDetails(string esp
														,string fromemail
														,string toemaillist
														// includeendtime = true to capture only WU's that have both start and endtime
														// some WU's don't have end time and it may be needed for various other process
														,boolean includeendtime = true
														,string dopsenv = dops.constants.dopsenvironment
														) := module
	shared states := ['completed','aborted','failed'];
	// no of workunits in dev is more compared to prod, hence limiting the count else
	// it is failing with buffer overlimit error
	shared noofdaysbehind := if (dopsenv = 'dev',1,1);
	shared startwu := 'W' + (string)STD.Date.AdjustDate(STD.Date.Today(),0,0,-noofdaysbehind) + '-' + (string)STD.Date.CurrentTime(true);
	shared endwu := 'W' + (string)STD.Date.Today() + '-' + (string)STD.Date.CurrentTime(true);
	shared integer nooffilesperbasket := 100;
	shared integer baskets := 2000;
	
	export rWUTimingDetails := record, maxlength(20000)
		string wuid;
		string job;
		string owner;
		string clustername;
		string state;
		string starttime := '';
		string endtime := '';
		integer totaltime := 0;
		integer totalthortime := 0;
		integer totalprocesstime := 0;
		integer totaldfutime := 0;
		string dfujobid := '';
		dataset(lib_workunitservices.WsTiming) wutimings;
		dataset(lib_workunitservices.WsTimeStamp) wutimestamp;
	end;
	
	export rDataVizInfo := record, maxlength(20000)
		string wuid;
		string job;
		string owner;
		string clustername;
		string state;
		string starttime := '';
		string endtime := '';
		string dfujobid := '';
		unsigned8 totalcompiletime := 0;
		unsigned8 totaltime := 0;
		unsigned8 totalthortime := 0;
		unsigned8 totalprocesstime := 0;
		unsigned8 totaldfutime := 0;
		integer whichbasket := 0;
		integer cnt := 0;
		string location := dops.constants.location;
		
	end;
	
	export GetWUList() := sort(lib_workunitservices.WorkunitServices.workunitlist
														(lowwuid := startwu 
															, highwuid := endwu)(stringlib.StringToLowerCase(state) in states and job <> ''), wuid);
	
	
	
	export GetDetails() := function
	
		dGetWUList := GetWUList();
		
		rWUTimingDetails xConvertToLocalLayout(dGetWUList l) := transform
			
			self.wuid := l.wuid;
			self.clustername := l.cluster;
			self.wutimings := sort(lib_workunitservices.workunitServices.WorkunitTimings(trim(l.wuid,left,right)),name,-duration);
			self.wutimestamp := lib_workunitservices.WorkunitServices.WorkunitTimeStamps(trim(l.wuid,left,right));
			self := l;
		end;
		
		dWUTimingDetails := project(dGetWUList,xConvertToLocalLayout(left));
		
		rWUTimingDetails xGetDFUWUIDs(dWUTimingDetails l,lib_workunitservices.WsTiming r) := transform
			self.dfujobid := if (regexfind('SPRAY',std.str.touppercase(trim(r.name,left,right)),nocase)
														,STD.Str.SplitWords(r.name,'(')[1]
														,'');
			self := l;
		end;
		
		dGetDFUWUIDs := dedup(sort(normalize(dWUTimingDetails,left.wutimings,xGetDFUWUIDs(left,right)),wuid), record);
		
		rDataVizInfo xCaptureTimings(dGetDFUWUIDs l,integer c) := transform
			s_time := l.wutimestamp(trim(id,left,right) = 'Created')[1].time;
			e_time := sort(l.wutimestamp(trim(id,left,right) = 'QueryFinished'),-time)[1].time;
			startseconds := if (s_time <> '',STD.Date.SecondsFromParts((integer)s_time[1..4]
																												,(integer)s_time[6..7]
																												,(integer)s_time[9..10]
																												,(integer)s_time[12..13]
																												,(integer)s_time[15..16]
																												,(integer)s_time[18..19]
																												,true)
																						,0);
			endseconds := if (e_time <> '',STD.Date.SecondsFromParts((integer)e_time[1..4]
																												,(integer)e_time[6..7]
																												,(integer)e_time[9..10]
																												,(integer)e_time[12..13]
																												,(integer)e_time[15..16]
																												,(integer)e_time[18..19]
																												,true)
																						,0);
			thortime := (unsigned8)(l.wutimings(trim(name,left,right) = 'Total thor time' or trim(name,left,right) = 'Total cluster time')[1].duration / 1000);
			processtime := (unsigned8)(l.wutimings(trim(name,left,right) = 'Process')[1].duration / 1000);
			compiletime := (unsigned8)(l.wutimings(trim(name,left,right) = 'compile')[1].duration / 1000);
			totaltime := if (endseconds > startseconds, endseconds - startseconds, startseconds - endseconds);
			dfutime := (unsigned8)(SUM(l.wutimings(regexfind('SPRAY',std.str.touppercase(trim(name,left,right)),nocase)),duration) / 1000);
			self.starttime := s_time;
			self.endtime := e_time;
			self.totaltime := totaltime;
			self.totalthortime :=  thortime;
			self.totalprocesstime :=  processtime;
			self.totaldfutime := dfutime;
			self.totalcompiletime := compiletime;
			self.cnt := c;
			self.job := regexreplace('[\'â]',l.job,'');
			self := l;
		end;
		
		dCaptureTimings := if (includeendtime
															,project(dGetDFUWUIDs,xCaptureTimings(left,counter))(starttime <> '' and endtime <> '')
															,project(dGetDFUWUIDs,xCaptureTimings(left,counter))
															);
		
		rDataVizInfo itr_recs(dCaptureTimings l, dCaptureTimings r) := transform
			self.whichbasket := if (r.cnt > (l.whichbasket * nooffilesperbasket),l.whichbasket + 1,l.whichbasket);
			self := r;
			
		end;
		
		dgroupbaskets := iterate(dCaptureTimings,itr_recs(left,right));
		
				
		return dedup(dgroupbaskets,record,except dfujobid, cnt, whichbasket);
		
	end;
	
	export UpdateDOPSDB(dataset(rDataVizInfo) dDetails) := function
		
		//dDetails := GetDetails();
	
		rDataVizInfoXML := record
			string wuid{xpath('wuid')};
			string job{xpath('job')};
			string owner{xpath('owner')};
			string clustername{xpath('clustername')};
			string state{xpath('state')};
			string starttime{xpath('starttime')};
			string endtime{xpath('endtime')};
			string totalcompiletime{xpath('totalcompiletime')};
			string totaltime{xpath('totaltime')};
			string totalthortime{xpath('totalthortime')};
			string totalprocesstime{xpath('totalprocesstime')};
			string totaldfutime{xpath('totaldfutime')};
			string location{xpath('location')};
			//unsigned8 totaldfutime := 0;
		end;
	
		rWUList := record, maxlength(50000)
			dataset(rDataVizInfoXML) WUList{xpath('wulist')};
		end;
		
		rWUList xWUList(dDetails L) := transform
			self.WUList   := DATASET([{ trim(l.wuid,left,right), trim(l.job,left,right), trim(l.owner,left,right), trim(l.clustername,left,right), trim(l.state,left,right), trim(l.starttime,left,right), trim(l.endtime,left,right), (string)l.totalcompiletime, (string)l.totaltime, (string)l.totalthortime, (string)l.totalprocesstime, (string)l.totaldfutime, l.location}], rDataVizInfoXML);
			self := L;
		end;

		dWUList := project(dDetails, xWUList(left));


		rUpdateWUTimingsRequest := record, maxlength(50000)
			dataset(rWUList) wlist{xpath('wlist')} := dWUList;
		end;
		
		rUpdateWUTimingsRequest xrUpdateWUTimingsRequest(dWUList l) := transform
			self.wlist := dWUList;
		end;
		
		
	
		rUpdateWUTimingsResponse := record
			string Code{xpath('status/statuscode')};
			string description{xpath('status/statusdescription')};
		end;
	
		rSOAPResponse := SOAPCALL(
				dops.constants.prboca.serviceurl(dopsenv),
				'UpdateWUTimings',
				rUpdateWUTimingsRequest,
				rUpdateWUTimingsResponse,
				xpath('UpdateWUTimingsResponse/UpdateWUTimingsResult'),
				NAMESPACE('http://lexisnexis.com/'),
				LITERAL,
				SOAPACTION('http://lexisnexis.com/UpdateWUTimings'));
		
		respstatus := record
			string Code;
			string description;
		
		end;
		
		resp := dataset([{rSOAPResponse.Code,rSOAPResponse.description}],respstatus);
		
		return resp;
		
		
	end;

	export UpdateDOPS() := function
		dDetails := GetDetails() : independent;
		
		basketsds := dedup(dDetails,whichbasket);

		respstatus := record
			string Code;
			string description;
		
		end;
		
		soap_recs := record
			integer whichbasket;
			//integer flagforemail := 0;
			dataset(respstatus) rstatus;
		end;
		
		soap_recs make_soap_calls(basketsds l) := transform
			
			self.rstatus := UpdateDOPSDB(dDetails(whichbasket = l.whichbasket));
			self := l;
		end;
		
		soap_response := project(basketsds,make_soap_calls(left));
		
		soapds := dataset('~dataops::soapcalls::wutimingstoupdatedb',soap_recs,thor,opt);
		
		return if (regexfind('hthor', thorlib.cluster())
						,if (~fileservices.fileexists('~wutimings::job::running')
								,sequential(
									output(dataset([{WORKUNIT}],{string wuid}),,'~wutimings::job::running',overwrite)
									,output(dDetails,,'~dataops::wutimings::presoapcall',overwrite)
									//output(choosen(ds,100)),
									,output(soap_response,,'~dataops::soapcalls::wutimingstoupdatedb',overwrite),
									if(count(soapds(rstatus[1].Code = '-1')) > 0,
									sequential(
										//output(choosen(soapds(rstatus[1].Code = '-1'),100)),
										fileservices.sendemail(toemaillist,
			'WU Timings Soap Calls failed - ' + Std.Date.SecondsToString(Std.Date.CurrentSeconds(TRUE), '%F%H%M%S%u'),
			'workunit: ' + workunit
																	,
																	,
																	,fromemail)),
										output('No Soap failures'))
										,fileservices.deletelogicalfile('~wutimings::job::running')
											
									)
									,output('Another job running')
								)
							,fail('run on a hthor cluster'));
									
			
	end;
	
	
	export run() := UpdateDOPS() : success(output('Workunit completed successfully'))
									,failure(sequential
															(dops.GetWUErrorMessages(WORKUNIT
																							,esp
																							,
																							,fromemail
																							,toemaillist)
																,fileservices.deletelogicalfile('~wutimings::job::running'))
														);
end;