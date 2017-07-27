EXPORT CleanAddressEnclarityFields (string1079 clean_addr) := 
MODULE

	export string10        prim_range						:=  clean_addr[1..10];
	export string2         predir								:= 	clean_addr[11..12];
	export string28        prim_name						:= 	clean_addr[13..40];
	export string4         addr_suffix					:=  clean_addr[41..44];
	export string2         postdir							:= 	clean_addr[45..46];
	export string10        unit_desig						:= 	clean_addr[47..56];
	export string8         sec_range						:= 	clean_addr[57..64];
	export string25        p_city_name					:= 	clean_addr[65..89];
	export string25        v_city_name					:=  clean_addr[90..114];
	export string2         st										:= 	clean_addr[115..116];
	export string5         zip									:= 	clean_addr[117..121];
	export string4         zip4									:= 	clean_addr[122..125];
	export string4         cart									:= 	clean_addr[126..129];
	export string1         cr_sort_sz						:= 	clean_addr[130];
	export string4         lot									:= 	clean_addr[131..134];
	export string1         lot_order						:= 	clean_addr[135];
	export string2         dbpc									:= 	clean_addr[136..137];
	export string1         chk_digit						:= 	clean_addr[138];
	export string2         rec_type							:= 	clean_addr[139..140];
	export string2         fips_state						:= 	clean_addr[141..142];
	export string3         fips_county					:= 	clean_addr[143..145];
	export string9 				 rural_route_nbr 			:= clean_addr[146..154];
	export string9 				 po_box_nbr		 				:= clean_addr[155..163];
	export string50 			 sec_addr		 					:= clean_addr[164..213];
	export string1 			 	 rdi									:= clean_addr[214];
	export string64 			 addr1_remainder			:= clean_addr[215..278];
	export string64 			 addr1_extra1 				:= clean_addr[279..342];
	export string64 			 addr1_extra2 				:= clean_addr[343..406];
	export string64 			 addr1_extra3 				:= clean_addr[407..470];
	export string64 			 addr1_extra4 				:= clean_addr[471..534];
	export string64 			 addr1_extra5 				:= clean_addr[535..598];
	export string64 			 addr1_extra6 				:= clean_addr[599..662];
	export string64 			 addr1_extra7 				:= clean_addr[663..726];
	export string64 			 addr1_extra8 				:= clean_addr[727..790];
	export string64 			 addr1_extra9 				:= clean_addr[791..854];
	export string64 			 addr1_extra10				:= clean_addr[855..918];
	export string64 			 addr2_line						:= clean_addr[919..982];
	export string10 			 addr2_unit_nbr				:= clean_addr[983..992];
	export string10 			 addr2_non_postal			:= clean_addr[993..1002];
	export string10 			 postal_type					:= clean_addr[1003..1012];
	export string10 			 non_postal_unit			:= clean_addr[1013..1022];
	export string10 			 non_postal_unit_nbr	:= clean_addr[1023..1032];
	export string10 			 rural_box_nbr				:= clean_addr[1033..1042];
	export string10        geo_lat							:= 	clean_addr[1043..1052];
	export string11        geo_long							:= 	clean_addr[1053..1063];
	export string4         msa									:= 	clean_addr[1064..1067];
	export string7         geo_blk							:= 	clean_addr[1068..1074];
	export string1         geo_match						:= 	clean_addr[1075];
	export string4         err_stat							:= 	clean_addr[1076..1079];
	
	export string75				 addr1								:= 	Address.Addr1FromComponents(prim_range, predir, prim_name,addr_suffix, postdir, unit_desig, sec_range);
	export string35				 addr2 								:=  Address.Addr2FromComponents(v_city_name, st, zip);
	
	export CleanAddressRecord := dataset([
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
		,rural_route_nbr
		,po_box_nbr 
		,sec_addr 
		,rdi 
		,addr1_remainder
		,addr1_extra1 
		,addr1_extra2 
		,addr1_extra3 
		,addr1_extra4 
		,addr1_extra5 
		,addr1_extra6 
		,addr1_extra7 
		,addr1_extra8 
		,addr1_extra9 
		,addr1_extra10
		,addr2_line
		,addr2_unit_nbr
		,addr2_non_postal
		,postal_type
		,non_postal_unit
		,non_postal_unit_nbr
		,rural_box_nbr
		,geo_lat
		,geo_long
		,msa
		,geo_blk
		,geo_match
		,err_stat
	}

	], Address.Layout_Clean_Addr_Enclarity)[1];

END;