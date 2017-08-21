import Crim_Common, Address, lib_stringlib;

/***************************************************************************/
/* Declare local variables used within the data */
Vendor_id        := '31';
origin_st        := 'OR';
source_file_name := 'OR_CRIM_COURT';

/***************************************************************************/
// Declare datasets needed to map the offender data
ds_charges       := sort(CRIM.File_OR_Raw_Charges      ,court_type,court_location,case_number);
ds_party         := sort(CRIM.File_OR_Raw_Party        ,court_type,court_location,case_number,party_side,party_id);
ds_crim_cases    :=      CRIM.Name_OR_Case_Courts;
ds_laws          := sort(CRIM.File_OR_Raw_Laws         ,law_code,law_number);
ds_sentences     := sort(CRIM.File_OR_Raw_Sentences    ,court_type,court_location,case_number);
ds_amounts       := sort(CRIM.File_OR_Raw_Amounts      ,court_type,court_location,case_number)(related_record_type = 'CRG'
                                                                                            or related_record_type = 'SNT');

/***************************************************************************/
/* Create lookups datasets*/
ds_Case_Court_Agency    := dedup(CRIM.File_OR_Lookup_Codes(Table_Type = 'TB11')
                                ,Table_Key);
ds_Charge_Status        := dedup(CRIM.File_OR_Lookup_Codes(Table_Type = 'TB13')
                                ,Table_Key);
ds_snt_jgmt_amount_type := dedup(CRIM.File_OR_Lookup_Codes(Table_Type = 'TB24')
                                ,Table_Key);
ds_Decision_Type        := dedup(CRIM.File_OR_Lookup_Codes(Table_Type = 'TB26')
                                ,Table_Key);
ds_Decision_Status      := dedup(CRIM.File_OR_Lookup_Codes(Table_Type = 'TB27')
                                ,Table_Key);
ds_sentence_modifier    := dedup(CRIM.File_OR_Lookup_Codes(Table_Type = 'TB46')
                                ,Table_Key);

/***************************************************************************/
/* Distribute for joining case and party */
ds_crim_amounts := distribute(ds_amounts, hash32(court_type,court_location,case_number));

layout_case_amount := record
   ds_crim_cases;
   Crim.Layout_OR_Amounts AND NOT [Court_Type          ,Court_Location      ,Case_Number
                                  ,Record_Changed_Date ,Record_Changed_Time
								  ,Command_Name        ,User_ID];
end;

layout_case_amount jCaseAmount (ds_amounts L, ds_crim_cases R) := transform
   self := L;
   self := R;
end;

ds_case_amount := join(ds_crim_amounts, ds_crim_cases
                      ,LEFT.court_type     = RIGHT.court_type
			       AND LEFT.court_location = RIGHT.court_location
				   AND LEFT.case_number    = RIGHT.case_number
                      ,jCaseAmount(LEFT,RIGHT)
				      ,LOCAL);

/* Map the amount description lookup values */
layout_case_amount_desc := record
   layout_case_amount;
   string50 amount_type_desc;
   string30 amount_modifier_desc;
   string20 amount_unit_desc;
end;

layout_case_amount_desc jCaseAmountType(ds_case_amount L, ds_snt_jgmt_amount_type R) := transform
   self                      := L;
   self.amount_type_desc     := trim(R.Full_Description,left,right);
   self.amount_modifier_desc := '';
   self.amount_unit_desc     := CRIM.Lookup_OR_Crim_Data.snt_jgmt_units_lookup(L.Amount_Unit);
end;

ds_case_amount_desc := join(ds_case_amount, ds_snt_jgmt_amount_type
                           ,LEFT.amount_type = trim(RIGHT.table_key,left,right)
						   ,jCaseAmountType(left,right)
						   ,LEFT OUTER
						   ,LOOKUP);

output(ds_case_amount_desc,,'~thor_data400::temp::OR_Crim_Court_chg_amount_descs',overwrite);

/* Map the amount modifier description lookup values */
layout_case_amount_desc jCaseAmountModifier(ds_case_amount_desc L, ds_sentence_modifier R) := transform
   self.amount_modifier_desc := trim(R.Full_Description,left,right);
   self                      := L;
end;

ds_case_amount_modifier_desc := join(ds_case_amount_desc, ds_sentence_modifier
                                    ,LEFT.amount_modifier = trim(RIGHT.table_key,left,right)
									,jCaseAmountModifier(left,right)
									,LEFT OUTER
									,LOOKUP);

output(ds_case_amount_modifier_desc,,'~thor_data400::temp::OR_Crim_Court_chg_amount_modifiers',overwrite);

/***************************************************************************/
/* Lookup the details on the individual laws referenced within the charges */
layout_charge_law_desc := record
	Crim.Layout_OR_charges;
	string30 law_number_desc;
	string1  law_number_class;
	string3  law_number_code;
end;

layout_charge_law_desc jChargeLaws (ds_charges L, ds_laws R) := transform
   self                  := L;
   self.law_number_desc  := R.description;
   self.law_number_class := R.penalty_class;
   self.law_number_code  := R.penalty_code;
end;

ds_charge_laws := join(ds_charges,ds_laws
					  ,LEFT.law_number = RIGHT.law_number
					  ,jChargeLaws(LEFT,RIGHT)
					  ,LEFT OUTER
					  ,LOOKUP);

/***************************************************************************/
/* Lookup the details on the description fields within the charges */

/* Combined layout for all three lookups */
layout_charge_desc := record
   layout_charge_law_desc;
   string50 charge_law_agency_desc := '';
   string50 charge_status_desc     := '';
   string50 original_agency_desc   := '';
end;

/* Lookup for the charging agency */
layout_charge_desc jChargeLawAgencyDesc (ds_charge_laws L, ds_Case_Court_Agency R) := transform
   self.charge_law_agency_desc := trim(R.Full_Description,left,right);
   self                        := L;
end;

ds_charge_agency := join(ds_charge_laws, ds_Case_Court_Agency
                        ,trim(LEFT.Law_Agency,left,right) = trim(RIGHT.table_key,left,right)
						,jChargeLawAgencyDesc(left,right)
						,LEFT OUTER
						,LOOKUP);

/* Lookup for the charge status */
layout_charge_desc jChargeLawStatusDesc (ds_charge_agency L, ds_Charge_Status R) := transform
   self.charge_law_agency_desc := trim(R.Full_Description,left,right);
   self                        := L;
end;

ds_charge_agency_status := join(ds_charge_agency, ds_Charge_Status
                               ,trim(LEFT.Charge_Status,left,right) = trim(RIGHT.table_key,left,right)
							   ,jChargeLawStatusDesc(left,right)
							   ,LEFT OUTER
							   ,LOOKUP);

/* Lookup for the original agency */
layout_charge_desc jChargeOriginalAgencyDesc (ds_charge_agency_status L, ds_Case_Court_Agency R) := transform
   self.original_agency_desc := trim(R.Full_Description,left,right);
   self                      := L;
end;

ds_charge_orig_agency := join(ds_charge_agency_status, ds_Case_Court_Agency
                             ,trim(LEFT.Original_Agency,left,right) = trim(RIGHT.table_key,left,right)
					     	 ,jChargeOriginalAgencyDesc(left,right)
							 ,LEFT OUTER
							 ,LOOKUP);

/***************************************************************************/
/* Link Charges to amounts */
layout_case_charge_amount := record
   ds_crim_cases;
   layout_charge_desc     AND NOT [Court_Type         ,Court_Location     ,Case_Number
                                  ,Record_Changed_Date,Record_Changed_Time,Command_Name
							      ,User_ID];
   Crim.Layout_OR_Amounts AND NOT [Court_Type          ,Court_Location      ,Case_Number
                                  ,Record_Changed_Date ,Record_Changed_Time
								  ,Command_Name        ,User_ID             ,Record_Type];
end;

layout_case_charge_amount jCaseAmountcharge (ds_case_amount L, ds_charge_orig_agency R) := transform
   self := L;
   self := R;
end;

ds_case_charge_amount := join(distribute(ds_case_amount(related_record_type = 'CRG'),hash32(court_type,court_location,case_number,related_record_id))
                             ,distribute(ds_charge_orig_agency                      ,hash32(court_type,court_location,case_number,charge_id))
                             ,LEFT.court_type        = RIGHT.court_type
			              AND LEFT.court_location    = RIGHT.court_location
				          AND LEFT.case_number       = RIGHT.case_number
						  AND LEFT.related_record_id = RIGHT.charge_id
                             ,jCaseAmountcharge(LEFT,RIGHT)
				             ,LOCAL);

/***************************************************************************/
/* Lookup the details on the description fields within the charges */

/* Add lookup values to the sentence layout */
layout_sentence_descriptions := record
   CRIM.Layout_OR_Sentences;
   string50 snt_decision_type_desc    := '';
   string50 snt_decision_status_desc  := '';
end;   

/* Lookup for the sentence decision type */
layout_sentence_descriptions jSentDecisionTypeDesc (ds_sentences L, ds_Decision_Type R) := transform
   self.snt_decision_type_desc := trim(R.Full_Description,left,right);
   self                        := L;
end;

ds_sent_dec_type_desc := join(ds_sentences, ds_Decision_Type
                             ,trim(LEFT.Decision_Type,left,right) = trim(RIGHT.table_key,left,right)
							 ,jSentDecisionTypeDesc(left,right)
							 ,LEFT OUTER
							 ,LOOKUP);

/* Lookup for the sentence decision status */
layout_sentence_descriptions jSentDecisionStatusDesc (ds_sent_dec_type_desc L, ds_Decision_Status R) := transform
   self.snt_decision_status_desc := trim(R.Full_Description,left,right);
   self                          := L;
end;

ds_sent_dec_status_desc := join(ds_sent_dec_type_desc, ds_Decision_Status
                               ,trim(LEFT.Decision_Status,left,right) = trim(RIGHT.table_key,left,right)
							   ,jSentDecisionStatusDesc(left,right)
							   ,LEFT OUTER
							   ,LOOKUP);

/***************************************************************************/
/* Link Sentences to case-amounts */

/* Create combined layout for case-sentence-amounts */
layout_case_sentence_amount := record
	string1  snt_Court_Type;
	string3  snt_Court_Location;
	string10 snt_Case_Number;
	string3  snt_Record_Type;
	string3  snt_Related_Party_Side;
	string5  snt_Related_Party_Id;
	string2  snt_Case_Class;
	string2  snt_Case_Type;
	string4  snt_Case_Status;
	string10 snt_Master_Case_Number;
	string3  snt_Master_Case_Type;
	string7  snt_Date_Case_Filed;
	string7  snt_Date_Case_Started;
	string7  snt_Initial_Entry_Date;
	string2  snt_Case_Origin;
	string4  snt_Starting_Instrument;
	string10 snt_District_Attorney_Number;
	string4  snt_Previous_Court;
	string10 snt_Previous_Case_Number;
	string4  snt_Previous_Decision;
	string4  snt_Termination_Stage;
	string4  snt_Termination_Type;
	string1  snt_Inre_Case;
	string1  snt_Exrel_Case;
	string11 snt_Amount_Prayed_For;
    Crim.Layout_OR_Sentences AND NOT [Court_Type         ,Court_Location     ,Case_Number
                                     ,Record_Changed_Date,Record_Changed_Time,Command_Name
							         ,User_ID];
	string50 snt_decision_type_desc    := '';
	string50 snt_decision_status_desc  := '';
	string5  snt_Amount_Id;
	string3  snt_Related_Record_Type;
	string5  snt_Related_Record_Id;
	string4  snt_Amount_Type;
	string4  snt_Amount_Modifier;
	string1  snt_Amount_Unit;
	string11 snt_Dollars;
	string9  snt_Non_Dollars;
	string5  snt_Related_Jgm_Amount_Id;
	string9  snt_Related_Receivable_Number;
	string3  snt_Related_Receivable_Sequence;
	string1  snt_Judgment_Flag;
end;

layout_case_sentence_amount jCaseAmountSentence (ds_case_amount L, ds_sent_dec_status_desc R) := transform
    self                                 := R;
	self.snt_Court_Type                  := l.Court_Type;
	self.snt_Court_Location              := l.Court_Location;
	self.snt_Case_Number                 := l.Case_Number;
	self.snt_Record_Type                 := l.Record_Type;
	self.snt_Related_Party_Side          := l.Related_Party_Side;
	self.snt_Related_Party_Id            := l.Related_Party_Id;
	self.snt_Case_Class                  := l.Case_Class;
	self.snt_Case_Type                   := l.Case_Type;
	self.snt_Case_Status                 := l.Case_Status;
	self.snt_Master_Case_Number          := l.Master_Case_Number;
	self.snt_Master_Case_Type            := l.Master_Case_Type;
	self.snt_Date_Case_Filed             := l.Date_Case_Filed;
	self.snt_Date_Case_Started           := l.Date_Case_Started;
	self.snt_Initial_Entry_Date          := l.Initial_Entry_Date;
	self.snt_Case_Origin                 := l.Case_Origin;
	self.snt_Starting_Instrument         := l.Starting_Instrument;
	self.snt_District_Attorney_Number    := l.District_Attorney_Number;
	self.snt_Previous_Court              := l.Previous_Court;
	self.snt_Previous_Case_Number        := l.Previous_Case_Number;
	self.snt_Previous_Decision           := l.Previous_Decision;
	self.snt_Termination_Stage           := l.Termination_Stage;
	self.snt_Termination_Type            := l.Termination_Type;
	self.snt_Inre_Case                   := l.Inre_Case;
	self.snt_Exrel_Case                  := l.Exrel_Case;
	self.snt_Amount_Prayed_For           := l.Amount_Prayed_For;
	self.snt_Amount_Id                   := l.Amount_Id;
	self.snt_Related_Record_Type         := l.Related_Record_Type;
	self.snt_Related_Record_Id           := l.Related_Record_Id;
	self.snt_Amount_Type                 := l.Amount_Type;
	self.snt_Amount_Modifier             := l.Amount_Modifier;
	self.snt_Amount_Unit                 := l.Amount_Unit;
	self.snt_Dollars                     := l.Dollars;
	self.snt_Non_Dollars                 := l.Non_Dollars;
	self.snt_Related_Jgm_Amount_Id       := l.Related_Jgm_Amount_Id;
	self.snt_Related_Receivable_Number   := l.Related_Receivable_Number;
	self.snt_Related_Receivable_Sequence := l.Related_Receivable_Sequence;
	self.snt_Judgment_Flag               := l.Judgment_Flag;
end;

ds_case_sentence_amount := join(distribute(ds_case_amount(related_record_type = 'SNT'),hash32(court_type,court_location,case_number,related_record_id))
                               ,distribute(ds_sent_dec_status_desc                    ,hash32(court_type,court_location,case_number,sentence_id))
                          ,LEFT.court_type        = RIGHT.court_type
			           AND LEFT.court_location    = RIGHT.court_location
				       AND LEFT.case_number       = RIGHT.case_number
					   AND LEFT.related_record_id = RIGHT.sentence_id
                          ,jCaseAmountSentence(LEFT,RIGHT)
				          ,LOCAL);

layout_case_charge_sentence := record
	layout_case_charge_amount;
    layout_case_sentence_amount AND NOT [Record_Type        ,Charge_ID];
end;

/***************************************************************************/
/* Link Sentences to charges */
layout_case_charge_sentence jChargeSentence (ds_case_charge_amount L, ds_case_sentence_amount R) := transform
	self.Court_Type                  := if(l.Court_Type != '' ,l.Court_Type ,r.snt_Court_Type);
	self.Court_Location              := if(l.Court_Location != '' ,l.Court_Location ,r.snt_Court_Location);
	self.Case_Number                 := if(l.Case_Number != '' ,l.Case_Number ,r.snt_Case_Number);
	self.Record_Type                 := if(l.Record_Type != '' ,l.Record_Type ,r.snt_Record_Type);
	self.Related_Party_Side          := if(l.Related_Party_Side != '' ,l.Related_Party_Side ,r.snt_Related_Party_Side);
	self.Related_Party_Id            := if(l.Related_Party_Id != '' ,l.Related_Party_Id ,r.snt_Related_Party_Id);
	self.Case_Class                  := if(l.Case_Class != '' ,l.Case_Class ,r.snt_Case_Class);
	self.Case_Type                   := if(l.Case_Type != '' ,l.Case_Type ,r.snt_Case_Type);
	self.Case_Status                 := if(l.Case_Status != '' ,l.Case_Status ,r.snt_Case_Status);
	self.Master_Case_Number          := if(l.Master_Case_Number != '' ,l.Master_Case_Number ,r.snt_Master_Case_Number);
	self.Master_Case_Type            := if(l.Master_Case_Type != '' ,l.Master_Case_Type ,r.snt_Master_Case_Type);
	self.Date_Case_Filed             := if(l.Date_Case_Filed != '' ,l.Date_Case_Filed ,r.snt_Date_Case_Filed);
	self.Date_Case_Started           := if(l.Date_Case_Started != '' ,l.Date_Case_Started ,r.snt_Date_Case_Started);
	self.Initial_Entry_Date          := if(l.Initial_Entry_Date != '' ,l.Initial_Entry_Date ,r.snt_Initial_Entry_Date);
	self.Case_Origin                 := if(l.Case_Origin != '' ,l.Case_Origin ,r.snt_Case_Origin);
	self.Starting_Instrument         := if(l.Starting_Instrument != '' ,l.Starting_Instrument ,r.snt_Starting_Instrument);
	self.District_Attorney_Number    := if(l.District_Attorney_Number != '' ,l.District_Attorney_Number ,r.snt_District_Attorney_Number);
	self.Previous_Court              := if(l.Previous_Court != '' ,l.Previous_Court ,r.snt_Previous_Court);
	self.Previous_Case_Number        := if(l.Previous_Case_Number != '' ,l.Previous_Case_Number ,r.snt_Previous_Case_Number);
	self.Previous_Decision           := if(l.Previous_Decision != '' ,l.Previous_Decision ,r.snt_Previous_Decision);
	self.Termination_Stage           := if(l.Termination_Stage != '' ,l.Termination_Stage ,r.snt_Termination_Stage);
	self.Termination_Type            := if(l.Termination_Type != '' ,l.Termination_Type ,r.snt_Termination_Type);
	self.Inre_Case                   := if(l.Inre_Case != '' ,l.Inre_Case ,r.snt_Inre_Case);
	self.Exrel_Case                  := if(l.Exrel_Case != '' ,l.Exrel_Case ,r.snt_Exrel_Case);
	self.Amount_Prayed_For           := if(l.Amount_Prayed_For != '' ,l.Amount_Prayed_For ,r.snt_Amount_Prayed_For);
	self.Amount_Id                   := if(l.Amount_Id != '' ,l.Amount_Id ,r.snt_Amount_Id);
	self.Related_Record_Type         := if(l.Related_Record_Type != '' ,l.Related_Record_Type ,r.snt_Related_Record_Type);
	self.Related_Record_Id           := if(l.Related_Record_Id != '' ,l.Related_Record_Id ,r.snt_Related_Record_Id);
	self.Amount_Type                 := if(l.Amount_Type != '' ,l.Amount_Type ,r.snt_Amount_Type);
	self.Amount_Modifier             := if(l.Amount_Modifier != '' ,l.Amount_Modifier ,r.snt_Amount_Modifier);
	self.Amount_Unit                 := if(l.Amount_Unit != '' ,l.Amount_Unit ,r.snt_Amount_Unit);
	self.Dollars                     := if(l.Dollars != '' ,l.Dollars ,r.snt_Dollars);
	self.Non_Dollars                 := if(l.Non_Dollars != '' ,l.Non_Dollars ,r.snt_Non_Dollars);
	self.Related_Jgm_Amount_Id       := if(l.Related_Jgm_Amount_Id != '' ,l.Related_Jgm_Amount_Id ,r.snt_Related_Jgm_Amount_Id);
	self.Related_Receivable_Number   := if(l.Related_Receivable_Number != '' ,l.Related_Receivable_Number ,r.snt_Related_Receivable_Number);
	self.Related_Receivable_Sequence := if(l.Related_Receivable_Sequence != '' ,l.Related_Receivable_Sequence ,r.snt_Related_Receivable_Sequence);
	self.Judgment_Flag               := if(l.Judgment_Flag != '' ,l.Judgment_Flag ,r.snt_Judgment_Flag);
    self := L;
    self := R;
end;

ds_charge_sentence := join(distribute(ds_case_charge_amount  ,hash32(court_type    ,court_location    ,case_number    ,charge_id))
                          ,distribute(ds_case_sentence_amount,hash32(snt_court_type,snt_court_location,snt_case_number,charge_id))
                          ,LEFT.court_type     = RIGHT.snt_court_type
 	                   AND LEFT.court_location = RIGHT.snt_court_location
					   AND LEFT.case_number    = RIGHT.snt_case_number
					   AND LEFT.charge_id      = RIGHT.charge_id
					      ,jChargeSentence(LEFT,RIGHT)
						  ,full outer
						  ,LOCAL);

output(ds_charge_sentence,,'~thor_data400::temp::or_crim_court_sentence_amounts',overwrite);

/***************************************************************************/
/* Declare layout minus unecessary information */
layout_slim_case_pty := RECORD
  string1  pty_court_type;
  string3  pty_court_location;
  string10 pty_case_number;
  string5  pty_party_id;
  string1  court_type;
  string3  court_location;
  string10 case_number;
  string3  related_party_side;
  string5  related_party_id;
  string2  case_class;
  string2  case_type;
  string4  case_status;
  string10 master_case_number;
  string3  master_case_type;
  string7  date_case_filed;
  string7  date_case_started;
  string7  initial_entry_date;
  string2  case_origin;
  string4  starting_instrument;
  string10 district_attorney_number;
  string4  previous_court;
  string10 previous_case_number;
  string4  previous_decision;
  string4  termination_stage;
  string4  termination_type;
  string1  inre_case;
  string1  exrel_case;
  string11 amount_prayed_for;
  string40 case_court_name;
  string3  record_type;
  string5  charge_id;
  string5  previous_charge_id;
  string5  charge_count;
  string7  incident_date;
  string7  citation_issue_date;
  string4  law_agency;
  string8  law_number;
  string30 law_number_desc;
  string1  law_number_class;
  string3  law_number_code;
  string4  law_code;
  string4  charge_modifier_agency;
  string8  charge_modifier_number;
  string10 citation_number;
  string4  original_agency;
  string10 original_agency_report_num;
  string6  bpst_number;
  string2  license_plate_state;
  string8  license_plate_number;
  string1  accident_related;
  string1  employment_related;
  string4  charge_status;
  string7  charge_status_date;
  string5  amount_id;
  string3  related_record_type;
  string5  related_record_id;
  string4  amount_type;
  string4  amount_modifier;
  string1  amount_unit;
  string11 dollars;
  string9  non_dollars;
  string5  related_jgm_amount_id;
  string9  related_receivable_number;
  string3  related_receivable_sequence;
  string1  judgment_flag;
  string1  snt_court_type;
  string3  snt_court_location;
  string10 snt_case_number;
  string3  snt_record_type;
  string3  snt_related_party_side;
  string5  snt_related_party_id;
  string2  snt_case_class;
  string2  snt_case_type;
  string4  snt_case_status;
  string10 snt_master_case_number;
  string3  snt_master_case_type;
  string7  snt_date_case_filed;
  string7  snt_date_case_started;
  string7  snt_initial_entry_date;
  string2  snt_case_origin;
  string4  snt_starting_instrument;
  string10 snt_district_attorney_number;
  string4  snt_previous_court;
  string10 snt_previous_case_number;
  string4  snt_previous_decision;
  string4  snt_termination_stage;
  string4  snt_termination_type;
  string1  snt_inre_case;
  string1  snt_exrel_case;
  string11 snt_amount_prayed_for;
  string5  sentence_id;
  string4  decision_type;
  string7  decision_date;
  string1  finacinal_system_flag;
  string7  due_date;
  string4  decision_status;
  string7  decision_status_date;
  string5  snt_amount_id;
  string3  snt_related_record_type;
  string5  snt_related_record_id;
  string4  snt_amount_type;
  string4  snt_amount_modifier;
  string1  snt_amount_unit;
  string11 snt_dollars;
  string9  snt_non_dollars;
  string5  snt_related_jgm_amount_id;
  string9  snt_related_receivable_number;
  string3  snt_related_receivable_sequence;
  string1  snt_judgment_flag;
  string	description;
  string	penalty_class;
  string	penalty_code;
  string disposition;
  
  
END;

						  
/* Distribute for joining case and party */
ds_crim_offenders := distribute(ds_party,hash32(court_type,court_location,case_number));

/***************************************************************************/
/* Link party to charges/sentences/amounts */

layout_slim_case_pty jcase_party(ds_crim_offenders L, ds_charge_sentence R) := transform
   self.pty_court_type     := L.court_type;
   self.pty_court_location := L.court_location;
   self.pty_case_number    := L.case_number;
   self.pty_party_id       := L.party_id;
   self := R;
   self := L;
   self := [];
end;

ds_party_offenses := join(       ds_crim_offenders
					 ,distribute(ds_charge_sentence,hash32(court_type,court_location,case_number))
					 ,LEFT.court_type   = RIGHT.court_type
			    AND LEFT.court_location = RIGHT.court_location
				AND LEFT.case_number    = RIGHT.case_number
                   ,jcase_party(LEFT,RIGHT)
				   ,LOCAL);


layout_slim_case_pty jlaw_off(ds_party_offenses l, ds_laws r) := transform
	self.description := r.description;
	self.penalty_class := r.penalty_class;
	self.penalty_code := r.penalty_code;
	self := l;
end;

ds_party_offenses_dsc := join(ds_party_offenses, ds_laws, left.law_agency = right.law_agency and left.law_number = right.law_number,
							jlaw_off(left, right), left outer);
							
							

layout_slim_case_pty jlaw_disp(ds_party_offenses l, ds_Charge_Status r) := transform
	self.disposition := r.full_description;
	self := l;
end;

ds_party_disp_dsc := join(ds_party_offenses, ds_Charge_Status, trim(left.decision_type, all) = trim(right.table_key, all),
							jlaw_disp(left, right), left outer);

/***************************************************************************/
/* Clean and map the combined data to the standard offenses layout */

// Filter for valid records
fOR_Crim := ds_party_disp_dsc(regexfind('[1-9]', trim(case_number,left,right)));








/* Clean date values */
string8  date_clean(string7 input_date) := if(trim(input_date,left,right) != '' and input_date != '0000000'
											 ,  if(input_date[1..1] = '1','20','19')
											  +    input_date[2..3]
											  +    input_date[4..5]
											  +    input_date[6..7]
											 ,'');



// crim_common.Layout_Moxie_DOC_Offenses tOR_Crim_Map(fOR_Crim Input) := transform
// end;

// ds

export Map_OR_Offenses := fOR_Crim;
