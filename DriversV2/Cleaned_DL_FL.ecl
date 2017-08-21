import Drivers, Address, ut, lib_stringlib;

export Cleaned_DL_FL(string processDate, string fileDate) := function

	in_file := DriversV2.File_DL_FL_Update(fileDate);
	
    Layout_Fixed := DriversV2.Layouts_DL_FL_In.Layout_FL_With_ProcessDte;

	Layout_Fixed trfFixed(in_file l) := transform
		self.process_date           := processDate;
		self.issuance               := l.blob[1..1];
		self.address_change         := l.blob[2..2];
		self.name_change            := l.blob[3..3];
		self.dob_change             := l.blob[4..4];
		self.sex_change             := l.blob[5..5];
		self.name                   := l.blob[6..57];
		self.addr1                  := l.blob[58..87];
		self.city                   := l.blob[88..107];
		self.st                     := l.blob[108..109];
		self.zip                    := l.blob[110..114];
		self.dob                    := l.blob[115..122];
		self.race                   := l.blob[123..123];
		self.sex_flag               := l.blob[124..124];
		self.lic_type               := l.blob[125..136];
		self.attention_flag         := l.blob[137..150];
		self.dod                    := l.blob[151..158];
		self.restriction            := l.blob[159..163];
		self.exp_date               := l.blob[164..171];
		self.lic_issue_date         := l.blob[172..179];
		self.lic_endorsements       := l.blob[180..184];
		self.dl_number              := l.blob[185..197];
		self.ssn                    := l.blob[198..206];
		self.age                    := l.blob[207..209];
		self.new_dl_number          := l.blob[210..222];
		self.personal_info_flag     := l.blob[223..223];
		self.xxx1                   := l.blob[224..225];
		self.dl_orig_issue_date     := l.blob[226..233];
		self.height                 := l.blob[234..236];
		self.oos_previous_dl_number := l.blob[237..257];
		self.oos_previous_st        := l.blob[258..259];
		self.filler2                := l.blob[260..260];
	end;
	
	in_file_fixed := project(in_file, trfFixed(left));

	layout_out := drivers.Layout_FL_Update;

	layout_out mapClean(in_file_fixed l) := transform
		string73 tempName := stringlib.StringToUpperCase(if(trim(l.name,left,right) <> '',
															Address.CleanPerson73(trim(l.name,left,right)),
															''));
		self.title			      	 := tempName[1..5];
		self.fname			      	 := tempName[6..25];
		self.mname			      	 := tempName[26..45];
		self.lname			      	 := tempName[46..65];
		self.name_suffix	    	 := tempName[66..70];
		self.cleaning_score			 := tempName[71..73];
		self.prim_range    			 := '';
		self.predir 	      		 := '';
		self.prim_name 	  			 := '';
		self.suffix   				 	 := '';
		self.postdir 	    		 	 := '';
		self.unit_desig 	  		 := '';
		self.sec_range 	  			 := '';
		self.p_city_name	  		 := '';
		self.v_city_name	  		 := '';
		self.st 			      	   := '';
		self.zip5		      		   := '';
		self.zip4 		      		 := '';
		self.cart 		      		 := '';
		self.cr_sort_sz 	 		   := '';
		self.lot 		      		   := '';
		self.lot_order 	  			 := '';
		self.dpbc 		      		 := '';
		self.chk_digit 	  			 := '';
		self.rec_type		  		   := '';
		self.ace_fips_st	  		 := '';
		self.county 	  			   := '';
		self.geo_lat 	    		   := '';
		self.geo_long 	    		 := '';
		self.msa 		      		   := '';
		self.geo_blk             := '';
		self.geo_match 	  			 := '';
		self.err_stat 	    		 := '';
		self.addr_fix_flag       := '';
		self.process_date            := lib_stringlib.stringlib.stringfilter(l.process_date,'0123456789');
		self.issuance                := stringlib.StringToUpperCase(trim(l.issuance,left,right));
		self.address_change          := stringlib.StringToUpperCase(trim(l.address_change,left,right));
		self.name_change             := stringlib.StringToUpperCase(trim(l.name_change,left,right));
		self.dob_change              := stringlib.StringToUpperCase(trim(l.dob_change,left,right));
		self.sex_change              := stringlib.StringToUpperCase(trim(l.sex_change,left,right));
		self.name                    := stringlib.StringToUpperCase(trim(l.name,left,right));
		self.addr1                   := stringlib.StringToUpperCase(trim(l.addr1,left,right));
		self.city                    := stringlib.StringToUpperCase(trim(l.city,left,right));
		self.state                   := stringlib.StringToUpperCase(trim(l.st,left,right));
		self.zip	                   := trim(l.zip,left,right);
		self.dob                     := lib_stringlib.stringlib.stringfilter(l.dob,'0123456789');
		self.race                    := stringlib.StringToUpperCase(trim(l.race,left,right));
		self.sex_flag                := stringlib.StringToUpperCase(trim(l.sex_flag,left,right));
		self.license_type            := stringlib.StringToUpperCase(trim(l.lic_type,left,right));
		self.attention_flag          := stringlib.StringToUpperCase(trim(l.attention_flag,left,right));
		self.dod                     := lib_stringlib.stringlib.stringfilter(l.dod,'0123456789');
		self.restrictions            := stringlib.StringToUpperCase(trim(l.restriction,left,right));
		self.orig_expiration_date    := lib_stringlib.stringlib.stringfilter(l.exp_date,'0123456789');
		self.lic_issue_date          := lib_stringlib.stringlib.stringfilter(l.lic_issue_date,'0123456789');
		self.lic_endorsement         := stringlib.StringToUpperCase(trim(l.lic_endorsements,left,right));
		self.dl_number               := stringlib.StringToUpperCase(trim(l.dl_number,left,right));
		self.ssn                     := trim(l.ssn,left,right);
		self.age                     := lib_stringlib.stringlib.stringfilter(l.age,'0123456789');
		self.new_dl_number           := stringlib.StringToUpperCase(trim(l.new_dl_number,left,right));
		self.personal_info_flag      := lib_stringlib.stringlib.stringfilter(l.personal_info_flag,'0123456789');
		self.dl_orig_issue_date      := lib_stringlib.stringlib.stringfilter(l.dl_orig_issue_date,'0123456789');
		self.height                  := lib_stringlib.stringlib.stringfilter(l.height,'0123456789');
		self.oos_previous_dl_number  := stringlib.StringToUpperCase(trim(l.oos_previous_dl_number,left,right));
		self.oos_previous_st         := stringlib.StringToUpperCase(trim(l.oos_previous_st,left,right));
		self                         := l;		
	end;

	Cleaned_FL_File := project(in_file_fixed, mapClean(left));
	
	return Cleaned_FL_File;
end;