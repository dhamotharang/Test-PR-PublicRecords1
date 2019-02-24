import ut,_Control,Address, STD;
export Proc_BK_Preprocess(string filedate) := function
	inCase := Bankruptcyv2.File_In_Case;
	inDefendants := Bankruptcyv2.File_In_Defendants;
	courtcodelookup := Bankruptcyv2.File_Lookup_CourtCode;
	courtcaselookup := Bankruptcyv2.File_Lookup_Courtcase;

	
	// Cleaning case *************************
	blank_string_set := [ 'INFORMATION UNAVAILABLE',
			    'INFOINFORMATION UNAVAILABLE',
			    'INFORAMTION UNAVAILABLE',
			    'INFORMAITON UNAVAILABLE',
			   'INFORMAITON UNKNOWN',
			   'INFORMATION UNKNOWN',
			   'INFORMATION  UNAVAILABLE',
			   'INFORMATION NOT AVAILABLE',
			   'INFORMATION NOT LISTED',
			   'INFORMATION UANVAILABLE ',
			   'INFORMATION UNAVAIALBLE',
			   'INFORMATION UNAVAILABLE',
			   'INFORMATION UNAVAILALBE',
			   'INFORMATION UNAVAILALE',
			   'INFORMATION UNAVIAILABLE',
			   'INFORMATION UNAVIALABLE',
			   'INFORMATION UNVAILABLE',
			   'INFORMTION UNAVAILABLE',
			   'LOCATION UKNOWN',
			   'LOCATION UNAVAILABLE',
			   'LOCATION UNKNOWN',
			   'UNASSIGNED',
			   'UNAVAILABLE',
			   'UNAVAILBLE'];
	
	Bankruptcyv2.Layout_In_Case clean_case(inCase l) := transform
		string l_caseNumber := if(trim(regexreplace('[0.,/}{\'"*|-]+',l.caseNumber,'')) = '','',
									l.caseNumber);
		string l_temp_caseNumber := if(regexfind(':',l_caseNumber),
								stringlib.stringfilter(trim(l_caseNumber)[2..8],'0123456789'),
		      							if(trim(l_caseNumber)[length(l_caseNumber)..length(l_caseNumber)] = '-',
										stringlib.stringfilter(trim(l_caseNumber)[2..8],'0123456789'),
										stringlib.stringfilter(trim(l_caseNumber),'0123456789')));
		string l_location341 	:=  if(regexfind('^[0]+$',l.location341),'',l.location341);
		self.time341 		:=  l.time341;//if(trim(regexfind('^[0]+$',l.time341),'',l.time341);
		
		self.trusteeName	:=  if(regexfind('^[0]+$',l.trusteeName),'',l.trusteeName);
		self.trusteeAddress :=	if(regexfind('^[0]+$',l.trusteeAddress),'',l.trusteeAddress);
		self.trusteeCity 	:=  if(regexfind('^[0]+$',l.trusteeCity),'',l.trusteeCity);
		self.trusteeZip4  	:=  l.trusteeZip4;//if(regexfind('^[0]+$',l.trusteeZip4),'',l.trusteeZip4);
		self.JudgeInit		:=  if(regexfind('^[0]+$',l.JudgeInit),'',l.JudgeInit);
		self.trusteeZip 	:=  l.trusteezip;//if(regexfind('^[0]+$',l.trusteeZip),'',l.trusteeZip);
		self.trusteePhone 	:=  l.trusteephone;//if(regexfind('^[0]+$',l.trusteePhone,'')) = '' and length(l.trusteePhone)) <> 8,'',l.trusteePhone);
		self.caseNumber   	:=  l_temp_caseNumber; 
		self.judge       	:=  if(trim(regexreplace('[0.,/}{\'"*|-]+',l.judge,'')) = 'INFORMATION UNAVAILABLE' or
                       	    trim(regexreplace('[0.,/}{\'"*|-]+',l.judge,'')) = 'INFORMATION UNVALAILABLE' or
                            trim(regexreplace('[0.,/}{\'"*|-]+',l.judge,'')) ='UNASSIGNED'or
                            trim(regexreplace('[0.,/}{\'"*|-]+',l.judge,'')) = 'UNAVAILABLE','',
							if(trim(regexreplace('[0.,/}{\'"*|-]+',l.judge,'')) = '','',l.judge)
							); 
		self.assets       	:=  if(trim(regexreplace('[0.,/}{\'"*|-]+',l.assets,'')) = '','',l.assets); 
		self.liab         	:=  if(trim(regexreplace('[0.,/}{\'"*|-]+',l.liab,'')) = '','',l.liab);
		self.bardate 		:=  stringlib.stringfilter(l.barDate,'1234567890')[1..8];
		self.location341 	:=  if (l_location341 in blank_string_set,'',if(trim(regexreplace('[0.,/}{\'"*|-]+',l_location341,'')) = '','',l_location341));
		self := l;
	end;
	
	clean_case_fields := project(inCase,clean_case(left))(trim(CaseNumber) <> '');
	
	// TMSID Process date
	
	phase2_recs := record
		string1    	source := 'L';	
		string8    	process_date;
		string50   	TMSID;
		string25  	orig_case_number;
		string5    	court_code;
		string10   	seq_number;
		string8  	date_last_seen := ''; 
		string8 	date_first_seen := '';
		string50	court_name;
		string40	court_location;
		Bankruptcyv2.Layout_In_Case;
	end;
	
	phase2_recs court_code_lookup(clean_case_fields l,courtcodelookup r) := transform
		string l_createdate := stringlib.stringfilter(l.createdate,'0123456789')[1..8];
		string l_courtcode := r.moxie_code;
		self.court_code := l_courtcode;
		self.tmsid := 'BK' + trim(l_courtcode) + trim(l.caseNumber);
		self.seq_number := if(l_createdate <> '',
								intformat(ut.DaysSince1900(l_createdate[1..4],l_createdate[5..6],l_createdate[7..8])-1,10,1),
								intformat(ut.DaysSince1900('1980','01','01'),10,1));
		self.process_date := filedate[1..8];
		self.orig_case_number := l.caseNumber;
		self.court_name := r.moxie_court_name;
		self.court_location := r.court_city;
		self := l;
	end;
	
	clean_case_out := sort(distribute(join(clean_case_fields,courtcodelookup,
							left.C3Code = right.C3Courtid,
							court_code_lookup(left,right),
							left outer,
							lookup)(trim(court_code) <> ''),hash(tmsid)),tmsid,local);
							
	// Get missing cases
	clean_missing_cases := sort(distribute(join(clean_case_fields,courtcodelookup,
							left.C3Code = right.C3Courtid,
							court_code_lookup(left,right),
							left outer,
							lookup)(trim(court_code) = ''),hash(tmsid)),tmsid,local);
	
	//*********** End clean case *************
	
	// Clean defendants
	
	Bankruptcyv2.Layout_In_Defendants clean_defendants(inDefendants l) := transform
		string l_taxid := if(trim(regexreplace('[0.,/}{\'"*|-]+',l.debtor1Taxid,'')) = '','',
									l.debtor1Taxid);
		string l_ssn := if(trim(regexreplace('[0.,/}{\'"*|-]+',l.debtor1SSN,'')) = '','',
									l.debtor1SSN);
		string l_caseNumber := if(trim(regexreplace('[0.,/}{\'"*|-]+',l.caseNumber,'')) = '','',
									l.caseNumber);
		string l_temp_caseNumber := if(regexfind(':',l_caseNumber),
								stringlib.stringfilter(trim(l_caseNumber)[2..8],'0123456789'),
		      							if(trim(l_caseNumber)[length(l_caseNumber)..length(l_caseNumber)] = '-',
										stringlib.stringfilter(trim(l_caseNumber)[2..8],'0123456789'),
										stringlib.stringfilter(trim(l_caseNumber),'0123456789')));
		
		self.caseNumber   	:=  l_temp_caseNumber;
		self.county 		:=  if(regexfind('^[0]+$',l.county),'',l.county); 
		self.debtor1Type  	:=  if(regexfind('^[0]+$',l.debtor1Type  ),'',l.debtor1Type );	
		self.debtor1PriYN 	:=  if(regexfind('^[0]+$',l.debtor1PriYN ),'',l.debtor1PriYN);	
		self.debtor1Name 	:=  if(regexfind('^[0]+$',l.debtor1Name ),'',l.debtor1Name);	
		self.debtor1First 	:=  if(regexfind('^[0]+$',l.debtor1First ),'',l.debtor1First);	
		self.debtor1Middle 	:=  if(regexfind('^[0]+$',l.debtor1Middle ),'',l.debtor1Middle);	
		self.debtor1Last  	:=  if(regexfind('^[0]+$',l.debtor1Last  ),'',l.debtor1Last );	
		self.debtor1Suffix 	:=  if(regexfind('^[0]+$',l.debtor1Suffix ),'',l.debtor1Suffix);	
		self.debtor1SSN 	:=  if(regexfind('^[0]+$',l.debtor1SSN ),'',l_ssn);	
		self.debtor1SSNSrc 	:=  if(regexfind('^[0]+$',l.debtor1SSNSrc ),'',l.debtor1SSNSrc);
		self.debtor1SSNMatch	:=  if(regexfind('^[0]+$',l.debtor1SSNMatch),'',l.debtor1SSNMatch);
		self.debtor1SSNMSrc	:=  if(regexfind('^[0]+$',l.debtor1SSNMSrc),'',l.debtor1SSNMSrc);
		self.debtor1Screen	:=  l.debtor1Screen;
		self.debtor1Dcode	:=  l.debtor1Dcode;
		self.debtor1DispType	:=  l.debtor1DispType;
		self.debtor1DispReason	:=  if(regexfind('^[0]+$',l.debtor1DispReason),'',l.debtor1DispReason);
		self.debtor1StatusDate	:=  if(regexfind('^[0]+$',l.debtor1StatusDate),'',l.debtor1StatusDate);
		self.debtor1HoldCase	:=  if(regexfind('^[0]+$',l.debtor1HoldCase),'',l.debtor1HoldCase);
		self.debtor1ActivityReceipt	:=  l.debtor1ActivityReceipt;//if(regexfind('^[0]+$',l.debtor1ActivityReceipt),'',l.debtor1ActivityReceipt);
		self.debtor1Taxid  	:=  if(regexfind('^[0]+$',l.debtor1Taxid  ),'',l_taxid );	
		self.debtor1Address 	:=  if(regexfind('^[0]+$',l.debtor1Address ),'',l.debtor1Address);	
		self.debtor1City  	:=  if(regexfind('^[0]+$',l.debtor1City  ),'',l.debtor1City );	
		self.debtor1State  	:=  if(regexfind('^[0]+$',l.debtor1State  ),'',l.debtor1State );	
		self.debtor1Zip  	:=  l.debtor1zip;//if(regexfind('^[0]+$',l.debtor1Zip  ),'',l.debtor1Zip );
		self.debtor1Zip4 	:= l.debtor1Zip4;//if(regexfind('^[0]+$',l.debtor1Zip4 ),'',l.debtor1Zip4);	
		self.debtor1Phone 	:= l.debtor1Phone;//if(regexfind('^[0]+$',l.debtor1Phone ),'',l.debtor1Phone);	
		self.debtor1AKAs 	:= if(regexfind('^[0]+$',l.debtor1AKAs ),'',
								//if(regexfind('|',l.debtor1AKAs),
										regexreplace('[|]',l.debtor1AKAs,' '));
									//	l.debtor1AKAs));		
		self.debtor1DBAs 	:= if(regexfind('^[0]+$',l.debtor1DBAs ),'',l.debtor1DBAs);		
		self.debtor1Attorney 	:= if(regexfind('^[0]+$',l.debtor1Attorney ),'',l.debtor1Attorney);		
		self.debtor1AttorneyFirm 	:= if(regexfind('^[0]+$',l.debtor1AttorneyFirm ),'',l.debtor1AttorneyFirm);		
		self.debtor1AttorneyAdd 	:= if(regexfind('^[0]+$',l.debtor1AttorneyAdd ),'',l.debtor1AttorneyAdd);		
		self.debtor1AttorneyCity 	:= if(regexfind('^[0]+$',l.debtor1AttorneyCity ),'',l.debtor1AttorneyCity);		
		self.debtor1AttorneyState 	:= if(regexfind('^[0]+$',l.debtor1AttorneyState ),'',l.debtor1AttorneyState);		
		self.debtor1AttorneyZip 	:= l.debtor1AttorneyZip;		
		self.debtor1AttorneyZip4 	:= l.debtor1AttorneyZip4;//if(regexfind('^[0]+$',l.debtor1AttorneyZip4 ),'',l.debtor1AttorneyZip4);		
		self.debtor1AttorneyPhone 	:= l.debtor1AttorneyPhone;//if(regexfind('^[0]+$',l.debtor1AttorneyPhone ),'',l.debtor1AttorneyPhone);
		self.debtor1AttorneyEmail		:= l.debtor1AttorneyEmail;	
		self.date_filed	:= if(regexfind('^[0]+$',l.date_filed ),'',l.date_filed);		
		self := l;
	end;
	
	clean_def_fields := project(inDefendants,clean_defendants(left))(trim(CaseNumber) <> '');
	
	
	// TMSID Process date
	
	phase21_recs := record
		string1	source := 'L';
		string50   	TMSID ;
		string8	process_date;
		string25	orig_case_number;
		string5    	court_code;
		string50	court_name;
		string40	court_location;
		Bankruptcyv2.Layout_In_Defendants;
	end;
	
	phase21_recs court_code_def_lookup(clean_def_fields l,courtcodelookup r) := transform
		string l_courtcode := r.moxie_code;
		self.court_code := l_courtcode;
		self.tmsid := 'BK' + trim(l_courtcode) + trim(l.caseNumber);
		self.process_date := filedate[1..8];
		self.orig_case_number := l.caseNumber;
		self.court_name := r.moxie_court_name;
		self.court_location := r.court_city;
		self := l;
	end;
	
	clean_def_out := sort(distribute(join(clean_def_fields,courtcodelookup,
							left.C3Code = right.C3Courtid,
							court_code_def_lookup(left,right),
							left outer,
							lookup)(trim(court_code) <> ''),hash(tmsid)),tmsid,local);
	
	//***** End Clean Def fields *****************
	
	// Join
	
	join_recs := record
		phase21_recs;
		string8  	date_last_seen := ''; 
		string8 	date_first_seen := '';
		string10	seq_number;
		string AssocCode;
		string50	RMSID;
		string1	latestflag;
	end;
	
	join_recs join_case_def(phase2_recs l, phase21_recs r) := transform
		
		dateset := [stringlib.stringfilter(r.dateDischarged,'1234567890')[1..8],
					stringlib.stringfilter(r.dateDischargeNA,'1234567890')[1..8],
					stringlib.stringfilter(r.dateDismissed,'1234567890')[1..8],
						stringlib.stringfilter(l.dateClosed,'1234567890')[1..8],
						stringlib.stringfilter(r.dateConverted,'1234567890')[1..8],
						stringlib.stringfilter(l.dateReopened,'1234567890')[1..8],
						stringlib.stringfilter(r.dateVacated,'1234567890')[1..8],
						stringlib.stringfilter(r.dateTransfered,'1234567890')[1..8],
						stringlib.stringfilter(l.dateReclosed,'1234567890')[1..8]];
		string tmsidstr := if(trim(r.dateConverted) = '','CO',trim(stringlib.stringfilter(r.dateConverted,'1234567890')[1..8])) +
							if(trim(r.dateDischarged) = '','DS',trim(stringlib.stringfilter(r.dateDischarged,'1234567890')[1..8])) +
							if(trim(r.dateDischargeNA) = '','NA',trim(stringlib.stringfilter(r.dateDischargeNA,'1234567890')[1..8])) +
							if(trim(r.dateDismissed) = '','DM',trim(stringlib.stringfilter(r.dateDismissed,'1234567890')[1..8])) +
							if(trim(r.dateVacated) = '','DV',trim(stringlib.stringfilter(r.dateVacated,'1234567890')[1..8])) +
							if(trim(r.dateTransfered) = '','DT',trim(stringlib.stringfilter(r.dateTransfered,'1234567890')[1..8]));
		
		self.court_code := l.court_code;
		self.source := l.source;
		self.orig_case_number := l.orig_case_number;
		self.process_date := l.process_date;
		self.tmsid := l.tmsid;
        self.AssocCode := l.AssocCode;
		self.seq_number := l.seq_number;
		self.date_last_seen := if( max(dateset) = '',stringlib.stringfilter(l.dateFiled,'1234567890')[1..8],max(dateset));
		self.date_first_seen := stringlib.stringfilter(l.origDateFiled,'1234567890')[1..8] ;
		self.rmsid := 'BKR' + trim(l.court_code) + trim(l.caseNumber) + trim((string20)hash64(trim(tmsidstr)));
		self.latestflag := '1';
		//self := l;
		self := r;
	end;
	
	join_case_def_out := join(clean_case_out,clean_def_out,
								left.tmsid = right.tmsid,
								join_case_def(left,right),
								// right outer,
								local
								);
	
	// Map to main layout
	
	Bankruptcyv2.layout_bankruptcy_main_in get_case_out(clean_case_out l,join_case_def_out r) := transform
		self.date_first_seen := r.date_first_seen;
		self.date_last_seen := r.date_last_seen;
		string l_trusteeName := if(stringlib.stringtouppercase(trim(l.trusteeName)) = 'INFORMATION UNAVAILABLE' or
								stringlib.stringtouppercase(trim(l.trusteeName)) = 'INFOINFORMATION UNAVAILABLE'or
								stringlib.stringtouppercase(trim(l.trusteeName)) = 'INFORAMTION UNAVAILABLE'or
								stringlib.stringtouppercase(trim(l.trusteeName)) = 'INFORMAITON UNAVAILABLE'or
								stringlib.stringtouppercase(trim(l.trusteeName)) ='INFORMAITON UNKNOWN'or
								stringlib.stringtouppercase(trim(l.trusteeName)) ='INFORMATION UNKNOWN'or
								stringlib.stringtouppercase(trim(l.trusteeName)) ='INFORMATION  UNAVAILABLE'or
								stringlib.stringtouppercase(trim(l.trusteeName)) ='INFORMATION NOT AVAILABLE'or
								stringlib.stringtouppercase(trim(l.trusteeName)) ='INFORMATION NOT LISTED'or
								stringlib.stringtouppercase(trim(l.trusteeName)) ='INFORMATION UANVAILABLE 'or
								stringlib.stringtouppercase(trim(l.trusteeName)) ='INFORMATION UNAVAIALBLE'or
								stringlib.stringtouppercase(trim(l.trusteeName)) ='INFORMATION UNAVAILABLE'or
								stringlib.stringtouppercase(trim(l.trusteeName)) ='INFORMATION UNAVAILALBE'or
								stringlib.stringtouppercase(trim(l.trusteeName)) ='INFORMATION UNAVAILALE'or
								stringlib.stringtouppercase(trim(l.trusteeName)) ='INFORMATION UNAVIAILABLE'or
								stringlib.stringtouppercase(trim(l.trusteeName)) ='INFORMATION UNAVIALABLE'or
								stringlib.stringtouppercase(trim(l.trusteeName)) ='INFORMATION UNVAILABLE'or
								stringlib.stringtouppercase(trim(l.trusteeName)) ='INFORMTION UNAVAILABLE'or
								stringlib.stringtouppercase(trim(l.trusteeName)) ='INFORAMTION UNAVAILABLE' or
								stringlib.stringtouppercase(trim(l.trusteeName)) ='UKNOWN'or
								stringlib.stringtouppercase(trim(l.trusteeName)) ='UNAVAILABLE'or
								stringlib.stringtouppercase(trim(l.trusteeName)) ='UNKNOWN'or
								stringlib.stringtouppercase(trim(l.trusteeName)) ='UNASSIGNED'or
								stringlib.stringtouppercase(trim(l.trusteeName)) ='UNAVAILABLE'or
								stringlib.stringtouppercase(trim(l.trusteeName)) ='NONE ASSIGNED' or
								stringlib.stringtouppercase(trim(l.trusteeName)) ='UNAVAILBLE','',l.trusteeName);

		self.id := l.intSeed;
		self.date_created := stringlib.stringfilter(l.CreateDate,'1234567890')[1..8];
		self.date_modified := '';
		self.court_code := l.court_code ;
		self.case_number := l.caseNumber;
		self.orig_case_number := l.orig_case_number;
		self.orig_filing_date := stringlib.stringfilter(l.origDateFiled,'1234567890')[1..8];
		self.claims_deadline := stringlib.stringfilter(l.datePOC,'1234567890')[1..8];
		self.orig_chapter := l.origChapter;
		self.filing_status := if(l.CaseType[1..1] = 'V','Voluntary',
							if(l.CaseType[1..1] = 'I','Involuntary',''));
		self.address_341 := l.location341;
		self.judge_name := l.judge;
		self.reclosed_date := stringlib.stringfilter(l.dateReclosed,'1234567890')[1..8];
		self.reopen_date := stringlib.stringfilter(l.dateReopened,'1234567890')[1..8];
		self.case_closing_date := stringlib.stringfilter(l.dateClosed,'1234567890')[1..8];
		self.CaseType := trim(l.CaseType);
		self.assets := trim(l.assets);
		self.liabilities := trim(l.liab);
		self.process_date := l.process_date ;
		self.RMSID := r.RMSID  ;
		self.TMSID := l.TMSID  ;
		self.SplitCase := trim(l.SplitCase);
		self.FiledInError := trim(l.FiledInError);
		self.vendor_courtid := trim(l.courtid);
		self.transferin := trim(l.TransferIn);
		self.vendor_c3code := trim(l.C3code);
		self.source := l.source;
		self.seq_number := l.seq_number;
		self.judges_identification := l.JudgeInit;
		self.assets_no_asset_indicator := l.assets_yn;
		self.filer_type := if(l.AssocCode = '1','I', if(l.AssocCode = '2','J',''));
		self.meeting_date := stringlib.stringfilter(l.date341,'1234567890')[1..8];
		self.complaint_deadline := '';
		self.filing_jurisdiction := trim(l.court_code)[1..2];
		self.trusteeName := l_trusteeName;
		self.lf := '\n' ;
		self.date_filed := stringlib.stringfilter(l.dateFiled,'1234567890')[1..8];
		self.meeting_time := l.time341;
		self.clean_name := if(l_trusteeName <> '',Address.CleanPersonFML73(l_trusteeName),'');
		// self.clean_address := '';
		self.clean_address := if( l.trusteeAddress = '' and trim(l.trusteeCity+' '+l.trusteeState+' '+l.trusteeZip) = '','',
								Address.CleanAddress182(l.trusteeAddress, l.trusteeCity+' '+l.trusteeState+' '+l.trusteeZip));
		self := l;

	end;

	join_case_out := join(clean_case_out,join_case_def_out,
						left.tmsid = right.tmsid,
						get_case_out(left,right),
						local);
	
	
	Bankruptcyv2.layout_bankruptcy_main_in get_court_case_out(join_case_out l,courtcaselookup r) := transform
		self := l;
	end;	
	
	court_case_out := join(join_case_out,courtcaselookup,
							left.court_code + left.case_number = right.court_code_case_number,
							get_court_case_out(left,right),
							left only,
							lookup);
	
	// End Main File
	
	// Map to search layout (initial)
	layout_bankruptcy_search_in_intermediate := record
		Bankruptcyv2.layout_bankruptcy_search_in;
		string company := '';
		string name := '';
	end;

	layout_bankruptcy_search_in_intermediate initial_mapping(join_case_def_out l, unsigned rec_cnt) := transform
		self.source     	:= l.source ; 
		self.court_code 	:= l.court_code;
		self.case_number 	:= l.caseNumber;
		self.caseID		:= l.caseID;
		self.defendantID	:= l.debtor1DefendantID;
		self.recID		:= l.debtor1RecID;
		self.orig_case_number 	:= l.orig_case_number;
		self.debtor_type 	:= choose(rec_cnt,
								if(l.debtor1PriYN = 'Y','P','S'), //Debtor
								if(l.debtor1PriYN = 'Y','PA','SA'), //AKA
								'',//Attorney
								if(l.debtor1PriYN = 'Y','PA','SA'),//DBA
								''//Attorney
								);
		self.ssn 		:= choose(rec_cnt,
								if(l.debtor1Type = 'I',l.debtor1SSN,''),
								if(l.debtor1Type = 'I' and trim(l.debtor1AKAs) <> '',l.debtor1SSN,''),
								'',
								'',
								''
								);
		self.ssnMatch 		:= choose(rec_cnt,
									if(l.debtor1Type = 'I',l.debtor1SSNMatch,''),
									if(l.debtor1Type = 'I' and trim(l.debtor1AKAs) <> '',l.debtor1SSNMatch,''),
									'',
									'',
									''
									);
		self.ssnSrc		:= choose(rec_cnt,
								if(l.debtor1Type = 'I',l.debtor1SSNSrc,''),
								if(l.debtor1Type = 'I' and trim(l.debtor1AKAs) <> '',l.debtor1SSNSrc,''),
								'',
								'',
								''
								);
		self.ssnMSrc		:= choose(rec_cnt,
								if(l.debtor1Type = 'I',l.debtor1SSNMSrc,''),
									if(l.debtor1Type = 'I' and trim(l.debtor1AKAs) <> '',l.debtor1SSNMSrc,''),
									'',
									'',
									''
									);
		self.screen		:= choose(rec_cnt,
							l.debtor1Screen,
							l.debtor1Screen,
							'',
							'',
							''
							);
		self.dCode		:= choose(rec_cnt,
								l.debtor1Dcode,
								l.debtor1Dcode,
								'',
								'',
								''
								);
		self.dispType		:= choose(rec_cnt,
								l.debtor1DispType,
								l.debtor1DispType,
								'',
								'',
								''
								);
		self.dispReason	:= choose(rec_cnt,
								l.debtor1DispReason,
								l.debtor1DispReason,
								'',
								'',
								''
								);
		self.statusDate	:= choose(rec_cnt,
								stringlib.stringfilter(l.debtor1StatusDate,'1234567890')[1..8],
								stringlib.stringfilter(l.debtor1StatusDate,'1234567890')[1..8],
								'',
								'',
								''
								);
		self.holdCase		:= choose(rec_cnt,
									stringlib.stringfilter(l.debtor1HoldCase,'1234567890')[1..8],
									stringlib.stringfilter(l.debtor1HoldCase,'1234567890')[1..8],
									'',
									'',
									''
									);
		self.dateVacated	:= stringlib.stringfilter(l.dateVacated,'1234567890')[1..8];
		self.dateTransferred	:= stringlib.stringfilter(l.dateTransfered,'1234567890')[1..8];
		self.activityReceipt	:= choose(rec_cnt,
									l.debtor1ActivityReceipt,
									l.debtor1ActivityReceipt,
									'',
									'',
									''
									);
		self.tax_id 		:= choose(rec_cnt,
									if(l.debtor1Type = 'B',l.debtor1Taxid,''),
									'',
									'',
									if(l.debtor1Type = 'B' and trim(l.debtor1DBAs) <> '',l.debtor1Taxid,''),
									''
									);
		self.name 		:= choose(rec_cnt,
									if(l.debtor1Type = 'I',l.debtor1First+' '+l.debtor1Middle+' '+l.debtor1Last+' '+l.debtor1Suffix,''),
									l.debtor1AKAs,
									l.debtor1Attorney,
									'',
									''
									);
		self.orig_fname 	:= choose(rec_cnt,
									if(l.debtor1Type = 'I',trim(l.debtor1First),'' ),
									'',
									'',
									'',
									''
									);
		self.orig_mname 	:= choose(rec_cnt,
									if(l.debtor1Type = 'I',trim(l.debtor1Middle),''),
									'',
									'',
									'',
									''
									);
		self.orig_lname 	:= choose(rec_cnt,
									if(l.debtor1Type = 'I',trim(l.debtor1Last),''),
									'',
									'',
									'',
									''
									);
		self.orig_name_suffix 	:= choose(rec_cnt,
									if(l.debtor1Type = 'I',trim(l.debtor1Suffix),''),
									'',
									'',
									'',
									''
									);
		self.company 		:= choose(rec_cnt,
									if(l.debtor1Type = 'B',l.debtor1Name,''),
									'',
									'',
									l.debtor1DBAs,
									l.debtor1AttorneyFirm
									);
		self.orig_addr1 		:= choose(rec_cnt,
										l.debtor1Address,
										l.debtor1Address,
										l.debtor1AttorneyAdd,
										l.debtor1Address,
										l.debtor1AttorneyAdd
										);
		self.orig_addr2 		:= choose(rec_cnt,	
									l.debtor1City+' '+l.debtor1State+' '+l.debtor1Zip,
									l.debtor1City+' '+l.debtor1State+' '+l.debtor1Zip,
									l.debtor1AttorneyCity+' '+l.debtor1AttorneyState+' '+l.debtor1AttorneyZip+' '+l.debtor1AttorneyZip4,				
									l.debtor1City+' '+l.debtor1State+' '+l.debtor1Zip,
									l.debtor1AttorneyCity+' '+l.debtor1AttorneyState+' '+l.debtor1AttorneyZip+' '+l.debtor1AttorneyZip4
									);
		self.orig_city 		:= choose(rec_cnt,
									l.debtor1City,
									l.debtor1City,
									l.debtor1AttorneyCity,
									l.debtor1City,
									l.debtor1AttorneyCity
									);
		self.orig_st 		:= choose(rec_cnt,
									l.debtor1State,
									l.debtor1State,
									l.debtor1AttorneyState,
									l.debtor1State,
									l.debtor1AttorneyState
									); 
		self.orig_zip5 		:= choose(rec_cnt,
									l.debtor1Zip,
									l.debtor1Zip,
									l.debtor1AttorneyZip,
									l.debtor1Zip,
									l.debtor1AttorneyZip
									); 
		self.orig_zip4 		:= choose(rec_cnt,
									l.debtor1Zip4,
									l.debtor1Zip4,
									l.debtor1AttorneyZip4,
									l.debtor1Zip4,
									l.debtor1AttorneyZip4
									);
		self.phone 		:= choose(rec_cnt,
								trim(l.debtor1Phone),
								trim(l.debtor1Phone),
								l.debtor1AttorneyPhone,
								'',
								l.debtor1AttorneyPhone
								);
		self.seq_number  	:= l.seq_number;
		self.name_type 	:= choose(rec_cnt,
								'D',
								'D',
								if(l.debtor1PriYN = 'Y','A1','A2'),
								'D',
								if(l.debtor1PriYN = 'Y','A1','A2')
								); 
		self.process_date 	:= l.process_date ;
		self.RMSID 		:= l.RMSID  ;
		self.TMSID 		:= l.TMSID  ;
		self.date_last_seen  	:= l.date_last_seen; 
		self.date_first_seen 	:= l.date_first_seen  ;
		self.debtor1PriYN 	:= 	choose(rec_cnt,
									l.debtor1PriYN,
									l.debtor1PriYN,
									'',
									l.debtor1PriYN,
									''
									);
								
		self.debtor1Type 	:= choose(rec_cnt,
									l.debtor1Type,
									l.debtor1Type,
									'',
									l.debtor1Type,
									''
									);
			
		self.latestflag  	:= l.latestflag ;
		self.chapter 		:= l.chapter;
		self.discharged 	:= if(trim(l.dateDischarged) <> '' and length(stringlib.stringfilter(l.dateDischarged,'1234567890')[1..8]) = 8,
								stringlib.stringfilter(l.dateDischarged,'1234567890')[1..8],
								if(trim(l.dateDischargeNA) <> '' and length(stringlib.stringfilter(l.dateDischargeNA,'1234567890')[1..8]) = 8,
								stringlib.stringfilter(l.dateDischargeNA,'1234567890')[1..8],
								if(trim(l.dateDismissed) <> '' and length(stringlib.stringfilter(l.dateDismissed,'1234567890')[1..8]) = 8,
								stringlib.stringfilter(l.dateDismissed,'1234567890')[1..8],
								'')));
		self.business_flag 	:= l.debtor1Type;  							
		self.corp_flag 	:= if(trim(l.debtor1Type) = 'B','Y','N');
		self.disposition 	:= if(trim(l.dateDischarged) <> '' and length(stringlib.stringfilter(l.dateDischarged,'1234567890')[1..8]) = 8,
								'Discharged',
								if(trim(l.dateDischargeNA) <> '' and length(stringlib.stringfilter(l.dateDischargeNA,'1234567890')[1..8]) = 8,
								'Discharge NA',
								if(trim(l.dateDismissed) <> '' and length(stringlib.stringfilter(l.dateDismissed,'1234567890')[1..8]) = 8,
								'Dismissed',
								'')));
						
		self.pro_se_ind 	:= if(stringlib.stringtolowercase(trim(l.debtor1Attorney)) = 'pro se','Y','N');
		self.filing_type 	:= l.debtor1Type;			
		self.converted_date 	:= stringlib.stringfilter(l.dateConverted,'1234567890')[1..8];
		self.date_filed 	:= stringlib.stringfilter(l.date_filed,'1234567890')[1..8];
		self.county		:= l.county;
		self.debtor_seq := '';
		self.cname := '';
		self.clean_name := '';
		self.clean_address := '';
		self.dispTypeDesc := '';
		self.srcDesc := '';
		self.srcMtchDesc := '';
		self.screenDesc := '';
		self.dcodeDesc := '';
		self.record_type := '';
		self.orig_name := '';
		self.orig_company := '';
		self.orig_email := l.debtor1AttorneyEmail;
		self.orig_fax := l.debtor1AttorneyFax;
		self.lf := '\n';
	end;
	
	init_mapping_out := NORMALIZE(join_case_def_out(length(trim(debtor1DBAs)) <= 2550),5,initial_mapping(left,counter),local);
	
	//Patch to Ut.NoWords - Always Pull Record
	fnAddOne(string inField, string inPara):= function
		nwResults := ut.NoWords(inField, inPara);	
		addOne    := if(nwResults = 0, 1, nwResults);
		return addOne;
	end;	
	
	// orig_name and orig_company contain ~'s - get the count of all ~'s for normalize
	layout_bankruptcy_search_in_plus := record
		layout_bankruptcy_search_in_intermediate;
		integer name_cnt;
		integer comp_cnt;
	end;
	
	layout_bankruptcy_search_in_plus get_cnt(init_mapping_out l) := transform
		self := l;
		self.name_cnt := fnAddOne(l.name,'~');
		self.comp_cnt := fnAddOne(l.company,'~');
	end;
	
	get_cnt_out := project(init_mapping_out(name <> '' or company <> ''),get_cnt(left));
	
	// normalize orig_name
	layout_bankruptcy_search_in_plus norm_name(get_cnt_out l,unsigned c) := transform
		self.orig_name := TRIM( ut.Word(l.name,c,'~'),LEFT,RIGHT );
		self := l;
	end;
	
	norm_name_out := normalize(get_cnt_out,left.name_cnt,norm_name(left,counter),local);
	
	// normalize orig_company
	layout_bankruptcy_search_in_plus norm_company(norm_name_out l,unsigned c) := transform
		self.orig_company := TRIM( ut.Word(l.company,c,'~'),LEFT,RIGHT );
		self := l;
	end;
	
	norm_comp_out := normalize(norm_name_out,left.comp_cnt,norm_company(left,counter),local);
	
	// clean fields
	bankruptcyv2.layout_bankruptcy_search_in clean_info(norm_comp_out l,courtcaselookup r) := transform
		infoset := ['INFORMATION UNAVAILABLE',
								'INFOINFORMATION UNAVAILABLE',
								'INFORAMTION UNAVAILABLE',
								'INFORMAITON UNAVAILABLE',
								 'INFORMAITON UNKNOWN',
								 'INFORMATION UNKNOWN',
								 'INFORMATION  UNAVAILABLE',
								 'INFORMATION NOT AVAILABLE',
								 'INFORMATION NOT LISTED',
								 'INFORMATION UANVAILABLE ',
								 'INFORMATION UNAVAIALBLE',
								 'INFORMATION UNAVAILABLE',
								 'INFORMATION UNAVAILALBE',
								 'INFORMATION UNAVAILALE',
								 'INFORMATION UNAVIAILABLE',
								 'INFORMATION UNAVIALABLE',
								 'INFORMATION UNVAILABLE',
								 'INFORMTION UNAVAILABLE',
								 'INFORAMTION UNAVAILABLE' ,
								 'UKNOWN',
								 'UNAVAILABLE',
								 'UNKNOWN',
								 'UNASSIGNED',
								 'UNAVAILABLE',
								 'NONE ASSIGNED' ,
								 'UNAVAILBLE'];
		self.record_type := if(l.chapter = '304',
							'SECTION ' + trim(l.chapter) + ' ' + trim(stringlib.stringtouppercase(l.disposition)),
							'CHAPTER ' + trim(l.chapter) + ' ' + trim(stringlib.stringtouppercase(l.disposition)));
		self.dispTypeDesc  :=  if(trim(l.dispType) = '0' ,'OPEN',
								if(trim(l.dispType) = '2' ,'DISCHARGED',
									if(trim(l.dispType) = '3' ,'DISCHARGE_NA',
										if(trim(l.dispType) = '4' ,'DISMISSED',
											if(trim(l.dispType) = '5' ,'FILED_IN_ERROR',
												if(trim(l.dispType) = '6' ,'TRANSFER_OUT',        
													if(trim(l.dispType) = '7' ,'SPLIT_OUT',
														if(trim(l.dispType) = '8' ,'CONSOLIDATED_OUT',
															if(trim(l.dispType) = '9' ,'CLOSED', '')))))))));
		self.srcDesc  	    :=  if(trim(l.ssnSrc) = 'E' ,'EBN - ELECTRONIC BANKRUPTCY NOTICE',
									if(trim(l.ssnSrc) = 'M' ,'MANUAL', 
										if(trim(l.ssnSrc) = 'O' ,'OKLAHOMA',   '')));
		self.srcMtchDesc   :=  if(trim(l.ssnMSrc) = 'E' ,'EBN - ELECTRONIC BANKRUPTCY NOTICE',
									if(trim(l.ssnMSrc) = 'M' ,'MANUAL', 
										if(trim(l.ssnMSrc) = 'O' ,'OKLAHOMA',   
											if(trim(l.ssnMSrc) = 'T' ,'ACCURINT-COURT VERIFIED', ''))));
		self.dcodeDesc     :=  if(trim(l.dCode) = '02' 	,'OPEN',
									if(trim(l.dCode) = '15' ,'DISMISSED', 
										if(trim(l.dCode) = '20' ,'DISCHARGED',   
											if(trim(l.dCode) = '30' ,'CONVERSION',
												if(trim(l.dCode) = '88' ,'RE-INSTATED',
													if(trim(l.dCode) = '99' ,'CLOSED/UNKNOWN', ''))))));
		self.screenDesc    :=  if(trim(l.screen) = '1' ,'NEW FILING',
									if(trim(l.screen) = '2' ,'341 UPDATE', 
										if(trim(l.screen) = '3' ,'CASE CLOSED OR DISPOSED',   '')));

		self.orig_name := if(stringlib.stringtouppercase(l.orig_name) in infoset,'',trim(l.orig_name,left,right)) ;
		self.orig_fname := if(stringlib.stringtouppercase(l.orig_fname) in infoset,'',l.orig_fname) ;
		self.orig_mname := if(stringlib.stringtouppercase(l.orig_mname) in infoset,'',l.orig_mname) ;
		self.orig_lname := if(stringlib.stringtouppercase(l.orig_lname) in infoset,'',l.orig_lname) ;
		self.orig_company := if(stringlib.stringtouppercase(l.orig_company) in infoset,'',trim(l.orig_company,left,right)) ;
		self.cname := if(stringlib.stringtouppercase(l.orig_company) in infoset,'',trim(l.orig_company,left,right)) ;
		self.orig_addr1 := trim(l.orig_addr1,left,right);
		self.orig_addr2 := trim(l.orig_addr2,left,right);
		self.orig_city := trim(l.orig_city,left,right);
		self.orig_st := trim(l.orig_st,left,right);
		self.orig_zip5 := trim(l.orig_zip5,left,right);
		self.orig_zip4 := trim(l.orig_zip4,left,right);

  // DF-23773 Use Orig_Name Values instead of Address.CleanPersonFML73 for Defendants
    STRING73 BuildName(STRING5 title='', STRING20 fname, STRING20 mname, STRING20 lname, STRING5 suffix, INTEGER2 score=99) :=
      STD.Str.ToUpperCase(title)+
      STD.Str.ToUpperCase(fname)+
      STD.Str.ToUpperCase(mname)+
      STD.Str.ToUpperCase(lname)+
      STD.Str.ToUpperCase(suffix)+
      IF(fname='' AND lname='','',INTFORMAT(score,3,0));
		self.clean_name :=  IF(stringlib.stringtouppercase(l.orig_name) in infoset or l.orig_name = '',
                          '',
                          IF(l.name_type='D',
                            BuildName('',l.orig_fname,l.orig_mname,l.orig_lname,l.orig_name_suffix),
                            Address.CleanPersonFML73(l.orig_name)
                          )
                        ) ;
                          
		self.clean_address := if(l.orig_addr1 = '' and l.orig_addr2 = '','',
								Address.CleanAddress182(l.orig_addr1,l.orig_addr2));
		self.ssn := if(l.ssn[1..5] = '00000',l.ssn[6..9],l.ssn);
		self.tax_id := if(l.tax_id[1..5] = '00000',l.tax_id[6..9],l.tax_id);

		self := l;
	end;
	
	court_search_out := join(norm_comp_out,courtcaselookup,
							left.court_code + left.case_number = right.court_code_case_number,
							clean_info(left,right),
							left only,
							lookup)(not(trim(orig_name) = '' and trim(orig_company) = ''));
	
	// End search file
	// File validation
	totmaincount := count(court_case_out);
	totmainerrcount := count(court_case_out(trim(clean_name,left,right) = 'ERR'));
	totmainaddresscount := count(court_case_out(trim(clean_address,left,right) = 'U001'));
	totsearchcount := count(court_search_out);
	totsearcherrcount := count(court_search_out(trim(clean_name,left,right) = 'ERR'));
	totsearchaddresscount := count(court_search_out(trim(clean_address,left,right) = 'U001'));
	
	create_files := parallel(
							sequential(
							if (fileservices.findsuperfilesubname('~thor_data400::in::bankruptcyv3::main','~thor_data400::in::bankruptcyv3::'+filedate+'::main') > 0 or
								fileservices.findsuperfilesubname('~thor_data400::in::bankruptcyv3::main_full','~thor_data400::in::bankruptcyv3::'+filedate+'::main') > 0,
								sequential(
									fileservices.clearsuperfile('~thor_data400::in::bankruptcyv3::main'),
									fileservices.removesuperfile('~thor_data400::in::bankruptcyv3::main_full','~thor_data400::in::bankruptcyv3::'+filedate+'::main')
									)),
							output(court_case_out,,'~thor_data400::in::bankruptcyv3::'+filedate+'::main',overwrite,COMPRESSED)),
							sequential(
							if (fileservices.findsuperfilesubname('~thor_data400::in::bankruptcyv3::search','~thor_data400::in::bankruptcyv3::'+filedate+'::search') > 0 or
							fileservices.findsuperfilesubname('~thor_data400::in::bankruptcyv3::search_full','~thor_data400::in::bankruptcyv3::'+filedate+'::search') > 0,
								sequential(
									fileservices.clearsuperfile('~thor_data400::in::bankruptcyv3::search'),
									fileservices.removesuperfile('~thor_data400::in::bankruptcyv3::search_full','~thor_data400::in::bankruptcyv3::'+filedate+'::search')
									)),
							output(court_search_out,,'~thor_data400::in::bankruptcyv3::'+filedate+'::search',overwrite,COMPRESSED))
							);
	
	super_main := sequential(
							if(~fileservices.superfileexists('~thor_data400::in::bankruptcyv3::main'),
								fileservices.createsuperfile('~thor_data400::in::bankruptcyv3::main')),
							if(~fileservices.superfileexists('~thor_data400::in::bankruptcyv3::main_full'),
								fileservices.createsuperfile('~thor_data400::in::bankruptcyv3::main_full')),
							FileServices.StartSuperFileTransaction(),
                            fileservices.clearsuperfile('~thor_data400::in::bankruptcyv3::main'),
							fileservices.addsuperfile('~thor_data400::in::bankruptcyv3::main','~thor_data400::in::bankruptcyv3::'+filedate+'::main'),
							//fileservices.addsuperfile('~thor_data400::in::bankruptcyv3::main_full','~thor_data400::in::bankruptcyv3::'+filedate+'::main'),
							FileServices.FinishSuperFileTransaction());

	super_search := sequential(
							if(~fileservices.superfileexists('~thor_data400::in::bankruptcyv3::search'),
								fileservices.createsuperfile('~thor_data400::in::bankruptcyv3::search')),
							if(~fileservices.superfileexists('~thor_data400::in::bankruptcyv3::search_full'),
								fileservices.createsuperfile('~thor_data400::in::bankruptcyv3::search_full')),
							FileServices.StartSuperFileTransaction(),
                            fileservices.clearsuperfile('~thor_data400::in::bankruptcyv3::search'),
							fileservices.addsuperfile('~thor_data400::in::bankruptcyv3::search','~thor_data400::in::bankruptcyv3::'+filedate+'::search'),
							//fileservices.addsuperfile('~thor_data400::in::bankruptcyv3::search_full','~thor_data400::in::bankruptcyv3::'+filedate+'::search'),
							FileServices.FinishSuperFileTransaction());
	
	missing_case := if (count(clean_missing_cases) > 0,
									sequential(
									output(choosen(clean_missing_cases,10)),
									fileservices.sendemail('Anantha.Venkatachalam@lexisnexis.com, Christopher.Brodeur@lexisnexis.com, Valerie.Minnis@lexisnexis.com',
			'Bankruptcy Missing Cases ' + (STRING8)Std.Date.Today(),
			'Please check the WU to determine the missing cases and check with Banko.' + WORKUNIT)),
			output('No missing cases'));
	
	
	return if((((totmainerrcount / totmaincount) > .01) or 
								((totsearcherrcount / totsearchcount) > .01) or 
								((totsearchaddresscount / totsearchcount) > .01) or 
								((totmainaddresscount / totmaincount) > .01)),
					 sequential(
					 if(_Control.ThisEnvironment.Name != 'Prod_Thor', fileservices.sendemail('Anantha.Venkatachalam@lexisnexis.com',
			'Bankruptcy Process failure:ERROR:' + (STRING8)Std.Date.Today(),
			'More than 1% of Bankruptcy records have clean names with value ERR\n'),
					fileservices.sendemail('Joseph.Lezcano@lexisnexis.com,Vesa.Niemela@lexisnexis.com,Lisa.Simmons@lexisnexis.com,Mike.Schumacher@lexisnexis.com,Brian.Dunnam@lexisnexis.com,Victor.tavernini@lexisnexis.com,Jeff.Torres@lexisnexis.com,Anantha.Venkatachalam@lexisnexis.com,afterhourssupport@lexisnexis.com,Christopher.Brodeur@lexisnexis.com,Sayeed.ahmed@lexisnexis.com',
			'Bankruptcy Process failure:ERROR:' + (STRING8)Std.Date.Today(),
			'More than 1% of Bankruptcy records have clean names or clean_addresses with value ERR or U001\n')),
					 fail('Process Abort: More than 1% of the records have clean name or clean address with value ERR or U001')),
					 sequential(missing_case,create_files,super_main,super_search));
		
end;