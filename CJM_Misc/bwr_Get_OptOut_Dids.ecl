#stored('roxie_regression_system','bat');

import didville, ut, header_slimsort, did_add, doxie, watchdog, patriot;

//leMailTarget := 'avenkatachalam@seisint.com,kgummadi@seisint.com;cbrodeur@seisint.com,jlezcano@seisint.com';

myrec1 := record
   string19 Lname;
   string16 FName;
   string12 Mname;
   string8 dob1;
   string55 Address;
   string20 Address_Number;
   string45 Address_streetname;
   string22 W2_City;
   string2 W2_St;
   string9 W2_zip;
   string52 Business_Address_Line_1;
   string6 Number3;
   string24 Streetname3;
   string48 Business_Address_Line_2;
   string22 City;
   string2 State;
   string9 zip;
   string8 DOB;
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

df1 := dataset('~thor_data400::in::federal_judges_jh',myrec1,flat);

myrec2 := record
   string9 Lname;
   string10 FName;
   string9 Mname;
   string8 DATE;
   string30 Address;
   string10 Address_Number;
   string20 Address_Streetname;
   string15 W2_Address_Line_2_City;
   string2 W2_Address_Line_2_St;
   string5 ZIP;
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

df2 := dataset('~thor_data400::in::federal_judges_jl',myrec2,flat);

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

df3 := dataset('~thor_data400::base::optout_name_removal',myrec3,flat);

slim_ssnrec := record
	string12 ssn;
end;

didville.Layout_Did_InBatch into_dib1(df1 L, integer C) := transform
	self.seq := C * 3;
	self.prim_range := L.prim_range;
	self.predir := L.predir;
	self.prim_name := L.prim_name;
	self.addr_suffix := L.suffix;
	self.postdir := L.postdir;
	self.unit_desig := L.unit_desig;
	self.sec_range := L.sec_range;
	self.p_city_name := L.p_city_name;
	self.st := L.st;
	self.z5 := L.z5;
	self.zip4 := L.zip4;
	self.dob := if (L.dob = '', L.dob1, L.dob);
	self.phone10 := '';
	self.ssn := '';
	self.fname := L.name_first;
	self.mname := L.name_middle;
	self.lname := l.name_last;
	self.suffix := L.name_suffix;
	self.title := '';
end;

mid1 := project(df1,into_dib1(LEFT, COUNTER));

didville.layout_did_inbatch into_dib2(df2 L, integer C) := transform
	self.seq := C * 3 + 1;
	self.fname := L.name_first;
	self.mname := L.name_middle;
	self.lname := L.name_last;
	self.suffix := L.name_suffix;
	self.addr_suffix := L.suffix;
	self := l;
	self.ssn := '';
	self.dob := '';
	self.phone10 := '';
	self.title := '';
end;

mid2 := project(df2,into_dib2(LEFT,COUNTER));

didville.Layout_Did_InBatch into_dib3(df3 L, integer C) := transform
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

mid3 := project(df3,into_dib3(LEFT,COUNTER));

//Filter for populated SSN
df3_ssn_pop := dedup(sort(df3(ssn <> ''),ssn),ssn,all);

slim_ssnrec ssn_df3(df3_ssn_pop L) := transform
	self.ssn := L.ssn;
end;

mid4 := project(df3_ssn_pop,ssn_df3(LEFT));

dfready := mid1 + mid2 + mid3;

did_add.Mac_Match_Fast_Roxie(dfready,res, '','','ALL',true,false);
/*
L_temp := record
	DidVille.Layout_Did_OutBatch;
	String9   best_ssn:='';
End;*/

// New_Res := project(Res,transform(L_temp, self:=left));

did_add.MAC_Add_SSN_By_DID(Res, did, best_ssn, res2)

didrec := record
	string12	did;
end;

outfddp := dedup(sort(res2(did != 0),did),did);

didrec into_didrec(outfddp L) := transform
	self.did := intformat(L.did,12,1);
end;

outfinal_did := project(outfddp,into_didrec(LEFT));

outfile_did_ssn := output(outfinal_did + mid4,,'~thor_data400::out::OptOutDids_' + thorlib.wuid());

//ssnrec := record
//	string9 best_ssn;
//end;

//outfssn := dedup(sort(res2(best_ssn != ''),best_ssn),best_ssn);

//outfinal_ssn := project(outfssn,transform(ssnrec, self := LEFT));

//outfile_ssn := output(outfinal_ssn,,'~thor_data400::out::OptOutSSNs_' + thorlib.wuid(),csv);


clear_did := fileservices.clearsuperfile('~thor_data400::out::ln_optout_did');
add_did   := fileServices.AddSuperFile  ('~thor_data400::out::ln_optout_did','~thor_data400::out::OptOutDids_'+ thorlib.wuid());

 //fSendMail(string pSubject, string pBody)
 // := fileservices.sendemail(leMailTarget,pSubject,pBody);

 //send_mail := fSendMail('Opt Out DID updates','New optout dids:  http://10.150.28.12:8010/WsWorkunits/WUInfo?Wuid=' + workunit + '\r\n');

// export bwr_Get_OptOut_Dids := sequential(outfile,send_mail);

export bwr_Get_OptOut_Dids := sequential(outfile_did_ssn, /*outfile_ssn,*/ clear_did, add_did);


