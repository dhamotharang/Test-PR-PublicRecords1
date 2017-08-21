import demo_data_scrambler,death_master,ut,Address;

// Moxie keys built on UNIX

moxie_plus_layout := record
   string8 filedate;
   string1 rec_type;
   string1 rec_type_orig;
   string9 ssn;
   string20 lname;
   string5 name_suffix;
   string20 fname;
   string20 mname;
   string1 VorP_code;
   string8 dod8;
   string8 dob8;
   string2 st_country_code;
   string5 zip_lastres;
   string5 zip_lastpayment;
   string2 state;
   string3 fipscounty;
   string73 clean_name;
   string16 state_death_id;
   string1 state_death_flag := '';
   string2 crlf;
end;

scramble_ds_main := demo_data_scrambler.scramble_death_masterv2;
                    
moxie_plus_layout proj_rec(scramble_ds_main l) := transform
  self.clean_name := Address.CleanPersonFML73(l.fname + ' ' + l.mname + ' ' + l.lname);
	self := l;
end;

result := project(scramble_ds_main,proj_rec(left));

export bwr_moxie_DM := output(result,,'~thor::out::death_master::moxie',overwrite);