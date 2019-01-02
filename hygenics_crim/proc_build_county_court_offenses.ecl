/*2014-04-23T19:31:32Z (Vani Chikte)

*/
import address, crim_common,STD;

// def := sort(distribute(hygenics_crim.file_in_defendant, hash(recordid)), recordid, local);
// cha := sort(distribute(hygenics_crim.file_in_charge, hash(recordid)), recordid, local);
// off := sort(distribute(hygenics_crim.file_in_offense, hash(recordid)), recordid, local);
// sen := sort(distribute(hygenics_crim.file_in_sentence, hash(recordid)), recordid, local);

 
def := distribute(hygenics_crim.file_in_defendant_counties(),hash(recordid,sourceid));
cha := distribute(hygenics_crim.file_in_charge_counties(),hash(recordid,sourceid));
off := distribute(hygenics_crim.file_in_offense_counties(),hash(recordid,sourceid));
sen := distribute(hygenics_crim.file_in_sentence_counties(),hash(recordid,sourceid));


layout_j_final := record

                //string ln_vendor := '';

                //from def
                string40   RecordID;
                string8    DOB;
                string100  SourceName;
                string20   SourceType;
                string2    StateCode;
                string20   RecordType;
                string115  Name;
                string1    NameType;
                string100  DefendantStatus;
                string20   DOCNumber;
                string20   FBINumber;
                string20   StateIDNumber;
                string20   InmateNumber;
                string20   AlienNumber;
                string200  DefendantAdditionalInfo;
                string20   DLNumber;
                string2    DLState;
                string100  InstitutionName;
                string200  InstitutionDetails;
                string8    InstitutionReceiptDate;
                string100  ReleaseToLocation;
                string200  ReleaseToDetails;
                //string8  SexOffenderRegistryDate;
                //string8  SexOffenderRegExpirationDate;
                //string100 SexOffenderRegistryNumber;

                //from charge
                string40   CaseID                := '';
                string20   WarrantNumber         := '';
                //string8  WarrantDate           := '';
                string200  WarrantDesc           := '';
                //string8  WarrantIssueDate      := '';
                string50   WarrantIssuingAgency  := '';
                string100  WarrantStatus         := '';
                string20   CitationNumber        := '';
                string20   BookingNumber         := '';
                string8    ArrestDate            := '';
                string50   ArrestingAgency       := '';
                string8    BookingDate           := '';
                string8    CustodyDate           := '';
                string50   CustodyLocation       := '';
                string100  InitialCharge         := '';
                string8    InitialChargeDate     := '';
                string8    InitialChargeCancelledDate := '';
                string100  ChargeDisposed        := '';
                string8    ChargeDisposedDate    := '';
                string20   ChargeSeverity        := '';
                string150  ChargeDisposition     := '';
                string100  AmendedCharge         := '';
                string8    AmendedChargeDate     := '';
                //string50 Bondsman              := '';
                string10   BondAmount            := '';
                string50   BondType              := '';

                //from offense
                //string40            RecordID;
                //string100          SourceName;
                //string20            SourceType;
                //string2              StateCode;
                string50             CaseNumber        := '';
                string100            CaseTitle         := '';
                string20             CaseType          := '';
                string100            CaseStatus        := '';
                string8              CaseStatusDate    := '';
                string200            CaseComments      := '';
                string8              FiledDate         := '';
                string100            CaseInfo          := '';
                string30             DocketNumber      := '';
                string30             OffenseCode       := '';
                string100            OffenseDesc       := '';
                string8              OffenseDate       := '';
                string100            OffenseType       := '';
                string20             OffenseDegree     := '';
                string20             OffenseClass      := '';
                string100            DispositionStatus := '';
                //string8            DispositionStatusDate := '';
                string150            Disposition       := '';
                string8              DispositionDate   := '';
                string50             OffenseLocation   := '';
                string100            FinalOffense      := '';
                string8              FinalOffenseDate  := '';
                string4              OffenseCount      := '';
                //string1            VictimUnder18     := '';
                string1              PriorOffenseFlag  := '';
                string20             InitialPlea       := '';
                //string8            InitialPleaDate   := '';
                string20             FinalRuling       := '';
                string8              FinalRulingDate   := '';
                string50             AppealStatus      := '';
                string8              AppealDate        := '';
                string50             CourtName         := '';
                string10             FineAmount        := '';
                string10             CourtFee          := '';
                string10             Restitution       := '';
                string20             TrialType         := '';
                string8              CourtDate         := '';
								string8              classification_code := '';
                //string             County            := '';

                //from sentence
                string8              SentenceDate       := '';
                string8              SentenceBeginDate  := '';
                string8              SentenceEndDate    := '';
                string20             SentenceType       := '';
                string10             SentenceMaxYears   := '';
                string10             SentenceMaxMonths  := '';
                string10             SentenceMaxDays    := '';
                string10             SentenceMinYears   := '';
                string10             SentenceMinMonths  := '';
                string10             SentenceMinDays    := '';
                string8              ScheduledReleaseDate      := '';
                string8              ActualReleaseDate         := '';
                string100            SentenceStatus            := '';
                string10             TimeServedYears           := '';
                string10             TimeServedMonths          := '';
                string10             TimeServedDays            := '';
                string10             PublicServiceHours        := '';
                string200            SentenceAdditionalInfo    := '';
                string50             CommunitySupervisionCounty:= '';
                string10             CommunitySupervisionYears := '';
                string10             CommunitySupervisionMonths:= '';
                string10             CommunitySupervisionDays  := '';
                string10             ParoleMaxYears         := '';
                string10             ParoleMaxMonths        := '';
                string10             ParoleMaxDays          := '';
                string10             ParoleMinYears         := '';
                string10             ParoleMinMonths        := '';
                string10             ParoleMinDays          := '';
                string8              ProbationBeginDate     := '';
                string8              ProbationEndDate       := '';
                string10             ProbationMaxYears      := '';
                string10             ProbationMaxMonths     := '';
                string10             ProbationMaxDays       := '';
                string10             ProbationMinYears      := '';
                string10             ProbationMinMonths     := '';
                string10             ProbationMinDays       := '';
                string100            ProbationStatus        := '';
								string100             sourceid              := '';
                //
end;

layout_j_final to_j1(def l, off r) := transform
//self.ln_vendor             := trim(hygenics_crim._functions.fn_sourcename_to_vendor(trim(l.sourcename), trim(l.statecode)));
self.fileddate               := r.fileddate;

	self.name := IF( regexfind('([": ,-;/]AKA[": ,-;/])|[(]AKA',l.name),_functions.strip_name_from_AKA(l.name,l.lastname,l.firstname,l.middlename,l.suffix),l.name);

//self.casetitle             := r.casetitle;
self.casetype                := r.casetype;
self.casenumber              := r.casenumber;
self.casestatus              := r.casestatus;
self.offensetype             := r.offensetype;
self.offensecount            := r.offensecount;
self.offensecode             := r.offensecode;
self.offensedesc             := r.offensedesc;
self.dispositiondate         := map(trim(r.dispositiondate) ='19000101' => '',
                                 trim(r.dispositiondate)[1..2] between '19' and '20' 
                                 and length(trim(r.dispositiondate))>=4 
                                 and r.dispositiondate<=stringlib.GetDateYYYYMMDD() => trim(r.dispositiondate),
                                 '');
self.disposition             := r.disposition;
self.offenselocation         := r.offenselocation;
self.courtdate               := MAP(_functions.fn_validate_dt(r.courtdate,'F')=1 => r.courtdate, '');
self.restitution             := r.restitution;
self                         := l;
self                         := r;
end;

j1 := join(def(),off, 
                                left.sourceid=right.sourceid and 
                                left.recordid=right.recordid, 
                                to_j1(left,right),local);

// output(def(recordid ='TXBOWIE10000'));
// output(off(recordid ='TXBOWIE10000'));


layout_j_final to_j2(j1 l, cha r) := transform

  self.citationnumber       := r.citationnumber;
  self.arrestdate           := map(trim(r.arrestdate) in ['19000101','20000000'] => '',
                                trim(r.arrestdate)[1..2] between '19' and '20' and (integer)trim(r.arrestdate)[5..6] <= 12  
                                and length(trim(r.arrestdate))>=4 
                                and r.arrestdate<=stringlib.GetDateYYYYMMDD() => trim(r.arrestdate),
                                '');
  self.CustodyDate          := map(trim(r.CustodyDate)='19000101' => '',
                                   trim(r.CustodyDate)[1..2] between '19' and '20' and (integer)trim(r.CustodyDate)[5..6] <= 12  
                                   and length(trim(r.Custodydate))>=4
                                   and r.CustodyDate<=stringlib.GetDateYYYYMMDD() => trim(r.CustodyDate),
                                   '');
  Self.ArrestingAgency      := r.ArrestingAgency;
  Self.CustodyLocation      := r.CustodyLocation;
  Self.InitialCharge        := r.InitialCharge;
  Self.InitialChargeDate    := map(trim(r.InitialChargeDate) ='19000101' => '',
                                   trim(r.InitialChargeDate)[1..2] between '19' and '20' 
                                   and length(trim(r.InitialChargedate))>=4 
                                   and r.InitialChargeDate<=stringlib.GetDateYYYYMMDD() => trim(r.InitialChargeDate),
                                   '');           
  Self.InitialChargeCancelledDate              := r.InitialChargeCancelledDate ;
  Self.ChargeDisposed        := r.ChargeDisposed;
  Self.ChargeDisposedDate    := map(trim(r.ChargeDisposedDate) ='19000101' => '',
                                    trim(r.ChargeDisposedDate)[1..2] between '19' and '20' 
                                    and length(trim(r.ChargeDisposeddate))>=4 
                                    and r.ChargeDisposedDate<=stringlib.GetDateYYYYMMDD() => trim(r.ChargeDisposedDate),
                                    '');
  Self.ChargeSeverity        := r.ChargeSeverity;
  Self.ChargeDisposition     := r.ChargeDisposition;
  Self.AmendedCharge         := r.AmendedCharge;
  Self.AmendedChargeDate     := map(trim(r.AmendedChargeDate) ='19000101' => '',
                                trim(r.AmendedChargeDate)[1..2] between '19' and '20' 
                                and length(trim(r.AmendedChargedate))>=4 
                                and r.AmendedChargeDate<=stringlib.GetDateYYYYMMDD() => trim(r.AmendedChargeDate),
                                '');           
  self                       := l;
  self                       := r;
end;

j2 := join(j1, cha, left.sourceid=right.sourceid and left.recordid=right.recordid and left.caseid=right.caseid, 
                    to_j2(left,right), left outer, local);
                                               
//output(choosen(j2,25));

layout_j_final to_j3(j2 l, sen r) := transform
               self.SentenceDate                       := r.sentencedate;
                self.SentenceBeginDate                 := r.SentenceBeginDate;
                self.SentenceEndDate                   := r.SentenceEndDate;
                self.SentenceType                      := r.SentenceType         ;
                self.SentenceMaxYears                  := r.SentenceMaxYears;
                self.SentenceMaxMonths                 := r.SentenceMaxMonths;
                self.SentenceMaxdays                   := r.SentenceMaxdays;
                self.SentenceMinYears                  := r.SentenceMinYears;
                self.SentenceMinMonths                 := r.SentenceMinMonths;
                self.SentenceMinDays                   := r.SentenceMinDays;
                //self.ScheduledReleaseDate    := '';
                //self.ActualReleaseDate        := '';
                self.SentenceStatus                    := r.SentenceStatus;
                self.TimeServedYears                   := r.TimeServedYears;
                self.TimeServedMonths                  := r.TimeServedMonths;
                self.TimeServedDays                    := r.TimeServedDays;
                self.PublicServiceHours                := r.PublicServiceHours;
                self.SentenceAdditionalInfo            := r.SentenceAdditionalInfo;
                self.CommunitySupervisionCounty        := r.CommunitySupervisionCounty;
                self.CommunitySupervisionYears         := r.CommunitySupervisionYears;
                self.CommunitySupervisionMonths        := r.CommunitySupervisionMonths;
                self.CommunitySupervisionDays          := r.CommunitySupervisionDays;
                self.ProbationBeginDate                := map(trim(r.ProbationBeginDate) ='19000101' => '',
                                                       trim(r.ProbationBeginDate)[1..2] between '19' and '20' 
                                                       and length(trim(r.ProbationBeginDate))>=4 => trim(r.ProbationBeginDate),       
                                                                                                                                                                                                                                                                                                                                '');
                                                                                                                                                                                                                                                                                                                                
                self.ProbationEndDate                  := map(trim(r.ProbationEndDate) ='19000101' => '',
                                                              trim(r.ProbationEndDate)[1..2] between '19' and '20' 
                                                              and length(trim(r.ProbationEndDate))>=4 =>trim(r.ProbationEndDate),     
                                                                                                                                                                                                                                                                                                                                '');
                self.ProbationMaxYears                 := r.ProbationMaxYears;
                self.ProbationMaxMonths                := r.ProbationMaxMonths;
                self.ProbationMaxDays                  := r.ProbationMaxDays;
                self.ProbationMinYears                 := r.ProbationMinYears;
                self.ProbationMinMonths                := r.ProbationMinMonths;
                self.ProbationMinDays                  := r.ProbationMinDays;
                self.ProbationStatus                   := r.ProbationStatus;
                self.ParoleMaxYears                    := r.ParoleMaxYears;
                self.ParoleMaxMonths                   := r.ParoleMaxMonths;
                self.ParoleMaxDays                     := r.ParoleMaxDays;
                self.ParoleMinYears                    := r.ParoleMinYears;
                self.ParoleMinMonths                   := r.ParoleMinMonths;
                self.ParoleMinDays                     := r.ParoleMinDays;
self := l;
//self := r;
end;
j3 := join(j2,sen,left.recordid=right.recordid and  left.sourceid=right.sourceid and left.caseid=right.caseid, 
           to_j3(left,right), left outer, local);

j_final := j3;

//output(j_final,, '~thor::base::hygenics::sample::court_offenses_new_20110113', overwrite);
//output(j3);
//output(j3(recordid ='TXBOWIE10000'));
 // output(j3(recordid ='OHMARIONMUNI1030 '));
hygenics_crim.Layout_Common_Court_Offenses_orig to_court_offenses(j_final l) := transform

                //-----field from charge file that were not mapped 
                // string50           Bondsman;
                // string10           BondAmount;
                // string50           BondType;
                // string20           ChargeSeverity;
                // string8             CustodyDate;
                // string50           CustodyLocation;
                // string8             InitialChargeDate;  - convict date
                // string8             InitialChargeCancelledDate;
                // string8             AmendedChargeDate;
                //------ field from offense file that were not mapped 
                // string100         CaseStatus;
                // string8                             CaseStatusDate;
                // string200         CaseComments;               
                // string100         CaseInfo;
                // string20             OffenseDegree;
                // string100         DispositionStatus;
                // string8                             DispositionStatusDate;
                // string50             OffenseLocation;
                // string8                             FinalOffenseDate;
                // string1                             VictimUnder18;
                // string1                             PriorOffenseFlag;
                // string8                             InitialPleaDate;
                // string50             AppealStatus;
                // string10             Restitution;
                
                // string8                             CourtDate;
                //-------------------------------------------------
                
                
  self.process_date           := stringlib.getdateyyyymmdd();
  string temp_case_number     := MAP(stringlib.stringfind(l.casenumber,'HTTP/',1) >0 =>'',
                                     l.casenumber);   
  vVendor                     := hygenics_crim._functions.fn_sourcename_to_vendor(trim(l.sourcename), trim(l.statecode));
  vcase_type                  := '';
  self.offender_key           := MAP(l.nametype ='A' => '', 
                                     hygenics_crim._functions.fn_persistent_offender_key(vVendor, l.name, l.dob, l.docnumber, l.inmatenumber, 
                                                                                         l.stateidnumber, l.fbinumber, temp_case_number, l.fileddate, vcase_type)
                                                                                                                                                                                                                                                                                                                                                );
  //self.offender_key                                                       := hygenics_crim._functions.fn_offender_key(vVendor, l.recordid,temp_case_number,l.fileddate);
  self.vendor                 := vVendor;
  self.state_origin           := trim(l.statecode);
  self.source_file            := trim(hygenics_crim._functions.fn_shorten_sourcename(l.sourcename));            
  self.off_comp               := '';
  self.off_delete_flag        := '';
                
  // Not sure if Initialchargedate or AmendedChargeDate can be mapped to offense date
  self.off_date               := map(trim(l.offensedate) = '19000101' => '',
                                     trim(l.offensedate)[1..2] between '19' and '20' and 
                                     length(trim(l.offensedate))>=4 and l.offensedate<=stringlib.GetDateYYYYMMDD() => trim(l.offensedate),
                                     '');
  self.arr_date               := if (trim(l.arrestdate)= '*','',trim(l.arrestdate));
  self.num_of_counts          := MAP(vVendor = 'UU'   => (string)((integer)l.offensecount),
	                                   regexfind('&N(B)*',l.offensecount) => regexreplace('([0-9]+)&N(B)*',l.offensecount,'$1'),
	                                   regexfind('[A-Z]',l.offensecount) => '',
	                                   (integer)(l.offensecount) = 0  => '',
	                                   (integer)(l.offensecount) > 99 => '',
	                                   trim(l.offensecount));

  self.le_agency_cd           := '';
  self.le_agency_desc         := MAP(l.arrestingagency <> '' => trim(l.arrestingagency),
                                                   regexfind('(ISSUING AGENCY: )([A-Z]+[A-Z ]);(.*)',l.casecomments) =>  trim(regexreplace('(ISSUING AGENCY: )([A-Z]+[A-Z ]);(.*)',l.casecomments,'$2'),left,right),
                                                   regexfind('ISSUING AGENCY: ',l.casecomments) =>  trim(regexreplace('(ISSUING AGENCY: )(.*)',l.casecomments,'$2'),left,right),
                                                   regexfind('FILING AGENCY:',l.casecomments) =>  trim(regexreplace('(FILING AGENCY: )(.*)',l.casecomments,'$2'),left,right),
                                                   regexfind('FILING AGENCY:',l.caseinfo) =>  trim(regexreplace('(FILING AGENCY: )(.*)',l.caseinfo,'$2'),left,right),                                                                                                                                                                                                                                                                                  
                                                   regexfind('AGENCY:',l.caseinfo) =>  trim(regexreplace('(AGENCY: )(.*)',l.caseinfo,'$2'),left,right),
                                                   regexfind('(ORIGINATING AGENCY:) ([A-Z]+[A-Z ]*),(.*)',l.casecomments) => trim(regexreplace('(ORIGINATING AGENCY:) ([A-Z]+[A-Z ]*),(.*)',l.casecomments,'$2'),left,right),
                                                   regexfind('JURISDICTION: ',l.caseinfo)  and vVendor not in ['QO']=> trim(regexreplace('(JURISDICTION: )([a-zA-Z]+)',l.caseinfo,'$2'),left,right),                                                                                                                                                                                                                                                           
                                                   '');
  self.le_agency_case_number  := trim(l.bookingnumber);
                
  self.traffic_ticket_number  := if(l.statecode not in ['NJ'],
                                    l.CitationNumber,
                                    '');
  self.traffic_dl_no          := trim(l.DLNumber);
  self.traffic_dl_st          := trim(l.DLState);
                
  self.arr_off_code           := '';
  self.arr_off_desc_1         := trim(l.initialcharge);               // split accross multiple fields on whitespace breakpoint?, use all charge fields?
  self.arr_off_desc_2         := trim(if(l.amendedcharge<>'', 'AMENDED:'+                ' '+l.amendedcharge,''));
  self.arr_off_type_cd        := '';
  self.arr_off_type_desc      := '';
  self.arr_off_lev            := '';
  self.arr_statute            := '';
  self.arr_statute_desc       := '';
  self.arr_disp_date          := if(trim(l.chargedisposeddate)[1..2] between '19' and '20' 
                                     and l.chargedisposeddate<=stringlib.GetDateYYYYMMDD(),
                                     trim(l.chargedisposeddate),'');
  self.arr_disp_code          := '';
  self.arr_disp_desc_1        := MAP( vVendor = 'FQ' => l.caseinfo,
                                    trim(l.chargedisposed));                           
  self.arr_disp_desc_2        := '';
  self.pros_refer_cd          := '';
  self.pros_refer             := '';
  self.pros_assgn_cd          := '';
  self.pros_assgn             := '';
  self.pros_chg_rej           := '';
  self.pros_off_code          := '';
  self.pros_off_desc_1        := '';
  self.pros_off_desc_2        := '';
  self.pros_off_type_cd       := '';
  self.pros_off_type_desc     := '';
  self.pros_off_lev           := '';
  self.pros_act_filed         := '';    
  self.court_case_number      := temp_case_number;
  self.court_cd               := '';
  self.court_desc             := trim(stringlib.stringtouppercase(l.courtname));
  self.court_appeal_flag      := '';
  self.court_final_plea       := MAP(regexfind('[0-9]+/[0-9]+/',l.InitialPlea) => '',
	                                   l.InitialPlea ='&NBSP;' => '',                        
                                     trim(l.InitialPlea)
                                                                                                                                                                                                                                                                                                );
                                                                                                                                                                                                                                                                                                
  string temp_offense         := MAP(trim(l.FinalOffense) <> '' => trim(l.FinalOffense),
																		 trim(l.offensedesc)  <> '' => trim(l.offensedesc),
																		 '');
																																																																																																																																									
	self.court_off_code         := MAP(vVendor IN ['LB','UB','QN','QX','QZ','IB','PZ','UW','UX','YC','YE','WU','VW','VO','VP','7Y','8G','8I','W0155','W0156','W0157','W0266'] => '',
																		 regexfind('[a-zA-Z0-9.]+[(a-zA-Z)]*[(0-9)]*:',temp_offense) =>'',
																		 regexfind('[a-zA-Z0-9.]+[.][(a-zA-Z)]*[(0-9)]*', l.offensecode) =>  '',
																		 regexfind('FELONY|MISDEMEANOR',l.offensecode) =>'',
                                     trim(l.offensecode));                    
                //old mapping                                                                                                                                                                                                                                                                   
  /*self.court_off_desc_1     := MAP(vVendor ='CF' => l.casetype,
                                     vVendor IN ['LB','QN','QX','QZ','IB'] => '',
                                     regexfind('[a-zA-Z0-9.]+[(a-zA-Z)]*[(0-9)]*:',temp_offense) =>'',
                                     regexfind('[a-zA-Z0-9.]+[.][(a-zA-Z)]*[(0-9)]*', l.offensecode)=>'',        																															 length(trim(temp_offense, left, right))<3 => '',
																																																																																								 temp_offense);*/
	LE_court_statute            := Map(regexfind('(.*) ([/(]*[0-9:]+[0-9:.]+[ A-Z]*[/( 0-9A-Z/)]*[/)]), ([A-Z])',l.finaloffense) => trim(regexreplace('(.*) ([/(]*[0-9:]+[0-9:.]+[ A-Z]*[/( 0-9A-Z/)]*[/)]), ([A-Z])',l.finaloffense,'$2'),left,right),
																		 regexfind('(.*) ([0-9:]+[0-9:.]+[ A-Z]*[/( 0-9A-Z/)]*), ([A-Z])',l.finaloffense)       => trim(regexreplace('(.*) ([0-9:]+[0-9:.]+[ A-Z]*[/( 0-9A-Z/)]*), ([A-Z])',l.finaloffense,'$2'),left,right),
																		 l.offensecode);
																																																																																																																																									
                                                                                                                                                                                                                                                                                                 
  LE_court_statute_desc       := Map(regexfind('(.*) ([/(]*[0-9:]+[0-9:.]+[ A-Z]*[/( 0-9A-Z/)]*[/)]), ([A-Z])',l.finaloffense) => trim(regexreplace('(.*) ([/(]*[0-9:]+[0-9:.]+[ A-Z]*[/( 0-9A-Z/)]*[/)]), ([A-Z])',l.finaloffense,'$1'),left,right),
                                     regexfind('(.*) ([0-9:]+[0-9:.]+[ A-Z]*[/( 0-9A-Z/)]*), ([A-Z])',l.finaloffense)       => trim(regexreplace('(.*) ([0-9:]+[0-9:.]+[ A-Z]*[/( 0-9A-Z/)]*), ([A-Z])',l.finaloffense,'$1'),left,right),
                                     l.finaloffense <> '' => l.finaloffense,
                                     l.offensedesc);
																		 
	UK_Court_statute            := MAP(regexfind('(.*)[ ]-(.*)[ ]*-[ ]*(.*)',temp_offense) => regexreplace(       '(.*)[ ]*-(.*)[ ]*-[ ]*(.*)',temp_offense,'$1'),
																	   regexfind('(.*)[ ]-(.*)',temp_offense) => regexreplace(             '(.*)[ ]*-(.*)',temp_offense,'$1'),
																	   '');

	UK_Court_statute_desc       := MAP(UK_Court_statute ='' => trim(temp_offense),
																	   regexfind('[0-9]',UK_Court_statute) and regexfind('(.*)[ ]-(.*)[ ]*-[ ]*(.*)',temp_offense) => regexreplace(    '(.*)[ ]*-(.*[ ]*-[ ]*.*)',temp_offense,'$2'),
																		 regexfind('[0-9]',UK_Court_statute) and regexfind('(.*)[ ]-(.*)',temp_offense) => regexreplace(                '(.*)[ ]-(.*)',temp_offense,'$2'),
																		 trim(temp_offense)
                                     );
                
// ..new mapping - we want to map everything to court_off_desc
self.court_off_desc_1         := trim(MAP(vVendor ='TS' and regexfind('[0-9.]+[ ]*([/(]*[A-Z0-9][/)]*)*[ ]*[A-Z]+' ,trim(temp_offense)) => 'NOT SPECIFIED',
                                     vVendor ='TV' and regexfind('I[0-9.]+[ ]*([/(]*[A-Z0-9][/)]*)*[ ]*[A-Z]+' ,trim(temp_offense)) => 'NOT SPECIFIED',
                                     vVendor ='TV' and regexfind('[0-9.]+[ ]*([/(]*[A-Z0-9][/)]*)*[ ]*[A-Z]+' ,trim(temp_offense)) => 'NOT SPECIFIED',
                                     vVendor ='UH' and trim(temp_offense)<> 'NOT SPECIFIED' => '',                           
                                     vVendor ='CF' => l.casetype,
                                     vVendor ='LB' => LE_court_statute_desc,
                                     vVendor ='UK' => UK_Court_statute_desc,
                                     vVendor IN ['UB','QN','QX','QZ','IB','UW','UX','YC','YE','WU','VW','VO','VP'] => temp_offense,
                                     regexfind('[a-zA-Z]+[0-9.]+[(a-zA-Z)]*[(0-9)]*:',temp_offense)=>  trim(regexreplace('([a-zA-Z]+[0-9.]+[/(a-zA-Z/)]*[(0-9)]*:)(.*)',temp_offense,'$2'),left,right),
                                     regexfind('[0-9.]+[a-zA-Z]+[(a-zA-Z)]*[(0-9)]*:',temp_offense)=>  trim(regexreplace('([0-9.]+[a-zA-Z]+[/(a-zA-Z/)]*[(0-9)]*:)(.*)',temp_offense,'$2'),left,right),
                                     temp_offense
                                     ),left,right);                                                            
                                                                                                                                                                                                                                                                                                
  self.court_off_desc_2        := MAP(stringlib.stringfind(l.caseinfo,'REASON:',1) >0 => l.caseinfo,
                                      '');
  self.court_off_type_cd       := '';
  self.court_off_type_desc     := '';
                
	offensetype   := trim(l.offensetype);
	offenseclass  := MAP( regexfind('&NBS([P;])*',l.offenseclass) => regexreplace('([A-Z][A-Z0-9]*)(&NBS([P;]*))',l.offenseclass,'$1'),
	                      regexfind('(.*) OF (.*)',l.offenseclass) => regexreplace('(.*) OF (.*)',l.offenseclass,'$1 $2'),
	                      trim(stringlib.stringfilterout(l.offenseclass,'-][')));
	offensedegree := MAP( regexfind('&NBS([P;])*',l.offensedegree) => regexreplace('([A-Z0-9])(&NBS([P;]*))',l.offensedegree,'$1'),
	                      l.offensedegree ='N/A' => '',	                      
												l.offensedegree ='NOT APPLICABLE' => '',
												l.sourcename ='FLORIDA_ESCAMBIA_COUNTY_CIRCUIT_COURT' => trim(stringlib.stringfilterout(l.offensedegree,'-+/.')),
												trim(l.offensedegree)
											);
  //off_lev												
	off_lev       := trim(MAP( trim(offensedegree)+trim(offensetype)+trim(offenseclass) IN ['UNCLASSIFIED','UNKNOWN OFFENSE TYPE','CONVERSION',
																																															 'NOT SPECIFIED','NULL','UNKNOWN','OTHER','XX','X','U',														
                                     																																																																																																																																																																																																																																																																																																																																														'CONVERTED DEGREE OF','DISMISSED','OTHR','[',']'] => '',
														offensedegree ='CAPITAL FELONY' => 'CF',
														offenseclass  ='CAPITAL FELONY' => 'CF',
														offensedegree ='STATE FELONY' => 'SF',
														offenseclass  ='STATE FELONY' => 'SF',
														offensedegree ='SPECIAL FELONY' => 'SPF',
														offensedegree ='COMPACT FELONY' => 'FCO',
														offensedegree ='COMPACT MISDEMEANOR' => 'MCO',
														offensedegree ='INFRACTION' => 'I',
														offensedegree ='INFRACTION (I)' => 'I',
														offensedegree ='TRAFFIC INFRACTION' => 'TI',
														offensedegree ='FELONY/LIFE' => 'FL',
														offensedegree ='CAPITOL FELONY' => 'FCAP',
														offenseclass  ='MISDEMEANOR CLASS AP' =>'MAP',
														offenseclass  ='MINOR OFFENSE'        =>'MINOR',
														offenseclass  ='CONSERVATION VIOLATI' =>'CVIO',
                            offenseclass  ='CONTEMPT OF COURT'    =>'COC',

														
														trim(trim(trim(offensedegree)+' '+trim(offensetype))+' '+trim(offenseclass),left,right)  ='PETTY MISDEMEANOR' => 'PM',  
														trim(trim(trim(offensedegree)+' '+trim(offensetype))+' '+trim(offenseclass),left,right) IN ['MINOR MISDEMEANOR','MISDEMEANOR MINOR'] => 'MM',
                            trim(trim(trim(offensedegree)+' '+trim(offensetype))+' '+trim(offenseclass),left,right)  ='GROSS MISDEMEANOR' => 'GM',
														trim(offensedegree)+trim(offensetype)+trim(offenseclass) IN ['TRAFFIC'] => 'T',
														trim(offensedegree)+trim(offensetype)+trim(offenseclass) IN ['N/ANON-MOVING INFRACTIO'] => 'I',													
														trim(trim(offensedegree)+' '+trim(offensetype)+' '+trim(offenseclass),left,right) IN ['FELONY SPECIAL'] => 'SF',													


														trim(trim(offensedegree)+' '+trim(offenseclass),left,right) IN ['S JF','SFJ','SJ - FELONY','SJ FELONY','SJF','SJFELONY','SJ-FELONY',
														     'FELONY STATE JAIL','STATE JAIL FELON Y','STATE JAILFELONY','STATE JAIL FELONY','FELON Y-STATE JAIL'] => 'FSJ',
														trim(offensedegree)+trim(offensetype)+trim(offenseclass)  ='AF1' => 'AF1',
														trim(offensedegree)+trim(offensetype)+trim(offenseclass)  ='AF2' => 'AF2',
														trim(offensedegree)+trim(offensetype)+trim(offenseclass)  ='AF3' => 'AF3',
														trim(offensedegree)+trim(offensetype)+trim(offenseclass)  IN ['MU','FU','CF','UM','MM','M1','M2','M3','M4','M5','MA','MB','MC','M*','F1','F2','F3','F4',
														                                                              'MI','MT','F5','FX','FS','F*','UNM'] => trim(offensedegree)+trim(offensetype)+trim(offenseclass),
																												
														trim(trim(offensedegree)+' '+trim(offenseclass),left,right) IN ['FIRST DEGREE LIFE','FIRST DEGREE, LIFE'] => 'FL1',
														trim(trim(offensedegree)+' '+trim(offenseclass),left,right) IN ['LIFE'] => 'LIFE',
														trim(trim(offenseclass)+' '+trim(offensedegree),left,right) IN ['AGG F1','AGG F-1','AGGRAVATED FELONY 1','AGGRAVATED FELONY ONE','AGG. FELONY ONE','AGG 1ST DEGREE FELON'] => 'AGGF1',
														trim(trim(offenseclass)+' '+trim(offensedegree),left,right) IN ['AGG F2','AGG F-2','AG F2','AG F-2','AGGRAVATED FELONY 2','AGGRAVATED FELONY TWO','AGG. FELONY TWO','AGG 2ND DEGREE FELON'] => 'AGGF2',
														trim(trim(offenseclass)+' '+trim(offensedegree),left,right) IN ['AG F3','AG F-3','AGG F3','AGG F-3','AGGRAVATED FELONY 3','AGGRAVATED FELONY THREE','AGG. FELONY THREE','AGG 3RD DEGREE FELON'] => 'AGGF3',
														trim(trim(offenseclass)+' '+trim(offensedegree),left,right) IN ['AGGRAVATED FELONY 4','AGGRAVATED FELONY FOUR','AGG. FELONY FOUR','AGG 4TH DEGREE FELON'] => 'AGGF4',
														trim(trim(offenseclass)+' '+trim(offensedegree),left,right) IN ['LIFE'] => 'LIFE',
														trim(trim(offenseclass)+' '+trim(offensedegree),left,right) IN ['COUNTY'] => 'COR',
														trim(trim(offenseclass)+' '+trim(offensedegree),left,right) IN ['MUNICIPAL','MUNICIPAL (CITY) ORD'] => 'MOR',
														trim(trim(offenseclass)+' '+trim(offensedegree),left,right) IN ['JUVENILE PETTY OFFEN'] => 'JPETTY',
														trim(trim(offenseclass)+' '+trim(offensedegree),left,right) IN ['JUVENILE TRAFFIC OFF'] => 'JT',
														trim(trim(offenseclass)+' '+trim(offensedegree),left,right) IN ['LOCAL SECOND'] => 'LO2',
														trim(trim(offenseclass)+' '+trim(offensedegree),left,right) IN ['SPECIAL FELONY'] => 'SPF',
														trim(offenseclass)+' '+trim(offensedegree) IN ['MISDEMEANORTWO'] => 'M2',								
                            trim(offenseclass)+' '+trim(offensedegree) IN ['MISDEMEANORUNDEFINED DEGREE'] => 'M',	
														trim(trim(offensedegree) +' '+ trim(offenseclass),left,right) IN ['TRAFFIC MISDEMEANOR','MISDEMEANOR TRAFFIC']=> 'MT',
														
														regexfind('MISD[.]*|MISDE',trim(offensedegree) + trim(offenseclass)) and  regexfind('UNSPECIF|UNCLASS|UNASSIGN',trim(offensedegree) + trim(offenseclass))               => 'M' ,
                            regexfind('FEL|FELONY',trim(offensedegree) + trim(offenseclass)) and      regexfind('UNSPECIF|UNCLASS|UNASSIGN',trim(offensedegree) + trim(offenseclass))               => 'F' ,
                                                             
                            regexfind('MISD[.]*|MISDE',offensedegree) and             regexfind('UNSPECIF|UNCLASS|UNASSIGN',offensedegree)     => 'M' ,
                            regexfind('FEL|FELONY',offensedegree) and                 regexfind('UNSPECIF|UNCLASS|UNASSIGN',offensedegree)     => 'F' ,

														l.sourcename ='TEXAS_BRAZORIA_COUNTY' and offenseclass[3..4]= '",' =>offenseclass[1..2],
														
														// l.sourcename ='FLORIDA_ESCAMBIA_COUNTY_CIRCUIT_COURT' and regexfind('LIFE',offensedegree)=> 'CF' ,
														// l.sourcename ='FLORIDA_ESCAMBIA_COUNTY_CIRCUIT_COURT' and regexfind('FIRST DEGREE[\\, ]LIFE' ,trim(offensedegree))  => 'LIFE1' ,
														// l.sourcename ='FLORIDA_ESCAMBIA_COUNTY_CIRCUIT_COURT' and regexfind('SECOND DEGREE[\\, ]LIFE',trim(offensedegree))  => 'LIFE2' ,
														// l.sourcename ='FLORIDA_ESCAMBIA_COUNTY_CIRCUIT_COURT' and regexfind('THIRD DEGREE[\\, ]LIFE' ,trim(offensedegree))  => 'LIFE3' ,
                            l.sourcename ='FLORIDA_MARION_COUNTY' =>  offenseclass[1..1],
																												
														l.sourcename ='FLORIDA_ESCAMBIA_COUNTY_CIRCUIT_COURT' and regexfind('LIFE' ,trim(offensedegree))  => 'LIFE' ,
														regexfind('AGG([0-9])(ST|RD|TH|ND) DEGREE FELONY',trim(offenseclass)+trim(offensedegree) )  =>regexreplace('AGG([0-9])(ST|RD|TH|ND) DEGREE FELONY',trim(offenseclass)+trim(offensedegree),'AF$1' ) ,
														
														l.sourcename ='ILLINOIS_COOK_COUNTY' and regexfind('FELONY'      ,trim(offenseclass))  => 'F'+trim(offensedegree),
														l.sourcename ='ILLINOIS_COOK_COUNTY' and regexfind('MISDEMEANOR' ,trim(offenseclass))  => 'M'+trim(offensedegree),
														l.sourcename ='ILLINOIS_COOK_COUNTY' and regexfind('TRAFFIC'     ,trim(offenseclass))  => 'T'+trim(offensedegree),													
														l.sourcename ='ILLINOIS_COOK_COUNTY' and regexfind('PETTY'       ,trim(offenseclass))  => 'P'+trim(offensedegree),	
														l.sourcename ='ILLINOIS_COOK_COUNTY' and offenseclass =''                              => '',	
														l.sourcename ='ILLINOIS_COOK_COUNTY' and offenseclass <>''                             => offenseclass[1..1]+trim(offensedegree),	
														                                                                               
                            l.sourcename ='OHIO_HARDIN_COUNTY'    and offenseclass ='' => '',	
														l.sourcename ='KANSAS_JOHNSON_COUNTY' and offenseclass ='' => '',	                                                                        
                            l.sourcename ='OHIO_ALLEN_COUNTY_LIMA_MUNICIPAL_COURT' and offenseclass ='' => '',	                                                               
                            l.sourcename ='OHIO_MONROE_COUNTY_COMMON_PLEAS_COURT' and offenseclass ='' => '',
														l.sourcename ='OHIO_MONTGOMERY_COUNTY_WEB' and offenseclass ='' => '',
														l.sourcename ='OHIO_CLINTON_COUNTY' and offenseclass ='' => '',                                                                                 
                            l.sourcename ='OHIO_STARK_COUNTY' and offenseclass ='' => '',                                                                                    
                            // l.sourcename ='OHIO_HARDIN_COUNTY'  => trim(offensedegree),
													
                            l.sourcename ='OHIO_BUTLER_COUNTY' and regexfind('ATTEMPT',offensedegree) =>'',
                             //FL leon
                            l.sourcename ='FLORIDA_LEON_COUNTY' and regexfind('MISDEMEANOR',Offensedegree) => 'M', 
                            l.sourcename ='FLORIDA_LEON_COUNTY' and regexfind('FEL',Offensedegree) => 'F',
                            l.sourcename ='FLORIDA_LEON_COUNTY' and regexfind('TRAFFIC INFRACTIO',Offensedegree) => 'TI',
                            l.sourcename ='FLORIDA_LEON_COUNTY' and regexfind('NON-TRAFFIC INFRACTI',Offensedegree) => 'I',
                            l.sourcename ='FLORIDA_LEON_COUNTY' and regexfind('CRIMINAL TRAFFIC',Offensedegree) => 'CT',
                            l.sourcename ='FLORIDA_LEON_COUNTY' and regexfind('MUNICIPAL ORDINANCE',Offensedegree) => 'MO',
                            l.sourcename ='FLORIDA_LEON_COUNTY' and regexfind('COUNTY ORDINANCE',Offensedegree) => 'CO',
                            l.sourcename ='FLORIDA_LEON_COUNTY' and regexfind('C. MM FINES AND COST',Offensedegree) => 'CM',
                            l.sourcename ='FLORIDA_LEON_COUNTY' and regexfind('D. CF COST AND FINES',Offensedegree) => 'CF',
                            l.sourcename ='FLORIDA_LEON_COUNTY' and regexfind('TR - COLLECTION',Offensedegree) => 'TR-CO',
                                                                                                                                                                                                                                                                
                            regexfind('AGG (ONE|FIRST|1ST)[ DEGREE]*F[ELONY]*',trim(offensetype) + ' '+ trim(offensedegree)) => 'AGF1' ,
														regexfind('AGG (SECOND|2ND)[ DEGREE]*F[ELONY]*',trim(offensetype) + ' '+ trim(offensedegree)) => 'AGF2' ,
														regexfind('AGG (THIRD|3RD)[ DEGREE]*F[ELONY]*' ,trim(offensetype) + ' '+ trim(offensedegree))=> 'AGF3' ,
														regexfind('AGG (FOUR|FOURTH|4TH)[ DEGREE]*F[ELONY]*',trim(offensetype) + ' '+ trim(offensedegree)) => 'AGF4' ,
														regexfind('AGG (FIFTH|5TH)[ DEGREE]* F[ELONY]*',trim(offensetype) + ' '+ trim(offensedegree)) => 'AGF5' ,
																
                            regexfind('([0-9])(ST|RD|TH|ND)[ ](DEGREE)[ ](M)(ISD)(EMEAN)*(OR)*',offensedegree) => regexreplace('([0-9])(ST|RD|TH|ND)[ ](DEGREE)[ ](M)(ISD)(EMEAN)*(OR)*',offensedegree,'$4$1'),       
                            regexfind('([0-9])(ST|RD|TH|ND)[ ](DEGREE)[ ](F)(EL)(ONY)*',offensedegree) => regexreplace('([0-9])(ST|RD|TH|ND)[ ](DEGREE)[ ](F)(EL)(ONY)*',offensedegree,'$4$1'),       
                            
														l.sourcename ='OHIO_SUMMIT_COUNTY' and 
                            regexfind('([0-9])(ST|RD|TH|ND)[ ](DEGREE)[ ](M)(ISDEMEANOR)',trim(offensedegree)+' '+offenseclass) => regexreplace('([0-9])(ST|RD|TH|ND)[ ](DEGREE)[ ](M)(ISDEMEANOR)',trim(offensedegree)+' '+offenseclass,'$4$1'),       
                            l.sourcename ='OHIO_SUMMIT_COUNTY' and 
                            regexfind('([0-9])(ST|RD|TH|ND)[ ](DEGREE)[ ](F)(ELONY)',trim(offensedegree)+' '+offenseclass) => regexreplace('([0-9])(ST|RD|TH|ND)[ ](DEGREE)[ ](F)(ELONY)',trim(offensedegree)+' '+offenseclass,'$4$1'),       
                            l.sourcename ='OHIO_SUMMIT_COUNTY' and 
                            regexfind('MINOR MISDEMEANOR',trim(offensedegree)+' '+offenseclass) => 'MM',       
                            
                            
                            l.sourcename ='TEXAS_COLLIN_COUNTY' => trim(offensedegree)[1..1]+offenseclass[1..1],
                            // l.sourcename ='OHIO_CLINTON_COUNTY' => trim(offensedegree),
                            //l.sourcename ='TEXAS_BRAZORIA_COUNTY' => trim(offensedegree),
                            // l.sourcename ='OHIO_FRANKLIN_COUNTY' =>  trim(offensetype),
                            // l.sourcename ='OHIO_FRANKLIN_COUNTY_MUNICIPAL_COURT' => trim(offensedegree),   
                            l.sourcename ='OHIO_GREENE_COUNTY_XENIA_MUNICIPAL_COURT' and length(trim(offensedegree))< 4 => trim(offensedegree,all),                                                            
                            // l.sourcename ='OHIO_STARK_COUNTY_COMMON_PLEAS_COURT' => trim(offensedegree,all), 
                            l.sourcename ='OHIO_SUMMIT_COUNTY' => trim(offenseclass,all),                                                                                  
                            l.sourcename ='TEXAS_EL_PASO_COUNTY' => trim(offensedegree,all),     
                            l.sourcename ='OHIO_TRUMBULL_COUNTY'  and   regexfind('LIFE|AF',Offensedegree) => trim(offensedegree),
														
                            l.sourcename ='FLORIDA_MARION_COUNTY' and   regexfind('M[ISDEMEANOR]*[- ]*(ONE|FIRST|1ST)[ DEGREE]*',trim(offenseclass)  + ' '+ trim(offensedegree)) => 'M1' ,
                            l.sourcename ='FLORIDA_MARION_COUNTY' and   regexfind('M[ISDEMEANOR]*[- ]*(MINOR)',trim(offenseclass)  + ' '+ trim(offensedegree)) => 'MM' ,
                            l.sourcename ='FLORIDA_MARION_COUNTY' and   regexfind('M[ISDEMEANOR]*[- ]*(SECOND|2ND)[ DEGREE]*',trim(offenseclass) + ' '+ trim(offensedegree))=> 'M2' ,
                            l.sourcename ='FLORIDA_MARION_COUNTY' and   regexfind('M[ISDEMEANOR]*[- ]*(THIRD|3RD)[ DEGREE]*',trim(offenseclass) + ' '+ trim(offensedegree))=> 'M3' ,
                            l.sourcename ='FLORIDA_MARION_COUNTY' and   regexfind('M[ISDEMEANOR]*[- ]*(FOUR|FOURTH|4TH)[ DEGREE]*',trim(offenseclass) + ' '+ trim(offensedegree))=> 'M4',
														
                            l.sourcename ='FLORIDA_MARION_COUNTY' and   regexfind('F[ELONY]*[- ]*(ONE|FIRST|1ST)[ DEGREE]*',trim(offenseclass)  + ' '+ trim(offensedegree)) => 'F1' ,
                            l.sourcename ='FLORIDA_MARION_COUNTY' and   regexfind('F[ELONY]*[- ]*(SECOND|2ND)[ DEGREE]*',trim(offenseclass) + ' '+ trim(offensedegree))=> 'F2' ,
                            l.sourcename ='FLORIDA_MARION_COUNTY' and   regexfind('F[ELONY]*[- ]*(THIRD|3RD)[ DEGREE]*',trim(offenseclass) + ' '+ trim(offensedegree))=> 'F3' ,
                            l.sourcename ='FLORIDA_MARION_COUNTY' and   regexfind('F[ELONY]*[- ]*(CAPITAL)',trim(offenseclass) + ' '+ trim(offensedegree))=> 'FC',
                            l.sourcename ='FLORIDA_MARION_COUNTY' and   regexfind('F[ELONY]*[- ]*(LIFE)',trim(offenseclass) + ' '+ trim(offensedegree))=> 'FL', 
														
														l.sourcename ='OHIO_MAHONING_COUNTY' and offensedegree <> '' => trim(offensedegree),
                            l.sourcename ='OHIO_LUCAS_COUNTY_COMMON_PLEAS_COURT' => trim(offensetype)+trim(offensedegree),
														
														l.sourcename ='FLORIDA_BROWARD_COUNTY' and offenseclass = 'FELONY' => 'F',
														l.sourcename ='FLORIDA_BROWARD_COUNTY' and offenseclass = 'MISDEMEANOR' => 'M',
                            l.sourcename ='FLORIDA_BROWARD_COUNTY' and offenseclass = 'MUNICIPAL ORDINANCE' => 'MO',
                            l.sourcename ='FLORIDA_BROWARD_COUNTY' and offenseclass = 'TRAFFIC CRIMINAL' => 'T',
														
                            // l.sourcename ='TEXAS_VICTORIA_COUNTY' and 
                            // offensetype+offensedegree+offenseclass = '' and 
                            // stringlib.stringfind(casetype, 'INDIC',1) =0 and 
                            // casetype <> 'INFORMATION' => trim(offensedegree,all), 
                            regexfind('PETTY MISD[EMEANOR]*[- ]*(ONE|FIRST|1ST|1)[ DEGREE]*',trim(offenseclass)  + ' '+ trim(offensedegree)) => 'PM1' ,
														regexfind('PETTY MISD[EMEANOR]*[- ]*(SECOND|2ND|2)[ DEGREE]*',trim(offenseclass) + ' '+ trim(offensedegree))=> 'PM2' ,
														regexfind('PETTY MISD[EMEANOR]*[- ]*(THIRD|3RD|3)[ DEGREE]*',trim(offenseclass) + ' '+ trim(offensedegree))=> 'PM3' ,
														regexfind('PETTY MISD[EMEANOR]*[- ]*(FOUR|FOURTH|4TH|4)[ DEGREE]*',trim(offenseclass) + ' '+ trim(offensedegree))=> 'PM4' ,
														regexfind('PETTY MISD[EMEANOR]*[- ]*(FIFTH|5TH|5)[ DEGREE]*',trim(offenseclass) + ' '+ trim(offensedegree)) => 'PM5' ,
														
														regexfind('GROSS MISD[EMEANOR]*[- ]*(ONE|FIRST|1ST|1)[ DEGREE]*',trim(offenseclass)  + ' '+ trim(offensedegree)) => 'GM1' ,
														regexfind('GROSS MISD[EMEANOR]*[- ]*(SECOND|2ND|2)[ DEGREE]*',trim(offenseclass) + ' '+ trim(offensedegree))=> 'GM2' ,
														regexfind('GROSS MISD[EMEANOR]*[- ]*(THIRD|3RD|3)[ DEGREE]*',trim(offenseclass) + ' '+ trim(offensedegree))=> 'GM3' ,
														regexfind('GROSS MISD[EMEANOR]*[- ]*(FOUR|FOURTH|4TH|4)[ DEGREE]*',trim(offenseclass) + ' '+ trim(offensedegree))=> 'GM4' ,
														regexfind('GROSS MISD[EMEANOR]*[- ]*(FIFTH|5TH|5)[ DEGREE]*',trim(offenseclass) + ' '+ trim(offensedegree)) => 'GM5' ,
														
														regexfind('MISD[EMEANOR]*[- ]*(ONE|FIRST|1ST|1)[ DEGREE]*',trim(offenseclass)  + ' '+ trim(offensedegree)) => 'M1' ,
														regexfind('MISD[EMEANOR]*[- ]*(MINOR)',trim(offenseclass)  + ' '+ trim(offensedegree)) => 'MM' ,
														regexfind('MISD[EMEANOR]*[- ]*(SECOND|2ND|2)[ DEGREE]*',trim(offenseclass) + ' '+ trim(offensedegree))=> 'M2' ,
														regexfind('MISD[EMEANOR]*[- ]*(THRID|THIRD|3RD|3)[ DEGREE]*',trim(offenseclass) + ' '+ trim(offensedegree))=> 'M3' ,
														regexfind('MISD[EMEANOR]*[- ]*(FOUR|FOURTH|4TH|4)[ DEGREE]*',trim(offenseclass) + ' '+ trim(offensedegree))=> 'M4' ,
														regexfind('MISD[EMEANOR]*[- ]*(FIFTH|5TH|5)[ DEGREE]*',trim(offenseclass) + ' '+ trim(offensedegree)) => 'M5' ,
														
														regexfind('M-1',trim(offenseclass) + ' '+ trim(offensedegree)) => 'M1' ,
														regexfind('M-M',trim(offenseclass) + ' '+ trim(offensedegree)) => 'MM' ,
														regexfind('M-2',trim(offenseclass) + ' '+ trim(offensedegree)) => 'M2' ,
														regexfind('M-3',trim(offenseclass) + ' '+ trim(offensedegree)) => 'M3' ,
														regexfind('M-4',trim(offenseclass) + ' '+ trim(offensedegree)) => 'M4' ,
														regexfind('M-5',trim(offenseclass) + ' '+ trim(offensedegree)) => 'M5' ,
													
														regexfind('F[ELONY]*[- ]*(ONE|FIRST|1ST|1)[ DEGREE]*',trim(offenseclass) + ' '+ trim(offensedegree)) => 'F1' ,
														regexfind('F[ELONY]*[- ]*(SECOND|2ND|2)[ DEGREE]*',trim(offenseclass) + ' '+ trim(offensedegree)) => 'F2' ,
														regexfind('F[ELONY]*[- ]*(THRID|THIRD|3RD|3)[ DEGREE]*',trim(offenseclass) + ' '+ trim(offensedegree))=> 'F3' ,
														regexfind('F[ELONY]*[- ]*(FOUR|FOURTH|4TH|4)[ DEGREE]*',trim(offenseclass) + ' '+ trim(offensedegree)) => 'F4' ,
														regexfind('F[ELONY]*[- ]*(FIFTH|5TH|5)[ DEGREE]*',trim(offenseclass) + ' '+ trim(offensedegree)) => 'F5' ,
														regexfind('C[OUNTY]*[- ]*CAPIT[OAL]*',trim(offenseclass) + ' '+ trim(offensedegree))=> 'CC' ,
														regexfind('F[ELONY]*[- ]*CAPIT[OAL]*',trim(offenseclass) + ' '+ trim(offensedegree))=> 'FCAP' ,
														regexfind('F[ELONY]*[- ]*LIFE*',trim(offenseclass) + ' '+ trim(offensedegree))=> 'FL' ,                                                                                     
														regexfind('COUNTY*[- ]*(FIRST|1ST)[ DEGREE]*',trim(offenseclass) + ' '+ trim(offensedegree)) =>'CO1',
											      regexfind('COUNTY*[- ]*(SECOND|2ND)[ DEGREE]*',trim(offenseclass) + ' '+ trim(offensedegree)) =>'CO2',                               
														regexfind('TRAFFIC INFRACTION[S]*[ ]*(FIRST|1ST)*[ DEGREE]*',trim(offenseclass) + ' '+ trim(offensedegree)) =>'TI',
														regexfind('INFRACTION[S]*[ ]*(FIRST|1ST)*[ DEGREE]*',trim(offenseclass) + ' '+ trim(offensedegree)) =>'I',
											      regexfind('MUNICIPAL ([/(]LOCAL[/)][- ])*(FIRST|1ST)[ DEGREE]*', trim(offenseclass) + ' '+ trim(offensedegree)) =>'MO1', 
														regexfind('MUNICIPAL ([/(]LOCAL[/)][- ])*(SECOND|2ND)[ DEGREE]*',trim(offenseclass) + ' '+ trim(offensedegree)) =>'MO2', 
														regexfind('MUNICIPAL ([/(]LOCAL[/)][- ])*(THIRD|3RD)[ DEGREE]*', trim(offenseclass) + ' '+ trim(offensedegree)) =>'MO3', 
														regexfind('MUNICIPAL[ ]*[/(]LOCAL[/)][- ]*',trim(offenseclass) + ' '+ trim(offensedegree)) =>'MO',
                            
														regexfind('MUNICIPAL[                ]*ORDINANCE',trim(offenseclass) + ' '+ trim(offensedegree)) =>'MO',                   
														regexfind('COUNTY[       ]*ORDINANCE',trim(offenseclass) + ' '+ trim(offensedegree)) =>'CO',             
                            //SEALED MISDEMEANOR                                                                                                                                                                                                                                                                            
                            regexfind('(CLASS)[ ]([A-Z][0-9]*)[ ](F)(ELONY)',offenseclass)      => regexreplace('(CLASS)[ ]([A-Z][0-9]*)[ ](F)(ELONY)',offenseclass,'$3$2'),       
                            regexfind('(CLASS)[ ]([A-Z][0-9]*)[ ](M)(ISDEMEANOR)',offenseclass) => regexreplace('(CLASS)[ ]([A-Z][0-9]*)[ ](M)(ISDEMEANOR)',offenseclass,'$3$2'),   
                            regexfind('(CLASS)[ ]([A-Z][0-9]*)[ ](F)(ELONY)',trim(offenseclass)+' '+trim(offensedegree))      => regexreplace('(CLASS)[ ]([A-Z][0-9]*)[ ](F)(ELONY)',trim(offenseclass)+' '+trim(offensedegree),'$3$2'),       
                            regexfind('(CLASS)[ ]([A-Z][0-9]*)[ ](M)(ISDEMEANOR)',trim(offenseclass)+' '+trim(offensedegree)) => regexreplace('(CLASS)[ ]([A-Z][0-9]*)[ ](M)(ISDEMEANOR)',trim(offenseclass)+' '+trim(offensedegree),'$3$2'),   
                            regexfind('(CLASS)[ ]([A-Z][0-9]*)[ ](F)(ELONY)',trim(offensedegree)+' '+trim(offenseclass))      => regexreplace('(CLASS)[ ]([A-Z][0-9]*)[ ](F)(ELONY)',trim(offensedegree)+' '+trim(offenseclass),'$3$2'),       
                            regexfind('(C[L]*ASS)[ ]([A-Z][0-9]*)[ ](M)(ISDEMEANOR)',trim(offensedegree)+' '+trim(offenseclass)) => regexreplace('(C[L]*ASS)[ ]([A-Z][0-9]*)[ ](M)(ISDEMEANOR)',trim(offensedegree)+' '+trim(offenseclass),'$3$2'),   
                                            
								            regexfind('(F)(ELONY)[ ](LEVEL)[ ]([0-9]+[A-Z]*)',trim(offenseclass)+' '+trim(offensedegree))      => regexreplace('(F)(ELONY)[ ](LEVEL)[ ]([0-9]+[A-Z]*)',trim(offenseclass)+' '+trim(offensedegree),'$1$4'),       
                            regexfind('(M)(ISDEMEANOR)[ ](LEVEL)[ ]([0-9]+[A-Z]*)',trim(offenseclass)+' '+trim(offensedegree)) => regexreplace('(M)(ISDEMEANOR)[ ](LEVEL)[ ]([0-9]+[A-Z]*)',trim(offenseclass)+' '+trim(offensedegree),'$1$4'), 
				 
                            regexfind('(CLASS)[ ]([A-Z]*[0-9]*)[ ](F)(EL[ONY]*)',trim(offenseclass)+ ' '+trim(offensetype)  )    => regexreplace('(CLASS)[ ]([A-Z]*[0-9]*)[ ](F)(EL[ONY]*)',trim(offenseclass)+ ' '+trim(offensetype),'$3$2'),       
                            regexfind('(CLASS)[ ]([A-Z]*[0-9]*)[ ](M)(ISDEMEANOR)',trim(offenseclass)+ ' '+trim(offensetype)) => regexreplace('(CLASS)[ ]([A-Z]*[0-9]*)[ ](M)(ISDEMEANOR)',trim(offenseclass)+ ' '+trim(offensetype),'$3$2'),   
                            
                            regexfind('(CLASS)[ ]([0-9])[ ](F)(ELONY)',offenseclass)      => regexreplace('(CLASS)[ ]([0-9])[ ](F)(ELONY)',offenseclass,'$3$2'),       
                            regexfind('(CLASS)[ ]([0-9])[ ](M)(ISDEMEANOR)',offenseclass) => regexreplace('(CLASS)[ ]([0-9])[ ](M)(ISDEMEANOR)',offenseclass,'$3$2'),   
                                                                                                                                                                                                                                                                                
                            regexfind('(CLASS)[ ]([A-Z])[ ](F)(ELONY)',offensedegree)      => regexreplace('(CLASS)[ ]([A-Z])[ ](F)(ELONY)',offensedegree,'$3$2'),       
                            regexfind('(CLASS)[ ]([A-Z])[ ](M)(ISDEMEANOR)',offensedegree) => regexreplace('(CLASS)[ ]([A-Z])[ ](M)(ISDEMEANOR)',offensedegree,'$3$2'),   

                            regexfind('(M)[ISDEMEANOR.]*[ ]*[/(]([A|B|C|D])[/)]' ,trim(offensedegree))  => regexreplace('(M)[ISDEMEANOR.]*[ ]*[/(]([A|B|C|D])[/)]' ,trim(offensedegree),'$1$2') ,
														regexfind('(F)[ELONY]*[ ]*[/(]([A|B|C|D])[/)]' ,trim(offensedegree))  => regexreplace('(F)[ELONY]*[ ]*[/(]([A|B|C|D])[/)]' ,trim(offensedegree),'$1$2') ,
										
														regexfind('(M)ISD[EMEANOR.]*[ ]([0-9A-Z])' ,trim(offenseclass) + ' '+trim(offensedegree))  => regexreplace('(M)ISD[EMEANOR.]*[ ]([0-9A-Z])' ,trim(offenseclass) + ' '+trim(offensedegree),'$1$2') ,
                            regexfind('(F)EL[ONY]*[ ]([0-9A-Z])'       ,trim(offenseclass) + ' '+trim(offensedegree))  => regexreplace('(F)EL[ONY]*[ ]([0-9A-Z])' ,trim(offenseclass) + ' '+trim(offensedegree),'$1$2') ,																																																																																																																		                            																																																																																																																																																					 														
                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                
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
                            
														regexfind('([0-9])(ST|RD|TH|ND)[ ](DEG[REE]*)[ ](C)(APITAL)[ ](.*)',offenseclass) => regexreplace('([0-9])(ST|RD|TH|ND)[ ](DEG[REE]*)[ ](C)(APITAL)[ ](.*)',offenseclass,'$4$1'),       
                            regexfind('([0-9])(ST|RD|TH|ND)[ ](DEG[REE]*)[ ](F)(EL[ONY]*)[ ](.*)',offenseclass) => regexreplace('([0-9])(ST|RD|TH|ND)[ ](DEG[REE]*)[ ](F)(EL[ONY]*)[ ](.*)',offenseclass,'$4$1'),       
                            regexfind('([0-9])(ST|RD|TH|ND)[ ](DEG[REE]*)[ ](M)(IS[DEMEANOR.]*)[ ](.*)',offenseclass) => regexreplace('([0-9])(ST|RD|TH|ND)[ ](DEG[REE]*)[ ](M)(IS[DEMEANOR.]*)[ ](.*)',offenseclass,'$4$1'),       
                            regexfind('([0-9])(ST|RD|TH|ND)[ ](DEG[REE]*)[ ](F)(EL[ONY]*)',offenseclass) => regexreplace('AGG ',regexreplace('([0-9])(ST|RD|TH|ND)[ ](DEG[REE]*)[ ](F)(EL[ONY]*)',offenseclass,'$4$1'),'A'),       
                            regexfind('([0-9])(ST|RD|TH|ND)[ ](DEG[REE]*)[ ](M)(IS[DEMEANOR.]*)',offenseclass) => regexreplace('([0-9])(ST|RD|TH|ND)[ ](DEG[REE]*)[ ](M)(IS[DEMEANOR.]*)',offenseclass,'$4$1'),       
           
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
														regexfind('FIRST DEGREE FELONY|FELONY FIRST DEGREE' ,trim(offensetype))  => 'F1' ,
														regexfind('SECOND DEGREE FELONY|FELONY SECOND DEGREE',trim(offensetype))  => 'F2' ,
														regexfind('THIRD DEGREE FELONY|FELONY THIRD DEGREE' ,trim(offensetype))  => 'F3' ,
														regexfind('FIFTH DEGREE FELONY|FELONY FIFTH DEGREE' ,trim(offensetype))  => 'F5' ,
														regexfind('FOURTH DEGREE FELONY|FELONY FOURTH DEGREE',trim(offensetype))  => 'F4' ,  
														regexfind('SIXTH DEGREE FELONY|FELONY SIXTH DEGREE',trim(offensetype))  => 'F6' ,													

														regexfind('(F)[ELONY]+ CLASS ([A-Z])',offensetype) => regexreplace('(F)[ELONY]+ CLASS ([A-Z])',offensetype,'$1$2'),     
														regexfind('(P)[ETTY]+ (O)FFENSE CLASS ([1-9])',offensetype) => regexreplace('(P)[ETTY]+ (O)FFENSE CLASS ([1-9])',offensetype,'$1$2$3'),
                            regexfind('(M)[ISDEMEANOR]+ CLASS ([A-Z])',offensetype) => regexreplace('(M)[ISDEMEANOR]+ CLASS ([A-Z])',offensetype,'$1$2'),     
													
													  regexfind('FIRST DEGREE M[ISDEMEANOR.]*|M[ISDEMEANOR.]* FIRST DEGREE' ,trim(offensetype))  => 'M1' ,
														regexfind('SECOND DEGREE M[ISDEMEANOR.]*|M[ISDEMEANOR.]* SECOND DEGREE',trim(offensetype))  => 'M2' ,
														regexfind('THIRD DEGREE M[ISDEMEANOR.]*|M[ISDEMEANOR.]* THIRD DEGREE' ,trim(offensetype))  => 'M3' ,
														regexfind('FIFTH DEGREE M[ISDEMEANOR.]*|M[ISDEMEANOR.]* FIFTH DEGREE' ,trim(offensetype))  => 'M5' ,
														regexfind('FOURTH DEGREE M[ISDEMEANOR.]*|M[ISDEMEANOR.]* FOURTH DEGREE',trim(offensetype))  => 'M4' ,                                                                                                                                                                                                                                                                   
														regexfind('MISD[EMEANOR]*[- ]*(ONE|FIRST|1ST)[ DEGREE]*',trim(offensetype)  + ' '+ trim(offensedegree)) => 'M1' ,
														regexfind('MISD[EMEANOR]*[- ]*(MINOR)',trim(offensetype)  + ' '+ trim(offensedegree)) => 'MM' ,
														regexfind('MISD[EMEANOR]*[- ]*(SECOND|2ND)[ DEGREE]*',trim(offensetype) + ' '+ trim(offensedegree))=> 'M2' ,
														regexfind('MISD[EMEANOR]*[- ]*(THIRD|3RD)[ DEGREE]*',trim(offensetype) + ' '+ trim(offensedegree))=> 'M3' ,
														regexfind('MISD[EMEANOR]*[- ]*(FOUR|FOURTH|4TH)[ DEGREE]*',trim(offensetype) + ' '+ trim(offensedegree))=> 'M4' ,
														regexfind('MISD[EMEANOR]*[- ]*(FIFTH|5TH)[ DEGREE]*',trim(offensetype) + ' '+ trim(offensedegree)) => 'M5' ,
										        regexfind('F[ELONY]*[- ]*(ONE|FIRST|1ST)[ DEGREE]*',trim(offensetype) + ' '+ trim(offensedegree)) => 'F1' ,
														regexfind('F[ELONY]*[- ]*(SECOND|2ND)[ DEGREE]*',trim(offensetype) + ' '+ trim(offensedegree)) => 'F2' ,
														regexfind('F[ELONY]*[- ]*(THIRD|3RD)[ DEGREE]*',trim(offensetype) + ' '+ trim(offensedegree))=> 'F3' ,
														regexfind('F[ELONY]*[- ]*(FOUR|FOURTH|4TH)[ DEGREE]*',trim(offensetype) + ' '+ trim(offensedegree)) => 'F4' ,
														regexfind('F[ELONY]*[- ]*(FIFTH|5TH)[ DEGREE]*',trim(offensetype) + ' '+ trim(offensedegree)) => 'F5' ,
														regexfind('C[OUNTY]*[- ]*CAPIT[OAL]*',trim(offensetype) + ' '+ trim(offensedegree))=> 'CC' ,
														regexfind('F[ELONY]*[- ]*CAPIT[OAL]*',trim(offensetype) + ' '+ trim(offensedegree))=> 'FCAP' ,
														regexfind('F[ELONY]*[- ]*LIFE*',trim(offensetype) + ' '+ trim(offensedegree))=> 'FL' ,                                                                                     
														regexfind('COUNTY[- ]*(FIRST|1ST)[ DEGREE]*',trim(offensetype) + ' '+ trim(offensedegree)) =>'CO1',
											      regexfind('COUNTY[- ]*(SECOND|2ND)[ DEGREE]*',trim(offensetype) + ' '+ trim(offensedegree)) =>'CO2',         
														
														regexfind('^SPECIAL (FEL|FELONY)',offensedegree) => 'SF',
											      regexfind('(M)(IS[DEMEANOR.]*)[ ][- ]*([A-Z])',offensedegree) => regexreplace('(M)(IS[DEMEANOR.]*)[ ][- ]*([A-Z])',offensedegree,'$1$3'),       
                            regexfind('^M[I]*NOR (MISD[.]*|MSD|MISDE|MISD[.]*)',offensedegree) => 'MM', 
                            regexfind('^M[I]*NOR (MISD[.]*|MSD|MISDE|MISD[.]*)|(MISD[.]*|MSD|MISDE|MISD[.]*) M[I]*NOR',offensetype) => 'MM',
														offensetype = 'UNCL-MM' OR offensedegree = 'MINOR MISDEMEANOR' OR offenseclass  = 'MINOR MISDEMEANOR'=> 'MM',
                            regexfind('^F$|^FEL|^FELONY',offensedegree) => 'F',  
                            regexfind('^M$|^MISD[.]*|^MSD|^MISDE|^MISD[.]*',offensedegree) => 'M',                                                                                                                                                                                                                                                                               
                            regexfind('^FEL|FELONY',offenseclass) => 'F',  
                            regexfind('^MISD[.]*|MSD|MISDE|MISD[.]*',offenseclass) => 'M',                                                                                                                                                                                                                                                                          
                            regexfind('^INFRACTION',offensetype) => 'I',
                            regexfind('^COUNTY',offensetype) => 'COR',
                            trim(offensetype) ='TRAFFIC INFRACTION' => 'TI', 
                            regexfind('MISD[.]*|MISDE',offenseclass) and regexfind('TRAFFIC',offenseclass)            => 'MT' ,
                            regexfind('MISD[.]*|MISDE',offensetype) and regexfind('TRAFFIC',offensetype)            => 'MT' ,
                            regexfind('MISD[.]*|MISDE',offensedegree) and            regexfind('TRAFFIC',offensedegree)      => 'MT' ,
                            offensetype IN ['TRAFFIC MISDEMEANOR'] => 'MT', 
                            regexfind('TRAFFIC$',trim(offensetype)) => 'T',                    
                            offensedegree = 'MISDEMEANOR'       OR offenseclass = 'MISDEMEANOR'    => 'M',   
                            offensedegree = 'FELONY'            OR offenseclass = 'FELONY'    => 'F', 
														offenseclass  = 'INFRACTION'       														    => 'I',
														offenseclass  = 'SELECTED TRAFFIC'            								      => 'T',						
                            trim(offensetype) IN ['MUNICIPAL','MUNICIPAL(LOCAL)','MUNICIPAL ORDINANCE','MUNICIPAL (CITY) ORDINANCE'] => 'MOR',   
														regexfind('^FEL|FELONY',offensetype) and regexfind('^[0-9]$',trim(offensedegree)) => 'F'+offensedegree,
														regexfind('^MISD|MISDEMEANOR',offensetype) and regexfind('^[0-9][NRD]*$',trim(offensedegree)) => 'M'+offensedegree,
                            regexfind('^FEL|FELONY',offensetype) => 'F'+offenseclass,  
                            regexfind('^MISD[.]*|MSD|MISDE|MISD[.]*',offensetype) => 'M'+offenseclass,
														offensetype ='AF' and length(trim(offensedegree)) =1        =>  offensetype[1..2]+offensedegree[1..1],		
														length(trim(offensetype)) = 2 and regexfind('[0-9A-Z0-9]+',offensetype) => trim(offensetype),
														regexfind('[0-9A-Z0-9]',offenseclass) and  regexfind('[0-9A-Z0-9]',offensedegree) => offenseclass[1..1]+ offensedegree[1..1],
                            length(trim(offensetype)) =1 and offenseclass  <> ''=>  offensetype[1..1]+offenseclass[1..1],
														length(trim(offensetype)) =1 and offensedegree <> ''=>  offensetype[1..1]+offensedegree[1..1],
														trim(offensetype)+trim(offenseclass)+trim(offensedegree) in ['F','M'] => trim(offensetype)+trim(offenseclass)+trim(offensedegree),
														trim(offensetype) ='PETTY OFFENSE' => 'PO',
                            length(trim(offenseclass)) <= 2 => trim(offenseclass),
												    length(trim(offensedegree)) <= 2 and regexfind('[0-9A-Z0-9]+',offensedegree) => trim(offensedegree),
														offensetype in ['F','M'] => trim(offensetype),
                            ''
                            ),left,right);
                
		LE_off_lev                  := Map(regexfind('(.*) ([/(]*[0-9:]+[0-9:.]+[ A-Z]*[/( 0-9A-Z/)]*[/)]), ([A-Z])',l.finaloffense) => trim(regexreplace('(.*) ([/(]*[0-9:]+[0-9:.]+[ A-Z]*[/( 0-9A-Z/)]*[/)]), ([A-Z])',l.finaloffense,'$3'),left,right),
																			 regexfind('(.*) ([0-9:]+[0-9:.]+[ A-Z]*[/( 0-9A-Z/)]*), ([A-Z])',l.finaloffense)       => trim(regexreplace('(.*) ([0-9:]+[0-9:.]+[ A-Z]*[/( 0-9A-Z/)]*), ([A-Z])',l.finaloffense,'$3'),left,right),
																			 off_lev);

		self.court_off_lev          := MAP(vVendor ='LB' and off_lev <> '' => off_lev, 
		                                   vVendor ='LB' => LE_off_lev,
                                     	 vVendor ='UV'  and regexfind('CRIMINAL (.*)',off_lev)=>	regexreplace('CRIMINAL (.*)',off_lev,'$1'),                                      
																			 vVendor ='10C'  and l.CitationNumber <> '' => 'T',  

                                     // the word traffic in offense
                                     vVendor ='7G' and stringlib.stringfind('TRAFFIC ',temp_offense,1)>0 and off_lev ='PM' => 'PMT',
																		 
																		 vVendor ='7V' and l.casetype in ['TRAFFIC VIOLATION'] and 	l.offenseclass IN ['INFRACTION','MISDEMEANOR']=> 'TV'+off_lev ,
																		 vVendor ='7V' and l.casetype in ['PARKING VIOLATION'] and 	l.offenseclass IN ['INFRACTION','MISDEMEANOR']=> 'PV'+off_lev ,
																		 vVendor ='7V' and l.casetype in ['CRIMINAL TRAFFIC']  and 	l.offenseclass IN ['INFRACTION','MISDEMEANOR']=> 'CT'+off_lev ,
																		 
																		 vVendor ='7X' and l.casetype in ['CRIMINAL FELONY']   and 	l.offensedegree IN ['CAPITAL']=> 'CF' ,
                                     
		                                 // M4 in the end
																		 vVendor IN ['QZ']  and stringlib.stringfilterout(off_lev,',.`{') IN ['CONVERSION',''] and
																		 regexfind('(.*)[)/ ]([MF][M0-9])[ ]*$', temp_offense)  => regexreplace('(.*)[)/ ]([MF][M0-9])[ ]*$', temp_offense,'$2'),
														         
		                                // M4 in the end
																		 vVendor IN ['RK','RM','VI','VO','VP','QP','QQ','QS','QT','QU','WN','WS','WT','WW','XZ','YD','YE','YH','YF','YK','YT','YZ','WP','YL','QR','XZ'] 
																		 and stringlib.stringfilterout(off_lev,',.`{') = '' and
																		 regexfind('(.*)[ )(-.]([MF][M0-9])[ ]*$', temp_offense)  => regexreplace('(.*)[ (-.]([MF][M0-9])[ ]*$', temp_offense,'$2'),
														 
														 
		                                 // (M1)in the middle or end for QM
																		 vVendor IN ['QM'] and off_lev IN ['','CT'] and
																		 regexfind('(.*)[(]([MF][M0-9])[)](.*)', temp_offense)  => regexreplace('(.*)[(]([MF][M0-9])[)](.*)', temp_offense,'$2'),
																		 
		                                 regexfind('&NBS([P;])*',off_lev) => regexreplace('([A-Z][A-Z0-9]*)&NBS([P;])',off_lev,'$1'),
                                     // Medina has 
                                     vVendor ='QS' and regexfind('(.*)( [/(])([FM]-[M0-9])[/)][ ]*$',temp_offense) => regexreplace('(.*)( [/(])([FM]-[M0-9])[/)][ ]*$',temp_offense,'$3'),
                                     vVendor ='QS' and regexfind('(.*) ([FM]-[M0-9])[ ]*',temp_offense) => regexreplace('(.*) ([FM]-[M0-9])[ ]*',temp_offense,'$2'),
                                     stringlib.stringfilterout(off_lev,',.`{') <> '' and
																		 stringlib.stringfilterout(off_lev,',.`{') <> 'CONVERSION'=> stringlib.stringfilterout(off_lev,',.`{'), 
                                                                                  
                                     vVendor ='FS' and trim(l.casetype) IN ['CF','CRIMINAL FELONY'] => 'F' , //FL Pinellas
																		 vVendor ='FS' and trim(l.casetype) IN ['MISDEMEANOR'] => 'M' , 
                                     vVendor ='FS' and trim(l.casetype) IN ['MM'] => 'MM' , 
                                     vVendor ='FS' and trim(l.casetype) IN ['MO','MUNICIPALITY'] => 'MOR' ,
                                     vVendor ='FS' and trim(l.casetype) IN ['CO','COUNTY ORDINANCE'] => 'COR' ,
                                     vVendor ='FS' and stringlib.stringfind(l.casetype,'TRAFFIC',1) >0=> 'T',
                                                                                                            
																		 vVendor ='RV' and stringlib.stringfind(temp_offense,'(MA)',1) >0  => 'MA',
																		 vVendor ='RV' and stringlib.stringfind(temp_offense,'(MB)',1) >0  => 'MB',
																			 
																		 vVendor ='6E' and stringlib.stringfind(temp_offense,'MISDEMEANOR A',1) >0  => 'MA',
																		 vVendor ='6E' and stringlib.stringfind(temp_offense,'MISDEMEANOR B',1) >0  => 'MB',
																		 vVendor ='6E' and stringlib.stringfind(temp_offense,'MISDEMEANOR',1) >0  => 'M',
																		 
																		 vVendor ='6C' and stringlib.stringfind(temp_offense,'MISDEMEANOR SIMPLE',1) >0  => 'SM',
																		 vVendor IN ['QU','YZ','YK','WT'] and regexfind('MINOR MISD', temp_offense)  => 'MM',
																		 
																		 vVendor IN ['5Q' ,'VG','RV','6C','5Y','VF','VV','RO','QX','UP','UW','UK','WT'] and regexfind('^MISD[EMEANOR]*[.) ]',temp_offense) and 
																		 stringlib.stringfind(temp_offense,'FALSE REPORT',1) =0 and 
																		 stringlib.stringfind(temp_offense,'ESCAPE',1) =0       and
																		 stringlib.stringfind(temp_offense,'VIOLATION',1) =0             => 'M',
																		 
																		 vVendor IN ['5Q' ,'VG','RV','6C','5Y','VF','VV','RO','QX','UP','UW','UK','QU','QN','FO','UY','WT','WX'] and regexfind('[(-/ ]MISD[EMEANOR]*[.) /]',temp_offense) and 
																		 stringlib.stringfind(temp_offense,'FALSE REPORT',1) =0 and 
																		 stringlib.stringfind(temp_offense,'ESCAPE',1) =0       and
																		 stringlib.stringfind(temp_offense,'VIOLATION',1) =0             => 'M',
																		 
																		 //MISD in the end
																		 vVendor IN ['UY','VF','VG','UK','WX','WT','9A'] and regexfind('[(-/ ]MISD[EMEANOR]*[.) /]*$',temp_offense) and 
																		 stringlib.stringfind(temp_offense,'FALSE REPORT',1) =0 and 
																		 stringlib.stringfind(temp_offense,'ESCAPE',1) =0       and
																		 stringlib.stringfind(temp_offense,'VIOLATION',1) =0             => 'M',
																		 //(MM) in the end
																		 vVendor IN ['9A'] and regexfind(' [(]MM[)]*$',temp_offense) and 
																		 stringlib.stringfind(temp_offense,'FALSE REPORT',1) =0 and 
																		 stringlib.stringfind(temp_offense,'ESCAPE',1) =0       => 'MM',
																		 
																		 //AGG F1
																		 vVendor IN ['WN','VP','QS','QU','QZ'] and regexfind('A[G .]*F[-]*[0-9]', temp_offense)  =>regexreplace('(.*)A[G .]*F[-]*([0-9])(.*)', temp_offense,'AF$2') ,
																		  //AGG F1 beginning
																		 vVendor IN ['QZ'] and regexfind('^A[G .]*F[-]*[0-9]', temp_offense)  =>'AF'+regexreplace('^A[G .]*F[-]*([0-9])(.*)', temp_offense,'$1'),
																		                                                 
																		 //values like MMM1
																		 vVendor IN ['QU'] and regexfind('(.*)([MF][M0-9])([MF][0-9])(.*)', temp_offense)  => regexreplace('(.*)([MF][M0-9])([FM][0-9])(.*)', temp_offense,'$2'),
																		 vVendor IN ['RP','US'] and regexfind('(.*) ["]([ABC])["] ([M])ISD[EMEANOR]*', temp_offense)  => regexreplace('(.*) ["]([ABC])["](.*) ([M])ISD[EMEANOR.]*',temp_offense, '$4$2'),
														
																	   vVendor IN ['RP','US'] and regexfind('CLASS ([AB]) ([M])ISD[EMEANOR]*', temp_offense) => regexreplace('(.*)CLASS (.*)([AB])(.*) ([M])ISD[EMEANOR]*', temp_offense,'$5$3'),
																		 
																		 vVendor IN ['VO','VP','5W','RQ','RP','QZ','QR','YB','YE','W0151','W0152'] and stringlib.stringfind(temp_offense,'MISD',1) >0 and
																		 stringlib.stringfind(temp_offense,'MISDEMEANOR CITATION',1) =0 => 'M',		
																		 //(M-1)or M-1 beggining
																		 vVendor IN ['RK','RM','VO','VP','YD','YE','YF','YZ','YT','RM','YK','WT','QS','QT','QZ'] and 
																		 regexfind('^[/(]*([MF])[-]([0-9])[)(-;/ ]+(.*)', temp_offense) => regexreplace('^[/(]*([MF])[-]([0-9])[)(-;/ ]+(.*)', temp_offense,'$1$2'),

																		 //(M-1)or M-1 in the end
																		 vVendor IN ['RK','RM','VO','VP','YD','YE','YF','YZ','YT','RM','YK','WS','WT','WN','WZ','QS','QT','QZ','QO','WX'] and 
																		 regexfind('(.*)[/( ]*([MF])[-]([0-9])[)-/]*[ ]*$', stringlib.stringfilterout(temp_offense,'[]')) => regexreplace('(.*)[/( ]*([MF])[-]([0-9])[)-/]*[ ]*$', stringlib.stringfilterout(temp_offense,'[]'),'$2$3'),
                                     //(M-1)or M-1 in the middle 
																		 vVendor IN ['YD','YE','YF','YZ','YT','RM','YK','QU','QZ','WT'] and
																		 regexfind('(.*)[/( )]*([MF])[-]([0-9])[)(-;/ ](.*)', stringlib.stringfilterout(temp_offense,'[]')) => regexreplace('(.*)[/( )]*([MF])[-]([0-9])[)(-;/ ](.*)', stringlib.stringfilterout(temp_offense,'[]'),'$2$3'),
													 
                                     // (M1)in the end
																		 vVendor IN ['VO','VP','YB','YT','QS','QU','WS','WT','WN','WX','WZ','YK','W0255'] and regexfind('(.*)[(]([MF][M0-9])[)][ ]*$', temp_offense)  => regexreplace('(.*)[(]([MF][M0-9])[)][ ]*$', temp_offense,'$2'),
																		 
																		 // (M1)in the middle or end
																		 vVendor IN ['VO','VP','YB','YT','QS','QU','WS','WT','WN','YK'] and regexfind('(.*)[(]([MF][M0-9])[)](.*)', temp_offense)  => regexreplace('(.*)[(]([MF][M0-9])[)](.*)', temp_offense,'$2'),
																		 // M4 in the beginning
																		 vVendor IN ['YD','QZ','YZ','WT'] and 
																		 regexfind('^([MF][M0-9])[ (-/](.*)', temp_offense+' ')  => regexreplace('^([MF][M0-9])[ (-/](.*)', temp_offense+' ','$1'),
                                     // M4 in the end
																		 vVendor IN ['YK','WT','W0254'] and 
																		 regexfind('(.*)/[ ]*([MFS][-]*[MJXS0-9\\*][F]*)[ ]*$', temp_offense)  => regexreplace('(.*)/[ ]*([MFS][-]*[MJXS0-9\\*][F]*)[ ]*$', temp_offense,'$2'),
																		 //FELONY-X in the end
																		 vVendor IN ['W0254'] and 
																		 regexfind('(.*)/[ ]*(F)ELONY[-]*([0-9])[ ]*$', temp_offense)  => regexreplace('(.*)/[ ]*(F)ELONY[-]*([0-9])[ ]*$', temp_offense,'$2$3'),
																		 vVendor IN ['W0254'] and                     
                                     regexfind('(.*)/[ ]*(STATE JAIL FELONY)[ ]*$', temp_offense)  => regexreplace('(.*)/[ ]*(STATE JAIL FELONY)[ ]*$', temp_offense,'SJF'),
																		 // M4 middle 
																		 vVendor IN ['QZ','QU','YD','WN','YK','WT'] and regexfind('(.*)[) (-/]([MF][M0-9])[)(,;/ ][INTOX ]*(.*)', temp_offense)  => regexreplace('(.*)[) (-/]([MF][M0-9])[)(,;/ ][INTOX ]*(.*)', temp_offense,'$2'),
																		 
																		 Vvendor IN ['5W','5Y','5Q','QQ','QR','RP','RR','XZ','YF','YH','YM','YL','YS','YZ','ZP','QZ','WT','W0151','W0152',
																		             'W0257','W0258','W0260','W0261','W0262','W0263','W0264','W0265','W0266'] and 
																		 regexfind('[ (/-]FEL[):\\./ -]|^FEL[\\. ]', temp_offense)  and regexfind('AMEND', temp_offense,0)='' => 'F',
																		 
																		 Vvendor IN ['W0257','W0258','W0260','W0261','W0262','W0263','W0264','W0265','W0266'] and 
																		 regexfind('[ (/-]MISD[):\\./ -]', temp_offense)  and regexfind('AMEND', temp_offense,0)='' => 'M',
																		 
                                     vVendor ='UL' and stringlib.stringfind(temp_offense,'FELONY/MISDEMEANOR',1) >0                =>'F/M',                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
                                     vVendor ='UL' and stringlib.stringfind(temp_offense,'TRAFFIC OR MINOR INFRACTION',1) >0 =>'T/MI',                                               
                                     vVendor IN ['QL','UL'] and stringlib.stringfind(temp_offense,'MISDEMEANOR',1) >0  => 'M'  ,                                               
                                     vVendor ='UL' and stringlib.stringfind(temp_offense,'INFRACTION',1) >0  => 'I'  ,
                                     vVendor ='UL' and stringlib.stringfind(temp_offense,'MAJOR TRAFFIC VIOLATION',1) >0  => 'MTV'  ,                                                    
                                     vVendor IN ['UU'] and stringlib.stringfind(temp_offense,'MISDEMEANOR OFFENSE',1) >0 => 'M'  ,
																		 
                                     vVendor ='UK' and stringlib.stringfilterout(off_lev,',.`{') = '' and 
                                                        stringlib.stringfind(temp_offense,'FTA',1) >0  => ''  ,
                                     vVendor ='FO' => temp_case_number[1..1], // FL dade
																		 
																		 vVendor ='W0027' and l.classification_code <>'TV' and trim(l.casetype) IN ['TRAFFIC','PARKING'] => '' ,
																		 vVendor ='W0041' and l.classification_code <>'TV' and trim(l.casetype) IN ['CRIMINAL TRAFFIC']  => '' ,
																		 
                                     (stringlib.stringfind(temp_offense,'FELONY',1) >0  or regexfind('FELONY|FEL0NY|FELONIOUS|FELONEOUS|FELONIOS|FELONOUS|CRIM-FEL|FEL:', temp_offense) ) and 
                                      regexfind('REDU[U]*CED|AMEND[DED]* TO|NON-FELONY|ACCESSORY|ATTEMPT TO COMMIT|FACILITATION',temp_offense,0) ='' => 'F',
																			
																		 regexfind('MISD:', temp_offense)  and 
                                     regexfind('REDU[U]*CED|AMEND[DED]* TO|NON-FELONY|ACCESSORY|ATTEMPT TO COMMIT|FACILITATION',temp_offense,0) ='' => 'M',  																				
                                     
																		 trim(l.casetype) IN ['CRIMINAL FELONY','FELONY'] => 'F' ,
																		 trim(l.casetype) IN ['FELONY II']      => 'F2' ,
																		 trim(l.casetype) IN ['FELONY I']       => 'F1' ,
																		 trim(l.casetype) IN ['CAPITAL FELONY'] => 'CF' ,
																		 trim(l.casetype) IN ['COUNTY ORDINANCE'] => 'COR' ,
                                     trim(l.casetype) IN ['CRIMINAL MISDEMEANOR','ADULT MISDEMEANOR','MISDEMEANOR'] => 'M' ,
                                     
                                     trim(l.casetype) IN ['MISDEMEANOR TRAFFIC'] => 'MT' ,
                                     
                                     trim(l.casetype) IN ['FELONY TRAFFIC'] => 'FT',
                                     /*(stringlib.stringfind(temp_offense,'FELONY',1) >0  or stringlib.stringfind(temp_offense,'FELONIOUS',1) >0 or
                                      stringlib.stringfind(temp_offense,'CRIM-FEL',1) >0   ) =>'F',*/
																		 trim(l.casetype) IN ['CRIMINAL TRAFFIC'] => 'CT' ,
																		 trim(l.casetype) IN ['TRAFFIC'] and  vVendor in ['RE'] => '', //As per Margaret don't use case types for RE 3/8/2017
																		 trim(l.casetype) IN ['TR','TRAFFIC','PARKING','PARKING INFRACTION'] => 'T' ,
                                     trim(l.casetype) IN ['CRIMINAL INFRACTION','CRIMINAL INFRACTIONS'] => 'CI',
																		 trim(l.casetype) IN ['INFRACTION'] => 'I',
																		 trim(l.casetype) IN ['TRAFFIC INFRACTION','TRAFFIC INFRACTIONS','INFRACTION TRAFFIC','INFRACTION: TRAFFIC/'] => 'TI',
																		 trim(l.casetype) IN ['COUNTY ORDINANCE INF','COUNTY ORDINANCE ARR'] => 'COR',
																		 trim(l.casetype) IN ['MUNICIPAL ORDINANCE']  => 'MOR',
																		 trim(l.casetype) IN ['ORDINANCE VIOLATION']  => 'OV',
                                     trim(l.casetype) IN ['NON CRIMINAL INFRACT','IN NON-CRIMINAL INFR'] => 'NIN',
																		 trim(l.casetype) IN ['NONTRAFFIC INFRACTIO'] => 'IN',
																		 trim(l.casetype) IN ['FELONY/GROSS MISDEME'] => 'F/GM',
																		 trim(l.casetype) IN ['CIVIL INFRACTION'] => 'CVI' ,
																		 trim(l.casetype) IN ['CIVIL TRAFFIC'] and  vVendor not in ['RE']  => 'CVT' ,
                                      ''
                                     );
                
                
  self.court_statute             := MAP(vVendor ='TS' and regexfind('[0-9.]+[ ]*([/(]*[A-Z0-9][/)]*)*[ ]*[A-Z]+' ,trim(temp_offense)) => trim(temp_offense),
                                        vVendor ='TV' and regexfind('I[0-9.]+[ ]*([/(]*[A-Z0-9][/)]*)*[ ]*[A-Z]+' ,trim(temp_offense)) => trim(temp_offense),
                                        vVendor ='TV' and regexfind('[0-9.]+[ ]*([/(]*[A-Z0-9][/)]*)*[ ]*[A-Z]+' ,trim(temp_offense)) => trim(temp_offense),                                     
                                        vVendor ='UH' and trim(temp_offense)<> 'NOT SPECIFIED' => trim(temp_offense),                           
                                        vVendor ='LB' and LE_court_statute[1..1]='(' and LE_court_statute[length(LE_court_statute)..] =')'=> LE_court_statute[2..length(LE_court_statute)-1],
                                        vVendor ='LB' => LE_court_statute,
                                        vVendor ='UK' and regexfind('[0-9]',UK_Court_statute) => UK_Court_statute,
                                        vVendor IN ['UB','QN','QX','QZ','IB','PZ','YC','YE','WU','VW','VO','VP','7Y','8G','8I','W0155','W0156','W0157','W0266'] => l.offensecode,
                                        regexfind('[a-zA-Z]+[0-9.]+[(a-zA-Z)]*[(0-9)]*:',temp_offense) => StringLib.StringFilterOut(trim(regexreplace('([a-zA-Z]+0-9.]+[/(a-zA-Z/)]*[(0-9)]*:)(.*)',temp_offense,'$1'),left,right),'()'),
                                        regexfind('[0-9.]+[a-zA-Z]+[(a-zA-Z)]*[(0-9)]*:',temp_offense) => StringLib.StringFilterOut(trim(regexreplace('([0-9.]+[a-zA-Z]+[/(a-zA-Z/)]*[(0-9)]*:)(.*)',temp_offense,'$1'),left,right),'()'),                                                                                                                                                                                                                                                                                                
                                        regexfind('[a-zA-Z0-9.]+[.][(a-zA-Z)]*[(0-9)]*', l.offensecode) => trim(l.offensecode),
                                        '');
                                                                                                                                                                           
  self.court_additional_statutes := '';
  
  self.court_statute_desc        :='';
                                   /* MAP(vVendor ='LB' => LE_court_statute_desc,
                                          vVendor IN ['QN','QX','QZ','IB'] => temp_offense,
                                          regexfind('[a-zA-Z]+[0-9.]+[(a-zA-Z)]*[(0-9)]*:',temp_offense)=>  trim(regexreplace('([a-zA-Z]+[0-9.]+[/(a-zA-Z/)]*[(0-9)]*:)(.*)',temp_offense,'$2'),left,right),
                                     regexfind('[0-9.]+[a-zA-Z]+[(a-zA-Z)]*[(0-9)]*:',temp_offense)=>  trim(regexreplace('([0-9.]+[a-zA-Z]+[/(a-zA-Z/)]*[(0-9)]*:)(.*)',temp_offense,'$2'),left,right),
                                     regexfind('[a-zA-Z0-9.]+[.][(a-zA-Z)]*[(0-9)]*', l.offensecode) => temp_offense,
                                                                                                                                                                                                                                                                                                '');*/
                                                                                                                                                                                                                                                                                                
  string temp_disp_date     := MAP(trim(l.dispositiondate)[1..2] between '19' and '20' 
                                      and length(trim(l.dispositiondate))>=4 
                                      and l.dispositiondate <= stringlib.GetDateYYYYMMDD() => trim(l.dispositiondate),
                                      trim(l.finalrulingdate)[1..2] between '19' and '20'     and 
                                      length(trim(l.finalrulingdate))>=4 and 
                                      l.finalrulingdate <= stringlib.GetDateYYYYMMDD() => trim(l.finalrulingdate),
                                     '');  
                                                                                                                                                                                
  self.court_disp_date      := if(temp_disp_date = '' and trim(l.ChargeDisposedDate)[1..2] between '19' and '20' 
                                    and length(trim(l.ChargeDisposedDate))>=4 
                                    and l.ChargeDisposedDate<=stringlib.GetDateYYYYMMDD(),
                                    trim(l.ChargeDisposedDate),
                                    temp_disp_date);
   
  string temp_disp           := map(regexfind('[A-Za-z]+', trim(l.disposition), 0)<>''=> trim(l.disposition),
                                    regexfind('[A-Za-z]+', trim(l.finalruling), 0)<>''=>trim(l.finalruling),
                                    ''); 

  self.court_disp_code       := MAP(length(temp_disp)<= 3 => temp_disp,
                                    vVendor IN ['US','8I','8K','9G','9U'] and regexfind('(.*) - (.*)',temp_disp) => regexreplace('(.*) - (.*)',temp_disp,'$1'),
																		'');
                                                                                                                                                                                
                //use disposition from charge table when value in offense table is null
  self.court_disp_desc_1    := MAP( trim(temp_disp) ='G'=>'GUILTY',                                            
                                    trim(temp_disp) ='D'=>'DISMISS',
																		trim(temp_disp) ='PLEA OF GUILTY NO JURY **'  => 'PLEA OF GUILTY NO JURY', 
																		trim(temp_disp) ='TYPE:P  PLEA OF GUILTY NO JURY **'  => 'PLEA OF GUILTY NO JURY',    
                                    trim(temp_disp) ='TYPE:S  PLEA OF GUILTY NO JURY **'  => 'PLEA OF GUILTY NO JURY',    
                                    trim(temp_disp) ='TYPE:J  PLEA OF GUILTY NO JURY **'  => 'PLEA OF GUILTY NO JURY',    

																		regexfind('&NBS',temp_disp) => regexreplace('(.*)&NBSP;',temp_disp,'$1'),
                                    vVendor IN ['US','8I','8K','9G','9U'] and regexfind('(.*) - (.*)',temp_disp) => regexreplace('(.*) - (.*)',temp_disp,'$2'),                                                                                                                                                        
                                    vVendor IN ['W0253'] and regexfind('[0-9]+ (.*)',temp_disp) => regexreplace('[0-9]+ (.*)',temp_disp,'$1'),                                                                                                                                                        
                                                                        
																		vVendor ='TJ' and temp_disp_date<> '' => 'CONVICTED', //For TX Harris - HD is mapping convict_date to disposition_date.
																		vVendor ='TI' and regexfind('GUILTY -',temp_disp) => 'GUILTY', //removing sentences from disp
																		vVendor ='TI' and regexfind('GUILTY PLEA- JURY VERDICT -',temp_disp) => 'GUILTY PLEA- JURY VERDICT', //removing sentences from disp and mapping here
																		vVendor ='TI' and regexfind('GUILTY BY JURY -',temp_disp) => 'GUILTY BY JURY', //removing sentences from disp and mapping here
																		
                                    vVendor ='TH' and l.caseinfo <> '' and stringlib.stringfind(temp_disp,',',1) >0 =>  trim(l.caseinfo)+','+ regexreplace('([A-Z/-]),(.*)',temp_disp,'$1'),
                                    vVendor ='TH' and l.caseinfo <> '' and stringlib.stringfind(temp_disp,',',1) =0 =>  trim(l.caseinfo)+','+ temp_disp,
                                    vVendor ='TH' and l.caseinfo = ''  and stringlib.stringfind(temp_disp,',',1) >0 =>  regexreplace('([A-Z/-]+), (.*)',temp_disp,'$1'),
                                    vVendor ='TH' and l.caseinfo = ''  and stringlib.stringfind(temp_disp,',',1) =0 =>  temp_disp,                                    
                                    vVendor ='FO' and trim(temp_disp) = 'CONV & SENT-CONCUR'   => 'CONVICTION, SENTENCE CONCURRENT',
																		vVendor ='FO' and trim(temp_disp) = 'CONV & SENT-CONSEC'   => 'CONVICTION, SENTENCE CONSECUTIVE',
																		vVendor ='FO' and trim(temp_disp) = 'CONV - COMM SERVICE'  => 'CONVICTION, COMMUNITY SERVICE',
																		vVendor ='FO' and trim(temp_disp) = 'CONV - PROB CONSEC'   => 'CONVICTION, PROBATION CONSECUTIVE',
																		vVendor ='FO' and trim(temp_disp) = 'CONV AND SENT'        => 'CONVICTION, WITH SENTENCE',
																		vVendor ='FO' and trim(temp_disp) = 'CONV PROB/SPLIT SENT' => 'CONVICTION, PROBATION, SPLIT SENTENCE',
																		vVendor ='FO' and trim(temp_disp) = 'CONV W/COMM CONTROL'  => 'CONVICTION, WITH COMM CONTROL',
																		vVendor ='FO' and trim(temp_disp) = 'CONV W/FINE & COST '  => 'CONVICTION, WITH FINE AND COST',
																		vVendor ='FO' and trim(temp_disp) = 'CONV-BOATING SCHOOL'  => 'CONVICTION, BOATING SCHOOL',
																		vVendor ='FO' and trim(temp_disp) = 'CONV-C.C./SPEC COND'  => 'CONVICTION, SPECIAL CONDITIONS',
																		vVendor ='FO' and trim(temp_disp) = 'CONV-PROB SPEC COND'  => 'CONVICTION, PROBATION SPECIAL CONDITIONS',
																		vVendor ='FO' and trim(temp_disp) = 'CONV-SUSP ENTRY SENT' => 'CONVICTION, SUSPENDED ENTRY SENTENCE',
																		vVendor ='FO' and trim(temp_disp) = 'CONV/SPLIT SENTENCE'  => 'CONVICTION, SPLIT SENTENCE',
																		vVendor ='FO' and trim(temp_disp) = 'CONVICTION - COMMUNI' => 'CONVICTION, COMMUNINITY SERVICE',
																		vVendor ='FO' and trim(temp_disp) = 'CONVICTION - JAIL'    => 'CONVICTION, JAIL',
																		vVendor ='FO' and trim(temp_disp) = 'CONVICTION - JAIL TE' => 'CONVICTION, JAIL',
																		vVendor ='FO' and trim(temp_disp) = 'CONVICTION - PROBATI' => 'CONVICTION, PROBATION',
																		vVendor ='FO' and trim(temp_disp) = 'CONVICTION - SUSPEND' => 'CONVICTION, SUSPENDED SENTENCE',
																		vVendor ='FO' and trim(temp_disp) = 'CONVICTION - W/PROBA' => 'CONVICTION, PROBATION',
																		vVendor ='FO' and trim(temp_disp) = 'CONVICTION AND SENTE' => 'CONVICTION, SENTENCED',
																		vVendor ='FO' and trim(temp_disp) = 'CONVICTION W/COMMUNI' => 'CONVICTION, COMMUNITY SERVICE',
																		vVendor ='FO' and trim(temp_disp) = 'CONVICTION W/FINE'    => 'CONVICTION, FINED',
																		vVendor ='FO' and trim(temp_disp) = 'CONVICTION W/PROB'    => 'CONVICTION, PROBATION',
																		vVendor ='FO' and trim(temp_disp) = 'CONVICTION W/PROBATI' => 'CONVICTION, PROBATION',
																		vVendor ='FO' and trim(temp_disp) = 'CONVICTION WITH COMM' => 'CONVICTION, COMMUNITY SERVICE',
																		vVendor ='FO' and trim(temp_disp) = 'CONVICTION WITH CRED' => 'CONVICTION  CREDIT TIME SERVED',
																		vVendor ='FO' and trim(temp_disp) = 'CONVICTION WITH FINE' => 'CONVICTION, WITH FINE',
																		vVendor ='FO' and trim(temp_disp) = 'CONVICTION WITH PROB' => 'CONVICTION, WITH PROB',
																		vVendor ='FO' and trim(temp_disp) = 'CONVICTION WITH SPLI' => 'CONVICTION, WITH SPLIT SENTENCE',
																		vVendor ='FO' and trim(temp_disp) = 'CONVICTION, SENTENCE' => 'CONVICTION, SENTENCE',
																		vVendor ='FO' and trim(temp_disp) = 'CONVICTION-JAIL/FINE' => 'CONVICTION, JAIL AND FINE',
																		vVendor ='FO' and trim(temp_disp) = 'CREDIT TIME SERVED'   => 'CONVICTION, CREDIT TIME SERVED',
                                    length(trim(temp_disp)) > 3 => temp_disp,
                                    vVendor ='QS' and stringlib.stringfind(l.sentencetype,'GUILTY',1)>0 => l.sentencetype,
                                    vVendor ='QS' and stringlib.stringfind(l.sentencetype,'DIS',1)>0 => l.sentencetype,
                                    vVendor ='QS' and stringlib.stringfind(l.sentencetype,'JUR',1)>0 => l.sentencetype,
                                    '');
  self.court_disp_desc_2 := MAP( vVendor ='9M' =>'', //case disposition is mapped in status which is used to populate this field and it contradicts the charge disposition.
	                               vVendor ='TH' and stringlib.stringfind(temp_disp,',',1) >0 =>  regexreplace('([A-Z/-]+), (.*)',temp_disp,'$2'),
                                 vVendor ='FH' and stringlib.stringfind(temp_disp,'PROSECUTOR FINAL ACTION:',1) >0 => 'Pros actn:'+regexreplace('(PROSECUTOR FINAL ACTION:) (.*)',temp_disp,'$2'),
                                 vVendor ='QQ' and stringlib.stringfind(l.casestatus,';',1) > 0 => l.casestatus[1..stringlib.stringfind(l.casestatus,';',1) - 1 ],
                                 vVendor ='QQ' and stringlib.stringfind(l.casestatus,';',1) = 0 => l.casestatus,
                                 l.casestatus <> '' and stringlib.stringfind(l.casestatus,':',1) > 0 => trim(trim(l.casestatus) + ' '+ l.casestatusdate), 
                                 l.casestatus <> '' and stringlib.stringfind(l.casestatus,':',1) = 0 => trim('Status:'+ trim(l.casestatus) + ' '+ l.casestatusdate), 
                                 l.trialtype);

  psent:= regexreplace('MINIMUM',
          regexreplace('MAXIMUM',
					regexreplace('MONTHS',
					regexreplace('YEARS',
                       l.sentenceadditionalinfo,'YRS'),'MNTHS'),'MAX'),'MIN');																 
  NVClarksent_agency  := hygenics_crim._f_parseNVClark_sentence.sent_agency(psent);
  NVClarksusp_sent    := hygenics_crim._f_parseNVClark_sentence.susp_sent(psent);
  NVClarkJAil         := hygenics_crim._f_parseNVClark_sentence.JAil(psent);
  NVClarkFine         := hygenics_crim._f_parseNVClark_sentence.Fine(psent);
  NVClarkFine_add     := hygenics_crim._f_parseNVClark_sentence.Fine_add(psent);
  NVClarkconsconc     := hygenics_crim._f_parseNVClark_sentence.consconc(psent);
  NVClarkProbation 	  := hygenics_crim._f_parseNVClark_sentence.Probation(psent);			
  NVClarkProbation2 	:= hygenics_crim._f_parseNVClark_sentence.Probation2(psent);	
  NVClarkcomm_serv    := hygenics_crim._f_parseNVClark_sentence.comm_serv(psent);
  NVClarkRestitution	:= hygenics_crim._f_parseNVClark_sentence.Restitution(psent);
  NVClarkadditional   := hygenics_crim._f_parseNVClark_sentence.additional(psent);
  NVClarkadditional2  := hygenics_crim._f_parseNVClark_sentence.additional2(psent);
  NVClarkother        := hygenics_crim._f_parseNVClark_sentence.other(psent);
	
	
								
  self.sent_date          := MAP(trim(l.SentenceDate)[1..2] between '19' and '20' 
                               and length(trim(l.SentenceDate))>=4 
                               and l.SentenceDate <= stringlib.GetDateYYYYMMDD() => trim(l.SentenceDate),                                                                                                                                                                                                 
                              '');                 
                                                                                                                                                                                                                                                                                                                                                
	string Maxsent          := IF(l.sentencemaxyears  <> '' and l.sentencemaxyears  <> '0' and regexfind('[0-9]+', l.sentencemaxyears , 0)<>'', trim(l.sentencemaxyears) + ' Years ','') +                                                                               
														 IF(l.sentencemaxmonths <> '' and l.sentencemaxmonths <> '0' and regexfind('[0-9]+', l.sentencemaxmonths, 0)<>'', trim(l.sentencemaxmonths) + ' Months ','') +
														 IF(l.sentencemaxdays   <> '' and l.sentencemaxdays   <> '0' and regexfind('[0-9]+', l.sentencemaxdays  , 0)<>'', trim(l.sentencemaxdays) + ' Days ',
																 '');
																 
	string Minsent          := IF(l.sentenceminyears  <> '' and l.sentenceminyears  <> '0' and regexfind('[0-9]+', l.sentenceminyears, 0)<>'', trim(l.sentenceminyears) + ' Years ', '') +                                                                               
														 IF(l.sentenceminmonths <> '' and l.sentenceminmonths <> '0' and regexfind('[0-9]+', l.sentenceminmonths, 0)<>'', trim(l.sentenceminmonths) + ' Months ', '') +
														 IF(l.sentencemindays   <> '' and l.sentencemindays   <> '0' and regexfind('[0-9]+', l.sentencemindays, 0)<>'', trim(l.sentencemindays) + ' Days ',
															 '');                  
															 
	string temp_timeserve1  := IF(l.timeservedyears  <> '' and l.sentenceminyears  <> '0'  ,trim(l.timeservedyears) + 'Years ','') +                                                                   
														 IF(l.timeservedmonths <> '' and l.sentenceminmonths <> '0'  ,trim(l.timeservedmonths) + 'Months ','') +
                             IF(l.timeserveddays   <> '' and l.sentencemindays   <> '0'  ,trim(l.timeserveddays) + 'Days ','');
                                                 
  String Jail_time        := MAP(regexfind('(JAIL TIME: )([0-9A-Z ,]+);',l.sentenceadditionalinfo) => regexreplace('(JAIL TIME: )([0-9A-Z ,]+);(.*)',l.sentenceadditionalinfo,'$2'),
                                               regexfind('(SENTENCE JAIL DAYS: )([0-9]+)',l.sentenceadditionalinfo) => trim(regexreplace('(SENTENCE JAIL DAYS: )([0-9]+)',l.sentenceadditionalinfo,'$2'))+'D','');
  string temp_timeserved  := MAP(temp_timeserve1 <> '' => 'Time served: '+ temp_timeserve1, Jail_time <> '' =>       'Jail: '+ stringlib.stringfindreplace(stringlib.stringfindreplace(stringlib.stringfindreplace( Jail_time, 'M','Months'),'D','Days'),'Y','Years'), '');                                                                                                                                                                                                          
  sent_jail_desc          := MAP(Maxsent <> '' and Minsent <> '' => 'Max: '+Maxsent+ ' Min: '+Minsent,
                             Maxsent <> '' => 'Max: '+Maxsent,
                             Minsent <> '' => 'Min: '+Minsent,
                             temp_timeserved <> '' =>temp_timeserved,
                             regexfind('L[I]*FE',l.sentencemaxyears) =>  l.sentencemaxyears,
                             regexfind('L[I]*FE',l.sentencemaxmonths) => l.sentencemaxmonths,
                             regexfind('L[I]*FE',l.sentencemaxdays) => l.sentencemaxdays,
                             '');                                                                                                                                                                                                                                                                    

	self.sent_jail          :=  MAP( vVendor ='8A' => NVClarkJAil,
                                   vVendor ='TB' and stringlib.stringfind(l.sentencetype,'SENTENCE',1) >0 => trim(l.sentencetype) +' '+sent_jail_desc,
                                   vVendor ='TH' and stringlib.stringfind(l.sentencetype,'SENTENCE',1) >0 => trim(trim(l.sentencetype) +' '+sent_jail_desc,left,right),
                                   sent_jail_desc);
 
  sentstat_susp_time      := MAP(
	                               regexfind('(SUSPENDED) (SENTENCE:|LENGTH:) [0-9]+ Y', l.sentencestatus) => trim(regexreplace('(SUSPENDED) (SENTENCE:|LENGTH:)(.*)', l.sentencestatus,'$3'),left,right)+'ears',
                                 regexfind('(SUSPENDED) (SENTENCE:|LENGTH:) [0-9]+ M', l.sentencestatus) => trim(regexreplace('(SUSPENDED) (SENTENCE:|LENGTH:)(.*)', l.sentencestatus,'$3'),left,right)+'onths',
                                 regexfind('SUSPENDED SENTENCE DAYS: [0-9]+'         , l.sentencestatus) => trim(regexreplace('(SUSPENDED SENTENCE DAYS:) (.*)'    , l.sentencestatus,'$2'),left,right)+'Days',
                                 regexfind('(SUSPENDED) (SENTENCE:|LENGTH:) [0-9]+ D', l.sentencestatus) => trim(regexreplace('(SUSPENDED) (SENTENCE:|LENGTH:)(.*)', l.sentencestatus,'$3'),left,right)+'ays',
                                 regexfind('(SUSP DAYS IN JAIL: )([0-9]+); (.*)', l.sentencestatus) => trim(regexreplace('(SUSP DAYS IN JAIL: )([0-9]+); (.*)', l.sentencestatus,'$2'+' Days'),left,right),                        
                                 regexfind('(SUSP DAYS IN JAIL: )(.*)', l.sentencestatus) => trim(regexreplace('(SUSP DAYS IN JAIL: )(.*)', l.sentencestatus,'$2'),left,right)+'Days', 

																 regexfind('(SENTENCE DAYS SUSPENDED: )(.*)', l.sentencestatus) => trim(regexreplace('(SENTENCE DAYS SUSPENDED: )(.*)', l.sentencestatus,'$2'),left,right)+'Days', 
																 
                                 regexfind('(JAIL DAYS SUSPENDED: )([0-9]+)[, ](.*)', l.sentencestatus) => trim(regexreplace('(JAIL DAYS SUSPENDED: )([0-9]+)[, ](.*)', l.sentencestatus,'$2'),left,right)+'Days', 
                                 regexfind('(SUSPENDED JAIL DAYS: )([0-9]+)[, ](.*)', l.sentencestatus) => trim(regexreplace('(SUSPENDED JAIL DAYS: )([0-9]+)[, ](.*)', l.sentencestatus,'$2'),left,right)+'Days', 
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
                                 regexfind('SENT DAYS JAIL SUSP:[0-9]+'    , l.sentenceadditionalinfo) => trim(regexreplace('(SENT DAYS JAIL SUSP:)(.*)',  l.sentenceadditionalinfo,'$2'),left,right)+'Days',                                 
																 regexfind('SUSPENDED DAYS IN JAIL:[0-9]+'    , l.sentenceadditionalinfo) => trim(regexreplace('(SUSPENDED DAYS IN JAIL:)(.*)',  l.sentenceadditionalinfo,'$2'),left,right)+'Days',   
                                 vVendor = '9I'and regexfind('JAIL SUSP:[0-9]+;', l.sentenceadditionalinfo) => trim(regexreplace('JAIL SUSP:(.*)',  l.sentenceadditionalinfo,'$1'),left,right),                                 
                                 regexfind('SUSPENDED JAIL DAYS: [0-9]+'    , l.sentenceadditionalinfo) => trim(regexreplace('(SUSPENDED JAIL DAYS: )(.*)',  l.sentenceadditionalinfo,'$2'),left,right)+'Days',   
                                 regexfind('SUSP DAYS:[0-9]+', l.sentenceadditionalinfo) => trim(regexreplace('SUSP DAYS:(.*)',  l.sentenceadditionalinfo,'$1'),left,right),                                 
                                 								
																 '');                                                                                                                                                                                                                                
  self.sent_susp_time       := MAP(vVendor ='8A' => hygenics_crim._f_parseNVClark_sentence.susp_sent(psent),
	                                 sentstat_susp_time <> '' => trim(sentstat_susp_time,left,right),
                                   sentaddl_susp_time <> '' => trim(sentaddl_susp_time,left,right),
                                   ''); 
                                         
  Invalid_amount := ['999999.00','888888.0','$0.00','0'];
                
  sent_court_cost        := MAP(regexfind('[0-9]+', trim(l.CourtFee), 0)='' => '',
                              trim(l.CourtFee) in Invalid_amount => '',
                              trim(l.CourtFee));
															
  FineAmount						 := MAP(vVendor ='8A' and NVClarkFine <> '' => NVClarkFine,
	                              vVendor ='8A' and NVClarkFine_add <> '' => NVClarkFine_add,
                                trim(l.FineAmount));	 								
																
  sent_court_fine        := MAP(regexfind('[0-9]+', trim(FineAmount), 0)='' => '',
                                trim(FineAmount) IN Invalid_amount => '',
                                trim(FineAmount));
                                                                                                                                                                                
  sent_susp_court_fine   := MAP(regexfind('(FINE SUSPENDED: )([0-9.]+), (.*)',l.caseinfo)  =>  regexreplace('(FINE SUSPENDED: )([0-9.]+), (.*)',l.caseinfo,'$2'),
	                              regexfind('(FINE SUSPENDED: )([0-9.]+)',l.caseinfo)  =>  regexreplace('(FINE SUSPENDED: )([0-9.]+)',l.caseinfo,'$2'),
																regexfind('(FINE SUSPENDED: )([0-9.]+), (.*)',l.casecomments)  =>  regexreplace('(FINE SUSPENDED: )([0-9.]+), (.*)',l.casecomments,'$2'),
	                              regexfind('(FINE SUSPENDED: )([0-9.]+)',l.casecomments)  =>  regexreplace('(FINE SUSPENDED: )([0-9.]+)',l.casecomments,'$2'),
																regexfind('(FINE SUSPENDED:\\$)([0-9.]+)',l.casecomments)  =>  regexreplace('(FINE SUSPENDED:\\$)([0-9.]+)',l.casecomments,'$2'),
                                
                                '');
                                                                                                                                                                                                                                                                                                
  SELF.sent_court_cost_orig      := sent_court_cost;
  SELF.sent_court_fine_orig      := sent_court_fine;
  SELF.sent_susp_court_fine_orig := sent_susp_court_fine;
                
	sent_court_cost_temp       := stringlib.stringfilterout(sent_court_cost,'$,*');
	sent_court_fine_temp       := stringlib.stringfilterout(sent_court_fine,'$,*');
	sent_susp_court_fine_temp  := stringlib.stringfilterout(sent_susp_court_fine,'$,*');
                
  sent_court_cost_1          := If(sent_court_cost_temp <> '',(string)((decimal12_2)sent_court_cost_temp *100),'');
  self.sent_court_cost       := MAP((integer)sent_court_cost_1 =0 => '',
															 	    length(trim(sent_court_cost_1)) >8 => '',
																	  sent_court_cost_1);
                                                                                                                                                                                                                                                                                
	sent_court_fine_1          := If(sent_court_fine_temp <> '',(string)((decimal12_2)sent_court_fine_temp *100),'');                                                                                                                                                                
  self.sent_court_fine       := MAP((integer)sent_court_fine_1 =0 => '',
																		length(trim(sent_court_fine_1)) >9 => '',
																		sent_court_fine_1);                                                                                                                                                                                     

  sent_susp_court_fine_1     := If(sent_susp_court_fine_temp <> '',(string)((decimal12_2)sent_susp_court_fine_temp *100),'');                                                                                                                                                              
  self.sent_susp_court_fine  := MAP((integer)sent_susp_court_fine_1 =0 => '',
																	  length(trim(sent_susp_court_fine_1)) >9 => '',
																	  sent_susp_court_fine_1);          
                
	string MaxProb             := IF(l.probationmaxyears <> ''  and regexfind('[0-9]+', l.probationmaxyears, 0)<>'', trim(l.probationmaxyears) + ' Years ', '') +                                                                             
															  IF(l.probationmaxmonths <> '' and regexfind('[0-9]+', l.probationmaxmonths, 0)<>'', trim(l.probationmaxmonths) + ' Months ', '') +
															  IF(l.probationmaxdays <> ''   and regexfind('[0-9]+', l.probationmaxdays, 0)<>'', trim(l.probationmaxdays) + ' Days ',
																	'');
                                                                                                                                                                                                
  string MinProb             := IF(l.probationminyears  <> '' and regexfind('[0-9]+', l.probationminyears, 0)<>'', trim(l.probationminyears) + ' Years ', '') +                                                                              
                                IF(l.probationminmonths <> '' and regexfind('[0-9]+', l.probationminmonths, 0)<>'', trim(l.probationminmonths) + ' Months ', '') +
                                IF(l.probationmindays   <> '' and regexfind('[0-9]+', l.probationmindays, 0)<>'', trim(l.probationmindays) + ' Days ',
                                   '');     
  prob_dates                 := MAP(l.probationbegindate <> '' and l.probationenddate <> '' => 'Dates:'+ l.probationbegindate+'-'+l.probationenddate,
                                    l.probationbegindate <> '' => 'Start:'+ l.probationbegindate,
                                    l.probationenddate   <> '' => 'End:'+ l.probationenddate,
                                    '');
  sent_probation_desc        := trim(trim( IF(Minprob <> '' ,' Min:'+Minprob,''),left,right) +
                                           IF(Maxprob <> '' ,' Max:'+Maxprob,''),left,right) ;                                                                                                                                                                                                                             
																					 
  self.sent_probation        := MAP( vVendor ='8A' => NVClarkProbation,
	                                   vVendor ='TB' and stringlib.stringfind(l.sentencetype,'PROBATION',1) >0 => l.sentencetype +' '+sent_probation_desc,
                                     vVendor ='TH' and stringlib.stringfind(l.sentencetype,'PROBATION',1) >0 => l.sentencetype +' '+sent_probation_desc,
                                     sent_probation_desc);
																		 
  self.sent_addl_prov_code   := '';
                
  sent_consec                := MAP(vVendor ='8A' => NVClarkconsconc,
	                                  trim(l.sentenceadditionalinfo) = 'CONSECUTIVE' => 'CS',
                                    trim(l.sentenceadditionalinfo) = 'CONCURRENT' => 'CC',
                                    trim(l.sentencestatus) = 'CONSECUTIVE' => 'CS',
                                    trim(l.sentencestatus) = 'CONCURRENT' => 'CC',
                                    trim(l.sentencetype) = 'CONSECUTIVE' => 'CS',
                                    trim(l.sentencetype) = 'CONCURRENT' => 'CC',
                                    '');               

  NV_temp_Sent              :=  NVClarksent_agency+NVClarksusp_sent+NVClarkJAil+NVClarkFine+NVClarkconsconc+NVClarkProbation+
							                  NVClarkProbation2+NVClarkcomm_serv+NVClarkRestitution+NVClarkadditional+NVClarkadditional2  ;
  addl_prov_frm_CaseComm    := Map(regexfind('CCS|FINE|JAIL|PROBATION|COMM[UNITY]* SERVICE|COMM[UNITY]* CONTROL',l.casecomments) => l.casecomments,
	                                 '');
 
  addl_prov_desc_W0031      := MAP(regexfind('(.*) ([0-9]+ MO[\\.] [UNSUPERVISED ]*PROBATION,) (.*)',l.casecomments)  =>  regexreplace('(.*) ([0-9]+ MO[\\.] [UNSUPERVISED ]*PROBATION,) (.*)',l.casecomments,'$2$3'),
                                   regexfind('(.*) ([0-9]+ MO[NTH]*S[\\.]* [UNSUPERVISED ]*PROBATION,) (.*)',l.casecomments)  =>  regexreplace('(.*) ([0-9]+ MO[NTH]*S[\\.]* [UNSUPERVISED ]*PROBATION,) (.*)',l.casecomments,'$2$3'),
                                   l.caseinfo[1..11] IN  ['RESTITUTION']=>  l.casecomments       ,
                                   l.caseinfo[1..9]  IN  ['PROBATION']=>    l.casecomments       ,
                                '');
																
  addl_prov_desc_8J         := MAP(regexfind('ENTRY OF SENTENCE AND CONVICTION[\\. ](.*)',l.sentenceadditionalinfo)=>regexreplace('ENTRY OF SENTENCE AND CONVICTION[\\. ](.*)',l.sentenceadditionalinfo,'$1') ,
																   regexfind('ENTRY OF SENTENCE[/:\\. -](.*)',l.sentenceadditionalinfo)=>regexreplace('ENTRY OF SENTENCE[/:\\. -](.*)',l.sentenceadditionalinfo,'$1') ,
																   l.sentenceadditionalinfo);
																	 
  addl_prov_desc_8J_1       := STD.Str.FindReplace(STD.Str.FindReplace( addl_prov_desc_8J, 'THE DEFENDANT IS SENTENCED','SENT'),'DEFENDANT SENTENCED','SENT');
	addl_prov_desc_8J_2       := regexreplace('VOLUME [0-9]+[ AND]+PAGE [0-9]+ ',
	                             regexreplace('VOLUME [0-9]+ PAGE [0-9]+ ',
	                             regexreplace('VOL [0-9]+[ /]+PAGE [0-9]+ ',addl_prov_desc_8J_1,''),''),'');
															 
	addl_prov_desc_9I         := MAP(regexfind('JAIL SUSP:[0-9]+;', l.sentenceadditionalinfo) => trim(regexreplace('JAIL SUSP:([0-9]+);(.*)',  l.sentenceadditionalinfo,'$2'),left,right),
	                                 trim(l.casecomments) <> '' => trim(l.casecomments),
	                                 '');                                 
  addl_prov_desc_9T         := STD.Str.FindReplace(STD.Str.FindReplace( l.sentenceadditionalinfo, 'SENTENCED','SENT'),'SENTENCE','SENT');
	                                 															 
	addl_prov_desc_1          := MAP( vVendor ='TI' and regexfind('GUILTY - ',temp_disp) => regexreplace('(GUILTY - )(.*)',temp_disp,'$2'), //removing sentences from disp and mapping here
	                                  vVendor ='TI' and regexfind('GUILTY PLEA- JURY VERDICT - ',temp_disp) => regexreplace('(GUILTY PLEA- JURY VERDICT - )(.*)',temp_disp,'$2'), //removing sentences from disp and mapping here
																		vVendor ='TI' and regexfind('GUILTY BY JURY - ',temp_disp) => regexreplace('(GUILTY BY JURY - )(.*)',temp_disp,'$2'), //removing sentences from disp and mapping here
	
	                                  vVendor ='8A' and NVClarkadditional <> '' => NVClarkadditional,
	                                  vVendor ='8A' and NV_temp_Sent='' => NVClarkother,
																		vVendor ='8A' =>'',
																		
																		vVendor ='8J' => addl_prov_desc_8J_2[1..40],
																		vVendor ='8R' => l.sentencestatus[1..40],
																		vVendor ='9I' => addl_prov_desc_9I[1..40],
																		vVendor ='9T' => addl_prov_desc_9T[1..40],
	                                  vVendor ='PJ' => l.casecomments,
																	  vVendor ='9Z' and stringlib.stringfind(l.sentenceadditionalinfo,';',1)>0=> l.sentenceadditionalinfo[1..stringlib.stringfind(l.sentenceadditionalinfo,';',1)-1],
																	  vVendor ='9Z' =>l.sentenceadditionalinfo,
                                    vVendor IN ['OP','PC','9N'] => '',
																		
                                    vVendor IN ['SA','YB'] and length(l.sentencestatus) > 40 => l.sentencestatus[1..40],
                                    vVendor = 'MC' and length(l.sentencestatus) > 40 => l.sentencestatus[1..40],
                                    vVendor = 'QX' and length(l.sentencestatus) > 40 => l.sentencestatus[1..40],
                                    vVendor = 'QN' and length(l.sentencestatus) > 40 => l.sentencestatus[1..40],
																		vVendor IN ['ZD','ZG','ZH','ZI','ZJ','ZK','ZL','ZM','ZN','ZO','ZP','ZQ','ZR','ZS','ZT','ZU','ZV',
                                                'ZW','ZX','ZY','ZZ','3A','3B','3N','3O','3P','3S','3T','3U','3V','3W','3Z','4A','4H',
																								'4I','4J','4K','4M','4N','4O','4P','4Q','4R','4S','4T','4U','4V']  => l.sentencestatus[1..40],
																		
                                    vVendor IN ['W0031'] and addl_prov_desc_W0031 <> '' => addl_prov_desc_W0031[1..40],																								
                                    vVendor IN ['OF','RJ','QV','W0036','W0028','W0034','W0031','8X','9D','9E','9I','9O'] and l.sentenceadditionalinfo <> '' => l.sentenceadditionalinfo[1..40],
																		vVendor IN ['W0036','W0028','W0034'] and addl_prov_frm_CaseComm <> '' => addl_prov_frm_CaseComm[1..40],                                    

                                    regexfind('(SUSPENDED) (SENTENCE:|LENGTH:) ([0-9]+ [A-Z]), (.*)', l.sentenceadditionalinfo) => regexreplace('(SUSPENDED) (SENTENCE:|LENGTH:) ([0-9]+ [A-Z]), (.*)', l.sentenceadditionalinfo,'$4'),
																		
                                    trim(l.sentenceadditionalinfo) in ['CONSECUTIVE','CONSECUTIVE'] => '',
                                    regexfind('(SENTENCE SEQ #: )[0-9]$',l.sentenceadditionalinfo) => '',
                                    regexfind('(SENTENCING JUDGE: )[A-Z, ]',l.sentenceadditionalinfo ) => '',   
                                    regexfind('(COMMUNITY CONTROL LENGTH: [0-9, YMD][0-9, YMD]*); (SENTENCE LOCATION: )(.*)',l.sentenceadditionalinfo ) => regexreplace('(COMMUNITY CONTROL LENGTH: [0-9, YMD][0-9, YMD]*); (SENTENCE LOCATION: )(.*)',l.sentenceadditionalinfo,'$1' ),
                                    regexfind('^(SENTENCE LOCATION: )(.*)',l.sentenceadditionalinfo ) => '',
                                    regexfind('^(LOCATION: )(.*)',l.sentenceadditionalinfo ) => '',
                                    regexfind('^(COMMUNITY CONTROL LENGTH: [0-9, YMD][0-9, YMD]*)$',l.sentenceadditionalinfo ) => regexreplace('^(COMMUNITY CONTROL LENGTH: [0-9, YMD][0-9, YMD]*)$',l.sentenceadditionalinfo,'$1' ),
                                    sentaddl_susp_time <> ''  => '',
                                    l.sentenceadditionalinfo);

                                                                                                                                                                                                                                                                                                
  addl_prov_desc_2          := MAP(vVendor ='8A' and NVClarkadditional2<>'' => NVClarkadditional2,
	                                 vVendor ='8A' and NV_temp_Sent='' => NVClarkother[41..],
																	 vVendor ='8A' =>'',
																	 vVendor ='8J' => addl_prov_desc_8J_2[41..],
																	 vVendor ='8R' => l.sentencestatus[41..],
																	 vVendor ='9I' => addl_prov_desc_9I[41..],
																	 vVendor ='9T' => addl_prov_desc_9T[41..],
																	 vVendor ='9Z' and stringlib.stringfind(l.sentenceadditionalinfo,';',1)>0=> trim(l.sentenceadditionalinfo[stringlib.stringfind(l.sentenceadditionalinfo,';',1)+2..],left,right),
																	  
	                                 trim(l.sentencestatus) IN ['CONSECUTIVE','CONSECUTIVE'] =>'',
                                   vVendor IN ['SA','YB'] and length(l.sentencestatus) > 40 => l.sentencestatus[41..],
																	 vVendor IN ['ZD','ZG','ZH','ZI','ZJ','ZK','ZL','ZM','ZN','ZO','ZP','ZQ','ZR','ZS','ZT','ZU','ZV',
                                                'ZW','ZX','ZY','ZZ','3A','3B','3N','3O','3P','3S','3T','3U','3V','3W','3Z','4A','4H',
																								'4I','4J','4K','4M','4N','4O','4P','4Q','4R','4S','4T','4U','4V'] and length(l.sentencestatus) > 40 => l.sentencestatus[41..],
                                   vVendor = 'MC' and length(l.sentencestatus) > 40 => l.sentencestatus[41..],
                                   vVendor = 'QX' and length(l.sentencestatus) > 40 => l.sentencestatus[41..],
                                   vVendor = 'QN' and length(l.sentencestatus) > 40 => l.sentencestatus[41..],
                                   vVendor = 'OU' and regexfind('(SUSP DAYS IN JAIL: )([0-9]+); (.*)', l.sentencestatus) => regexreplace('(SUSP DAYS IN JAIL: )([0-9]+); (.*)', l.sentencestatus,'$3'),  
                                   vVendor = 'QP' and regexfind('(JAIL DAYS SUSPENDED: )([0-9]+), (.*)', l.sentencestatus) => regexreplace('(JAIL DAYS SUSPENDED: )([0-9]+), (.*)', l.sentencestatus,'$3'),  
                                   vVendor = 'QW' and regexfind('(SUSPENDED JAIL DAYS: )([0-9]+), (.*)', l.sentencestatus) => regexreplace('(SUSPENDED JAIL DAYS: )([0-9]+), (.*)', l.sentencestatus,'$3'),  
                                   vVendor = 'QP' and stringlib.stringfind(l.sentencestatus,'JAIL DAYS SUSPENDED',1) =0 => l.sentencestatus,
                                   vVendor = 'QW' and stringlib.stringfind(l.sentencestatus,'SUSPENDED JAIL DAYS',1) =0 => l.sentencestatus,
                                   vVendor = 'RV' and l.sentencestatus ='' and l.sentencetype <> ''=> 'Sentence Type: '+ l.sentencetype,
																	 
                                   vVendor IN ['W0031'] and addl_prov_desc_W0031 <> ''=>  addl_prov_desc_W0031[41..],                                   
																	 vVendor IN ['OF','RJ','QV','W0036','W0028','W0034','W0031','8X','9D','9E','9I','9O'] and l.sentenceadditionalinfo <> '' => l.sentenceadditionalinfo[41..],
																	 vVendor IN ['W0036','W0028','W0034'] and addl_prov_frm_CaseComm <> '' => addl_prov_frm_CaseComm[41..],
																	 
                                   regexfind('(SUSPENDED) (SENTENCE:|LENGTH:) ([0-9]+ [A-Z]), (.*)', l.sentencestatus) => regexreplace('(SUSPENDED) (SENTENCE:|LENGTH:) ([0-9]+ [A-Z]), (.*)', l.sentencestatus,'$4'),
                                   sentstat_susp_time <> '' => '',
																	 vVendor IN ['I0022'] => l.sentenceadditionalinfo[41..],

                                   l.sentencestatus                                                                                                                                                                                                                                                                             
                                   );
                
  self.sent_addl_prov_desc_1:= addl_prov_desc_1;
  
  self.sent_addl_prov_desc_2:= addl_prov_desc_2;
                
  self.sent_consec          := sent_consec;
  
  self.sent_agency_rec_cust_ori   := '';
  self.sent_agency_rec_cust       := MAP(vVendor ='8A' => NVClarksent_agency,
	                                       trim(l.sentencetype) in ['CONSECUTIVE','CONSECUTIVE'] => '',
                                         vVendor IN ['TB','TH','8L'] => '',
                                         vVendor ='QS' and stringlib.stringfind(l.sentencetype,'GUILTY',1)>0 => '',
                                         vVendor ='QS' and stringlib.stringfind(l.sentencetype,'DIS',1)>0 => '',
                                         vVendor ='QS' and stringlib.stringfind(l.sentencetype,'JUR',1)>0 => '', 
                                         l.sentencetype <> '' and trim(l.sentencetype) <> 'N/A'  =>  l.sentencetype, 
                                         l.institutionname <> '' => l.institutionname,
                                         trim(l.CustodyLocation)
                                                                                                                                                                                                                                                                                       );
                
  self.appeal_date                := if(regexfind('[0-9]+', trim(l.appealdate)[1..4], 0)<>'' and trim(l.appealdate)[1] in ['1','2'],
                                        trim(l.appealdate),
                                        '');
                                                                                                                                                                                                                                                                                                
  self.appeal_off_disp            := '';
  self.appeal_final_decision      := '';
  
  //Fields added for CROSS
  self.offense_town               := l.offenselocation;
  self.convict_dt                 := MAP(trim(l.finalrulingdate) = '19000101' => '',
                                         trim(l.finalrulingdate)[1..2] between '19' and '20' and 
                                         length(trim(l.finalrulingdate))>=4 and 
                                         l.finalrulingdate <= stringlib.GetDateYYYYMMDD() => trim(l.finalrulingdate),
                                         '');  
                
  self.cty_conv            := MAP(
                                 vVendor = 'QQ' => '', 
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
																							
  restitution               := MAP(vVendor = '8A' =>NVClarkRestitution,
	                                 l.restitution
                                   );																							
  self.restitution          := MAP(regexfind('[0-9]+', trim(restitution), 0)='' => '',
                                   restitution IN Invalid_amount => '',
                                   restitution
                                   );
                
  community_serv            := IF(l.CommunitySupervisionYears  <> '' and regexfind('[0-9]+', l.CommunitySupervisionYears, 0)<>'', trim(l.CommunitySupervisionYears) + ' Years ','') +                                                                              
                               IF(l.CommunitySupervisionMonths <> '' and regexfind('[0-9]+', l.CommunitySupervisionMonths, 0)<>'', trim(l.CommunitySupervisionMonths) + ' Months ','') +
                               IF(l.CommunitySupervisionDays   <> '' and regexfind('[0-9]+', l.CommunitySupervisionDays, 0)<>'', trim(l.CommunitySupervisionDays) + ' Days ',
                                  '');                 
                                                                                                                                                                                                                                                                
  public_serv_hrs           := IF(l.publicservicehours <> '' and regexfind('[0-9]+', l.publicservicehours, 0)<>'', 'Pub Serv: '+trim(l.publicservicehours) + ' Hours','') ;                                                                                                                                                                                                                                                                                                                             
	
	self.community_service    := MAP(vVendor = '8A' => NVClarkcomm_serv,
	                                 community_serv <> '' => community_serv, 
	                                 public_serv_hrs);
																	 
 
  string MaxParole          := IF(l.ParoleMaxYears  <> '' and regexfind('[0-9]+', l.ParoleMaxYears, 0)<>'', trim(l.ParoleMaxYears) + ' Years ', '') +                                                                    
                               IF(l.ParoleMaxMonths <> '' and regexfind('[0-9]+', l.ParoleMaxMonths, 0)<>'', trim(l.ParoleMaxMonths) + ' Months ', '') +
                               IF(l.ParoleMaxDays   <> '' and regexfind('[0-9]+', l.ParoleMaxDays, 0)<>'', trim(l.ParoleMaxDays) + ' Days ',
                                  '');
                                                                                                                                                                                                
  string MinParole          := IF(l.ParoleMinYears  <> '' and regexfind('[0-9]+', l.ParoleMinYears, 0)<>'', trim(l.ParoleMinYears) + ' Years ', '') +                                                                     
                               IF(l.ParoleMinMonths <> '' and regexfind('[0-9]+', l.ParoleMinMonths, 0)<>'', trim(l.ParoleMinMonths) + ' Months ', '') +
                               IF(l.ParoleMinDays   <> '' and regexfind('[0-9]+', l.ParoleMinDays, 0)<>'', trim(l.ParoleMinDays) + ' Days ',
                                 '');
    
  self.parole              := MAP(MaxParole <> '' and MinParole <> '' => 'Max: '+MaxParole + ' Min: '+MinParole,
                                                                                                                                                                                                  ''); 
  self.addl_sent_dates     := MAP(
	                            l.SentenceBeginDate <> '' and l.SentenceEndDate <> ''=>  'Start:'+trim(l.SentenceBeginDate)+ 'End:'+trim(l.SentenceEndDate),
                              l.SentenceBeginDate <> '' =>'Start:'+ trim(l.SentenceBeginDate),
                              l.SentenceEndDate <> '' =>'End:'+ trim(l.SentenceEndDate),
                                                                                                                                                                                                                                                '');
  self.Probation_desc2     := MAP(vVendor = '8A' => NVClarkProbation2,
	                            prob_dates <> '' and l.probationstatus <> '' =>  trim(prob_dates)+ '-' + l.probationstatus,
                              prob_dates <> '' =>  trim(prob_dates),
                                                                                                                                                                                                                                                l.probationstatus);
  self.court_dt            := l.courtdate;               

	self.court_county        := MAP(regexfind('^COUNTY: ([A-Z ]+)[ ]+$',l.caseinfo) => 	regexreplace('^COUNTY: ([A-Z ]+)[ ]+$',l.caseinfo,'$1'),
	                                regexfind('^COUNTY: ([A-Z]+)[ ]+$',l.caseinfo) => 	regexreplace('^COUNTY: ([A-Z]+)[ ]+$',l.caseinfo,'$1')
									              ,'');
	self.Hyg_classification_code := l.classification_code;
end;


//REMOVE RECORDS WITH NO VENDOR CODE ASSIGNED////////////////////////////////////
//output(j_final(recordid in ['FLLEON237899','FLLEON237900','FLLEON237901']));
//output(j_final(offensedesc ='AGG MEN. AMEND TO DC M4'));

result_common                := project(j_final, to_court_offenses(left))(trim(vendor, left, right)<>'');
//output(result_common(court_off_desc_1 ='AGG MEN. AMEND TO DC M4' and vendor ='YK'));

/////////////////////////////////////////////////////////////////////////

filtered_result := result_common(off_date <> '' or arr_date <> '' or  le_agency_cd <> '' or le_agency_desc <> '' or le_agency_case_number <> '' or
																 traffic_ticket_number <> '' or traffic_dl_no <> '' or traffic_dl_st <> '' or arr_off_code <> '' or arr_off_desc_1 <> '' or 
																 arr_off_desc_2<> '' or arr_off_type_cd<> '' or arr_off_type_desc<> '' or  arr_off_lev <> '' or arr_statute <> '' or 
																 arr_statute_desc <> '' or arr_disp_date<> '' or arr_disp_code <> '' or arr_disp_desc_1 <> '' or arr_disp_desc_2 <> '' or 
																 pros_refer_cd <> '' or pros_refer <> '' or pros_assgn_cd <> '' or pros_assgn <> '' or pros_chg_rej <> '' or pros_off_code <> '' or 
																 pros_off_desc_1 <> '' or pros_off_desc_2 <> '' or pros_off_type_cd <> '' or pros_off_type_desc <> '' or pros_off_lev <> '' or 
																 pros_act_filed <> '' /*or court_case_number <> ''*/ or court_cd <> '' or court_desc <> '' or court_appeal_flag <> '' or 
																 court_final_plea <> '' or  court_off_code<> '' or  court_off_desc_1<> '' or  court_off_desc_2 <> '' or court_off_type_cd <> '' or  
																 court_off_type_desc <> '' or court_off_lev <> '' or  court_statute <> '' or  court_additional_statutes <> '' or  court_statute_desc <> '' or 
																 court_disp_date<> '' or court_disp_code<> '' or  court_disp_desc_1<> '' or  court_disp_desc_2<> '' or sent_date <> '' or  sent_jail <> '' or  
																 sent_susp_time <> '' or sent_court_cost <> '' or sent_court_fine <> '' or sent_susp_court_fine <> '' or  sent_probation<> '' or 
																 sent_addl_prov_code <> '' or  sent_addl_prov_desc_1 <> '' or sent_addl_prov_desc_2 <> '' or sent_consec <> '' or  
																 sent_agency_rec_cust_ori <> '' or  sent_agency_rec_cust <> '' or appeal_date <> '' or appeal_off_disp <> '' or appeal_final_decision <> '' or
                                 offense_town <> ''or convict_dt <> '' or cty_conv <> '' or restitution <> '' or community_service               <> '' or parole <> '' or    
                                 addl_sent_dates <> '' or Probation_desc2 <> '' or court_dt <> '' or court_county <> '');
                                                                                                                                                                                                                                                                                                
                                                                                                                                                                                                                                                                                                 
// sorted_rcommon            := sort(distribute(filtered_result,HASH(offender_key,vendor,source_file)),offender_key,vendor, source_file,off_date, /*court_Case_number,*/  arr_date,le_agency_desc,arr_disp_date,traffic_ticket_number,arr_off_desc_1,arr_off_desc_2,
														 // court_desc,court_final_plea, court_off_code,court_off_desc_1,court_off_desc_2, court_off_lev, court_statute, /*court_statute_desc,*/court_disp_date,
														 // court_disp_code, court_disp_desc_1,court_disp_desc_2,offense_town,convict_dt,cty_conv,sent_date,sent_jail, sent_susp_time,sent_court_cost, 
														 // sent_court_fine, sent_probation,sent_consec,appeal_date, sent_addl_prov_desc_1,sent_addl_prov_desc_2,sent_agency_rec_cust,Probation_desc2,addl_sent_dates,
                             // restitution,community_service,parole,court_dt,court_county,local) ;
														 
sorted_rcommon            := sort(distribute(filtered_result,HASH(offender_key,vendor,source_file)),offender_key,vendor, source_file,
                             StringLib.StringFilter(StringLib.StringToUpperCase(court_off_desc_1+court_off_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
                             off_date,court_Case_number, /* arr_date,*/court_disp_desc_2,
														 StringLib.StringFilter(StringLib.StringToUpperCase(court_disp_desc_1),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
														 le_agency_desc,traffic_ticket_number,arr_disp_date,arr_off_desc_1,arr_off_desc_2,
														 court_final_plea,court_desc, court_off_code,court_statute, court_off_lev,court_disp_code, 
														 court_disp_date,
														 offense_town,convict_dt,cty_conv,sent_date,sent_jail, sent_susp_time,sent_court_cost, 
														 sent_court_fine, sent_probation,sent_consec,appeal_date, sent_addl_prov_desc_1,sent_addl_prov_desc_2,sent_agency_rec_cust,Probation_desc2,addl_sent_dates,
                             restitution,community_service,parole,court_county,-court_dt,local);					//court date causing dups in FM									 

sorted_rcommon rollupCrim(sorted_rcommon L, sorted_rcommon R) := TRANSFORM
                self.arr_date             := if(l.arr_date              = '', r.arr_date      ,l.arr_date);
                self.le_agency_desc       := if(l.le_agency_desc        = '', r.le_agency_desc,l.le_agency_desc);
                self.arr_disp_date        := if(l.arr_disp_date         = '', r.arr_disp_date ,l.arr_disp_date)  ; 
                self.traffic_ticket_number:= if(l.traffic_ticket_number = '', r.traffic_ticket_number,l.traffic_ticket_number) ; 
                self.arr_off_desc_1       := if(l.arr_off_desc_1    = '', r.arr_off_desc_1,l.arr_off_desc_1) ; 
                self.arr_off_desc_2       := if(l.arr_off_desc_2    = '', r.arr_off_desc_2,l.arr_off_desc_2) ;            
                self.court_final_plea     := if(l.court_final_plea  = '', r.court_final_plea, l.court_final_plea);
                self.court_desc           := if(l.court_desc  = '', r.court_desc, l.court_desc);      
                self.court_off_code       := if(l.court_off_code    = '', r.court_off_code, l.court_off_code);
                self.court_off_desc_1     := if(l.court_off_desc_1  = '', r.court_off_desc_1, l.court_off_desc_1);
                self.court_off_desc_2     := if(l.court_off_desc_2  = '', r.court_off_desc_2, l.court_off_desc_2);
                self.court_off_lev        := if(l.court_off_lev     = '', r.court_off_lev, l.court_off_lev);
                self.court_statute        := if(l.court_statute     = '', r.court_statute, l.court_statute);
//              self.court_statute_desc     := if(l.court_statute_desc= '', r.court_statute_desc, l.court_statute_desc);
                self.court_disp_code      := if(l.court_disp_code   = '', r.court_disp_code, l.court_disp_code);      
                self.court_disp_desc_1    := if(l.court_disp_desc_1 = '', r.court_disp_desc_1, l.court_disp_desc_1);
                self.court_disp_desc_2    := if(l.court_disp_desc_2 = '', r.court_disp_desc_2, l.court_disp_desc_2);
                self.court_disp_date      := if(l.court_disp_date   = '', r.court_disp_date, l.court_disp_date);
                self.offense_town         := if(l.offense_town      = '', r.offense_town , l.offense_town );
                self.convict_dt           := if(l.convict_dt        = '', r.convict_dt, l.convict_dt);
                self.cty_conv             := if(l.cty_conv          = '', r.cty_conv, l.cty_conv);  
                self.sent_date            := if(l.sent_date         = '', r.sent_date , l.sent_date);
                self.sent_jail            := if(l.sent_jail         = '', r.sent_jail , l.sent_jail);
                self.sent_susp_time       := if(l.sent_susp_time    = '', r.sent_susp_time , l.sent_susp_time);          
                self.sent_court_cost      := if(l.sent_court_cost   = '', r.sent_court_cost, l.sent_court_cost);
                self.sent_court_fine      := if(l.sent_court_fine   = '', r.sent_court_fine, l.sent_court_fine);
                self.sent_probation       := if(l.sent_probation    = '', r.sent_probation, l.sent_probation);
                self.sent_consec          := if(l.sent_consec       = '', r.sent_consec, l.sent_consec);
                self.appeal_date          := if(l.appeal_date       = '', r.appeal_date, l.appeal_date);
                self.sent_addl_prov_desc_1:= if(l.sent_addl_prov_desc_1    = '', r.sent_addl_prov_desc_1, l.sent_addl_prov_desc_1);
                self.sent_addl_prov_desc_2:= if(l.sent_addl_prov_desc_2    = '', r.sent_addl_prov_desc_2, l.sent_addl_prov_desc_2);
                self.sent_agency_rec_cust := if(l.sent_agency_rec_cust     = '', r.sent_agency_rec_cust , l.sent_agency_rec_cust );
                self.Probation_desc2      := if(l.Probation_desc2   = '', r.Probation_desc2 , l.Probation_desc2 );
                self.addl_sent_dates      := if(l.addl_sent_dates   = '', r.addl_sent_dates , l.addl_sent_dates );
                self.restitution          := if(l.restitution       = '', r.restitution , l.restitution );
                self.community_service    := if(l.community_service = '', r.community_service, l.community_service);
                self.parole               := if(l.parole            = '', r.parole, l.parole);
                self.court_dt             := if(l.court_dt          = '', r.court_dt, l.court_dt);
                self.court_county         := if(l.court_county      = '', r.court_county, l.court_county);
                SELF   := L; 
END;

// offender_key,vendor, source_file,StringLib.StringFilter(StringLib.StringToUpperCase(court_off_desc_1+court_off_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
// off_date,court_Case_number, /* arr_date,*/le_agency_desc,traffic_ticket_number,arr_disp_date,arr_off_desc_1,arr_off_desc_2,
// court_final_plea,court_desc, court_off_code,court_statute, court_off_lev,court_disp_code, 
// StringLib.StringFilter(StringLib.StringToUpperCase(court_disp_desc_1),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
// court_disp_desc_2,court_disp_date,
														 // offense_town,convict_dt,cty_conv,sent_date,sent_jail, sent_susp_time,sent_court_cost, 
														 // sent_court_fine, sent_probation,sent_consec,appeal_date, sent_addl_prov_desc_1,sent_addl_prov_desc_2,sent_agency_rec_cust,Probation_desc2,addl_sent_dates,
                             // restitution,community_service,parole,court_dt,court_county,local);		

rollupCrimOut := ROLLUP(sorted_rcommon,  left.offender_key = right.offender_key and 
              trim(left.vendor)      = trim(right.vendor) and 
							trim(left.source_file) = trim(right.source_file) and 
							StringLib.StringFilter(StringLib.StringToUpperCase(left.court_off_desc_1+left.court_off_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ') =StringLib.StringFilter(StringLib.StringToUpperCase(right.court_off_desc_1+right.court_off_desc_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ') and
							trim(left.off_date)     = trim(Right.off_date) and 
							trim(left.court_Case_number) = trim(right.court_Case_number) and 
						  (left.court_disp_desc_2 = right.court_disp_desc_2 or  right.court_disp_desc_2=''  or left.court_disp_desc_2 ='') and
							(StringLib.StringFilter(StringLib.StringToUpperCase(left.court_disp_desc_1),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ') =StringLib.StringFilter(StringLib.StringToUpperCase(right.court_disp_desc_1),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ') or right.court_disp_desc_1='' or left.court_disp_desc_1 ='')and							
							
							(left.le_agency_desc         = right.le_agency_desc   or   right.le_agency_desc   ='' or left.le_agency_desc  ='') and 
							(left.traffic_ticket_number  = right.traffic_ticket_number or right.traffic_ticket_number =''             or left.traffic_ticket_number     ='') and 
							(left.arr_disp_date          = right.arr_disp_date    or   right.arr_disp_date    ='' or left.arr_disp_date        ='') and 
							(left.arr_off_desc_1         = right.arr_off_desc_1   or   right.arr_off_desc_1   ='' or left.arr_off_desc_1   ='') and                                 
							(left.arr_off_desc_2         = right.arr_off_desc_2   or   right.arr_off_desc_2   ='' or left.arr_off_desc_2   ='') and 
							(left.court_final_plea       = right.court_final_plea or   right.court_final_plea ='' or left.court_final_plea ='') and                                                                                                                                                                                                
							(left.court_desc             = right.court_desc       or   right.court_desc       ='' or left.court_desc       ='') and
							(
								 ((left.court_off_code     = right.court_off_code   or   right.court_off_code   ='' or left.court_off_code   ='') and (right.court_statute  ='' and left.court_statute   ='')) OR
								 ((left.court_statute      = right.court_statute    or   right.court_statute    ='' or left.court_statute    ='') and (right.court_off_code ='' and left.court_off_code  ='')) 
							)              and
							(left.court_off_lev     = right.court_off_lev    or   right.court_off_lev    =''  or left.court_off_lev     ='') and
              (left.court_disp_code   = right.court_disp_code  or   right.court_disp_code  =''  or left.court_disp_code   ='') and
							(left.court_disp_date   = right.court_disp_date   or  right.court_disp_date  =''  or left.court_disp_date   ='') and
							(left.offense_town      = right.offense_town      or  right.offense_town     =''  or left.offense_town      ='') and
							(left.convict_dt        = right.convict_dt        or  right.convict_dt       =''  or left.convict_dt        ='') and
							(left.cty_conv          = right.cty_conv          or  right.cty_conv         =''  or left.cty_conv          ='') and
							(left.sent_date         = right.sent_date         or  right.sent_date        =''  or left.sent_date         ='') and
							(left.sent_jail         = right.sent_jail         or  right.sent_jail        =''  or left.sent_jail         ='') and
							(left.sent_susp_time    = right.sent_susp_time    or  right.sent_susp_time   =''  or left.sent_susp_time    ='') and                                                                                                                                                                                              
							(left.sent_court_cost   = right.sent_court_cost   or  right.sent_court_cost  =''  or left.sent_court_cost   ='') and
							(left.sent_court_fine   = right.sent_court_fine   or  right.sent_court_fine  =''  or left.sent_court_fine   ='') and
							(left.sent_probation    = right.sent_probation    or  right.sent_probation   =''  or left.sent_probation    ='') and
							(left.sent_consec       = right.sent_consec       or  right.sent_consec      =''  or left.sent_consec       ='') and
							(left.appeal_date       = right.appeal_date       or  right.appeal_date      =''  or left.appeal_date       ='') and
							(left.sent_addl_prov_desc_1 = right.sent_addl_prov_desc_1  or  right.sent_addl_prov_desc_1 ='' or left.sent_addl_prov_desc_1  ='') and
							(left.sent_addl_prov_desc_2 = right.sent_addl_prov_desc_2  or  right.sent_addl_prov_desc_2 ='' or left.sent_addl_prov_desc_2  ='') and                                                                                                                                                                                 
							(left.sent_agency_rec_cust  = right.sent_agency_rec_cust   or  right.sent_agency_rec_cust  ='' or left.sent_agency_rec_cust   ='') and
							(left.Probation_desc2    = right.Probation_desc2  or  right.Probation_desc2   ='' or left.Probation_desc2   ='') and                                                                                                                                                                 
							(left.addl_sent_dates    = right.addl_sent_dates  or  right.addl_sent_dates   ='' or left.addl_sent_dates   ='') and
							(left.restitution        = right.restitution      or  right.restitution       ='' or left.restitution       ='') and
							(left.community_service  = right.community_service or  right.community_service='' or left.community_service ='') and
              (left.parole             = right.parole           or  right.parole            ='' or left.parole            ='') and
							//(left.court_dt           = right.court_dt         or  right.court_dt          ='' or left.court_dt          ='') and
							(left.court_county       = right.court_county     or  right.court_county      ='' or left.court_county      ='') ,
							
							rollupCrim(LEFT,RIGHT),local) : persist ('~thor200_144::persist::hygenics::crimtemp::HD::county::offenses');
							
Set_offender_key:=[//'FM4884167878826446502372013CF002543A0010020130808',             
                     'FE330909699634058488800014069CF10A20000811'        ];

// output(sorted_rcommon(offender_key in Set_offender_key));
// output(rollupCrimOut(offender_key in Set_offender_key));
// result_dedup                := dedup(rollupCrimOut, record,EXCEPT num_of_counts, local)  : persist ('~thor200_144::persist::hygenics::crim::HD::county::offense');
export proc_build_county_court_offenses :=  rollupCrimOut; 