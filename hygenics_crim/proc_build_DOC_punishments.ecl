import crim_common, hygenics_crim, STD;


Printable := ' abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789~`!@#$%^&*()_-+={[}]|:;",<.>/?\'\\'; 

fn_KeepPrintableChars(string s) := STD.Str.Filter(s, Printable);  

def := distribute(hygenics_crim.file_in_defendant_doc,HASH32(recordid,statecode));
off := distribute(hygenics_crim.file_in_offense_doc,HASH32(recordid,statecode));
sen := distribute(hygenics_crim.file_in_sentence_doc,HASH32(recordid,statecode));
pri := distribute(hygenics_crim.file_in_priors_doc,HASH32(recordid,statecode));
cha := distribute(hygenics_crim.file_in_charge_doc,hash32(recordid,statecode));


layout_j_final := record

	string 			ln_vendor := '';

	//from def
	string40		RecordID;
	string			Gender;
	string 			Race;
	string8	  	DOB;
	string100		SourceName;
	string20		SourceType;
	string2			StateCode;
	string20		RecordType;
	string8		  RecordUploadDate;
	string115		Name;
	string100		DefendantStatus;
	string20		DOCNumber;
	string20		FBINumber;
	string20		StateIDNumber;
	string20		InmateNumber;
	string20		AlienNumber;
	//string200	DefendantAdditionalInfo;
	//string20	DLNumber;
	//string2		DLState;
	string100		InstitutionName;
	string200		InstitutionDetails;
	string8			InstitutionReceiptDate;
	//string100	ReleaseToLocation;
	//string200	ReleaseToDetails;
	//string8		SexOffenderRegistryDate;
	//string8		SexOffenderRegExpirationDate;
	//string100	SexOffenderRegistryNumber;
	
	//from offense
	//string40	RecordID;
	//string100	SourceName;
	//string20	SourceType;
	//string2		StateCode;
	string100 		CaseID 								:= '';
	string50		CaseNumber						:= '';
	//string100	CaseTitle							:= '';
	//string20	CaseType							:= '';
	//string100	CaseStatus						:= '';
	//string8		CaseStatusDate				:= '';
	//string200	CaseComments					:= '';
	string8			FiledDate							:= '';
	//string100	CaseInfo							:= '';
	string30		DocketNumber					:= '';
	//string30	OffenseCode	    			:= '';
	//string100	OffenseDesc	    			:= '';
	//string8		OffenseDate						:= '';
	//string100	OffenseType						:= '';
	//string20	OffenseDegree					:= '';
	//string20	OffenseClass					:= '';
	//string100	DispositionStatus			:= '';
	//string8		DispositionStatusDate	:= '';
	//string150	Disposition					  := '';
	//string8		DispositionDate				:= '';
	//string50	OffenseLocation				:= '';
	//string100	FinalOffense				  := '';
	//string8		FinalOffenseDate			:= '';
	//string4		OffenseCount				  := '';
	//string1		VictimUnder18				  := '';
	//string1		PriorOffenseFlag			:= '';
	//string20	InitialPlea					  := '';
	//string8		InitialPleaDate				:= '';
	//string20	FinalRuling					  := '';
	//string8		FinalRulingDate				:= '';
	//string50	AppealStatus				  := '';
	//string8		AppealDate					  := '';
	string50		CourtName					    := '';
	string10		FineAmount					  := '';
	string10		CourtFee					   	:= '';
	string10		Restitution					  := '';
	//string20	TrialType					    := '';
	//string8		CourtDate					    := '';

	//from sentence
	string8		SentenceDate				  	:= '';
	string8		SentenceBeginDate		  := '';
	string8		SentenceEndDate			  := '';
	string20	SentenceType				  := '';
	string10	SentenceMaxYears		  := '';
	string10	SentenceMaxMonths		  := '';
	string10	SentenceMaxDays			  := '';
	string10	SentenceMinYears		  := '';
	string10	SentenceMinMonths		  := '';
	string10	SentenceMinDays			  := '';
	string8		ScheduledReleaseDate	:= '';
	string8		ActualReleaseDate			:= '';
	string100	SentenceStatus				:= '';
	string10	TimeServedYears				:= '';
	string10	TimeServedMonths			:= '';
	string10	TimeServedDays				:= '';
	string10	PublicServiceHours			:= '';
	string200	SentenceAdditionalInfo		  := '';
	string50	CommunitySupervisionCounty	:= '';
	string10	CommunitySupervisionYears	  := '';
	string10	CommunitySupervisionMonths	:= '';
	string10	CommunitySupervisionDays	  := '';
	string8		ParoleBeginDate			  := '';
	string8		ParoleEndDate				  := '';
	string8		ParoleEligibilityDate	:= '';
	string8		ParoleHearingDate			:= '';
	string10	ParoleMaxYears				:= '';
	string10	ParoleMaxMonths				:= '';
	string10	ParoleMaxDays				  := '';
	string10	ParoleMinYears				:= '';
	string10	ParoleMinMonths				:= '';
	string10	ParoleMinDays				  := '';
	string100	ParoleStatus				  := '';
	string50	ParoleOfficer				  := '';
	string20	ParoleOffcerPhone			:= '';
	string8		ProbationBeginDate		:= '';
	string8		ProbationEndDate			:= '';
	string10	ProbationMaxYears			:= '';
	string10	ProbationMaxMonths		:= '';
	string10	ProbationMaxDays			:= '';
	string10	ProbationMinYears			:= '';
	string10	ProbationMinMonths		:= '';
	string10	ProbationMinDays			:= '';
	string100	ProbationStatus				:= '';

	//from charge
	string8		BookingDate						:= '';
	string8   custodydate           := ''; 
 
 end;


layout_j_final to_j1(off l,def r) := transform
    self.ln_vendor 		      		:=trim(hygenics_crim._functions.fn_sourcename_to_vendor(trim(l.sourcename),l.statecode));
 		self.RecordID 		      		:= r.RecordID;
		self.SourceName 		    		:= r.SourceName;
		self.SourceType 		    		:= r.SourceType;
		self.RecordUploadDate       := r.RecordUploadDate;
		self.StateCode 		      		:= r.StateCode;
		self.DefendantStatus 				:= r.DefendantStatus;
		self.InmateNumber 		  		:= r.InmateNumber;	
		self.InstitutionName 				:= r.InstitutionName; 
		self.InstitutionDetails 		:= r.InstitutionDetails;
		self.InstitutionReceiptDate := r.InstitutionReceiptDate;	
	  self.CaseID        					:= l.CaseID;
    self.DOCNumber     					:= r.DOCNumber;
	  self.FBINumber     					:= r.FBINumber;
	  self.stateIDNumber 					:= r.stateIDNumber;
	  self.AlienNumber   					:= r.AlienNumber;
		self.CaseNumber	   					:= l.CaseNumber;
		self.courtname	   					:= l.courtname;
	  self.FiledDate		 					:= l.FiledDate;
		self.FineAmount		 					:= l.FineAmount;
	  self.CourtFee			 					:= l.CourtFee;
	  self.Restitution	 					:= l.Restitution;			
		self.DocketNumber  					:= l.DocketNumber;
		self.dob           					:= r.dob;
		self.gender		   						:= r.gender;
		self.race		   							:= r.race;
		self.recordtype    					:= r.recordtype;
		self.name          					:= r.name
end;

j1 := join(off,def, 
						left.statecode=right.statecode and 
						left.recordid=right.recordid, 
						to_j1(left,right),local);

layout_j_final to_j3(j1 l, sen r) := transform
    self.ln_vendor 		   := l.ln_vendor;
 		self.RecordID 		   := l.RecordID;
		self.SourceName      := l.SourceName;
		self.SourceType 	   := l.SourceType;
		self.RecordUploadDate:= l.RecordUploadDate;
		self.StateCode 		   := l.StateCode;
		self.DefendantStatus := l.DefendantStatus;
		self.InmateNumber    := l.InmateNumber;	
		self.InstitutionName := l.InstitutionName; 
		self.dob             := l.dob;
		self.gender			     := l.gender;
		self.race			       := l.race;
		self.recordtype      := l.recordtype;
		self.name            := l.name;
		self.InstitutionDetails     := l.InstitutionDetails;
		self.InstitutionReceiptDate := l.InstitutionReceiptDate;	
		self.DOCNumber              := l.DOCNumber;
	  self.FBINumber              := l.FBINumber;
	  self.stateIDNumber          := l.stateIDNumber;
	  self.AlienNumber            := l.AlienNumber;
		self.CaseID                 := l.CaseID;
	  self.CaseNumber	            := l.CaseNumber;
		self.courtname	   					:= l.courtname;
	  self.FiledDate				      := l.FiledDate;
	  self.FineAmount		          := l.FineAmount;
	  self.CourtFee				        := l.CourtFee;
	  self.Restitution			      := l.Restitution;		
		self.DocketNumber           := l.DocketNumber;
  	self.SentenceDate				    := r.SentenceDate;
		self.SentenceBeginDate		  := r.SentenceBeginDate;
		self.SentenceEndDate			  := r.SentenceEndDate;
		self.SentenceType				    := r.SentenceType;
		self.SentenceMaxYears		    := r.SentenceMaxYears;
		self.SentenceMaxMonths		  := r.SentenceMaxMonths;
		self.SentenceMaxDays			  := r.SentenceMaxDays;
		self.SentenceMinYears		    := r.SentenceMinYears;
		self.SentenceMinMonths		  := r.SentenceMinMonths;
		self.SentenceMinDays			  := r.SentenceMinDays;
		self.ScheduledReleaseDate	  := r.ScheduledReleaseDate;
		self.ActualReleaseDate			:= r.ActualReleaseDate;
		self.SentenceStatus				  := r.SentenceStatus;
		self.TimeServedYears				:= r.TimeServedYears;
		self.TimeServedMonths			  := r.TimeServedMonths;
		self.TimeServedDays				  := r.TimeServedDays;
		self.PublicServiceHours		  := r.PublicServiceHours;
		self.SentenceAdditionalInfo	:= r.SentenceAdditionalInfo;
		self.CommunitySupervisionCounty	:= r.CommunitySupervisionCounty;
		self.CommunitySupervisionYears	:= r.CommunitySupervisionYears;
		self.CommunitySupervisionMonths	:= r.CommunitySupervisionMonths;
		self.CommunitySupervisionDays	  := r.CommunitySupervisionDays;
		self.ParoleBeginDate			      := r.ParoleBeginDate;
		self.ParoleEndDate				  := r.ParoleEndDate;
		self.ParoleEligibilityDate	:= r.ParoleEligibilityDate;
		self.ParoleHearingDate			:= r.ParoleHearingDate;
		self.ParoleMaxYears				  := r.ParoleMaxYears;
		self.ParoleMaxMonths				:= r.ParoleMaxMonths;
		self.ParoleMaxDays				  := r.ParoleMaxDays;
		self.ParoleMinYears				  := r.ParoleMinYears;
		self.ParoleMinMonths				:= r.ParoleMinMonths;
		self.ParoleMinDays				  := r.ParoleMinDays;
		self.ParoleStatus				    := r.ParoleStatus;
		self.ParoleOfficer				  := r.ParoleOfficer;
		self.ParoleOffcerPhone			:= r.ParoleOffcerPhone;
		self.ProbationBeginDate		  := r.ProbationBeginDate;
		self.ProbationEndDate			  := r.ProbationEndDate;
		self.ProbationMaxYears			:= r.ProbationMaxYears;
		self.ProbationMaxMonths		  := r.ProbationMaxMonths;
		self.ProbationMaxDays			  := r.ProbationMaxDays;
		self.ProbationMinYears			:= r.ProbationMinYears;
		self.ProbationMinMonths		  := r.ProbationMinMonths;
		self.ProbationMinDays			  := r.ProbationMinDays;
		self.ProbationStatus				:= r.ProbationStatus;
 end;

j3 := join(j1,sen, 
                left.statecode=right.statecode and 
								left.recordid=right.recordid and 
								left.caseid=right.caseid, 
								to_j3(left,right), left outer, local);

								
layout_j_final addField(j3 l, cha r):= transform
	self.bookingdate := r.bookingdate;
	self.custodydate := r.custodydate;
	self := l;
end;

j4	:= join(j3, cha,
								left.statecode=right.statecode and 
								left.recordid=right.recordid and 
								left.caseid=right.caseid, 
								addField(left,right), left outer, local);

j_final := j4;

/////////////// Join Def and Priors

//add code here

layout_j_final to_j11(pri r ,def l) := transform
 self.ln_vendor 		    := trim(hygenics_crim._functions.fn_sourcename_to_vendor(trim(l.sourcename),l.statecode));
 self.caseid            := r.CaseID; 
 self.casenumber		    := r.casenumber;
 self.SentenceDate      := if(trim(r.SentenceDate)[1..2] between '19' and '20',
								              trim(r.SentenceDate),''); 
 self.SentenceBeginDate := if(trim(r.SentenceBeginDate)[1..2] between '19' and '20',
								              trim(r.SentenceBeginDate),''); 
 self.SentenceEndDate   := if(trim(r.SentenceEndDate)[1..2] between '19' and '20' ,
								              trim(r.SentenceEndDate),''); 		
 self.SentenceType		  := r.SentenceType;
 self.SentenceMaxYears	:= r.SentenceMaxYears;
 self.SentenceMaxMonths	:= r.SentenceMaxMonths;						
 self.SentenceMaxDays		:= r.SentenceMaxDays;															
 self.SentenceMinYears	:= r.SentenceMinYears;
 self.SentenceMinMonths	:= r.SentenceMinMonths;						
 self.SentenceMinDays		:= r.SentenceMinDays;	
 
 self.SentenceStatus    := r.SentenceStatus;
 self.CommunitySupervisionCounty := r.CommunitySupervisionCounty;
 self.CommunitySupervisionYears  := r.CommunitySupervisionYears;
 self.CommunitySupervisionMonths := r.CommunitySupervisionMonths;
 self.CommunitySupervisionDays   := r.CommunitySupervisionDays;
 self.ScheduledReleaseDate       := r.ScheduledReleaseDate;
 self.ActualReleaseDate          := r.ActualReleaseDate;
 self 					:= l; 
 self 					:= r;
end;

jpriors := join(pri, def,
				left.statecode=right.statecode and 
				left.recordid=right.recordid, 
				to_j11(left,right),local);
				
//output(jpriors);		

ds_concat_def_off_sent_prior 	:= j_final + jpriors;

//REMOVE RECORDS WHERE VENDOR CODE IS NOT ASSIGNED///////////////////////////////////////////////////

ds_concat_def_off_sent_priors	:= ds_concat_def_off_sent_prior(trim(ln_vendor, right, left)<>'');

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 hygenics_crim.layout_Common_DOC_Punishment_orig  to_court_punishments(ds_concat_def_off_sent_priors L) := TRANSFORM
                                                   
	s1 := l.sentenceadditionalinfo;	
  pos1:= stringlib.stringfind(s1,'MAX RELEASE DATE',1);
	MaxReleaseDt := 	Map(REGEXFIND('MAX RELEASE DATE',s1,NOCASE) =>s1[pos1+ 18..pos1+ 25],'');

	/////
	pos3:= stringlib.stringfind(s1,'JAIL TIME',1);
	pos4:= stringlib.stringfind(s1,';',1);
	JailTime := 	Map(REGEXFIND('JAIL TIME',s1,NOCASE) =>s1[pos3..pos4],'');
	////
	pos5:= stringlib.stringfind(s1,'DISCHARGE FROM PAROLE',1);
	DischargeFromParole := 	Map(REGEXFIND('DISCHARGE FROM PAROLE',s1,NOCASE) =>s1[ pos5+22..pos5+29],'');	
	////		
  pos7:= stringlib.stringfind(s1,'CONDITIONAL RELEASE DATE',1);
	ConditionalReleaseDt := 	Map(REGEXFIND('CONDITIONAL RELEASE DATE',s1,NOCASE) =>s1[ pos7+26..pos7+33],'');	
	
	///	
	pos10:= stringlib.stringfind(s1,'SECURITY STATUS',1);
	sec_status_string := 	Map(REGEXFIND('SECURITY STATUS',s1,NOCASE) =>s1[ pos10 ..],'');	
  pos11 :=stringlib.stringfind(sec_status_string,',',1);
	sec_status := Map(REGEXFIND('SECURITY STATUS',s1,NOCASE) =>s1[ pos10 .. pos10 +pos11],'');	
	
	
	pos14:= stringlib.stringfind(s1,'SENTENCE JAIL DAYS',1);	
	sent_jail_string := 	Map(REGEXFIND('SENTENCE JAIL DAYS',s1,NOCASE) =>s1[ pos14 ..],'');	
  pos15 :=stringlib.stringfind(sent_jail_string,',',1);
	sent_jail := Map(REGEXFIND('SENTENCE JAIL DAYS',s1,NOCASE) =>s1[ pos14 .. pos14 +pos15],'');	
		
	/////////	
	s2 := l.sentencestatus;
	pos12:= stringlib.stringfind(s2,'SENTENCED TO',1);	
	sent_to_string := 	Map(REGEXFIND('SENTENCED TO',s2,NOCASE) =>s2[ pos12 ..],'');		
  pos13 :=stringlib.stringfind(sent_to_string,';',1);
	sent_to := Map(REGEXFIND('SENTENCED TO',s2,NOCASE) =>s2[ pos12 .. pos12 +pos13],'');		
	
	/////
  pos2:= stringlib.stringfind(s2,'RELEASE TYPE',1);
	ReleaseType := 	Map(REGEXFIND('RELEASE TYPE',s2,NOCASE) =>s2[pos2+ 14..],'');
	
	////
	az_sent_status_pos   := stringlib.stringfind(s2,';',1);
	
	az_sent_status_parse := 	Map(REGEXFIND(';',s2,NOCASE) =>s2[1..az_sent_status_pos],s2);
	
	ga_sent_status_pos   := stringlib.stringfind(s2,':',1);
	ga_sent_status_parse := 	map(REGEXFIND(':',s2,NOCASE) =>  s2[ga_sent_status_pos +2..],'');
	
  /////////
	
	 parolestatus := l.parolestatus;           

   PAROLE_HEARING_LOC_pos := stringlib.stringfind(parolestatus,'PAROLE HEARING LOC',1);
	 PAROLE_HEARING_LOC_parse := 	Map(REGEXFIND('PAROLE HEARING LOC',parolestatus,NOCASE) =>parolestatus[PAROLE_HEARING_LOC_pos  + 20 ..],'');
	 
	 
	/////////
	
  s16 := l.sentenceadditionalinfo;
  pos16:= stringlib.stringfind(s16,'SUPERVISION END DATE',1);
	SuperVisionEndDt := 	Map(REGEXFIND('SUPERVISION END DATE',s16,NOCASE) =>s16[pos16+ pos16+ 29],'');
  //
	pos18:= stringlib.stringfind(s16,'SUPERVISED RELEASE DATE',1);
	SupervisedReleaseDate := 	Map(REGEXFIND('SUPERVISED RELEASE DATE',s16,NOCASE) =>s16[ pos18+25..pos18+32],'');	

	/////////
	
	
	tempeligdt_AZDOC := MAP(regexfind('(.*); (TEMP RELEASE ELIGIBLE: )([0-9]{8})$', l.sentenceadditionalinfo) =>regexreplace('(.*); (TEMP RELEASE ELIGIBLE: )([0-9]{8}$)', l.sentenceadditionalinfo,'$3'),
                          '');

  ctl_rel_dt_AZDOC := MAP (regexfind('(.*); (FLAT MAX DATE: )([0-9]{8})(;)(.*)', l.sentenceadditionalinfo) => regexreplace('(.*); (FLAT MAX DATE: )([0-9]{8})(;)(.*)', l.sentenceadditionalinfo,'$3'),
                           regexfind('(.*); (FLAT MAX DATE: )([0-9]{8})$', l.sentenceadditionalinfo) => regexreplace('(.*); (FLAT MAX DATE: )([0-9]{8})$', l.sentenceadditionalinfo,'$3'),       
                           regexfind('(FLAT MAX DATE: )([0-9]{8})(;)(.*)', l.sentenceadditionalinfo) => regexreplace('(FLAT MAX DATE: )([0-9]{8})(;)(.*)', l.sentenceadditionalinfo,'$2'),
                           regexfind('(FLAT MAX DATE: )([0-9]{8})$', l.sentenceadditionalinfo) => regexreplace('(FLAT MAX DATE: )([0-9]{8})($)', l.sentenceadditionalinfo,'$2'),       
                           '' )  ;

	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	vVendor 				 := hygenics_crim._functions.fn_sourcename_to_vendor(trim(l.sourcename),l.statecode);
	self.process_date 			:= stringlib.getdateyyyymmdd();
	
	string temp_case_number := MAP(stringlib.stringfind(l.casenumber,'INCORRECT',1) >0 =>'',
                                   l.casenumber); 
  //string def_number  := hygenics_crim._functions.fn_choose_def_number(l.statecode, l.recordid, l.stateidnumber, l.docnumber, l.inmatenumber);						
																			
  admit_date         := MAP(vVendor ='DI' => l.custodydate,
	                          l.InstitutionReceiptDate <> '' => l.InstitutionReceiptDate,
	                          regexfind('(ADMISSION INFO: "DATE: )([0-9]{8})(.*)',l.sentenceadditionalinfo) => regexreplace('(ADMISSION INFO: "DATE: )([0-9]{8})(.*)',l.sentenceadditionalinfo,'$2'),
	                          l.sentencebegindate); 
  event_date         := MAX(l.sentencedate,admit_date,l.parolebegindate,l.probationbegindate);																								 
	ls_source	         := trim(hygenics_crim._functions.fn_shorten_sourcename(l.sourcename));					//VC		
	vcase_type         := MAP (l.recordtype = 'CRIMINAL ADMISSION' =>'ADM',  
                              l.recordtype = 'CRIMINAL RELEASE' => 'REL',    
                              l.recordtype = 'CRIMINAL RESIDENT' => 'RES',
															''); //VC
																													

	v_pty_nm                 := StringLib.StringFilter(StringLib.StringToUpperCase(l.name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); 
	v_doc_num1               := StringLib.StringFilter(StringLib.StringToUpperCase(l.docnumber),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	v_inm_num1               := StringLib.StringFilter(StringLib.StringToUpperCase(l.inmatenumber),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); 
	v_stid_num1              := StringLib.StringFilter(StringLib.StringToUpperCase(l.stateidnumber),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); 
		//v_filter_list           := ['NA','UNK','NULL','R000'];
		v_doc_num               := IF(v_doc_num1  in _functions.Filterlist,'',v_doc_num1);
		v_inm_num               := IF(v_inm_num1  in _functions.Filterlist,'',v_inm_num1);
		v_stid_num              := IF(v_stid_num1 in _functions.Filterlist,'',v_stid_num1);	
	
self.offender_key		:= MAP(     vVendor in [
																	'DA','DB','DH','DJ','DI','DP','DM','DQ','DN','SB',
																	'DS','DU','EU','DY','DV','DX','EV','WG','EW','EX',
																	'EF','WH','WK','EP','ER','ET','DF','6X','ZB','6W',
																	'I0050','I0052'] and v_doc_num <> ''  => trim(vVendor) + v_doc_num, 
																	
																vVendor in [
																	'DD','DG','WL','DD','VE','WD','EA','WC','ED','WF',
																	'EE','EG','EI','EJ','EO','EQ',
																	'I0046','I0047','I0051'] and v_inm_num <> ''	=> trim(vVendor) + v_inm_num,
																
																vVendor in [
																	'EL','DW','6H','6Z','I0048','I0049'] and v_stid_num <> ''	=> trim(vVendor) + v_stid_num +trim(l.dob, all),
																	
																vVendor in [
																	'DR','DZ','WE','EK','ES','EM'] and v_stid_num <> ''	=> trim(vVendor) + v_stid_num,
																	
																vVendor in [
																	'DO','EB','EC','WJ','EH','EN'] => trim(vVendor) + (string)HASH64( v_pty_nm) + trim(l.gender, all) + trim(l.dob, all) + trim(l.race, all),
																
																vVendor in [
																	'DT']  			 => trim(vVendor) + (string)HASH64( v_pty_nm) + trim(l.gender, all) + trim(l.race, all) + trim(l.dob, all) + trim(l.courtname, all) + trim(l.docketnumber, all),
																
																vVendor in [
																	'EY'] 			 => trim(vVendor) + (string)HASH64( v_pty_nm) + trim(l.gender, all) + trim(l.bookingdate, all),
																//l.nametype <> 'A' and vVendor in [
																//	'DL']				 => vVendor + (string)HASH64( v_pty_nm)+ trim(l.dob, all)  ,																
																
																trim(l.dob, all) <> '' 			 => trim(vVendor) + (string)HASH64( v_pty_nm) +  trim(l.dob, all),
																
																trim(l.dob, all) =  '' 			 => trim(vVendor) + (string)HASH64( v_pty_nm) +  trim(l.gender, all) + trim(l.race, all),
																'');	
																//hygenics_crim._functions.fn_persistent_offender_key(vVendor, l.name, l.dob, l.docnumber, l.inmatenumber, 
																//l.stateidnumber, l.fbinumber, temp_case_number, r.fileddate, vcase_type)
																//);		

    self.vendor			    := trim(l.ln_vendor);	
	self.source_file 	    := trim(ls_source);//VC
	self.offense_key 	    := ''; //  hygenics_crim._functions.fn_offender_key( l.ln_vendor, l.caseid,'', l.fileddate );
	
	self.event_dt 	      := MAP(l.ln_vendor[1..2] ='I0' => l.recorduploaddate  , event_date);	
	
	self.punishment_type 	:= Map(  event_date =''  => 'I',
	                               event_date = l.parolebegindate  => 'P',
	                               event_date = l.probationbegindate => 'P' ,
	                               event_date = l.sentencedate  => 'I', 
	                               event_date = l.sentencebegindate => 'I',
																 event_date = admit_date => 'I',
																 l.ProbationEndDate <> '' or l.ParoleEndDate <> '' => 'P',
																 '');
																 

		string temp_senttype   := MAP(regexfind('LIFE',l.sentencetype) => l.sentencetype,
	                              regexfind('LFE',l.sentencetype) => 'LIFE',
	                              regexfind('DEATH',l.sentencetype) => l.sentencetype,
																regexfind('DTH',l.sentencetype) => 'DEATH',
																'');
	
	
		string temp_tmeservedN := IF(l.timeservedyears  <> ''	,INTFORMAT((integer)trim(l.timeservedyears),3,1) ,'') +					
	                          IF(l.timeservedmonths <> ''	,INTFORMAT((integer)trim(l.timeservedmonths),3,1),'') +
														IF(l.timeserveddays   <> ''	,INTFORMAT((integer)trim(l.timeserveddays),3,1),'');
														
	string temp_timeserve1 := IF(l.timeservedyears  <> ''	,trim(l.timeservedyears) + 'Years ','') +					
	                          IF(l.timeservedmonths <> ''	,trim(l.timeservedmonths) + 'Months ','') +
														IF(l.timeserveddays   <> ''	,trim(l.timeserveddays) + 'Days ','');
	                                                                                                           
													
  String Jail_time        := MAP(regexfind('(JAIL TIME: )([0-9A-Z ,]+);',l.sentenceadditionalinfo) => regexreplace('(JAIL TIME: )([0-9A-Z ,]+);(.*)',l.sentenceadditionalinfo,'$2'),
	                               regexfind('(SENTENCE JAIL DAYS: )([0-9]+)',l.sentenceadditionalinfo) => trim(regexreplace('(SENTENCE JAIL DAYS: )([0-9]+)',l.sentenceadditionalinfo,'$2'))+'D','');
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
	                              regexfind('SUSPENDED MONTHS:',l.sentenceadditionalinfo) => trim(l.sentencetype) + ': '+trim(temp_max_sent) + ' SUSPENDED: '+regexreplace('(SUSPENDED MONTHS: )(.*)',l.sentenceadditionalinfo,'$2')+'Months',
	                              l.statecode ='MT' and temp_max_sent <> '' and  
																regexfind('DEFERRED MONTHS:' ,l.sentenceadditionalinfo) => trim(l.sentencetype) + ': '+trim(temp_max_sent) + ' DEFERRED:'+regexreplace('(DEFERRED MONTHS: )(.*)',l.sentenceadditionalinfo,'$2')+'Months',                                                                                                                                                                               
																l.statecode ='MT' and temp_max_sent = '' and 
	                              regexfind('SUSPENDED MONTHS:',l.sentenceadditionalinfo) => 'SUSPENDED: '+regexreplace('(SUSPENDED MONTHS: )(.*)',l.sentenceadditionalinfo,'$2')+'Months',
	                              l.statecode ='MT' and temp_max_sent = '' and 
																regexfind('DEFERRED MONTHS:' ,l.sentenceadditionalinfo) => 'DEFERRED:'+regexreplace('(DEFERRED MONTHS: )(.*)',l.sentenceadditionalinfo,'$2')+'Months',                                                                                                                                                                               
																
																l.statecode ='MT' and temp_max_sent <> '' => trim(l.sentencetype) + ':'+temp_max_sent,
                                '');
																
  stc_lgth          := MAP (l.statecode ='MT' => MT_sentlgth,
	                               temp_tmeservedN   <> '' => temp_tmeservedN,
	                              // temp_min_sentN    <> '' and temp_max_sentN <> '' => '',
																// temp_max_sentN    <> '' => temp_max_sentN ,
																// temp_min_sentN    <> '' => temp_min_sentN ,
																 '');																	 
																 
	stc_lgth_desc     := MAP (l.statecode ='MT' => MT_sentlgthdesc,
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
																 

///														 
																 
	self.sent_length 			:= stc_lgth;  
	
	
	//string temp_min_sent  := IF(l.sentenceminyears  <> ''	,trim(l.sentenceminyears) + 'Years ','') +					
	                         // IF(l.sentenceminmonths <> ''	,trim(l.sentenceminmonths) + 'Months ','') +
												 	 // IF(l.sentencemindays   <> ''	,trim(l.sentencemindays) + 'Days ','');		
														
	//string temp_max_sent  :=  IF(l.sentencemaxyears  <> ''	,trim(l.sentencemaxyears) + 'Years ','') +					
		                        // IF(l.sentencemaxmonths <> ''	,trim(l.sentencemaxmonths) + 'Months ','') +
														// IF(l.sentencemaxdays   <> ''	,trim(l.sentencemaxdays) + 'Days ','');	
														
	self.sent_length_desc := stc_lgth_desc;
																										

	self.cur_stat_inm 			:= '';
	self.cur_stat_inm_desc  :=  MAP(l.sourcename = 'ALABAMA_DEPARTMENT_OF_CORRECTIONS' => Trim(l.sentencetype),            
	                                l.sourcename = 'ARIZONA_DEPARTMENT_OF_CORRECTIONS'  => az_sent_status_parse,
																	l.sourcename = 'ARKANSAS_DEPARTMENT_OF_CORRECTIONS' => Trim(l.sentencetype), 
	                                l.sourcename = 'COLORADO_DEPARTMENT_OF_CORRECTIONS' and l.sentencetype <> '' =>trim(l.sentencetype),
																	//l.sourcename = 'COLORADO_DEPARTMENT_OF_CORRECTIONS'  and  StringLib.StringFind(l.InstitutionName,'PAROLE',1) > 0 =>'PAROLE',
																	l.sourcename = 'FLORIDA_DEPARTMENT_OF_CORRECTIONS'  and l.sentencetype <> ''  => trim(l.sentencetype),
																	l.sourcename = 'FLORIDA_DEPARTMENT_OF_CORRECTIONS'  => trim(l.sentencestatus),
																	l.sourcename = 'CONNECTICUT_DEPARTMENT_OF_CORRECTIONS'  => Trim(l.InstitutionName),     
																	l.sourcename = 'GEORGIA_DEPARTMENT_OF_CORRECTIONS'  => ga_sent_status_parse,
																	l.sourcename = 'IDAHO_DEPARTMENT_OF_CORRECTIONS'    =>trim(l.sentencetype),  
																	l.sourcename = 'ILLINOIS_DEPARTMENT_OF_CORRECTIONS' => ReleaseType,
																	l.sourcename = 'INDIANA_DEPARTMENT_OF_CORRECTIONS'  => Trim(l.sentencetype),                                                                 
                                  l.sourcename = 'IOWA_DEPARTMENT_OF_CORRECTIONS'     and trim(l.sentencetype) = 'PAROLE' => '',
																	l.sourcename = 'IOWA_DEPARTMENT_OF_CORRECTIONS'     and trim(l.sentencetype) = 'PROBATION' => '',
																	l.sourcename = 'IOWA_DEPARTMENT_OF_CORRECTIONS'     => Trim(l.sentencetype), 
																	l.sourcename = 'KANSAS_DEPARTMENT_OF_CORRECTIONS'   => Trim(l.defendantstatus),
																	l.sourcename = 'KENTUCKY_DEPARTMENT_OF_CORRECTIONS'  => trim(sent_to),
																										 //no lousiana
																										 //no maine 
																	l.sourcename = 'MICHIGAN_DEPARTMENT_OF_CORRECTIONS'   => Trim(l.defendantstatus),
																	l.sourcename = 'MINNESOTA_DEPARTMENT_OF_CORRECTIONS'  => Trim(l.sentencestatus),                                                                    
                                  l.sourcename = 'MISSISSIPPI_DEPARTMENT_OF_CORRECTIONS' and l.defendantstatus <> '' and 
																	               StringLib.StringFind(l.defendantstatus,'PAROLE',1) = 0  and 
																								 StringLib.StringFind(l.defendantstatus,'PROBATION',1) = 0 => Trim(l.defendantstatus),																																															 
																	
																	l.sourcename = 'MISSOURI_DEPARTMENT_OF_CORRECTIONS' and l.sentencetype <> '' => trim(l.sentencetype),      
																	l.sourcename = 'MISSOURI_DEPARTMENT_OF_CORRECTIONS'  and 
																	StringLib.StringFind(l.InstitutionName,'PROBATION & PAROLEPAROLE',1) > 0 =>'PROBATION & PAROLEPAROLE',
	                                l.sourcename = 'MONTANA_DEPARTMENT_OF_CORRECTIONS'   => Trim(l.InstitutionDetails),

																	l.sourcename = 'NEBRASKA_DEPARTMENT_OF_CORRECTIONS'  => Trim(l.defendantstatus),     
																	l.sourcename = 'NEVADA_DEPARTMENT_OF_CORRECTIONS'  and 
																	l.sentencestatus <> '' and PAROLE_HEARING_LOC_parse <> '' => Trim(l.sentencestatus) + '; ' + PAROLE_HEARING_LOC_parse,
																	l.sourcename = 'NEVADA_DEPARTMENT_OF_CORRECTIONS'  and 
																	l.sentencestatus <> ''                                    => Trim(l.sentencestatus) ,
																	l.sourcename = 'NEVADA_DEPARTMENT_OF_CORRECTIONS'  and 
																	PAROLE_HEARING_LOC_parse <> ''                            => PAROLE_HEARING_LOC_parse,
																	//no nh doc
																										 
																	l.sourcename = 'NEW_JERSEY_DEPARTMENT_OF_CORRECTIONS' and 
																	l.sentencetype <> '' and l.sentencestatus <> ''          => fn_KeepPrintableChars(Trim(l.sentencetype) + '; ' + Trim(l.sentencestatus)),
																	l.sourcename = 'NEW_JERSEY_DEPARTMENT_OF_CORRECTIONS' and 
																	l.sentencetype <> ''                                     => fn_KeepPrintableChars(Trim(l.sentencetype)) ,
																	l.sourcename = 'NEW_JERSEY_DEPARTMENT_OF_CORRECTIONS' and 
																	l.sentencestatus <> ' '                                  => fn_KeepPrintableChars(Trim(l.sentencestatus)),
																	l.sourcename = 'NEW_MEXICO_DEPARTMENT_OF_CORRECTIONS'    => Trim(l.defendantstatus), 
	                                l.sourcename = 'NEW_YORK_DEPARTMENT_OF_CORRECTIONS'      => Trim(l.defendantstatus),                                                                  
                                  l.sourcename = 'NORTH_CAROLINA_DEPARTMENT_OF_CORRECTIONS' and l.sentencetype <> 'DEPT OF CORR   DIV O' => 
																	                                             REGEXFIND('[A-Za-z]*',l.sentencestatus,0)  + l.sentencetype, 
																																																		
																	l.sourcename = 'OHIO_DEPARTMENT_OF_CORRECTIONS'     => Trim(l.defendantstatus),  
																	l.sourcename = 'OKLAHOMA_DEPARTMENT_OF_CORRECTIONS' and 
																	l.sentencetype <> '' and l.sentencestatus <> '' and 
																	trim(l.sentencestatus) <> 'SENTENCED TO P&P/CSD'        => Trim(l.sentencetype) + '; ' + Trim(l.sentencestatus),
																	l.sourcename = 'OKLAHOMA_DEPARTMENT_OF_CORRECTIONS' and 
																	l.sentencetype <> ''                                   => Trim(l.sentencetype) ,
																	l.sourcename = 'OKLAHOMA_DEPARTMENT_OF_CORRECTIONS' and 
																	l.sentencestatus <> ''                                 => Trim(l.sentencestatus),
														  		l.sourcename = 'OREGON_DEPARTMENT_OF_CORRECTIONS'   and  stringlib.stringfind(l.defendantstatus,'COMMUNITY SUPERVISION LEVEL:',1) >0 => l.defendantstatus[.. stringlib.stringfind(l.defendantstatus,'COMMUNITY SUPERVISION LEVEL:',1) -3],
																	l.sourcename = 'OREGON_DEPARTMENT_OF_CORRECTIONS'   => l.defendantstatus,
	 																l.sourcename = 'RHODE_ISLAND_DEPARTMENT_OF_CORRECTIONS'  => Trim(l.sentencestatus),                                                              
																	l.sourcename = 'SOUTH_CAROLINA_DEPARTMENT_OF_CORRECTIONS'  => Trim(l.defendantstatus),                                                             
																	l.sourcename = 'TENNESSEE_DEPARTMENT_OF_CORRECTIONS' => Trim(l.sentencetype), 
																										// Hygencis fix: map type from sent addi info
																								
         										      l.sourcename = 'TEXAS_DEPARTMENT_OF_CORRECTIONS'  => regexfind('[A-Z]+',Trim(l.sentencestatus),0),
																	l.sourcename = 'UTAH_DEPARTMENT_OF_CORRECTIONS'  => Trim(l.sentencestatus),
																										 //VA DOC LN CRIM and HYGEN is null
																	l.sourcename = 'WASHINGTON_DEPARTMENT_OF_CORRECTIONS' and 
																	l.sentencetype <> '' and l.sentencestatus <> ''   => Trim(l.sentencetype) + '; '  + Trim(l.sentencestatus),
																	l.sourcename = 'WASHINGTON_DEPARTMENT_OF_CORRECTIONS' and 
																	l.sentencetype <> ''                              => Trim(l.sentencetype) ,
																	l.sourcename = 'WASHINGTON_DEPARTMENT_OF_CORRECTIONS' and 
																	l.sentencestatus <> ''                            => Trim(l.sentencestatus),
																	
																	
																	l.sourcename = 'WEST_VIRGINIA_DEPARTMENT_OF_CORRECTIONS'  => Trim(l.defendantstatus),
																	l.sourcename = 'LOUISIANA_JAIL_ROSTERS'  => Trim(l.sentencestatus),                                                                         

                                  l.ln_vendor = 'I0046' and  regexfind('(SPECIAL PROVISIONS: )(.*)',l.sentenceadditionalinfo ) => regexreplace('(SPECIAL PROVISIONS: )(.*)',l.sentenceadditionalinfo,'$2' )
                                                                                   
																	,''); 																										                           
																								 
	self.cur_loc_inm_cd 		:= '';
	self.cur_loc_inm 				:=   MAP(l.sourcename = 'KENTUCKY_DEPARTMENT_OF_CORRECTIONS' and sent_to	<> '' => trim(sent_to),
	                                                 l.InstitutionName);    
	
	self.inm_com_cty_cd 		:= '';
	self.inm_com_cty 				:= ''; 
	self.cur_sec_class_dt   := '';
	self.cur_loc_sec 				:=   MAP(l.sourcename = 'WISCONSIN_DEPARTMENT_OF_CORRECTIONS' =>  Trim(l.sentencestatus),  
	                                             l.sourcename = 'MONTANA_DEPARTMENT_OF_CORRECTIONS' =>  '',
																							     l.sourcename = 'MINNESOTA_DEPARTMENT_OF_CORRECTIONS'  => sec_status, 
																									    REGEXREPLACE('INSTITUTION ADDRESS:',REGEXREPLACE('INSTITUTION PHONE:',TRIM(l.InstitutionDetails),'Phone:', NOCASE),'Address:',NOCASE));
																			 
	self.gain_time 					:= ''; 
	self.gain_time_eff_dt   := '';
	self.latest_adm_dt 			:= _functions.fn_Validate_date(admit_date); 	
	
	sch_rel_dt              := MAP(l.sourcename = 'ARIZONA_DEPARTMENT_OF_CORRECTIONS' and  l.ScheduledReleaseDate <> ''=>  l.ScheduledReleaseDate,
	                                            l.sourcename = 'ARIZONA_DEPARTMENT_OF_CORRECTIONS' and  tempeligdt_AZDOC <> ''=>  tempeligdt_AZDOC,
																							  l.sourcename = 'ARIZONA_DEPARTMENT_OF_CORRECTIONS' =>  l.SentenceEndDate,
																								   l.ScheduledReleaseDate);
	
	 sch_rel_dt_2            := 	REGEXREPLACE('19888888',
	                                        REGEXREPLACE('200000',  
																			        REGEXREPLACE('20000000',
	                                               REGEXREPLACE('19999999',
	                                                    if(trim(sch_rel_dt)[1..2] between '19' and '20', trim(sch_rel_dt),'')
																							           ,''),''),''),'');		
	
	self.sch_rel_dt         := MAP( l.sourcename = 'MISSISSIPPI_DEPARTMENT_OF_CORRECTIONS' and  l.sentencestatus IN ['PAROLE','PROBATION']  => '', 
	                                l.ln_vendor IN ['I0048','I0049'] => '',
																	sch_rel_dt_2); 
  	
	
	act_rel_dt              :=  MAP( l.sourcename = 'CONNECTICUT_DEPARTMENT_OF_CORRECTIONS'  and l.ActualReleaseDate <> '' => l.ActualReleaseDate,
	                                 l.sourcename = 'CONNECTICUT_DEPARTMENT_OF_CORRECTIONS'  and l.InstitutionName = 'DISCHARGE' => l.defendantstatus[17 ..],
																	 l.sourcename = 'MISSISSIPPI_DEPARTMENT_OF_CORRECTIONS' and  l.sentencestatus IN ['PAROLE','PROBATION']  => '',                                                                                         
                                   l.ln_vendor IN ['I0048','I0049'] => '',
																	 l.ActualReleaseDate); 
																								
	self.act_rel_dt         := 	REGEXREPLACE('19888888',
	                                        REGEXREPLACE('200000',  
																			        REGEXREPLACE('20000000',
	                                               REGEXREPLACE('19999999',
	                                                  if(trim(act_rel_dt)[1..2] between '19' and '20', trim(act_rel_dt),'')
																										    ,''),''),''),'');
																					
	
	ctl_rel_dt := MAP(l.sourcename = 'KENTUCKY_DEPARTMENT_OF_CORRECTIONS'  =>trim(ConditionalReleaseDt),
	                                         l.sourcename = 'MINNESOTA_DEPARTMENT_OF_CORRECTIONS'  =>trim(ConditionalReleaseDt), 
																					   l.sourcename = 'CONNECTICUT_DEPARTMENT_OF_CORRECTIONS'  =>trim(MaxReleaseDt),
																						   l.sourcename = 'ARIZONA_DEPARTMENT_OF_CORRECTIONS'  => ctl_rel_dt_AZDOC,
																					    '');
	
	
	self.ctl_rel_dt 				:=  if(trim(ctl_rel_dt)[1..2] between '19' and '20', trim(ctl_rel_dt),'');
																							
	self.presump_par_rel_dt := if(trim(l.ParoleEligibilityDate)[1..2] IN ['19','20'] , trim(l.ParoleEligibilityDate),'');
	self.mutl_part_pgm_dt   := ''; 
	self.par_cur_stat 			:= '';						 
	self.par_cur_stat_desc  := MAP(l.sourcename = 'TEXAS_DEPARTMENT_OF_CORRECTIONS'  => regexfind('[A-Z]+',Trim(l.ParoleStatus),0),																	
	                               l.ParoleStatus <> '' => l.ParoleStatus,
	                               l.sourcename = 'COLORADO_DEPARTMENT_OF_CORRECTIONS'  and  StringLib.StringFind(l.InstitutionName,'PAROLE',1) > 0 =>'PAROLE',
																 l.sourcename = 'IOWA_DEPARTMENT_OF_CORRECTIONS'     and trim(l.sentencetype) = 'PAROLE' => l.sentencetype,
																 l.sourcename = 'MISSISSIPPI_DEPARTMENT_OF_CORRECTIONS' and l.defendantstatus <> '' and 
																	               StringLib.StringFind(l.defendantstatus,'PAROLE',1) >0 => Trim(l.defendantstatus),
																 '');
	self.par_st_dt 					:= if(trim(l.ParoleBeginDate)[1..2] IN ['19','20'] , trim(l.ParoleBeginDate),'');
	

	
	/////
	self.par_sch_end_dt			:= MAP(l.sourcename = 'MISSISSIPPI_DEPARTMENT_OF_CORRECTIONS' and 
	                               l.sentencestatus = 'PAROLE' => l.ScheduledReleaseDate,
																 l.ln_vendor = 'I0048' => l.ScheduledReleaseDate,
																 '');
	
	
	
	self.par_act_end_dt 		:=   MAP(l.sourcename = 'KENTUCKY_DEPARTMENT_OF_CORRECTIONS'  =>trim(DischargeFromParole),
                                   l.sourcename = 'MISSISSIPPI_DEPARTMENT_OF_CORRECTIONS' and 
	  															 l.sentencestatus = 'PAROLE' => l.ActualReleaseDate,
																	 l.ln_vendor = 'I0048' => l.ActualReleaseDate,
	                                                                     l.ParoleEndDate);
																								
																								
	/////																							
	self.par_cty_cd 				:= '';
	self.par_cty 		    		:= l.CommunitySupervisionCounty;
	
	
	////
	self.pro_st_dt          := MAP(l.ProbationBeginDate <> '' => l.ProbationBeginDate,SupervisedReleaseDate);
	
	self.pro_end_dt         := MAP(l.sourcename = 'MISSISSIPPI_DEPARTMENT_OF_CORRECTIONS' and l.sentencestatus = 'PROBATION' and 
	                               l.ActualReleaseDate <> '' => l.ActualReleaseDate,
                                 l.sourcename = 'MISSISSIPPI_DEPARTMENT_OF_CORRECTIONS' and l.sentencestatus = 'PROBATION' and 
																 l.ScheduledReleaseDate <> '' => l.ScheduledReleaseDate,    
																 l.ln_vendor = 'I0049' => l.ScheduledReleaseDate,
																 l.ProbationEndDate   <> '' => l.ProbationEndDate,
																 SuperVisionEndDt);	  
	
	////
	self.pro_status         := MAP(l.sourcename = 'IOWA_DEPARTMENT_OF_CORRECTIONS'     and trim(l.sentencetype) = 'PROBATION' => l.sentencetype,
	                               l.sourcename = 'MISSISSIPPI_DEPARTMENT_OF_CORRECTIONS' and l.defendantstatus <> ''and 
																	               StringLib.StringFind(l.defendantstatus,'PROBATION',1) >0 => Trim(l.defendantstatus),	
	                               l.ProbationStatus);
																 
	self.sent_date		:= MAP(_functions.fn_Validate_date(l.SentenceDate) <> '' => l.SentenceDate,	                                
																  '' );
	
	self.release_type	:= '';
	self.office_region	:= '';
	self.par_status_dt	:= '';
	self.supv_office	:= '';
	self.supv_officer 	:= l.paroleofficer;
	self.office_phone	:= l.paroleoffcerphone;
	self.tdcjid_unit_type := '';
	self.tdcjid_unit_assigned := '';
	self.tdcjid_admit_date := '';
	self.prison_status	:= '';
	self.recv_dept_code	:= '';
	self.recv_dept_date	:= '';
	self.parole_active_flag := '';
	self.casepull_date	:= '';
END;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ds_punishment 	:= project(ds_concat_def_off_sent_priors, to_court_punishments(left)); 

 hygenics_crim.layout_Common_DOC_Punishment_orig skip_only_if_latest_adm_dt_loaded(ds_punishment L) := TRANSFORM,
																																													skip(l.latest_adm_dt <> '' and 
																																																				l.sent_length + 	
																																																				l.sent_length_desc + 	
																																																				l.cur_stat_inm + 	
																																																				l.cur_stat_inm_desc + 	
																																																				l.cur_loc_inm_cd + 	
																																																				l.cur_loc_inm + 	
																																																				l.inm_com_cty_cd + 	
																																																				l.inm_com_cty + 	
																																																				l.cur_sec_class_dt + 	
																																																				l.cur_loc_sec + 	
																																																				l.gain_time + 	
																																																				l.gain_time_eff_dt + 	
																																																			///	latest_adm_dt + 	
																																																				l.sch_rel_dt + 	
																																																				l.act_rel_dt + 	
																																																				l.ctl_rel_dt + 	
																																																				l.presump_par_rel_dt + 	
																																																				l.mutl_part_pgm_dt + 	
																																																				l.par_cur_stat +
																																																				l.par_cur_stat_desc + 	
																																																				l.par_st_dt + 	
																																																				l.par_sch_end_dt + 	
																																																				l.par_act_end_dt + 	
																																																				l.par_cty_cd + 	
																																																				l.par_cty + 	
																																																				l.pro_st_dt + 
																																																				l.pro_end_dt +      
																																																			  l.pro_status = '' )

SELF := L;
end;																																																			 
ds_projected := PROJECT(ds_punishment,skip_only_if_latest_adm_dt_loaded(LEFT));

srt_punishment := sort(distribute(ds_projected,HASH(offender_key,vendor,source_file)),
																//	process_date,		
																//	offender_key,		
																//			event_dt,		
																		 vendor,		
																//			source_file,		
																			offender_key,
																//			offense_key,		
																		 event_dt,
																			punishment_type,
																			cur_stat_inm_desc,		
																			sent_length,		
																			sent_length_desc,		
																			cur_stat_inm,		
																	// cur_stat_inm_desc,		
																			cur_loc_inm_cd,		
																			cur_loc_inm,		
																			inm_com_cty_cd,		
																			inm_com_cty,		
																			cur_sec_class_dt,		
																			cur_loc_sec,		
																			gain_time,		
																			gain_time_eff_dt,		
																			latest_adm_dt,		
																			sch_rel_dt,		
																			act_rel_dt,		
																			ctl_rel_dt,		
																			presump_par_rel_dt,		
																			mutl_part_pgm_dt,		
																			par_cur_stat,
																			par_cur_stat_desc,		
																			par_st_dt,		
																			par_sch_end_dt,		
																			par_act_end_dt,		
																			par_cty_cd,		
																			par_cty,		
																			pro_st_dt,	
																			pro_end_dt,	     
																		 pro_status,local);
																														 
																															
hygenics_crim.layout_Common_DOC_Punishment_orig    tr_rollup_punishment_file(srt_punishment L, srt_punishment R) := TRANSFORM

SELF.process_date := l.process_date;
SELF.offender_key := l.offender_key;
SELF.event_dt := l.event_dt;
SELF.vendor := l.vendor;
SELF.source_file := l.source_file; 
SELF.offense_key := l.offense_key;
SELF.punishment_type := l.punishment_type;
SELF.cur_stat_inm_desc :=  l.cur_stat_inm_desc;
SELF.sent_length := if(l.sent_length='',r.sent_length,l.sent_length);
SELF.sent_length_desc := if(l.sent_length_desc ='',r.sent_length_desc ,l.sent_length_desc);
SELF.cur_stat_inm := if(l.cur_stat_inm='',r.cur_stat_inm,l.cur_stat_inm);
SELF.cur_loc_inm_cd := if(l.cur_loc_inm_cd='',r.cur_loc_inm_cd,l.cur_loc_inm_cd);
SELF.cur_loc_inm := if(l.cur_loc_inm='',r.cur_loc_inm,l.cur_loc_inm);
SELF.inm_com_cty_cd := if(l.inm_com_cty_cd='',r.inm_com_cty_cd,l.inm_com_cty_cd);
SELF.inm_com_cty := if(l.inm_com_cty='',r.inm_com_cty,l.inm_com_cty);
SELF.cur_sec_class_dt := if(l.cur_sec_class_dt='',r.cur_sec_class_dt,l.cur_sec_class_dt);
SELF.cur_loc_sec := if(l.cur_loc_sec='',r.cur_loc_sec,l.cur_loc_sec);
SELF.gain_time := if(l.gain_time='',r.gain_time,l.gain_time);
SELF.gain_time_eff_dt := if(l.gain_time_eff_dt='',r.gain_time_eff_dt,l.gain_time_eff_dt);
SELF.latest_adm_dt := if(l.latest_adm_dt='',r.latest_adm_dt,l.latest_adm_dt);
SELF.sch_rel_dt := if(l.sch_rel_dt='',r.sch_rel_dt,l.sch_rel_dt);
SELF.act_rel_dt := if(l.act_rel_dt='',r.act_rel_dt,l.act_rel_dt);
SELF.ctl_rel_dt := if(l.ctl_rel_dt='',r.ctl_rel_dt,l.ctl_rel_dt);
SELF.presump_par_rel_dt := if(l.presump_par_rel_dt='',r.presump_par_rel_dt,l.presump_par_rel_dt);
SELF.mutl_part_pgm_dt := if(l.mutl_part_pgm_dt='',r.mutl_part_pgm_dt,l.mutl_part_pgm_dt);
SELF.par_cur_stat := if(l.par_cur_stat='',r.par_cur_stat,l.par_cur_stat);
SELF.par_cur_stat_desc := if(l.par_cur_stat_desc='',r.par_cur_stat_desc,l.par_cur_stat_desc);
SELF.par_st_dt := if(l.par_st_dt='',r.par_st_dt,l.par_st_dt);
SELF.par_sch_end_dt := if(l.par_sch_end_dt='',r.par_sch_end_dt,l.par_sch_end_dt); 
SELF.par_act_end_dt := if(l.par_act_end_dt='',r.par_act_end_dt,l.par_act_end_dt);
SELF.par_cty_cd := if(l.par_cty_cd='',r.par_cty_cd,l.par_cty_cd);
SELF.par_cty := if(l.par_cty='',r.par_cty,l.par_cty);
SELF.pro_st_dt := if(l.pro_st_dt='',r.pro_st_dt,l.pro_st_dt);
SELF.pro_end_dt :=  if(l.pro_end_dt='',r.pro_end_dt,l.pro_end_dt);    
SELF.pro_status := if(l.pro_status='',r.pro_status,l.pro_status);
self := l;
end;

ds_rollup_punishment_file := ROLLUP(srt_punishment,
																														(LEFT.vendor = RIGHT.vendor) and 
																														(LEFT.offender_key = RIGHT.offender_key) and 
																														(LEFT.event_dt = RIGHT.event_dt) and 
																														(LEFT.punishment_type = RIGHT.punishment_type) and
																														(LEFT.cur_stat_inm_desc = RIGHT.cur_stat_inm_desc) and
																														
																														(LEFT.sent_length = '' or RIGHT.sent_length = ''	or LEFT.sent_length =  RIGHT.sent_length) and 
																														(LEFT.sent_length_desc = '' or RIGHT.sent_length_desc	 = ''	or LEFT.sent_length_desc = RIGHT.sent_length_desc) and 	
																														(LEFT.cur_stat_inm = '' or RIGHT.cur_stat_inm = ''	or 	LEFT.cur_stat_inm = RIGHT.cur_stat_inm) and 																				
																														(LEFT.cur_loc_inm_cd = '' or RIGHT.cur_loc_inm_cd	 = ''	or 	LEFT.cur_loc_inm_cd = RIGHT.cur_loc_inm_cd) and 
																														(LEFT.cur_loc_inm = '' or RIGHT.cur_loc_inm = ''	or 	LEFT.cur_loc_inm = RIGHT.cur_loc_inm) and 
																														(LEFT.inm_com_cty_cd = '' or RIGHT.inm_com_cty_cd= '' or	LEFT.inm_com_cty_cd = RIGHT.inm_com_cty_cd) and 	
																														(LEFT.inm_com_cty = '' or RIGHT.inm_com_cty= '' or	LEFT.inm_com_cty = RIGHT.inm_com_cty) and 	
																														(LEFT.cur_sec_class_dt = '' or RIGHT.cur_sec_class_dt = '' or LEFT.cur_sec_class_dt = RIGHT.cur_sec_class_dt) and 
																														(LEFT.cur_loc_sec = '' or RIGHT.cur_loc_sec = '' or  LEFT.cur_loc_sec = RIGHT.cur_loc_sec) and 		
																														(LEFT.gain_time = '' or RIGHT.gain_time = '' or LEFT.gain_time =  RIGHT.gain_time) and 		
																														(LEFT.gain_time_eff_dt	= '' or RIGHT.gain_time_eff_dt = '' or 	LEFT.gain_time_eff_dt	= RIGHT.gain_time_eff_dt) and 
																														(LEFT.latest_adm_dt = '' or RIGHT.latest_adm_dt = '' or 	LEFT.latest_adm_dt = RIGHT.latest_adm_dt) and 	
																														(LEFT.sch_rel_dt = '' or RIGHT.sch_rel_dt = '' or 	LEFT.sch_rel_dt = RIGHT.sch_rel_dt) and 	
																														(LEFT.act_rel_dt = '' or RIGHT.act_rel_dt = '' or LEFT.act_rel_dt = RIGHT.act_rel_dt) and 
																														(LEFT.ctl_rel_dt = '' or RIGHT.ctl_rel_dt = '' or LEFT.ctl_rel_dt = RIGHT.ctl_rel_dt) and 
																														(LEFT.presump_par_rel_dt = '' or RIGHT.presump_par_rel_dt = '' or LEFT.presump_par_rel_dt = RIGHT.presump_par_rel_dt) and 	
																														(LEFT.mutl_part_pgm_dt = '' or RIGHT.mutl_part_pgm_dt = '' or LEFT.mutl_part_pgm_dt = RIGHT.mutl_part_pgm_dt) and 		
																														(LEFT.par_cur_stat = '' or RIGHT.par_cur_stat = '' or LEFT.par_cur_stat = RIGHT.par_cur_stat) and 
																														(LEFT.par_cur_stat_desc = '' or RIGHT.par_cur_stat_desc = '' or 	LEFT.par_cur_stat_desc = RIGHT.par_cur_stat_desc) and 	
																														(LEFT.par_st_dt = '' or RIGHT.par_st_dt = '' or 	LEFT.par_st_dt = RIGHT.par_st_dt) and 	
																														(LEFT.par_sch_end_dt = '' or RIGHT.par_sch_end_dt = '' or LEFT.par_sch_end_dt = RIGHT.par_sch_end_dt ) and 		
																														(LEFT.par_act_end_dt = '' or RIGHT.	par_act_end_dt = '' or 	LEFT.par_act_end_dt = RIGHT.par_act_end_dt) and 
																														(LEFT.par_cty_cd = '' or RIGHT.par_cty_cd = '' or LEFT.par_cty_cd = RIGHT.par_cty_cd) and 		
																														(LEFT.par_cty = '' or RIGHT.par_cty = '' or 	LEFT.par_cty = RIGHT.par_cty) and  	
																														(LEFT.pro_st_dt = '' or RIGHT.pro_st_dt = '' or 	LEFT.pro_st_dt = RIGHT.pro_st_dt) and  
																														(LEFT.pro_end_dt = '' or RIGHT.pro_end_dt = '' or 	 LEFT.pro_end_dt = RIGHT.pro_end_dt) and 
																														(LEFT.pro_status = '' or RIGHT.pro_status = '' or  LEFT.pro_status = RIGHT.pro_status),																							
																					                 		tr_rollup_punishment_file(LEFT,RIGHT),local);																					 
																						
																											
dedup_punishment	:= dedup(ds_rollup_punishment_file,	process_date,		
																															offender_key,																																			
																															vendor,		
																															source_file,
																															event_dt,
																															offense_key,		
																															punishment_type,
																															sent_length,		
																															sent_length_desc,		
																															cur_stat_inm,		
																															cur_stat_inm_desc,		
																															cur_loc_inm_cd,		
																															cur_loc_inm,		
																															inm_com_cty_cd,		
																															inm_com_cty,		
																															cur_sec_class_dt,		
																															cur_loc_sec,		
																															gain_time,		
																															gain_time_eff_dt,		
																															latest_adm_dt,		
																															sch_rel_dt,		
																															act_rel_dt,		
																															ctl_rel_dt,		
																															presump_par_rel_dt,		
																															mutl_part_pgm_dt,		
																															par_cur_stat,
																															par_cur_stat_desc,		
																															par_st_dt,		
																															par_sch_end_dt,		
																															par_act_end_dt,		
																															par_cty_cd,		
																															par_cty,		
																															pro_st_dt,	
																															pro_end_dt,	     
																														  pro_status,local);	

result_punishment := dedup_punishment : persist ('~thor_200::persist::out::crim::HD::DOC::punishment');

export proc_build_DOC_punishments := result_punishment;