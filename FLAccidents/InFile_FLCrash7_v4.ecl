import Address,lib_stringlib,FLAccidents,standard;

flc7_v2_in := dataset('~thor_data400::sprayed::flcrash7'
						,FLAccidents.Layout_FLCrash7_v4, csv(Heading(1),separator(','),terminator(['\n','\r\n'])));
						
BadNameFilter 	:= '(UNKNOWN|UNK |UK |N/A|TEST )';

flc7_v2_rec := FLAccidents.Layout_FLCrash7_v2;

//Layout to add clean name fields for identifying business vs individual name
Layout_clean_name := RECORD
		FLAccidents.Layout_FLCrash7_v4;
		string FullOwnerName;
		Standard.Name;
		string70  cname;
END;

Layout_clean_name mapClnFields(flc7_v2_in l)	:= TRANSFORM
self.FullOwnerName	:= IF(TRIM(l.prop_business_name,left,right) != '',TRIM(l.prop_business_name,left,right),
													StringLib.StringCleanSpaces(l.prop_owner_firstname+' '+l.prop_owner_middleinitial+' '+l.prop_owner_lastname));
self	:= l;
self	:= [];
END;
 
fClnName	:= project(flc7_v2_in,mapClnFields(LEFT));

//call Macro to differentiate company vs person in FullName field
Address.Mac_Is_Business(fClnName,FullOwnerName,ClnName,name_flag,false,true);

//Map identified name fields fields
Layout_clean_name clnLicense(ClnName l) := transform
		clean_name_U			:= if(l.name_flag = 'U' and TRIM(l.prop_business_name,left,right) = '',Address.CleanPerson73(l.FullOwnerName),'');
		self.title 				:= map( (l.name_flag = 'P' or l.name_flag = 'D')and TRIM(l.prop_business_name,left,right) = '' => l.cln_title,
													l.name_flag = 'U' => clean_name_U[1..5],'');										
		self.fname 				:= map( (l.name_flag = 'P' or l.name_flag = 'D') and TRIM(l.prop_business_name,left,right) = ''=> l.cln_fname,
													l.name_flag = 'U' => clean_name_U[6..25],'');										
		self.mname 				:= map( (l.name_flag = 'P' or l.name_flag = 'D') and TRIM(l.prop_business_name,left,right) = ''=> l.cln_mname,
													l.name_flag = 'U' => clean_name_U[26..45],'');					
		self.lname 				:=  map( (l.name_flag = 'P' or l.name_flag = 'D') and TRIM(l.prop_business_name,left,right) = ''=> l.cln_lname,
														l.name_flag = 'U' => clean_name_U[46..65],'');
		self.name_suffix 	:=  map( (l.name_flag = 'P' or l.name_flag = 'D') and TRIM(l.prop_business_name,left,right) = ''=> l.cln_suffix,
													l.name_flag = 'U' => clean_name_U[66..70],'');
		self.cname	 			:= if(l.name_flag = 'B' or TRIM(l.prop_business_name,left,right) != '',l.FullOwnerName,'');

		self := l;
		self := [];
END;

flc7_v2_clean	:= project(ClnName,clnLicense(left));

flc7_v2_rec flc7_convert_to_old(flc7_v2_clean l) := transform
self.rec_type_7       := '7';

self.prop_owner_name	:=	IF(trim(l.prop_business_name,left,right) = '',l.FullOwnerName,StringLib.StringCleanSpaces(l.prop_business_name));
self.prop_owner_address	:=	trim(l.prop_owner_street,left,right);
self.prop_owner_st_city	:=  trim(l.prop_owner_city,left,right);

//FullOwnerName					:= StringLib.StringCleanSpaces(l.prop_owner_firstname+' '+l.prop_owner_middleinitial+' '+l.prop_owner_lastname);
/*self.prop_owner_name	:=	IF(trim(l.prop_business_name,left,right) = '',l.FullOwnerName,StringLib.StringCleanSpaces(l.prop_business_name));
self.prop_owner_st_city	:=	StringLib.StringCleanSpaces(REGEXREPLACE(BadNameFilter,l.prop_owner_street, '') +' '+ REGEXREPLACE(BadNameFilter,l.prop_owner_city, ''));
tmpclean_address := if(l.prop_owner_street <> '' and StringLib.StringCleanSpaces(regexreplace('0',l.prop_owner_zip,'')) <> '',Address.CleanAddress182(StringLib.StringCleanSpaces(l.prop_owner_street),StringLib.StringCleanSpaces(l.prop_owner_city+ ', '+l.prop_owner_state + '  '+ l.prop_owner_zip)),'');
self.prim_range			     := tmpclean_address[1..10];
self.predir				       := tmpclean_address[11..12];
self.prim_name				   := tmpclean_address[13..40];
self.addr_suffix			   := tmpclean_address[41..44];
self.postdir				     := tmpclean_address[45..46];
self.unit_desig			     := tmpclean_address[47..56];
self.sec_range				   := tmpclean_address[57..64];
self.p_city_name			   := tmpclean_address[65..89];
self.v_city_name			   := tmpclean_address[90..114];
self.st					         := tmpclean_address[115..116];
self.zip					       := tmpclean_address[117..121];
self.zip4					       := tmpclean_address[122..125];
self.cart					       := tmpclean_address[126..129];
self.cr_sort_sz			     := tmpclean_address[130];
self.lot					       := tmpclean_address[131..134];
self.lot_order				   := tmpclean_address[135];
self.dpbc                := tmpclean_address[136..137];
self.chk_digit				   := tmpclean_address[138];
self.rec_type				     := tmpclean_address[139..140];
self.ace_fips_st				 := tmpclean_address[141..142];
self.county              := tmpclean_address[143..145];
self.geo_lat				     := tmpclean_address[146..155];
self.geo_long				     := tmpclean_address[156..166];
self.msa					       := tmpclean_address[167..170];
self.geo_blk				     := tmpclean_address[171..177];
self.geo_match				   := tmpclean_address[178];
self.err_stat				     := tmpclean_address[179..182];*/
self                   :=  l;
self                   := [];
end;

export InFile_FLCrash7_v4 := project(flc7_v2_clean,flc7_convert_to_old(left));
