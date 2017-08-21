import ut, AID, NID, lib_stringlib,address;

file_TFD_in := FraudPoint3.file.in_20141029;

//standard name and address

FraudPoint3.layout.preclean_TFD tclean_TFD(file_TFD_in le) := transform

self.name_clean := stringlib.stringcleanspaces(trim(le.first_name,left,right) + ' ' + trim(le.middle_name,left,right) +' ' + trim(le.last_name,left,right)); 
									 
self.date_application := fraudpoint3.fncleanfunctions.clean_date(le.date_application);
self.Date_Fraud_Detected := fraudpoint3.fncleanfunctions.clean_date(le.Date_Fraud_Detected);

self.address1 := trim(le.street_ADDRESS,left,right);
self.address2 := trim(trim(le.City,left,right) + if(le.City <> '', ', ', ' ') +
									 trim(le.STATE,left,right) + ' ' +
									if(length(le.ZIP_CODE) = 4, '0'+le.ZIP_CODE,le.ZIP_CODE), left,right);
self.appended_lexid := 0;
self := le;
self := [];

end;

preclean_TFD := project(file_TFD_in, tclean_TFD(left));

NID.Mac_CleanFullNames(preclean_TFD, name_out, name_clean, includeInRepository:=true,normalizeDualNames:=true);

append_nameid := name_out ;

//clean address

FraudPoint3.layout.base tclean_TFD_addr(append_nameid le) := transform

string182 clean_address := Address.CleanAddress182(le.address1, le.address2);		

self.title 			:= le.cln_title;
self.fname 			:= le.cln_fname;
self.mname 			:= le.cln_mname;
self.lname 			:= le.cln_lname;
self.name_suffix 	:= le.cln_suffix;
//append person clean address
self.prim_range    := clean_address[1..10];
self.predir        := clean_address[11..12]	;
self.prim_name     := clean_address[13..40];
self.addr_suffix     := clean_address[41..44];
self.postdir        := clean_address[45..46];
self.unit_desig	   :=	clean_address[47..56];
self.sec_range     := clean_address[57..64];
self.p_city_name    := clean_address[65..89];
self.v_city_name     := clean_address[90..114];
self.st            := clean_address[115..116];
self.zip           := clean_address[117..121]; 	
self.zip4          := clean_address[122..125];	
self.cart		   :=	clean_address[126..129];
self.cr_sort_sz	   :=	clean_address[130];
self.lot		   :=	clean_address[131..134];
self.lot_order		:=	clean_address[135];
self.dbpc		    :=	clean_address[136..137];
self.chk_digit		:=	clean_address[138];
self.rec_type	    :=	clean_address[139..140]	;
self.fips_state := clean_address[141..142];
self.fips_county		:=   clean_address[143..145];
self.geo_lat		:=	clean_address[146..155];
self.geo_long		:=	clean_address[156..166];
self.msa			:=	clean_address[167..170];
self.geo_blk		:=	clean_address[171..177];
self.geo_match		:=	clean_address[178];
self.err_stat		:=	clean_address[179..182]	;																						   
self := le;

end;

TFD_clean_address := PROJECT(append_nameid, tclean_TFD_addr(left));

TFD_deduped := dedup(TFD_clean_address, all);

export clean_TFD := TFD_deduped;

