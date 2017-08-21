import STD,lib_workunitservices,lib_stringlib,thorbackup;
EXPORT WorkunitTimingDetails(string esp
														,string fromemail
														,string toemaillist
														,string p_wuid = ''
														) := module
	shared states := ['completed','aborted','failed'];
	shared startwu := 'W20160101-000000';
	shared endwu := 'W' + (string)STD.Date.Today() + '-' + (string)STD.Date.CurrentTime(true);
	
	
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
		unsigned8 totalcompiletime := 0;
		unsigned8 totaltime := 0;
		unsigned8 totalthortime := 0;
		unsigned8 totalprocesstime := 0;
		unsigned8 totaldfutime := 0;
		string location := dops.constants.location;
		
	end;
	
	export GetWUList() := sort(if (p_wuid = ''
													,lib_workunitservices.WorkunitServices.workunitlist
														(lowwuid := startwu 
															, highwuid := endwu)(stringlib.StringToLowerCase(state) in states)
													,	lib_workunitservices.WorkunitServices.workunitlist
														(lowwuid := p_wuid 
															, highwuid := p_wuid)	
														), wuid);
	
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
		
		
		rDataVizInfo xCaptureTimings(dWUTimingDetails l) := transform
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
			totaltime := endseconds - startseconds;
			dfutime := (unsigned8)(SUM(l.wutimings(regexfind('SPRAY',std.str.touppercase(trim(name,left,right)),nocase)),duration) / 1000);
			self.starttime := s_time;
			self.endtime := e_time;
			self.totaltime := totaltime;
			self.totalthortime :=  thortime;
			self.totalprocesstime :=  processtime;
			self.totaldfutime := dfutime;
			self.totalcompiletime := compiletime;
			self := l;
		end;
		
		dCaptureTimings := project(dWUTimingDetails,xCaptureTimings(left))(starttime <> '' and endtime <> '');
		
		return dCaptureTimings;
		
	end;
	
	export UpdateDOPS() := function
		
		dDetails := GetDetails();
	
		rDataVizInfoXML := record, maxlength(20000)
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
				dops.constants.prboca.serviceurl('dev'),
				'UpdateWUTimings',
				rUpdateWUTimingsRequest,
				dataset(rUpdateWUTimingsResponse),
				xpath('UpdateWUTimingsResponse/UpdateWUTimingsResult'),
				NAMESPACE('http://lexisnexis.com/'),
				LITERAL,
				SOAPACTION('http://lexisnexis.com/UpdateWUTimings')) : independent;
		
		return if (regexfind('hthor', thorlib.cluster())
							,sequential(
									output(rSOAPResponse)
									,if(rSOAPResponse[1].Code = '-1',
											fileservices.sendemail(toemaillist
																				,'WU Timing Details SOAP Errors for ' + esp
																				,'Workunit: ' + workunit + '\n\nReason: ' + rSOAPResponse[1].description
																				,
																				,
																				,fromemail),
											output('No Soap failures')
										))
							,fail('run on a hthor cluster')
						);
		
		
		
	end;
	
	export run() := UpdateDOPS() : success(output('Workunit completed successfully'))
									,failure(dops.GetWUErrorMessages(WORKUNIT
																							,esp
																							,
																							,fromemail
																							,toemaillist)
														);
	
end;