

import ut, Address, did_Add;

export clean_opt_out_data(string filedate) := function

f := fcra_opt_out.dataset_infile;


fcra_opt_out.layout_infile_appended trecs(f L) := transform
self.date_YYYYMMDD :=  ut.JultoYYYYMMDD(l.julian_date);
self.address1 := L.address;
self.address2 := L.city + ' '+ L.state + ' '+ L.zip5;
self := L;
end;

precs := project(f,trecs(left));

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
