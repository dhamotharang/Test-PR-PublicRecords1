import ut, _control;
export fPrepareSprayEmailBody(dataset(Layout_Sprays.infoout) pSprayInformation) :=
function

	///////////////////////////////////////////////////////////////////////////
	// -- Add unique id
	///////////////////////////////////////////////////////////////////////////
	layout_unique_id := 
	record, maxlength(131072)
		Layout_Sprays.infoout																		;
		unsigned4													parent_unique_id := 0	;
		dataset(Layout_Sprays.ChildNames)	dFilesSprayed					;
		dataset(Layout_Sprays.ChildNames)	dFilesSkipped					;
	end;

	layout_unique_id addseq(Layout_Sprays.infoout ref,unsigned4 cnt) :=
	transform
		self.parent_unique_id			:= cnt	;
		self.dFilesSprayed				:= ref.dFilesToSpray(willspray = true);
		self.dFilesSkipped				:= ref.dFilesToSpray(willspray = false);
		self											:= ref	;
	end;

	contents_seq := project(pSprayInformation,addseq(left,counter));

	// Add email line preface
	Layout_Sprays.NormForEmail tAddEmailPreface(layout_unique_id l) :=
	transform
	
		server := IPAddresses.serversinfo(ipaddress = l.SourceIP)[1].servername;
		
		self									:= l	;
		self.filetype					:= 'A';
		self.child_unique_id	:= 0;
		self.emailine 				:=	'Source:\n'					+
															'\tServer       : '		+ l.SourceIP + if(server != '', ' ( ' + server + ' )', '') + '\n' + 
															'\tDirectory    : '		+ l.SourceDirectory + '\n' +
															'\tFilename     : '		+ l.directory_filter + '\n\n' +
															'Destination:\n'		+
															'\tEnvironment  : '		+ _Control.ThisEnvironment.Name + '\n' +
															'\tCluster      : '		+ l.GroupName + '\n' +
															'\tFile Layout  : '		+ l.file_type + '\n' +
															'\tCompressed   : '		+ if(l.compress, 'Yes', 'No') + '\n' +
															if(l.record_size != 0 and l.file_type = 'FIXED', 
															'\tRecord Length: '		+ l.record_size + '\n','')
															;
																					
	end;   
	
	dEmailPreface := project(contents_seq, tAddEmailPreface(left));

	// normalize out logical files sprayed
	Layout_Sprays.NormForEmail tNormLogicalsSprayed(layout_unique_id l, Layout_Sprays.ChildNames r, unsigned4 cnt) :=
	transform
	
		server := IPAddresses.serversinfo(ipaddress = l.SourceIP)[1].servername;
		
		self									:= r	;
		self									:= l	;
		self.filetype					:= 'L1';
		self.child_unique_id	:= cnt;
		self.emailine 				:= if(cnt = 1	,		'\nSprayed the following ' + if(count(l.dFilesSprayed) > 1, (string)count(l.dFilesSprayed) + ' ', '') + 'logical file' + if(count(l.dFilesSprayed) > 1, 's','') + ':\n' + 
																						'\t1. ' 										+ r.RemoteFilename + ' -> ' + r.ThorLogicalFilename + '\n'
																				,		'\t' + (string)cnt	+ '. '	+ r.RemoteFilename + ' -> ' + r.ThorLogicalFilename + '\n'
																);
																					
	end;   
	
	dNormLogicals_sprayed := normalize(contents_seq, left.dFilesSprayed, tNormLogicalsSprayed(left,right,counter));
	
	// normalize out logical files skipped
	Layout_Sprays.NormForEmail tNormLogicalsSkipped(layout_unique_id l, Layout_Sprays.ChildNames r, unsigned4 cnt) :=
	transform
	
		server := IPAddresses.serversinfo(ipaddress = l.SourceIP)[1].servername;
		
		self									:= r	;
		self									:= l	;
		self.filetype					:= 'L2';
		self.child_unique_id	:= cnt;
		self.emailine 				:= if(cnt = 1	,		'\nSkipped the following ' + if(count(l.dFilesSkipped) > 1, (string)count(l.dFilesSkipped) + ' ', '') + 'logical file' + if(count(l.dFilesSkipped) > 1, 's','') + ':\n' + 
																						'\t1. ' 										+ r.RemoteFilename + ' -> ' + r.ThorLogicalFilename + '\n'
																				,		'\t' + (string)cnt	+ '. '	+ r.RemoteFilename + ' -> ' + r.ThorLogicalFilename + '\n'
																);
																					
	end;   
	
	dNormLogicals_skipped := normalize(contents_seq, left.dFilesSkipped, tNormLogicalsSkipped(left,right,counter));

	// normalize out superfiles child dataset
	Layout_Sprays.NormForEmail tNormSupers(layout_unique_id l, Layout_Sprays.ChildSuperNames r, unsigned4 cnt) :=
	transform
	
		self											:= l			;
		self.filetype							:= 'S'		;
		self.child_unique_id			:= cnt		;
		self.emailine 						:= if(cnt = 1	, '\nAdded the ' + if(l.remotefilescount > 1, (string)l.remotefilescount + ' ', '') + 'logical file' + if(l.remotefilescount > 1, 's','') +' above to the following ' + if(l.superfilescount > 1, l.superfilescount + ' superfiles:\n', 'superfile:\n') +
																							'\t1. '										+ r.name + '\n'
																						,	'\t' + (string)cnt + '. ' + r.name + '\n'
																);
	end;   
	
	dNormSupers := normalize(contents_seq, left.dSuperfilenames, tNormSupers(left,right,counter));
	
	//add the two datasets together, sorting them on parent uniqueid, and filetype, and child unique id.
	//then rollup the flattened dataset.  

	dCombineSuperAndLogical := sort(dEmailPreface + dNormLogicals_sprayed + dNormLogicals_skipped + dNormSupers, parent_unique_id, filetype, child_unique_id);
	
	Layout_Sprays.NormForEmail tRollupForEmail(Layout_Sprays.NormForEmail l, Layout_Sprays.NormForEmail r) :=
	transform

		linebreak := if(l.parent_unique_id != r.parent_unique_id, '\n\n---------------------------------------------------------------------------------------------\n\n', '');

		self.emailine					:= trim(l.emailine) + linebreak + trim(r.emailine);
		self.parent_unique_id := if(l.parent_unique_id != r.parent_unique_id, r.parent_unique_id, l.parent_unique_id);
		self := l;
		
	end;
	
	dRollupForEmail := rollup(dCombineSuperAndLogical, true, tRollupForEmail(left,right));
	
	emailline := if(count(dNormLogicals_sprayed + dNormLogicals_skipped) > 0
										,'Workunit: ' + workunit + '\n\n' + trim(dRollupForEmail[1].emailine)
										,'Workunit: ' + workunit + '\n\n' + trim(dEmailPreface[1].emailine) + '\nNo files found to spray.\n' +
											'Your filename pattern did not match any files'
									);
	
	returndataset := dataset([
	
		 {count(dNormLogicals_sprayed),count(dNormLogicals_skipped), emailline 				}
	    
	], Layout_Sprays.ReturnEmail);
	
	return returndataset[1];

end;
