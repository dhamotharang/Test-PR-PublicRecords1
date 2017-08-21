export layout_airmen_certificate := module

export v1 := record //pre 20120722
	string8 date_first_seen;
	string8 date_last_seen;
	string1 current_flag;
	string1 letter;
	string7 unique_id;
	string2 rec_type;
	string1 cer_type;
	string1 cer_level;
	string8 cer_exp_date;
	string99 ratings;
	string79 filler;
	string2 lfcr;
end;

export v2 := record
	string8 date_first_seen;
	string8 date_last_seen;
	string1 current_flag;
	string1 letter;
	string7 unique_id;
	string2 rec_type;
	string1 cer_type;
	string1 cer_level;
	string8 cer_exp_date;
	string110 ratings;
	string99 filler;  //type ratings for pilots.txt and blank for non pilot.txt 
	string2 lfcr;
end;
end; 
