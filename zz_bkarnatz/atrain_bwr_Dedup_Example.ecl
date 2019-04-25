import risk_indicators, ut, ashirey;

eyeball := 30;


prii_layout := RECORD
  unsigned8 date_added;
  string customer;
  string source_info;
  integer1 perm_flag;
  string accountnumber;
  string firstname;
  string middlename;
  string lastname;
  string streetaddress;
  string city;
  string state;
  string zip;
  string homephone;
  string ssn;
  string dateofbirth;
  string workphone;
  string income;
  string dlnumber;
  string dlstate;
  string balance;
  string chargeoffd;
  string formername;
  string email;
  string company;
  integer8 historydateyyyymm;
  string placeholder_1;
  string placeholder_2;
  string placeholder_3;
  string placeholder_4;
  string placeholder_5;
  string dppa;
  string glb;
  string drm;
  integer8 history_date;
  string other1;
  string other2;
  string other3;
  string other4;
 END;



//basefilename := '~scoringqa::out::fcra::riskview_xml_generic_allflagships_v3_20140729_1';        //New Sample File After 6/25
//testfilename := '~scoringqa::out::fcra::riskview_xml_generic_allflagships_v3_20140730_1';        //RV 3 is "v3"  RV 4 is "v4"

pii_file := ut.foreign_prod + 'scoring_project::in::riskview_xml_generic_version3_20140528';
ds_pii := dataset(pii_file, prii_layout, CSV(HEADING(SINGLE), QUOTE('"')));


FLNameSort := (Sort(ds_pii,lastname,firstname));
RollUpNameSorted :=(dedup(FLNameSort, firstname, lastname, ssn));

Output(Count(ds_pii));
Output(Count(RollUpNameSorted));
