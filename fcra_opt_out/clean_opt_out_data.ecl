

import doxie_files, doxie,ut,Address,did_Add,header_slimsort,watchdog,RoxieKeyBuild;

export clean_opt_out_data(string filedate) := function

// converting to YYYYMMMDD format - ut.dob_convert

pos1(string dob) := stringlib.StringFind(dob, '/', 1);
pos2(string dob) := stringlib.StringFind(dob, '/', 2);

integer2 iday(string dob) := (integer2)(dob[pos1(dob) + 1..pos2(dob) - 1]);
integer2 imonth(string dob) := (integer2)(dob[1..pos1(dob) - 1]);
integer2 iyear(string dob, integer2 year_digits) 
	:= (integer2)(dob[pos2(dob) + 1..pos2(dob) + 1 + year_digits]);

string8 convert_date(string dob, integer2 year_digits) := 
	intformat(if(year_digits = 2, iyear(dob, year_digits) + 2000, iyear(dob, year_digits)), 4, 1) + 
	intformat(imonth(dob), 2, 1) +
	intformat(iday(dob), 2, 1);


f := fcra_opt_out.dataset_infile;
al_file := fcra_opt_out.File_Alpharetta_In;

// convert alpharetta file to standard format.
fcra_opt_out.layout_infile_appended tarecs(al_file L) := transform
	self.source_flag := l.source_flag;
	self.inname_first := l.fname;
	self.inname_middle := l.mname;
	self.inname_last := l.lname;
	self.inname_suffix := l.suffix;
	self.address := l.address;
	self.city := l.city;
	self.state := l.state;
	self.zip5 := l.zip;
	self.ssn := l.ssn;
	self.date_YYYYMMDD :=  if(l.date_added <> '',convert_date(l.date_added,2),'');
	self.address1 := L.address;
	self.address2 := L.city + ' '+ L.state + ' '+ L.zip;
	//DF-28591
    self.global_sid:=0;
    self.record_sid := 0;
    self.dt_effective_first := 0;
    self.dt_effective_last := 0;
	self := l;
end;

arecs := project(al_file,tarecs(left));

fcra_opt_out.layout_infile_appended trecs(f L) := transform
	self.date_YYYYMMDD :=  if(l.julian_date <> '',ut.JultoYYYYMMDD(l.julian_date),'');
	self.address1 := L.address;
	self.address2 := L.city + ' '+ L.state + ' '+ L.zip5;
	//DF-28591
    self.global_sid:=0;
    self.record_sid := 0;
    self.dt_effective_first := 0;
    self.dt_effective_last := 0;
	self := L;
end;

erecs := project(f,trecs(left));

precs := arecs + erecs;

Address.MAC_Address_Clean(precs,address1,address2,true,appndAddr);
newfile:= appndAddr;


fcra_opt_out.layout_infile_appended trecs2(newfile input) := transform

self.prim_range 			:= input.clean[1..10]; 
self.predir 				:= input.clean[11..12];					   
self.prim_name 				:= input.clean[13..40];
self.name_suffix 		    := input.clean[41..44];
self.postdir 				:= input.clean[45..46];
self.unit_desig 			:= input.clean[47..56];
self.sec_range 				:= input.clean[57..64];

self.p_city_name 			:= input.clean[65..89];
self.v_city_name 			:= input.clean[90..114];
self.st 					:= if(input.clean[115..116]='',ziplib.ZipToState2(input.clean[117..121]),
								input.clean[115..116]);

self.z5 					:= input.clean[117..121];
self.z4 					:= input.clean[122..125];
self.cart 					:= input.clean[126..129];
self.cr_sort_sz 			:= input.clean[130];
self.lot 					:= input.clean[131..134];
self.lot_order 				:= input.clean[135];
self.dpbc 					:= input.clean[136..137];
self.chk_digit 				:= input.clean[138];
self.rec_type 				:= input.clean[139..140];
self.ace_fips_county	    := input.clean[141..145];
self.geo_lat 				:= input.clean[146..155];
self.geo_long 				:= input.clean[156..166];
self.msa 					:= input.clean[167..170];
self.geo_blk 				:= input.clean[171..177];
self.geo_match 				:= input.clean[178];
self.err_stat 				:= input.clean[179..182];
self := input;
end;

precs2 := project(newfile,trecs2(left));

fcra_opt_out.layout_infile_appended tnames(fcra_opt_out.layout_infile_appended L) := transform

CleanName:= Address.CleanPersonFML73(L.inname_first + ' ' + L.inname_middle + ' ' + L.inname_last);
self.title 			:= CleanName[1..5];
self.fname 			:= CleanName[6..25];
self.mname 			:= CleanName[26..45];
self.lname 			:= CleanName[46..65];
self.name_suffix 	:= CleanName[66..70];
self.name_score     := CleanName[71..73];
self := L;
end;

pnames := project(precs2(inname_last<>'' and inname_first <>''),tnames(left));

lMatchSet := ['S','A'];
did_Add.MAC_Match_Flex
	(pnames , lMatchSet,						
	 ssn, blank2, fname, mname,lname, name_suffix, 
	 prim_range, prim_name, sec_range, z5, st, blank3, 
	 DID,
	 pnames,
	 true, DID_Score,
	 75,						
	 outfile
	)
	
	
did_add.MAC_Add_SSN_By_DID(outfile,did,ssn_append,outssn, true);	

//export clean_opt_out_data := output (outssn,,'~thor_data400::base::fcra::optout',overwrite);
// retval := output (outssn,,'~thor_data400::base::fcra::optout',overwrite);

return outssn;

end;


