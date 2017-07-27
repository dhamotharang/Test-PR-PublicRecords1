import ut,eq_hist;

export file_header_in(boolean pFastHeader=false) := module

shared rec := record
 ebcdic string15 first_name;
 ebcdic string15 middle_initial;
 ebcdic string25 last_name;
 ebcdic string2  suffix;
 ebcdic string15 former_first_name;
 ebcdic string15 former_middle_initial;
 ebcdic string25 former_last_name;
 ebcdic string2  former_suffix;
 ebcdic string15 former_first_name2;
 ebcdic string15 former_middle_initial2;
 ebcdic string25 former_last_name2;
 ebcdic string2  former_suffix2;
 ebcdic string15 aka_first_name;
 ebcdic string15 aka_middle_initial;
 ebcdic string25 aka_last_name;
 ebcdic string2  aka_suffix;
 ebcdic string57 current_address;
 ebcdic string20 current_city;
 ebcdic string2  current_state;
 ebcdic string5  current_zip;
 ebcdic string6  current_address_date_reported;
 ebcdic string57 former1_address;
 ebcdic string20 former1_city;
 ebcdic string2  former1_state;
 ebcdic string5  former1_zip;
 ebcdic string6  former1_address_date_reported;
 ebcdic string57 former2_address;
 ebcdic string20 former2_city;
 ebcdic string2  former2_state;
 ebcdic string5  former2_zip;
 ebcdic string6  former2_address_date_reported;
 ebcdic string6  blank1;
 ebcdic string9  ssn;
 ebcdic string9  cid;
 ebcdic string1  ssn_confirmed;
 ebcdic string1  blank2;
 ebcdic string43 blank3;
end;

//same layout in header.file_header_in_weekly
shared rec_weekly := record
        string8  eq_as_of_dt;
 ebcdic string15 first_name;
 ebcdic string15 middle_initial;
 ebcdic string25 last_name;
 ebcdic string2  suffix;
 ebcdic string15 former_first_name;
 ebcdic string15 former_middle_initial;
 ebcdic string25 former_last_name;
 ebcdic string2  former_suffix;
 ebcdic string15 former_first_name2;
 ebcdic string15 former_middle_initial2;
 ebcdic string25 former_last_name2;
 ebcdic string2  former_suffix2;
 ebcdic string15 aka_first_name;     //Per vendor, this will hold newest former name
 ebcdic string15 aka_middle_initial; //Per vendor, this will hold newest former name
 ebcdic string25 aka_last_name;      //Per vendor, this will hold newest former name
 ebcdic string2  aka_suffix;         //Per vendor, this will hold newest former name
 ebcdic string57 current_address;
 ebcdic string20 current_city;
 ebcdic string2  current_state;
 ebcdic string5  current_zip;
 ebcdic string6  current_address_date_reported;
 ebcdic string57 former1_address;
 ebcdic string20 former1_city;
 ebcdic string2  former1_state;
 ebcdic string5  former1_zip;
 ebcdic string6  former1_address_date_reported;
 ebcdic string57 former2_address;
 ebcdic string20 former2_city;
 ebcdic string2  former2_state;
 ebcdic string5  former2_zip;
 ebcdic string6  former2_address_date_reported;
 ebcdic string6  blank1;
 ebcdic string9  ssn;
 ebcdic string9  cid;
 ebcdic string1  ssn_confirmed;
 ebcdic string1  filler1;
 ebcdic string1  name_change;
 ebcdic string1  addr_change;
 ebcdic string1  ssn_change;
 ebcdic string1  former_name_change;
 ebcdic string1  new_rec;
 ebcdic string38 filler2;
end;
 
shared monthly_file :=	dataset('~thor_data400::in::hdr_raw',rec,flat) +
                        dataset('~thor_data400::in::hdr_supplement2',rec,flat);
shared weekly_file  := dataset('~thor400_84::in::eq_weekly_with_as_of_date',rec_weekly,flat);

//all this is in the attempt to avoid the monthly data from re-cleaning/DID'ing (header.preprocess)
//when the addition of a new weekly file would trigger the UID to re-sequence

shared monthly_file1 := project(monthly_file,transform(header.layout_eq_src,self:=left,self:=[]));

//EQ and EH (EQ history restored) are concatenated in EQ source key but if both sources are sequenced independent of one another,
//two entities will endup with the same uid causing queries to randomly display the wrong one - bug 80773
shared seed:=if(pFastHeader,999999999999,1);
header.Mac_Set_Header_Source(monthly_file1,header.layout_eq_src,header.layout_header_in,'EQ',withUID,seed);

export eq_uid_monthly := withUID : persist('persist::headerbuild_eq_src');

//counter is safe provided that that the monthly file has less than 100B records
//UID's still need to be unique across the monthly & weekly data in the event
//weekly data is ever introduced into the full header

//putting this date here means that the 
//Header EQ Src key would need to change
//if the Weekly data were ever added

fn_convert_to_days(integer pInput) := 
	 (((integer)(pInput[1..4])*365)
	+ ((integer)(pInput[5..6])* 12)
	+ ((integer)(pInput[7..8])    )
	 );
	 
r_layout_header_in_with_as_of_dt := record
 string8 eq_as_of_dt;
 integer eq_as_of_dt_in_days;
 integer today_in_days;
 boolean within_range;
 header.layout_header_in;
end;

r_layout_header_in_with_as_of_dt t_map_weekly(weekly_file le, integer c) := transform
 self.eq_as_of_dt         := le.eq_as_of_dt;
 self.eq_as_of_dt_in_days := fn_convert_to_days((integer)le.eq_as_of_dt);
 self.today_in_days       := fn_convert_to_days((integer)ut.getdate);
 self.within_range        := ut.DaysApart(ut.getdate,le.eq_as_of_dt)	<= header.sourcedata_month.v_nbr_of_days_to_keep;
 self.src                 := 'WH';
 self.uid                 := c + seed + 100000000000;
 self                     := le;
 self                     := [];
end;

export eq_uid_weekly  := project(weekly_file,t_map_weekly(left,counter))(within_range=true);

end;