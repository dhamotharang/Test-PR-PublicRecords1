pb1i_layout := record
	string30 ACCOUNT := '';
     string30 CMPY := '';
     string30 DBANAME := '';
     string50 CMPYADDR := '';
     string30 CMPYCITY := '';
     string2 CMPYSTATE := '';
     string9 CMPYZIP := '';
     string1 CMPYTYPE := '';
     string9 FEIN := '';
     string10 CMPYPHONE1 := '';
     string10 CMPYPHONE2 := '';
     string10 CMPYPHONE3 := '';
     string50 WEBSITE := '';
     string15 FIRST := '';
     string20 LAST := '';
     string15 AUTHREPTITLE := '';
     string50 ADDR := '';
     string30 CITY := '';
     string2 STATE := '';
     string9 ZIP := '';
     string9 SOCS := '';
     string8 DOB := '';
     string10 HPHONE := '';
     string10 WPHONE := '';
     string20 DRLC := '';
     string2 DRLCSTATE := '';
     string20 EMAIL := '';
	string6 historydateyyyymm := '';
end;

f := dataset('~dvstemp::in::biid_sample', pb1i_layout, csv(quote('"')));
output(f);

// populate the input values to business instant id with the original input values
business_risk.Layout_Input_moxie into_bus_input(f le) := transform
	self.acctno := le.account; 
	
	a1_val := le.cmpyaddr;
	a2_val := Address.Addr2FromComponents(le.cmpycity, le.cmpystate, le.cmpyzip);
	clean_cmpy_addr := if(a1_val<>'' or a2_val<>'',Address.CleanAddress182(a1_val,a2_val),'');
	self.name_company := le.cmpy;
	self.alt_company_name := le.dbaname;
	self.prim_range := clean_cmpy_addr[1..10];
	self.predir := clean_cmpy_addr[11..12];
	self.prim_name := clean_cmpy_addr[13..40];
	self.addr_suffix := clean_cmpy_addr[41..44];
	self.postdir := clean_cmpy_addr[45..46];
	self.unit_desig := clean_cmpy_addr[47..56];
	self.sec_range := clean_cmpy_addr[57..64];
	self.p_city_name := clean_cmpy_addr[90..114];
	self.st := clean_cmpy_addr[115..116];
	self.z5 := clean_cmpy_addr[117..121];
	self.zip4 := clean_cmpy_addr[122..125];
	self.lat := clean_cmpy_addr[146..155];
	self.long := clean_cmpy_addr[156..166];
	self.addr_type := clean_cmpy_addr[139];
	self.addr_status := clean_cmpy_addr[179..182];	
	self.fein		 := le.fein;
	self.phoneno    := le.cmpyphone1;
	self.ip_addr	 := le.website;
	
	a1_val2 := le.addr;
	a2_val2 := Address.Addr2FromComponents(le.city, le.state, le.zip);
	clean_addr := if(a1_val2<>'' or a2_val2<>'',Address.CleanAddress182(a1_val2,a2_val2),'');
	self.name_first := le.first;
	self.name_last  := le.last;
	self.prim_range_2 := clean_addr[1..10];
	self.predir_2 := clean_addr[11..12];
	self.prim_name_2 := clean_addr[13..40];
	self.addr_suffix_2 := clean_addr[41..44];
	self.postdir_2 := clean_addr[45..46];
	self.unit_desig_2 := clean_addr[47..56];
	self.sec_range_2 := clean_addr[57..64];
	self.p_city_name_2 := clean_addr[90..114];
	self.st_2 := clean_addr[115..116];
	self.z5_2 := clean_addr[117..121];
	self.zip4_2 := clean_addr[122..125];
	self.ssn := le.socs;
	self.dob := le.dob;
	self.phone_2 := le.hphone;
	self.dl_number := le.drlc;
	self.dl_state := le.drlcstate;
	self.rep_email	:= le.email;
	
	self := [];
end;

batch_in := project(f,into_bus_input(LEFT));
output(batch_in);

roxieIP := 'certstagingvip.hpcc.risk.regn.net:9876';
#stored('roxie_regression_system','vip');

//roxieIP := 'stcloudroxievip.sc.seisint.com:9876';  //St. Cloud Roxie
	
RiskProcessing.MAC_BIID_Batch(batch_in, results, 1, 1, false, roxieIP);
output(results,,'~dvstemp::out::biid_sample_output', overwrite);


//  ***********************************************************************************************
//  to-despray the file after it has been run on hthor, you need to run the following code to 
//  output that file with a cluster, use either the 50x or the 400x to run the code below.
//  ***********************************************************************************************

/*
d := dataset('~dvstemp::out::biid_sample_output', business_risk.Layout_Final_Batch, flat);
output(d,, '~thor_data50::out::biid_sample_output', overwrite);
*/