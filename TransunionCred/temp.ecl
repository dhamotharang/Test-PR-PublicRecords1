import address;
export temp(dataset(Layouts.base) d)  := function

invalid_prim_name := ['NONE','UNKNOWN','UNKNWN','UNKNOWEN','UNKNONW','UNKNON','UNKNWON','UNKONWN','UNEKNOWN','UN KNOWN','GENERAL DELIVERY'];

Layouts.base tr (d l) := transform
	Clean_Address := address.CleanAddress182(l.Prepped_addr1,l.Prepped_addr2);
	STRING28  v_prim_name 		:= Clean_Address[13..40];
	STRING5   v_zip       		:= Clean_Address[117..121];
	STRING4   v_zip4      		:= Clean_Address[122..125];
	SELF.prim_range  			:= Clean_Address[ 1..  10];
	SELF.predir      			:= Clean_Address[ 11.. 12];
	SELF.prim_name   			:= if(trim(v_prim_name) in invalid_prim_name,'',v_prim_name);
	SELF.addr_suffix 			:= Clean_Address[ 41.. 44];
	SELF.postdir     			:= Clean_Address[ 45.. 46];
	SELF.unit_desig  			:= Clean_Address[ 47.. 56];
	SELF.sec_range   			:= Clean_Address[ 57.. 64];
	SELF.p_city_name 			:= Clean_Address[ 65.. 89];
	SELF.v_city_name 			:= Clean_Address[ 90..114];
	SELF.st          			:= Clean_Address[115..116];
	SELF.zip         			:= if(v_zip='00000','',v_zip);
	SELF.zip4       	 		:= if(v_zip4='0000','',v_zip4);
	SELF.cart        			:= Clean_Address[126..129];
	SELF.cr_sort_sz  			:= Clean_Address[130..130];
	SELF.lot         			:= Clean_Address[131..134];
	SELF.lot_order   			:= Clean_Address[135..135];
	SELF.dbpc        			:= Clean_Address[136..137];
	SELF.chk_digit   			:= Clean_Address[138..138];
	SELF.rec_type    			:= Clean_Address[139..140];
	SELF.county      			:= Clean_Address[141..145];
	SELF.geo_lat     			:= Clean_Address[146..155];
	SELF.geo_long    			:= Clean_Address[156..166];
	SELF.msa         			:= Clean_Address[167..170];
	SELF.geo_blk     			:= Clean_Address[171..177];
	SELF.geo_match   			:= Clean_Address[178..178];
	SELF.err_stat    			:= Clean_Address[179..182];
	SELF := l;
END;

return project(d,tr(left));

end;


