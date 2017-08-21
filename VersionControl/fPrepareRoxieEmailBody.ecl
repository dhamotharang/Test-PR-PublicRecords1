/////////////////////////////////////////////////////////////////////////////
// -- fPrepareRoxieEmailBody()
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
export fPrepareRoxieEmailBody(

	 dataset(Layout_Names)	pall_superkeynames				// dataset of superkeynames to include in email
	,string									pversion 						= ''	// optional version that all subkeys will be compared to

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
		self.superfilecontents	:= fileservices.superfilecontents(l.name)[1].name;
		self.name								:= l.name;
		self.version						:= regexfind('[[:digit:]]{8}[[:alpha:]]?',self.superfilecontents,0);
	end;

	getcontents := project(pall_superkeynames, tgetcontents(left));

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
	
	layout_versions_email := 
	record, maxlength(1000)
		string versions := versions_table.version;
	end;
	
	versions_table_email := table(versions_table, layout_versions_email);
	
	layout_versions_email trollupversions(layout_versions_email l, layout_versions_email r) :=
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
	
	return 		decision_time
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
end;