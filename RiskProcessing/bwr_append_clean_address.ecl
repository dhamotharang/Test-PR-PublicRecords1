#workunit('name','clean address');
import risk_indicators;

unsigned record_limit :=   10;    //number of records to read from input file; 0 means ALL
eyeball := 10;

//===================  input-output files  ======================
infile_name := '~dvstemp::in::shell_4_0_chase_1139_sample_input';
outfile_name := '~dvstemp::out::chase1139_cleaned_input_' + thorlib.wuid();

//==================  input file layout  ========================
layout_input := RECORD
    STRING Account;
    STRING FirstName;
    STRING MiddleName;
    STRING LastName;
    STRING StreetAddress;
    STRING City;
    STRING State;
    STRING Zip;
    STRING HomePhone;
    STRING SSN;
    STRING DateOfBirth;
    STRING WorkPhone;
    STRING income;  
    string DLNumber;
    string DLState;													
    string BALANCE; 
    string CHARGEOFFD;  
    string FormerName;
    string EMAIL;  
    string employername;
    integer historydateyyyymm;
  END;
	
ds_in := dataset (infile_name, layout_input, csv(quote('"')));

//=================
ds_input := IF (record_limit = 0, ds_in, CHOOSEN (ds_in, record_limit));
OUTPUT (choosen(ds_input,eyeball), NAMED ('input'));

temp_layout := record
	layout_input;
	STRING10 prim_range;
	STRING2  predir;
	STRING28 prim_name;
	STRING4  addr_suffix;
	STRING2  postdir;
	STRING10 unit_desig;
	STRING8  sec_range;
	STRING25 p_city_name;
	STRING2  st;
	STRING5  z5;
	STRING4  zip4;
	STRING10 lat := '';
	STRING11 long := '';
	string3 county := '';
	string7 geo_blk := '';
	STRING1  addr_type;
	STRING4  addr_status;
end;

temp_layout clean_address(layout_input le) := transform
	street_address := risk_indicators.MOD_AddressClean.street_address(le.streetaddress);
	clean_182 := risk_indicators.MOD_AddressClean.clean_addr( street_address, le.city, le.state, le.zip ) ;		
			
	self.prim_range := clean_182[1..10];
	self.predir := clean_182[11..12];
	self.prim_name := clean_182[13..40];
	self.addr_suffix := clean_182[41..44];
	self.postdir := clean_182[45..46];
	self.unit_desig := clean_182[47..56];
	self.sec_range := clean_182[57..64];
	self.p_city_name := clean_182[90..114];
	self.st := clean_182[115..116];
	self.z5 := clean_182[117..121];
	self.zip4 := clean_182[122..125];
	self.lat := clean_182[146..155];
	self.long := clean_182[156..166];
	self.addr_type := risk_indicators.iid_constants.override_addr_type(le.streetaddress, clean_182[139],clean_182[126..129]);
	self.addr_status := clean_182[179..182];
	self.county := clean_182[143..145];
	self.geo_blk := clean_182[171..177];
		
	self := le;	
end;
with_cleaned_address := PROJECT(ds_input, clean_address(LEFT));

output(choosen(with_cleaned_address,eyeball), named('with_cleaned_address'));
output(with_cleaned_address,, outfile_name, CSV(QUOTE('"')));

