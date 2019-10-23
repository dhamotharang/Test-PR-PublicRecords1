import Civ_Court, Address,ut;

export Civ_Court_Cleaner(infile,outfile) := macro

#uniquename(tParty)
#uniquename(preCleanName)
#uniquename(CleanName)
#uniquename(CleanAddress)

Civil_Court.Layout_In_Party %tParty%(infile input) := Transform

				
%preCleanName%		:= StringLib.StringFilter(StringLib.StringToUpperCase(input.entity_1),
					   ' -&\'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); 

%CleanName%			:= if(civ_court.fIsCompany(%preCleanName%)<>true,
						map(input.entity_nm_format_1= 'F' => Address.CleanPersonFMl73(%preCleanName%)
						  ,input.entity_nm_format_1	= 'L' => Address.CleanPersonLFM73(%preCleanName%)
						  ,Address.CleanPerson73(%preCleanName%)),
						  %preCleanName%);

%CleanAddress%		:= if(input.entity_1_address_3+input.entity_1_address_4 = '',
							Address.CleanAddress182(input.entity_1_address_1,input.entity_1_address_2),
						    Address.CleanAddress182(input.entity_1_address_1 + ' ' + input.entity_1_address_2,
													input.entity_1_address_3 + ' ' + input.entity_1_address_4));


self.prim_range1 	:= %CleanAddress%[1..10]; 
self.predir1 		:= %CleanAddress%[11..12];					   
self.prim_name1 	:= %CleanAddress%[13..40];
self.addr_suffix1 	:= %CleanAddress%[41..44];
self.postdir1 		:= %CleanAddress%[45..46];
self.unit_desig1 	:= %CleanAddress%[47..56];
self.sec_range1 	:= %CleanAddress%[57..64];
self.p_city_name1 	:= %CleanAddress%[65..89];
self.v_city_name1 	:= %CleanAddress%[90..114];
self.st1 			:= if(%CleanAddress%[115..116]='',ziplib.ZipToState2(%CleanAddress%[117..121]),
					   %CleanAddress%[115..116]);

self.zip1 			:= %CleanAddress%[117..121];
self.zip41 			:= %CleanAddress%[122..125];
self.cart1 			:= %CleanAddress%[126..129];
self.cr_sort_sz1 	:= %CleanAddress%[130];
self.lot1 			:= %CleanAddress%[131..134];
self.lot_order1 	:= %CleanAddress%[135];
self.dpbc1 			:= %CleanAddress%[136..137];
self.chk_digit1 	:= %CleanAddress%[138];
self.rec_type1 		:= %CleanAddress%[139..140];
self.ace_fips_st1	:= %CleanAddress%[141..142];
self.ace_fips_county1:= %CleanAddress%[143..145];
self.geo_lat1 		:= %CleanAddress%[146..155];
self.geo_long1 		:= %CleanAddress%[156..166];
self.msa1 			:= %CleanAddress%[167..170];
self.geo_blk1 		:= %CleanAddress%[171..177];
self.geo_match1 	:= %CleanAddress%[178];
self.err_stat1 		:= %CleanAddress%[179..182];

self.e1_title1 		:= if(civ_court.fIsCompany(%preCleanName%)<>true,
						%CleanName%[1..5],
						'');
self.e1_fname1 		:= if(civ_court.fIsCompany(%preCleanName%)<>true,
						%CleanName%[6..25],
						'');
self.e1_mname1 		:= if(civ_court.fIsCompany(%preCleanName%)<>true,
						%CleanName%[26..45],
						'');
self.e1_lname1 		:= if(civ_court.fIsCompany(%preCleanName%)<>true,
						%CleanName%[46..65],
						'');
self.e1_suffix1 	:= if(civ_court.fIsCompany(%preCleanName%)<>true,
						%CleanName%[66..70],
						'');
self.e1_pname1_score := if(civ_court.fIsCompany(%preCleanName%)<>true,
						%CleanName%[71..73],
						'');
self.e1_cname1		:= if(civ_court.fIsCompany(%preCleanName%)=true,
						%preCleanName%,
						'');


//self.data_type := '5';
/*
self.address_clean1 := %CleanAddress%[1..64]; 
self.address_clean2 := %CleanAddress%[65..89]+' '+%CleanAddress%[115..116]+' '+%CleanAddress%[117..121];					   
self.p1 			:= %CleanName%[1..70];
*/

self				:= input; 

end;



#uniquename(pParty)
%pParty% := project(infile,%tParty%(left));

outfile := %pParty%;
endmacro;




