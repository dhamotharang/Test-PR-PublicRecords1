
// Used to replace spaces in date strings with zeroes so that yob field in autokey files
// gets built correctly, since some dates only contain a yyyy or a yyyymm.
shared fixed_date(string8 dtin) := StringLib.StringFindReplace(dtin, ' ', '0');

// start with the *base::sex_offender::mainpublic (offenders) file.
base_file := Hygenics_SOff.File_Main;

// A record with all the fields needed to build the autokeys
ak_rec := record
    string60  seisint_primary_key;
	unsigned8 did;
	string9	  ssn;
	string30  lname;
	string30  fname;
	string20  mname;
	string8   dob;
    string10  prim_range;
    string28  prim_name;
    string8   sec_range;
    string25  city_name;
    string2   st;
	string2   orig_state_code;
    string5   zip5;
	qstring10 geo_lat;
	qstring11 geo_long;
	qstring1  geo_match;
	unsigned1 zero  := 0;
	string1   blank := '';
end;


// Normalize the first time for different p/v_city_name values
ak_rec norm_cities(base_file l,unsigned1 C):=transform
	// On the second time when the v_city_name is being used, null out the
	// ssn field so that duplicate ssn autokey file records do not get created.
	self.ssn  := if(C=1,
	                // check ssn field first and if empty use the ssn_appended field                ???
	                if(l.ssn<>'',l.ssn,l.ssn_appended),
									'');
	// Put zeroes in mm and/or dd part in dob when it contains spaces (i.e. yyyy or yyymm only)
	self.dob := if(l.dob=' ',l.dob,fixed_date(l.dob)),
	// Blank out city if data value = "N/A"
	self.city_name := if(C=1,
	                     if(l.p_city_name<>'N/A',l.p_city_name,''),
											 if(l.v_city_name<>'N/A',l.v_city_name,''));
	self:= l;
end;

norm_file_cities := normalize(base_file,if(left.p_city_name=left.v_city_name or 
                                           left.v_city_name='',1,2),
                              norm_cities(left,counter));
															
// Remove any duplicate records after the normalize
dedup_file_cities := dedup(sort(norm_file_cities,seisint_primary_key,record),record); 


// Normalize a second time for orig_state_code not = address state
ak_rec state_xform(dedup_file_cities l,unsigned1 C):=transform
	self.prim_range  := if(C=1,l.prim_range,'');
    self.prim_name   := if(C=1,l.prim_name,'');
    self.sec_range   := if(C=1,l.sec_range,'');
    self.city_name   := if(C=1,l.city_name,'');
	self.st          := if(C=1,l.st,l.orig_state_code);
	self.zip5        := if(C=1,l.zip5,'');
	self.geo_lat 	 := if(C=1,l.geo_lat,'');
	self.geo_long 	 := if(C=1,l.geo_long,'');
	self.geo_match 	 := if(C=1,l.geo_match,'');

	// On the second time when orig_state_code is being used, null out the
	// ssn field so that duplicate autokey ssn file records do not get created.
	self.ssn          := if(C=1,l.ssn,'');
	self:= l;
end;

norm_file_states := normalize(dedup_file_cities,if(left.orig_state_code=left.st or
                                                   left.st='',1,2),
                              state_xform(left,counter));

// Remove any duplicate records after the normalize
dedup_file_states := dedup(sort(norm_file_states,seisint_primary_key,record),record); 


export File_Autokey_Main := dedup_file_states;