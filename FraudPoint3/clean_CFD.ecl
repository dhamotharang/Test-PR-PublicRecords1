import ut, AID, NID, lib_stringlib,address;
#OPTION('multiplePersistInstances',FALSE);

file_CFD_in := dedup(FraudPoint3.file.in_20131001 + FraudPoint3.file.in_20131101, all);

//standard name and address

FraudPoint3.layout.preclean_CFD tclean_CFD(file_CFD_in le) := transform

self.name_clean := stringlib.stringcleanspaces(trim(le.first_name,left,right) + ' ' + trim(le.mid_name,left,right) +' ' + trim(le.last_name,left,right)); 
									 
self.DOB := le.DOB[7..10] + le.DOB[1..2] + le.DOB[4..5];
self.app_date := le.app_date[7..10] + le.app_date[1..2] + le.app_date[4..5];
self.email := lib_stringlib.stringlib.StringToUpperCase(le.email);
self.address1 := trim(le.ADDRESS1,left,right);
self.address2 := trim(trim(le.City,left,right) + if(le.City <> '', ', ', ' ') +
									 trim(le.STATE,left,right) + ' ' +
									if(length(le.ZIPCODE) = 4, '0'+le.ZIPCODE,le.ZIPCODE), left,right);

self := le;
self := [];

end;

preclean_CFD := project(file_CFD_in, tclean_CFD(left));

NID.Mac_CleanFullNames(preclean_CFD, name_out, name_clean, includeInRepository:=true,normalizeDualNames:=true);

append_nameid := name_out ;

//clean address

FraudPoint3.layout.preclean_CFD tclean_CFD_addr(append_nameid le) := transform

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

CFD_clean_address := PROJECT(append_nameid, tclean_CFD_addr(left));

//if only one phone populated or no phone number 

CFD_has_one_phone := CFD_clean_address(~(home_phone <> '' and cell_phone <> ''));

FraudPoint3.layout.base tmapping_common(CFD_has_one_phone le) := transform

self.customer_ID := le.CUST_ID_NUM;
self.vendor_ID := '18393';
self.Date_Fraud_Reported_LN := '';            
self.middle_name  := le.MID_name;
self.street_address := le.address1;
self.zip_code := le.zipcode;
self.Phone_Number := if(le.home_phone <> '',le.home_phone, le.cell_phone);
self.Email_Address := le.EMAIL;
self.Income := le.net_income;
self.Own_or_Rent := le.own_rent_other;
//self.Location_Identifier;
//self.Other_Application_Identifier;
//self.Other_Application_Identifier2;
//self.Other_Application_Identifier3;
self.Date_Application := le.app_date;
//self.Time_Application;
self.Application_ID := le.App_Number;
self.Source_Identifier := 'CFD';

self := le;
self := [];

end;

CFD_mapping_out := project(CFD_has_one_phone, tmapping_common(left)); 

////normalize phone number if both phone number populated

CFD_has_home_cell_phone := CFD_clean_address(home_phone <> '' and cell_phone <> '');

FraudPoint3.layout.base tnormalize(CFD_has_home_cell_phone le, integer cnt) := transform

self.customer_ID := le.CUST_ID_NUM;
self.vendor_ID := '18393';
self.Date_Fraud_Reported_LN := '';            
self.middle_name  := le.MID_name;
self.street_address := le.address1;
self.zip_code := le.zipcode;
self.Phone_Number := choose(cnt, le.home_phone, le.cell_phone);
self.Email_Address := le.EMAIL;
self.Income := le.net_income;
self.Own_or_Rent := le.own_rent_other;
//self.Location_Identifier;
//self.Other_Application_Identifier;
//self.Other_Application_Identifier2;
//self.Other_Application_Identifier3;
self.Date_Application := le.app_date;
//self.Time_Application;
self.Application_ID := le.App_Number;
//self.FraudPoint_Score := choose(cnt, le.FP1_score, le.FP2_score) ;
self.Source_Identifier := 'CFD';

self := le;
self := [];

end;

CFD_normalized := normalize(CFD_has_home_cell_phone, 2, tnormalize(left, counter));

CFD_deduped := dedup(CFD_normalized, all);

CFD_comb := CFD_mapping_out + CFD_deduped : persist('~thor_data400::persist::fraudpoint3_clean_CFD');

export clean_CFD := CFD_comb;


