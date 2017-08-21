import ut;
// build name - actual build name in orbit
// build version
// intoken - authorization
// emailme - list of email ids that requires notification
// componentlist - set of all build names and item names (filenames with path)
//								 since a build can contain items and other builds.
//								 for example, the set should look like
//								 ['SCRUB CARRIER DISCOVERY,20100903','\\\\unixland\\data\\orbittesting\\LEXISNEXIS_CD_CC_HISTORY_POSTSCRUB\\process\\20100903\\unixcc_full']
//								 In the above example, "SCRUB CARRIER DISCOVERY,20100903" is a build version of another build
//								 sub build name is required because we can have different sub builds with the same version and
//								 the second element in the set is an item (filename)
//								 we can have any number of builds and items in the set and in any order.
export AddComponentsToBuild(string buildname,
														string buildversion,
														string intoken, 
														string emailme,
														set of string componentlist) := function

	xmlbuildname := regexreplace('&',trim(buildname,left,right),'&amp;');
	//xmlmasterbuildname := regexreplace('&',MasterBuildName,'&amp;');

	getcompds := dedup(sort(orbit.GetBuildComponents(trim(buildname,left,right),trim(buildversion,left,right),intoken),mainbuildname,subbuildversion,filenames),record,all);

	denorm_rec := record,maxlength(500000)
		string dsname := '';
		string buildxmlstring := '';
		string itemxmlstring := '';
		//string setword := ''; // used to store the previous build or item name but used exclusively
													// for item names since the xml tag for item has child tags.

	end;
	
	dummyds := dataset([{xmlbuildname,'',''}],denorm_rec);
	
	// Build the component xml tag, it could contain build names and/or item names
	denorm_rec denormalize_items(dummyds l,getcompds r) := transform
		//wordcnt := ut.noWords(regexreplace('[\\\\/]+',r.filenames,'|'),'|'); // Replace all '\' to '|' and get word count
		//getword := ut.word(regexreplace('[\\\\/]+',r.filenames,'|'),wordcnt,'|'); // Replace '\' to '|' and get the (n-1)th word since it always has the receiving id with the foldername
		buildcomponent := trim(r.subbuildname,left,right) + ',' + trim(r.subbuildversion,left,right); // example "SUB BUILDNAME, 20100903" this will be compared with component set from the user
		self.dsname := r.mainbuildname;
		self.buildxmlstring := l.buildxmlstring + 
									if(r.itemtype = 'Build' and buildcomponent in componentlist,'<BuildName>'+r.subbuildname+'</BuildName>'+
											'<BuildVersion>'+r.subbuildversion+'</BuildVersion><Reason/>','');
		self.itemxmlstring := l.itemxmlstring + 
								if(r.filenames <> '', if(r.filenames in componentlist,
									//if (l.setword <> getword , // if the receiving ids are different then use different component tag
										//if(l.setword = '','<Component i:type="ItemComponent"><FileNames>',
												if(l.itemxmlstring <> '','</FileNames></Component><Component i:type="ItemComponent"><FileNames>',
												'<Component i:type="ItemComponent"><FileNames>')
												+
								'<FileName>' +
									'<Name>'+r.filenames+'</Name>' +
									'<Status i:nil="true" />' +
								'</FileName>',''),'');
		//self.setword := if(r.filenames <> '' and r.filenames in componentlist,getword,'');// change made here
	end;
	
	denorm_out := denormalize(dummyds,getcompds,left.dsname = right.mainbuildname,
						denormalize_items(left,right)) : independent;

	buildds := denorm_out(buildxmlstring <> '')[1].buildxmlstring;
	itemds := denorm_out(itemxmlstring <> '')[1].itemxmlstring;
	
	inrec := RECORD, MAXLENGTH(500000)
			string somestring {xpath('xml')} := 	
				'<OrbitRequest xmlns='+orbit.EnvironmentVariables.xmlns+'>'+
				'<Builds>'+
					'<Build>' +
						'<BuildName>'+xmlbuildname+'</BuildName>' + 
						'<BuildVersion>'+trim(buildversion,left,right)+'</BuildVersion>' +
						'<Components>' +
							if ( buildds <> '',
							'<Component i:type="BuildComponent">' +
								buildds +
							'</Component>','') +
							if (itemds <> '',
							//'<Component i:type="ItemComponent">' +
								//'<FileNames>' +
									itemds +
								'</FileNames>' +
							'</Component>','') +
						'</Components>' +
					'</Build>' +
				'</Builds>'+
				'<Token>'+intoken+'</Token>'+
				'</OrbitRequest>';
	end;
	
	string mysomestring := 	
				'<OrbitRequest xmlns='+orbit.EnvironmentVariables.xmlns+'>'+
				'<Builds>'+
					'<Build>' +
						'<BuildName>'+xmlbuildname+'</BuildName>' + 
						'<BuildVersion>'+trim(buildversion,left,right)+'</BuildVersion>' +
						'<Components>' +
							if ( buildds <> '',
							'<Component i:type="BuildComponent">' +
								buildds +
							'</Component>','') +
							if (itemds <> '',
							//'<Component i:type="ItemComponent">' +
								//'<FileNames>' +
									itemds +
								'</FileNames>' +
							'</Component>','') +
						'</Components>' +
					'</Build>' +
				'</Builds>'+
				'<Token>'+intoken+'</Token>'+
				'</OrbitRequest>';
 
	outrec := RECORD, MAXLENGTH(500000)
	   string outdata {xpath('AddBuildInstanceComponentsResponse/AddBuildInstanceComponentsResult')};
	end;
	 
	retval := SOAPCALL(
		orbit.EnvironmentVariables.serviceurl,
		'AddBuildInstanceComponents',
		INREC,
		OUTREC,
		NAMESPACE(orbit.EnvironmentVariables.namespace),
		LITERAL,
		SOAPACTION(orbit.EnvironmentVariables.soapactionprefix + 'AddBuildInstanceComponents'));
	
	xmlout_rec := record, maxlength(500000)
		string xmlline;
	end;
	
	xmlds := dataset([{retval.outdata}],xmlout_rec);

	build_rec := record
		string mainbuildname := xmlbuildname;
		string buildversion := buildversion;
		string componentname := xmltext('BuildName');
							//		xmltext('FileNames/FileName/Name'));
		string componentcode := xmltext('BuildVersion');//xmltext('FileNames/FileName/Status/Code');
		string recflag := 'B';
	end;

	buildxmlout := parse(xmlds,xmlline,build_rec,xml('OrbitResponse/Builds/Build/Components/Component[@i:type="BuildComponent"]'));

	item_rec := record
		string mainbuildname := xmlbuildname;
		string buildversion := buildversion;
		string componentname := xmltext('Name');
							//		xmltext('FileNames/FileName/Name'));
		string componentcode := xmltext('Status/Code');
		string recflag := 'I';
	end;

	itemxmlout := parse(xmlds,xmlline,item_rec,xml('OrbitResponse/Builds/Build/Components/Component[@i:type="ItemComponent"]/FileNames/FileName'));

	fullds := buildxmlout + itemxmlout;

	string_Rec := record
		string buildstatus := xmltext('OrbitStatus/OrbitStatusCode');
		string builddesc := xmltext('OrbitStatus/OrbitStatusDescription');
		string xmlrequest := mysomestring;
	end;

	xmlout := parse(xmlds,xmlline,string_rec,xml('OrbitResponse')) : INDEPENDENT;

	mail_rec := record
		string dsname := '';
		string mailstring := '';
	end;
	
	mailds := dataset([{xmlbuildname,''}],mail_rec);
	
	mail_rec denormalize_mail(mailds l,fullds r) := transform
		self.dsname := r.mainbuildname;
		self.mailstring := l.mailstring + '\n' + if(r.recflag = 'B','Build:','Item:') +
									r.componentname + ':' + r.componentcode;
		
	end;
	
	mail_out := denormalize(mailds,fullds,left.dsname = right.mainbuildname,
						denormalize_mail(left,right));

	return sequential(output(xmlout[1].xmlrequest,named('Input_XML')),
						if(buildds <> '' or itemds <> '',
								if(trim(xmlout[1].buildstatus,left,right) = 'Success',
												fileservices.sendemail
												(
												emailme,
												'Orbit Components Added for '+xmlbuildname+':'+buildversion+':SUCCESS',
												'List of Components \n\n' +
												'*****************************************************************\n'+
												'<Format> ComponentType:ComponentName:Status/Version \n' +
												'Status/Version - version for sub builds and status for files\n' +
												'*****************************************************************\n'+
												mail_out[1].mailstring
												),
												fileservices.sendemail
												(
												emailme,
												'Orbit Components Added for '+xmlbuildname+':'+buildversion+':FAILED',
												'Adding components to build failed. Reason: '+xmlout[1].builddesc
												)
									 ),
									 
									fileservices.sendemail(
									emailme,
									'No components added to '+xmlbuildname+':'+buildversion+':FAILED',
									'No components were available to add'))
									);

End;