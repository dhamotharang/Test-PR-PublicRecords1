import Crim, Address,ut;

export Crim_clean(infile,outfile) := macro

#uniquename(tOffenders)
#uniquename(preCleanName)
#uniquename(CleanName)
#uniquename(CleanAddress)

Crim_Common.Layout_In_Court_Offender %tOffenders%(infile input) := Transform

				
%preCleanName%		:= StringLib.StringFilter(StringLib.StringToUpperCase(input.pty_nm),
					   ' -\'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); 

%CleanName%			:= map(input.pty_nm_fmt= 'F' => Address.CleanPersonFMl73(%preCleanName%)
						  ,input.pty_nm_fmt= 'L' => Address.CleanPersonLFM73(%preCleanName%)
						  ,Address.CleanPerson73(%preCleanName%));

%CleanAddress%		:= if(input.street_address_3+input.street_address_4+input.street_address_5 = '',
							Address.CleanAddress182(input.street_address_1,input.street_address_2),
						    Address.CleanAddress182(input.street_address_1 + ' ' + input.street_address_2,
													input.street_address_3 + ' ' + input.street_address_4+' '+ input.street_address_5));


self.data_type := '2';

self.prim_range 	:= %CleanAddress%[1..10]; 
self.predir 		:= %CleanAddress%[11..12];					   
self.prim_name 		:= %CleanAddress%[13..40];
self.addr_suffix 	:= %CleanAddress%[41..44];
self.postdir 		:= %CleanAddress%[45..46];
self.unit_desig 	:= %CleanAddress%[47..56];
self.sec_range 		:= %CleanAddress%[57..64];
self.p_city_name 	:= %CleanAddress%[65..89];
self.v_city_name 	:= %CleanAddress%[90..114];
self.state 			:= if(%CleanAddress%[115..116]='',ziplib.ZipToState2(%CleanAddress%[117..121]),
					   %CleanAddress%[115..116]);

self.zip5 			:= %CleanAddress%[117..121];
self.zip4 			:= %CleanAddress%[122..125];
self.cart 			:= %CleanAddress%[126..129];
self.cr_sort_sz 	:= %CleanAddress%[130];
self.lot 			:= %CleanAddress%[131..134];
self.lot_order 		:= %CleanAddress%[135];
self.dpbc 			:= %CleanAddress%[136..137];
self.chk_digit 		:= %CleanAddress%[138];
self.rec_type 		:= %CleanAddress%[139..140];
self.ace_fips_st	:= %CleanAddress%[141..142];
self.ace_fips_county:= %CleanAddress%[143..145];
self.geo_lat 		:= %CleanAddress%[146..155];
self.geo_long 		:= %CleanAddress%[156..166];
self.msa 			:= %CleanAddress%[167..170];
self.geo_blk 		:= %CleanAddress%[171..177];
self.geo_match 		:= %CleanAddress%[178];
self.err_stat 		:= %CleanAddress%[179..182];

self.title 			:= %CleanName%[1..5];
self.fname 			:= %CleanName%[6..25];
self.mname 			:= %CleanName%[26..45];
self.lname 			:= %CleanName%[46..65];
self.name_suffix 	:= %CleanName%[66..70];
self.cleaning_score := %CleanName%[71..73];

self				:= input; 

end;



#uniquename(poffenders)
%poffenders% := project(infile,%tOffenders%(left));

outfile := %poffenders%;
endmacro;
