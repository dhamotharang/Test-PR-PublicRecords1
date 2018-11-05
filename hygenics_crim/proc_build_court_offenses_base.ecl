import crim_common;

def := sort(distribute(hygenics_crim.file_in_defendant(), hash(recordid,sourceid)), recordid, local);
cha := sort(distribute(hygenics_crim.file_in_charge, hash(recordid,sourceid)), recordid, local);
off := sort(distribute(hygenics_crim.file_in_offense, hash(recordid,sourceid)), recordid, local);
sen := sort(distribute(hygenics_crim.file_in_sentence, hash(recordid,sourceid)), recordid, local);

layout_j_final := record

	string ln_vendor := '';

	//from def
	string115	Name;
	string40	RecordID;
	string100	SourceName;
	string20	SourceType;
	string2		StateCode;
	string8		DOB;
	string20	DOCNumber;
	string20	FBINumber;
	string20	StateIDNumber;
	string20	InmateNumber;
	string100	DefendantStatus;
	string200	DefendantAdditionalInfo;
	string20	DLNumber;
	string2		DLState;
	string100	InstitutionName;
	string200	InstitutionDetails;
	string8		InstitutionReceiptDate;
	string100	ReleaseToLocation;
	string200	ReleaseToDetails;
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
	string50	CourtName					  := '';
	string10	FineAmount					:= '';
	string10	CourtFee					  := '';
	string10	Restitution					:= '';
	string20	TrialType					  := '';
	string8	  Court_dt					  := '';
	string		County						  := '';
  string8   orig_fileddate			:= '';
	string8   classification_code := '';
	
	//from sentence
	string8		SentenceDate				    := '';
	string8		SentenceBeginDate		  	:= '';
	string8		SentenceEndDate			  	:= '';
	string20	SentenceType				    := '';
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
	//string10	PublicServiceHours			:= '';
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
	string10	ParoleMaxDays				  := '';
	string10	ParoleMinYears				:= '';
	string10	ParoleMinMonths				:= '';
	string10	ParoleMinDays				  := '';
	//string100	ParoleStatus				:= '';
	//string50	ParoleOfficer				:= '';
	//string20	ParoleOffcerPhone		:= '';
	string8		ProbationBeginDate		:= '';
	string8		ProbationEndDate			:= '';
	string10	ProbationMaxYears			:= '';
	string10	ProbationMaxMonths		:= '';
	string10	ProbationMaxDays			:= '';
	string10	ProbationMinYears			:= '';
	string10	ProbationMinMonths		:= '';
	string10	ProbationMinDays			:= '';
	string100	ProbationStatus				:= '';
	string100  sourceid             := '';
	//
end;

layout_j_final to_j1(def l, off r) := transform
 self.ln_vendor 		  := trim(hygenics_crim._functions.fn_sourcename_to_vendor(trim(l.sourcename), trim(l.statecode)));
 self.fileddate 		  := if(trim(r.fileddate)[1..2] between '19' and '20' 
								and length(trim(r.fileddate))>4 
								and trim(r.fileddate, left, right)[5..6] in ['01','02','03','04','05','06','07','08','09','10','11','12']
								and r.fileddate<=stringlib.GetDateYYYYMMDD(),
								trim(r.fileddate),
							  if(trim(r.fileddate)[1..2] between '19' and '20' 
								and length(trim(r.fileddate))=4 
								and r.fileddate<=stringlib.GetDateYYYYMMDD(),
								trim(r.fileddate),	
								''));
 self.orig_fileddate	  := r.fileddate;
 //self.casetitle			  := r.casetitle;
 self.casetype			  := r.casetype;
 self.casenumber		  := r.casenumber;
 self.casestatus		  := r.casestatus;
 self.offensetype		  := r.offensetype;
 self.offensecount	  := r.offensecount;
 self.offensecode		  := r.offensecode;
 self.offensedesc		  := r.offensedesc;
 self.dispositiondate := if(trim(r.dispositiondate)[1..2] between '19' and '20' 
								and length(trim(r.dispositiondate))>4 
								and trim(r.dispositiondate, left, right)[5..6] in ['01','02','03','04','05','06','07','08','09','10','11','12']
								and r.dispositiondate<=stringlib.GetDateYYYYMMDD(),
								trim(r.dispositiondate),
							 if(trim(r.dispositiondate)[1..2] between '19' and '20' 
								and length(trim(r.dispositiondate))=4 
								and r.dispositiondate<=stringlib.GetDateYYYYMMDD(),
								trim(r.dispositiondate),
								''));
 self.disposition		  := r.disposition;
 self.offenselocation	  := r.offenselocation;
 self.county			  := r.county;
 self.restitution		  := r.restitution;
 self.court_dt			  := r.courtdate;
 self 					  := l;
 self 					  := r;
end;

j1 := join(def,off, 
		 	left.recordid=right.recordid and 
		  left.sourceid=right.sourceid, 
		  to_j1(left,right), local);

layout_j_final to_j2(j1 l, cha r) := transform

  self.citationnumber 	 := r.citationnumber;
  self.arrestdate        := if(trim(r.arrestdate, left, right)[1..2] between '19' and '20' and length(trim(r.arrestdate, left, right))=8 and trim(r.arrestdate, left, right)[5..6] in ['01','02','03','04','05','06','07','08','09','10','11','12'] and r.arrestdate<=stringlib.GetDateYYYYMMDD(),
									trim(r.arrestdate, left, right),
								if(trim(r.arrestdate)[1..2] between '19' and '20' and length(trim(r.arrestdate, left, right))=4 and r.arrestdate[1..4]<=stringlib.GetDateYYYYMMDD()[1..4],
									trim(r.arrestdate, left, right),
								''));
  self.CustodyDate     	 := if(trim(r.custodydate, left, right)[1..2] between '19' and '20' and length(trim(r.custodydate, left, right))=8 and trim(r.custodydate, left, right)[5..6] in ['01','02','03','04','05','06','07','08','09','10','11','12'] and r.custodydate<=stringlib.GetDateYYYYMMDD(),
									trim(r.custodydate, left, right),
								if(trim(r.custodydate)[1..2] between '19' and '20' and length(trim(r.custodydate, left, right))=4 and r.custodydate[1..4]<=stringlib.GetDateYYYYMMDD()[1..4],
									trim(r.custodydate, left, right),
								''));
  Self.ArrestingAgency	 := r.ArrestingAgency;
  Self.CustodyLocation	 := r.CustodyLocation;
  Self.InitialCharge	 := r.InitialCharge;
  Self.InitialChargeDate := if(trim(r.initialchargedate, left, right)[1..2] between '19' and '20' and length(trim(r.initialchargedate, left, right))=8 and trim(r.initialchargedate, left, right)[5..6] in ['01','02','03','04','05','06','07','08','09','10','11','12'] and r.initialchargedate<=stringlib.GetDateYYYYMMDD(),
									trim(r.initialchargedate, left, right),
								if(trim(r.initialchargedate)[1..2] between '19' and '20' and length(trim(r.initialchargedate, left, right))=4 and r.initialchargedate[1..4]<=stringlib.GetDateYYYYMMDD()[1..4],
									trim(r.initialchargedate, left, right),
								''));	
  Self.InitialChargeCancelledDate	:= r.InitialChargeCancelledDate ;
  Self.ChargeDisposed	 := r.ChargeDisposed;
  Self.ChargeDisposedDate:= if(trim(r.chargedisposeddate, left, right)[1..2] between '19' and '20' and length(trim(r.chargedisposeddate, left, right))=8 and trim(r.chargedisposeddate, left, right)[5..6] in ['01','02','03','04','05','06','07','08','09','10','11','12'] and r.chargedisposeddate<=stringlib.GetDateYYYYMMDD(),
									trim(r.chargedisposeddate, left, right),
								if(trim(r.chargedisposeddate)[1..2] between '19' and '20' and length(trim(r.chargedisposeddate, left, right))=4 and r.chargedisposeddate[1..4]<=stringlib.GetDateYYYYMMDD()[1..4],
									trim(r.chargedisposeddate, left, right),
								''));
  Self.ChargeSeverity	 := r.ChargeSeverity;
  Self.ChargeDisposition := r.ChargeDisposition;
  Self.AmendedCharge	 := r.AmendedCharge;
  Self.AmendedChargeDate := if(trim(r.amendedchargedate, left, right)[1..2] between '19' and '20' and length(trim(r.amendedchargedate, left, right))=8 and trim(r.amendedchargedate, left, right)[5..6] in ['01','02','03','04','05','06','07','08','09','10','11','12'] and r.amendedchargedate<=stringlib.GetDateYYYYMMDD(),
									trim(r.amendedchargedate, left, right),
								if(trim(r.amendedchargedate)[1..2] between '19' and '20' and length(trim(r.amendedchargedate, left, right))=4 and r.amendedchargedate[1..4]<=stringlib.GetDateYYYYMMDD()[1..4],
									trim(r.amendedchargedate, left, right),
								''));
  self 					 := l;
  self 					 := r;
end;

j2 := join(j1, cha,
			left.sourceid=right.sourceid and left.recordid=right.recordid and left.caseid=right.caseid, 
			to_j2(left,right), left outer, local);
			
layout_j_final to_j3(j2 l, sen r) := transform
 	self.SentenceDate				:= r.sentencedate;
	self.SentenceBeginDate			:= r.SentenceBeginDate;
	self.SentenceEndDate			:= r.SentenceEndDate;
	self.SentenceType				:= r.SentenceType	;
	self.SentenceMaxYears		  	:= r.SentenceMaxYears;
	self.SentenceMaxMonths			:= r.SentenceMaxMonths;
	self.SentenceMaxdays		  	:= r.SentenceMaxdays;
	self.SentenceMinYears		  	:= r.SentenceMinYears;
	self.SentenceMinMonths			:= r.SentenceMinMonths;
	self.SentenceMinDays			:= r.SentenceMinDays;
	//self.ScheduledReleaseDate	:= '';
	//self.ActualReleaseDate			:= '';
	self.SentenceStatus				:= r.SentenceStatus;
	self.TimeServedYears			:= r.TimeServedYears;
	self.TimeServedMonths			:= r.TimeServedMonths;
	self.TimeServedDays				:= r.TimeServedDays;
	//self.PublicServiceHours		:= '';
	self.SentenceAdditionalInfo		:= r.SentenceAdditionalInfo;
	self.CommunitySupervisionCounty	:= r.CommunitySupervisionCounty;
	self.CommunitySupervisionYears	:= r.CommunitySupervisionYears;
	self.CommunitySupervisionMonths	:= r.CommunitySupervisionMonths;
	self.CommunitySupervisionDays	:= r.CommunitySupervisionDays;
	self.ProbationBeginDate		  	:= r.ProbationBeginDate;
	self.ProbationEndDate			:= r.ProbationEndDate	;
	self.ProbationMaxYears			:= r.ProbationMaxYears;
	self.ProbationMaxMonths		  	:= r.ProbationMaxMonths;
	self.ProbationMaxDays			:= r.ProbationMaxDays;
	self.ProbationMinYears			:= r.ProbationMinYears;
	self.ProbationMinMonths		  	:= r.ProbationMinMonths;
	self.ProbationMinDays			:= r.ProbationMinDays;
	self.ProbationStatus			:= r.ProbationStatus;
	self.ParoleMaxYears				:= r.ParoleMaxYears;
	self.ParoleMaxMonths			:= r.ParoleMaxMonths;
	self.ParoleMaxDays				:= r.ParoleMaxDays;
	self.ParoleMinYears				:= r.ParoleMinYears;
	self.ParoleMinMonths			:= r.ParoleMinMonths;
	self.ParoleMinDays				:= r.ParoleMinDays;
 self := l;
 //self := r;
 end;
j3 := join(j2,sen, left.sourceid=right.sourceid and left.recordid=right.recordid and left.caseid=right.caseid, 
										to_j3(left,right), left outer, local);

j_final := j3;

//output(j_final,, '~thor::base::hygenics::sample::court_offenses_new_20110113', overwrite);

Layout_Common_Court_Offenses_orig to_court_offenses(j_final l) := transform
	
  self.process_date				    := stringlib.getdateyyyymmdd();
	
	vVendor 						:= hygenics_crim._functions.fn_sourcename_to_vendor(trim(l.sourcename), trim(l.statecode));
	
	string temp_case_number       	:= MAP(l.casenumber <> ''   => l.casenumber, 
											l.DocketNumber <> '' => l.DocketNumber,
											'');
	  
	string temp_disp_orig     := map(trim(l.ln_vendor) ='I0002' and stringlib.stringfind(l.casecomments,'DISMISSED',1) >0 => 'DISMISSED',
	                                 regexfind('[A-Z]+', trim(l.disposition), 0)<>''=> trim(l.disposition),
	                                 trim(l.ln_vendor) ='RD' and trim(l.InitialPlea) =''=>'',
											             regexfind('[A-Z]+', trim(l.finalruling), 0)<>''=>trim(l.finalruling),
											            ''); 

  string temp_disp 					:= if(regexfind(',', temp_disp_orig[1], 0)<>'',
											            temp_disp_orig[2..],
											            temp_disp_orig); 
																	
  self.offender_key				    := hygenics_crim._functions.fn_persistent_offender_key(vVendor, l.name, l.dob, l.docnumber, l.inmatenumber, 
																					l.stateidnumber, l.fbinumber, l.casenumber, l.orig_fileddate, l.casetype);
										
										//hygenics_crim._functions.fn_offender_key(l.ln_vendor, l.recordid,temp_case_number,l.fileddate);
  self.vendor					    := trim(l.ln_vendor);
  self.state_origin				    := trim(l.statecode);
  self.source_file				    := trim(hygenics_crim._functions.fn_shorten_sourcename(l.sourcename));	
  self.off_comp					    := '';
  self.off_delete_flag		      	:= '';
	
  // Not sure if Initialchargedate or AmendedChargeDate can be mapped to offense date
  V_off_date				:= if(trim(l.offensedate, left, right)[1..2] between '19' and '20' and length(trim(l.offensedate, left, right))=8 and trim(l.offensedate, left, right)[5..6] in ['01','02','03','04','05','06','07','08','09','10','11','12'] and l.offensedate<=stringlib.GetDateYYYYMMDD(),
											    trim(l.offensedate, left, right),
										   if(trim(l.offensedate)[1..2] between '19' and '20' and length(trim(l.offensedate, left, right))=4 and l.offensedate[1..4]<=stringlib.GetDateYYYYMMDD()[1..4],
											    trim(l.offensedate, left, right),
										   ''));
  V_initchg_date				:= if(trim(l.initialchargedate, left, right)[1..2] between '19' and '20' and length(trim(l.initialchargedate, left, right))=8 and trim(l.initialchargedate, left, right)[5..6] in ['01','02','03','04','05','06','07','08','09','10','11','12'] and  l.initialchargedate<=stringlib.GetDateYYYYMMDD(),
											    trim(l.initialchargedate, left, right),
										   if(trim(l.initialchargedate)[1..2] between '19' and '20' and length(trim(l.initialchargedate, left, right))=4 and l.initialchargedate[1..4]<=stringlib.GetDateYYYYMMDD()[1..4],
											    trim(l.initialchargedate, left, right),
										   ''));											 
  self.off_date     := MAP(trim(l.ln_vendor) ='RD' and V_off_date='' => V_initchg_date, 
	                         V_off_date); 
  self.arr_date			:= if(trim(l.arrestdate, left, right)[1..2] between '19' and '20' and length(trim(l.arrestdate, left, right))=8 and trim(l.arrestdate, left, right)[5..6] in ['01','02','03','04','05','06','07','08','09','10','11','12'] and l.arrestdate<=stringlib.GetDateYYYYMMDD(),
											trim(l.arrestdate, left, right),
										if(trim(l.arrestdate)[1..2] between '19' and '20' and length(trim(l.arrestdate, left, right))=4 and l.arrestdate[1..4]<=stringlib.GetDateYYYYMMDD()[1..4],
											trim(l.arrestdate, left, right),
										''));
  self.num_of_counts			    := If((integer)(l.offensecount) > 99, 
											'',
										if(regexfind('[0-9]+', l.offensecount, 0)<>'',
											trim(l.offensecount),
											''));
  self.le_agency_cd				    := '';
  self.le_agency_desc			    := trim(l.arrestingagency);
  self.le_agency_case_number  := trim(l.bookingnumber);
	
  self.traffic_ticket_number  := MAP(l.statecode in ['NJ'] => '',
											               trim(l.CitationNumber) <> 'CNONE' => trim(l.CitationNumber),
											               '');
  self.traffic_dl_no			    := trim(l.DLNumber);
  self.traffic_dl_st			    := trim(l.DLState);
	
  self.arr_off_code				    := '';
  self.arr_off_desc_1			    := trim(l.initialcharge);	// split accross multiple fields on whitespace breakpoint?, use all charge fields?
  self.arr_off_desc_2			    := trim(if(l.amendedcharge<>'', 'AMENDED:'+	' '+l.amendedcharge,''));
  self.arr_off_type_cd		        := '';
  self.arr_off_type_desc	        := '';
  self.arr_off_lev				    := MAP(trim(l.ln_vendor) ='RD' and regexfind('INITIAL CHARGE INFO: TYPE: ([A-Z])([A-Z]+), CLASS: ([A-Z1-9]); (.*)',l.caseinfo) => regexreplace('INITIAL CHARGE INFO: TYPE: ([A-Z])([A-Z]+), CLASS: ([A-Z1-9]); (.*)',l.caseinfo,'$1$3'),
	                                  '');
  self.arr_statute				    := '';
  self.arr_statute_desc		      	:= '';
  self.arr_disp_date			    := if(trim(l.bookingdate, left, right)[1..2] between '19' and '20' and length(trim(l.bookingdate, left, right))=8 and trim(l.bookingdate, left, right)[5..6] in ['01','02','03','04','05','06','07','08','09','10','11','12'] and l.bookingdate<=stringlib.GetDateYYYYMMDD(),
											trim(l.bookingdate, left, right),
										if(trim(l.bookingdate)[1..2] between '19' and '20' and length(trim(l.bookingdate, left, right))=4 and l.bookingdate[1..4]<=stringlib.GetDateYYYYMMDD()[1..4],
											trim(l.bookingdate, left, right),
										''));
  self.arr_disp_code			    := '';
  self.arr_disp_desc_1		    := MAP (trim(l.ln_vendor) ='TB' and 
																	    regexfind('(ARREST DISPOSITION:[ ]*)([A-Z ]+)[ ]*$',temp_disp) =>  regexreplace('(ARREST DISPOSITION:[ ]*)([A-Z ]+)[ ]*$',temp_disp,'$2'),
																			trim(l.ln_vendor) ='TB' and
																			regexfind('(ARREST DISPOSITION:[ ]*)([A-Z ]+)[ ]*$',temp_disp) =>  regexreplace('(ARREST DISPOSITION:[ ]*)([A-Z ]+)[ ]*$',temp_disp,'$2'),
																			trim(l.ln_vendor) ='TB' and
																			regexfind('(ARREST[ ]*:[ ]*)([A-Z ]+)[ ]*$',temp_disp) =>  regexreplace('(ARREST[ ]*:[ ]*)([A-Z ]+)[ ]*$',temp_disp,'$2'),
																			trim(l.ln_vendor) ='TB' and
																			regexfind('(ARREST[ ]*:[ ]*)([A-Z ]+)[ ]*$',temp_disp) =>  regexreplace('(ARREST[ ]*:[ ]*)([A-Z ]+)[ ]*$',temp_disp,'$2'),
											               l.bookingdate<>''=> 'BOOKED', ''); 			
  self.arr_disp_desc_2		    := if(l.bondamount<>'' or l.bondtype<>'', 
											              'BOND: '+trim(l.bondtype)+' '+trim(l.bondamount),'') + 
										                if(l.warrantnumber<>'' or l.warrantdesc<>'' or l.warrantissuingagency<>'' or l.warrantstatus<>'',
											                'WARRANT: '+trim(l.warrantnumber)+ ' '+trim(l.warrantdesc)+	' '+trim(l.warrantissuingagency)+
											                ' '+trim(l.warrantstatus),
											                '');
  self.pros_refer_cd			    := '';
  self.pros_refer				    := '';
  self.pros_assgn_cd			    := '';
  self.pros_assgn				    := '';
  self.pros_chg_rej				    := '';
  self.pros_off_code			    := '';
  self.pros_off_desc_1		      	:= '';
  self.pros_off_desc_2		        := '';
  self.pros_off_type_cd		        := '';
  self.pros_off_type_desc	        := '';
  self.pros_off_lev				    := '';
  self.pros_act_filed			    := '';
	
  self.court_case_number	        := temp_case_number;
  self.court_cd					          := MAP(l.sourcename = 'ALASKA_ADMINISTRATOR_OF_THE_COURTS' => regexreplace('-',regexreplace('(.*- )(.*)',l.courtname ,'$1'),''),   
																							 l.sourcename = 'ARKANSAS_ADMINISTRATOR_OF_THE_COURTS' => regexreplace('-',regexreplace('(.*- )(.*)',l.courtname ,'$1'),''),
																							 l.sourcename = 'ARIZONA_ADMINISTRATOR_OF_THE_COURTS' => regexreplace('-',regexreplace('(.*- )(.*)',l.courtname ,'$1'),''),
																							 l.sourcename = 'CONNECTICUT_ADMINISTRATOR_OF_THE_COURTS' => regexreplace('-',regexreplace('(.*- )(.*)',l.courtname ,'$1'),''),
																							 l.sourcename = 'HAWAII_STATE_JUDICIARY' => regexreplace('-',regexreplace('(.*- )(.*)',l.courtname ,'$1'),''),
																							 l.sourcename = 'NEW_JERSEY_ADMINISTRATOR_OF_THE_COURTS ' => regexreplace('-',regexreplace('(.*- )(.*)',l.courtname ,'$1'),''),
																							 l.sourcename = 'OREGON_ADMINISTRATOR_OF_THE_COURTS' => regexreplace('-',regexreplace('(.*- )(.*)',l.courtname ,'$1'),''),
																							 l.sourcename = 'RHODE_ISLAND_ADMINISTRATOR_OF_THE_COURTS ' => regexreplace('-',regexreplace('(.*- )(.*)',l.courtname ,'$1'),''),
																							 l.sourcename = 'RHODE_ISLAND_ADMINISTRATOR_OF_THE_COURTS_TRAFFIC' => regexreplace('-',regexreplace('(.*- )(.*)',l.courtname ,'$1'),''),
																							 l.sourcename = 'TENNESSEE_ADMINISTRATOR_OF_THE_COURTS' => regexreplace('-',regexreplace('(.*- )(.*)',l.courtname ,'$1'),''),
																							 l.sourcename = 'UTAH_ADMINISTRATOR_OF_THE_COURTS' => regexreplace('-',regexreplace('(.*- )(.*)',l.courtname ,'$1'),''),
																							 l.sourcename = 'VIRGINIA_ADMINISTRATOR_OF_THE_COURTS' => regexreplace('-',regexreplace('(.*- )(.*)',l.courtname ,'$1'),'')
																			           	,'');	
										
			get_court_desc                := MAP(l.sourcename = 'ALASKA_ADMINISTRATOR_OF_THE_COURTS' => Trim(regexreplace('(.*- )(.*)',l.courtname,'$2')),   
						 												        l.sourcename = 'ARKANSAS_ADMINISTRATOR_OF_THE_COURTS' => trim(regexreplace('(.*- )(.*)',l.courtname ,'$2')),   																					 
																						l.sourcename = 'ARIZONA_ADMINISTRATOR_OF_THE_COURTS' => Trim(regexreplace('(.*- )(.*)',l.courtname,'$2')),            
																						l.sourcename = 'HAWAII_STATE_JUDICIARY   ' => Trim(regexreplace('(.*-[ ])([A-Z]+.*)',l.courtname ,('$2'))),            
																						l.sourcename = 'INDIANA_ADMINISTRATOR_OF_THE_COURTS' => Trim(l.courtname),            
																						l.sourcename = 'MARYLAND_ADMINISTRATOR_OF_THE_COURTS' => Trim(regexreplace('([A-Z .\']+)-.*',l.courtname,'$1')),            
																						l.sourcename = 'MINNESOTA_DEPARTMENT_OF_PUBLIC_SAFETY' => Trim(l.courtname),            
																						l.sourcename = 'MISSOURI_ADMINISTRATOR_OF_THE_COURTS' => Trim(l.courtname),            
																						l.sourcename = 'NEW_MEXICO_ADMINISTRATOR_OF_THE_COURTS' => Trim(l.courtname),            
																						l.sourcename = 'NORTH_DAKOTA_ADMINISTRATOR_OF_THE_COURTS' => Trim(l.courtname),            
																						l.sourcename = 'OREGON_ADMINISTRATOR_OF_THE_COURTS' => Trim(regexreplace('.*- ([A-Z ]+)',l.courtname,'$1')),            
																						l.sourcename = 'RHODE_ISLAND_ADMINISTRATOR_OF_THE_COURTS' => Trim(regexreplace('(.*- )(.*)',l.courtname,'$2')),            
																						l.sourcename = 'RHODE_ISLAND_ADMINISTRATOR_OF_THE_COURTS_TRAFFIC' => Trim(regexreplace('(.*- )(.*)',l.courtname,'$2')),            
																						l.sourcename = 'TENNESSEE_ADMINISTRATOR_OF_THE_COURTS' => regexreplace('(.*- )(.*)',l.courtname,'$2'),            
																						l.sourcename = 'TEXAS_DEPARTMENT_OF_PUBLIC_SAFETY' => Trim(l.courtname),            
																						l.sourcename = 'UTAH_ADMINISTRATOR_OF_THE_COURTS' => Trim(regexreplace('(.*- )(.*)',l.courtname,'$2')),   
																						l.sourcename = 'VIRGINIA_ADMINISTRATOR_OF_THE_COURTS' => Trim( map(regexfind('(.*- )(.*)(-[ A-Z]+)',l.courtname) => regexreplace('(.*- )(.*)(-[ A-Z]+)',l.courtname,'$2$3'),	
																																																							 regexfind('(.*- )(.*)',l.courtname)  => regexreplace('(.*- )(.*)',l.courtname,'$2')
																																																							 ,'')), 
									                          l.sourcename='MINNESOTA_DEPARTMENT_OF_PUBLIC_SAFETY'  => map(regexfind('([A-Z ]+)(CO DISTRICT COURT.*)',l.courtname)=> l.courtname,
																																								   											 regexfind('([A-Z ]+)(DIST COURT.*)',l.courtname) => l.courtname,
																																																			   regexfind('([A-Z ]+)(COUNTY.*)',l.courtname)     => l.courtname,
																																																			   regexfind('([A-Z ]+)(CO COURT.*)',l.courtname) 	 => l.courtname																								
																																							  										     ,''),
																						l.sourcename = 'VIRGINIA_ADMINISTRATOR_OF_THE_COURTS_CIRCUIT_COURTS_WEBSITE' => Trim(l.courtname), 																														 
																																																																									
																						Trim(l.courtname));									
										
  self.court_desc				    :=  get_court_desc;	

  self.court_appeal_flag	      	:= '';
  self.court_final_plea		      	:= //MAP(//trim(l.ln_vendor) ='RD'  => trim(l.finalruling),
	                                       trim(l.InitialPlea);
																		 //		);
  self.court_off_code			  	:= MAP(l.statecode = 'AR' => '',
	                                   l.statecode = 'CT' => '',
	                                   l.statecode = 'FL' => '',
	                                   l.statecode = 'HI' => '',
																		 l.statecode = 'IA' => '',
																		 l.statecode = 'IN' => '',
																		 l.statecode = 'MD' => '',
																		 l.statecode = 'MN' => '',
									                   l.statecode = 'NM' => '',
	                                   l.statecode = 'OK' => '',
	                                   l.statecode = 'PA' and l.ln_vendor ='PU' => '',
																		 // l.statecode = 'RI' => '',
																		 l.statecode = 'RI' and l.ln_vendor ='RA' => '',
																		 l.statecode = 'UT' => '',
	                                   l.statecode = 'VA' => '',
																		 l.statecode = 'WI' => '',
																		 IF(regexfind('[a-zA-Z0-9.-]+[(a-zA-Z)-]*[(0-9)]*:', l.offensecode), '', trim(l.offensecode))
																		) ;
  
  string temp_offense_orig          := stringlib.stringtouppercase(if(trim(l.FinalOffense) <> '',
											                 trim(l.FinalOffense),
										                   if(trim(l.offensedesc) <> '',
											                    trim(l.offensedesc),
											                    '')));
											
  string temp_offense		:= if(regexfind('TOTAL DEFENDANTS', trim(temp_offense_orig, left, right), 0)<>'',
														'',
													if(length(trim(temp_offense_orig, left, right))<3,
														'',
													temp_offense_orig));

//find court_desc
		ct_off_desc := MAP(
		                   l.statecode = 'CT' => '',
														 l.statecode = 'FL' => regexreplace('[/(]PRINCIPAL[/)]',temp_offense,''),
														 l.statecode = 'HI' => '',
														 l.statecode = 'IA' => '',
														 l.statecode = 'IN' => '',
														 l.statecode = 'MD' => '',
														 l.statecode = 'MN' => '',
														 l.statecode = 'NC' => '',
														 l.statecode = 'NM' => '',
														 l.statecode = 'OK' => '',
														 l.statecode = 'PA' and l.ln_vendor ='PU' => '',
														 // l.statecode = 'RI' => '',
														 l.statecode = 'RI' and l.ln_vendor ='RA' => '',
														 l.statecode = 'UT' => '',
														 l.statecode = 'VA' => '',
														 l.statecode = 'WI' => '',
	                             if(regexfind('[A-Z]+', if(regexfind('[a-zA-Z0-9.]+[(a-zA-Z)]*[(0-9)]*:',temp_offense),	'',
											         if(l.statecode = 'HI' and stringlib.stringfind(temp_offense, '|', 1) <> 0,
												          temp_offense[1..stringlib.stringfind(temp_offense, '|', 1)-1],
											         if(l.statecode = 'AK' and stringlib.stringfind(temp_offense, ':', 1) <> 0,
												          temp_offense[stringlib.stringfind(temp_offense, ':', 1)+1..length(temp_offense)],
												          temp_offense))), 0)<>'',
										           if(regexfind('[a-zA-Z0-9.]+[(a-zA-Z)]*[(0-9)]*:',temp_offense),
											            '',
										           if(l.statecode = 'HI' and stringlib.stringfind(temp_offense, '|', 1) <> 0,
   											          temp_offense[1..stringlib.stringfind(temp_offense, '|', 1)-1],
										           if(l.statecode = 'AK' and stringlib.stringfind(temp_offense, ':', 1) <> 0,
											            temp_offense[stringlib.stringfind(temp_offense, ':', 1)+1..length(temp_offense)],
											            temp_offense))),	'')
															);
															

	  string SatuteW0004                    := MAP(l.ln_vendor = 'W0004' and  regexfind('(.*) - (.*) - (.*)',l.FinalOffense)=> regexreplace('(.*) - (.*) - (.*)',l.FinalOffense,'$1'),
	                                              '');															
	
		ct_statute                           := MAP(l.statecode = 'CT' => temp_offense,
																				 l.statecode = 'FL' => regexreplace('[/(]PRINCIPAL[/)]',temp_offense,''),
																				 l.statecode = 'HI' => temp_offense,
																				 l.statecode = 'IA' => temp_offense,
																				 l.statecode = 'IN' and stringlib.stringfind(temp_offense, ':', 1) <> 0 => temp_offense[stringlib.stringfind(temp_offense, ':', 1)+1..],
																				 l.statecode = 'IN'                                                     => temp_offense,
																				 l.statecode = 'MD' => temp_offense,
																				 l.statecode = 'MN' and regexfind('!@#', temp_offense, 0)<>'' => temp_offense[1..stringlib.stringfind(temp_offense, '!@#', 1)],
											                   l.statecode = 'MN' => temp_offense,
																				 l.statecode = 'NM' => temp_offense,
											                   l.statecode = 'NC' => MAP(regexfind('(.*, )([a-zA-Z0-9.-]+[/(a-zA-Z/)]*[(0-9)]*)$',temp_offense) => regexreplace('(.*), ([a-zA-Z0-9.-]+[/(a-zA-Z/)]*[(0-9)]*)$',temp_offense,'$1'),
                                                                   regexfind('(.*, )([a-zA-Z0-9.-]+[/(a-zA-Z/)]*[(0-9)]*,.*)(OFF CLASS: .*)',temp_offense) => regexreplace('(.*, )([a-zA-Z0-9.-]+[/(a-zA-Z/)]*[(0-9)]*,.*)(OFF CLASS: .*)',temp_offense,'$1$3'),
                                                                   regexfind('(.*, )([a-zA-Z0-9.-]+[/(a-zA-Z/)]*[(0-9)]*), OFF.*',temp_offense) => regexreplace('(.*), ([a-zA-Z0-9.-]+[/(a-zA-Z/)]*[(0-9)]*), OFF.*',temp_offense,'$1'),
				                                                           regexfind('(.*, )([ a-zA-Z0-9.-]+)(, OFF .*)',temp_offense) => regexreplace('(.*, )([ a-zA-Z0-9.-]+)(, OFF .*)',temp_offense,'$1$2'),
																																	 temp_offense),
																				 l.statecode = 'OK' => temp_offense,
																				 l.statecode = 'PA' and l.ln_vendor ='PU' => temp_offense,
																				 l.statecode = 'RI' and l.ln_vendor ='RA' => temp_offense,
																				 l.statecode = 'UT' => temp_offense,
																				 l.statecode = 'VA' => temp_offense,
																				 l.statecode = 'WI' => temp_offense,
																				 regexfind('[a-zA-Z0-9.]+[(a-zA-Z)]*[(0-9)]*:',temp_offense) => trim(regexreplace('([a-zA-Z0-9.]+[/(a-zA-Z/)]*[(0-9)]*:)(.*)',temp_offense,'$2'),left,right), 
											                   '');
  
  string OffenseW0004                    := MAP(l.ln_vendor = 'W0004' and  regexfind('(.*) - (.*) - (.*)',l.FinalOffense)=> regexreplace('(.*) - (.*) - (.*)',l.FinalOffense,'$2'),
	                                             '');	                                                         
  string Offense_levW0004                := MAP(l.ln_vendor = 'W0004' and  regexfind('(.*) - (.*) - (.*)',l.FinalOffense)=> regexreplace('(.*) - (.*) - (.*)',l.FinalOffense,'$3'),
	                                             '');	                                                         	
												
  self.court_off_desc_1				    := MAP(l.ln_vendor ='W0004' and OffenseW0004 <>'' =>  OffenseW0004,
	                                       ct_off_desc<>''     =>  ct_off_desc,
											                   ct_statute);	

  self.court_off_desc_2		      	:= '';
  self.court_off_type_cd	      	:= '';
  self.court_off_type_desc	    	:= '';
	
	temp_offense_lev_W0002          := MAP(regexfind('^TRAFFIC|^EXPIRED REG|^SPEED|^MOVING|SEAT[ ]*BELT',temp_offense) => 'T',
	                                       '');
																			 
	self.court_off_lev			    		:= MAP(
	                                      l.sourcename = 'UTAH_WHITE_COLLAR_CRIME_OFFENDER_REGISTRY' => 'F', //with legal approval- https://www.utfraud.com/Home/Faqs
																			  l.sourcename = 'ILLINOIS_VIOLENT_OFFENDER_AGAINST_YOUTH ' => 'F',//with legal approval - http://www.isp.state.il.us/cmvo/cmvofaq.cfm?CFID=44357946&CFTOKEN=2407f7570d66c157-59497B11-B879-EA3C-2BFB1AAF644EEFE6&jsessionid=ec3096b73f85ef3429152c1a665965836404#offenses
																				
	                                      l.sourcename ='WASHINGTON_PUBLIC_SCOMIS_CRIMINAL_INDEX' and 
																				trim(l.offenseclass)= 'GROSS MISDEMEANOR' => 'GM',
																				l.sourcename ='WASHINGTON_PUBLIC_SCOMIS_CRIMINAL_INDEX' and 
																				trim(l.offenseclass)= 'MISDEMEANOR'       => 'M' ,
																				l.sourcename ='WASHINGTON_PUBLIC_SCOMIS_CRIMINAL_INDEX' and
																				trim(l.offenseclass)= 'FELONY'            => 'F' ,
																				l.sourcename ='WASHINGTON_PUBLIC_SCOMIS_CRIMINAL_INDEX' and
																				trim(l.offenseclass)= 'COMBINATION'       => 'COMB', 	
	
	                                      l.sourcename ='WASHINGTON_PUBLIC_SCOMIS_CRIMINAL_INDEX' => trim(l.offenseclass),
																				 
	                                      l.sourcename = 'WASHINGTON_COURTS_OF_LIMITED_JURISDICTION_CRIMINAL_INDEX' and 
																				stringlib.stringfind(temp_offense ,'FELONY',1) >0 => 'F',
																				l.sourcename = 'WASHINGTON_COURTS_OF_LIMITED_JURISDICTION_CRIMINAL_INDEX' and 
																				stringlib.stringfind(temp_offense ,'MISD',1) >0 => 'M',
																				l.sourcename = 'WASHINGTON_COURTS_OF_LIMITED_JURISDICTION_CRIMINAL_INDEX' and 
																				l.casetype = 'CRIMINAL NON-TRAFFIC' => '',
                                        l.sourcename = 'WASHINGTON_COURTS_OF_LIMITED_JURISDICTION_CRIMINAL_INDEX' and 
																				l.casetype = 'CRIMINAL TRAFFIC' => 'T',
																				 
	                                      l.statecode in ['AZ'] and trim(l.offenseclass) = 'FELONY/MISDEMEANOR' =>'FM',
												                l.statecode in ['AZ'] => map(
																				                              l.casetype = 'TRAFFIC' and 
																				                              trim(l.offenseclass) = '' => 'T',
																																			l.casetype = 'TRAFFIC' and 
																				                              trim(l.offenseclass) in ['NON CRIMINAL'] => 'TNC',
																																			l.casetype = 'TRAFFIC' and 
																				                              trim(l.offenseclass) in ['PETTY OFFENSE'] => 'TP',
																				                              l.offenseclass[1..1]
																																			),
												                l.statecode in ['AK', 'AR'] and trim(l.offensetype) = 'PROBATION REVOCATION' => '',  
																				l.statecode in ['AK'] => l.offenseclass[1..1],	
																				l.statecode in ['AR'] => map(trim(l.offenseclass, left, right)='FELONY' and trim(l.offensedegree, left, right)='A' => 'FA',
																				 													  trim(l.offenseclass, left, right)='FELONY' and trim(l.offensedegree, left, right)='B' => 'FB',
																																		trim(l.offenseclass, left, right)='FELONY' and trim(l.offensedegree, left, right)='C' => 'FC',
																																		trim(l.offenseclass, left, right)='FELONY' and trim(l.offensedegree, left, right)='D' => 'FD',
																																		trim(l.offenseclass, left, right)='FELONY' and trim(l.offensedegree, left, right)='U' => 'FU',
																																		trim(l.offenseclass, left, right)='MISDEMEANOR' and trim(l.offensedegree, left, right)='A' => 'MA',
																																		trim(l.offenseclass, left, right)='MISDEMEANOR' and trim(l.offensedegree, left, right)='B' => 'MB',
																																		trim(l.offenseclass, left, right)='MISDEMEANOR' and trim(l.offensedegree, left, right)='C' => 'MC',
																																		trim(l.offenseclass, left, right)='MISDEMEANOR' and trim(l.offensedegree, left, right)='D' => 'MD',
																																		trim(l.offenseclass, left, right)='MISDEMEANOR' and trim(l.offensedegree, left, right)='U' => 'MU',
																																		trim(l.offensetype, left, right)<>'' => trim(trim(l.offensetype, left, right)[1..2], left, right),
																																		''),
												                 l.statecode in ['FL'] => (if(trim(l.offensetype, left, right)='MISDEMEANOR',
																																		'M',
																																	 if(trim(l.offensetype, left, right)='MUNICIPAL',
																																		'MU',
																																		trim(l.offensetype, left, right)[1])))+ 
																																		trim((map(stringlib.stringfind(trim(l.offensedegree, left, right),'FIRST DEGREE',1)>0 => '1',
																																				trim(l.offensedegree, left, right)='SECOND DEGREE' => '2',
																																				trim(l.offensedegree, left, right)='THIRD DEGREE' => '3',
																																				trim(l.offensedegree, left, right)='FOURTH DEGREE' => '4',
																																				trim(l.offensedegree, left, right)='FIFTH DEGREE' => '5',
																																				trim(l.offensedegree, left, right)='SIXTH DEGREE' => '6',
																																				trim(l.offensedegree, left, right)='SEVENTH DEGREE' => '7',
																																				trim(l.offensedegree, left, right)='EIGHTH DEGREE' => '8',
																																				trim(l.offensedegree, left, right)='NINTH DEGREE' => '9',
																																				trim(l.offensedegree, left, right)='TENTH DEGREE' => '10',
																																				trim(l.offensedegree, left, right)='CAPITAL' => 'CA',
																																				trim(l.offensedegree, left, right)='LIFE' => 'L',
																																				'')), left, right),
																				l.statecode in ['GA'] => 	(map(trim(l.offensetype, left, right)='FELONY' and trim(l.offenseclass, left, right)='' => 'F',
																																		trim(l.offensetype, left, right)='MISDEMEANOR' and trim(l.offenseclass, left, right)='' => 'M',
																																		'')),
																				l.statecode in ['HI'] 	=> (MAP(regexfind('(PETTY) (M)(ISD[EMEANOR]*)',l.offensedegree) => 'PM',
																																			regexfind('(M)(ISD[EMEANOR]*) ([A-Z])',l.offensedegree) => regexreplace('(M)(ISD[EMEANOR]*) ([A-Z])',l.offensedegree,'$1$3'),
																																			regexfind('(F)(EL[ONY]*) ([A-Z])',l.offensedegree) =>  regexreplace('(F)(EL[ONY]*) ([A-Z])',l.offensedegree,'$1$3'),
																																			regexfind('(I)(NFRACTION) ([A-Z])',l.offensedegree) =>regexreplace('(I)(INFRACTION) ([A-Z])',l.offensedegree,'$1$3'),
																																			regexfind('(V)(IOLATION)',l.offensedegree) =>regexreplace('(V)(IOLATION)',l.offensedegree,'$1'),
																																			regexfind('([A-Z])',l.offensedegree) => regexreplace('([A-Z])',l.offensedegree,'$1'),
																																			'')),	
																				l.statecode in ['IA'] => (map(trim(l.offensedegree, left, right)='FELONY A'   => 'FA',//copy this to actual mapping
																																			trim(l.offensedegree, left, right)='FELONY B'   => 'FB',
																																			trim(l.offensedegree, left, right)='FELONY C'   => 'FC',
																																			trim(l.offensedegree, left, right)='FELONY D'   => 'FD',	
																																			trim(l.offensedegree, left, right)='SERIOUS MISDEMEANOR'    /*and trim(l.offensedegree, left, right)='SERIOUS MISDEMEANOR' */ => 'MSE',
																																			trim(l.offensedegree, left, right)='SIMPLE MISDEMEANOR'     /*and trim(l.offensedegree, left, right)='SIMPLE MISDEMEANOR'  */ => 'MSI',
																																			trim(l.offensedegree, left, right)='AGGRAVATED MISDEMEANOR' /*and trim(l.offensedegree, left, right)='AGGRAVATED MISDEMEAN'*/ => 'AM',
	
																				                              trim(l.offensetype, left, right)='SERIOUS MISDEMEANOR'    /*and trim(l.offensedegree, left, right)='SERIOUS MISDEMEANOR' */ => 'MSE',
																																			trim(l.offensetype, left, right)='SIMPLE MISDEMEANOR'     /*and trim(l.offensedegree, left, right)='SIMPLE MISDEMEANOR'  */ => 'MSI',
																																			trim(l.offensetype, left, right)='AGGRAVATED MISDEMEANOR' /*and trim(l.offensedegree, left, right)='AGGRAVATED MISDEMEAN'*/ => 'AM',
																																			trim(l.offensetype, left, right)='FELONY A'   => 'FA',
																																			trim(l.offensetype, left, right)='FELONY B'   => 'FB',
																																			trim(l.offensetype, left, right)='FELONY C'   => 'FC',
																																			trim(l.offensetype, left, right)='FELONY D'   => 'FD',		
																																			trim(l.offensetype, left, right)='FELONY'     => 'F',
																																			trim(l.offensetype, left, right)='MISDEMEANOR'=> 'M',
																																			trim(l.offensetype, left, right)='TRAFFIC'    => 'T',
																																			'')),
																				l.statecode in ['IN'] 	=> (MAP(regexfind('(M)(ISD[EMEANOR]*) (CLASS) ([A-Z])',l.offensedegree) => regexreplace('(M)(ISD[EMEANOR]*) (CLASS) ([A-Z])',l.offensedegree,'$1$4'),
																																			regexfind('(F)(EL[ONY]*) (CLASS) ([A-Z])',l.offensedegree) => regexreplace('(F)(EL[ONY]*) (CLASS) ([A-Z])',l.offensedegree,'$1$4'),
																																			regexfind('(I)(NFRACTION) (CLASS) ([A-Z])',l.offensedegree) => regexreplace('(I)(NFRACTION) (CLASS) ([A-Z])',l.offensedegree,'$1$4'),
																																			regexfind('(M)(ISD[EMEANOR]*) ([A-Z])',l.offensedegree) => regexreplace('(M)(ISD[EMEANOR]*) ([A-Z])',l.offensedegree,'$1$3'),
																																			regexfind('(F)(EL[ONY]*) ([A-Z])',l.offensedegree) =>  regexreplace('(F)(EL[ONY]*) ([A-Z])',l.offensedegree,'$1$3'),
																																			regexfind('(I)(NFRACTION) ([A-Z])',l.offensedegree) =>regexreplace('(I)(INFRACTION) ([A-Z])',l.offensedegree,'$1$3'),
																																			'')),	
                                        l.statecode in ['IL'] 	=> (MAP(regexfind('(CLASS) ([A-Z0-9]) (M)(ISD[EMEANOR]*)',l.offenseclass) => regexreplace('(CLASS) ([A-Z0-9]) (M)(ISD[EMEANOR]*)',l.offenseclass,'$3$2'),
																																			  regexfind('(CLASS) ([A-Z0-9]) (F)(EL[ONY]*)'     ,l.offenseclass) => regexreplace('(CLASS) ([A-Z0-9]) (F)(EL[ONY]*)'     ,l.offenseclass,'$3$2'),
																																			  regexfind('(CLASS) ([A-Z0-9]) (I)(NFRACTION)'    ,l.offenseclass) => regexreplace('(CLASS) ([A-Z0-9]) (I)(NFRACTION)'    ,l.offenseclass,'$3$2'),
																																				trim(l.casetype)='CRIMINAL FELONY' => 'F',
																																				trim(l.casetype)='CRIMINAL MISDEMEANOR' => 'M',																																				
																																		  	'')),	
																																			
																				l.statecode in ['MD'] => (MAP(  trim(l.casetype)='INFRACTION' => 'I',
																				                                trim(l.casetype)='MISDEMEANOR' => 'M',
																																				trim(l.casetype)='VIOLATION' => 'V',
																																				trim(l.casetype) IN ['FELONY DISTRICT COURT','FELONY'] => 'F',																																				
																																				trim(l.casetype) IN ['CITATION - DNR','CRIMINAL - JTP - MOTOR VEHICLE','CRIMINAL - JTP - MOTOR VEHICLE',
																																				                     'CITATION - CRIMINAL','CITATION - CIVIL','MASS TRANSIT CITATION','TRAFFIC']=> 'T',
																																		  	trim(l.offenseclass[1..1]))),
																				                                                                                                    
																				vVendor = 'W0002'  => map(
																				                             l.offenseclass = 'GROSS MISDEMEANOR'    => 'GM'+ temp_offense_lev_W0002,
																				                             l.offenseclass = 'FELONY'               => 'F'+  temp_offense_lev_W0002,
																															  	   l.offenseclass = 'JUVENILE PETTY OFFEN' => 'JPO'+temp_offense_lev_W0002, 
																																		 l.offenseclass = 'JUVENILE TRAFFIC OFF' => 'JTO'+temp_offense_lev_W0002,
																																		 l.offenseclass = 'MISDEMEANOR'          => 'M'+  temp_offense_lev_W0002, 
																																		 l.offenseclass = 'PETTY MISDEMEANOR'    => 'PM'+ temp_offense_lev_W0002,
																																		 regexfind('PETTY MISD'           ,l.casetype)=> 'PM',
																																		 regexfind('GROSS MISD'           ,l.casetype)=> 'GM',
																																		 regexfind('MISDEMEANOR'          ,l.casetype)=> 'M',
																																		 regexfind('FELONY'               ,l.casetype)=> 'F',
																																		 regexfind('MOVING - MISDEMEANOR' ,l.casetype)=> 'MT',
                                                                     regexfind('MOVING - PETTY MISD'  ,l.casetype)=> 'PMT',
                                                                     regexfind('OVERWEIGHT MISDEMEAN' ,l.casetype)=> 'MT',
                                                                     regexfind('PETTY MISD. DNR'      ,l.casetype)=> 'MT',
																																		 regexfind('SPEEDING-MISD'        ,l.casetype)=> 'MT',
                                                                     regexfind('SPEEDING-PETTY MISD'  ,l.casetype)=> 'MT',
																																		 regexfind('^TRAFFIC'             ,l.casetype)=> 'T',
																				                             ''),
                                        																																	 
																				   
																				l.statecode in ['MN'] => trim(l.offensedegree[1..1]),		
																				l.statecode in ['MO'] => (MAP(regexfind('(M)(ISD[EMEANOR]*) ([A-Z]) (RSMO: [A-Z0-9/. ]*)',l.offensetype) => regexreplace('(M)(ISD[EMEANOR]*) ([A-Z]) (RSMO: [A-Z0-9/. ]*)',l.offensetype,'$1$3'),
																																			regexfind('(F)(EL[ONY]*) ([A-Z]) (RSMO: [A-Z0-9/. ]*)',l.offensetype) => regexreplace('(F)(EL[ONY]*) ([A-Z]) (RSMO: [A-Z0-9/. ]*)',l.offensetype,'$1$3'),
																																			regexfind('(I)(NFRACTION) (RSMO: [A-Z0-9/. ]*)',l.offensetype) => regexreplace('(I)(NFRACTION) (RSMO: [A-Z0-9/. ]*)',l.offensetype,'$1'),
																																			regexfind('(M)(ISD[EMEANOR]*)',l.offensetype) => 'M',
																																			regexfind('(F)(EL[ONY]*)',l.offensetype) => 'F',
																																			regexfind('(I)(NFRACTION)',l.offensetype) => 'I',
																																			regexfind('(M)(ISD[EMEANOR]*)',l.offensetype) => 'M',
																																			regexfind('(F)(EL[ONY]*)',l.offensetype) => 'F',
																																			'')),	
																				l.statecode in ['NC'] => 	(map(trim(l.casetype)='FELONY' => 'F',
																																			 trim(l.casetype)='INFRACTION' => 'I',
																																			 trim(l.casetype)='MISDEMEANOR' => 'M',
																																			'')),
																				l.statecode in ['ND'] => 	(map(trim(l.offenseclass, left, right)='FA' or trim(l.offensedegree, left, right)='FA' => 'FA',
																																			trim(l.offenseclass, left, right)='FB' or trim(l.offensedegree, left, right)='FB' => 'FB',
																																			trim(l.offenseclass, left, right)='FC' or trim(l.offensedegree, left, right)='FC' => 'FC',	
																																			trim(l.offenseclass, left, right)[1..9]='FELONY AA' => 'FAA',
																																			trim(l.offenseclass, left, right)[1..8]='FELONY A' => 'FA',	
																																			trim(l.offenseclass, left, right)[1..8]='FELONY B' => 'FB',
																																			trim(l.offenseclass, left, right)[1..8]='FELONY C' => 'FC',
																																			trim(l.offenseclass, left, right)[1..8]='FELONY D' => 'FD',
																																			trim(l.offenseclass, left, right)[1..8]='FELONY U' => 'F',
																																			trim(l.offenseclass, left, right)[1..2]='IN' => 'I',
																																			trim(l.offenseclass, left, right)[1..13]='MISDEMEANOR A' => 'MA',
																																			trim(l.offenseclass, left, right)[1..13]='MISDEMEANOR B' => 'MB',
																																			trim(l.offenseclass, left, right)[1..13]='MISDEMEANOR C' => 'MC',
																																			trim(l.offenseclass, left, right)[1..13]='MISDEMEANOR U' => 'M',
																																			trim(l.offensetype, left, right)= 'FELONY'         => 'F',                                                                                            
                                                                      trim(l.offensetype, left, right)= 'FELONY CLASS A' => 'FA', 
																																			trim(l.offensetype, left, right)= 'FELONY AA'      => 'FA',
																																			trim(l.offensetype, left, right)= 'FELONY CLASS B' => 'FB',
																																			trim(l.offensetype, left, right)= 'FELONY CLASS C' => 'FC',                                
																																			trim(l.offensetype, left, right)= 'MISDEMEANOR'        => 'M',  
																																			trim(l.offensetype, left, right)= 'MISDEMEANOR CLASS A'=> 'MA',
																																			trim(l.offensetype, left, right)= 'MISDEMEANOR CLASS B'=> 'MB',                                                                                 
																																			trim(l.offensetype, left, right)= 'INFRACTION'         => 'I',                                                                                      
																																			trim(l.offensetype, left, right) IN ['NON-MOVING VIOLATION' ,'MOVING VIOLATION','DOT']=>'T',                                                                               
																																			'')),
																																			
																				l.statecode in ['NM'] => trim(l.offenseclass),
																				l.statecode in ['OK'] => (map(trim(l.offenseclass, left, right) in ['CRIMINAL FELONY','FELONY'] => 'F',
																																			trim(l.offenseclass, left, right) in ['CRIMINAL MISDEMEANOR','MISDEMEANOR'] => 'M',
																																			trim(l.offenseclass, left, right) in ['TRAFFIC'] => 'T',
																																			'')),
																				l.statecode in ['OR'] 	=> (map(trim(l.offensedegree, left, right) in ['FE','FELONY'] and trim(l.offenseclass, left, right) = '' => 'F',	
																																			trim(l.offensedegree, left, right) in ['FE','FELONY'] and trim(l.offenseclass, left, right) = 'A' => 'FA',
																																			trim(l.offensedegree, left, right) in ['FE','FELONY'] and trim(l.offenseclass, left, right) = 'B' => 'FB',
																																			trim(l.offensedegree, left, right) in ['FE','FELONY'] and trim(l.offenseclass, left, right) = 'C' => 'FC',
																																			trim(l.offensedegree, left, right) in ['FE','FELONY'] and trim(l.offenseclass, left, right) = 'E' => 'FE',
																																			trim(l.offensedegree, left, right) in ['FE','FELONY'] and trim(l.offenseclass, left, right) = 'F' => 'FF',
																																			trim(l.offensedegree, left, right) in ['FE','FELONY'] and trim(l.offenseclass, left, right) = 'U' => 'FU',
																																			trim(l.offensedegree, left, right) in ['IF','INFRACTION'] and trim(l.offenseclass, left, right) = '' => 'I',	
																																			trim(l.offensedegree, left, right) in ['IF','INFRACTION'] and trim(l.offenseclass, left, right) = 'A' => 'IA',	
																																			trim(l.offensedegree, left, right) in ['IF','INFRACTION'] and trim(l.offenseclass, left, right) = 'B' => 'IB',	
																																			trim(l.offensedegree, left, right) in ['IF','INFRACTION'] and trim(l.offenseclass, left, right) = 'C' => 'IC',	
																																			trim(l.offensedegree, left, right) in ['IF','INFRACTION'] and trim(l.offenseclass, left, right) = 'D' => 'ID',	
																																			trim(l.offensedegree, left, right) in ['IF','INFRACTION'] and trim(l.offenseclass, left, right) = 'F' => 'IF',	
																																			trim(l.offensedegree, left, right) in ['IF','INFRACTION'] and trim(l.offenseclass, left, right) = 'U' => 'IU',
																																			trim(l.offensedegree, left, right)[1] = 'M' and trim(l.offenseclass, left, right) in ['','I'] => 'M',
																																			trim(l.offensedegree, left, right)[1] = 'M' and trim(l.offenseclass, left, right) = 'A' => 'MA',
																																			trim(l.offensedegree, left, right)[1] = 'M' and trim(l.offenseclass, left, right) = 'B' => 'MB',
																																			trim(l.offensedegree, left, right)[1] = 'M' and trim(l.offenseclass, left, right) = 'C' => 'MC',
																																			trim(l.offensedegree, left, right)[1] = 'M' and trim(l.offenseclass, left, right) = 'D' => 'MD',
																																			trim(l.offensedegree, left, right)[1] = 'M' and trim(l.offenseclass, left, right) = 'U' => 'MU',
																																			trim(l.offensedegree, left, right) in ['VI','VIOLATION'] and trim(l.offenseclass, left, right) = '' => 'V',
																																			trim(l.offensedegree, left, right) in ['VI','VIOLATION'] and trim(l.offenseclass, left, right) = 'A' => 'VA',
																																			trim(l.offensedegree, left, right) in ['VI','VIOLATION'] and trim(l.offenseclass, left, right) = 'B' => 'VB',
																																			trim(l.offensedegree, left, right) in ['VI','VIOLATION'] and trim(l.offenseclass, left, right) = 'C' => 'VC',
																																			trim(l.offensedegree, left, right) in ['VI','VIOLATION'] and trim(l.offenseclass, left, right) = 'D' => 'VD',
																																			trim(l.offensedegree, left, right) in ['VI','VIOLATION'] and trim(l.offenseclass, left, right) = 'U' => 'VU',
																																			'')),
																				l.statecode in ['PA'] 	=> (map(trim(l.offensedegree, left, right)='1ST DEGREE FELONY' => 'F1',
																																			trim(l.offensedegree, left, right)='2ND DEGREE FELONY' => 'F2',
																																			trim(l.offensedegree, left, right)='3RD DEGREE FELONY' => 'F3',
																																			trim(l.offensedegree, left, right)='FELONY NOT CLASSIFIE' => 'F',
																																			trim(l.offensedegree, left, right)='1ST DEGREE MISDEMEAN' => 'M1',
																																			trim(l.offensedegree, left, right)='2ND DEGREE MISDEMEAN' => 'M2',
																																			trim(l.offensedegree, left, right)='3RD DEGREE MISDEMEAN' => 'M3',
																																			trim(l.offensedegree, left, right)='MISDEMEANOR NOT CLAS' => 'M',
																																			trim(l.casetype, left, right)='TRAFFIC' => 'T', //VC 10092013 - works only for MJ courts 
																																			temp_case_number[1..2] ='TR' =>'T', //VC 10092013 - need this for non MJ court records 
																																			'')),
																				l.ln_vendor = 'RA'         => 	(map(l.casetype = 'VIOLATION' => 'V',
																				                                 //l.casetype = 'FELONY' => 'F',
																																				 //l.casetype = 'MISDEMEANOR' => 'M', 
																																				 l.casetype = 'ORDINANCE' => 'ORD',
																				                             '')),
																				l.statecode in ['RI'] 	=> (if(trim(l.offensetype, left, right)[1] in ['F','M','O','T','V'] ,
																																		trim(l.offensetype, left, right)[1],
																																		'')),	
                                        l.statecode in ['SC'] 	=> MAP(l.offensetype ='TRAFFIC' => trim(l.offenseclass, left, right)[1] + trim(l.offensedegree, left, right)+'T',
																																			 l.offensetype ='MINOR' => trim(l.offenseclass, left, right)[1] + trim(l.offensedegree, left, right)+'M',
																																			 l.offensetype ='MUNICIPAL' => trim(l.offenseclass, left, right)[1] + trim(l.offensedegree, left, right)+'MUN',
																																			 l.offensetype ='ORDINANCE' => 'ORD',
																																			 trim(l.offenseclass, left, right)[1] + trim(l.offensedegree, left, right)
																																			 ),	
																																			
																				l.statecode in ['TN'] 	=> (MAP(trim(l.offenseclass, left, right)='FELONY' and trim(l.offensedegree, left, right) <> '' => trim(l.offenseclass, left, right)[1] + trim(l.offensedegree, left, right),
																																			trim(l.offenseclass, left, right)='MISDEMEANOR' and trim(l.offensedegree, left, right) <> '' => trim(l.offenseclass, left, right)[1] + trim(l.offensedegree, left, right),
																																			'')),	
																				l.statecode in ['TX'] 	=> (map(trim(l.offenseclass, left, right)[1]='F' and trim(l.offensedegree, left, right) in ['','UNCLASSIFIED DEGREE'] =>'F',			
																																			trim(l.offenseclass, left, right)[1]='F' and trim(l.offensedegree, left, right)='1ST DEGREE' => 'F1',
																																			trim(l.offenseclass, left, right)[1]='F' and trim(l.offensedegree, left, right)='2ND DEGREE' => 'F2',
																																			trim(l.offenseclass, left, right)[1]='F' and trim(l.offensedegree, left, right)='3RD DEGREE' => 'F3',
																																			trim(l.offensedegree, left, right)='CAPTIAL FELONY' => 'CF',
																																			trim(l.offensedegree, left, right)='STATE JAIL FELONY' => 'SF',
																																			trim(l.offenseclass, left, right)[1]='M' and trim(l.offensedegree, left, right) in ['','CLASS UNKNOWN'] =>'M',
																																			trim(l.offenseclass, left, right)='M8' =>'M',
																																			trim(l.offenseclass, left, right)[1]='M' and trim(l.offensedegree, left, right)='CLASS A' => 'MA',
																																			trim(l.offenseclass, left, right)[1]='M' and trim(l.offensedegree, left, right)='CLASS B' => 'MB',
																																			trim(l.offenseclass, left, right)[1]='M' and trim(l.offensedegree, left, right)='CLASS C' => 'MC',
																																			'')),
																				l.statecode in ['UT'] 	=> (map(trim(l.offenseclass, left, right)='FE' =>'FE',	
																																			trim(l.offenseclass, left, right)[1]='F' and trim(l.offensedegree, left, right) ='1ST DEGREE' =>'F1',
																																			trim(l.offenseclass, left, right)[1]='F' and trim(l.offensedegree, left, right) ='2ND DEGREE' =>'F2',
																																			trim(l.offenseclass, left, right)[1]='F' and trim(l.offensedegree, left, right) ='3RD DEGREE' =>'F3',
																																			trim(l.offenseclass, left, right)[1]='I' and trim(l.offensedegree, left, right) ='' =>'I',
																																			trim(l.offenseclass, left, right)='ME' =>'ME',
																																			trim(l.offenseclass, left, right)[1]='M' and trim(l.offensedegree, left, right)='CLASS A' => 'MA',
																																			trim(l.offenseclass, left, right)[1]='M' and trim(l.offensedegree, left, right)='CLASS B' => 'MB',
																																			trim(l.offenseclass, left, right)[1]='M' and trim(l.offensedegree, left, right)='CLASS C' => 'MC',
																																			trim(l.casetype) in ['INFRACTION']  and l.offenseclass in ['NA'] => 'I',
																																			trim(l.casetype) in ['PARKING COURT CASE','PARKING CITATION','TRAFFIC CITATION','TRAFFIC COURT CASE']  and l.offenseclass in ['NA'] => 'T',
																																			'')),
																				
																				vVendor ='W0003' and trim(l.offenseclass, left, right)='FELONY' =>'F'+trim(l.offensedegree),	
																				vVendor ='W0003' and trim(l.offenseclass, left, right)='MISDEMEANOR' =>'M'+trim(l.offensedegree),
																				vVendor ='W0003' and trim(l.offenseclass, left, right)='INFRACTION' =>'I'+trim(l.offensedegree),
																				vVendor ='W0003' and trim(l.offenseclass, left, right)='CAPIAS' =>'CAPIAS',																																			
																				
																				vVendor ='W0004' and Offense_levW0004 <>'' =>  Offense_levW0004[1..1],	
																				vVendor ='W0004' and trim(l.offenseclass, left, right)='FELONY' =>'F'+trim(l.offensedegree),	
																				vVendor ='W0004' and trim(l.offenseclass, left, right)='MISDEMEANOR' =>'M'+trim(l.offensedegree),
																				vVendor ='W0004' and trim(l.offenseclass, left, right)='CAPIAS' =>'CAPIAS',
																																								
																				l.statecode in ['VA'] => 	(map(trim(l.casetype)='FELONY' => 'F',
																																			trim(l.casetype)='INFRACTION' => 'I',
																																			trim(l.casetype)='MISDEMEANOR' => 'M',
																																			trim(l.casetype)='AV' => 'AV',
																																			trim(l.casetype)='CA' => 'CA',
																																			trim(l.casetype)='NC' => 'NC',
																																			trim(l.casetype)='RL' => 'RL',
																																			trim(l.casetype)='SC' => 'SC',	
																																			'')),
																				l.statecode in ['WI'] => 	(map(trim(l.offenseclass, left, right)[1..3]='FEL' and trim(l.offensedegree, left, right) in ['CLASS NOT KNOWN','UNCLASSIFIED'] =>'F',
																																			trim(l.offenseclass, left, right)[1..3]='FEL' and trim(l.offensedegree, left, right) = 'CLASS A' =>'FA',
																																			trim(l.offenseclass, left, right)[1..3]='FEL' and trim(l.offensedegree, left, right) = 'CLASS B' =>'FB',
																																			trim(l.offenseclass, left, right)[1..3]='FEL' and trim(l.offensedegree, left, right) = 'CLASS BC' =>'FBC',
																																			trim(l.offenseclass, left, right)[1..3]='FEL' and trim(l.offensedegree, left, right) = 'CLASS C' =>'FC',
																																			trim(l.offenseclass, left, right)[1..3]='FEL' and trim(l.offensedegree, left, right) = 'CLASS D' =>'FD',
																																			trim(l.offenseclass, left, right)[1..3]='FEL' and trim(l.offensedegree, left, right) = 'CLASS E' =>'FE',
																																			trim(l.offenseclass, left, right)[1..3]='FEL' and trim(l.offensedegree, left, right) = 'CLASS F' =>'FF',
																																			trim(l.offenseclass, left, right)[1..3]='FEL' and trim(l.offensedegree, left, right) = 'CLASS G' =>'FG',	
																																			trim(l.offenseclass, left, right)[1..3]='FEL' and trim(l.offensedegree, left, right) = 'CLASS H' =>'FH',
																																			trim(l.offenseclass, left, right)[1..3]='FEL' and trim(l.offensedegree, left, right) = 'CLASS I' =>'FI',	
																																			trim(l.offenseclass, left, right)[1]='M' and trim(l.offensedegree, left, right) = 'CLASS A' =>'MA',
																																			trim(l.offenseclass, left, right)[1]='M' and trim(l.offensedegree, left, right) = 'CLASS B' =>'MB',
																																			trim(l.offenseclass, left, right)[1]='M' and trim(l.offensedegree, left, right) = 'CLASS C' =>'MC',
																																			trim(l.offenseclass, left, right)[1]='M' and trim(l.offensedegree, left, right) in ['CLASS NOT KNOWN','UNCLASSIFIED'] =>'MU',
																																			
																																			trim(l.offensetype, left, right) IN ['CLASS A FOREFEITURE','CLASS A FORFEITURE','FORF. A'] =>'TA',                                         
																																			trim(l.offensetype, left, right) IN ['CLASS B FOREFEITURE','CLASS B FORFEITURE','FORF. B'] =>'TB',                                         
																																			trim(l.offensetype, left, right) IN ['CLASS C FOREFEITURE','CLASS C FORFEITURE','FORF. C'] =>'TC',                                         
																																			trim(l.offensetype, left, right) IN ['CLASS D FOREFEITURE','CLASS D FORFEITURE','FORF. D'] =>'TD',                                        
																																			trim(l.offensetype, left, right)='CLASS E FORFEITURE'                       =>'TE',                                                                                  
																																			trim(l.offensetype, left, right)='FELONY'                                   =>'F',                                                                           
																																			trim(l.offensetype, left, right)='FELONY (CLASS NOT KNOWN)'                 =>'FU',                                                                            
																																			trim(l.offensetype, left, right)='FELONY BC'                                =>'FBC',                                                                            
																																			trim(l.offensetype, left, right) IN ['FELONY CLASS A']                      =>'FA',                                                                                       
																																			trim(l.offensetype, left, right) IN ['FELONY CLASS B']                      =>'FB',                                                                                      
																																			trim(l.offensetype, left, right) IN ['FELONY CLASS C']                      =>'FC',                                                                                      
																																			trim(l.offensetype, left, right) IN ['FELONY CLASS D']                      =>'FD',                                                                                      
																																			trim(l.offensetype, left, right) IN ['FELONY CLASS E']                      =>'FE',                                                                                      
																																			trim(l.offensetype, left, right) IN ['FELONY CLASS F']                      =>'FF',                                                                                      
																																			trim(l.offensetype, left, right) IN ['FELONY CLASS G']                      =>'FG',                                                                                      
																																			trim(l.offensetype, left, right) IN ['FELONY CLASS H']                      =>'FH',                                                                                      
																																			trim(l.offensetype, left, right)='FELONY FIRST DEGREE'                      =>'F1',                                                                                 
																																			trim(l.offensetype, left, right)='FELONY I'                                 =>'FI',                                                                                     
																																			trim(l.offensetype, left, right) IN ['FORF. U','UNCLASSIFIED FORFEITURE']   =>'TU',                                                                                             
																																			trim(l.offensetype, left, right) IN ['FORFEITURE', 'TRAFFIC']               =>'T',                                                                                         
																																			trim(l.offensetype, left, right) IN ['MISD. A','MISDEMEANOR CLASS A']       =>'MA',                                                                                             
																																			trim(l.offensetype, left, right) IN ['MISD. B','MISDEMEANOR CLASS B']       =>'MB',                                                                                             
																																			trim(l.offensetype, left, right) IN ['MISD. C','MISDEMEANOR CLASS C']       =>'MC',                                                                                             
																																			trim(l.offensetype, left, right) IN ['MISD. U','MISDEMEANOR (CLASS NOT KNOWN)'] =>'MU',                                                                                             
																																			trim(l.offensetype, left, right) IN ['MISDEMEANOR']                         =>'M',                                                                                        
																													      			l.casetype ='CRIMINAL TRAFFIC' => 'CT',
																																			'')),	
																				l.statecode in ['WV'] => 	(map(trim(l.casetype)='FELONY' => 'F',
																																			trim(l.casetype)='INFRACTION' => 'I',
																																			trim(l.casetype)='MISDEMEANOR' => 'M',
																																			'')),																
																				trim(l.offensetype[1..1]+l.offenseclass[1..1],left,right));																	


  self.court_statute	:=	   MAP(l.ln_vendor = 'W0004' and  SatuteW0004 <> '' =>  SatuteW0004	,
	                               l.ln_vendor = 'W0004'=> l.offensecode,
	                               l.statecode = 'AR' => l.offensecode,
	                               l.statecode = 'CT' => l.offensecode,
																 l.statecode = 'FL' => l.offensecode,
																 l.statecode = 'HI' => l.offensecode,
																 l.statecode = 'IA' => l.offensecode,
																 l.statecode = 'IN' => l.offensecode,
																 l.statecode = 'MD' => l.offensecode,
																 l.statecode = 'MN' => l.offensecode,
																 l.statecode = 'NC' => MAP(regexfind('(.*, )([a-zA-Z0-9.-]+[/(a-zA-Z/)]*[(0-9)]*)$',temp_offense) => regexreplace('(.*, )([a-zA-Z0-9.-]+[/(a-zA-Z/)]*[(0-9)]*)$',temp_offense,'$2'),
                                                            regexfind('(.*, )([a-zA-Z0-9.-]+[/(a-zA-Z/)]*[(0-9)]*), OFF.*',temp_offense) => regexreplace('(.*, )([a-zA-Z0-9.-]+[/(a-zA-Z/)]*[(0-9)]*), OFF.*',temp_offense,'$2'),
                                                            ''),	
																 l.statecode = 'NM' => l.offensecode,
																 l.statecode = 'OK' => l.offensecode,
																 l.statecode = 'PA' and l.ln_vendor ='PU' => l.offensecode,
																 // l.statecode = 'RI' => l.offensecode,
																 l.statecode = 'RI' and l.ln_vendor ='RA' => l.offensecode,
																 l.statecode = 'UT' => l.offensecode,
																 l.statecode = 'VA' => l.offensecode,
																 l.statecode = 'WI' => l.offensecode,
	                                if(length(if(regexfind('[a-zA-Z0-9.]+[(a-zA-Z)]*[(0-9)]*:',temp_offense), 
											            if(regexfind('[0-9]+', regexreplace('([a-zA-Z0-9.]+[/(a-zA-Z/)]*[(0-9)]*)(.*)',temp_offense,'$1'), 0)='',
											               '',
											               regexreplace('([a-zA-Z0-9.]+[/(a-zA-Z/)]*[(0-9)]*)(.*)',temp_offense,'$1')),
											               '')) >= 2 and trim(temp_offense, left, right) not in ['1st', '2nd', '3rd', '4th'],
										              if(regexfind('[a-zA-Z0-9.]+[(a-zA-Z)]*[(0-9)]*:',temp_offense), 
											            if(regexfind('[0-9]+', regexreplace('([a-zA-Z0-9.]+[/(a-zA-Z/)]*[(0-9)]*)(.*)',temp_offense,'$1'), 0)='',
											            '',
											            regexreplace('([a-zA-Z0-9.]+[/(a-zA-Z/)]*[(0-9)]*)(.*)',temp_offense,'$1')),
											            ''), 
											            '')
																	);
	
										
  self.court_additional_statutes	:= '';
  //NC_statute_off_code             := 
  self.court_statute_desc		      := '';
  string temp_disp_date         	:= MAP(trim(l.dispositiondate, left, right)[1..2] between '19' and '20' 
												                 and length(trim(l.dispositiondate, left, right))=8 
																 and trim(l.dispositiondate, left, right)[5..6] in ['01','02','03','04','05','06','07','08','09','10','11','12']
												                 and l.dispositiondate<=stringlib.GetDateYYYYMMDD() => trim(l.dispositiondate),
											                   trim(l.dispositiondate, left, right)[1..2] between '19' and '20' 
												                 and length(trim(l.dispositiondate, left, right))=4 
												                 and l.dispositiondate[1..4]<=stringlib.GetDateYYYYMMDD()[1..4] => trim(l.dispositiondate),
											                   trim(l.finalrulingdate, left, right)[1..2] between '19' and '20' 
												                 and length(trim(l.finalrulingdate, left, right))=8 
																 and trim(l.finalrulingdate, left, right)[5..6] in ['01','02','03','04','05','06','07','08','09','10','11','12']
												                 and l.finalrulingdate<=stringlib.GetDateYYYYMMDD() => trim(l.finalrulingdate),
											                   trim(l.finalrulingdate, left, right)[1..2] between '19' and '20' 
												                 and length(trim(l.finalrulingdate, left, right))=4 
												                 and l.finalrulingdate[1..4]<=stringlib.GetDateYYYYMMDD()[1..4] => trim(l.finalrulingdate),
											                    ''); 
											
  self.court_disp_date			    := if(temp_disp_date = '' 
																		and trim(l.chargedisposeddate, left, right)[1..2] between '19' and '20' 
																		and length(trim(l.chargedisposeddate, left, right))=8 
																		and trim(l.chargedisposeddate, left, right)[5..6] in ['01','02','03','04','05','06','07','08','09','10','11','12']
																		and l.chargedisposeddate<=stringlib.GetDateYYYYMMDD(),
											              trim(l.chargedisposeddate),
																		if(temp_disp_date = '' 
																			and trim(l.chargedisposeddate, left, right)[1..2] between '19' and '20' 
																			and length(trim(l.chargedisposeddate, left, right))=4 
																			and l.chargedisposeddate[1..4]<=stringlib.GetDateYYYYMMDD()[1..4],
											                trim(l.chargedisposeddate),
												              temp_disp_date));
   

  self.court_disp_code			:= MAP( l.ln_vendor = 'W0001' and regexfind('(.*) - (.*)',temp_disp) => regexreplace('(.*) - (.*)',temp_disp,'$1'),
	                                  length(temp_disp)<= 3 => temp_disp, 
																		'');
											
	                                 //use disposition from charge table when value in offense table is null
  self.court_disp_desc_1		:= IF(temp_disp = '' and length(trim(l.chargedisposed)) >= 3 and regexfind('[A-Z]+', trim(l.chargedisposed)[1..3], 0)<>'',
											            l.ChargeDisposed,
																	If(l.ln_vendor = 'W0001' and regexfind('(.*) - (.*)',temp_disp) , regexreplace('(.*) - (.*)',temp_disp,'$2'),
																	IF(l.ln_vendor = 'W0320' , 'CONVICTED', //As per hygenics everyone in the registry is convicted.
																	If(trim(l.ln_vendor) ='TB' , //TXDPS - strip the court dispo out to match the disp lookup
																	    MAP(regexfind('(COURT DISPOSITION:[ ]*)([A-Z ]+)[ ]*[, ]+(.*)',temp_disp) =>  regexreplace('(COURT DISPOSITION:[ ]*)([A-Z ]+)[ ]*[, ]+(.*)',temp_disp,'$2'),
																					regexfind('(COURT DISPOSITION:[ ]*)([A-Z ]+)[ ]*$',temp_disp) =>  regexreplace('(COURT DISPOSITION:[ ]*)([A-Z ]+)[ ]*$',temp_disp,'$2'),
																					regexfind('(COURT[ ]*:[ ]*)([A-Z ]+)[ ]*[, ]+(.*)',temp_disp) =>  regexreplace('(COURT[ ]*:[ ]*)([A-Z ]+)[ ]*[, ]+(.*)',temp_disp,'$2'),
																					regexfind('(COURT[ ]*:[ ]*)([A-Z ]+)[ ]*$'        ,temp_disp) =>  regexreplace('(COURT[ ]*:[ ]*)([A-Z ]+)[ ]*$',temp_disp,'$2'),temp_disp),
											            if(l.statecode = 'UT' and length(temp_disp)<= 3,
												             //http://www.utcourts.gov/c_srch/instruct/dispcodes.asp - translations for codes
												              MAP(trim(temp_disp) ='A4'=>'402 AMENDED', 
																			trim(temp_disp) ='AA'=>'ABSTRACT OF AWARD',
																			trim(temp_disp) ='AB'=>'ABSTRACT OF JUDGMENT',
																			trim(temp_disp) ='AD'=>'ADMINISTRATIVE CLOSURE',
																			trim(temp_disp) ='AJ'=>'AGREED JUDGMENT',
																			trim(temp_disp) ='AM'=>'AMENDED',
																			trim(temp_disp) ='BF'=>'BAIL FORFEITURE',
																			trim(temp_disp) ='BR'=>'BANKRUPTCY',
																			trim(temp_disp) ='BR'=>'BANKRUPTCY',
																			trim(temp_disp) ='BT'=>'BENCH TRIAL',
																			trim(temp_disp) ='BO'=>'BOUND OVER DISTRICT',
																			trim(temp_disp) ='CC'=>'CASE CONSOLIDATION',
																			trim(temp_disp) ='CV'=>'CHANGE OF VENUE',
																			trim(temp_disp) ='CU'=>'CLOSED UNCOLLECTIBLE',
																			trim(temp_disp) ='CS'=>'COUNTER SUIT',
																			trim(temp_disp) ='CS'=>'CRIMINAL SENTENCE',
																			trim(temp_disp) ='CJ'=>'CUSTODY & SUPPORT JUDGMENT',
																			trim(temp_disp) ='DE'=>'DECEASED',
																			trim(temp_disp) ='DP'=>'DECLINED PROSECUTION',
																			trim(temp_disp) ='DC'=>'DEFAULT - CLERK',
																			trim(temp_disp) ='DJ'=>'DEFAULT - JUDGE',
																			trim(temp_disp) ='D'=>'DISMISSED',
																			trim(temp_disp) ='DI'=>'DISMISSED WITH PREJUDICE',
																			trim(temp_disp) ='DP'=>'DISMISSED WITH PREJUDICE',
																			trim(temp_disp) ='DW'=>'DISMISSED WITHOUT PREJUDICE',
																			trim(temp_disp) ='DV'=>'DIVERSION',
																			trim(temp_disp) ='DD'=>'DIVORCE DECREE',
																			trim(temp_disp) ='DO'=>'DOMESTIC ORDER OSC',
																			trim(temp_disp) ='JD'=>'DOMESTIC VIOLENCE JUDGMENT',
																			trim(temp_disp) ='EP'=>'EXPIRED',
																			trim(temp_disp) ='XP'=>'EXPUNGED',
																			trim(temp_disp) ='EX'=>'EXTRADITION',
																			trim(temp_disp) ='FP'=>'FINE PAID',
																			trim(temp_disp) ='FJ'=>'FOREIGN JUDGMENT',
																			trim(temp_disp) ='JF'=>'FORFEITURE JUDGMENT',
																			trim(temp_disp) ='G'=>'GUILTY',
																			trim(temp_disp) ='GB'=>'GUILTY - BENCH',
																			trim(temp_disp) ='GJ'=>'GUILTY - JURY',
																			trim(temp_disp) ='GM'=>'GUILTY - MENTAL ILL',
																			trim(temp_disp) ='IJ'=>'GUILTY INSANITY JURY',
																			trim(temp_disp) ='MJ'=>'GUILTY MENT-ILL JURY',
																			trim(temp_disp) ='GP'=>'GUILTY PLEA',
																			trim(temp_disp) ='IC'=>'INDUSTRIAL COMMISSION JUDGMENT',
																			trim(temp_disp) ='BC'=>'JUDGMENT BY CONFESSION',
																			trim(temp_disp) ='EX'=>'JUDGMENT EXPIRED',
																			trim(temp_disp) ='JE'=>'JUDGMENT EXPIRED',
																			trim(temp_disp) ='OP'=>'JUDGMENT ON PLEADING',
																			trim(temp_disp) ='CW'=>'JUDGMENT WITH COUNTER',
																			trim(temp_disp) ='CJ'=>'JUDGMENT WITH COUNTER',
																			trim(temp_disp) ='JT'=>'JURY TRIAL',
																			trim(temp_disp) ='41'=>'LACK OF PROSECUTION 4.1',
																			trim(temp_disp) ='MT'=>'MISTRIAL',
																			trim(temp_disp) ='JM'=>'MODIFICATION OF JUDGMENT',
																			trim(temp_disp) ='NT'=>'NEW TRIAL GRANTED',
																			trim(temp_disp) ='NC'=>'NO CAUSE OF ACTION',
																			trim(temp_disp) ='NO'=>'NO CAUSE OF ACTION',
																			trim(temp_disp) ='NC'=>'NO CONTEST',
																			trim(temp_disp) ='NG'=>'NOT GUILTY',
																			trim(temp_disp) ='NB'=>'NOT GUILTY - BENCH',
																			trim(temp_disp) ='NJ'=>'NOT GUILTY - JURY',
																			trim(temp_disp) ='NI'=>'NOT GUILTY -INSANITY',
																			trim(temp_disp) ='PO'=>'PARDONED',
																			trim(temp_disp) ='PS'=>'PARTIAL SATISFACTION',
																			trim(temp_disp) ='JP'=>'PATERNITY JUDGMENT',
																			trim(temp_disp) ='PA'=>'PLEA IN ABEYANCE',
																			trim(temp_disp) ='PB'=>'PLEA IN ABEYANCE DOMESTIC',
																			trim(temp_disp) ='PJ'=>'PREVIOUS JUDGMENT',
																			trim(temp_disp) ='PD'=>'PROBATE DISPOSED',
																			trim(temp_disp) ='RM'=>'REMANDED',
																			trim(temp_disp) ='RP'=>'REPLACED BY ORS',
																			trim(temp_disp) ='RJ'=>'RESTITUTION JUDGMENT',
																			trim(temp_disp) ='SA'=>'SATISFIED',
																			trim(temp_disp) ='DN'=>'SENT TO DEBT COLLECTION',
																			trim(temp_disp) ='AS'=>'SET ASIDE',
																			trim(temp_disp) ='SA'=>'SET ASIDE',
																			trim(temp_disp) ='SC'=>'SMALL CLAIM JUDGMENT',
																			trim(temp_disp) ='ST'=>'STIPULATED JUDGMENT',
																			trim(temp_disp) ='SJ'=>'SUMMARY JUDGMENT',
																			trim(temp_disp) ='SL'=>'SUPPORT LIEN JUDGMENT',
																			trim(temp_disp) ='TX'=>'TAX COMMISSION JUDGMENT',
																			trim(temp_disp) ='JJ'=>'TRANSCRIPT OF JUDGMENT',
																			trim(temp_disp) ='TR'=>'TRANSFERRED',
																			trim(temp_disp) ='TJ'=>'TRIAL JUDGMENT',
																			trim(temp_disp) ='UP'=>'UNPROSECUTED',
																			trim(temp_disp) ='UR'=>'URESA ACTION',
																			trim(temp_disp) ='VA'=>'VACATED',
																			trim(temp_disp) ='VL'=>'VOLUNTARY DISMISSAL',
																			trim(temp_disp) ='WC'=>'WAGE CLAIM JUDGMENT',
																			trim(temp_disp) ='WP'=>'WITHDRAWAL OF PLEA',
																			trim(temp_disp) ='WD'=>'WITHDRAWN',
																			trim(temp_disp) ='WI'=>'WITHDRAWN',
																			temp_disp), 
												if(length(trim(temp_disp)) >= 3, 		temp_disp,
												if(l.statecode = 'HI' and stringlib.stringfind(temp_offense, '|', 2) <> 0,
													temp_offense[stringlib.stringfind(temp_offense, '|', 1)+1..stringlib.stringfind(temp_offense, '|', 2)-1],
													'')))))));
  self.court_disp_desc_2		    := Map(l.ln_vendor = 'NF' => l.dispositionstatus,
	                                     l.trialtype);
  self.sent_date				    := MAP(l.SentenceDate <> '' => l.SentenceDate,
											// l.SentenceBeginDate <> '' and l.SentenceEndDate <> '' => 'Start Date: '+ trim(l.SentenceBeginDate) + ' End Date: '+trim(l.SentenceEndDate),
											             l.SentenceBeginDate <> '' =>/*'Start Date: '+*/ trim(l.SentenceBeginDate),
											// l.SentenceEndDate <> '' =>'End Date: '+ trim(l.SentenceEndDate),
											'');
											
	  string Maxsent    := IF(l.sentencemaxyears <> '' and regexfind('[0-9]+', l.sentencemaxyears, 0)<>'', trim(l.sentencemaxyears) + ' Years ','') +					
											   IF(l.sentencemaxmonths <> '' and regexfind('[0-9]+', l.sentencemaxmonths, 0)<>'', trim(l.sentencemaxmonths) + ' Months ','') +
											   IF(l.sentencemaxdays <> '' and regexfind('[0-9]+', l.sentencemaxdays, 0)<>'', trim(l.sentencemaxdays) + ' Days ',
											   '');
	string Minsent      := IF(l.sentenceminyears <> '' and regexfind('[0-9]+', l.sentenceminyears, 0)<>'', trim(l.sentenceminyears) + ' Years ', '') +					
											   IF(l.sentenceminmonths <> '' and regexfind('[0-9]+', l.sentenceminmonths, 0)<>'', trim(l.sentenceminmonths) + ' Months ', '') +
											   IF(l.sentencemindays <> '' and regexfind('[0-9]+', l.sentencemindays, 0)<>'', trim(l.sentencemindays) + ' Days ',
											   '');		
																	 
  self.sent_jail			:= MAP( l.ln_vendor = 'RB' => '',
	                            Maxsent <> '' and Minsent <> '' => 'Max: '+Maxsent+ ' Min: '+Minsent,
											        Maxsent <> '' => 'Max: '+Maxsent,
											        Minsent <> '' => 'Min: '+Minsent,
											       ''); 
  temp_sent_susp      := MAP(regexfind('SENTENCE SUSPENDED: ([0-9]+ YEAR)[(S)]+([0-9]+ MONTH)[(S)]+(0 DAY)[(S)]+'  , l.sentencestatus) =>  regexreplace('SENTENCE SUSPENDED: ([0-9]+ YEAR)[(S)]+([0-9]+ MONTH)[(S)]+(0 DAY)[(S)]+'  , l.sentencestatus,'$1S $2S $3S') ,
	                       '');								                                                 

  temp_sent_susp1     := regexreplace(' 0 DAYS',
	                       regexreplace(' 0 MONTHS ',
	                       regexreplace('^0 YEARS ',temp_sent_susp,''),''),'');  											
  self.sent_susp_time	:= MAP(l.ln_vendor = 'W0003' => temp_sent_susp1,
	                           regexfind('(SUSPENDED JAIL TIME:) [0-9]+ Y', l.sentencestatus) => regexreplace('(SUSPENDED JAIL TIME:)(.*)', l.sentencestatus,'$2')+'ears',
											       regexfind('(SUSPENDED JAIL TIME:) [0-9]+ M', l.sentencestatus) => regexreplace('(SUSPENDED JAIL TIME:)(.*)', l.sentencestatus,'$2')+'onths',
											       regexfind('(SUSPENDED JAIL TIME:) [0-9]+ D', l.sentencestatus) => regexreplace('(SUSPENDED JAIL TIME:)(.*)', l.sentencestatus,'$2')+'ays',
											       regexfind('SUSPENDED SENTENCE MONTHS:', l.sentenceadditionalinfo) => regexreplace('(SUSPENDED SENTENCE MONTHS:)(.*)', l.sentenceadditionalinfo,'$2')+' Months',                                                                                                                                                           
											       '');
											
  sent_court_cost			:= MAP(regexfind('[0-9]+', trim(l.CourtFee), 0)='' => '',
											       trim(l.CourtFee) ='888888.0' => '',
											       trim(l.CourtFee));
											
  sent_court_fine			:= MAP(regexfind('[0-9]+', trim(l.FineAmount), 0)='' => '',
											       trim(l.FineAmount) ='888888.0' => '',
											       trim(l.FineAmount));
											
  sent_susp_court_fine	    	   := '';
	
	SELF.sent_court_cost_orig      := sent_court_cost;
  SELF.sent_court_fine_orig      := sent_court_fine;
  SELF.sent_susp_court_fine_orig := sent_susp_court_fine;
	
	sent_court_cost_temp       := MAP(trim(sent_court_cost) in ['8888888','888888.','88888888.','888888.00','888888.88'] => '', 
                                    stringlib.stringfilterout(sent_court_cost,'$,*')
																		);
	sent_court_fine_temp       := MAP(trim(sent_court_fine) in ['8888888','888888.','88888888.','888888.00','888888.88'] => '', 
                                    stringlib.stringfilterout(sent_court_fine,'$,*')
																		);
	sent_susp_court_fine_temp  := stringlib.stringfilterout(sent_susp_court_fine,'$,*');
	sent_court_cost_1          := If(sent_court_cost_temp <> '',(string)((decimal12_2)sent_court_cost_temp *100),'');
  self.sent_court_cost       := MAP((integer)sent_court_cost_1 =0 => '',
	                                  length(trim(sent_court_cost_1)) >8 => '',
	                                  sent_court_cost_1);
																	 
	sent_court_fine_1          := If(sent_court_fine_temp <> '',(string)((decimal12_2)sent_court_fine_temp *100),'');										
  self.sent_court_fine       := MAP((integer)sent_court_fine_1 =0 => '',
	                                  length(trim(sent_court_fine_1)) >9 => '',
	                                  sent_court_fine_1);											

//	self.test                  := If(sent_court_fine_temp <> '',(string)((decimal12_2)sent_court_fine_temp *100),'');

  self.sent_susp_court_fine	 := If(sent_susp_court_fine_temp <> '',(string)((decimal12_2)sent_susp_court_fine_temp *100),'');
	
	
	  string MaxProb           := IF(l.probationmaxyears <> '' and regexfind('[0-9]+', l.probationmaxyears, 0)<>'', trim(l.probationmaxyears) + ' Years ', '') +					
											          IF(l.probationmaxmonths <> '' and regexfind('[0-9]+', l.probationmaxmonths, 0)<>'', trim(l.probationmaxmonths) + ' Months ', '') +
											          IF(l.probationmaxdays <> '' and regexfind('[0-9]+', l.probationmaxdays, 0)<>'', trim(l.probationmaxdays) + ' Days ',
											          '');
												
	  string MinProb           := IF(l.probationminyears <> '' and regexfind('[0-9]+', l.probationminyears, 0)<>'', trim(l.probationminyears) + ' Years ', '') +					
											          IF(l.probationminmonths <> '' and regexfind('[0-9]+', l.probationminmonths, 0)<>'', trim(l.probationminmonths) + ' Months ', '') +
											          IF(l.probationmindays <> '' and regexfind('[0-9]+', l.probationmindays, 0)<>'', trim(l.probationmindays) + ' Days ',
											          '');	
																	 
  self.sent_probation			   := MAP(Maxprob <> '' and Minprob <> '' => 'Max: '+Maxprob + ' Min: '+Minprob,
											              Maxprob <> '' => 'Max: '+Maxprob,
											              Minprob <> '' => 'Min: '+Minprob,
											              ''); 
											
  self.sent_addl_prov_code	     := '';                                                                                                                                      

	self.sent_addl_prov_desc_1 		 := MAP(trim(l.ln_vendor) ='I0002' and regexfind('JAIL|FINE|PRISON|PROBATION',l.casecomments) => regexreplace('(ADDITIONAL INFORMATION: )(.*)',l.casecomments,'$2'),
                                      	trim(l.ln_vendor) IN ['I0001','I0003'] => l.casestatus,
	                                      l.ln_vendor = 'RB' and Maxsent <> '' and Minsent <> '' => trim(trim(l.sentencetype) + ' Max: '+Maxsent+ ' Min: '+Minsent,left,right),
																				l.ln_vendor = 'RB' and Maxsent <> '' => trim(trim(l.sentencetype) + ' Max: '+Maxsent,left,right),
																				l.ln_vendor = 'RB' and Minsent <> '' => trim(trim(l.sentencetype) + ' Min: '+Minsent,left,right),
																				l.ln_vendor IN ['W0001'] and l.sentencestatus <> '' => trim(l.sentencestatus),
																				l.ln_vendor IN ['W0003','I0009','I0010','I0011'] and l.sentenceadditionalinfo <> '' => trim(l.sentenceadditionalinfo),
																				l.ln_vendor = 'TA' => l.sentencestatus,
																				trim(l.ln_vendor) ='I0008' =>l.sentenceadditionalinfo,
																				'');
  self.sent_addl_prov_desc_2	    := MAP(trim(l.ln_vendor) ='I0002' and regexfind('JAIL|FINE|PRISON|PROBATION',l.casecomments) => regexreplace('(ADDITIONAL INFORMATION: )(.*)',l.casecomments[41..],'$2'),
                                      	
	                                      '');
  self.sent_consec				        := MAP(trim(l.sentenceadditionalinfo) = 'CONSECUTIVE' => 'CS',
											               trim(l.sentenceadditionalinfo) = 'CONCURRENT' => 'CS',
											               '');
  self.sent_agency_rec_cust_ori	  := '';
  self.sent_agency_rec_cust		  	:= trim(l.CustodyLocation);
	
  self.appeal_date				  	    := if(regexfind('[0-9]+', trim(l.appealdate)[1..4], 0)<>'' and trim(l.appealdate)[1] in ['1','2'],
											                  trim(l.appealdate),
											                  '');
  self.appeal_off_disp			  	  := '';
  self.appeal_final_decision	  	:= '';
  
  //Fields added for CROSS
  self.offense_town					:= l.offenselocation;
  self.convict_dt					  := l.finalrulingdate;
  self.cty_conv						  := l.county;
  self.restitution					:= l.restitution;
  self.community_service		:= IF(l.CommunitySupervisionYears <> '' and regexfind('[0-9]+', l.CommunitySupervisionYears, 0)<>'', trim(l.CommunitySupervisionYears) + ' Years ','') +					
											         IF(l.CommunitySupervisionMonths <> '' and regexfind('[0-9]+', l.CommunitySupervisionMonths, 0)<>'', trim(l.CommunitySupervisionMonths) + ' Months ','') +
											         IF(l.CommunitySupervisionDays <> '' and regexfind('[0-9]+', l.CommunitySupervisionDays, 0)<>'', trim(l.CommunitySupervisionDays) + ' Days ',
											         '');
  
	string MaxParole := IF(l.ParoleMaxYears <> '' and regexfind('[0-9]+', l.ParoleMaxYears, 0)<>'', trim(l.ParoleMaxYears) + ' Years ', '') +					
											IF(l.ParoleMaxMonths <> '' and regexfind('[0-9]+', l.ParoleMaxMonths, 0)<>'', trim(l.ParoleMaxMonths) + ' Months ', '') +
											IF(l.ParoleMaxDays <> '' and regexfind('[0-9]+', l.ParoleMaxDays, 0)<>'', trim(l.ParoleMaxDays) + ' Days ',
											   '');
												
	string MinParole := IF(l.ParoleMinYears <> '' and regexfind('[0-9]+', l.ParoleMinYears, 0)<>'', trim(l.ParoleMinYears) + ' Years ', '') +					
											IF(l.ParoleMinMonths <> '' and regexfind('[0-9]+', l.ParoleMinMonths, 0)<>'', trim(l.ParoleMinMonths) + ' Months ', '') +
											IF(l.ParoleMinDays <> '' and regexfind('[0-9]+', l.ParoleMinDays, 0)<>'', trim(l.ParoleMinDays) + ' Days ',
											   '');
    
  self.parole			 := MAP(MaxParole <> '' and MinParole <> '' => 'Max: '+MaxParole + ' Min: '+MinParole,
										    	MaxParole <> '' => 'Max: '+MaxParole,
											    MinParole <> '' => 'Min: '+MinParole,
											    ''); 

  self.addl_sent_dates				:= if(trim(l.sentencedate, left, right)[1..2] between '19' and '20' and length(trim(l.sentencedate, left, right))=8 and trim(l.sentencedate, left, right)[5..6] in ['01','02','03','04','05','06','07','08','09','10','11','12'] and l.sentencedate<=stringlib.GetDateYYYYMMDD(),
											trim(l.sentencedate, left, right),
										if(trim(l.sentencedate)[1..2] between '19' and '20' and length(trim(l.sentencedate, left, right))=4 and l.sentencedate[1..4]<=stringlib.GetDateYYYYMMDD()[1..4],
											trim(l.sentencedate, left, right),
										''));
											
  self.probation_desc2				:= if(trim(l.probationbegindate, left, right)[1..2] between '19' and '20' and length(trim(l.probationbegindate, left, right))=8 and trim(l.probationbegindate, left, right)[5..6] in ['01','02','03','04','05','06','07','08','09','10','11','12'] and l.probationbegindate<=stringlib.GetDateYYYYMMDD(),
											trim(l.probationbegindate, left, right),
										if(trim(l.probationbegindate)[1..2] between '19' and '20' and length(trim(l.probationbegindate, left, right))=4 and l.probationbegindate[1..4]<=stringlib.GetDateYYYYMMDD()[1..4],
											trim(l.probationbegindate, left, right),
										''));
  
  self.court_dt		 := if(trim(l.court_dt, left, right)[1..2] between '19' and '20' and length(trim(l.court_dt, left, right))=8 and trim(l.court_dt, left, right)[5..6] in ['01','02','03','04','05','06','07','08','09','10','11','12'] and l.court_dt<=stringlib.GetDateYYYYMMDD(),
											trim(l.court_dt, left, right),
											'');
											
	get_court_county := 
              MAP(l.sourcename = 'ALASKA_ADMINISTRATOR_OF_THE_COURTS' => Trim(map( regexfind('(.*- )([A-Z ]+)(FIRST DISTRICT)',l.courtname)  => regexreplace('(.*- )([A-Z ]+)(FIRST DISTRICT)',l.courtname,'$2'),
																																									 regexfind('(.*- )([A-Z ]+)(SECOND DISTRICT)',l.courtname) => regexreplace('(.*- )([A-Z ]+)(SECOND DISTRICT)',l.courtname,'$2'),
																																									 regexfind('(.*- )([A-Z ]+)(THIRD DISTRICT)',l.courtname)	 => regexreplace('(.*- )([A-Z ]+)(THIRD DISTRICT)',l.courtname,'$2'),
																																									 regexfind('(.*- )([A-Z ]+)(FOURTH DISTRICT)',l.courtname) => regexreplace('(.*- )([A-Z ]+)(FOURTH DISTRICT)',l.courtname,'$2')																																 
																																									 ,'')),   
									l.sourcename = 'ARIZONA_ADMINISTRATOR_OF_THE_COURTS' => Trim(map(regexfind('(.*- )([A-Z -]+)(MUNI.*)',l.courtname)  => regexreplace('(.*- )([A-Z -]+)(MUNI.*)',l.courtname,'$2'),
																																									 regexfind('(.*- )([A-Z -]+)(COUNTY.*)',l.courtname)=> regexreplace('(.*- )([A-Z -]+)(COUNTY.*)',l.courtname,'$2'),
																																									 regexfind('(.*- )([A-Z -]+)(JUSTICE)',l.courtname)	=> regexreplace('(.*- )([A-Z -]+)(JUSTICE)',l.courtname,'$2'),
																																									 regexfind('(.*- )([A-Z -]+)(MAGISTRATE.*)',l.courtname) => regexreplace('(.*- )([A-Z -]+)(MAGISTRATE.*)',l.courtname,'$2')
																																									 ,'')),            
									l.sourcename = 'HAWAII_STATE_JUDICIARY   ' => Trim(regexreplace('(.*-[ ])([A-Z]+)([ ].*)',l.courtname ,('$2'))),            
									l.sourcename = 'INDIANA_ADMINISTRATOR_OF_THE_COURTS' => Trim(regexreplace('([A-Z]+)([ ].*)',l.courtname,('$1'))),            
									l.sourcename = 'MARYLAND_ADMINISTRATOR_OF_THE_COURTS' => Trim(regexreplace('(.*FOR[ ]+)([A-Z .\']+) ([A-Z]+) -(.*)',l.courtname,'$2')),            
									l.sourcename = 'MINNESOTA_DEPARTMENT_OF_PUBLIC_SAFETY' =>'',            
									l.sourcename = 'MISSOURI_ADMINISTRATOR_OF_THE_COURTS' => '',            
									l.sourcename = 'NEW_MEXICO_ADMINISTRATOR_OF_THE_COURTS' => Trim(regexreplace('([A-Z /]+) [A-Z]+',l.courtname,'$1')),            
									l.sourcename = 'NORTH_DAKOTA_ADMINISTRATOR_OF_THE_COURTS' => Trim(map(regexfind('([A-Z ]+) COUNTY.*',l.courtname) 	=> regexreplace('([A-Z ]+) COUNTY.*',l.courtname,'$1'),
																																												regexfind('([A-Z ]+) MUNICIPAL.*',l.courtname)=> regexreplace('([A-Z ]+) MUNICIPAL.*',l.courtname,'$1')																	 
																																												,'')),            
									l.sourcename = 'OREGON_ADMINISTRATOR_OF_THE_COURTS' => Trim(map(regexfind('.*- ([A-Z ]+)COUNTY.*',l.courtname)    => regexreplace('.*- ([A-Z ]+)COUNTY.*',l.courtname,'$1'),
																																									regexfind('.*- ([A-Z ]+)CO .*',l.courtname) 			=> regexreplace('.*- ([A-Z ]+)CO .*',l.courtname,'$1'),
																																									regexfind('.*- ([A-Z ]+)CIRCUIT .*',l.courtname)	=> regexreplace('.*- ([A-Z ]+)CIRCUIT .*',l.courtname,'$1'),
																																									regexfind('.*- ([A-Z ]+)DISTRICT .*',l.courtname) => regexreplace('.*- ([A-Z ]+)DISTRICT .*',l.courtname,'$1')
																																									,'')),            
									l.sourcename = 'RHODE_ISLAND_ADMINISTRATOR_OF_THE_COURTS' => '',            
									l.sourcename = 'RHODE_ISLAND_ADMINISTRATOR_OF_THE_COURTS_TRAFFIC' => '',            
									l.sourcename = 'TENNESSEE_ADMINISTRATOR_OF_THE_COURTS' => trim(regexreplace('(.*- )([A-Z]+)(,.*)',l.courtname,'$2')),            
									l.sourcename = 'TEXAS_DEPARTMENT_OF_PUBLIC_SAFETY' => '',            
									l.sourcename = 'UTAH_ADMINISTRATOR_OF_THE_COURTS' => Trim( regexreplace('(.*- )([A-Z .]+)(DISTRICT.*)',l.courtname,'$2')),   
									l.sourcename = 'VIRGINIA_ADMINISTRATOR_OF_THE_COURTS' => Trim(map(regexfind('(.*- )([A-Z ]+)(CITY[A-Z ]+-[ A-Z]+)',l.courtname) => regexreplace('(.*- )([A-Z ]+)(CITY[A-Z ]+-[ A-Z]+)',l.courtname,'$2'),																																									
																																										regexfind('(.*- )([A-Z ]+)(GENERAL DISTRICT )(-[ A-Z/]+)',l.courtname) => regexreplace('(.*- )([A-Z ]+)(GENERAL DISTRICT )(-[ A-Z/]+)',l.courtname,'$2'),			
																																										regexfind('(.*- )([A-Z /]+)(.*GENERAL DISTRICT)',l.courtname) => regexreplace('(.*- )([A-Z /]+)(.*GENERAL DISTRICT)',l.courtname,'$2'),																																									
																																										regexfind('(.*- )([A-Z /]+)(.*CIRCUIT)',l.courtname)					=> regexreplace('(.*- )([A-Z /]+)(.*CIRCUIT)',l.courtname,'$2'),																																									
																																										regexfind('(.*- )([A-Z /]+)(.*COMBINED)',l.courtname)         => regexreplace('(.*- )([A-Z /]+)(.*COMBINED)',l.courtname,'$2'),																																									
																																										regexfind('(.*- )([ A-Z]+)(CITY.*)(-[ A-Z]+)',l.courtname)    => regexreplace('(.*- )([ A-Z]+)(CITY.*)(-[ A-Z]+)',l.courtname,'$2')
																																										,'')),
																																																																																				
									l.sourcename='MINNESOTA_DEPARTMENT_OF_PUBLIC_SAFETY' => map(regexfind('([A-Z ]+)(CO DISTRICT COURT.*)',l.courtname) => regexreplace('([A-Z ]+)(CO DISTRICT COURT.*)',l.courtname,'$1'),
																																							regexfind('([A-Z ]+)(DIST COURT.*)',l.courtname)			  => regexreplace('([A-Z ]+)(DIST COURT.*)',l.courtname,'$1'),
																																							regexfind('([A-Z ]+)(COUNTY.*)',l.courtname)					  => regexreplace('([A-Z ]+)(COUNTY.*)',l.courtname,'$1'),
																																							regexfind('([A-Z ]+)(CO COURT.*)',l.courtname)   			  => regexreplace('([A-Z ]+)(CO COURT.*)',l.courtname,'$1')																								
																																							,''),
									regexfind('^COUNTY: ([A-Z]+)[ ]+$',l.caseinfo) => 	regexreplace('^COUNTY: ([A-Z]+)[ ]+$',l.caseinfo,'$1')																													
									,'');
										
											
  self.court_county					:= get_court_county;
  self.Hyg_classification_code := l.classification_code;
end;


result_common 	:= project(j_final, to_court_offenses(left));

sorted_rcommon	:= sort(result_common, off_date, court_Case_number, StringLib.StringFilter(StringLib.StringToUpperCase(court_off_desc_1+court_off_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'), 
						            court_final_plea,court_off_lev, court_statute,court_off_code,	court_disp_date, court_disp_desc_1,court_disp_desc_2,
                        sent_jail, sent_date, sent_court_cost, sent_court_fine, sent_probation, le_agency_desc, local);


												
sorted_rcommon rollupCrim(sorted_rcommon L, sorted_rcommon R) := TRANSFORM
	self.le_agency_desc				:= if(l.le_agency_desc = '', r.le_agency_desc, l.le_agency_desc);
	self.court_final_plea			:= if(l.court_final_plea = '', r.court_final_plea, l.court_final_plea);
	self.court_off_code				:= if(l.court_off_code = '', r.court_off_code, l.court_off_code);
	self.court_off_desc_1			:= if(l.court_off_desc_1 = '', r.court_off_desc_1, l.court_off_desc_1);
	self.court_off_lev      		:= if(l.court_off_lev = '', r.court_off_lev, l.court_off_lev);
	self.court_statute				:= if(l.court_statute = '', r.court_statute, l.court_statute);
	//self.court_statute_desc			:= if(l.court_statute_desc = '', r.court_statute_desc, l.court_statute_desc);
	self.sent_date 			  		:= if(l.sent_date = '', r.sent_date , l.sent_date);
	self.sent_jail  			  	:= if(l.sent_jail = '', r.sent_jail , l.sent_jail);
	self.sent_court_cost 			:= if(l.sent_court_cost = '' , r.sent_court_cost, l.sent_court_cost);
	self.sent_court_fine  		:= if(l.sent_court_fine = '' , r.sent_court_fine, l.sent_court_fine);
	self.sent_court_cost_orig	:= if(l.sent_court_cost = '' , r.sent_court_cost_orig, l.sent_court_cost_orig);
	self.sent_court_fine_orig	:= if(l.sent_court_fine = '' , r.sent_court_fine_orig, l.sent_court_fine_orig);
	self.sent_probation  			:= if(l.sent_probation = '', r.sent_probation, l.sent_probation);
	self.court_disp_desc_1  		:= if(l.court_disp_desc_1 = '', r.court_disp_desc_1, l.court_disp_desc_1);
	self.court_disp_date    		:= if(l.court_disp_date = '', r.court_disp_date, l.court_disp_date);
	SELF 							:= L; 
END;

rollupCrimOut := ROLLUP(sorted_rcommon,
                        left.offender_key = right.offender_key and 
												StringLib.StringFilter(StringLib.StringToUpperCase(left.court_off_desc_1+left.court_off_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ') = StringLib.StringFilter(StringLib.StringToUpperCase(right.court_off_desc_1+right.court_off_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ') and
												trim(left.off_date)          = trim(Right.off_date) and 	
												trim(left.court_Case_number) = trim(right.court_Case_number) and
												(left.court_final_plea   = right.court_final_plea   or  right.court_final_plea  =''	or left.court_final_plea   ='') and
												(left.court_off_lev      = right.court_off_lev      or  right.court_off_lev     =''	or left.court_off_lev      ='') and
												(left.court_statute      = right.court_statute      or  right.court_statute     =''	or left.court_statute      ='') and
												(left.court_off_code     = right.court_off_code     or  right.court_off_code    =''	or left.court_off_code     ='') and
												
												(left.court_disp_date   = right.court_disp_date   or  right.court_disp_date  =''	or left.court_disp_date   ='') and
												(left.court_disp_desc_1 =	right.court_disp_desc_1 or  right.court_disp_desc_1=''  or left.court_disp_desc_1 ='') and
												(left.court_disp_desc_2 =	right.court_disp_desc_2 or  right.court_disp_desc_2='' 	or left.court_disp_desc_2 ='') and
												(left.sent_jail 				=	right.sent_jail 		    or  right.sent_jail 		   =''	or left.sent_jail 		    ='') and	
												(left.sent_date 				=	right.sent_date 		    or  right.sent_date 		   =''	or left.sent_date 		    ='') and													
												(left.sent_court_cost 	=	right.sent_court_cost 	or  right.sent_court_cost  =''	or left.sent_court_cost 	='') and	
												(left.sent_court_fine 	=	right.sent_court_fine 	or  right.sent_court_fine  =''	or left.sent_court_fine 	='') and	
												(left.sent_probation 		=	right.sent_probation 		or  right.sent_probation 	 =''	or left.sent_probation 		='') and	
												(left.le_agency_desc 		=	right.le_agency_desc 		or  right.le_agency_desc 	 =''	or left.le_agency_desc 		='') 	
												, 
												rollupCrim(LEFT,RIGHT),local);

// output(sorted_rcommon   (offender_key ='TB10543803824862588689')); 
// output(rollupCrimOut   (offender_key ='TB10543803824862588689')); 
result_sort 	:= sort(rollupCrimOut, offender_key,vendor,state_origin,source_file,off_comp,off_delete_flag,off_date,arr_date, 
                                     le_agency_cd,le_agency_case_number,
																		 traffic_ticket_number,traffic_dl_no,traffic_dl_st,
																		 arr_off_code,arr_off_desc_1,arr_off_desc_2,arr_off_type_cd,arr_off_type_desc,arr_off_lev,arr_statute,arr_statute_desc,arr_disp_date,arr_disp_code,arr_disp_desc_1,arr_disp_desc_2,
																		 pros_refer_cd, pros_refer,pros_assgn_cd, pros_assgn,pros_chg_rej, pros_off_code, pros_off_desc_1, pros_off_desc_2,pros_off_type_cd, pros_off_type_desc,pros_off_lev, pros_act_filed, 
																		 court_case_number, court_cd,court_desc,court_appeal_flag, court_final_plea, 
																		 StringLib.StringFilter(StringLib.StringToUpperCase(court_off_code),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),	
																		 StringLib.StringFilter(StringLib.StringToUpperCase(court_off_desc_1+court_off_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),																		 
																		 court_off_type_cd, court_off_type_desc, court_off_lev, 
																		 StringLib.StringFilter(StringLib.StringToUpperCase(court_statute),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),	
																		 court_additional_statutes, court_disp_date,court_disp_code, court_disp_desc_1, court_disp_desc_2,
																		 sent_date,  sent_susp_time,sent_court_cost,sent_susp_court_fine, sent_addl_prov_code, sent_addl_prov_desc_1,
                                     sent_addl_prov_desc_2,sent_consec, sent_agency_rec_cust_ori, sent_agency_rec_cust,appeal_date,
																		 appeal_off_disp,appeal_final_decision,-num_of_counts,-sent_jail,-sent_probation,-le_agency_desc,-sent_court_fine,local);
																		 
//Pull only those records that have a vendor code assigned	
//several dups due to courtoffCode, Sentence_Jail, sent_probation	le_agency_desc,																 
result_dedup 	:= dedup(result_sort(trim(vendor, left, right)<>''), offender_key,vendor,state_origin,source_file,off_comp,off_delete_flag,off_date,arr_date, 
                                     le_agency_cd,le_agency_case_number,
																		 traffic_ticket_number,traffic_dl_no,traffic_dl_st,
																		 arr_off_code,arr_off_desc_1,arr_off_desc_2,arr_off_type_cd,arr_off_type_desc,arr_off_lev,arr_statute,arr_statute_desc,arr_disp_date,arr_disp_code,arr_disp_desc_1,arr_disp_desc_2,
																		 pros_refer_cd, pros_refer,pros_assgn_cd, pros_assgn,pros_chg_rej, pros_off_code, pros_off_desc_1, pros_off_desc_2,pros_off_type_cd, pros_off_type_desc,pros_off_lev, pros_act_filed, 
																		 court_case_number, court_cd,court_desc,court_appeal_flag, court_final_plea, 
																		 //StringLib.StringFilter(StringLib.StringToUpperCase(court_off_code),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),		
																		 StringLib.StringFilter(StringLib.StringToUpperCase(court_off_desc_1+court_off_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),																		 
																		 court_off_type_cd, court_off_type_desc, court_off_lev, 
                                     StringLib.StringFilter(StringLib.StringToUpperCase(court_statute),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),	 																		 
																		 court_additional_statutes, court_disp_date,court_disp_code, court_disp_desc_1, court_disp_desc_2,
																		 sent_date, /*sent_jail,*/ sent_susp_time,sent_court_cost,sent_susp_court_fine, sent_addl_prov_code, sent_addl_prov_desc_1,
                                     sent_addl_prov_desc_2,sent_consec, sent_agency_rec_cust_ori, sent_agency_rec_cust,appeal_date,
																		 appeal_off_disp,appeal_final_decision,local)  : persist ('~thor200_144::persist::hygenics::crim::aoc_offense');
// output(result_dedup   (offender_key ='PY100068169064275890542003CT00005120030605'));
export proc_build_court_offenses_base := result_dedup;

