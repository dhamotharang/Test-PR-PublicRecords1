EXPORT Production_Proddata_Paro_Check() := functionmacro;

IMPORT ut, Risk_Indicators, riskwise, models, fcra, zz_bbraaten2;

eyeball := 5000; 
_retry 		:= 3;  //***define use 3
_timeout 	:= 120;  //***define use 120
_threads 	:= 1;  //***define use 1 
roxieIP_2 	:= riskwise.shortcuts.prod_batch_neutral ; 
		
IT61_Scores_Paro_msn605_infile  := scoring_project_pip.Input_Sample_Names.IT61_Scores_BATCH_Paro_msn605_rsn804_infile;                       //Added 

layout_prii := RECORD
  unsigned8 date_added;
  string customer;
  string source_info;
  integer1 perm_flag;
  integer3 accountnumber;
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
  string dpm;
  string other2;
  string other3;
  string other4;
 END;
 
dsin := dataset(IT61_Scores_Paro_msn605_infile, layout_prii, thor);

slim := choosen(dsin, eyeball);

//*****************************************************

layout_soap_input := record
		unsigned6	did;
		string first;
		string last;
		unsigned dob;
		string10 phone;
		string10 socs;
		string addr;
		string city;
		string state;
		string zip;
end;

layout_soap_input trans(slim le) := transform
		self.first := le.firstname;
		self.last := le.lastname;
		self.dob := (integer)le.dateofbirth;
		self.phone := le.homephone;
		self.socs := le.ssn;
		self.addr := le.streetaddress;
		self.city := le.city;
		self.state := le.state;
		self.zip := le.zip;
		self := [];
END;

soap_in := project(slim, trans(LEFT));

output(soap_in);

input_rec := record
	risk_indicators.Layouts.layout_input_plus_overrides;
	unsigned glb;
	unsigned dppa;
	string apn;
	unsigned bdid;
	string fein;
end;

Soap_output_prod := soapcall(soap_in, roxieIP_2,
												'riskWise.ProdData', {soap_in}, 
												DATASET(input_rec), 
												RETRY(_retry), TIMEOUT(_timeout),
												XPATH('*/Results/Result/Dataset[@name=\'indata_tomtom\']/Row'),
												PARALLEL(_threads));

Output(Soap_output_prod);


output(Soap_output_prod(geo_blk = ''));

lat_count := count(Soap_output_prod(lat = ''));
long_count := count(Soap_output_prod(long = ''));
geo_blk_count := count(Soap_output_prod(geo_blk = ''));

lat_PCT := (lat_count/eyeball)*100;
long_PCT := (long_count/eyeball)*100;
geo_PCT := (geo_blk_count/eyeball)*100;

flag2 := if(geo_PCT > 19, true, false);

return flag2;

endmacro;
