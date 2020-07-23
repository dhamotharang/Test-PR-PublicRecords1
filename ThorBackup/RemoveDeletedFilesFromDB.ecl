import ut,dops;
EXPORT RemoveDeletedFilesFromDB(string environment,integer noofdays = 0
,string dopsenv = dops.constants.dopsenvironment) := module

shared filedate := thorbackup.constants.yogurt().enddate+thorbackup.constants.yogurt().l_time : independent;
shared desprayfilename := '~yogurt::desrpay::'+regexreplace('-',WORKUNIT[2..],'')+'::deletefilesfromdops';

export getlist() := function
	superlist := sort(thorbackup.Constants.Fulllist(environment),-subname);
	ds := sort(fileservices.logicalfilelist()(ut.DaysApart(regexreplace('-',modified,'')[1..8],ut.GetDate) > thorbackup.constants.getthreshold(noofdays).ndays),-name);
	fromdbds := sort(thorbackup.GetDeleteFilesFromDB(,environment,,,,'2')(ut.DaysApart(regexreplace('-',modified,'')[1..8],ut.GetDate) > thorbackup.constants.getthreshold(noofdays).ndays),-filename);
	// files moved to in super
	typeof(fromdbds) getfilestodelete(superlist l, fromdbds r) := transform
		self := r;
	end;
	
	movedtosupersetds := join(superlist,fromdbds,
												trim(left.subname,left,right) = trim(right.filename,left,right),
												getfilestodelete(left,right)
												);
	// files not on thor
	typeof(fromdbds) getfilestodeletenotinsuper(ds l, fromdbds r) := transform
		self := r;
	end;
	
	notonthorsetds := join(ds,fromdbds,
												trim(left.name,left,right) = trim(right.filename,left,right),
												getfilestodeletenotinsuper(left,right),
												right only
												);

	//setds := dedup(sort(notinthorsetds + notinsupersetds,filename),filename);

	setds := dedup(sort(notonthorsetds + movedtosupersetds,filename),filename);

	integer totcount := count(setds);
	integer baskets := totcount / thorbackup.Constants.getnooffiles().nfiles; // total soapcalls
		
	thorbackup.GetOldFiles(environment,noofdays).layout_filelist numbertherecords(setds l,integer c) := transform
			self.cnt := c;
			self := l;
	end;
		
	numberedrecords := project(setds,numbertherecords(left,counter));
		
		//integer l_basket := 1;
	thorbackup.GetOldFiles(environment,noofdays).layout_filelist itr_recs(numberedrecords l, numberedrecords r) := transform
		self.whichbasket := if (r.cnt > (baskets * l.whichbasket) and r.cnt > (l.whichbasket * thorbackup.Constants.getnooffiles().nfiles),l.whichbasket + 1,l.whichbasket);
		self := r;
			
	end;
		
	groupbaskets := iterate(numberedrecords,itr_recs(left,right));
	
	
	
	return groupbaskets;

end;

	export updatedb(dataset(thorbackup.GetOldFiles(environment,noofdays).layout_filelist) ds) := function
	
		l_filelist := record
			string filename{xpath('filename')};
			string filepattern{xpath('filepattern')};
			string modified{xpath('modified')};
			integer size{xpath('size')};
			string owner{xpath('owner')};
			string cluster{xpath('cluster')};
			integer totalmatchedfiles{xpath('totalmatchedfiles')};
			string daliip{xpath('daliip')};
			string issetfordelete{xpath('issetfordelete')} := '';
			string statuscode{xpath('statuscode')} := '';
			string statusdescription{xpath('statusdescription')} := '';
			integer noofdays{xpath('noofdays')} := 0;
			string emailid{xpath('emailid')} := 'Automation';
			string excludeme{xpath('excludeme')} := '';
		end;
		
		l_filelist proj_recs(ds l) := transform
			self := l;
		end;
		
		proj_out := project(ds,proj_recs(left));
		
		
		filelist := record, maxlength(50000)
			
			dataset(l_filelist) r_filelist{xpath('filelist')};
		end;
		
		filelist tmakefatrecord(proj_out L) := transform
			self.r_filelist   := DATASET([{ l.filename, l.filepattern, l.modified, l.size, l.owner, l.cluster, l.totalmatchedfiles, l.daliip }], l_filelist);
			self := L;
		end;

		file_flat := project(proj_out, tmakefatrecord(left));
		
		
		InputRec := record, maxlength(50000)
			dataset(filelist) d_filelist{xpath('flist')} := file_flat;
			
		end;
	
		
		outrec := record
			string Code{xpath('status/statuscode')};
			string description{xpath('status/statusdescription')};
		end;
	
		soapresults := SOAPCALL(
				dops.constants.prboca.serviceurl(dopsenv),
				'DeleteThorFilesFromDB',
				InputRec,
				outrec,
				xpath('DeleteThorFilesFromDBResponse/DeleteThorFilesFromDBResult'),
				NAMESPACE('http://lexisnexis.com/'),
				LITERAL,
				SOAPACTION('http://lexisnexis.com/DeleteThorFilesFromDB'));
	
		respstatus := record
			string Code;
			string description;
		
		end;
		
		resp := dataset([{soapresults.Code,soapresults.description}],respstatus);
		
		return resp;
	end;
	
	export prepfordespray() := function
		ds := getlist();
		
		string_layout_filelist := record
			string filename;
			string owner;
			string cluster;
			string daliip;
		end;
	
		string_layout_filelist desprayfiles(ds l) := transform
			self := l;
		end;
		
		getfilestodespray := project(ds,desprayfiles(left));
		
		return getfilestodespray;
	end;
	
	
	export DeleteThorFilesFromDB() := function
		ds := getlist();
		
		basketsds := dedup(ds,whichbasket);

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
			
			self.rstatus := updatedb(ds(whichbasket = l.whichbasket));
			self := l;
		end;
		
		soap_response := project(basketsds,make_soap_calls(left));
		
		soapds := dataset('~yogurt::soapcalls::todeletefromdb',soap_recs,thor,opt);
		
		return sequential(
									output(soap_response,,'~yogurt::soapcalls::todeletefromdb',overwrite),
									if(count(soapds(rstatus[1].Code = '-1')) > 0,
										fileservices.sendemail(thorbackup.constants.yogurt().emailerrors,
			'Yogurt DeleteFromDB Soap Calls failed on ' + environment +' - ' + filedate,
			'workunit: ' + workunit),
										output('No Soap failures')
											)
									);
	end;
	export run :=  DeleteThorFilesFromDB() : failure(fileservices.sendemail(thorbackup.constants.yogurt().emailerrors,
			'Yogurt DeleteFromDB Soap Calls failed on ' + environment +' - ' + filedate,
			'workunit: ' + workunit));	

	export despray :=  sequential(
										output(prepfordespray(),,desprayfilename,overwrite,csv),
										fileservices.Despray(desprayfilename,Constants.Yogurt().destip,Constants.Yogurt().destlocation + '/deletefilesfromdops_'+regexreplace('-',WORKUNIT[2..],''),,,,TRUE),
										fileservices.deletelogicalfile(desprayfilename)
										) : failure(fileservices.sendemail(thorbackup.constants.yogurt().emailerrors,
			environment + ' DOPS DB Delete Prep failed - ' + filedate,
			'workunit: ' + workunit+ '\r\n' + failmessage
																	,
																	,
																	,thorbackup.constants.yogurt().senderemail));	
	
end;