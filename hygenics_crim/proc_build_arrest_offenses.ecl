import crim_common, lib_date,STD ;
 
def := distribute(hygenics_crim.file_in_defendant_arrests(),hash(recordid,sourceid));
cha := distribute(hygenics_crim.file_in_charge_arrests(),hash(recordid,sourceid));
off := distribute(hygenics_crim.file_in_offense_arrests(),hash(recordid,sourceid));
sen := distribute(hygenics_crim.file_in_sentence_arrests(),hash(recordid,sourceid));


layout_j_final := record

	//string ln_vendor := '';

	//from def
	string40	RecordID;
	string8	  DOB;
	string100	SourceName;
	string20	SourceType;
	string2		StateCode;
	string20	RecordType;
	string115	Name;
	string1 	NameType;
	string100	DefendantStatus;
	string20	DOCNumber;
	string20	FBINumber;
	string20	StateIDNumber;
	string20	InmateNumber;
	string20	AlienNumber;
	string200	DefendantAdditionalInfo;
	string20	DLNumber;
	string2		DLState;
	string100	InstitutionName;
	string200	InstitutionDetails;
	string8		InstitutionReceiptDate;
	string100	ReleaseToLocation;
	string200	ReleaseToDetails;
	string		Race;
	string		Gender;
	//string8	SexOffenderRegistryDate;
	//string8	SexOffenderRegExpirationDate;
	//string100 SexOffenderRegistryNumber;

	//from charge
	string40	CaseID						:= '';
	string20	WarrantNumber				:= '';
	//string8	WarrantDate					:= '';
	string200	WarrantDesc					:= '';
	//string8	WarrantIssueDate			:= '';
	string50	WarrantIssuingAgency		:= '';
	string100	WarrantStatus				:= '';
	string20	CitationNumber      		:= '';
	string20	BookingNumber				:= '';
	string8		ArrestDate					:= '';
	string50	ArrestingAgency				:= '';
	string8		BookingDate					:= '';
	string8		CustodyDate					:= '';
	string50	CustodyLocation				:= '';
	string100	InitialCharge				:= '';
	string8		InitialChargeDate			:= '';
	string8		InitialChargeCancelledDate	:= '';
	string100	ChargeDisposed				:= '';
	string8		ChargeDisposedDate			:= '';
	string20	ChargeSeverity				:= '';
	string150	ChargeDisposition			:= '';
	string100	AmendedCharge				:= '';
	string8		AmendedChargeDate			:= '';
	//string50	Bondsman					:= '';
	string10	BondAmount					:= '';
	string50	BondType					:= '';

	//from offense
	//string40	RecordID;
	//string100	SourceName;
	//string20	SourceType;
	//string2	StateCode;
	string50	CaseNumber					:= '';
	string100	CaseTitle					:= '';
	string20	CaseType					:= '';
	string100	CaseStatus					:= '';
	string8		CaseStatusDate				:= '';
	string200	CaseComments				:= '';
	string8		FiledDate					:= '';
	string100	CaseInfo					:= '';
	string30	DocketNumber				:= '';
	string30	OffenseCode	    			:= '';
	string100	OffenseDesc	    			:= '';
	string8		OffenseDate					:= '';
	string100	OffenseType					:= '';
	string20	OffenseDegree				:= '';
	string20	OffenseClass				:= '';
	string100	DispositionStatus			:= '';
	//string8	DispositionStatusDate		:= '';
	string150	Disposition					:= '';
	string8		DispositionDate				:= '';
	string50	OffenseLocation				:= '';
	string100	FinalOffense				:= '';
	string8		FinalOffenseDate			:= '';
	string4		OffenseCount				:= '';
	//string1	VictimUnder18				:= '';
	string1		PriorOffenseFlag			:= '';
	string20	InitialPlea					:= '';
	//string8	InitialPleaDate				:= '';
	string20	FinalRuling					:= '';
	string8		FinalRulingDate				:= '';
	string50	AppealStatus				:= '';
	string8		AppealDate					:= '';
	string50	CourtName					:= '';
	string10	FineAmount					:= '';
	string10	CourtFee					:= '';
	string10	Restitution					:= '';
	string20	TrialType					:= '';
	string8	  CourtDate					:= '';
	string8   classification_code := '';
	//string		County						:= '';

	//from sentence
	string8		SentenceDate				:= '';
	string8		SentenceBeginDate		  	:= '';
	string8		SentenceEndDate			  	:= '';
	string20	SentenceType				:= '';
	string10	SentenceMaxYears		  	:= '';
	string10	SentenceMaxMonths		  	:= '';
	string10	SentenceMaxDays			  	:= '';
	string10	SentenceMinYears		  	:= '';
	string10	SentenceMinMonths		  	:= '';
	string10	SentenceMinDays			  	:= '';
	string8		ScheduledReleaseDate		:= '';
	string8		ActualReleaseDate			:= '';
	string100	SentenceStatus				:= '';
	string10	TimeServedYears				:= '';
	string10	TimeServedMonths			:= '';
	string10	TimeServedDays				:= '';
	string10	PublicServiceHours			:= '';
	string200	SentenceAdditionalInfo		:= '';
	string50	CommunitySupervisionCounty	:= '';
	string10	CommunitySupervisionYears	:= '';
	string10	CommunitySupervisionMonths	:= '';
	string10	CommunitySupervisionDays	:= '';
	// string8	ParoleBeginDate				:= '';
	// string8	ParoleEndDate				:= '';
	// string8	ParoleEligibilityDate		:= '';
	// string8	ParoleHearingDate			:= '';
	string10	ParoleMaxYears				:= '';
	string10	ParoleMaxMonths				:= '';
	string10	ParoleMaxDays				:= '';
	string10	ParoleMinYears				:= '';
	string10	ParoleMinMonths				:= '';
	string10	ParoleMinDays				:= '';
	//string100	ParoleStatus				:= '';
	//string50	ParoleOfficer				:= '';
	//string20	ParoleOffcerPhone			:= '';
	string8		ProbationBeginDate			:= '';
	string8		ProbationEndDate			:= '';
	string10	ProbationMaxYears			:= '';
	string10	ProbationMaxMonths			:= '';
	string10	ProbationMaxDays			:= '';
	string10	ProbationMinYears			:= '';
	string10	ProbationMinMonths			:= '';
	string10	ProbationMinDays			:= '';
	string100	ProbationStatus				:= '';
	string20  sourceid              :='';
	//
end;

layout_j_final to_j1(def l, off r) := transform
 //self.ln_vendor 		  := trim(hygenics_crim._functions.fn_sourcename_to_vendor(trim(l.sourcename), trim(l.statecode)));
 self.name := If(regexfind('([": ,-;/]AKA[": ,-;/])|[(]AKA',l.name+' '), _functions.strip_name_from_AKA(l.name,l.lastname,l.firstname,l.middlename,l.suffix),l.name);
 /*MAP(regexfind('(.*)([ -/;]AKA[ /-;])(.*)',l.lastname) and 
										 l.firstname <> '' and l.middlename <> '' => trim(trim(regexreplace('(.*)([ -/;]AKA[ /-;])(.*)',l.lastname,'$1')) +', '+trim(l.firstname)+' '+trim(l.middlename)+' '+trim(l.suffix),left,right),
										 regexfind('(.*)([ -/;]AKA[ /-;])(.*)',l.lastname) and 
										 l.firstname <> '' and l.middlename = ''  => trim(trim(regexreplace('(.*)([ -/;]AKA[ /-;])(.*)',l.lastname,'$1')) +', '+trim(l.firstname)+' '+trim(l.suffix),left,right),
										 regexfind('(.*)([ -/;]AKA[ /-;])(.*)',l.lastname) and 
										 l.firstname = '' and l.middlename <> ''  => trim(trim(regexreplace('(.*)([ -/;]AKA[ /-;])(.*)',l.lastname,'$1')) +', '+trim(l.middlename)+' '+trim(l.suffix),left,right),
										 
										 regexfind('(.*)(- AKA[ /-;])(.*)',l.name) => regexreplace('(.*)(- AKA[ /-;])(.*)',l.name,'$1'),
										 regexreplace('(.*)([ -/;]AKA[ /-;])(.*)',l.name,'$1')
										 );*/
 self.fileddate 		  := if(trim(r.fileddate)[1..2] between '19' and '20' 
								and length(trim(r.fileddate))>=4 
								and r.fileddate<=stringlib.GetDateYYYYMMDD(),
								trim(r.fileddate),
								'');	
 //self.casetitle			  := r.casetitle;
 self.casetype			  := r.casetype;
 self.casenumber		  := r.casenumber;
 self.casestatus		  := r.casestatus;
 self.offensetype		  := r.offensetype;
 self.offensecount	  := r.offensecount;
 self.offensecode		  := r.offensecode;
 self.offensedesc		  := r.offensedesc;
 self.dispositiondate 	  := if(trim(r.dispositiondate)[1..2] between '19' and '20' 
								and length(trim(r.dispositiondate))>=4 
								and r.dispositiondate<=stringlib.GetDateYYYYMMDD(),
								trim(r.dispositiondate),
								'');
 self.disposition		  := r.disposition;
 self.offenselocation	:= r.offenselocation;
 self.courtdate			  := r.courtdate;
 self.restitution		  := r.restitution;
 self 					  := l;
 self 					  := r;
end;

j1 := join(def,off, 
		left.sourceid=right.sourceid and 
		left.recordid=right.recordid, 
		to_j1(left,right),local);

layout_j_final to_j2(j1 l, cha r) := transform

  self.citationnumber 	 := r.citationnumber;
  self.arrestdate        := r.arrestdate;
  self.CustodyDate     	 := r.CustodyDate;
  Self.ArrestingAgency	 := r.ArrestingAgency;
  Self.CustodyLocation	 := r.CustodyLocation;
  Self.InitialCharge	 	 := r.InitialCharge;
  Self.InitialChargeDate := r.InitialChargeDate;	
  Self.InitialChargeCancelledDate	:= r.InitialChargeCancelledDate;
  Self.ChargeDisposed	 := r.ChargeDisposed;
  Self.ChargeDisposedDate:= r.ChargeDisposedDate;
  Self.ChargeSeverity	 := r.ChargeSeverity;
  Self.ChargeDisposition := r.ChargeDisposition;
  Self.AmendedCharge	 := r.AmendedCharge;
  Self.AmendedChargeDate := r.AmendedChargeDate;	 
	self.bookingnumber := r.bookingnumber;		
	self.WarrantNumber := r.WarrantNumber;
	self.bondamount := r.bondamount;
	self.bondtype := r.bondtype;
	self.bookingdate := r.bookingdate;
  self 					 := l;
  self 					 := r;
end;

j2 := join(j1, cha,
			left.sourceid=right.sourceid and 
			left.recordid=right.recordid and 
			left.caseid=right.caseid, 
			to_j2(left,right), left outer, local);
			
		//	output(choosen(j2,25));

layout_j_final to_j3(j2 l, sen r) := transform
 	self.SentenceDate				  := r.sentencedate;
	self.SentenceBeginDate		:= r.SentenceBeginDate;
	self.SentenceEndDate			:= r.SentenceEndDate;
	self.SentenceType				  := r.SentenceType	;
	self.SentenceMaxYears		  := r.SentenceMaxYears;
	self.SentenceMaxMonths		:= r.SentenceMaxMonths;
	self.SentenceMaxdays		  := r.SentenceMaxdays;
	self.SentenceMinYears		  := r.SentenceMinYears;
	self.SentenceMinMonths		:= r.SentenceMinMonths;
	self.SentenceMinDays			:= r.SentenceMinDays;
	//self.ScheduledReleaseDate	:= '';
	//self.ActualReleaseDate			:= '';
	self.SentenceStatus				:= r.SentenceStatus;
	self.TimeServedYears			:= r.TimeServedYears;
	self.TimeServedMonths			:= r.TimeServedMonths;
	self.TimeServedDays				:= r.TimeServedDays;
	self.PublicServiceHours		:= r.PublicServiceHours;
	self.SentenceAdditionalInfo		  := r.SentenceAdditionalInfo;
	self.CommunitySupervisionCounty	:= r.CommunitySupervisionCounty;
	self.CommunitySupervisionYears	:= r.CommunitySupervisionYears;
	self.CommunitySupervisionMonths	:= r.CommunitySupervisionMonths;
	self.CommunitySupervisionDays	  := r.CommunitySupervisionDays;
	self.ProbationBeginDate		  	  := r.ProbationBeginDate;
	self.ProbationEndDate			      := r.ProbationEndDate;
	self.ProbationMaxYears			  := r.ProbationMaxYears;
	self.ProbationMaxMonths		  	:= r.ProbationMaxMonths;
	self.ProbationMaxDays			    := r.ProbationMaxDays;
	self.ProbationMinYears			  := r.ProbationMinYears;
	self.ProbationMinMonths		  	:= r.ProbationMinMonths;
	self.ProbationMinDays			    := r.ProbationMinDays;
	self.ProbationStatus			    := r.ProbationStatus;
	self.ParoleMaxYears				    := r.ParoleMaxYears;
	self.ParoleMaxMonths			    := r.ParoleMaxMonths;
	self.ParoleMaxDays				    := r.ParoleMaxDays;
	self.ParoleMinYears				    := r.ParoleMinYears;
	self.ParoleMinMonths			    := r.ParoleMinMonths;
	self.ParoleMinDays				    := r.ParoleMinDays;
 self := l;
 //self := r;
 end;
j3 := join(j2,sen, left.sourceid=right.sourceid and left.recordid=right.recordid and left.caseid=right.caseid, 
										to_j3(left,right), left outer, local);

j_final := j3;

//output(j_final,, '~thor::base::hygenics::sample::court_offenses_new_20110113', overwrite);
//output(j3);
Layout_Common_Court_Offenses_orig to_court_offenses(j_final l) := transform

	//-----field from charge file that were not mapped 
	// string50	Bondsman;
	// string10	BondAmount;
	// string50	BondType;
	// string20	ChargeSeverity;
	// string8	CustodyDate;
	// string50	CustodyLocation;
	// string8	InitialChargeDate;  - convict date
	// string8	InitialChargeCancelledDate;
	// string8	AmendedChargeDate;
	//------ field from offense file that were not mapped 
	// string100	CaseStatus;
	// string8		CaseStatusDate;
	// string200	CaseComments;	
	// string100	CaseInfo;
	// string20	  OffenseDegree;
	// string100	DispositionStatus;
	// string8		DispositionStatusDate;
	// string50	  OffenseLocation;
	// string8		FinalOffenseDate;
	// string1		VictimUnder18;
	// string1		PriorOffenseFlag;
	// string8		InitialPleaDate;
	// string50	  AppealStatus;
	// string10	  Restitution;
	 
	// string8		CourtDate;
	//-------------------------------------------------
	
	
  self.process_date				    := stringlib.getdateyyyymmdd();
	string temp_case_number     := MAP(l.casenumber <> ''   => l.casenumber, 
											               l.DocketNumber <> '' => l.DocketNumber,
											               '');
	ls_vendor                   := trim(hygenics_crim._functions.fn_sourcename_to_vendor(trim(l.sourcename), trim(l.statecode)));										
	vcase_type                  := '';
	
	
	   casenumber := map(l.sourcename='ALABAMA_BALDWIN_COUNTY_ARRESTS' and 
																						    regexfind('([A-Z0-9]+)( )(.*)',l.casenumber)
																													    => regexreplace('([A-Z0-9]+)( )(.*)',l.casenumber,'$1'),
																															           REGEXFIND('CRIME FOR BENEFIT',l.casenumber,NOCASE) =>'',
																																				     REGEXFIND('ENTER AT DIV',l.casenumber,NOCASE) =>'',
																																						      REGEXFIND('TERMINATED DIVERSION',l.casenumber,NOCASE) =>''																															
																																																					    ,l.casenumber); 
	
	 vVendor 								:= hygenics_crim._functions.fn_sourcename_to_vendor(trim(l.sourcename), trim(l.statecode)); 
	 v_pty_nm               := StringLib.StringFilter(StringLib.StringToUpperCase(l.name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); 	
	 vDob										:= StringLib.StringFilter(StringLib.StringToUpperCase(l.dob),'0123456789'); 	
	 vBookingNumber					:= StringLib.StringFilter(StringLib.StringToUpperCase(l.bookingnumber),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	 vBookingDate						:= if(regexfind('/', l.bookingdate, 0)<>'',
																(string)LIB_Date.Date_MMDDYY_I2(regexreplace('/', l.bookingdate, '')),
																l.bookingdate);
	 vArrestDate						:= if(regexfind('/', l.arrestdate, 0)<>'',
																(string)LIB_Date.Date_MMDDYY_I2(regexreplace('/', l.arrestdate, '')),
																l.arrestdate);
	 vCourtDate							:= if(regexfind('/', l.courtdate, 0)<>'',
																(string)LIB_Date.Date_MMDDYY_I2(regexreplace('/', l.courtdate, '')),
																l.courtdate);
	 vOffenseDate						:= if(regexfind('/', l.offensedate, 0)<>'',
																(string)LIB_Date.Date_MMDDYY_I2(regexreplace('/', l.offensedate, '')),
																l.offensedate);
	 vFileDate							:= if(regexfind('/', l.fileddate, 0)<>'',
																(string)LIB_Date.Date_MMDDYY_I2(regexreplace('/', l.fileddate, '')),
																l.fileddate);
	 vDispDate							:= if(regexfind('/', l.dispositiondate, 0)<>'',
																(string)LIB_Date.Date_MMDDYY_I2(regexreplace('/', l.dispositiondate, '')),
																l.dispositiondate);
	 vCourtName							:= StringLib.StringFilter(StringLib.StringToUpperCase(l.courtname),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	 vDocketNum							:= StringLib.StringFilter(StringLib.StringToUpperCase(l.docketnumber),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	 vCaseID								:= StringLib.StringFilter(StringLib.StringToUpperCase(l.caseid),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	 
	 self.offender_key			:= if(l.nametype <>'A' and trim(vBookingDate, left, right) <>'' and trim(vVendor) not in ['BN','BU','BY','CV','GH','GX','IP','KB','NQ'],
																		trim(vVendor) + (string)HASH64(v_pty_nm) + trim(vDOB, all) + vBookingDate,
																 if(l.nametype <>'A' and trim(vArrestDate, left, right) <>'' and trim(vVendor) not in ['BN','BU','BY','CV','KB'],
																		trim(vVendor) + (string)HASH64(v_pty_nm) + trim(vDOB, all) + vArrestDate,
																 if(l.nametype <>'A' and trim(vBookingNumber, left, right) <>'' and trim(vVendor) in ['BJ','BN','BU','BY','CV','GH','GX','IP','KB','NQ'],
																		trim(vVendor) + (string)HASH64(v_pty_nm) + trim(vDOB, all) + vBookingNumber,
																 if(l.nametype <>'A' and trim(vCourtName, left, right) <>'' and trim(vVendor) in ['BM','CS','LI','QE'],
																		trim(vVendor) +(string)HASH64(v_pty_nm) + trim(vDOB, all) + vCourtName,
																 if(l.nametype <>'A' and trim(vCourtDate, left, right) <>'' and trim(vVendor) in ['BZ','HG','KI','IQ','KL'],
																		trim(vVendor) + (string)HASH64(v_pty_nm) + trim(vDOB, all) + vCourtDate,
																 if(l.nametype <>'A' and trim(vDocketNum, left, right) <>'' and trim(vVendor) in ['CW','LH','LJ'],
																		trim(vVendor) + (string)HASH64(v_pty_nm) + trim(vDOB, all) + vDocketNum,
																 if(l.nametype <>'A' and trim(vDispDate, left, right) <>'' and trim(vVendor) in ['MQ','MU','MY','NI','NK'],
																		trim(vVendor) + (string)HASH64(v_pty_nm) + trim(vDOB, all) + vDispDate,
																 if(l.nametype <>'A' and trim(vOffenseDate, left, right) <>'' and trim(vVendor) in ['HX'],
																		trim(vVendor) + (string)HASH64(v_pty_nm) + trim(vDOB, all) + vOffenseDate,
																		trim(vVendor) + (string)HASH64(v_pty_nm) + trim(vDOB, all) + trim(l.race)+trim(l.gender)))))))));
																		
  //self.offender_key				  := hygenics_crim._functions.fn_offender_key(ls_vendor, l.recordid,temp_case_number,l.fileddate);
  self.vendor					        := trim(ls_vendor);
  self.state_origin				    := trim(l.statecode);
  self.source_file				    := trim(hygenics_crim._functions.fn_shorten_sourcename(l.sourcename));	
  self.off_comp					      := '';
  self.off_delete_flag		    := '';
	
  // Not sure if Initialchargedate or AmendedChargeDate can be mapped to offense date
  self.off_date					    := if(trim(vOffenseDate)[1..2] between '19' and '20' and 
	                                length(trim(vOffenseDate))>=4 and vOffenseDate<=stringlib.GetDateYYYYMMDD(),
											            trim(vOffenseDate),
											            '');
																	
	arrestdate := if(trim(vArrestDate)[1..2] between '19' and '20' and 
	                                length(trim(vArrestDate))>=4 and vArrestDate<=stringlib.GetDateYYYYMMDD(),
											            trim(vArrestDate),
											            '');
																	
	bookingdate := if(trim(vBookingDate)[1..2] between '19' and '20' and 
	                                length(trim(vBookingDate))>=4 and vBookingDate<=stringlib.GetDateYYYYMMDD(),
											            trim(vBookingDate),
											            '');																
	
																
  self.arr_date					      := map(arrestdate<> '' => if (trim(arrestdate)= '*','',trim(arrestdate)), bookingdate);
  self.num_of_counts			    := If((integer)(l.offensecount) > 99, '',trim(l.offensecount));
 
  self.le_agency_cd				    := '';
  self.le_agency_desc			    := MAP(l.arrestingagency <> '' => trim(l.arrestingagency),
	                                   regexfind('(ISSUING AGENCY: )([A-Z]+[A-Z ]);(.*)',l.casecomments) =>  trim(regexreplace('(ISSUING AGENCY: )([A-Z]+[A-Z ]);(.*)',l.casecomments,'$2'),left,right),
																		 regexfind('ISSUING AGENCY: ',l.casecomments) =>  trim(regexreplace('(ISSUING AGENCY: )(.*)',l.casecomments,'$2'),left,right),
																		 regexfind('FILING AGENCY:',l.casecomments) =>  trim(regexreplace('(FILING AGENCY: )(.*)',l.casecomments,'$2'),left,right),
																		 regexfind('FILING AGENCY:',l.caseinfo) =>  trim(regexreplace('(FILING AGENCY: )(.*)',l.caseinfo,'$2'),left,right),																		 
																		 regexfind('HOLDING AGENCY: ',l.caseinfo) =>  trim(regexreplace('(.*)(HOLDING AGENCY: )(.*)',l.caseinfo,'$3'),left,right),
																		 regexfind('AGENCY:',l.caseinfo) =>  trim(regexreplace('(AGENCY: )(.*)',l.caseinfo,'$2'),left,right),
															       regexfind('(ORIGINATING AGENCY:) ([A-Z]+[A-Z ]*),(.*)',l.casecomments) => trim(regexreplace('(ORIGINATING AGENCY:) ([A-Z]+[A-Z ]*),(.*)',l.casecomments,'$2'),left,right),
																		 regexfind('JURISDICTION: ',l.caseinfo) => trim(regexreplace('(JURISDICTION: )([a-zA-Z]+)',l.caseinfo,'$2'),left,right),																
																		 '');
  self.le_agency_case_number  := trim(l.bookingnumber);
	
  self.traffic_ticket_number  :=  l.CitationNumber;
											            
  self.traffic_dl_no			    := trim(l.DLNumber);
  self.traffic_dl_st			    := trim(l.DLState);
	
	//////////////////////////////////////////////////////////////////////////////////////////////////
	
	//// arrest fields logic ///////
	
	arr_off_desc_1			    := trim(if(l.amendedcharge<>'', l.amendedcharge,l.initialcharge));	
  arr_off_desc_2			    :='' ;
	
	vChargeDisposeDdate			:= if(regexfind('/', l.chargedisposeddate, 0)<>'',
																	(string)LIB_Date.Date_MMDDYY_I2(regexreplace('/', l.chargedisposeddate, '')),
																	l.chargedisposeddate);
	
  arr_disp_date			    := if(trim(vChargeDisposeDdate)[1..2] between '19' and '20' 
								                 and vChargeDisposeDdate<=stringlib.GetDateYYYYMMDD(),
								                 trim(vChargeDisposeDdate),'');
  arr_disp_code			    := '';
  arr_disp_desc_1		    :=  trim(l.chargedisposition); 	
  
	warrantnumber :=  Map(l.WarrantNumber<>'' =>'Warrant#: ' + l.WarrantNumber,'');	
	
  arr_disp_desc_2  :=    map(l.bondamount <> '' => 'BOND AMT: ' + l.bondamount, 
	                                               REGEXFIND('BAIL AMOUNT',l.casecomments,NOCASE) = true => l.casecomments,
																								    REGEXFIND('BAIL AMOUNT',l.caseinfo,NOCASE) = true => l.caseinfo, 
																										    REGEXFIND('TOTAL BAIL',l.caseinfo,NOCASE) = true => l.caseinfo , '')  + 
	                                                        map(l.bondtype <> '' => 'BOND TYP: ' + l.bondtype,'');

	
	
	//// court fields logic ///////
	
	
	string temp_offense         := MAP(trim(l.FinalOffense) <> '' => trim(l.FinalOffense),
											               trim(l.offensedesc) <> '' => trim(l.offensedesc),
											               '');
																		 
															 
  court_off_desc_2		    := MAP(stringlib.stringfind(l.caseinfo,'REASON:',1) >0 => l.caseinfo,
	                                   '');
	
	offensetype   := l.offensetype;
	offenseclass  := l.offenseclass;
	offensedegree := l.offensedegree;
	off_lev :=     trim(MAP(
	
											           l.sourcename = 'CALIFORNIA_LOS_ANGELES_COUNTY_ARRESTS' => offensedegree[1..1],                                                               
                                 l.sourcename = 'COLORADO_EL_PASO_COUNTY_ARRESTS' and trim(offensetype) ='TRAFFIC' => 'T',                                                                       
                                 l.sourcename = 'COLORADO_EL_PASO_COUNTY_ARRESTS' and trim(offensetype) ='FELONY' => 'F',
																 l.sourcename = 'COLORADO_EL_PASO_COUNTY_ARRESTS' and trim(offensetype) ='MISDEMEANOR' => 'M',
																 l.sourcename = 'COLORADO_EL_PASO_COUNTY_ARRESTS' and trim(offensetype) ='MUNICIPAL STATUTE' => 'MUS',
																 l.sourcename = 'COLORADO_EL_PASO_COUNTY_ARRESTS' and trim(offensetype) ='PETTY OFFENSE' => 'PO',
																 
                                 l.sourcename = 'FLORIDA_LAKE_COUNTY_ARRESTS' => trim(offensetype) +	trim(offensedegree),
                                 l.sourcename = 'FLORIDA_PUTNAM_COUNTY_ARRESTS' => trim(offensetype) +	trim(offensedegree),                                                                       
                                 l.sourcename = 'KANSAS_JOHNSON_COUNTY_ARRESTS' => trim(offensetype) +	trim(offensedegree),                                                                       
                                 l.sourcename = 'TEXAS_HARRIS_COUNTY_ARRESTS' and length(trim(offensedegree)) < 5 => trim(offensedegree),                                                                        
				 
                                    regexfind('M-1 AND M-4',offenseclass)      =>   'M1M4', 
                                  	regexfind('M-1',offenseclass)      =>   'M-1', 
																		regexfind('M-2',offenseclass)      =>   'M-2', 
																		regexfind('M-3',offenseclass)      =>   'M-3', 
																		regexfind('M-4',offenseclass)      =>   'M-4', 
																		regexfind('M-M',offenseclass)      =>   'M-M', 
																		regexfind('MINOR MISDEMEANOR',offenseclass)      =>   'M-M', 
																		
																		regexfind('F-1',offenseclass)      =>   'F-1', 
																		regexfind('F-2',offenseclass)      =>   'F-2', 
																		regexfind('F-3',offenseclass)      =>   'F-3', 
																		regexfind('F-4',offenseclass)      =>   'F-4', 
																		regexfind('F-5',offenseclass)      =>   'F-5', 
																		
																	trim(offensedegree)+trim(offensetype)+trim(offensedegree) IN ['NULL','UNKNOWN','OTHER','XX','X','U','OTHR','[',']'] => '',
																	regexfind('MISD[.]*|MISDE',offensedegree) and 	regexfind('UNSPECIF|UNCLASS|UNASSIGN',offensedegree)	=> 'M' ,
																	regexfind('FEL|FELONY',offensedegree) and 	regexfind('UNSPECIF|UNCLASS|UNASSIGN',offensedegree)	=> 'F' ,
                                 	 regexfind('/(M/)&/(F/)',offensetype)      =>   'FM',
																	regexfind('/(F/)',offensetype)      =>   'F',
											            regexfind('/(M/)',offensetype)      =>   'M',
																	regexfind('/(LIFE/)',offensetype)      =>   'L',  
																	
																	regexfind('FEDERAL',offensetype)      =>   'FED',  
																	regexfind('INS',offensetype)      =>   'INS',  
																	
																	regexfind('GROSS MISD',offensedegree)      =>   'GM',  
																	regexfind('PET MISD',offensedegree)      =>   'PM',  
																	regexfind('PETTY MISDEMEANOR',offensedegree)      =>   'PM',  
																	
																	regexfind('MISDEMEANOR A',offensedegree)      =>   'MA',    
                                  regexfind('MISDEMEANOR B',offensedegree)      =>   'MB',    
                                  regexfind('MISDEMEANOR C',offensedegree)      =>   'MC',    																	
																	regexfind('F1-2',offensedegree)      =>   'F1-2', 
																	
																 regexfind('A FELONY',offensetype)      =>   'FA',  
																 regexfind('B FELONY',offensetype)      =>   'FB',  
																 regexfind('C FELONY' ,offensetype)      =>   'FC',  
																 regexfind('D FELONY',offensetype)      =>   'FD',  
																 regexfind('SERIOUS',offensetype)      =>   'SE',  
																 regexfind('SIMPLE',offensetype)      =>   'SI',  	
																	
																	offensedegree ='CAPITAL FELONY' => 'CF',
																	offensedegree ='STATE FELONY' => 'SF',
															    offensedegree ='COMPACT FELONY' => 'FCO',
																	offensedegree ='COMPACT MISDEMEANOR' => 'MCO',
																	offensedegree ='INFRACTION' => 'I',
																	offensetype    IN ['INFRACTION','INF','INFRA','INFRACTI'] => 'I',
																	offensetype    IN ['MIS'] => 'M',
																	offensetype    IN ['ORDINANCE'] => 'O', 
																	regexfind('(CLASS)[ ]([A-Z][0-9]*)[ ](F)(ELONY)',offenseclass)      => regexreplace('(CLASS)[ ]([A-Z][0-9]*)[ ](F)(ELONY)',offenseclass,'$3$2'),       
																	regexfind('(CLASS)[ ]([A-Z][0-9]*)[ ](M)(ISDEMEANOR)',offenseclass) => regexreplace('(CLASS)[ ]([A-Z][0-9]*)[ ](M)(ISDEMEANOR)',offenseclass,'$3$2'),   
																	
																	regexfind('(CLASS)[ ]([0-9])[ ](F)(ELONY)',offenseclass)      => regexreplace('(CLASS)[ ]([0-9])[ ](F)(ELONY)',offenseclass,'$3$2'),       
																	regexfind('(CLASS)[ ]([0-9])[ ](M)(ISDEMEANOR)',offenseclass) => regexreplace('(CLASS)[ ]([0-9])[ ](M)(ISDEMEANOR)',offenseclass,'$3$2'),   
																	
                        					regexfind('(CLASS)[ ]([A-Z])[ ](F)(ELONY)',offensedegree)      => regexreplace('(CLASS)[ ]([A-Z])[ ](F)(ELONY)',offensedegree,'$3$2'),       
                                  regexfind('(CLASS)[ ]([A-Z])[ ](M)(ISDEMEANOR)',offensedegree) => regexreplace('(CLASS)[ ]([A-Z])[ ](M)(ISDEMEANOR)',offensedegree,'$3$2'),   
																	
																	
                  								regexfind('([0-9])(ST|RD|TH|ND)[ ](DEG)[ ](C)(APITAL)[ ](.*)',offensetype) => regexreplace('([0-9])(ST|RD|TH|ND)[ ](DEG)[ ](C)(APITAL)[ ](.*)',offensetype,'$4$1'),       
	                                regexfind('([0-9])(ST|RD|TH|ND)[ ](DEG)[ ](F)(EL[ONY]*)[ ](.*)',offensetype) => regexreplace('([0-9])(ST|RD|TH|ND)[ ](DEG)[ ](F)(EL[ONY]*)[ ](.*)',offensetype,'$4$1'),       
																	regexfind('([0-9])(ST|RD|TH|ND)[ ](DEG)[ ](M)(IS[DEMEANOR.]*)[ ](.*)',offensetype) => regexreplace('([0-9])(ST|RD|TH|ND)[ ](DEG)[ ](M)(IS[DEMEANOR.]*)[ ](.*)',offensetype,'$4$1'),       
																	regexfind('([0-9])(ST|RD|TH|ND)[ ](DEG)[ ](F)(EL[ONY]*)',offensetype) => regexreplace('([0-9])(ST|RD|TH|ND)[ ](DEG)[ ](F)(EL[ONY]*)',offensetype,'$4$1'),       
																	regexfind('([0-9])(ST|RD|TH|ND)[ ](DEG)[ ](M)(IS[DEMEANOR.]*)',offensetype) => regexreplace('([0-9])(ST|RD|TH|ND)[ ](DEG)[ ](M)(IS[DEMEANOR.]*)',offensetype,'$4$1'),       
																	
																	regexfind('([0-9])(ST|RD|TH|ND)[ ](DEG[REE]*)[ ](C)(APITAL)[ ](.*)',offensedegree) => regexreplace('([0-9])(ST|RD|TH|ND)[ ](DEG[REE]*)[ ](C)(APITAL)[ ](.*)',offensedegree,'$4$1'),       
	                                regexfind('([0-9])(ST|RD|TH|ND)[ ](DEG[REE]*)[ ](F)(EL[ONY]*)[ ](.*)',offensedegree) => regexreplace('([0-9])(ST|RD|TH|ND)[ ](DEG[REE]*)[ ](F)(EL[ONY]*)[ ](.*)',offensedegree,'$4$1'),       
																	regexfind('([0-9])(ST|RD|TH|ND)[ ](DEG[REE]*)[ ](M)(IS[DEMEANOR.]*)[ ](.*)',offensedegree) => regexreplace('([0-9])(ST|RD|TH|ND)[ ](DEG[REE]*)[ ](M)(IS[DEMEANOR.]*)[ ](.*)',offensedegree,'$4$1'),       
																	regexfind('([0-9])(ST|RD|TH|ND)[ ](DEG[REE]*)[ ](F)(EL[ONY]*)',offensedegree) => regexreplace('AGG ',regexreplace('([0-9])(ST|RD|TH|ND)[ ](DEG[REE]*)[ ](F)(EL[ONY]*)',offensedegree,'$4$1'),'A'),       
																	regexfind('([0-9])(ST|RD|TH|ND)[ ](DEG[REE]*)[ ](M)(IS[DEMEANOR.]*)',offensedegree) => regexreplace('([0-9])(ST|RD|TH|ND)[ ](DEG[REE]*)[ ](M)(IS[DEMEANOR.]*)',offensedegree,'$4$1'),       
																	
																	regexfind('(C)(APITAL)[ ]([0-9])(ST|RD|TH|ND)[ ](DEG[REE]*)[ ](.*)',offensedegree) => regexreplace('(C)(APITAL)[ ]([0-9])(ST|RD|TH|ND)[ ](DEG[REE]*)[ ](.*)',offensedegree,'$1$3'),       
	                                regexfind('(F)(EL[ONY]*)[ ][- ]*([0-9])(ST|RD|TH|ND)[ ](DEG[REE]*)[ ](.*)',offensedegree) => regexreplace('(F)(EL[ONY]*)[ ][- ]*([0-9])(ST|RD|TH|ND)[ ](DEG[REE]*)[ ](.*)',offensedegree,'$1$3'),       
																	regexfind('(M)(IS[DEMEANOR.]*)[ ][- ]*([0-9])(ST|RD|TH|ND)[ ](DEG[REE]*)[ ](.*)',offensedegree) => regexreplace('(M)(IS[DEMEANOR.]*)[ ][- ]*([0-9])(ST|RD|TH|ND)[ ](DEG[REE]*)[ ](.*)',offensedegree,'$1$3'),       
																	regexfind('(F)(EL[ONY]*)[ ][- ]*([0-9])(ST|RD|TH|ND)[ ](DEG[REE]*)',offensedegree) => regexreplace('(F)(EL[ONY]*)[ ][- ]*([0-9])(ST|RD|TH|ND)[ ](DEG[REE]*)',offensedegree,'$1$3'),       
																	regexfind('(M)(IS[DEMEANOR.]*)[ ][- ]*([0-9])(ST|RD|TH|ND)[ ](DEG[REE]*)',offensedegree) => regexreplace('(M)(IS[DEMEANOR.]*)[ ][- ]*([0-9])(ST|RD|TH|ND)[ ](DEG[REE]*)',offensedegree,'$1$3'),       
																																		
																	regexfind('AGGRAVATED FELONY 1' ,trim(offensedegree))  => 'AF1' ,
				                          regexfind('AGGRAVATED FELONY 2',trim(offensedegree))   => 'AF2' ,
																	regexfind('AGGRAVATED FELONY 3' ,trim(offensedegree))  => 'AF3' ,																	
																	
																	regexfind('FIRST DEGREE FELONY' ,trim(offensedegree))  => 'F1' ,
				                          regexfind('SECOND DEGREE FELONY',trim(offensedegree))  => 'F2' ,
																	regexfind('THIRD DEGREE FELONY' ,trim(offensedegree))  => 'F3' ,
																	regexfind('FIFTH DEGREE FELONY' ,trim(offensedegree))  => 'F5' ,
																	regexfind('FOURTH DEGREE FELONY',trim(offensedegree))  => 'F4' ,		
																	regexfind('FIRST DEGREE M[ISDEMEANOR.]*' ,trim(offensedegree))  => 'M1' ,
				                          regexfind('SECOND DEGREE M[ISDEMEANOR.]*',trim(offensedegree))  => 'M2' ,
																	regexfind('THIRD DEGREE M[ISDEMEANOR.]*' ,trim(offensedegree))  => 'M3' ,
																	regexfind('FIFTH DEGREE M[ISDEMEANOR.]*' ,trim(offensedegree))  => 'M5' ,
																	regexfind('FOURTH DEGREE M[ISDEMEANOR.]*',trim(offensedegree))  => 'M4' ,	
																	regexfind('FIRST DEGREE FELONY' ,trim(offensetype))  => 'F1' ,
				                          regexfind('SECOND DEGREE FELONY',trim(offensetype))  => 'F2' ,
																	regexfind('THIRD DEGREE FELONY' ,trim(offensetype))  => 'F3' ,
																	regexfind('FIFTH DEGREE FELONY' ,trim(offensetype))  => 'F5' ,
																	regexfind('FOURTH DEGREE FELONY',trim(offensetype))  => 'F4' ,																		
																	regexfind('FIRST DEGREE M[ISDEMEANOR.]*' ,trim(offensetype))  => 'M1' ,
				                          regexfind('SECOND DEGREE M[ISDEMEANOR.]*',trim(offensetype))  => 'M2' ,
																	regexfind('THIRD DEGREE M[ISDEMEANOR.]*' ,trim(offensetype))  => 'M3' ,
																	regexfind('FIFTH DEGREE M[ISDEMEANOR.]*' ,trim(offensetype))  => 'M5' ,
																	regexfind('FOURTH DEGREE M[ISDEMEANOR.]*',trim(offensetype))  => 'M4' ,																	
																	regexfind('MISD[EMEANOR]*[- ]*(ONE|FIRST|1ST)[ DEGREE]*',trim(offensetype)  + ' '+ trim(offensedegree)) => 'M1' ,
				                          regexfind('MISD[EMEANOR]*[- ]*(MINOR)',trim(offensetype)  + ' '+ trim(offensedegree)) => 'MM' ,
				                          regexfind('MISD[EMEANOR]*[- ]*(SECOND|2ND)[ DEGREE]*',trim(offensetype) + ' '+ trim(offensedegree))=> 'M2' ,
																	regexfind('MISD[EMEANOR]*[- ]*(THIRD|3RD)[ DEGREE]*',trim(offensetype) + ' '+ trim(offensedegree))=> 'M3' ,
																	regexfind('MISD[EMEANOR]*[- ]*(FOUR|FOURTH|4TH)[ DEGREE]*',trim(offensetype) + ' '+ trim(offensedegree))=> 'M4' ,
																	regexfind('F[ELONY]*[- ]*(ONE|FIRST|1ST)[ DEGREE]*',trim(offensetype) + ' '+ trim(offensedegree)) => 'F1' ,
																	regexfind('F[ELONY]*[- ]*(SECOND|2ND)[ DEGREE]*',trim(offensetype) + ' '+ trim(offensedegree)) => 'F2' ,
																	regexfind('F[ELONY]*[- ]*(THIRD|3RD)[ DEGREE]*',trim(offensetype) + ' '+ trim(offensedegree))=> 'F3' ,
																	regexfind('F[ELONY]*[- ]*(FOUR|FOURTH|4TH)[ DEGREE]*',trim(offensetype) + ' '+ trim(offensedegree)) => 'F4' ,
																	regexfind('F[ELONY]*[- ]*(FIFTH|5TH)[ DEGREE]*',trim(offensetype) + ' '+ trim(offensedegree)) => 'F5' ,
																	regexfind('C[OUNTY]*[- ]*CAPIT[OAL]*',trim(offensetype) + ' '+ trim(offensedegree))=> 'CC' ,
																	regexfind('F[ELONY]*[- ]*CAPIT[OAL]*',trim(offensetype) + ' '+ trim(offensedegree))=> 'FCAP' ,
																	regexfind('F[ELONY]*[- ]*LIFE*',trim(offensetype) + ' '+ trim(offensedegree))=> 'FL' ,                                                                                     
																	regexfind('C[OUNTY]*[- ]*(FIRST|1ST)[ DEGREE]*',trim(offensetype) + ' '+ trim(offensedegree)) =>'CO1',
                                  regexfind('C[OUNTY]*[- ]*(SECOND|2ND)[ DEGREE]*',trim(offensetype) + ' '+ trim(offensedegree)) =>'CO2',																	
																	regexfind('^SPECIAL (FEL|FELONY)',offensedegree) => 'SF',
                                  regexfind('(M)(IS[DEMEANOR.]*)[ ][- ]*([A-Z])',offensedegree) => regexreplace('(M)(IS[DEMEANOR.]*)[ ][- ]*([A-Z])',offensedegree,'$1$3'),       
																	regexfind('^M[I]*NOR (MISD[.]*|MSD|MISDE|MISD[.]*)',offensedegree) => 'MM', 
																	regexfind('^M[I]*NOR (MISD[.]*|MSD|MISDE|MISD[.]*)|(MISD[.]*|MSD|MISDE|MISD[.]*) M[I]*NOR',offensetype) => 'MM',																	
																	regexfind('^F$|^FEL|^FELONY',offensedegree) => 'F',  
																	regexfind('^M$|^MISD[.]*|^MSD|^MISDE|^MISD[.]*',offensedegree) => 'M', 																	
																	regexfind('^FEL|FELONY',offenseclass) => 'F',  
													        regexfind('^MISD[.]*|MSD|MISDE|MISD[.]*',offenseclass) => 'M',  																	  
																	regexfind('^INFRACTION',offensetype) => 'I',
																	regexfind('^COUNTY',offensetype) => 'COR',
																	trim(offensetype) ='TRAFFIC INFRACTION' => 'TI', 
																	regexfind('MISD[.]*|MISDE',offenseclass) and 	regexfind('TRAFFIC',offenseclass)	=> 'MT' ,
																	regexfind('MISD[.]*|MISDE',offensetype) and 	regexfind('TRAFFIC',offensetype)	=> 'MT' ,
																	regexfind('MISD[.]*|MISDE',offensedegree) and 	regexfind('TRAFFIC',offensedegree)	=> 'MT' ,
																	offensetype IN ['TRAFFIC MISDEMEANOR'] => 'MT', 
																	regexfind('TRAFFIC$',trim(offensetype)) => 'T',
																  trim(offensetype) IN ['MUNICIPAL','MUNICIPAL(LOCAL)','MUNICIPAL ORDINANCE','MUNICIPAL (CITY) ORDINANCE'] => 'MOR',                                                                                 
                                  regexfind('^FEL|FELONY',offensetype) => 'F'+offenseclass,  
													        regexfind('^MISD[.]*|MSD|MISDE|MISD[.]*',offensetype) => 'M'+offenseclass,
																	length(trim(offensetype)) = 2 and regexfind('[0-9A-Z0-9]+',offensetype) => trim(offensetype),
																	length(trim(offensedegree)) <= 2 and regexfind('[0-9A-Z0-9]+',offensedegree) => trim(offensedegree),
																	length(trim(offensetype)) =1 =>  offensetype[1..1]+offenseclass[1..1],
																	length(trim(offenseclass)) <= 2 => trim(offenseclass),
																	''
															   ),left,right);
																 
	court_off_lev			    := MAP(stringlib.stringfind(temp_offense,'FELONY)',1) >0  and stringlib.stringfind(temp_offense,'(FIRST',1) >0 => 'F1',
	                             stringlib.stringfind(temp_offense,'FELONY)',1) >0  and stringlib.stringfind(temp_offense,'(SECOND',1) >0 => 'F2',
															 stringlib.stringfind(temp_offense,'FELONY)',1) >0  and stringlib.stringfind(temp_offense,'(THIRD',1) >0 => 'F3',
															 stringlib.stringfind(temp_offense,'FELONY)',1) >0  and stringlib.stringfind(temp_offense,'(FOURTH',1) >0 => 'F4',
															 stringlib.stringfind(temp_offense,'FELONY)',1) >0  and stringlib.stringfind(temp_offense,'(MISC',1) >0 => 'F',
															 stringlib.stringfind(temp_offense,'MISDEMEANOR)',1) >0  and stringlib.stringfind(temp_offense,'(FIRST',1) >0 => 'M1',
	                             stringlib.stringfind(temp_offense,'MISDEMEANOR)',1) >0  and stringlib.stringfind(temp_offense,'(SECOND',1) >0 => 'M2',
															 stringlib.stringfind(temp_offense,'MISDEMEANOR)',1) >0  and stringlib.stringfind(temp_offense,'(THIRD',1) >0 => 'M3',
															 stringlib.stringfind(temp_offense,'MISDEMEANOR)',1) >0  and stringlib.stringfind(temp_offense,'(FOURTH',1) >0 => 'M4',
															 stringlib.stringfind(temp_offense,'MISDEMEANOR)',1) >0  and stringlib.stringfind(temp_offense,'(MISC',1) >0 => 'M',
                               ls_vendor ='W0221' and stringlib.stringfind(temp_offense,'TRAFFIC',1) >0 => 'T',
															 stringlib.stringfind(temp_offense,' TRAFFIC:',1) >0 => 'T',
															 stringlib.stringfind(temp_offense,'TRAFFIC VIOLATIONS',1) >0 => 'T',															 
															 stringlib.stringfind(temp_offense,' MISD:',1) >0 => 'M',
															 stringlib.stringfind(temp_offense,' FEL:',1) >0  => 'F',
															 stringlib.stringfind(temp_offense,' MISD;',1) >0 => 'M',
															 stringlib.stringfind(temp_offense,' FEL;',1) >0  => 'F',
	                             stringlib.stringfilterout(off_lev,',.`{(')
															 );
    

  court_statute			    := MAP(ls_vendor IN ['W0048','W0051','W0242'] and l.offensecode <> '' => l.offensecode,
	                             ls_vendor IN ['W0054'] and temp_offense <> '' => temp_offense,
                               ls_vendor IN ['W0117'] and regexfind('^([0-9]+[0-9A-Z\\.\\(\\) ]+)(.*)(PC|VC|HS) ([A-Z]+[ ]*)(.*)$',temp_offense) =>regexreplace('^([0-9]+[0-9A-Z\\.\\(\\) ]+)(.*)(PC|VC|HS) ([A-Z]+[ ]*)(.*)$',temp_offense,'$1$2$3'),                             
	                             ls_vendor IN ['W0046','W0088'] and regexfind('([0-9.]+)(.*)(PC|VC|HS) ([A-Z]+[ ]*)(.*)$',temp_offense) =>regexreplace('([0-9.]+)(.*)(PC|VC|HS) ([A-Z]+[ ]*)(.*)$',temp_offense,'$1$2$3'),                             
															 
                               ls_vendor IN ['W0122','W0123'] and regexfind('([0-9\\.-]+)([\\(][A-Z0-9][\\)])[/]([A-Z]+[ ]*)(.*)$',temp_offense)=>regexreplace('([0-9\\.-]+)([\\(][A-Z0-9][\\)])[/]([A-Z]+[ ]*)(.*)$',temp_offense,'$1$2$3'),   
															 ls_vendor IN ['W0051','W0122','W0123'] and regexfind('([0-9\\.-]+)([\\(][A-Z0-9][\\)])[ ]*([\\(][A-Z0-9][\\)])([A-Z]+[ ]*)(.*)$',temp_offense)=>regexreplace('([0-9\\.-]+)([\\(][A-Z0-9][\\)])[ ]*([\\(][A-Z0-9][\\)])([A-Z]+[ ]*)(.*)$',temp_offense,'$1$2$3'),   
															 
															 ls_vendor IN ['W0048','W0051','W0121','W0122','W0123'] and regexfind('^([0-9]+[0-9A-Z\\.-]+)[\\. -]([A-Z]+[ ]*)(.*)$',temp_offense)                        =>regexreplace('^([0-9]+[0-9A-Z\\.-]+)[\\. -]([A-Z]+[ ]*)(.*)$',temp_offense,'$1'),
       												 ls_vendor IN ['W0048','W0051','W0088','W0121'] and regexfind('^([0-9\\.-]+)([\\(][A-Z0-9]+[\\)])[- ]([A-Z]+[ ]*)(.*)$',temp_offense)      =>regexreplace('([0-9\\.-]+)([\\(][A-Z0-9]+[\\)])[- ]([A-Z]+[ ]*)(.*)$',temp_offense,'$1$2'),
												       ls_vendor IN ['W0048','W0051'] and regexfind('^([0-9\\.-]+)([\\(][A-Z0-9]+[\\)][0-9])[- ]([A-Z]+[ ]*)(.*)$',temp_offense) =>regexreplace('([0-9\\.-]+)([\\(][A-Z0-9]+[\\)][0-9])[- ]([A-Z]+[ ]*)(.*)$',temp_offense,'$1$2'),
												       ls_vendor IN ['W0048','W0051','W0088','W0121','W0122','W0123'] and regexfind('^([0-9]+[0-9A-Z\\.-]+)([\\(][A-Z0-9]+[\\)])+[ ]*([A-Z]+[ ]*)(.*)$',temp_offense)     =>regexreplace('([0-9]+[0-9A-Z\\.-]+)([\\(][A-Z0-9]+[\\)])+[ ]*([A-Z]+[ ]*)(.*)$',temp_offense,'$1$2'),

                               ls_vendor IN ['W0075','W0076'] and regexfind('([0-9\\.]+[A-Z0-9\\.]+)([\\(][A-Z0-9][\\)])[ ]*([\\(][A-Z0-9][\\)])([A-Z]+[ ]*)(.*)$',temp_offense)=>regexreplace('([0-9\\.]+[A-Z0-9\\.]+)([\\(][A-Z0-9][\\)])[ ]*([\\(][A-Z0-9][\\)])([A-Z]+[ ]*)(.*)$',temp_offense,'$1$2$3'),   
															 ls_vendor IN ['W0075','W0076'] and regexfind('^([0-9\\.]+[A-Z0-9\\.-]+)[\\. ]([A-Z]+[ ]*)(.*)$',temp_offense)                                    =>regexreplace('^([0-9\\.]+[A-Z0-9\\.-]+)[\\. ]([A-Z]+[ ]*)(.*)$',temp_offense,'$1'),
       												 ls_vendor IN ['W0075','W0076'] and regexfind('^([0-9\\.]+[A-Z0-9\\.]+)([\\(][A-Z0-9]+[\\)])[- ]([A-Z]+[ ]*)(.*)$',temp_offense)                  =>regexreplace('([0-9\\.]+[A-Z0-9\\.]+)([\\(][A-Z0-9]+[\\)])[- ]([A-Z]+[ ]*)(.*)$',temp_offense,'$1$2'),
												       ls_vendor IN ['W0075','W0076'] and regexfind('^([0-9\\.]+[A-Z0-9\\.]+)([\\(][A-Z0-9]+[\\)][0-9])[- ]([A-Z]+[ ]*)(.*)$',temp_offense)             =>regexreplace('([0-9\\.]+[A-Z0-9\\.]+)([\\(][A-Z0-9]+[\\)][0-9])[- ]([A-Z]+[ ]*)(.*)$',temp_offense,'$1$2'),
												       ls_vendor IN ['W0075','W0076'] and regexfind('^([0-9\\.]+[A-Z0-9\\. ]+)([\\(][A-Z0-9]+[\\)])+[ ]*([A-Z]+[ ]*)(.*)$',temp_offense)                 =>regexreplace('([0-9\\.]+[A-Z0-9\\. ]+)([\\(][A-Z0-9]+[\\)])+[ ]*([A-Z]+[ ]*)(.*)$',temp_offense,'$1$2'),
                               
															 ls_vendor IN ['W0051'] and stringlib.stringfind(temp_offense,'..',1) >0 => temp_offense[1..stringlib.stringfind(temp_offense,' ',1)-1], 
                               ls_vendor IN ['W0050','W0071'] and stringlib.stringfind(temp_offense,' ',1) >0 => temp_offense[1..stringlib.stringfind(temp_offense,' ',1)-1], 
                               ls_vendor IN ['W0076'] and stringlib.stringfind(temp_offense,'321J.2 ',1) >0 => '321J.2', 
                                                              
															 ls_vendor ='W0055' and regexfind('([0-9]+)([0-9A-Z\\.\\(\\)\\-]+[\\)])([A-Z]+[ ]*)(.*)$',temp_offense) =>regexreplace('([0-9]+)([0-9A-Z\\.\\(\\)\\-]+[\\)])([A-Z]+[ ]*)(.*)$',temp_offense,'$1$2'),
 												       ls_vendor ='W0055' and regexfind('([0-9]+)([0-9A-Z\\.\\(\\)\\-]+[ ])([A-Z]+[ ]*)(.*)$',temp_offense) =>regexreplace('([0-9]+)([0-9A-Z\\.\\(\\)\\-]+[ ])([A-Z]+[ ]*)(.*)$',temp_offense,'$1$2'),
                               ls_vendor IN ['W0064','W0068'] and stringlib.stringfind(temp_offense,'/',1) >0 => temp_offense[1..stringlib.stringfind(temp_offense,'/',1)-1], 
                               ls_vendor ='W0065' and stringlib.stringfind(temp_offense,'(',1) >0 => temp_offense[1..stringlib.stringfind(temp_offense,'(',1)-1], 
        											 
															 ls_vendor IN ['W0091'] and  regexfind('(PC|VC|HS|BP)( [0-9\\./]+[A-Z0-9\\.]+)([\\(][A-Z0-9][\\)])([\\(][A-Z0-9][\\)])([A-Z]+[/: ]*)(.*)$' ,temp_offense)=>regexreplace('(PC|VC|HS|BP)( [0-9\\./]+[A-Z0-9\\.]+)([\\(][A-Z0-9][\\)])([\\(][A-Z0-9][\\)])([A-Z]+[/: ]*)(.*)$',temp_offense,'$1$2$3$4'),   
															 ls_vendor IN ['W0091'] and  regexfind('(PC|VC|HS|BP)( [0-9\\./]+[A-Z0-9\\.]+)( [\\(][A-Z0-9][\\)])([\\(][A-Z0-9][\\)])([A-Z]+[/: ]*)(.*)$',temp_offense)=>regexreplace('(PC|VC|HS|BP)( [0-9\\./]+[A-Z0-9\\.]+)( [\\(][A-Z0-9][\\)])([\\(][A-Z0-9][\\)])([A-Z]+[/: ]*)(.*)$',temp_offense,'$1$2$3$4'),
										           ls_vendor IN ['W0091'] and  regexfind('^([0-9\\./]+[A-Z0-9\\./]+)([ ]*[\\(][A-Z0-9][\\)])[ ]*([\\(][A-Z0-9][\\)])([A-Z]+[/: ]*)(.*)$'     ,temp_offense)=>regexreplace('^([0-9\\./]+[A-Z0-9\\./]+)([ ]*[\\(][A-Z0-9][\\)])[ ]*([\\(][A-Z0-9][\\)])([A-Z]+[/: ]*)(.*)$',temp_offense,'$1$2$3'),   
															 ls_vendor IN ['W0091'] and  regexfind('(PC|VC|HS|BP)( [0-9\\./]+[A-Z0-9\\. ]+)([\\(][A-Z0-9]+[\\)])+[ ]*([A-Z]+[/: ]*)(.*)$'              ,temp_offense)=>regexreplace('(PC|VC|HS|BP)( [0-9\\./]+[A-Z0-9\\. ]+)([\\(][A-Z0-9]+[\\)])+[ ]*([A-Z]+[/: ]*)(.*)$',temp_offense,'$1$2$3'),
															 ls_vendor IN ['W0091'] and  regexfind('(PC|VC|HS|BP)( [0-9\\./ ]+) ([A-Z]+[: ]*)(.*)$'                                                    ,temp_offense)=>regexreplace('(PC|VC|HS|BP)( [0-9\\./ ]+) ([A-Z]+[/: ]*)(.*)$',temp_offense,'$1$2'),

                               ls_vendor IN ['W0103','W0104','W0107','W0108','W0115','W0116'] => trim(l.offensecode),
															 
															 ls_vendor IN ['W0310'] and stringlib.stringfind(temp_offense,'-',2) >0 => temp_offense[1..stringlib.stringfind(temp_offense,'-',2)-1], 
                               ls_vendor IN ['W0310'] and regexfind('^([0-9\\.]+[0-9]+)[-]([A-Z0-9]+)[ ]*(.*)$',temp_offense) => regexreplace('^([0-9\\.]+[0-9]+)[-]([A-Z0-9]+)[ ]*(.*)$',temp_offense,'$1$2'), 
                               ls_vendor IN ['W0310'] and stringlib.stringfind(temp_offense,' ',1) >0  
															                        and stringlib.stringfind(temp_offense,'-',2) =0 => temp_offense[1..stringlib.stringfind(temp_offense,'-',1)-1],                                
															 
															 regexfind('[a-zA-Z]+[0-9.]+[(a-zA-Z)]*[(0-9)]*:',temp_offense) => StringLib.StringFilterOut(trim(regexreplace('([a-zA-Z]+0-9.]+[/(a-zA-Z/)]*[(0-9)]*:)(.*)',temp_offense,'$1'),left,right),'()'),
	  													 regexfind('[0-9.]+[a-zA-Z]+[(a-zA-Z)]*[(0-9)]*:',temp_offense) => StringLib.StringFilterOut(trim(regexreplace('([0-9.]+[a-zA-Z]+[/(a-zA-Z/)]*[(0-9)]*:)(.*)',temp_offense,'$1'),left,right),'()'),
															 
															 regexfind('[a-zA-Z0-9.]+[.][(a-zA-Z)]*[(0-9)]*', l.offensecode) => trim(l.offensecode),
                               '');
															 

	court_statute_desc		:= MAP(ls_vendor IN ['W0046','W0088'] and regexfind('([0-9.]+)(.*)(PC|VC|HS) ([A-Z]+[ ]*)(.*)$',temp_offense) =>  regexreplace('([0-9.]+)(.*)(PC|VC|HS) ([A-Z]+[ ]*)(.*)$',temp_offense,'$4$5'),                               
															 ls_vendor IN ['W0054']  => '',             // offense desc not available                   
                               ls_vendor IN ['W0122','W0123'] and regexfind('([0-9\\.-]+)([\\(][A-Z0-9][\\)])[/]([A-Z]+[ ]*)(.*)$',temp_offense)=>regexreplace('([0-9\\.-]+)([\\(][A-Z0-9][\\)])[/]([A-Z]+[ ]*)(.*)$',temp_offense,'$1$2$3'),   
															 ls_vendor IN ['W0051','W0122','W0123']         and regexfind('([0-9\\.-]+)([\\(][A-Z0-9][\\)])[ ]*([\\(][A-Z0-9][\\)])([A-Z]+[ ]*)(.*)$',temp_offense)=>regexreplace('([0-9\\.-]+)([\\(][A-Z0-9][\\)])[ ]*([\\(][A-Z0-9][\\)])([A-Z]+[ ]*)(.*)$',temp_offense,'$4$5'),   
                               ls_vendor IN ['W0117'] and regexfind('^([0-9]+[0-9A-Z\\.\\(\\) ]+)(.*)(PC|VC|HS) ([A-Z]+[ ]*)(.*)$',temp_offense) =>regexreplace('^([0-9]+[0-9A-Z\\.\\(\\) ]+)(.*)(PC|VC|HS) ([A-Z]+[ ]*)(.*)$',temp_offense,'$4$5'),                             
															 ls_vendor IN ['W0048','W0051','W0088','W0121','W0122','W0123'] and regexfind('^([0-9]+[0-9A-Z\\.-]+)[\\. -]([A-Z]+[ ]*)(.*)$',temp_offense)                        =>regexreplace('^([0-9]+[0-9A-Z\\.-]+)[\\. -]([A-Z]+[ ]*)(.*)$',temp_offense,'$2$3'),
  											  		 ls_vendor IN ['W0048','W0051','W0088','W0121'] and regexfind('^([0-9\\.-]+)([\\(][A-Z0-9]+[\\)])[- ]([A-Z]+[ ]*)(.*)$',temp_offense)      =>regexreplace('([0-9\\.-]+)([\\(][A-Z0-9]+[\\)])[- ]([A-Z]+[ ]*)(.*)$',temp_offense,'$3$4'),
												       ls_vendor IN ['W0048','W0051'] and regexfind('^([0-9\\.-]+)([\\(][A-Z0-9]+[\\)][0-9])[- ]([A-Z]+[ ]*)(.*)$',temp_offense) =>regexreplace('([0-9\\.-]+)([\\(][A-Z0-9]+[\\)][0-9])[- ]([A-Z]+[ ]*)(.*)$',temp_offense,'$3$4'),
          							       ls_vendor IN ['W0048','W0051','W0088','W0121','W0122','W0123'] and regexfind('^([0-9]+[0-9A-Z\\.-]+)([\\(][A-Z0-9]+[\\)])+[ ]*([A-Z]+[ ]*)(.*)$',temp_offense)     =>regexreplace('([0-9]+[0-9A-Z\\.-]+)([\\(][A-Z0-9]+[\\)])+[ ]*([A-Z]+[ ]*)(.*)$',temp_offense,'$3$4'),
															                                                                      
                               ls_vendor IN ['W0075','W0076'] and regexfind('^([0-9\\.]+[A-Z0-9\\.]+)([\\(][A-Z0-9][\\)])[ ]*([\\(][A-Z0-9][\\)])([A-Z]+[ ]*)(.*)$',temp_offense)=>regexreplace('([0-9\\.]+[A-Z0-9\\.]+)([\\(][A-Z0-9][\\)])[ ]*([\\(][A-Z0-9][\\)])([A-Z]+[ ]*)(.*)$',temp_offense,'$4$5'),   
															 ls_vendor IN ['W0075','W0076'] and regexfind('^([0-9\\.]+[A-Z0-9\\.-]+)[\\. ]([A-Z]+[ ]*)(.*)$',temp_offense)                        =>regexreplace('^([0-9\\.]+[A-Z0-9\\.-]+)[\\. ]([A-Z]+[ ]*)(.*)$',temp_offense,'$2$3'),
  											  		 ls_vendor IN ['W0075','W0076'] and regexfind('^([0-9\\.]+[A-Z0-9\\.]+)([\\(][A-Z0-9]+[\\)])[- /]([A-Z]+[ ]*)(.*)$',temp_offense)      =>regexreplace('([0-9\\.]+[A-Z0-9\\.]+)([\\(][A-Z0-9]+[\\)])[- ]([A-Z]+[ ]*)(.*)$',temp_offense,'$3$4'),
												       ls_vendor IN ['W0075','W0076'] and regexfind('^([0-9\\.]+[A-Z0-9\\.]+)([\\(][A-Z0-9]+[\\)][0-9])[- ]([A-Z]+[ ]*)(.*)$',temp_offense) =>regexreplace('([0-9\\.]+[A-Z0-9\\.]+)([\\(][A-Z0-9]+[\\)][0-9])[- ]([A-Z]+[ ]*)(.*)$',temp_offense,'$3$4'),
          							       ls_vendor IN ['W0075','W0076'] and regexfind('^([0-9\\.]+[A-Z0-9\\. ]+)([\\(][A-Z0-9]+[\\)])+[ ]*([A-Z]+[ ]*)(.*)$',temp_offense)     =>regexreplace('([0-9\\.]+[A-Z0-9\\. ]+)([\\(][A-Z0-9]+[\\)])+[ ]*([A-Z]+[ ]*)(.*)$',temp_offense,'$3$4'),
                               ls_vendor IN ['W0051'] and stringlib.stringfind(temp_offense,'..',1) >0 => temp_offense[stringlib.stringfind(temp_offense,' ',1)+2 ..],
	                             ls_vendor IN ['W0076'] and stringlib.stringfind(temp_offense,'321J.2 ',1) >0 => temp_offense[stringlib.stringfind(temp_offense,'321J.2 ',1)+1 ..],
                                															 
															 ls_vendor IN ['W0050','W0071'] and stringlib.stringfind(temp_offense,' ',1) >0 => temp_offense[stringlib.stringfind(temp_offense,' ',1)+1 ..],
	                             ls_vendor ='W0055' and regexfind('([0-9]+)([0-9A-Z\\.\\(\\)\\-]+[\\)])([A-Z]+[ ]*)(.*)$',temp_offense) =>regexreplace('([0-9]+)([0-9A-Z\\.\\(\\)\\-]+[\\)])([A-Z]+[ ]*)(.*)$',temp_offense,'$3$4'),
	                             ls_vendor ='W0055' and regexfind('([0-9]+)([0-9A-Z\\.\\(\\)\\-]+[ ])([A-Z]+[ ]*)(.*)$',temp_offense) =>regexreplace('([0-9]+)([0-9A-Z\\.\\(\\)\\-]+[ ])([A-Z]+[ ]*)(.*)$',temp_offense,'$3$4'),	
                               ls_vendor IN ['W0064','W0068'] and stringlib.stringfind(temp_offense,'/',1) >0 => trim(temp_offense[stringlib.stringfind(temp_offense,'/',1)+1..],left,right), 
                               ls_vendor ='W0065' and stringlib.stringfind(temp_offense,'(',1) >0 => temp_offense[stringlib.stringfind(temp_offense,'(',1)..], 
                               
															 ls_vendor IN ['W0091'] and  regexfind('(PC|VC|HS|BP)( [0-9\\./]+[A-Z0-9\\.]+)([\\(][A-Z0-9][\\)])([\\(][A-Z0-9][\\)])([A-Z]+[/: ]*)(.*)$' ,temp_offense)=>regexreplace('(PC|VC|HS|BP)( [0-9\\./]+[A-Z0-9\\.]+)([\\(][A-Z0-9][\\)])([\\(][A-Z0-9][\\)])([A-Z]+[/: ]*)(.*)$',temp_offense,'$5$6'),   
                               ls_vendor IN ['W0091'] and  regexfind('(PC|VC|HS|BP)( [0-9\\./]+[A-Z0-9\\.]+)( [\\(][A-Z0-9][\\)])([\\(][A-Z0-9][\\)])([A-Z]+[/: ]*)(.*)$',temp_offense)=>regexreplace('(PC|VC|HS|BP)( [0-9\\./]+[A-Z0-9\\.]+)( [\\(][A-Z0-9][\\)])([\\(][A-Z0-9][\\)])([A-Z]+[/: ]*)(.*)$',temp_offense,'$5$6'),   
  													   ls_vendor IN ['W0091'] and  regexfind('^([0-9\\.]+[A-Z0-9\\./]+)([ ]*[\\(][A-Z0-9][\\)])[ ]*([\\(][A-Z0-9][\\)])([A-Z]+[/: ]*)(.*)$'      ,temp_offense)=>regexreplace('^([0-9\\.]+[A-Z0-9\\./]+)([ ]*[\\(][A-Z0-9][\\)])[ ]*([\\(][A-Z0-9][\\)])([A-Z]+[/: ]*)(.*)$',temp_offense,'$4$5'),   
                               ls_vendor IN ['W0091'] and  regexfind('(PC|VC|HS|BP)( [0-9\\./]+[A-Z0-9\\. ]+)([\\(][A-Z0-9]+[\\)])+[ ]*([A-Z]+[/: ]*)(.*)$'              ,temp_offense)=>regexreplace('(PC|VC|HS|BP)( [0-9\\./]+[A-Z0-9\\. ]+)([\\(][A-Z0-9]+[\\)])+[ ]*([A-Z]+[/: ]*)(.*)$',temp_offense,'$4$5'),
                               ls_vendor IN ['W0091'] and  regexfind('(PC|VC|HS|BP)( [0-9\\./ ]+) ([A-Z]+[/: ]*)(.*)$'                                                   ,temp_offense)=>regexreplace('(PC|VC|HS|BP)( [0-9\\./ ]+) ([A-Z]+[/: ]*)(.*)$',temp_offense,'$3$4'),

															 ls_vendor IN ['W0310'] and stringlib.stringfind(temp_offense,'-',2) >0 => temp_offense[stringlib.stringfind(temp_offense,'-',2)+1..], 
                               ls_vendor IN ['W0310'] and regexfind('^([0-9\\.]+[0-9]+)[-]([A-Z0-9]+)[ ]*(.*)$',temp_offense) => regexreplace('^([0-9\\.]+[0-9]+)[-]([A-Z0-9]+)[ ]*(.*)$',temp_offense,'$3'), 
                               ls_vendor IN ['W0310'] and stringlib.stringfind(temp_offense,'-',2) =0 
															                        and stringlib.stringfind(temp_offense,'-',1) >0 => temp_offense[stringlib.stringfind(temp_offense,'-',1)+1..],                                
					         
				                       regexfind('[a-zA-Z]+[0-9.]+[(a-zA-Z)]*[(0-9)]*:',temp_offense)=>  trim(regexreplace('([a-zA-Z]+[0-9.]+[/(a-zA-Z/)]*[(0-9)]*:)(.*)',temp_offense,'$2'),left,right),
                               regexfind('[0-9.]+[a-zA-Z]+[(a-zA-Z)]*[(0-9)]*:',temp_offense)=>  trim(regexreplace('([0-9.]+[a-zA-Z]+[/(a-zA-Z/)]*[(0-9)]*:)(.*)',temp_offense,'$2'),left,right),
                               regexfind('[a-zA-Z0-9.]+[.][(a-zA-Z)]*[(0-9)]*', l.offensecode) => temp_offense,
															 '');																 
  court_off_code			  := MAP(regexfind('[a-zA-Z0-9.]+[(a-zA-Z)]*[(0-9)]*:',temp_offense) =>'',
	                             regexfind('[a-zA-Z0-9.]+[.][(a-zA-Z)]*[(0-9)]*', l.offensecode) =>  '',
															 court_statute <> '' => '',
															 trim(l.offensecode));		
																		 
  court_off_desc_1		  := MAP(//regexfind('[a-zA-Z0-9.]+[(a-zA-Z)]*[(0-9)]*:',temp_offense) =>'',
                               //regexfind('[a-zA-Z0-9.]+[.][(a-zA-Z)]*[(0-9)]*', l.offensecode)=>'',
															 court_statute_desc <> '' => '',															 
											         length(trim(temp_offense, left, right))<3 => '',
											         temp_offense);  
	
	string temp_disp_date       := MAP(trim(l.dispositiondate)[1..2] between '19' and '20' 
											                   and length(trim(l.dispositiondate))>=4 
											                   and l.dispositiondate <= stringlib.GetDateYYYYMMDD() => trim(l.dispositiondate),
											                   trim(l.finalrulingdate)[1..2] between '19' and '20' 	and 
																				 length(trim(l.finalrulingdate))>=4 and 
																				 l.finalrulingdate <= stringlib.GetDateYYYYMMDD() => trim(l.finalrulingdate),
											                  '');  
											
  court_disp_date		:=  temp_disp_date;
   
  string temp_disp        := map(regexfind('[A-Za-z]+', trim(l.disposition), 0)<>''=> trim(l.disposition),
											           regexfind('[A-Za-z]+', trim(l.finalruling), 0)<>''=>trim(l.finalruling),
											           ''); 

  court_disp_code		:= if(length(temp_disp)<= 3,
											          temp_disp,
											          '');
	 
  court_disp_desc_1	:= MAP( trim(temp_disp) ='G'=>'GUILTY',
												          				length(trim(temp_disp)) > 3 => temp_disp,
													                '');
	court_disp_desc_2	:= MAP(l.casestatus <> '' and stringlib.stringfind(l.casestatus,':',1) > 0 => trim(trim(l.casestatus) + ' '+ l.casestatusdate), 
	                               l.casestatus <> '' and stringlib.stringfind(l.casestatus,':',1) = 0 => trim('Status:'+ trim(l.casestatus) + ' '+ l.casestatusdate), 
	                               l.trialtype);

	
	//////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	//Arrest offense set fields
 // self.arr_off_code				    := if(arr_off_desc_1 <> '' ,'', court_off_code 08/23/2012
 
  self.arr_off_code     := map (court_off_desc_1 <> '' => court_off_code,
                                             court_statute_desc <> ''  => '' ,
                                                    //    arr_off_code  
																												'') ;  
 
 
 //self.arr_off_desc_1			    := if(arr_off_desc_1 <> '' ,arr_off_desc_1, court_off_desc_1);	08/23/2012
	
	self.arr_off_desc_1			    := map(ls_vendor IN ['W0054'] => '',
	                                   court_off_desc_1 <> '' => court_off_desc_1,
	                                   court_statute_desc <> '' => court_statute_desc,																			     
																		 arr_off_desc_1);
	
	
 // self.arr_off_desc_2			    := court_off_desc_1  ;
 //self.arr_off_desc_2			    :=  if(arr_off_desc_1 <> '' ,arr_off_desc_2 , court_off_desc_2);	08/23/2012
	
   self.arr_off_desc_2        := map(court_off_desc_1 <> ''  => court_off_desc_2,
                                     court_statute_desc <> ''  => '',
                                     arr_off_desc_2);

	
  self.arr_off_type_cd		    := '';
  self.arr_off_type_desc	    := '';
	
  //self.arr_off_lev				    := if(arr_off_desc_1 <> '' ,'', off_lev);  08/23/21012
	// self.arr_off_lev            := If (court_off_desc_1 <> ''  or  court_statute_desc <> ''  , court_off_lev,  off_lev);     
	   
	self.arr_off_lev            := court_off_lev;
  //self.arr_statute				    :=  if(arr_off_desc_1 <> '' ,'', court_statute);   08/23/2012	
	
	self.arr_statute            := MAP (
	                                  ls_vendor IN ['W0054'] => court_statute,
	                                  court_statute <> ''  => court_statute,
                                    court_off_desc_1 <> '' => '',
                                    // arr_statute   
																		'' );       

	
  //self.arr_statute_desc		    := if(arr_off_desc_1 <> '' ,'', court_statute_desc);    08/23/2012	

	self.arr_statute_desc		    := ''; 
	
	// Arrest disposition set fields 
  self.arr_disp_date			    :=  if(arr_off_desc_1 <> '' ,arr_disp_date, court_disp_date);
  self.arr_disp_code			    := if(arr_off_desc_1 <> '' ,'', court_disp_code);
  self.arr_disp_desc_1		    :=   if(arr_off_desc_1 <> '' ,arr_disp_desc_1 + ' ' + warrantnumber, court_disp_desc_1 + ' ' + warrantnumber);		
  self.arr_disp_desc_2		    := map(arr_off_desc_1 <> '' =>arr_disp_desc_2,
	                                             arr_off_desc_1 = ''  and arr_disp_desc_2 ='' => court_disp_desc_2,arr_disp_desc_2);	
 
  self.pros_refer_cd			    := '';
  self.pros_refer				      := '';
  self.pros_assgn_cd			    := '';
  self.pros_assgn				      := '';
  self.pros_chg_rej				    := '';
  self.pros_off_code			    := '';
  self.pros_off_desc_1		    := '';
  self.pros_off_desc_2		    := '';
  self.pros_off_type_cd		    := '';
  self.pros_off_type_desc	    := '';
  self.pros_off_lev				    := '';
  self.pros_act_filed			    := '';	
	
	
  self.court_case_number	    := ''; //casenumber; as per Judy we don't map case_number for arrest
  self.court_cd					      := '';
	
	   courtname := map(l.sourcename = 'UTAH_UTAH_COUNTY_ARRESTS' and length(trim(l.courtname)) > 4
	                                       => '',l.courtname);		
	
  self.court_desc				      := trim(stringlib.stringtouppercase(courtname));
  self.court_appeal_flag	    := '';
  self.court_final_plea		    := MAP(regexfind('[0-9]+/[0-9]+/',l.InitialPlea) => '',
	                                   trim(l.InitialPlea)
																		 );																		 
																		 
	//Court offense set fields
	//self.court_off_code		:=  if(arr_off_desc_1 = '' ,'', court_off_code);		08/23/2012	
	
	self.court_off_code := '';
	
  //self.court_off_desc_1		    := if(arr_off_desc_1 = '' ,'', court_off_desc_1);					08/23/2012				
	
	self.court_off_desc_1 := '';
	
  //self.court_off_desc_2		    := if(arr_off_desc_1 = '' ,'', court_off_desc_2);	
	
	self.court_off_desc_2	 := '';
	
  self.court_off_type_cd	    := '';
  self.court_off_type_desc	  := '';		
	
	//self.court_off_lev		:=  if(arr_off_desc_1 = '' ,'', court_off_lev);	08/23/2012
	
	self.court_off_lev		:= '';
	
  //self.court_statute		:=  if(arr_off_desc_1 = '' ,'', court_statute);				08/23/2012						
  
	self.court_statute		:= '';
	
	self.court_additional_statutes	:= '';  
 
 //self.court_statute_desc		  := if(arr_off_desc_1 = '' ,'', court_statute_desc);	 08/23/2012
 
  self.court_statute_desc		  :=  '';
																		 
	//Court disposition set fields										
  self.court_disp_date		:= if(arr_off_desc_1 = '' ,'', court_disp_date);   
  self.court_disp_code		:= if(arr_off_desc_1 = '' ,'', court_disp_code);											
	self.court_disp_desc_1	:= if(arr_off_desc_1 = '' ,'',court_disp_desc_1);
	self.court_disp_desc_2	:= if(arr_off_desc_1 = '' ,'', court_disp_desc_2);
	
  self.sent_date				  := MAP(l.SentenceDate <> '' => l.SentenceDate,	'');
											
	string Maxsent      := IF(l.sentencemaxyears <> '' and regexfind('[0-9]+', l.sentencemaxyears, 0)<>'', trim(l.sentencemaxyears) + ' Years ','') +					
											   IF(l.sentencemaxmonths <> '' and regexfind('[0-9]+', l.sentencemaxmonths, 0)<>'', trim(l.sentencemaxmonths) + ' Months ','') +
											   IF(l.sentencemaxdays <> '' and regexfind('[0-9]+', l.sentencemaxdays, 0)<>'', trim(l.sentencemaxdays) + ' Days ',
											      '');
	string Minsent      := IF(l.sentenceminyears <> '' and regexfind('[0-9]+', l.sentenceminyears, 0)<>'', trim(l.sentenceminyears) + ' Years ', '') +					
											   IF(l.sentenceminmonths <> '' and regexfind('[0-9]+', l.sentenceminmonths, 0)<>'', trim(l.sentenceminmonths) + ' Months ', '') +
											   IF(l.sentencemindays <> '' and regexfind('[0-9]+', l.sentencemindays, 0)<>'', trim(l.sentencemindays) + ' Days ',
											     '');		
	string temp_timeserve1 := IF(l.timeservedyears  <> ''	,trim(l.timeservedyears) + 'Years ','') +					
	                          IF(l.timeservedmonths <> ''	,trim(l.timeservedmonths) + 'Months ','') +
														IF(l.timeserveddays   <> ''	,trim(l.timeserveddays) + 'Days ','');
	                                 
  String Jail_time        := MAP(regexfind('(JAIL TIME: )([0-9A-Z ,]+);',l.sentenceadditionalinfo) => regexreplace('(JAIL TIME: )([0-9A-Z ,]+);(.*)',l.sentenceadditionalinfo,'$2'),
	                               regexfind('(SENTENCE JAIL DAYS: )([0-9]+)',l.sentenceadditionalinfo) => trim(regexreplace('(SENTENCE JAIL DAYS: )([0-9]+)',l.sentenceadditionalinfo,'$2'))+'D','');
  string temp_timeserved  := MAP(temp_timeserve1 <> '' => 'Time served: '+ temp_timeserve1,
	                               Jail_time <> '' =>       'Jail: '+ stringlib.stringfindreplace(stringlib.stringfindreplace(stringlib.stringfindreplace
																                          ( Jail_time, 'M','Months'),'D','Days'),'Y','Years'),
                                 '');		
																 
	string DAYS_IN_JAIL     := MAP(STD.str.find(l.casecomments,'DAYS_IN_JAIL:',1)>0 =>(string)l.casecomments[STD.str.find(l.casecomments,'DAYS_IN_JAIL:',1)+14..],
	                               '0');																 
  sent_jail_desc          := MAP(Maxsent <> '' and Minsent <> '' => 'Max: '+Maxsent+ ' Min: '+Minsent,
											           Maxsent <> '' => 'Max: '+Maxsent,
											           Minsent <> '' => 'Min: '+Minsent,
														     temp_timeserved <> '' =>temp_timeserved,
														     regexfind('L[I]*FE',l.sentencemaxyears) =>  l.sentencemaxyears,
														     regexfind('L[I]*FE',l.sentencemaxmonths) => l.sentencemaxmonths,
														     regexfind('L[I]*FE',l.sentencemaxdays) => l.sentencemaxdays,
														     DAYS_IN_JAIL <> '0' => 'Days in Jail:'+DAYS_IN_JAIL,
											           '');																	 
  self.sent_jail			    := sent_jail_desc;

  sentstat_susp_time      := MAP(regexfind('(SUSPENDED) (SENTENCE:|LENGTH:) [0-9]+ Y', l.sentencestatus) => trim(regexreplace('(SUSPENDED) (SENTENCE:|LENGTH:)(.*)', l.sentencestatus,'$3'),left,right)+'ears',
											           regexfind('(SUSPENDED) (SENTENCE:|LENGTH:) [0-9]+ M', l.sentencestatus) => trim(regexreplace('(SUSPENDED) (SENTENCE:|LENGTH:)(.*)', l.sentencestatus,'$3'),left,right)+'onths',
											           regexfind('SUSPENDED SENTENCE DAYS: [0-9]+'         , l.sentencestatus) => trim(regexreplace('(SUSPENDED SENTENCE DAYS:) (.*)'    , l.sentencestatus,'$2'),left,right)+'Days',
											           regexfind('(SUSPENDED) (SENTENCE:|LENGTH:) [0-9]+ D', l.sentencestatus) => trim(regexreplace('(SUSPENDED) (SENTENCE:|LENGTH:)(.*)', l.sentencestatus,'$3'),left,right)+'ays',
											           regexfind('(SUSP DAYS IN JAIL: )([0-9]+); (.*)', l.sentencestatus) => trim(regexreplace('(SUSP DAYS IN JAIL: )([0-9]+); (.*)', l.sentencestatus,'$2'+' Days'),left,right),                        
                                 regexfind('(SUSP DAYS IN JAIL: )(.*)', l.sentencestatus) => trim(regexreplace('(SUSP DAYS IN JAIL: )(.*)', l.sentencestatus,'$2'),left,right)+'Days',                        
                                 regexfind('(SUSP JAIL TIME:) ([0-9]+)', l.sentencestatus) => regexreplace('(SUSP JAIL TIME:) ([0-9]+)', l.sentencestatus,'$2'),
                                 
																 regexfind('(SUSPENDED:) [0-9]+ Y', l.sentencestatus) => trim(regexreplace('(SUSPENDED:) (.*)', l.sentencestatus,'$2'),left,right)+'ears',
											           regexfind('(SUSPENDED:) [0-9]+ M', l.sentencestatus) => trim(regexreplace('(SUSPENDED:) (.*)', l.sentencestatus,'$2'),left,right)+'onths',
											           regexfind('(SUSPENDED:) [0-9]+ D', l.sentencestatus) => trim(regexreplace('(SUSPENDED:) (.*)', l.sentencestatus,'$2'),left,right)+'ays',
											           
																 '');
																 
  sentaddl_susp_time      := MAP(regexfind('(SUSPENDED) (SENTENCE:|LENGTH:) ([0-9]+ Y), (.*)', l.sentenceadditionalinfo) => trim(regexreplace('(SUSPENDED) (SENTENCE:|LENGTH:) ([0-9]+ Y), (.*)', l.sentenceadditionalinfo,'$3'),left,right)+'ears',
											           regexfind('(SUSPENDED) (SENTENCE:|LENGTH:) ([0-9]+ M), (.*)', l.sentenceadditionalinfo) => trim(regexreplace('(SUSPENDED) (SENTENCE:|LENGTH:) ([0-9]+ M), (.*)', l.sentenceadditionalinfo,'$3'),left,right)+'onths',
											           regexfind('(SUSPENDED) (SENTENCE:|LENGTH:) ([0-9]+ D), (.*)', l.sentenceadditionalinfo) => trim(regexreplace('(SUSPENDED) (SENTENCE:|LENGTH:) ([0-9]+ D), (.*)', l.sentenceadditionalinfo,'$3'),left,right)+'ays',
											           
																 regexfind('(SUSPENDED) (SENTENCE:|LENGTH:) [0-9]+ Y', l.sentenceadditionalinfo) => trim(regexreplace('(SUSPENDED) (SENTENCE:|LENGTH:)(.*)', l.sentenceadditionalinfo,'$3'),left,right)+'ears',
											           regexfind('(SUSPENDED) (SENTENCE:|LENGTH:) [0-9]+ M', l.sentenceadditionalinfo) => trim(regexreplace('(SUSPENDED) (SENTENCE:|LENGTH:)(.*)', l.sentenceadditionalinfo,'$3'),left,right)+'onths',
											           regexfind('(SUSPENDED) (SENTENCE:|LENGTH:) [0-9]+ D', l.sentenceadditionalinfo) => trim(regexreplace('(SUSPENDED) (SENTENCE:|LENGTH:)(.*)', l.sentenceadditionalinfo,'$3'),left,right)+'ays',
											           	
	                               regexfind('(SUSPENDED JAIL TIME:) [0-9]+ Y', l.sentenceadditionalinfo) => trim(regexreplace('(SUSPENDED JAIL TIME:)(.*)', l.sentenceadditionalinfo,'$2'),left,right)+'ears',
											           regexfind('(SUSPENDED JAIL TIME:) [0-9]+ M', l.sentenceadditionalinfo) => trim(regexreplace('(SUSPENDED JAIL TIME:)(.*)', l.sentenceadditionalinfo,'$2'),left,right)+'onths',
											           regexfind('(SUSPENDED JAIL TIME:) [0-9]+ D', l.sentenceadditionalinfo) => trim(regexreplace('(SUSPENDED JAIL TIME:)(.*)', l.sentenceadditionalinfo,'$2'),left,right)+'ays',
											           regexfind('SUSPENDED SENTENCE MONTHS:',      l.sentenceadditionalinfo) => trim(regexreplace('(SUSPENDED SENTENCE MONTHS:)(.*)', l.sentenceadditionalinfo,'$2'),left,right)+' Months',                                                                                                                                                           
                                 regexfind('SENTENCE SUSPENDED DAYS: [0-9]+', l.sentenceadditionalinfo) => trim(regexreplace('(SENTENCE SUSPENDED DAYS:) (.*)',  l.sentenceadditionalinfo,'$2'),left,right)+'Days',
											           '');														
  self.sent_susp_time	:= MAP(sentstat_susp_time <> '' => trim(sentstat_susp_time,left,right),
	                           sentaddl_susp_time <> '' => trim(sentaddl_susp_time,left,right),
														 '' 
	                          );
											
  sent_court_cost             := MAP(regexfind('[0-9]+', trim(l.CourtFee), 0)='' => '',
											               trim(l.CourtFee) ='888888.0' => '',
											               trim(l.CourtFee));
											
  sent_court_fine             := MAP(regexfind('[0-9]+', trim(l.FineAmount), 0)='' => '',
    									               trim(l.FineAmount) IN ['888888.0','$0.00','0'] => '',
											               trim(l.FineAmount));
											
  sent_susp_court_fine	    	:= '';
	
	SELF.sent_court_cost_orig      := sent_court_cost;
  SELF.sent_court_fine_orig      := sent_court_fine;
  SELF.sent_susp_court_fine_orig := sent_susp_court_fine;
	
	sent_court_cost_temp       := stringlib.stringfilterout(sent_court_cost,'$,*');
	sent_court_fine_temp       := stringlib.stringfilterout(sent_court_fine,'$,*');
	sent_susp_court_fine_temp  := stringlib.stringfilterout(sent_susp_court_fine,'$,*');
	
  // self.sent_court_cost       := If(sent_court_cost_temp <> '',(string)((decimal10_2)sent_court_cost_temp *100),'');
	// self.sent_court_fine       := If(sent_court_fine_temp <> '',(string)((decimal10_2)sent_court_fine_temp *100),'');
	
	sent_court_cost_1          := If(sent_court_cost_temp <> '',(string)((decimal12_2)sent_court_cost_temp *100),'');
  self.sent_court_cost       := MAP((integer)sent_court_cost_1 =0 => '',
	                                  length(trim(sent_court_cost_1)) >8 => '',
	                                  sent_court_cost_1);
																	 
	sent_court_fine_1          := If(sent_court_fine_temp <> '',(string)((decimal12_2)trim(sent_court_fine_temp) *100),'');										
  self.sent_court_fine       := MAP((integer)sent_court_fine_1 =0 => '',
	                                  length(trim(sent_court_fine_1)) >9 => '',
	                                  sent_court_fine_1);		
	
	self.sent_susp_court_fine	 := If(sent_susp_court_fine_temp <> '',(string)((decimal12_2)sent_susp_court_fine_temp *100),'');
	
	string MaxProb      := IF(l.probationmaxyears <> ''  and regexfind('[0-9]+', l.probationmaxyears, 0)<>'', trim(l.probationmaxyears) + ' Years ', '') +					
											   IF(l.probationmaxmonths <> '' and regexfind('[0-9]+', l.probationmaxmonths, 0)<>'', trim(l.probationmaxmonths) + ' Months ', '') +
											   IF(l.probationmaxdays <> ''   and regexfind('[0-9]+', l.probationmaxdays, 0)<>'', trim(l.probationmaxdays) + ' Days ',
											      '');
												
	string MinProb      := IF(l.probationminyears  <> '' and regexfind('[0-9]+', l.probationminyears, 0)<>'', trim(l.probationminyears) + ' Years ', '') +					
											   IF(l.probationminmonths <> '' and regexfind('[0-9]+', l.probationminmonths, 0)<>'', trim(l.probationminmonths) + ' Months ', '') +
											   IF(l.probationmindays   <> '' and regexfind('[0-9]+', l.probationmindays, 0)<>'', trim(l.probationmindays) + ' Days ',
											      '');	
  
	vProbBeginDate				:= if(regexfind('/', l.ProbationBeginDate, 0)<>'',
																(string)LIB_Date.Date_MMDDYY_I2(regexreplace('/', l.ProbationBeginDate, '')),
																l.ProbationBeginDate);
	
	vProbEndDate				:= if(regexfind('/', l.ProbationEndDate, 0)<>'',
																(string)LIB_Date.Date_MMDDYY_I2(regexreplace('/', l.ProbationEndDate, '')),
																l.ProbationEndDate);
	
	ProbBeginDate		  	  := if(trim(vProbBeginDate)[1..2] between '19' and '20' 
								                        and length(trim(vProbBeginDate))>=4 ,trim(vProbBeginDate),	
																				'');
																				
	ProbEndDate			      := if(trim(vProbEndDate)[1..2] between '19' and '20' 
								                        and length(trim(vProbEndDate))>=4 ,trim(vProbEndDate),
																				'');
	
	prob_dates          := MAP(	ProbBeginDate <> '' and ProbEndDate <> '' => 'Dates:'+ ProbBeginDate+'-'+ProbEndDate,
															ProbBeginDate <> '' => 'Start:'+ ProbBeginDate,
															ProbEndDate   <> '' => 'End:'+ ProbEndDate,
															'');
  sent_probation_desc := 	trim(trim(
	                            IF(Minprob <> '' ,' Min:'+Minprob,''),left,right) +
															IF(Maxprob <> '' ,' Max:'+Maxprob,''),left,right) 
														  ;														
  self.sent_probation	:= sent_probation_desc;
	
  self.sent_addl_prov_code	:= '';

	
	sent_consec               := MAP(trim(l.sentenceadditionalinfo) = 'CONSECUTIVE' => 'CS',
											             trim(l.sentenceadditionalinfo) = 'CONCURRENT' => 'CC',
											             trim(l.sentencestatus) = 'CONSECUTIVE' => 'CS',
																	 trim(l.sentencestatus) = 'CONCURRENT' => 'CC',
																	 trim(l.sentencetype) = 'CONSECUTIVE' => 'CS',
																	 trim(l.sentencetype) = 'CONCURRENT' => 'CC',
																	 '');               


																	 
  addl_prov_desc_1          := MAP( regexfind('(SUSPENDED) (SENTENCE:|LENGTH:) ([0-9]+ [A-Z]), (.*)', l.sentenceadditionalinfo) => regexreplace('(SUSPENDED) (SENTENCE:|LENGTH:) ([0-9]+ [A-Z]), (.*)', l.sentenceadditionalinfo,'$4'),
											              trim(l.sentenceadditionalinfo) in ['CONSECUTIVE','CONSECUTIVE'] => '',
	  																regexfind('(SENTENCE SEQ #: )[0-9]$',l.sentenceadditionalinfo) => '',
																		regexfind('(SENTENCING JUDGE: )[A-Z, ]',l.sentenceadditionalinfo ) => '',   
																		regexfind('(COMMUNITY CONTROL LENGTH: [0-9, YMD][0-9, YMD]*); (SENTENCE LOCATION: )(.*)',l.sentenceadditionalinfo ) => regexreplace('(COMMUNITY CONTROL LENGTH: [0-9, YMD][0-9, YMD]*); (SENTENCE LOCATION: )(.*)',l.sentenceadditionalinfo,'$1' ),
                                    regexfind('^(SENTENCE LOCATION: )(.*)',l.sentenceadditionalinfo ) => '',
																		regexfind('^(LOCATION: )(.*)',l.sentenceadditionalinfo ) => '',
                                    regexfind('^(COMMUNITY CONTROL LENGTH: [0-9, YMD][0-9, YMD]*)$',l.sentenceadditionalinfo ) => regexreplace('^(COMMUNITY CONTROL LENGTH: [0-9, YMD][0-9, YMD]*)$',l.sentenceadditionalinfo,'$1' ),
                                    sentaddl_susp_time <> ''  => '',
											            	l.sentenceadditionalinfo);
																		
	addl_prov_desc_2					:= MAP(trim(l.sentencestatus) IN ['CONSECUTIVE','CONSECUTIVE'] =>'',
                                     regexfind('(SUSPENDED) (SENTENCE:|LENGTH:) ([0-9]+ [A-Z]), (.*)', l.sentencestatus) => regexreplace('(SUSPENDED) (SENTENCE:|LENGTH:) ([0-9]+ [A-Z]), (.*)', l.sentencestatus,'$4'),
                                   sentstat_susp_time <> '' => '',
																	 l.sentencestatus																	 
																	 );
	
  self.sent_addl_prov_desc_1:= addl_prov_desc_1;
  
	self.sent_addl_prov_desc_2:= addl_prov_desc_2;
	
  self.sent_consec				  := sent_consec;
  
	 
	
                                                                                                    
	self.sent_agency_rec_cust_ori	  := '';
  self.sent_agency_rec_cust	      := MAP(trim(l.sentencetype) in ['CONSECUTIVE','CONSECUTIVE'] => '',
	                                        l.sentencetype <> '' and trim(l.sentencetype) <> 'N/A'  =>  l.sentencetype, 
	                                       l.institutionname <> '' => l.institutionname,
 	                                       trim(l.CustodyLocation)
																	       );
	
  self.appeal_date				        := if(regexfind('[0-9]+', trim(l.appealdate)[1..4], 0)<>'' and trim(l.appealdate)[1] in ['1','2'],
											                  trim(l.appealdate),
											                  '');
																		
  self.appeal_off_disp			:= '';
  self.appeal_final_decision:= '';
  
  //Fields added for CROSS
  self.offense_town					:= l.offenselocation;
  self.convict_dt					  := l.finalrulingdate;
	
  self.cty_conv						  := MAP(					
	                              regexfind('(.*); (COURT LOC: )([a-zA-Z]+[\'a-zA-Z. ]*)',l.caseinfo) => trim(regexreplace('(.*); (COURT LOC: )([a-zA-Z]+[\'a-zA-Z. ]*)',l.caseinfo,'$3'),left,right),
					                      regexfind('(COURT LOC: )([a-zA-Z]+[\'a-zA-Z. ]*)',l.caseinfo) => trim(regexreplace('(COURT LOC: )([a-zA-Z]+[\'a-zA-Z. ]*)',l.caseinfo,'$2'),left,right),
					                      regexfind('SENTENCING COUNTY:',l.sentencestatus) =>  trim(regexreplace('(SENTENCING COUNTY:)(.*)',l.sentencestatus,'$2'),left,right),
															  regexfind('COUNTY [a-zA-Z ]*:',l.caseinfo) => trim(regexreplace('(COUNTY [a-zA-Z ]*: )(.*)',l.caseinfo,'$2'),left,right),
																regexfind('([a-zA-Z ]*COUNTY: )([a-zA-Z]+[\'a-zA-Z. ]*)(,.*)',l.sentenceadditionalinfo) => trim(regexreplace('([a-zA-Z ]*COUNTY: )([a-zA-Z]+[\'a-zA-Z. ]*)(,.*)',l.sentenceadditionalinfo,'$2'),left,right) ,
																regexfind('([a-zA-Z ]*COUNTY: )([a-zA-Z]+[\'a-zA-Z. ]*)(;.*)',l.sentenceadditionalinfo) => trim(regexreplace('([a-zA-Z ]*COUNTY: )([a-zA-Z]+[\'a-zA-Z. ]*)(;.*)',l.sentenceadditionalinfo,'$2'),left,right) ,
 															  regexfind('([a-zA-Z ]*COUNTY: )([a-zA-Z]+[\'a-zA-Z. ]*)$',l.sentenceadditionalinfo) => trim(regexreplace('([a-zA-Z ]*COUNTY: )([a-zA-Z]+[\'a-zA-Z. ]*)$',l.sentenceadditionalinfo,'$2'),left,right) ,
																regexfind('(.*) (SENTENCE COUNTY: )([a-zA-Z]+[a-zA-Z ]*)$',l.sentenceadditionalinfo)=> trim(regexreplace('(.*) (SENTENCE COUNTY: )([a-zA-Z]+[a-zA-Z ]*)$',l.sentenceadditionalinfo,'$3'),left,right),    
	                              regexfind('COUNTY [a-zA-Z ]*:',l.sentenceadditionalinfo) => trim(regexreplace('(COUNTY [a-zA-Z ]*:)(.*)',l.sentenceadditionalinfo,'$2'),left,right) ,
																regexfind('SENTENCING AGENCY:',l.sentenceadditionalinfo) => trim(regexreplace('(SENTENCING AGENCY:)(.*)',l.sentenceadditionalinfo,'$2'),left,right) ,
																regexfind('COUNTY OF CONVICTION:',l.casecomments) => trim(regexreplace('(COUNTY OF CONVICTION: )([a-zA-Z]+)',l.casecomments,'$2'),left,right),
																regexfind('PROSECUTION JURISDICTION: ',l.casecomments) => trim(regexreplace('COUNTY',regexreplace('(PROSECUTION JURISDICTION: )([a-zA-Z]+)',l.casecomments,'$2'),''),left,right),
																regexfind('JURISDICTION: ',l.casecomments) => trim(regexreplace('COUNTY',regexreplace('(JURISDICTION: )([a-zA-Z]+)',l.casecomments,'$2'),''),left,right),
																regexfind('(.*) (COMMITTING COUNTY: )([a-zA-Z]+[a-zA-Z ]*);(.*)',l.defendantadditionalinfo) => trim(regexreplace('(.*) (COMMITTING COUNTY: )([a-zA-Z]+[a-zA-Z ]*);(.*)',l.defendantadditionalinfo,'$3'),left,right),
																regexfind('(.*)[ ](COUNTY: )(.*)',l.offenselocation) => regexreplace('(.*)[ ](COUNTY: )(.*)',l.offenselocation,'$3'),
																regexfind('(COUNTY COMMITTED: )(.*)',l.offenselocation) => regexreplace('(COUNTY COMMITTED: )(.*)',l.offenselocation,'$2'),
																regexfind('(COUNTY CONVICTED: )(.*)',l.offenselocation) => regexreplace('(COUNTY CONVICTED: )(.*)',l.offenselocation,'$2'), 
																//l.statecode ='AR' => l.arrestingagency,
																//l.offenselocation <> '' => trim(l.offenselocation),
	                              '');
  self.restitution					:= MAP(regexfind('[0-9]+', trim(l.restitution), 0)='' => '',
	                                 l.restitution
																	 );
	
  community_serv            := IF(l.CommunitySupervisionYears  <> '' and regexfind('[0-9]+', l.CommunitySupervisionYears, 0)<>'', trim(l.CommunitySupervisionYears) + ' Years ','') +					
											         IF(l.CommunitySupervisionMonths <> '' and regexfind('[0-9]+', l.CommunitySupervisionMonths, 0)<>'', trim(l.CommunitySupervisionMonths) + ' Months ','') +
											         IF(l.CommunitySupervisionDays   <> '' and regexfind('[0-9]+', l.CommunitySupervisionDays, 0)<>'', trim(l.CommunitySupervisionDays) + ' Days ',
											          ''); 	
																
  public_serv_hrs           := IF(l.publicservicehours <> '' and regexfind('[0-9]+', l.publicservicehours, 0)<>'', 'Pub Serv: '+trim(l.publicservicehours) + ' Hours','') ;																				
	self.community_service		:= IF(community_serv <> '', community_serv, public_serv_hrs);
  
	string MaxParole          := IF(l.ParoleMaxYears  <> '' and regexfind('[0-9]+', l.ParoleMaxYears, 0)<>'', trim(l.ParoleMaxYears) + ' Years ', '') +					
											         IF(l.ParoleMaxMonths <> '' and regexfind('[0-9]+', l.ParoleMaxMonths, 0)<>'', trim(l.ParoleMaxMonths) + ' Months ', '') +
											         IF(l.ParoleMaxDays   <> '' and regexfind('[0-9]+', l.ParoleMaxDays, 0)<>'', trim(l.ParoleMaxDays) + ' Days ',
											         '');
												
	string MinParole          := IF(l.ParoleMinYears  <> '' and regexfind('[0-9]+', l.ParoleMinYears, 0)<>'', trim(l.ParoleMinYears) + ' Years ', '') +					
										           IF(l.ParoleMinMonths <> '' and regexfind('[0-9]+', l.ParoleMinMonths, 0)<>'', trim(l.ParoleMinMonths) + ' Months ', '') +
											         IF(l.ParoleMinDays   <> '' and regexfind('[0-9]+', l.ParoleMinDays, 0)<>'', trim(l.ParoleMinDays) + ' Days ',
											         '');
    
  self.parole					 := MAP(MaxParole <> '' and MinParole <> '' => 'Max: '+MaxParole + ' Min: '+MinParole,
															 MaxParole <> '' => 'Max: '+MaxParole,
															 MinParole <> '' => 'Min: '+MinParole,
												  ''); 
  self.addl_sent_dates := MAP(l.SentenceBeginDate <> '' and l.SentenceEndDate <> ''=>  'Start:'+trim(l.SentenceBeginDate)+ 'End:'+trim(l.SentenceEndDate),
											        l.SentenceBeginDate <> '' =>'Start:'+ trim(l.SentenceBeginDate),
											        l.SentenceEndDate <> '' =>'End:'+ trim(l.SentenceEndDate),
															'');
	self.Probation_desc2 := MAP(prob_dates <> '' and l.probationstatus <> '' =>  trim(prob_dates)+ '-' + l.probationstatus,
	                            prob_dates <> '' =>  trim(prob_dates),
															l.probationstatus);
self.court_dt          :=  MAP(trim(l.courtdate)[1..2] between '19' and '20' 
											                   and length(trim(l.courtdate))>=4 => trim(l.courtdate),'') ;	
self.court_county	   := '';		
self.Hyg_classification_code := l.classification_code;												
end;


result_common 	:= project(j_final, to_court_offenses(left))(trim(vendor, left, right)<>'');

/////////////////////////////////////////////////////////////////////////

dedup_sort_result_common := 
                          dedup(sort(distribute(result_common,hash(offender_key)),
													      offender_key,source_file, vendor,off_date, arr_date,	num_of_counts,	 le_agency_desc,	le_agency_case_number,	 traffic_ticket_number, 	traffic_dl_no,		
																traffic_dl_st, 
																StringLib.StringFilter(StringLib.StringToUpperCase(arr_off_code),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
                                StringLib.StringFilter(StringLib.StringToUpperCase(arr_off_desc_1+arr_off_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),																
																arr_off_lev, arr_statute,	arr_statute_desc, arr_disp_date, arr_disp_code,	arr_disp_desc_1,		  
																arr_disp_desc_2,	court_case_number, court_desc,court_appeal_flag,	court_final_plea,
																StringLib.StringFilter(StringLib.StringToUpperCase(court_off_code),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
																StringLib.StringFilter(StringLib.StringToUpperCase(court_off_desc_1+court_off_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
 															  court_off_lev,	court_statute, court_additional_statutes,	 court_statute_desc, court_disp_date,court_disp_code,	court_disp_desc_1,court_disp_desc_2,
																sent_date,  sent_jail,	sent_susp_time,  sent_court_cost, sent_court_fine,	 sent_probation, sent_addl_prov_code,	sent_addl_prov_desc_1,sent_addl_prov_desc_2,
																sent_consec,  sent_agency_rec_cust,  appeal_date,	offense_town,	convict_dt,	 cty_conv,	restitution,	community_service,parole,	 addl_sent_dates, 
																Probation_desc2,  court_dt,local),
																 offender_key, source_file,vendor,off_date, arr_date,	num_of_counts,	 le_agency_desc,	le_agency_case_number,	 traffic_ticket_number, 	traffic_dl_no,		
																traffic_dl_st,
																StringLib.StringFilter(StringLib.StringToUpperCase(arr_off_code),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
                                StringLib.StringFilter(StringLib.StringToUpperCase(arr_off_desc_1+arr_off_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),																
																arr_off_lev, arr_statute,	arr_statute_desc, arr_disp_date, arr_disp_code,	arr_disp_desc_1,		  
																arr_disp_desc_2,	court_case_number, court_desc,court_appeal_flag,	court_final_plea,
																StringLib.StringFilter(StringLib.StringToUpperCase(court_off_code),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
                                StringLib.StringFilter(StringLib.StringToUpperCase(court_off_desc_1+court_off_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
																court_off_lev,	court_statute, court_additional_statutes,	 court_statute_desc, court_disp_date,court_disp_code,	court_disp_desc_1,court_disp_desc_2,
																sent_date,  sent_jail,	sent_susp_time,  sent_court_cost, sent_court_fine,	 sent_probation, sent_addl_prov_code,	sent_addl_prov_desc_1,sent_addl_prov_desc_2,
																sent_consec,  sent_agency_rec_cust,  appeal_date,	offense_town,	convict_dt,	 cty_conv,	restitution,	community_service,parole,	 addl_sent_dates, 
																Probation_desc2,  court_dt,local)
													                  : persist ('~thor_data200::persist::hygenics::crim::HD::arrest::offenses');												
													   

export proc_build_arrest_offenses :=  dedup_sort_result_common;