import Drivers, Address, ut, lib_stringlib, _Validate;

export Cleaned_DL_TX(string processDate, string fileDate) := function

	in_file := DriversV2.File_DL_TX_Update(fileDate);

	layout_out := DriversV2.Layouts_DL_TX_Update.Layout_DL_TX_Update2;
	
	alpha := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ- ';
	
  RemoveTitle(STRING s) := FUNCTION
	  cln_drv    := IF(stringlib.StringToUpperCase(s[1..10]) = 'PRESIDENT-',
		               StringLib.StringFindReplace(StringLib.StringFindReplace(s,'PRESIDENT-',''),',',' '),
									 IF(stringlib.StringToUpperCase(s[1..10]) = 'FIRST-LADY',stringlib.StringToUpperCase(StringLib.StringFindReplace(s,'FIRST-LADY,','')),stringlib.StringToUpperCase(s)));
    str_len    := LENGTH(cln_drv);
    out_str    := IF(stringlib.StringToUpperCase(s[1..10]) = 'PRESIDENT-' OR stringlib.StringToUpperCase(s[1..10]) = 'FIRST-LADY',
		              (cln_drv[(str_len-4)..] + ', ' + cln_drv[1..(str_len-4)]),cln_drv);
    RETURN TRIM(StringLib.StringToUppercase(out_str), LEFT, RIGHT);
  END;	
	
	layout_out mapClean(in_file l) := transform,
																		skip(l.line[1] = 'H' OR l.line[1] = 'T')  //skip the header and trailer records
	
		string   full_name      := RemoveTitle(l.line[14..138]);

		string73 tempName       := stringlib.StringToUpperCase(if(trim(full_name,left,right) <> '',
															   Address.CleanPersonLFM73(trim(full_name,left,right)),
															   ''));
		
    string182 tempAddress   := stringlib.StringToUpperCase(if(trim(l.line[147..178],left,right) + ' ' + trim(l.line[179..210],left,right) <> '' or 
																 trim(l.line[246..250],left,right)  <> '',
																 Address.CleanAddress182(trim(l.line[147..178],left,right) + ' ' + trim(l.line[179..210],left,right),
																						 trim(l.line[246..250],left,right)),
																 ''));
																 
		self.title                 := tempName[1..5];
		self.fname                 := tempName[6..25];
		self.mname                 := tempName[26..45];
		self.lname                 := tempName[46..65];
		self.suffix	               := ut.fGetSuffix(tempName[66..70]);
		self.name_score            := tempName[71..73];
		self.prim_range            := tempAddress[1..10];
		self.predir 	             := tempAddress[11..12];
		self.prim_name 	           := tempAddress[13..40];
		self.addr_suffix           := tempAddress[41..44];
		self.postdir 	             := tempAddress[45..46];
		self.unit_desig 	         := tempAddress[47..56];
		self.sec_range 	           := tempAddress[57..64];
		self.p_city_name	         := tempAddress[65..89];
		self.v_city_name	         := tempAddress[90..114];
		self.state	               := if(tempAddress[115..116] = '',
										              ziplib.ZipToState2(tempAddress[117..121]),
															   tempAddress[115..116]);
		self.zip5		               := tempAddress[117..121];
		self.zip4 		             := tempAddress[122..125];
		self.cart 		             := tempAddress[126..129];
		self.cr_sort_sz 	         := tempAddress[130];
		self.lot 		               := tempAddress[131..134];
		self.lot_order 	           := tempAddress[135];
		self.dpbc 		             := tempAddress[136..137];
		self.chk_digit 	           := tempAddress[138];
		self.rec_type	             := tempAddress[139..140];
		self.ace_fips_st	         := tempAddress[141..142];
		self.county     	         := tempAddress[143..145];
		self.geo_lat 	             := tempAddress[146..155];
		self.geo_long 	           := tempAddress[156..166];
		self.msa 		               := tempAddress[167..170];
		self.geo_blk               := tempAddress[171..177];
		self.geo_match 	           := tempAddress[178];
		self.err_stat 	           := tempAddress[179..182];			
		self.process_date          := IF(_Validate.Date.fIsValid(processDate),processDate,ut.now());
		self.trans_indicator       := stringlib.StringToUpperCase(trim(l.line[1..1],left,right));
		self.card_type             := stringlib.StringToUpperCase(trim(l.line[2..3],left,right));
		self.dl_number             := stringlib.StringToUpperCase(trim(l.line[4..13],left,right));
		self.last_name             := stringlib.StringToUpperCase(trim(l.line[14..53],left,right));
		self.first_name            := stringlib.StringToUpperCase(trim(l.line[54..93],left,right));
		self.middle_name           := stringlib.StringToUpperCase(trim(l.line[94..133],left,right));
		self.suffix_name           := stringlib.StringToUpperCase(trim(l.line[134..138],left,right));
		self.date_of_birth         := IF(_Validate.Date.fIsValid(l.line[143..146] + l.line[139..142]) AND
	                                  _Validate.Date.fIsValid(l.line[143..146] + l.line[139..142],_Validate.Date.Rules.DateInPast),l.line[139..146],'');
		self.street_addr1          := stringlib.StringToUpperCase(trim(l.line[147..178],left,right));
		self.street_addr2          := stringlib.StringToUpperCase(trim(l.line[179..210],left,right));
		self.city                  := stringlib.StringToUpperCase(trim(l.line[211..243],left,right));
		self.in_state              := stringlib.StringToUpperCase(trim(l.line[244..245],left,right));
		self.zip                   := IF((INTEGER)stringlib.stringfilter(l.line[246..250],'0123456789')<>0,stringlib.stringfilter(l.line[246..250],'0123456789'),''); 
		self.in_zip4               := IF((INTEGER)stringlib.stringfilter(l.line[251..254],'0123456789')<>0,stringlib.stringfilter(l.line[251..254],'0123456789'),''); 
		self.issue_date            := IF(_Validate.Date.fIsValid(l.line[259..262] + l.line[255..258]) AND
	                                  _Validate.Date.fIsValid(l.line[259..262] + l.line[255..258],_Validate.Date.Rules.DateInPast),l.line[255..262],'');
		self                       := l;		
	end;

	Cleaned_TX_File := project(in_file, mapClean(left));
	 
	return Cleaned_TX_File;
end;