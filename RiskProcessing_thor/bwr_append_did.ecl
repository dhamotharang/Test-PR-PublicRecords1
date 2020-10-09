#workunit('name', 'did_append on Vault');

recLayout := RECORD
    STRING field1;
    STRING field2;
    STRING field3;
    STRING field4;
    STRING field5;
    STRING field6;
    STRING field7;
    STRING field8;
    STRING field9;
    STRING field10;
    STRING field11;
    STRING field12;
    STRING field13;
    STRING field14;
END;
eyeball := 10;  // number of records to look at

// ds := choosen(DATASET('~vault::healthcare::data_pull::pr_nonfcra::senmembers_20200929a', recLayout, csv(HEADING(1))), 100);
ds := DATASET('~vault::healthcare::data_pull::pr_nonfcra::senmembers_20200929a', recLayout, csv(HEADING(1)));
output(choosen(ds, eyeball), named('original_input'));

output(count(ds));


risk_indicators.layout_input cleanup(ds le, integer c) := TRANSFORM
	self.seq :=  c;  // give each record a unique identifier
	
  self.fname := STD.Str.touppercase(le.field2);
	self.lname := STD.Str.touppercase(le.field4);
	self.ssn := '';  // doesn't look like this file has SSN populated
	self.dob := trim(le.field10[1..4] + le.field10[6..7] + le.field10[9..10]); 
	self.phone10 := riskwise.cleanPhone(le.field13);
			
  street_addr := le.field5;
  city := le.field7;
  st := le.field8;
  zip := le.field9;
  
	street_address := risk_indicators.MOD_AddressClean.street_address(street_addr);
	clean_addr := risk_indicators.MOD_AddressClean.clean_addr( street_address, City, St, Zip ) ;											

	SELF.in_streetAddress := street_address;
	SELF.in_city := City;
	SELF.in_state := St;
	SELF.in_zipCode := Zip;
	self.in_country := '';
  self.prim_range   := address.cleanFields(clean_addr).prim_range;
  self.predir 			:= address.cleanFields(clean_addr).predir;
  self.prim_name 		:= address.cleanFields(clean_addr).prim_name;
  self.addr_suffix 	:= address.cleanFields(clean_addr).addr_suffix;
  self.postdir 			:= address.cleanFields(clean_addr).postdir;
  self.unit_desig 	:= address.cleanFields(clean_addr).unit_desig;
  self.sec_range 		:= address.cleanFields(clean_addr).sec_range;
  self.p_city_name 	:= address.cleanFields(clean_addr).v_city_name;  
  self.st 					:= address.cleanFields(clean_addr).st;
  self.z5 					:= address.cleanFields(clean_addr).zip;
  self.zip4 				:= address.cleanFields(clean_addr).zip4;
  self.lat 					:= address.cleanFields(clean_addr).geo_lat;
  self.long 				:= address.cleanFields(clean_addr).geo_long;
  self.addr_type 		:= address.cleanFields(clean_addr).rec_type;
  self.addr_status 	:= address.cleanFields(clean_addr).err_stat;
  self.county 			:= clean_addr[143..145];  
  self.geo_blk 			:= address.cleanFields(clean_addr).geo_blk;
  self.country 			:= '';
	
	self.employer_name := le.field1;  // hang onto this later to pass it through to output in case they need it
  self := [];
END;

indata_clean := PROJECT(ds, cleanup(left, counter));

output(choosen(indata_clean, eyeball), named('indata_clean'));

didprep := PROJECT(indata_clean, TRANSFORM(didville.Layout_Did_OutBatch, SELF := LEFT));
  
matchset_input := ['A','D','S','P','Z'];

did_Add.MAC_Match_Flex(didprep, matchset_input,
                       SSN, DOB, fName, mname, LName, suffix, 
                       prim_range, prim_name, sec_range, z5,
                       st, Phone10,
                       did,
                       didville.Layout_Did_OutBatch,
                       true, score,	//these should default to zero in definition
                       0,	  //dids with a score below here will be dropped 	
                       resu);
output(choosen(resu, eyeball), named('did_appended'));

layout_final := record
  string field1;
  resu;
end;

jfinal := join(indata_clean, resu, left.seq=right.seq, 
  transform(layout_final,
    self.field1 := left.employer_name;
    self := right));

output(choosen(jfinal, eyeball), named('jfinal'));
output(jfinal,, '~dvstemp::out::insurance_file_with_DID_appended_' + thorlib.wuid(), __compressed__);


 
 
 
                         