import ut,address,did_add, header;

EXPORT Update_Base (string pVersion, boolean pUseProd = false) := function

input := Files(pVersion,pUseProd).input;

Layouts.base tr1 (input l) := transform

	self.title       := ut.CleanSpacesAndUpper(l.orig_title);
	self.fname       := ut.CleanSpacesAndUpper(l.orig_Fname);
	self.mname       := ut.CleanSpacesAndUpper(l.orig_mname);
	self.lname       := ut.CleanSpacesAndUpper(l.orig_lname);
	self.name_suffix := l.orig_name_suffix;

	addr1:=l.orig_address;
	addr2:=trim(StringLib.StringCleanSpaces(	trim(L.orig_city) + if(L.orig_city <> '',',','')
																+ ' '+ L.orig_st
																+ ' '+ L.orig_Zip
																),left,right);
	Clean_Address := address.CleanAddress182(addr1,addr2);
	STRING5   v_zip       		  := Clean_Address[117..121];
	STRING4   v_zip4      		  := Clean_Address[122..125];
	SELF.prim_range  			  := Clean_Address[ 1..  10];
	SELF.predir      			  := Clean_Address[ 11.. 12];
	SELF.prim_name   			  := Clean_Address[13..40];
	SELF.addr_suffix 			  := Clean_Address[ 41.. 44];
	SELF.postdir     			  := Clean_Address[ 45.. 46];
	SELF.unit_desig  			  := Clean_Address[ 47.. 56];
	SELF.sec_range   			  := Clean_Address[ 57.. 64];
	SELF.p_city_name 			  := Clean_Address[ 65.. 89];
	SELF.v_city_name 			  := Clean_Address[ 90..114];
	SELF.st          			  := Clean_Address[115..116];
	SELF.zip         			  := if(v_zip='00000','',v_zip);
	SELF.zip4       	 		  := if(v_zip4='0000','',v_zip4);
	SELF.cart        			  := Clean_Address[126..129];
	SELF.cr_sort_sz  			  := Clean_Address[130..130];
	SELF.lot         			  := Clean_Address[131..134];
	SELF.lot_order   			  := Clean_Address[135..135];
	SELF.dbpc        			  := Clean_Address[136..137];
	SELF.chk_digit   			  := Clean_Address[138..138];
	SELF.rec_type    			  := Clean_Address[139..140];
	self.fips_state	  	  		  := Clean_Address[141..142];
	self.fips_county 	  	  	  := Clean_Address[143..145];
	SELF.geo_lat     			  := Clean_Address[146..155];
	SELF.geo_long    			  := Clean_Address[156..166];
	SELF.msa         			  := Clean_Address[167..170];
	SELF.geo_blk     			  := Clean_Address[171..177];
	SELF.geo_match   			  := Clean_Address[178..178];
	SELF.err_stat    			  := Clean_Address[179..182];
	self.dt_first_seen            :=(unsigned)l.orig_Customer_Reported_date;
	self.dt_last_seen             :=(unsigned)l.orig_Customer_Reported_date;
	self.dt_vendor_first_reported :=(unsigned)pVersion;
	self.dt_vendor_last_reported  :=(unsigned)pVersion;
	SELF := l;
	SELF := [];
END;

cleanAdd_t := project(input,tr1(left));

//Add to previous base
base_and_update := if(nothor(FileServices.GetSuperFileSubCount(Filenames(pVersion, pUseProd).lBaseTemplate_built)) = 0
											 ,cleanAdd_t
											 ,cleanAdd_t + Files(pVersion, pUseProd).Base_AsSrc.built);
return base_and_update;

End;