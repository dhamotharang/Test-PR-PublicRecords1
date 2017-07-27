IMPORT SANCTN, Address, lib_stringlib;

export clean_party(string filedate) := function

#uniquename(cluster);

SANCTN_party      := SANCTN.file_in_party;
SANCTN_party_text := SANCTN.file_in_party_varying;

layout_combined := RECORD
   SANCTN.layout_SANCTN_party_in;
   string255 party_text;   
end;

layout_combined  party_combined(SANCTN_party      L
                               ,SANCTN_party_text R) := TRANSFORM
   self.party_text   := R.PARTY_TEXT;
   self.ORDER_NUMBER := R.ORDER_NUMBER;
   self := L;
end;

j_party := JOIN(SANCTN_party
               ,SANCTN_party_text
			   ,left.BATCH_NUMBER    = right.BATCH_NUMBER
			AND left.INCIDENT_NUMBER = right.INCIDENT_NUMBER
			AND left.PARTY_NUMBER    = right.PARTY_NUMBER
			   ,party_combined(left,right)
			   ,LEFT OUTER
			   ,LOCAL);


SANCTN.layout_SANCTN_party_clean clean_SANCTN_party(j_party input) := TRANSFORM
   // Set the local values
   is_company   := SANCTN.fIsCompany(input.PARTY_NAME);
   tempPName    := if(is_company
                     ,''
				     ,Address.CleanPersonLFM73(input.PARTY_NAME));
   CleanPName   := if(NOT(is_company) AND NOT((INTEGER)tempPName[71..73] < 80)
                     ,tempPName
					 ,'');
   CleanCName   := if(is_company OR (INTEGER)tempPName[71..73] < 80
                     ,stringlib.StringToUpperCase(input.PARTY_NAME)
					 ,'');
   CleanAddress := Address.CleanAddress182(input.inADDRESS
                                          ,input.inCITY + ' ' + input.inSTATE + ' ' + input.inZIP);
   
   // Set the person and company name values
   self.title 			:= if(NOT(is_company) AND NOT((INTEGER)tempPName[71..73] < 80),CleanPName[1..5],'');
   self.fname 			:= if(NOT(is_company) AND NOT((INTEGER)tempPName[71..73] < 80),CleanPName[6..25],'');
   self.mname 			:= if(NOT(is_company) AND NOT((INTEGER)tempPName[71..73] < 80),CleanPName[26..45],'');
   self.lname 			:= if(NOT(is_company) AND NOT((INTEGER)tempPName[71..73] < 80),CleanPName[46..65],'');
   self.name_suffix 	:= if(NOT(is_company) AND NOT((INTEGER)tempPName[71..73] < 80),CleanPName[66..70],'');
   self.name_score 		:= if(NOT(is_company) AND NOT((INTEGER)tempPName[71..73] < 80),CleanPName[71..73],''); 
   self.cname           := if(is_company       OR     (INTEGER)tempPName[71..73] < 80 ,CleanCName,'');
   // Set the address values
   self.prim_range 		:= CleanAddress[1..10]; 
   self.predir 			:= CleanAddress[11..12];					   
   self.prim_name 		:= CleanAddress[13..40];
   self.addr_suffix 	:= CleanAddress[41..44];
   self.postdir 		:= CleanAddress[45..46];
   self.unit_desig 	    := CleanAddress[47..56];
   self.sec_range 		:= CleanAddress[57..64];
   self.p_city_name 	:= CleanAddress[65..89];
   self.v_city_name 	:= CleanAddress[90..114];
   self.st 			    := if(CleanAddress[115..116]=''
                             ,ziplib.ZipToState2(CleanAddress[117..121])
							 ,CleanAddress[115..116]);
   self.zip5 			:= CleanAddress[117..121];
   self.zip4 			:= CleanAddress[122..125];
   self.cart 			:= CleanAddress[126..129];
   self.cr_sort_sz 		:= CleanAddress[130];
   self.lot 			:= CleanAddress[131..134];
   self.lot_order 		:= CleanAddress[135];
   self.dpbc 			:= CleanAddress[136..137];
   self.chk_digit 		:= CleanAddress[138];
   self.addr_rec_type 	:= CleanAddress[139..140];
   self.fips_state		:= CleanAddress[141..142];
   self.fips_county     := CleanAddress[143..145];
   self.geo_lat 		:= CleanAddress[146..155];
   self.geo_long 		:= CleanAddress[156..166];
   self.cbsa 			:= CleanAddress[167..170];
   self.geo_blk 		:= CleanAddress[171..177];
   self.geo_match 		:= CleanAddress[178];
   self.err_stat 		:= CleanAddress[179..182];

   self := input;
   
end;

clean_data := sort(PROJECT(j_party, clean_SANCTN_party(LEFT)) ,batch_number,incident_number, party_number, order_number);

output('Party data: ' + count(clean_data));

clean_data_deduped := output(dedup(clean_data,all),,SANCTN.cluster_name +'out::SANCTN::'+filedate+'::party_cleaned');

return sequential(clean_data_deduped);

end;

// EXPORT clean_party := PROJECT(j_party, clean_SANCTN_party(LEFT)) 
                             // : PERSIST(SANCTN.cluster + 'persist::SANCTN::party_clean');