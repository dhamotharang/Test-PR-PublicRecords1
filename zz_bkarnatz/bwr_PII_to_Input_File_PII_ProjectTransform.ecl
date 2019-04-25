

import ut,Scoring_Project_Macros;

lay := RECORD
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
 END;



Heather_572k_input:= dataset(ut.foreign_prod + 'hmccarl::in::rv5t_dev_val_inputs',lay, csv(quote('"'), HEADING(1)));

Heather_315k_input:= dataset(ut.foreign_prod + 'ndobmeier::rv5_inputs::rv5b_dev_val_inputs_0323',lay, csv(quote('"'), HEADING(1)));


new_lay := RECORD
  Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
 END;


new_lay new_trans(lay le, integer c) := transform
  self.accountnumber := c;
  self.firstname := le.firstname;
  self.middlename := le.middlename;
  self.lastname := le.lastname;
  self.streetaddress:= le.streetaddress;
  self.city := le.city;
  self.state := le.state;
  self.zip := le.zip;
  self.homephone := le.homephone;
  self.ssn := le.ssn;
  self.dateofbirth := le.dateofbirth;
  self.workphone := le.workphone;
  self.income := le.income;
  self.dlnumber := le.dlnumber;
  self.dlstate := le.dlstate;
  self.balance := le.balance;
  self.chargeoffd := le.chargeoffd;
  self.formername := le.formername;
  self.email := le.email;
  self.company := le.company;
  self.historydateyyyymm := le.historydateyyyymm;
	Self.PLACEHOLDER_1 := le.accountnumber;
  self := [];
	END;


Proj_572k := PROJECT(Heather_572k_input, new_trans(left, counter));
Proj_315k := PROJECT(Heather_315k_input, new_trans(left, counter));


Out_name_572k := '~scoring_project::in::Heather_RVA_572k';
Out_name_315k := '~scoring_project::in::Heather_RVA_315k';

DS_572K := output(Proj_572k ,,Out_name_572k, thor, overwrite);
DS_315k := output(Proj_315k ,,Out_name_315k, thor, overwrite);
 
Return Sequential(DS_572K,DS_315k);