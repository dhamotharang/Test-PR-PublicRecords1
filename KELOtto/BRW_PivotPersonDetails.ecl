IMPORT KELOtto;

AttributeDescriptionSet := 
  [
  
    'Associated SSN Count',
    'Contributory Count',

    'Years between death and first event',

    'Deceased Prior to all events',
    'Deceased Significantly prior to events',
    'Deceased Event Percent',

    'Death prior to all contributory events',
    'Death significantly prior to all contributory events',
    'Contributory deceased event count',
    'Contributory deceased event percent',

    
    'Manipulated Identity Index',
    'Stolen Identity Index',
    'Suspicious Activity Index',
    'Synthetic Identity Index',
    'Vulnerable Victim Index',
    'Friendly Fraud Index'


  ];
  
/*
associated_ssn_count_
customer_person_customer_count_

all_max_deceased_to_event_diff_
death_prior_to_all_events_
high_risk_death_prior_to_all_events_
deceased_event_percent_
all_death_prior_to_all_events_
all_high_risk_death_prior_to_all_events_
all_deceased_event_count_
all_deceased_event_percent_

manipulated_identity_index_
stolen_identity_index_
suspicious_activity_index_
synthetic_identity_index_
vulnerable_victim_index_
friendlyfraud_index_

*/
  

AttributeIconSet := 
  [
    'fa-user',//'Associated SSN Count',
    'fa-user',//'Contributory Count',

    'fa-user',//'Years between death and first event',

    'fa-user',//'Deceased Prior to all events',
    'fa-user',//'Deceased Significantly prior to events',
    'fa-user',//'Deceased Event Percent',

    'fa-user',//'Death prior to all contributory events',
    'fa-user',//'Death significantly prior to all contributory events',
    'fa-user',//'Contributory deceased event count',
    'fa-user',//'Contributory deceased event percent',

    
    'fa-exclamation',//'Manipulated Identity Index',
    'fa-exclamation',//'Stolen Identity Index',
    'fa-exclamation',//'Suspicious Activity Index',
    'fa-exclamation',//'Synthetic Identity Index',
    'fa-exclamation',//'Vulnerable Victim Index',
    'fa-exclamation'//'Friendly Fraud Index'
 
  ];

CustomerAttributeSummaryRec := RECORD
  UNSIGNED customer_id_; 
  UNSIGNED source_customer_;
  UNSIGNED industry_type_;
  UNSIGNED Lex_Id_;
//  UNSIGNED source_customer_;
  INTEGER1 StatType;
  STRING Description;
  STRING More;
  STRING SummaryValue;
  STRING Icon;
  STRING MoreDescription;
  STRING MoreIcon;
  BOOLEAN HasValue;
END;  

CustomerAttributeSummaryRec tCustomerAttributeSummary(KELOtto.Q__show_Customer_Person.Res0 L, INTEGER C) := TRANSFORM
  SELF.customer_id_ := L.customer_id_;
  SELF.industry_type_ := L.industry_type_;
  SELF.source_customer_ := L.source_customer_;
  SELF.Lex_ID_ := L.lex_id_;
//  SELF.source_customer_ := L.fdn_file_info_id_;
  
  SELF.Description := AttributeDescriptionSet[C];
  SELF.More := 'More Info';
  SELF.StatType := CHOOSE(C, 1, 1, 
                             2, 2, 2, 2, 2, 2, 2, 2, 
                             20, 20, 20, 20, 20, 20);
  SELF.SummaryValue := CHOOSE(C, 
 
    (STRING)L.associated_ssn_count_,
    (STRING)L.customer_person_customer_count_,

    MAP(L.all_max_deceased_to_event_diff_ < 0 => (STRING)(L.all_max_deceased_to_event_diff_ * -1) + ' years', ''),
    MAP(L.death_prior_to_all_events_=1 => 'True', ''),
    MAP(L.high_risk_death_prior_to_all_events_ = 1 => 'True', ''),
    ROUND(L.deceased_event_percent_ * 100) + ' %', 
    MAP(L.all_death_prior_to_all_events_ =1 => 'True', ''),
    MAP(L.all_high_risk_death_prior_to_all_events_ = 1 => 'True', ''),
    (STRING)L.all_deceased_event_count_,
    ROUND(L.all_deceased_event_percent_ * 100) + ' %', 
    (STRING)L.manipulated_identity_index_,
    (STRING)L.stolen_identity_index_,
    (STRING)L.suspicious_activity_index_,
    (STRING)L.synthetic_identity_index_,
    (STRING)L.vulnerable_victim_index_,
    (STRING)L.friendlyfraud_index_);
  
  SELF.Icon := AttributeIconSet[C];
  SELF.MoreDescription := 'More info...';
  SELF.MoreIcon := 'fa-info';

  SELF.HasValue := CHOOSE(C, 
  
    MAP(L.associated_ssn_count_>0 => True, False),
    MAP(L.customer_person_customer_count_>0 => True, False),

    MAP(L.all_max_deceased_to_event_diff_ < 0 => True, False),
    MAP(L.death_prior_to_all_events_=1 => True, False),
    MAP(L.high_risk_death_prior_to_all_events_ = 1 => True, False),
    MAP(ROUND(L.deceased_event_percent_ * 100)>0 => True, False),
    MAP(L.all_death_prior_to_all_events_ =1 => True, False),
    MAP(L.all_high_risk_death_prior_to_all_events_ = 1 => True, False),
    MAP(L.all_deceased_event_count_>0 => True, False),
    MAP((L.all_deceased_event_percent_ * 100) > 0 => True, False),
    MAP((STRING)L.manipulated_identity_index_ != '0' => True, False),
    MAP((STRING)L.stolen_identity_index_ != '0' => True, False),
    MAP((STRING)L.suspicious_activity_index_ != '0' => True, False),
    MAP((STRING)L.synthetic_identity_index_ != '0' => True, False),
    MAP((STRING)L.vulnerable_victim_index_ != '0' => True, False),
    MAP((STRING)L.friendlyfraud_index_ != '0' => True, False));
  
END;

d1 := NORMALIZE(KELOtto.Q__show_Customer_Person.Res0,16,tCustomerAttributeSummary(LEFT,COUNTER));
output(d1,, '~gov::otto::personstats_pivot', overwrite);

