import SexOffender;

In_Base_file := OKC_Sexual_Offenders.File_OKC_Sex_Offender_DID;

Layout_Base_File := recordof(In_Base_file);

Layout_Searchfile := record
	SexOffender.Layout_Accurint_SearchFile;
	string2 newline := '\r\n';
end;

Layout_Searchfile  trf_OKC_Sex_Off_Searchfile(Layout_Base_File InputRecord) := transform
 	self.fips_st      	:= InputRecord.county[1..2];
	self.fips_county  	:= InputRecord.county[3..5];
	self.ssn          	:= InputRecord.orig_ssn;
	self.dob          	:= InputRecord.date_of_birth;
	self.dob_aka      	:= InputRecord.date_of_birth_aka;
	self.did          	:= InputRecord.did;
	self.did_score    	:= InputRecord.did_score;
	self.dpbc           := InputRecord.dbpc;
	self.cleaning_score := InputRecord.name_score;	
	self.ssn_appended 	:= InputRecord.ssn;
	self              	:= InputRecord;
end;

ds_SearchFile := project(In_Base_file,trf_OKC_Sex_Off_Searchfile(left));

ds_SearchFile_Final := sort(ds_SearchFile, seisint_primary_key, orig_state, name_type, name_orig); 

//output(ds_SearchFile_Final,,'~thor_data400::base::OKC_Sex_Offender_Search_File',overwrite);

//Moxie Layout///////////////////////////////////////////////////////////////////////////////////////
	oldMoxieLayout := RECORD
		 string16 seisint_primary_key;
		 string8 dt_last_reported;
		 string2 vendor_code;
		 string20 source_file;
		 string2 orig_state;
		 string50 name_orig;
		 string1 name_type;
		 string9 ssn;
		 string8 dob;
		 string8 dob_aka;
		 string125 registration_address_1;
		 string45 registration_address_2;
		 string35 registration_address_3;
		 string35 registration_address_4;
		 string35 registration_address_5;
		 string5 title;
		 string20 fname;
		 string20 mname;
		 string20 lname;
		 string5 name_suffix;
		 string3 cleaning_score;
		 string10 prim_range;
		 string2 predir;
		 string28 prim_name;
		 string4 addr_suffix;
		 string2 postdir;
		 string10 unit_desig;
		 string8 sec_range;
		 string25 p_city_name;
		 string25 v_city_name;
		 string2 st;
		 string5 zip;
		 string4 zip4;
		 string4 cart;
		 string1 cr_sort_sz;
		 string4 lot;
		 string1 lot_order;
		 string2 dpbc;
		 string1 chk_digit;
		 string2 rec_type;
		 string2 fips_st;
		 string3 fips_county;
		 string10 geo_lat;
		 string11 geo_long;
		 string4 msa;
		 string7 geo_blk;
		 string1 geo_match;
		 string4 err_stat;
		 string12 did;
		 string3 did_score;
		 string9 ssn_appended;
		 string2 newline;
	 END;
 
	oldMoxieLayout  oldMoxieTran(ds_SearchFile_Final l) := transform
		self := l;
	end;

ds_SearchMoxieFile := project(ds_SearchFile_Final, oldMoxieTran(left));

output(ds_SearchMoxieFile,,'~thor_200::base::OKC_Sex_Offender_Search_File_Moxie',overwrite);

///////////////////////////////////////////////////////////////////////////////////////

export Mapping_OKC_Cleaned_As_SearchFile := output(ds_SearchFile_Final,,'~thor_200::base::OKC_Sex_Offender_Search_File',overwrite);