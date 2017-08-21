#stored('roxie_regression_system','bat');

import didville, ut, header_slimsort, did_add, doxie, watchdog, patriot;


myrec3 := record
   string8 Date_Received;
   //string8 Date_to_DDP;
   string18 First_Name;
   string11 Middle_Name;
   string19 Last_Name;
   string38 Address;
   string9 HouseNumber;
   string28 Street_Name;
   string25 City;
   string3 STate;
   string6 Zip;
   /*string34 Suppression_Reason;
   string3 Information_Complete;
   string18 Information_Needed;
   string10 Special_Libraries;*/
	 string9 ssn;
   string5 name_prefix;
   string20 name_first;
   string20 name_middle;
   string20 name_last;
   string5 name_suffix;
   string3 name_score;
   string10 prim_range;
   string2 predir;
   string28 prim_name;
   string4 suffix;
   string2 postdir;
   string10 unit_desig;
   string8 sec_range;
   string25 p_city_name;
   string25 v_city_name;
   string2 st;
   string5 z5;
   string4 zip4;
   string4 cart;
   string1 cr_sort_sz;
   string4 lot;
   string1 lot_order;
   string2 dpbc;
   string1 chk_digit;
   string2 rec_type;
   string2 ace_fips_st;
   string3 county;
   string10 geo_lat;
   string11 geo_long;
   string4 msa;
   string7 geo_blk;
   string1 geo_match;
   string4 err_stat;
   string1 lf;
end;



df4 := dataset('~thor_data400::base::optout_name_removal_consumer',myrec3,flat);



didville.Layout_Did_InBatch into_dib4(df4 L, integer C) := transform
	self.seq := C * 3 + 2;
	self.fname := L.name_first;
	self.mname := L.name_middle;
	self.lname := L.name_last;
	self.suffix := L.name_suffix;
	self.addr_suffix := L.suffix;
	self := L;
	self.dob := '';
	self.phone10 := '';
	self.title := '';
end;



mid3 := project(df4,into_dib4(LEFT,COUNTER));

did_add.Mac_Match_Fast_Roxie(mid3,res, '','','ALL',true,false);


sequential(Fileservices.Clearsuperfile('~thor_data400::consumer_optout_dids'),output(res,,'~thor_data400::consumer_opt_out_dids ' + thorlib.wuid(),named('Consumer_Opt_Out_records_with_assigned_did'), overwrite),Fileservices.addsuperfile('~thor_data400::consumer_optout_dids', '~thor_data400::consumer_opt_out_dids ' + thorlib.wuid()));