/////////////////////////////////////////////////////////////////////////////
// -- fun_RoxieEmailBody()
// -- Parameters:
// -- 	pall_superkeynames	-- dataset of superkeynames to include in email body
// --		pversion						-- optional version that all subkeys will be compared to
// --
// --	This function takes the dataset of superkeys passed, finds all of the subkeys
// -- Verifies that their versions are all the same and, if pversion is used,
// --	checks them against that passed version.  It returns a standard roxie email body
// --	if everything checks out, otherwise it specifies the irregularities
/////////////////////////////////////////////////////////////////////////////
import ut;
export fun_RoxieEmailBody(
	 dataset(Layout_Names)	pall_superkeynames				// dataset of superkeynames to include in email
	,string									pversion 						= ''	// optional version that all subkeys will be compared to
  ,boolean                pDebug              = false
) :=
function
	
	lversion := pversion;
	
	layout_twonames := 
	record, maxlength(16000)
		Layout_Names																						;
		string			superfilecontents														;
		string			emailine					{maxlength(15000)}	:= ''	;
		unsigned4		record_id															:= 0	;
		string9			version																:= ''	;
	end;
	
	/////////////////////////////////////////////////////////////////////////////
	// -- Get Superfile Subfiles
	/////////////////////////////////////////////////////////////////////////////
	layout_twonames tgetcontents(Layout_Names l) :=
	transform
    supercontents := fileservices.superfilecontents(l.name);
    findversion   := supercontents;//(pversion = '' or regexfind(pversion,name,nocase));
    subcount      := count(findversion);
    
		self.superfilecontents	:= map(fileservices.superfileexists(l.name) = true => findversion[subcount].name 
                                  ,fileservices.fileexists     (l.name) = true => l.name
                                  ,'');
		self.name								:= l.name;
		self.version						:= regexfind('[[:digit:]]{8}[[:alpha:]]?',self.superfilecontents,0);
	end;
	getcontents := nothor(project(global(pall_superkeynames,few), tgetcontents(left)));
	version_filter := lversion = '' or getcontents.version = lversion;
	getcontents_goodversion := getcontents(version_filter);
	getcontents_badversion	:= getcontents(not(version_filter));
	/////////////////////////////////////////////////////////////////////////////
	// -- Add Unique id
	/////////////////////////////////////////////////////////////////////////////
	layout_twonames addseq(layout_twonames lef,unsigned4 cnt) :=
	transform
		self.record_id	:= cnt;
		self 						:= lef;
	end;
	contents_seq_good := project(getcontents_goodversion,addseq(left,counter));
	contents_seq_bad	:= project(getcontents_badversion	,addseq(left,counter));
	/////////////////////////////////////////////////////////////////////////////
	// -- Rollup, creating Email Body into one record
	/////////////////////////////////////////////////////////////////////////////
	layout_twonames trollupline(layout_twonames l, layout_twonames r) :=
	transform
		self.emailine := if(l.record_id = 1 and r.record_id = 2,
									'keys: ' + (string)l.record_id + ') ' + l.name[2..] + '\n\t\t\t' + l.superfilecontents + '\n' +
									'      ' + (string)r.record_id + ') ' + r.name[2..] + '\n\t\t\t' + r.superfilecontents + '\n',
		trim(l.emailine) 
							+ 	'      ' + (string)r.record_id + ') ' + r.name[2..] + '\n\t\t\t' + r.superfilecontents + '\n');
		self := l;
	end;
	layout_twonames tprojectline(layout_twonames l) :=
	transform
		self.emailine := if(trim(l.emailine) = ''
								, 'keys: ' + (string)l.record_id + ') ' + l.name[2..] + '\n\t\t\t' + l.superfilecontents + '\n'
								,	l.emailine
								);
		self := l;
	end;
	rollupcontents_good := rollup(contents_seq_good , true, trollupline(left,right));
	rollupcontents_bad	:= rollup(contents_seq_bad	, true, trollupline(left,right));
                             
	projectcontents_good	:= project(rollupcontents_good	, tprojectline(left))[1] : global;
	projectcontents_bad		:= project(rollupcontents_bad		, tprojectline(left))[1] : global;
	versions_table 				:= table(getcontents, {version}, version, few);
	ExistMultipleVersions := if(count(versions_table) > 1, true, false);
	
	Layout_FilenameVersions_email := 
	record, maxlength(1000)
		string versions := versions_table.version;
	end;
	
	versions_table_email := table(versions_table, Layout_FilenameVersions_email);
	
	Layout_FilenameVersions_email trollupversions(Layout_FilenameVersions_email l, Layout_FilenameVersions_email r) :=
	transform
		self.versions := trim(l.versions) + '\n\t' + trim(r.versions);
	end;
	
	versions_rollup := rollup(versions_table_email, true, trollupversions(left,right))[1] : global;
	
	correct_version := if(lversion != ''
												,'('+ pversion +')'
												,''
												);
	decision_time := map(count(getcontents_badversion) > 0 =>
												  'There are versions in this package that do not match the intended version'+ correct_version +'.  Check to make sure this is correct.\n'
												+ 'List of versions in this package follows:\n'
												+ '\t' + versions_rollup.versions + '\n\n'
												+ 'List of keys with Wrong version follows.\n'
												+ stringlib.StringToLowerCase(trim(projectcontents_bad.emailine))
											,ExistMultipleVersions =>
													'There are multiple versions in this package.  Check to make sure this is correct.\n'
												+ 'List of versions in this package follows:\n'
												+ '\t' + versions_rollup.versions + '\n\n'
												,''
									);
	
	returnresult := decision_time
					+ if(count(getcontents_goodversion) > 0
							,		if(count(getcontents_badversion) > 0
										,'\nList of keys with correct version follows.\n'
										,''
									)
								+ stringlib.StringToLowerCase(trim(projectcontents_good.emailine))
								+ '      have been built and are ready to be deployed to QA.'							
							,		'\nNo keys with correct version'+ correct_version +' exist in this package.'
								+ stringlib.StringToLowerCase(trim(projectcontents_good.emailine))
						);

  outputdebug := parallel(
    output(pall_superkeynames ,named('pall_superkeynames'))
   ,output(getcontents ,named('getcontents'))
   ,output(getcontents_goodversion  ,named('getcontents_goodversion'))
   ,output(getcontents_badversion	 ,named('getcontents_badversion'))
   ,output(contents_seq_good  ,named('contents_seq_good'))
   ,output(contents_seq_bad	 ,named('contents_seq_bad'))
   ,output(rollupcontents_good  ,named('rollupcontents_good'))
   ,output(rollupcontents_bad	 ,named('rollupcontents_bad'))
   ,output(projectcontents_good	 ,named('projectcontents_good'))
   ,output(projectcontents_bad		 ,named('projectcontents_bad'))
   ,output(versions_table 				 ,named('versions_table'))
   ,output(ExistMultipleVersions ,named('ExistMultipleVersions'))
   ,output(versions_table_email ,named('versions_table_email'))
   ,output(versions_rollup ,named('versions_rollup'))
   ,output(correct_version ,named('correct_version'))
   ,output(decision_time ,named('decision_time'))
  
  );

  return when(returnresult,if(pDebug = true ,outputdebug));
end;
