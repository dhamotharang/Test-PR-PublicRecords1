import crim_common;
 
def 	:= distribute(hygenics_crim.file_in_defendant_doc(),hash(recordid,statecode));
cha 	:= distribute(hygenics_crim.file_in_charge_doc(),hash(recordid,statecode));
off 	:= distribute(hygenics_crim.file_in_offense_doc(),hash(recordid,statecode));
pri 	:= distribute(hygenics_crim.file_in_priors_doc(),hash(recordid,statecode));
sen1 	:= hygenics_crim.file_in_sentence_doc();

	 slim_sent_rec := record 
		sen1.RecordID;
		sen1.CaseID;
		sen1.StateCode;
		sen1.SentenceType;		
		sen1.SentenceDate;    	 					
		sen1.SentenceBeginDate;					
		sen1.SentenceEndDate;						
		sen1.SentenceMaxYears;
		sen1.SentenceMaxMonths;
		sen1.SentenceMaxdays;
		sen1.SentenceMinYears;
		sen1.SentenceMinMonths;
		sen1.SentenceMinDays;
		sen1.SentenceStatus;
		sen1.TimeServedYears;	
		sen1.TimeServedMonths;
		sen1.TimeServedDays;
		sen1.SentenceAdditionalInfo;		
		sen1.PublicServiceHours;
		sen1.CommunitySupervisionCounty;
		sen1.CommunitySupervisionYears;	
		sen1.CommunitySupervisionMonths;	
		sen1.CommunitySupervisionDays;
		sen1.ParoleMaxYears;
		sen1.ParoleMaxMonths;
		sen1.ParoleMaxDays;
		sen1.ParoleMinYears;
		sen1.ParoleMinMonths;
		sen1.ParoleMinDays;
		sen1.ProbationMaxYears;
		sen1.ProbationMaxMonths;
		sen1.ProbationMaxDays;
		sen1.ProbationMinYears;
		sen1.ProbationMinMonths;
		sen1.ProbationMinDays;
	 end;

slim_sen 	:= project(sen1,slim_sent_rec);
sen 		:= distribute(slim_sen,hash(recordid,statecode));

	layout_j_final := record

		string ln_vendor := '';

		//from def
		string40	RecordID;
		string8	  	DOB;
		string100	SourceName;
		string20	SourceType;
		string2		StateCode;
		string20	RecordType;
		string115	Name;
		string100	DefendantStatus;
		string		Gender;
		string      Race;
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
		// string8	SexOffenderRegistryDate;
		// string8	SexOffenderRegExpirationDate;
		// string100SexOffenderRegistryNumber;

		// from charge
		string40	CaseID						:= '';
		// string20	WarrantNumber				:= '';
		// string8	WarrantDate					:= '';
		// string200WarrantDesc					:= '';
		// string8	WarrantIssueDate			:= '';
		// string50	WarrantIssuingAgency		:= '';
		// string100WarrantStatus				:= '';
		string20	CitationNumber      		:= '';
		//string20	BookingNumber				:= '';
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
		//string10	BondAmount					:= '';
		//string50	BondType					:= '';

		// from offense
	//	string40	RecordID;
	//	string100	SourceName;
	//	string20	SourceType;
	//	string2		StateCode;
		string50	CaseNumber					:= '';
		//string100	CaseTitle					:= '';
		string20	CaseType					:= '';
		//string100	CaseStatus					:= '';
		//string8	CaseStatusDate				:= '';
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
		//string50	AppealStatus				:= '';
		//string8	AppealDate					:= '';
		string50	CourtName					:= '';
		string8   classification_code := '';
		//string10	FineAmount					:= '';
		//string10	CourtFee					:= '';
		//string10	Restitution					:= '';
		//string20	TrialType					:= '';
		//string8	CourtDate					:= '';

		// from sentence
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
		//string8	ScheduledReleaseDate		:= '';
		//string8	ActualReleaseDate			:= '';
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
		// string8	ParoleBeginDate			  	:= '';
		// string8	ParoleEndDate				:= '';
		// string8	ParoleEligibilityDate		:= '';
		// string8	ParoleHearingDate			:= '';
		string10	ParoleMaxYears				:= '';
		string10	ParoleMaxMonths				:= '';
		string10	ParoleMaxDays				:= '';
		string10	ParoleMinYears				:= '';
		string10	ParoleMinMonths				:= '';
		string10	ParoleMinDays				:= '';
		// string100ParoleStatus				:= '';
		// string50	ParoleOfficer				:= '';
		// string20	ParoleOffcerPhone			:= '';
		// string8	ProbationBeginDate			:= '';
		// string8	ProbationEndDate			:= '';
		string10	ProbationMaxYears			:= '';
		string10	ProbationMaxMonths			:= '';
		string10	ProbationMaxDays			:= '';
		string10	ProbationMinYears			:= '';
		string10	ProbationMinMonths			:= '';
		string10	ProbationMinDays			:= '';
		// string100	ProbationStatus			:= '';
		//
	end;

	layout_j_final to_j1(off r ,def l) := transform
		 self.ln_vendor 		  	:= trim(hygenics_crim._functions.fn_sourcename_to_vendor(trim(l.sourcename),l.statecode));
		 self.fileddate 		  	:= r.fileddate;
		 //self.casetitle			:= r.casetitle;
		 self.casetype			  	:= r.casetype;
		 self.casenumber		  	:= r.casenumber;
		 //self.casestatus		  	:= r.casestatus;
		 self.offensetype		  	:= r.offensetype;
		 self.offensecount	  	  	:= r.offensecount;
		 self.offensecode		  	:= r.offensecode;
		 self.offensedesc		  	:= r.offensedesc;
		 self.OffenseDate     	  	:= if(trim(r.offensedate)[1..2] between '19' and '20' 
											and r.offensedate<=stringlib.GetDateYYYYMMDD(),
											trim(r.offensedate),
											''); 
		 self.dispositiondate 		:= if(trim(r.dispositiondate)[1..2] between '19' and '20' 
											and r.dispositiondate<=stringlib.GetDateYYYYMMDD(),
											trim(r.dispositiondate),
											''); 
		 self.disposition		  	:= r.disposition;
		 self.finalrulingdate 		:= if(trim(r.finalrulingdate)[1..2] between '19' and '20' 
											and r.finalrulingdate <= stringlib.GetDateYYYYMMDD(),
											trim(r.finalrulingdate),
											''); 
															
		 self 						:= l;
		 self 						:= r;
	end;

j1 := join(off, def,
			left.statecode=right.statecode and 
			left.recordid=right.recordid, 
			to_j1(left,right),local);

	layout_j_final to_j11(pri r ,def l) := transform
		 self.ln_vendor 					:= trim(hygenics_crim._functions.fn_sourcename_to_vendor(trim(l.sourcename),l.statecode));
		 self.caseid          				:= r.CaseID; 
		 self.casenumber					:= r.casenumber;
		 self.offensedesc					:= r.offensedesc;
		 self.OffenseDate     				:= if(trim(r.offensedate)[1..2] between '19' and '20' 
													  and r.offensedate<=stringlib.GetDateYYYYMMDD(),
													  trim(r.offensedate),'');   
		 self.offensetype					:= r.offensetype;
		 self.OffenseDegree					:= r.OffenseDegree;
		 self.OffenseClass					:= r.OffenseClass;						
		 self.Disposition					:= r.Disposition;	
		 
		 self.dispositiondate   			:= if(trim(r.dispositiondate)[1..2] between '19' and '20'and r.SentenceEndDate <= stringlib.GetDateYYYYMMDD(),
													  trim(r.dispositiondate),
													  ''); 
		 self.SentenceDate      			:= if(trim(r.SentenceDate)[1..2] between '19' and '20',
													  trim(r.SentenceDate),''); 
		 self.SentenceBeginDate 			:= if(trim(r.SentenceBeginDate)[1..2] between '19' and '20',
													  trim(r.SentenceBeginDate),
													  ''); 
		 self.SentenceEndDate   			:= if(trim(r.SentenceEndDate)[1..2] between '19' and '20' ,
													  trim(r.SentenceEndDate),
													  ''); 		
		 self.SentenceType					:= trim(r.SentenceType);
		 self.SentenceMaxYears				:= r.SentenceMaxYears;
		 self.SentenceMaxMonths				:= r.SentenceMaxMonths;						
		 self.SentenceMaxDays				:= r.SentenceMaxDays;															
		 self.SentenceMinYears				:= r.SentenceMinYears;
		 self.SentenceMinMonths				:= r.SentenceMinMonths;						
		 self.SentenceMinDays				:= r.SentenceMinDays;		 
		 self.SentenceStatus    			:= r.SentenceStatus;
		 self.CommunitySupervisionCounty 	:= r.CommunitySupervisionCounty;
		 self.CommunitySupervisionYears  	:= r.CommunitySupervisionYears;
		 self.CommunitySupervisionMonths  	:= r.CommunitySupervisionMonths;
		 self.CommunitySupervisionDays  	:= r.CommunitySupervisionDays;	 
		 self 								:= l; 
		 self 								:= r;
	end;

jpriors := join(pri, def,
				left.statecode=right.statecode and 
				left.recordid=right.recordid, 
				to_j11(left,right),local);

	layout_j_final to_j2(j1 l, cha r) := transform

		self.citationnumber 	 		:= r.citationnumber;
		self.arrestdate        			:= if(trim(r.arrestdate)[1..2] between '19' and '20' 
													 and r.arrestdate<=stringlib.GetDateYYYYMMDD(),
													 trim(r.arrestdate),'');
		self.CustodyDate       			:= if(trim(r.CustodyDate)[1..2] between '19' and '20' ,
													 trim(r.CustodyDate),'');
		Self.ArrestingAgency	 		:= r.ArrestingAgency;
		Self.CustodyLocation	 		:= r.CustodyLocation;
		Self.InitialCharge		 		:= r.InitialCharge;
		Self.InitialChargeDate 			:= if(trim(r.InitialChargeDate)[1..2] between '19' and '20' 
													 and r.InitialChargeDate<=stringlib.GetDateYYYYMMDD(),
													 trim(r.InitialChargeDate),'');		 ;
		Self.InitialChargeCancelledDate	:= r.InitialChargeCancelledDate;
		Self.ChargeDisposed		 		:= r.ChargeDisposed;
		Self.ChargeDisposedDate			:= if(trim(r.chargedisposeddate)[1..2] between '19' and '20' 
													 and r.chargedisposeddate<=stringlib.GetDateYYYYMMDD(),
													 trim(r.chargedisposeddate),'');       
		Self.ChargeSeverity		 		:= r.ChargeSeverity;
		Self.ChargeDisposition 			:= r.ChargeDisposition;
		Self.AmendedCharge		 		:= r.AmendedCharge;
		Self.AmendedChargeDate 			:= r.AmendedChargeDate;
		self.bookingdate				:= r.bookingdate;
		self 							:= l;
		self 							:= r;
	end;

j2 := join(j1, cha,
			left.statecode=right.statecode and 
			left.recordid=right.recordid and 
			left.caseid=right.caseid, 
			to_j2(left,right), left outer, local);
			
		//	output(choosen(j2,25));

layout_j_final to_j3(j2 l, sen r) := transform

	self.SentenceType			:= r.SentenceType;
	self.SentenceDate      		:= if(trim(r.SentenceDate)[1..2] between '19' and '20' ,
											trim(r.SentenceDate),
											''); 
	self.SentenceBeginDate 		:= if(trim(r.SentenceBeginDate)[1..2] between '19' and '20' ,
								            trim(r.SentenceBeginDate),
											''); 
	self.SentenceEndDate   		:= if(trim(r.SentenceEndDate)[1..2] between '19' and '20' ,
								            trim(r.SentenceEndDate),
											''); 		
	self.SentenceMaxYears		:= IF(regexfind('[a-zA-Z]',r.SentenceMaxYears),'',trim(r.SentenceMaxYears));
	self.SentenceMaxMonths		:= IF(regexfind('[a-zA-Z]',r.SentenceMaxMonths),'',trim(r.SentenceMaxMonths));
	self.SentenceMaxdays		:= IF(regexfind('[a-zA-Z]',r.SentenceMaxdays),'',trim(r.SentenceMaxdays));
	self.SentenceMinYears		:= IF(regexfind('[a-zA-Z]',r.SentenceMinYears),'',trim(r.SentenceMinYears));
	self.SentenceMinMonths		:= IF(regexfind('[a-zA-Z]',r.SentenceMinMonths),'',trim(r.SentenceMinMonths));
	self.SentenceMinDays		:= IF(regexfind('[a-zA-Z]',r.SentenceMinDays),'',trim(r.SentenceMinDays));
	//self.ScheduledReleaseDate	:= '';
	//self.ActualReleaseDate			:= '';
	self.SentenceStatus					:= r.SentenceStatus;
	self.TimeServedYears				:= r.TimeServedYears;
	self.TimeServedMonths				:= r.TimeServedMonths;
	self.TimeServedDays					:= r.TimeServedDays;
	self.PublicServiceHours				:= r.PublicServiceHours;
	self.SentenceAdditionalInfo		  	:= r.SentenceAdditionalInfo;
	self.CommunitySupervisionCounty		:= r.CommunitySupervisionCounty;
	self.CommunitySupervisionYears		:= r.CommunitySupervisionYears;
	self.CommunitySupervisionMonths		:= r.CommunitySupervisionMonths;
	self.CommunitySupervisionDays	  	:= r.CommunitySupervisionDays;	
	self.ParoleMaxYears			:= r.ParoleMaxYears;
	self.ParoleMaxMonths		:= r.ParoleMaxMonths;
	self.ParoleMaxDays			:= r.ParoleMaxDays;
	self.ParoleMinYears			:= r.ParoleMinYears;
	self.ParoleMinMonths		:= r.ParoleMinMonths;
	self.ParoleMinDays			:= r.ParoleMinDays;
	self.ProbationMaxYears		:= r.ProbationMaxYears;
	self.ProbationMaxMonths		:= r.ProbationMaxMonths;
	self.ProbationMaxDays		:= r.ProbationMaxDays;
	self.ProbationMinYears		:= r.ProbationMinYears;
	self.ProbationMinMonths		:= r.ProbationMinMonths;
	self.ProbationMinDays		:= r.ProbationMinDays;
	self := l;
 end;

j3 		:= join(j2,sen, 
				left.statecode=right.statecode and 
				left.recordid=right.recordid and 
				left.caseid=right.caseid, 
				to_j3(left,right), left outer, local);

j_final := j3 + jpriors;

hygenics_crim.Layout_Common_DOC_Offenses_orig to_court_offenses(j_final l) := transform

	//-----field from charge file that were not mapped 
	// string50	Bondsman;
	// string10	BondAmount;
	// string50	BondType;
	// string20	ChargeSeverity;

	// string50	CustodyLocation;
	// string8	InitialChargeDate;  - convict date
	// string8	InitialChargeCancelledDate;
	// string8	AmendedChargeDate;
	//------ field from offense file that were not mapped 
	// string100	CaseStatus;
	// string8		CaseStatusDate;
	// string200	CaseComments;	
	// string100	CaseInfo; - mapped to cty_conv, courtname - OK
	// string100	DispositionStatus;
	// string8		DispositionStatusDate;
	// string50	  OffenseLocation;
	// string8		FinalOffenseDate;
	// string1		VictimUnder18;
	// string1		PriorOffenseFlag;
	// string8		InitialPleaDate;
	// string50	  AppealStatus;
	// string10	  Restitution;
	// string20	  TrialType;
	// string8		CourtDate;
	//-------------------------------------------------
	
	
	self.process_date		 := stringlib.getdateyyyymmdd();
	
	string temp_case_number  := MAP(stringlib.stringfind(l.casenumber,'INCORRECT',1) >0 =>'',
                                l.casenumber); 
  
	string ls_source     	 := hygenics_crim._functions.fn_shorten_sourcename(l.sourcename);																				
	
	vcase_type           	 := MAP (l.recordtype = 'CRIMINAL ADMISSION' =>'ADM',  
								l.recordtype = 'CRIMINAL RELEASE' => 'REL',    
								l.recordtype = 'CRIMINAL RESIDENT' => 'RES',
					 			'');
								
	vVendor 				 := hygenics_crim._functions.fn_sourcename_to_vendor(trim(l.sourcename),l.statecode);
	v_pty_nm                := StringLib.StringFilter(StringLib.StringToUpperCase(l.name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); 
	v_doc_num1              := StringLib.StringFilter(StringLib.StringToUpperCase(l.docnumber),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	v_inm_num1              := StringLib.StringFilter(StringLib.StringToUpperCase(l.inmatenumber),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); 
	v_stid_num1             := StringLib.StringFilter(StringLib.StringToUpperCase(l.stateidnumber),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); 
		//v_filter_list           := ['NA','UNK','NULL','R000'];
		v_doc_num               := IF(v_doc_num1  in _functions.Filterlist,'',v_doc_num1);
		v_inm_num               := IF(v_inm_num1  in _functions.Filterlist,'',v_inm_num1);
		v_stid_num              := IF(v_stid_num1 in _functions.Filterlist,'',v_stid_num1);
	self.offender_key		:= MAP(vVendor in [
																	'DA','DB','DH','DJ','DI',
																	'DP','DM','DQ','DN','SB',
																	'DS','DU','EU','DY','DV',
																	'DX','EV','WG','EW','EX',
																	'EF','WH','WK','EP','ER',
																	'ET','DF','6X','ZB','6W'] and v_doc_num <> ''  => trim(vVendor) + v_doc_num, 
																	
																vVendor in [
																	'DD','DG','WL','DD','VE',
																	'WD','EA','WC','ED','WF',
																	'EE','EG','EI','EJ','EO',
																	'EQ'] and v_inm_num <> ''	=> trim(vVendor) + v_inm_num,
																	
																vVendor in [
																	'EL','DW','6H','6Z'] and v_stid_num <> ''	=> trim(vVendor) + v_stid_num +trim(l.dob, all),
																	
																vVendor in [
																	'DR','DZ','WE','EK','ES','EM'] and v_stid_num <> ''	=> trim(vVendor) + v_stid_num,
																	
																vVendor in [
																	'DO','EB','EC','WJ','EH','EN'] => trim(vVendor) + (string)HASH64( v_pty_nm) + trim(l.gender, all) + trim(l.dob, all) + trim(l.race, all),
																
																vVendor in [
																	'DT']/*ME_DOC*/  			 => trim(vVendor) + (string)HASH64( v_pty_nm) + trim(l.gender, all) + trim(l.race, all) + trim(l.dob, all) + trim(l.courtname, all) + trim(l.docketnumber, all),
																
																vVendor in [
																	'EY']/*NH_DOC*/ 			 => trim(vVendor) + (string)HASH64( v_pty_nm) + trim(l.gender, all) + trim(l.bookingdate, all),
																//l.nametype <> 'A' and vVendor in [
																//	'DL']/*HI_DOC*/				 => vVendor + (string)HASH64( v_pty_nm)+ trim(l.dob, all)  ,																
																
																trim(l.dob, all) <> '' 			 => trim(vVendor) + (string)HASH64( v_pty_nm) +  trim(l.dob, all),
																
																trim(l.dob, all) =  '' 			 => trim(vVendor) + (string)HASH64( v_pty_nm) +  trim(l.gender, all) + trim(l.race, all),
																'');	
																//hygenics_crim._functions.fn_persistent_offender_key(vVendor, l.name, l.dob, l.docnumber, l.inmatenumber, 
																//l.stateidnumber, l.fbinumber, temp_case_number, r.fileddate, vcase_type)
																//);									
    self.vendor				 := trim(l.ln_vendor);
	self.source_file		 := trim(ls_source);
	self.offense_key		 := hygenics_crim._functions.fn_offender_key(l.ln_vendor, l.caseid, trim(temp_case_number), l.fileddate);				
	
	// Not sure if Initialchargedate or AmendedChargeDate can be mapped to offense date
	self.off_date			 := l.offensedate;

	self.arr_date			 := MAP(_functions.fn_Validate_date(l.arrestdate) <> '' => l.arrestdate, // Changed for FCRA DATE
	                          _functions.fn_Validate_date(l.bookingdate) <> '' => l.bookingdate,
																  '' );
	self.num_of_counts		 := If((integer)(l.offensecount) > 99, '',trim(l.offensecount));
	
	self.case_num            := temp_case_number;
	self.off_code            := MAP(regexfind('PRISONER|PAROLEE|DISCHARGED|PROBATIONER|ABSCONDER|ESCAPE',l.offensecode) =>'',        
	                                trim(l.offensecode)
																	);
	self.chg                 := MAP(l.statecode = 'MN' and regexfind('STATUTE: ',l.caseinfo) => l.caseinfo,
	                                '' );
	self.chg_typ_flg         := '';
	temp_off_desc            := MAP(trim(l.FinalOffense) <> '' => trim(l.FinalOffense),
	                                //trim(l.offensedesc)  <> 'NOT SPECIFIED' =>trim(l.offensedesc),
																	trim(l.offensedesc)
																 );
																 
	self.off_desc_1          := IF( length(temp_off_desc) >75, temp_off_desc[1..75],temp_off_desc);
																	
	self.off_desc_2          := trim(IF (length(temp_off_desc) >75, trim(temp_off_desc[75+1..]) ,'')+
	                            trim(MAP(trim(l.offenseclass)[1..2] ='CL' =>' Class:'+trim(l.offenseclass),
															   	''
																	)+
															MAP(trim(l.offensedegree) in ['LOW','MODERATE','HIGHEST','HIGH'] =>' Degree:'+trim(l.offensedegree),
																	l.statecode = 'TN'  and l.offensedegree <> ''=> 'Severity: '+trim(l.offensedegree),
																	''
															    ),left,right),left,right);
															
	self.add_off_cd          := '';
	self.add_off_desc        := MAP( l.statecode = 'MI' => l.offensetype,
	                                 l.statecode = 'NY' and length(l.offensetype) >5 => l.offensetype,
	                                 l.statecode = 'WA' => stringlib.stringfindreplace(trim(l.caseinfo),'MOST SERIOUS CRIME:','MostSerious:'), 
	                                 l.amendedcharge<>'' => 'Amended: ' +	trim(l.amendedcharge),
	                                 l.initialcharge<>'' => 'Initial: ' + trim(l.initialcharge),
																	 '');
	
	
	//Need to fix the off lev in NM DOC
	offensedegree := trim(l.offensedegree);
	offensetype   := trim(l.offensetype);
	offenseclass  := trim(l.offenseclass);
	statecode     := l.statecode;
	
	off_lev             := trim(MAP(
	                                //AZ 
																	statecode = 'AZ' => offenseclass[1..1],
																	//MN
																	statecode = 'MN' => offenseclass[1..1],
																	//MS
																	statecode = 'MS' => offenseclass[1..1],
																	//TN
																	statecode = 'TN' and regexfind('(F)(ELONY )([A-Z])',offenseclass ) => regexreplace('(F)(ELONY )([A-Z])',offenseclass,'$1$3' ),
																	statecode = 'TN' and offenseclass ='FELONY' => 'F',
																	
	                                statecode = 'MI' => offenseclass[1..1],
                                  //Based on the NY website
																	statecode ='NY'  and offenseclass in ['A1','A2','A3','B','C','D','E'] => 'F'+offenseclass,
																	statecode ='NY'  and offenseclass in ['FELONY'] and offensedegree ='UNSPECIFIED'=> 'FU',
																	statecode ='NY'  and offenseclass in ['FELONY'] => 'F'+offensedegree,
																	offensedegree ='CAPITAL FELONY' => 'FCA',
															    offensedegree ='COMPACT FELONY' => 'FCO',
																	offensedegree ='COMPACT MISDEMEANOR' => 'MCO',
																	offensedegree ='INFRACTION' => 'I',

																	l.sourcename ='OHIO_DEPARTMENT_OF_CORRECTIONS_WEBSITE' => trim(offenseclass[1..1]+trim(offensedegree),left,right),
																	//IA
																	trim(offenseclass) = 'SERIOUS MISDEMEANOR' =>'MSE',
																	trim(offenseclass) = 'SIMPLE MISDEMEANOR'  =>'MSI',
                                  regexfind('AGGRAVATED MISD',offenseclass)  =>'AM',
																	regexfind('AGGRAVATED FEL',offenseclass)   =>'AF',

																	//NM
                                  regexfind('PETTY MISD',offensetype)        =>'PM',                                                                                   
                                  trim(offensetype) ='COMPACT'               =>'CM',
																	trim(offensetype) ='SPECIAL PENALTY FELONY' =>'SPF', 
                                  trim(offensedegree)+trim(offensetype)+trim(offensedegree) IN ['NULL','UNKNOWN','OTHER','XX','X','U','OTHR'] => '',
																	
																	//AZ - has been fixed by HD
	                                //trim(offenseclass)[1..2] ='CL' and trim(offensetype) ='' =>'',
																	//NM
																	regexfind('([0-9])(ST|RD|TH|ND)[ ](DEG)[ ](CA)(PITAL)[ ](.*)',offensetype) => regexreplace('([0-9])(ST|RD|TH|ND)[ ](DEG)[ ](CA)(PITAL)[ ](.*)',offensetype,'$4$1'),       
																	regexfind('([0-9])(ST|RD|TH|ND)[ ](DEG)[ ](F)(EL[ONY]*)[ ](.*)',offensetype) => regexreplace('([0-9])(ST|RD|TH|ND)[ ](DEG)[ ](F)(EL[ONY]*)[ ](.*)',offensetype,'$4$1'),       
																	regexfind('([0-9])(ST|RD|TH|ND)[ ](DEG)[ ](M)(IS[DEMEANOR]*)[ ](.*)',offensetype) => regexreplace('([0-9])(ST|RD|TH|ND)[ ](DEG)[ ](M)(IS[DEMEANOR]*)[ ](.*)',offensetype,'$4$1'),       
																	regexfind('([0-9])(ST|RD|TH|ND)[ ](DEG)[ ](F)(EL[ONY]*)',offensetype) => regexreplace('([0-9])(ST|RD|TH|ND)[ ](DEG)[ ](F)(EL[ONY]*)',offensetype,'$4$1'),       
																	regexfind('([0-9])(ST|RD|TH|ND)[ ](DEG)[ ](M)(IS[DEMEANOR]*)',offensetype) => regexreplace('([0-9])(ST|RD|TH|ND)[ ](DEG)[ ](M)(IS[DEMEANOR]*)',offensetype,'$4$1'),       
																	
																	//NE
																	vVendor =  'EX' and regexfind('FEL',offenseclass) => 'F',
																	vVendor =  'EX' and regexfind('MISD',offenseclass) => 'M',
																	
																	regexfind('(F)(EL)[ ]([A-Z])',offensetype) => regexreplace('(F)(EL)[ ]([A-Z])',offensetype,'$1$3'),       
																	regexfind('(M)(SD)[ ]([A-Z])',offensetype) => regexreplace('(M)(SD)[ ]([A-Z])',offensetype,'$1$3'),       
																	
																	//NC
																	regexfind('(F)(ELON[Y]*)[ ](CLASS)[ ]([0-9])',trim(offensetype)+' '+trim(offenseclass))  => regexreplace('(F)(ELON[Y]*)[ ](CLASS)[ ]([0-9])',trim(offensetype)+' '+trim(offenseclass),'$1$4'),       
																	regexfind('(M)(ISD[.EMEANOR]*])[ ](CLASS)[ ]([0-9])',trim(offensetype)+' '+trim(offenseclass)) => regexreplace('(M)(ISD[.EMEANOR]*])[ ](CLASS)[ ]([0-9])',trim(offensetype)+' '+trim(offenseclass),'$1$4'),   
																	
																	regexfind('(F)(ELON[Y]*)[ ](CLASS)[ ]([A-Z][0-9]*)[ ]([A-Z ]*)',trim(offensetype)+' '+trim(offenseclass))      => regexreplace('(F)(ELON[Y]*)[ ](CLASS)[ ]([A-Z][0-9]*)[ ]([A-Z ]*)',trim(offensetype)+' '+trim(offenseclass),'$1$4'),       
																	regexfind('(M)(ISD[.EMEANOR]*)[ ](CLASS)[ ]([A-Z][0-9]*)[ ]([A-Z ]*)',trim(offensetype)+' '+trim(offenseclass)) => regexreplace('(M)(ISD[.EMEANOR]*)[ ](CLASS)[ ]([A-Z][0-9]*)[ ]([A-Z ]*)',trim(offensetype)+' '+trim(offenseclass),'$1$4'), 																	
																	
																	regexfind('(F)(ELON[Y]*)[ ](CLASS)[ ]([A-Z][0-9]*)',trim(offensetype)+' '+trim(offenseclass))      => regexreplace('(F)(ELON[Y]*)[ ](CLASS)[ ]([A-Z][0-9]*)',trim(offensetype)+' '+trim(offenseclass),'$1$4'),       
																	regexfind('(M)(ISD[.EMEANOR]*)[ ](CLASS)[ ]([A-Z][0-9]*)',trim(offensetype)+' '+trim(offenseclass)) => regexreplace('(M)(ISD[.EMEANOR]*)[ ](CLASS)[ ]([A-Z][0-9]*)',trim(offensetype)+' '+trim(offenseclass),'$1$4'), 																	
																	
																 
																	regexfind('(F)(ELON[Y]*)[ ](NON CLASS CODE)',trim(offensetype)+' '+trim(offenseclass))      => regexreplace('(F)(ELON[Y]*)[ ](NON CLASS CODE)',trim(offensetype)+' '+trim(offenseclass),'$1$4'),       
																	regexfind('(M)(ISD[.EMEANOR]*)[ ](NON CLASS CODE)',trim(offensetype)+' '+trim(offenseclass)) => regexreplace('(M)(ISD[.EMEANOR]*)[ ](NON CLASS CODE)',trim(offensetype)+' '+trim(offenseclass),'$1$4'), 																	
																	
																	statecode ='NC'  and regexfind('CLASS',trim(offenseclass),0) ='' and
																	regexfind('^MISD|MSD|MISDE',offensetype) => 'M', 
																	
																	statecode ='NC'  and regexfind('CLASS',trim(offenseclass),0) ='' and
																	regexfind('^FEL|FELONY',offensetype) => 'F', 
																	
																	// OK DOC
																	vVendor =  'EF'  and trim(offenseclass) <> '' and regexfind('LOW',trim(offensedegree),0) <>''  => offenseclass[1..1]+'LOW', 
																	
																	vVendor =  'EF'  and trim(offenseclass) <> '' and regexfind('MODERATE',trim(offensedegree),0) <>'' => offenseclass[1..1]+'MOD',
																	
																	vVendor =  'EF'  and trim(offenseclass) <> '' and regexfind('HIGHEST',trim(offensedegree),0) <> '' => offenseclass[1..1]+'HST',
																	
																	vVendor =  'EF'  and trim(offenseclass) <> '' and regexfind('HIGH',trim(offensedegree),0) <> '' => offenseclass[1..1]+'HIG',
																	
																	
																	//IL OR NC etc
																	regexfind('(CLASS)[ ]([A-Z][0-9]*)[ ](F)(ELONY)',offenseclass)      => regexreplace('(CLASS)[ ]([A-Z][0-9]*)[ ](F)(ELONY)',offenseclass,'$3$2'),       
																	regexfind('(CLASS)[ ]([A-Z][0-9]*)[ ](M)(ISDEMEANOR)',offenseclass) => regexreplace('(CLASS)[ ]([A-Z][0-9]*)[ ](M)(ISDEMEANOR)',offenseclass,'$3$2'),   
																	
																	regexfind('(CLASS)[ ]([0-9])[ ](F)(ELONY)',offenseclass)      => regexreplace('(CLASS)[ ]([0-9])[ ](F)(ELONY)',offenseclass,'$3$2'),       
																	regexfind('(CLASS)[ ]([0-9])[ ](M)(ISDEMEANOR)',offenseclass) => regexreplace('(CLASS)[ ]([0-9])[ ](M)(ISDEMEANOR)',offenseclass,'$3$2'),   
																	
                        					regexfind('(CLASS)[ ]([A-Z])[ ](F)(ELONY)',offensedegree)      => regexreplace('(CLASS)[ ]([A-Z])[ ](F)(ELONY)',offensedegree,'$3$2'),       
                                  regexfind('(CLASS)[ ]([A-Z])[ ](M)(ISDEMEANOR)',offensedegree) => regexreplace('(CLASS)[ ]([A-Z])[ ](M)(ISDEMEANOR)',offensedegree,'$3$2'),   
																	
																	regexfind('^([A-Z])[ ](F)(ELONY)',offenseclass)      => regexreplace('^([A-Z])[ ](F)(ELONY)',offenseclass,'$2$1'),       
                                  regexfind('^([A-Z])[ ](M)(ISDEMEANOR)',offenseclass) => regexreplace('^([A-Z])[ ](M)(ISDEMEANOR)',offenseclass,'$2$1'),   
							                   
																 	regexfind('UNCL[A]*SS[IFIED]* FELONY',offenseclass)  => 'F',       
                                  regexfind('UNCL[A]*SS[IFIED]* MISDEME',offenseclass) => 'M',   
							                           

																  //OR
																	//statecode ='OR' =>   offenseclass,
																	regexfind('(CLASS)[ ]([A-Z][0-9]*)[ ](F)(ELONY)',trim(offensedegree)+' '+offenseclass)      => regexreplace('(CLASS)[ ]([A-Z][0-9]*)[ ](F)(ELONY)',trim(offensedegree)+' '+offenseclass,'$3$2'),       
																	regexfind('(CLASS)[ ]([A-Z][0-9]*)[ ](M)(ISDEMEANOR)',trim(offensedegree)+' '+offenseclass) => regexreplace('(CLASS)[ ]([A-Z][0-9]*)[ ](M)(ISDEMEANOR)',trim(offensedegree)+' '+offenseclass,'$3$2'),   
																	
																	regexfind('(CLASS)[ ]([0-9])[ ](F)(ELONY)',trim(offensedegree)+' '+offenseclass)       => regexreplace('(CLASS)[ ]([0-9])[ ](F)(ELONY)',trim(offensedegree)+' '+offenseclass,'$3$2'),       
																	regexfind('(CLASS)[ ]([0-9])[ ](M)(ISDEMEANOR)',trim(offensedegree)+' '+offenseclass) => regexreplace('(CLASS)[ ]([0-9])[ ](M)(ISDEMEANOR)',trim(offensedegree)+' '+offenseclass,'$3$2'),   
																	
                        					regexfind('(CLASS)[ ]([A-Z])[ ](F)(ELONY)',trim(offensedegree)+' '+offenseclass)      => regexreplace('(CLASS)[ ]([A-Z])[ ](F)(ELONY)',trim(offensedegree)+' '+offenseclass,'$3$2'),       
                                  regexfind('(CLASS)[ ]([A-Z])[ ](M)(ISDEMEANOR)',trim(offensedegree)+' '+offenseclass) => regexreplace('(CLASS)[ ]([A-Z])[ ](M)(ISDEMEANOR)',trim(offensedegree)+' '+offenseclass,'$3$2'),   
												
																 	regexfind('UNCL[A]*SS[IFIED]* FELONY',trim(offensedegree)+' '+offenseclass)  => 'F',       
                                  regexfind('UNCL[A]*SS[IFIED]* MISDEME',trim(offensedegree)+' '+offenseclass) => 'M',
																	
																	regexfind('PRE-STRUCTURE FELONY',trim(offensedegree)+' '+offenseclass)  => 'F',       
                    							regexfind('PRE-STRUCTURE MISDEMEANOR',trim(offensedegree)+' '+offenseclass) => 'M',         
																	regexfind('PREFAIR FELONY',trim(offensedegree)+' '+offenseclass)  => 'F',               
																	regexfind('PREFAIR MISDEMEANOR',trim(offensedegree)+' '+offenseclass) => 'M',  

																  regexfind('(.*)[ ](M)(ISDEMEANOR)',offenseclass) => regexreplace('(.*)(M)(ISDEMEANOR)',offenseclass,'$2'),   
							                    regexfind('(.*)[ ](M)(ISDEMEAN)',offenseclass) => regexreplace('(.*)(M)(ISDEMEAN)',offenseclass,'$2'),   
											            regexfind('(.*)[ ](F)(ELONY)',offenseclass)  => regexreplace('(.*)(F)(ELONY)',offenseclass,'$2'), 
													        regexfind('^(F)(ELONY)[ ](.*)',offenseclass) => regexreplace('^(F)(ELONY)[ ](.*)',offenseclass,'$1'),  
													        regexfind('^(M)(ISDEMEANOR)[ ](.*)',offenseclass) => regexreplace('^(M)(ISDEMEANOR)[ ](.*)',offenseclass,'$1'),  
																	trim(offensedegree) = 'THIRD DEGREE FELONY' => 'F3' ,
				                          trim(offensedegree) = 'FIRST DEGREE FELONY' => 'F1' ,
				                          trim(offensedegree) = 'SECOND DEGREE FELONY' => 'F2' ,
				                          trim(offensedegree) = 'COMPACT FELONY' => 'FCO' ,
	                                statecode in ['AZ'] and trim(offenseclass) = 'FELONY/MISDEMEANOR' =>'FM',
	                                //statecode in ['AZ'] =>offenseclass[1..1],
															    statecode in ['AK', 'AR'] and trim(offensetype) = 'PROBATION REVOCATION' => '',  
	                                statecode in ['AK', 'AR'] => offenseclass[1..1]+OffenseDegree[1..1],
																	regexfind('^FELONY',offensedegree) => 'F',  
													        regexfind('^MISDEMEANOR',offensedegree) => 'M',  		
																	regexfind('^FEL|FELONY',offensedegree) => 'F',  
													        regexfind('^MISD|MSD|MISDE',offensedegree) => 'M',  
																	regexfind('^FEL|FELONY',offenseclass) => 'F',  
													        regexfind('^MISD|MSD|MISDE',offenseclass) => 'M',  
																	regexfind('^FEL|FELONY',offensetype) and trim(offenseclass) in ['UNSPECIFIED']=> 'F',
																	regexfind('^FEL|FELONY',offensetype)     => 'F'+offenseclass,  
													        regexfind('^MISD|MSD|MISDE',offensetype) and trim(offenseclass) in ['UNSPECIFIED'] => 'M',
																	regexfind('^MISD|MSD|MISDE',offensetype) => 'M'+offenseclass,
																	length(trim(offensetype)) =2 => trim(offensetype),	
																	length(trim(offensetype)) =1 =>  offensetype[1..1]+offenseclass[1..1],
																	length(trim(offenseclass)) <= 2 => trim(offenseclass),
																	length(trim(offensedegree)) <= 2 => trim(offensedegree),
																	//l.statecode = 'MI' and offensetype[1..8] = 'HABITUAL' =>'',
															    //offensetype[1..1]+offenseclass[1..1]
																	''
															   ),left,right);
	self.off_typ             := map(trim(l.ln_vendor) ='EB' and off_lev ='CM' => '',
	                                trim(l.ln_vendor) ='EF' => off_lev[1..1],
																	trim(l.ln_vendor) IN ['EV','WG','EG'] and off_lev[1..1] in ['M','F'] => off_lev[1..1],
																	off_lev in ['FIFTH','FOURTH','SECOND','FIRST'] => '',
	                                stringlib.stringfind(off_lev,'F',1)>0 => 'F',
	                                stringlib.stringfind(off_lev,'M',1)>0 => 'M',
																	off_lev = 'I' => 'I',
																	regexfind('^MISD[./) ]*$',temp_off_desc) => 'M',
																	((stringlib.stringfind(temp_off_desc,'FELONY',1) >0  or stringlib.stringfind(temp_off_desc,'FELONIOUS',1) >0) and 
																	  stringlib.stringfind(temp_off_desc,'FELONY OR MISDEMEANORS',1) =0 and temp_off_desc not in ['CRIME IS NO LONGER A FELONY']) and 
																		regexfind('FAILURE TO APPEAR|ACCESSORY TO FELONY|CONSPIRACY|SOLICITATION TO COMMIT FELONY',temp_off_desc,0) = '' =>'F',	
																	'');
	self.off_lev             := Map(off_lev <> '' => off_lev,
	                                regexfind('^MISD[./) ]*$',temp_off_desc) => 'M',
																	((stringlib.stringfind(temp_off_desc,'FELONY',1) >0  or stringlib.stringfind(temp_off_desc,'FELONIOUS',1) >0) and 
																	  stringlib.stringfind(temp_off_desc,'FELONY OR MISDEMEANORS',1) =0 and temp_off_desc not in ['CRIME IS NO LONGER A FELONY']) and 
																		regexfind('FAILURE TO APPEAR|ACCESSORY TO FELONY|CONSPIRACY|SOLICITATION TO COMMIT FELONY',temp_off_desc,0) = '' =>'F',
                          					
																	 '');
	                                // map(off_lev = 'I' => 'I',
																	// off_lev[1..1] IN ['M','F'] => off_lev[2..],
																	// length(off_lev)=3 => stringlib.StringFilterOut(off_lev,'MF'),
																	// off_lev);
	self.arr_disp_date       := if(trim(l.chargedisposeddate)[1..2] between '19' and '20' 
								                 and l.chargedisposeddate<=stringlib.GetDateYYYYMMDD(),
								                 trim(l.chargedisposeddate),'');
	self.arr_disp_cd         := '';
	self.arr_disp_desc_1     := trim(l.chargedisposed);
	self.arr_disp_desc_2     := '';
	self.arr_disp_desc_3     := '';
	self.court_cd            := '';
	self.court_desc          := MAP(l.courtname <> '' => trim(stringlib.stringtouppercase(l.courtname)),
	                                regexfind('ISSUING AGENCY:',l.caseinfo) => trim(l.caseinfo),
	                                '');
	self.ct_dist             := '';
	self.ct_fnl_plea_cd      := '';
	self.ct_fnl_plea         := l.InitialPlea;
	self.ct_off_code         := '';
	self.ct_chg              := '';
	self.ct_chg_typ_flg      := '';
	self.ct_off_desc_1       := '';
	self.ct_off_desc_2       := '';
	self.ct_addl_desc_cd     := '';
	self.ct_off_lev          := '';
	string temp_disp_date    := MAP(trim(l.dispositiondate) <> '*' and trim(l.dispositiondate) <> '' =>trim(l.dispositiondate),
	                                     //trim(l.finalrulingdate)<> '' => trim(l.finalrulingdate),
																			 ''
	                                    ); 															
	self.ct_disp_dt          := IF(temp_disp_date ='', l.ChargeDisposedDate,temp_disp_date);;
	self.ct_disp_cd          := '';
	NC_disp1                 := MAP(regexfind('(COMPONENT DISPO 1: )(.*)(, )(COMPONENT DISPO 2: )(.*)',trim(l.disposition)) => regexreplace('(COMPONENT DISPO 1: )(.*)(, )(COMPONENT DISPO 2: )(.*)',trim(l.disposition),'$2'),
	                                regexfind('(COMPONENT DISPO 1: )(.*)',trim(l.disposition)) => regexreplace('(COMPONENT DISPO 1: )(.*)',trim(l.disposition),'$2'),
	                                '');
  NC_disp2                 := MAP(regexfind('(COMPONENT DISPO 1: )(.*)(, )(COMPONENT DISPO 2: )(.*)',trim(l.disposition)) => regexreplace('(COMPONENT DISPO 1: )(.*)(, )(COMPONENT DISPO 2: )(.*)',trim(l.disposition),'$5'),
	                                regexfind('(COMPONENT DISPO 2: )(.*)',trim(l.disposition)) => regexreplace('(COMPONENT DISPO 2: )(.*)',trim(l.disposition),'$2'),
	                                '');																	
	string temp_disp         := MAP (NC_disp1 <> '' AND NC_disp2 <> '' AND NC_disp1 = NC_disp2 => TRIM(NC_disp1),
	                                 NC_disp1 <> '' AND NC_disp2 <> '' AND NC_disp1 <> NC_disp2 => TRIM(NC_disp1) + ', ' + TRIM(NC_disp2),
																	 NC_disp1 <> '' => TRIM(NC_disp1),
																	 NC_disp2 <> '' => TRIM(NC_disp2),
	                                 trim(l.disposition) <> '*' and trim(l.disposition) <> '' => trim(l.disposition),
	                                 trim(l.finalruling) <> '' => trim(l.finalruling),
	                                 ''); 
	                            //use disposition from charge table when value in offense table is null
  self.ct_disp_desc_1      := IF(temp_disp ='', l.ChargeDisposed,temp_disp);
	 
	self.ct_disp_desc_2    := '';
	self.cty_conv_cd       := MAP(regexfind('PARISH CONVICTED:',l.casecomments) => trim(regexreplace('(.*)(PARISH CONVICTED: )([a-zA-Z]+)(; )(.*)',l.casecomments,'$3'),left,right),
                               	'');
	self.cty_conv          := MAP(l.statecode ='MN' and 
	                              regexfind('(.*) (SENTENCE COUNTY: )([a-zA-Z]+[a-zA-Z ]*)$',l.sentenceadditionalinfo) => trim(regexreplace('(.*) (SENTENCE COUNTY: )([a-zA-Z.]+[a-zA-Z. ]*)$',l.sentenceadditionalinfo,'$3'),left,right),
																
																regexfind('SENTENCING COUNTY:',l.sentencestatus) =>  trim(regexreplace('(SENTENCING COUNTY:)(.*)',l.sentencestatus,'$2'),left,right),
															  regexfind('COUNTY [a-zA-Z ]*:',l.caseinfo) => trim(regexreplace('(COUNTY [a-zA-Z ]*: )(.*)',l.caseinfo,'$2'),left,right),
																regexfind('([a-zA-Z ]*COUNTY: )([a-zA-Z]+[\'a-zA-Z. ]*)(,.*)',l.sentenceadditionalinfo) => trim(regexreplace('([a-zA-Z ]*COUNTY: )([a-zA-Z]+[\'a-zA-Z. ]*)(,.*)',l.sentenceadditionalinfo,'$2'),left,right) ,
																regexfind('([a-zA-Z ]*COUNTY: )([a-zA-Z]+[\'a-zA-Z. ]*)(;.*)',l.sentenceadditionalinfo) => trim(regexreplace('([a-zA-Z ]*COUNTY: )([a-zA-Z]+[\'a-zA-Z. ]*)(;.*)',l.sentenceadditionalinfo,'$2'),left,right) ,
 															  regexfind('([a-zA-Z ]*COUNTY: )([a-zA-Z]+[\'a-zA-Z. ]*)$',l.sentenceadditionalinfo) => trim(regexreplace('([a-zA-Z ]*COUNTY: )([a-zA-Z]+[\'a-zA-Z. ]*)$',l.sentenceadditionalinfo,'$2'),left,right) ,
																regexfind('(.*) (SENTENCE COUNTY: )([a-zA-Z]+[a-zA-Z ]*)$',l.sentenceadditionalinfo)=> trim(regexreplace('(.*) (SENTENCE COUNTY: )([a-zA-Z]+[a-zA-Z. ]*)$',l.sentenceadditionalinfo,'$3'),left,right),    
	                              regexfind('COUNTY [a-zA-Z ]*:',l.sentenceadditionalinfo) => trim(regexreplace('(COUNTY [a-zA-Z. ]*:)(.*)',l.sentenceadditionalinfo,'$2'),left,right) ,
																regexfind('SENTENCING AGENCY:',l.sentenceadditionalinfo) => trim(regexreplace('(SENTENCING AGENCY:)(.*)',l.sentenceadditionalinfo,'$2'),left,right) ,
																regexfind('COUNTY OF CONVICTION:',l.casecomments) => trim(regexreplace('(COUNTY OF CONVICTION: )([a-zA-Z.]+)',l.casecomments,'$2'),left,right),
																regexfind('PROSECUTION JURISDICTION: ',l.casecomments) => trim(regexreplace('COUNTY',regexreplace('(PROSECUTION JURISDICTION: )([a-zA-Z.]+)',l.casecomments,'$2'),''),left,right),
																regexfind('JURISDICTION: ',l.casecomments) => trim(regexreplace('COUNTY',regexreplace('(JURISDICTION: )([a-zA-Z.]+)',l.casecomments,'$2'),''),left,right),
																regexfind('(.*) (COMMITTING COUNTY: )([a-zA-Z]+[a-zA-Z ]*);(.*)',l.defendantadditionalinfo) => trim(regexreplace('(.*) (COMMITTING COUNTY: )([a-zA-Z]+[a-zA-Z. ]*);(.*)',l.defendantadditionalinfo,'$3'),left,right),
																regexfind('(.*)[ ](COUNTY: )(.*)',l.offenselocation) => regexreplace('(.*)[ ](COUNTY: )(.*)',l.offenselocation,'$3'),
																regexfind('(COUNTY COMMITTED: )(.*)',l.offenselocation) => regexreplace('(COUNTY COMMITTED: )(.*)',l.offenselocation,'$2'),
																regexfind('(COUNTY CONVICTED: )(.*)',l.offenselocation) => regexreplace('(COUNTY CONVICTED: )(.*)',l.offenselocation,'$2'), 
																
																l.statecode ='AR' => l.arrestingagency,
																//l.offenselocation <> '' => trim(l.offenselocation),
	                              '');
     

	self.adj_wthd          := '';
	self.stc_dt            := MAP(_functions.fn_Validate_date(l.SentenceDate) <> '' => l.SentenceDate,	                                
																  '' );
	self.stc_cd            := '';
	self.stc_comp          := '';
	
	string temp_senttype   := MAP(regexfind('LIFE',l.sentencetype) => l.sentencetype,
	                              regexfind('LFE',l.sentencetype) => 'LIFE',
	                              regexfind('DEATH',l.sentencetype) => l.sentencetype,
																regexfind('DTH',l.sentencetype) => 'DEATH',
																'');
																
	self.stc_desc_1        := MAP(l.statecode ='MT' => l.sentencetype,
	                              temp_senttype = '' and l.sentencetype <> '' => 'Sentence Type : '+ l.sentencetype,
															 ''); //needed for MT check for other sources	                          
	self.stc_desc_2        := MAP(
	                              /*l.SentenceBeginDate <> '' and l.SentenceEndDate <> '' =>'Sent Start Date: '+ l.SentenceBeginDate + ' Sent End Date: '+l.SentenceEndDate,
														 		l.SentenceBeginDate <> ''  =>'Sent Start Date: '+ l.SentenceBeginDate ,
																l.SentenceEndDate   <> ''  =>'Sent End Date: '+l.SentenceEndDate ,
																'');*/
																
																_functions.fn_Validate_date(l.SentenceBeginDate) <> '' and _functions.fn_Validate_date(l.SentenceEndDate) <> '' =>'Sent Start Date: '+ l.SentenceBeginDate + ' Sent End Date: '+l.SentenceEndDate,
														 		_functions.fn_Validate_date(l.SentenceBeginDate) <> ''  =>'Sent Start Date: '+ l.SentenceBeginDate ,
																_functions.fn_Validate_date(l.SentenceEndDate) <> ''  =>'Sent End Date: '+l.SentenceEndDate ,
																'');
																
	string tempstc_desc3   := IF(l.communitysupervisionyears  <> ''	,trim(l.communitysupervisionyears) + 'Years ','') +					
	                          IF(l.communitysupervisionmonths <> ''	,trim(l.communitysupervisionmonths) + 'Months ','') +
														IF(l.communitysupervisiondays   <> ''	,trim(l.communitysupervisiondays) + 'Days ','');
														
														

  self.stc_desc_3        := MAP (tempstc_desc3 <> '' => 'Community Supervision: '+tempstc_desc3,
	                               l.publicservicehours <> '' => 'Public Service: '+l.publicservicehours,
	                               '');
	
	self.stc_desc_4        := MAP(l.statecode ='KY' => trim(l.sentencestatus),
	                              l.ln_vendor 'I0046' =  l.sentencetype,
	                              //l.institutionname <> '' and trim(l.institutionname) <> 'UNKNOWN'  => 'Institution Name: '+trim(l.institutionname) + trim(l.institutiondetails),
														    '');
																	
	string temp_tmeservedN := IF(l.timeservedyears  <> ''	,INTFORMAT((integer)trim(l.timeservedyears),3,1) ,'') +					
	                          IF(l.timeservedmonths <> ''	,INTFORMAT((integer)trim(l.timeservedmonths),3,1),'') +
														IF(l.timeserveddays   <> ''	,INTFORMAT((integer)trim(l.timeserveddays),3,1),'');
														
	string temp_timeserve1 := IF(l.timeservedyears  <> ''	,trim(l.timeservedyears) + 'Years ','') +					
	                          IF(l.timeservedmonths <> ''	,trim(l.timeservedmonths) + 'Months ','') +
														IF(l.timeserveddays   <> ''	,trim(l.timeserveddays) + 'Days ','');
	                                                                                                           
													
  String Jail_time        := MAP(regexfind('(JAIL TIME: )([0-9A-Z ,]+);',l.sentenceadditionalinfo) => regexreplace('(JAIL TIME: )([0-9A-Z ,]+);(.*)',trim(l.sentenceadditionalinfo),'$2'),
	                               regexfind('(SENTENCE JAIL DAYS: )([0-9]+)',l.sentenceadditionalinfo) => trim(regexreplace('(SENTENCE JAIL DAYS: )([0-9]+)',trim(l.sentenceadditionalinfo),'$2'))+'D','');
  string temp_timeserved  := MAP(temp_timeserve1 <> '' => 'Time served: '+ temp_timeserve1,
	                               Jail_time <> '' =>       'Jail: '+ stringlib.stringfindreplace(stringlib.stringfindreplace(stringlib.stringfindreplace
																                          ( Jail_time, 'M','Months'),'D','Days'),'Y','Years'),
                                 ''); 																										
	
  string temp_min_sentN   := IF(l.sentenceminyears  <> ''	,INTFORMAT((integer)trim(l.sentenceminyears),3,1),'') +					
	                           IF(l.sentenceminmonths <> ''	,INTFORMAT((integer)trim(l.sentenceminmonths),3,1),'') +
														 IF(l.sentencemindays   <> ''	,INTFORMAT((integer)trim(l.sentencemindays),3,1),'');															
														
	string temp_min_sent   := IF(l.sentenceminyears  <> ''	,trim(l.sentenceminyears) + 'Years ','') +					
	                          IF(l.sentenceminmonths <> ''	,trim(l.sentenceminmonths) + 'Months ','') +
														IF(l.sentencemindays   <> ''	,trim(l.sentencemindays) + 'Days ','');																

  string temp_max_sentN  := IF(l.sentencemaxyears  <> ''	,INTFORMAT((integer)trim(l.sentencemaxyears),3,1),'') +					
		                        IF(l.sentencemaxmonths <> ''	,INTFORMAT((integer)trim(l.sentencemaxmonths),3,1),'') +
														IF(l.sentencemaxdays   <> ''	,INTFORMAT((integer)trim(l.sentencemaxdays),3,1),'');
														
	string temp_max_sent   := IF(l.sentencemaxyears  <> ''	,trim(l.sentencemaxyears) + 'Years ','') +					
		                        IF(l.sentencemaxmonths <> ''	,trim(l.sentencemaxmonths) + 'Months ','') +
														IF(l.sentencemaxdays   <> ''	,trim(l.sentencemaxdays) + 'Days ','');

	string MT_sentlgth     := IF(l.statecode ='MT', temp_max_sentN,'');
	string MT_sentlgthdesc := MAP(l.statecode ='MT' and temp_max_sent <> '' and 
	                              regexfind('SUSPENDED MONTHS:',l.sentenceadditionalinfo) => trim(l.sentencetype) + ': '+trim(temp_max_sent) + ' SUSPENDED: '+regexreplace('(SUSPENDED MONTHS: )(.*)',trim(l.sentenceadditionalinfo),'$2')+'Months',
	                              l.statecode ='MT' and temp_max_sent <> '' and  
																regexfind('DEFERRED MONTHS:' ,l.sentenceadditionalinfo) => trim(l.sentencetype) + ': '+trim(temp_max_sent) + ' DEFERRED:'+regexreplace('(DEFERRED MONTHS: )(.*)',trim(l.sentenceadditionalinfo),'$2')+'Months',                                                                                                                                                                               
																l.statecode ='MT' and temp_max_sent = '' and 
	                              regexfind('SUSPENDED MONTHS:',l.sentenceadditionalinfo) => 'SUSPENDED: '+regexreplace('(SUSPENDED MONTHS: )(.*)',trim(l.sentenceadditionalinfo),'$2')+'Months',
	                              l.statecode ='MT' and temp_max_sent = '' and 
																regexfind('DEFERRED MONTHS:' ,l.sentenceadditionalinfo) => 'DEFERRED:'+regexreplace('(DEFERRED MONTHS: )(.*)',trim(l.sentenceadditionalinfo),'$2')+'Months',                                                                                                                                                                               
																
																l.statecode ='MT' and temp_max_sent <> '' => trim(l.sentencetype) + ':'+temp_max_sent,
                                '');
																
  self.stc_lgth          := MAP (l.statecode ='MT' => MT_sentlgth,
	                               temp_tmeservedN   <> '' => temp_tmeservedN,
	                              // temp_min_sentN    <> '' and temp_max_sentN <> '' => '',
																// temp_max_sentN    <> '' => temp_max_sentN ,
																// temp_min_sentN    <> '' => temp_min_sentN ,
																 '');																	 
																 
	self.stc_lgth_desc     := MAP (l.statecode ='MT' => MT_sentlgthdesc,
	                               l.statecode = 'OH' and 
																 regexfind('(.*)(DEFINITE YRS: )([0-9]+)',l.sentenceadditionalinfo) => regexreplace('(.*)(DEFINITE YRS: )([0-9]+)',trim(l.sentenceadditionalinfo),'$3')+'Years',
	                               temp_senttype   <> '' => temp_senttype,
	                               temp_timeserved <> '' => temp_timeserved,
	                    //           temp_min_sent   <> '' and temp_max_sent <> '' => '',
											//					 temp_max_sent   <> '' => temp_max_sent ,
											//					 temp_min_sent   <> '' => temp_min_sent ,
											//					 temp_max_sent   <> '' => temp_max_sent ,
											//					 temp_min_sent   <> '' => temp_min_sent ,
																 '');		
																 
 
  inc_admit_dt            := MAP(//regexfind('ADMISSION INFO: "DATE:',l.sentenceadditionalinfo) => regexreplace('(ADMISSION INFO: "DATE: )([0-9]*)(,)',l.sentenceadditionalinfo,'$2'),
	                              regexfind('(ORIG ADMIT DATE:)([0-9]*)',l.Institutiondetails) => regexreplace('(ORIG ADMIT DATE: )([0-9]*)',l.Institutiondetails,'$2'),
																l.InstitutionReceiptDate <> '' =>trim(l.InstitutionReceiptDate),
																l.CustodyDate <>'' => trim(l.CustodyDate),
                                '')  ;														
														
	self.inc_adm_dt        := if(trim(inc_admit_dt)[1..2] between '19' and '20' 
								            and inc_admit_dt <= stringlib.GetDateYYYYMMDD(),
								            trim(inc_admit_dt),'');
														
	self.min_term          := MAP (l.statecode ='MT' => '',
	                               regexfind('[0-9]',temp_min_sentN) => temp_min_sentN,
	                               //temp_min_sentN <> '' and temp_max_sentN  <> '' => temp_min_sentN,
	                               //temp_senttype <> '' or temp_tmeservedN <> '' => temp_min_sentN,''
	                               temp_min_sentN);
																 
	self.min_term_desc     := MAP (l.statecode ='MT' => '',
	                               //temp_min_sent <> ''  and temp_max_sent  <> ''  => temp_min_sent,
	                               //temp_senttype <> ''  or temp_timeserved <> '' => temp_min_sent,''
	                               temp_min_sent);
																 
	self.max_term          := MAP (l.statecode ='MT' => '',
	                               //temp_min_sentN <> '' and temp_max_sentN  <> '' => temp_max_sentN,
	                               //temp_senttype <> '' or temp_tmeservedN <> '' => temp_max_sentN,''
																 regexfind('[0-9]',temp_max_sentN) => temp_max_sentN,
	                  						 ''//temp_max_sentN
	                               );		
																 
	self.max_term_desc     := MAP (l.statecode ='MT' => '',
	                               //temp_min_sent <> ''  and temp_max_sent  <> ''  => temp_max_sent,
	                               //temp_senttype <> ''  or temp_timeserved <> '' => temp_max_sent,''
	                               temp_max_sent);
																 
  string Par_min_sent   :=  IF(l.Paroleminyears  <> ''	,trim(l.Paroleminyears) + 'Years ','') +					
	                          IF(l.Paroleminmonths <> ''	,trim(l.Paroleminmonths) + 'Months ','') +
														IF(l.Parolemindays   <> ''	,trim(l.Parolemindays) + 'Days ','');		
														
	string Par_max_sent   :=  IF(l.Parolemaxyears  <> ''	,trim(l.Parolemaxyears) + 'Years ','') +					
		                        IF(l.Parolemaxmonths <> ''	,trim(l.Parolemaxmonths) + 'Months ','') +
														IF(l.Parolemaxdays   <> ''	,trim(l.Parolemaxdays) + 'Days ','');
														
	self.parole           :=  MAP(Par_min_sent <> '' and Par_max_sent <> '' => Par_min_sent+'; '+Par_max_sent,
	                              Par_min_sent <> '' => Par_min_sent,
											          Par_max_sent <> '' => Par_max_sent,
											          '');
	string Prob_min_sent   := IF(l.probationminyears  <> ''	,trim(l.probationminyears) + 'Years ','') +					
	                          IF(l.probationminmonths <> ''	,trim(l.probationminmonths) + 'Months ','') +
														IF(l.probationmindays   <> ''	,trim(l.probationmindays) + 'Days ','');		
														
	string Prob_max_sent   := IF(l.probationmaxyears  <> ''	,trim(l.probationmaxyears) + 'Years ','') +					
		                        IF(l.probationmaxmonths <> ''	,trim(l.probationmaxmonths) + 'Months ','') +
														IF(l.probationmaxdays   <> ''	,trim(l.probationmaxdays) + 'Days ','');
														
	self.probation         := MAP (Prob_min_sent <> '' and Prob_max_sent <> '' => Prob_min_sent+'; '+Prob_max_sent,
	                               Prob_min_sent <> '' => Prob_min_sent,
										           	 Prob_max_sent <> '' => Prob_max_sent,
											           '');
	self.offensetown      := MAP(regexfind('(.*)[ ](COUNTY: )(.*)',l.offenselocation) => '',
	                             regexfind('(COUNTY COMMITTED: )(.*)',l.offenselocation) => '',
															 regexfind('COUNTY CONVICTED:',l.offenselocation) => '',                 

	                             l.offenselocation); 
	self.convict_dt       := MAP (trim(l.finalrulingdate)<> '' => trim(l.finalrulingdate),
	                              '');
	self.court_county	    := '';
	self.Hyg_classification_code := l.classification_code;
	
end;

//REMOVE RECORDS WHERE VENDOR CODE IS NOT ASSIGNED////////////////////////////////////////////
result_common 	:= project(j_final, to_court_offenses(left))(trim(vendor, left, right)<>'') ;
	
/////////////////////////////////////////////////////////////////////////////////////////////

// result_sort 	:= sort(distribute(result_common,HASH(offender_key,vendor,source_file)),
                                     // process_date, offender_key, vendor, source_file, off_date, arr_date, case_num, 
                                     // off_code, chg, chg_typ_flg, off_desc_1, off_desc_2, add_off_cd, add_off_desc, off_typ, off_lev,
                                     // arr_disp_date, arr_disp_cd, arr_disp_desc_1, arr_disp_desc_2, arr_disp_desc_3, court_cd, court_desc,
                                     // ct_dist, ct_fnl_plea_cd, ct_fnl_plea, ct_off_code, ct_chg, ct_chg_typ_flg, ct_off_desc_1, ct_off_desc_2,
                                     // ct_addl_desc_cd, ct_off_lev, ct_disp_dt, ct_disp_cd, ct_disp_desc_1, ct_disp_desc_2, cty_conv_cd,
                                     // cty_conv, adj_wthd, stc_dt, stc_cd, stc_comp, stc_desc_1, stc_desc_2, stc_desc_3, stc_desc_4,
                                     // stc_lgth, stc_lgth_desc, inc_adm_dt, min_term, min_term_desc, max_term, max_term_desc,
																		 // parole,probation,offensetown,convict_dt,
																		 // -num_of_counts,-offense_key,local);
																		 
result_sort 	:= sort(distribute(result_common,HASH(offender_key,vendor,source_file)),
                                     process_date, offender_key, vendor, source_file, off_date, arr_date, case_num, 
																		 StringLib.StringFilter(StringLib.StringToUpperCase(off_code),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
																		 chg, chg_typ_flg, 
																		 StringLib.StringFilter(StringLib.StringToUpperCase(off_desc_1+off_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
																		 add_off_cd, add_off_desc, off_typ, off_lev,
                                     arr_disp_date, arr_disp_cd, arr_disp_desc_1, arr_disp_desc_2, arr_disp_desc_3, court_cd, court_desc,
                                     ct_dist, ct_fnl_plea_cd, ct_fnl_plea, ct_off_code, ct_chg, ct_chg_typ_flg, ct_off_desc_1, ct_off_desc_2,
                                     ct_addl_desc_cd, ct_off_lev, ct_disp_dt, ct_disp_cd, ct_disp_desc_1, ct_disp_desc_2, cty_conv_cd,
                                     cty_conv, adj_wthd, trim(stc_dt), stc_comp, stc_desc_1, stc_desc_2, stc_desc_3, stc_desc_4,
                                     stc_lgth, stc_lgth_desc, inc_adm_dt, min_term, min_term_desc, max_term, 
																		 StringLib.StringFilter(StringLib.StringToUpperCase(max_term_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
																		 parole,
																		 StringLib.StringFilter(StringLib.StringToUpperCase(probation),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
																		 offensetown,convict_dt,-num_of_counts,-offense_key,
																		 local); 																		 

// result_dedup 	:= dedup(result_sort, process_date, offender_key, vendor, source_file, off_date, arr_date, case_num, 
                                     // off_code, chg, chg_typ_flg, off_desc_1, off_desc_2, add_off_cd, add_off_desc, off_typ, off_lev,
                                     // arr_disp_date, arr_disp_cd, arr_disp_desc_1, arr_disp_desc_2, arr_disp_desc_3, court_cd, court_desc,
                                     // ct_dist, ct_fnl_plea_cd, ct_fnl_plea, ct_off_code, ct_chg, ct_chg_typ_flg, ct_off_desc_1, ct_off_desc_2,
                                     // ct_addl_desc_cd, ct_off_lev, ct_disp_dt, ct_disp_cd, ct_disp_desc_1, ct_disp_desc_2, cty_conv_cd,
                                     // cty_conv, adj_wthd, stc_dt, stc_cd, stc_comp, stc_desc_1, stc_desc_2, stc_desc_3, stc_desc_4,
                                     // stc_lgth, stc_lgth_desc, inc_adm_dt, min_term, min_term_desc, max_term, max_term_desc,
																		 // parole,probation,offensetown,convict_dt,local)  : persist ('persist::out::crim::HD::DOC::offenses');
 
result_dedup 	:= dedup(result_sort,  process_date,offender_key,vendor, source_file, off_date, arr_date, case_num, 
 																		 StringLib.StringFilter(StringLib.StringToUpperCase(off_code),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
																		 chg, chg_typ_flg, 
																		 StringLib.StringFilter(StringLib.StringToUpperCase(off_desc_1+off_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
																		 add_off_cd, add_off_desc, off_typ, off_lev,
                                     arr_disp_date, arr_disp_cd, arr_disp_desc_1, arr_disp_desc_2, arr_disp_desc_3, court_cd, court_desc,
                                     ct_dist, ct_fnl_plea_cd, ct_fnl_plea, ct_off_code, ct_chg, ct_chg_typ_flg, ct_off_desc_1, ct_off_desc_2,
                                     ct_addl_desc_cd, ct_off_lev, ct_disp_dt, ct_disp_cd, ct_disp_desc_1, ct_disp_desc_2, cty_conv_cd,
                                     cty_conv, adj_wthd,trim(stc_dt),stc_comp,stc_desc_1, stc_desc_2, stc_desc_3, stc_desc_4,
                                     stc_lgth, stc_lgth_desc, inc_adm_dt, min_term, min_term_desc, max_term, 
                                     StringLib.StringFilter(StringLib.StringToUpperCase(max_term_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
																		 parole,
																		 StringLib.StringFilter(StringLib.StringToUpperCase(probation),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),																		 
																		 offensetown,convict_dt,local) : persist ('persist::out::crim::HD::DOC::offenses');
//remove records with blank charges for UT DOC 
export Proc_build_DOC_offenses := result_dedup(vendor = 'EM' and case_num+off_code+off_desc_1+stc_dt+ct_disp_desc_1 <>'')+result_dedup(vendor <> 'EM');