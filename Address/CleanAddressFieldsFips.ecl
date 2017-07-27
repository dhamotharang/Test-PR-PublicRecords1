export CleanAddressFieldsFips(string182 clean_addr) := 
MODULE

	export string10        prim_range		:=  clean_addr[1..10];
	export string2         predir				:= 	clean_addr[11..12];
	export string28        prim_name		:= 	clean_addr[13..40];
	export string4         addr_suffix	:=  clean_addr[41..44];
	export string2         postdir			:= 	clean_addr[45..46];
	export string10        unit_desig		:= 	clean_addr[47..56];
	export string8         sec_range		:= 	clean_addr[57..64];
	export string25        p_city_name	:= 	clean_addr[65..89];
	export string25        v_city_name	:=  clean_addr[90..114];
	export string2         st						:= 	clean_addr[115..116];
	export string5         zip					:= 	clean_addr[117..121];
	export string4         zip4					:= 	clean_addr[122..125];
	export string4         cart					:= 	clean_addr[126..129];
	export string1         cr_sort_sz		:= 	clean_addr[130];
	export string4         lot					:= 	clean_addr[131..134];
	export string1         lot_order		:= 	clean_addr[135];
	export string2         dbpc					:= 	clean_addr[136..137];
	export string1         chk_digit		:= 	clean_addr[138];
	export string2         rec_type			:= 	clean_addr[139..140];
	export string2         fips_state		:= 	clean_addr[141..142];
	export string3         fips_county	:= 	clean_addr[143..145];
	export string10        geo_lat			:= 	clean_addr[146..155];
	export string11        geo_long			:= 	clean_addr[156..166];
	export string4         msa					:= 	clean_addr[167..170];
	export string7         geo_blk			:= 	clean_addr[171..177];
	export string1         geo_match		:= 	clean_addr[178];
	export string4         err_stat			:= 	clean_addr[179..182];
	
	export string75				 addr1				:= 	Address.Addr1FromComponents(prim_range, predir, prim_name,addr_suffix, postdir, unit_desig, sec_range);
	export string35				 addr2 				:=  Address.Addr2FromComponents(v_city_name, st, zip);
	
	export addressrecord := dataset([
	{	 prim_range	
		,predir			
		,prim_name	
		,addr_suffix
		,postdir		
		,unit_desig	
		,sec_range	
		,p_city_name
		,v_city_name
		,st					
		,zip				
		,zip4				
		,cart				
		,cr_sort_sz	
		,lot				
		,lot_order	
		,dbpc				
		,chk_digit	
		,rec_type		
		,fips_state	
		,fips_county
		,geo_lat		
		,geo_long		
		,msa				
		,geo_blk		
		,geo_match	
		,err_stat		
	}

	], Address.Layout_Clean182_fips)[1];

END;