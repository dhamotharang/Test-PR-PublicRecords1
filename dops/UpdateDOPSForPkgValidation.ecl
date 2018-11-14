import STD;
// This is called from dops.updateversion
EXPORT UpdateDOPSForPkgValidation(
										string l_dopsdatasetname
										,string l_buildversion
										,string l_environmentflag // Q - QA or P for Prod
										,string l_clusterflag // F - FCRA, N - NonFCRA, B - Boolean
										,string l_locationflag = dops.constants.location
										,string l_dopsenv = dops.constants.dopsenvironment
										,string l_daliip = ''
										,string l_email = ''
										,string l_testenv = 'NA'
										) := module

	export rKeyInfo := record
			string datasetname;
			string superkey;
			string logicalkey;
			integer recordcount := 0;
			integer size := 0;
			string clusterflag;
			string environmentflag;
			string locationflag;
			string statuscode := '';
			string statusdescription := '';
	end;

	export GetKeyInfo() := function
		
		dGetKeyswithVersion := dops.GetRoxieKeys(l_dopsdatasetname,l_locationflag,l_clusterflag,dopsenv := l_dopsenv);
	
		
	
		rKeyInfo xKeyWithVersion(dGetKeyswithVersion l) := transform
			string replacedkey := regexreplace(trim(l_dopsdatasetname,left,right)+'_DATE',l.logicalkey,trim(l_buildversion,left,right),nocase);
			boolean isavailable := STD.File.FileExists(if (l_daliip <> '','~foreign::'+l_daliip+'::'+replacedkey,'~'+replacedkey));
			self.superkey := l.superkey;
			self.logicalkey := replacedkey;
			self.datasetname := trim(l_dopsdatasetname,left,right);
			self.clusterflag := trim(l_clusterflag,left,right);
			self.environmentflag := trim(l_environmentflag,left,right);
			self.locationflag := trim(l_locationflag,left,right);
			self.recordcount := if (isavailable
														,if(l_daliip <> ''
															,STD.File.LogicalFileList(replacedkey,foreigndali:=l_daliip)
															,STD.File.LogicalFileList(replacedkey)
															)[1].rowcount
														,-1
														);
			self.size := if (isavailable
													,if(l_daliip <> ''
															,STD.File.LogicalFileList(replacedkey,foreigndali:=l_daliip)
															,STD.File.LogicalFileList(replacedkey)
														)[1].size
													,-1
										);
			self := l;
		end;
	
		dKeyWithVersion := nothor(project(global(dGetKeyswithVersion,few),xKeyWithVersion(left)));

		return dKeyWithVersion;
	
	end;

	export UpdateInfo() := function
	
		dKeyInfo := GetKeyInfo();
		
		rUpdateKeyInfo := record
			string datasetname{xpath('datasetname')};
			string cluster{xpath('cluster')};
      string environment{xpath('environment')};
			string location{xpath('location')};
      string buildversion{xpath('buildversion')};
      string superkey{xpath('superkey')}; // time when the info was first captured
      string logicalkey{xpath('logicalkey')};
      string size{xpath('size')};
      string recordcount{xpath('recordcount')}; // time when WU was created
      string statuscode{xpath('statuscode')};
			string statusdescription {xpath('statusdescription')};
			
			
		end;
	
		rKIList := record, maxlength(50000)
			dataset(rUpdateKeyInfo) KIList{xpath('pkgvalidation')};
		end;
		
		rKIList xKIList(dKeyInfo L) := transform
			self.KIList   := DATASET([{ trim(l.datasetname,left,right)
																	,trim(l.clusterflag,left,right)
																	,trim(l.environmentflag,left,right)
																	,trim(l.locationflag,left,right)
																	,trim(l_buildversion,left,right)
																	,trim(l.superkey,left,right)
																	,trim(l.logicalkey,left,right)
																	,trim((string)l.size,left,right)
																	,trim((string)l.recordcount,left,right)
																	,''
																	,''
																	}], rUpdateKeyInfo);
			self := L;
		end;

		dKIList := project(dKeyInfo, xKIList(left));

		rUpdateInfoForPkgValidationRequest := record, maxlength(50000)
			dataset(rKIList) ulist{xpath('ulist')} := dKIList;
			
		end;
		
		rSOAPResponse := SOAPCALL(
				
				dops.constants.prboca.serviceurl(l_dopsenv,l_clusterflag,l_locationflag,if (l_testenv <> '',l_testenv,'NA')),
				////////////////////////////////////////////////
				// to check the soap xml use local machine IP and run soapplus -s -p 4546
				// 'http://10.176.152.60:4546/',
				////////////////////////////////////////////////
				'UpdateInfoForPkgValidation',
				rUpdateInfoForPkgValidationRequest,
				dataset(rKIList),
				xpath('UpdateInfoForPkgValidationResponse/UpdateInfoForPkgValidationResult'),
				NAMESPACE('http://lexisnexis.com/'),
				LITERAL,
				SOAPACTION('http://lexisnexis.com/UpdateInfoForPkgValidation'));
		
		rGetKey := record
			string l_buildversion := '';
			dataset(rUpdateKeyInfo) ulist;
		end;
		
		rGetKey xGetKey(rSOAPResponse l) := transform
			self.ulist := l.KIList;
			self.l_buildversion := l_buildversion;
		end;
		
		dGetKey := project(rSOAPResponse,xGetKey(left));
		
		rKeyInfo xNormRecs(dGetKey l,rUpdateKeyInfo r) := transform
			self.recordcount := (integer)r.recordcount;
			self.size := (integer)r.size;
			self.clusterflag := r.cluster;
			self.locationflag := r.location;
			self.environmentflag := r.environment;
			self := r;
		end;
		
		dNormRecs := normalize(dGetKey, left.ulist, xNormRecs(left,right));
		
		return if (count(dKeyInfo) > 0, dNormRecs, dataset([],rKeyInfo));
	end;

	export RunUpdate() := function
		dUpdateInfo := dedup(sort(UpdateInfo(),superkey),record);/* : failure(
															fileservices.sendemail(
																				dops.constants.rptemail(l_locationflag)
																				,'KEY INFO UPDATE DOPS DB:'+ l_dopsdatasetname+':'+l_buildversion+':'+l_clusterflag+':FAILED'
																				,failmessage
																				,
																				,
																				,dops.constants.rptemail(l_locationflag)+if (l_email <> '',','+l_email,'')
																			)
																);*/

		return dUpdateInfo;
		
	end;

end;