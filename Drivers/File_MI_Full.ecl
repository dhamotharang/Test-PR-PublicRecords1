import Address, lib_stringlib;

Files_MI_old := dataset(Drivers.Cluster + 'in::drvlic_mi_update',	Layout_MI_Full,thor);

layout_norm := record
	recordof(Files_MI_Old);
	string1 addr_type := '';
end;

layout_norm trfNormAddr(Files_MI_Old l, integer c) := transform
   self.addr_type    := choose(c,'','M');
   self.orig_Street  := choose(c, l.orig_Street, l.orig_MailingStreet);
   self.orig_City    := choose(c, l.orig_City, l.orig_MailingCity);
   self.orig_State   := choose(c, l.orig_State, l.orig_MailingState);
   self.orig_Zip     := choose(c, l.orig_Zip, l.orig_MailingZip);
   self              := l;
end;

norm_file := normalize(Files_MI_Old, 
					   if(trim(left.orig_MailingStreet,left,right) <> trim(left.orig_Street,left,right) and 
						  trim(left.orig_MailingStreet,left,right) <> '',2,1)
					  ,trfNormAddr(left,counter));

Layout_MI_Out := record
  Drivers.Layout_MI_Full;
  string1 addr_type := ''
end;
					  
Layout_MI_Out  trfMailingAddr(norm_file l) := transform
   string182 tempAddress := stringlib.StringToUpperCase(if(trim(l.orig_Street,left,right) <> '' or 
														   trim(l.orig_City,left,right)  <> '' or
														   trim(l.orig_state,left,right) <> '' or
														   trim(l.orig_zip,left,right)   <> '',
														   Address.CleanAddress182(trim(l.orig_Street,left,right),
														          	               trim(trim(l.orig_City,left,right) + ', ' +
																				   trim(l.orig_State,left,right) + ' ' +
																				   lib_stringlib.stringlib.stringfilter(l.orig_Zip,'0123456789'),left,right)),
														   ''));
   self.clean_prim_range		:= tempAddress[1..10];
   self.clean_predir 	        := tempAddress[11..12];
   self.clean_prim_name 	  	:= tempAddress[13..40];
   self.clean_addr_suffix		:= tempAddress[41..44];
   self.clean_postdir 	    	:= tempAddress[45..46];
   self.clean_unit_desig 	    := tempAddress[47..56];
   self.clean_sec_range 	  	:= tempAddress[57..64];
   self.clean_p_city_name	    := tempAddress[65..89];
   self.clean_v_city_name	    := tempAddress[90..114];
   self.clean_st 			    := if(tempAddress[115..116] = '',
   									  ziplib.ZipToState2(tempAddress[117..121]),
														 tempAddress[115..116]);
   self.clean_zip 		      	:= tempAddress[117..121];
   self.clean_zip4 		        := tempAddress[122..125];
   self.clean_cart 		        := tempAddress[126..129];
   self.clean_cr_sort_sz 	 	:= tempAddress[130];
   self.clean_lot 		      	:= tempAddress[131..134];
   self.clean_lot_order 	  	:= tempAddress[135];
   self.clean_dpbc 		        := tempAddress[136..137];
   self.clean_chk_digit 	  	:= tempAddress[138];
   self.clean_record_type  	    := tempAddress[139..140];
   self.clean_ace_fips_st	    := tempAddress[141..142];
   self.clean_fipscounty  		:= tempAddress[143..145];
   self.clean_geo_lat 	    	:= tempAddress[146..155];
   self.clean_geo_long 	        := tempAddress[156..166];
   self.clean_msa 		      	:= tempAddress[167..170];
   self.clean_geo_blk           := tempAddress[171..177];
   self.clean_geo_match 	  	:= tempAddress[178];
   self.clean_err_stat 	        := tempAddress[179..182];
   self                         := l;
end;

clean_mail_addr := project(norm_file(addr_type = 'M'), trfMailingAddr(left));

Layout_MI_Out trfResAddr(norm_file l) := transform
  self := l;
end;

old_res_addr_recs := project(norm_file(trim(addr_type) = ''), trfResAddr(left));


export File_MI_Full	:=	clean_mail_addr + old_res_addr_recs;