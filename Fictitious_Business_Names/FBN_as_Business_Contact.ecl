IMPORT Business_Header, ut;
fbn_contacts := Fictitious_Business_Names.Cleaned_File;

// Normalize 2 contact names
layout_cont_slim := record
string100 clean_company_name;

//string100 clean_address_split;

//string73 clean_cleaned_name;
string5   			CCT_Clean_title							;
string20 	 			CCT_Clean_fname							;
string20  			CCT_Clean_mname							;
string20 				CCT_Clean_lname							;
string5  		 		CCT_Clean_name_suffix 				;
string3     		CCT_Clean_cleaning_score 	  ;




recordof(Fictitious_Business_Names.File_Out_AllFlat_Rollup);

string10  	CCT_Address_Clean_prim_range			;
string2  		CCT_Address_Clean_predir					;
string28 		CCT_Address_Clean_prim_name				;
string4   	CCT_Address_Clean_addr_suffix			;
string2  		CCT_Address_Clean_postdir					;
string10  	CCT_Address_Clean_unit_desig			;
string8   	CCT_Address_Clean_sec_range				;
string25 		CCT_Address_Clean_p_city_name			;
string25 		CCT_Address_Clean_v_city_name			;
string2  		CCT_Address_Clean_st							;
string5  		CCT_Address_Clean_zip							;
string4  		CCT_Address_Clean_zip4						;
string4  		CCT_Address_Clean_cart						;
string1  		CCT_Address_Clean_cr_sort_sz			;
string4   	CCT_Address_Clean_lot							;
string1  		CCT_Address_Clean_lot_order				;
string2  		CCT_Address_Clean_dpbc						;
string1  		CCT_Address_Clean_chk_digit				;
string2  		CCT_Address_Clean_record_type			;
string2  	CCT_Address_Clean_ace_fips_st				;
string3  	CCT_Address_Clean_fipscounty				;
string10 	CCT_Address_Clean_geo_lat						;
string11 	CCT_Address_Clean_geo_long					;
string4 	CCT_Address_Clean_msa								;
string7  	CCT_Address_Clean_geo_match					;
string4  	CCT_Address_Clean_err_stat					;	

string10  	Business_Address_Clean_prim_range			;
string2 	 	Business_Address_Clean_predir					;
string28 		Business_Address_Clean_prim_name			;
string4   	Business_Address_Clean_addr_suffix		;
string2  		Business_Address_Clean_postdir				;
string10  	Business_Address_Clean_unit_desig			;
string8   	Business_Address_Clean_sec_range			;
string25 		Business_Address_Clean_p_city_name		;
string25 		Business_Address_Clean_v_city_name		;
string2  		Business_Address_Clean_st							;
string5  		Business_Address_Clean_zip						;
string4  		Business_Address_Clean_zip4						;
string4  		Business_Address_Clean_cart						;
string1  		Business_Address_Clean_cr_sort_sz			;
string4   	Business_Address_Clean_lot						;
string1  		Business_Address_Clean_lot_order			;
string2 	 	Business_Address_Clean_dpbc						;
string1  		Business_Address_Clean_chk_digit			;
string2 	 	Business_Address_Clean_record_type		;
string2  		Business_Address_Clean_ace_fips_st		;
string3  		Business_Address_Clean_fipscounty			;
string10 		Business_Address_Clean_geo_lat				;
string11 		Business_Address_Clean_geo_long				;
string4 		Business_Address_Clean_msa						;
string7  		Business_Address_Clean_geo_match			;
string4  		Business_Address_Clean_err_stat				;	

string10 BusinessTelephone_clean									;
string10 ContactTelephone_clean										;
end;




layout_cont_slim fbn_norm_names(Fictitious_Business_Names.Layout_Cleaned_File l, integer CTR) := TRANSFORM
self.CCT_Clean_title := choose(CTR,l.CCT1_Clean_title,l.CCT2_Clean_title);
self.CCT_Clean_fname := choose(CTR,l.CCT1_Clean_fname,l.CCT2_Clean_fname );
self.CCT_Clean_mname := choose(CTR,l.CCT1_Clean_mname,l.CCT2_Clean_mname );
self.CCT_Clean_lname := choose(CTR,l.CCT1_Clean_lname,l.CCT2_Clean_lname );
self.CCT_Clean_name_suffix := choose(CTR,l.CCT1_Clean_name_suffix,l.CCT2_Clean_name_suffix );
self.CCT_Clean_cleaning_score := choose(CTR,l.CCT1_Clean_cleaning_score,l.CCT2_Clean_cleaning_score );
self := L;
end;

fbn_cont_slim := NORMALIZE(fbn_contacts, 2, fbn_norm_names(LEFT, COUNTER));


//*************************************************************************
// Translate Contact from dca to Business Contact Format
//*************************************************************************

Business_Header.Layout_Business_Contact_Full Translate_fbn_to_BCF(fbn_cont_slim l) := TRANSFORM
self.title := l.CCT_Clean_title;
self.fname := l.CCT_Clean_fname;
self.mname := l.CCT_Clean_mname;
self.lname := l.CCT_Clean_lname;
self.name_suffix := l.CCT_Clean_name_suffix;
self.company_title := ''; 
self.vendor_id := L.infousa_fbn_key;
self.source := 'IF';
self.name_score := Business_Header.CleanName(l.CCT_Clean_fname,l.CCT_Clean_mname,l.CCT_Clean_lname, l.CCT_Clean_name_suffix)[142]														;
self.prim_range							:= if(trim(l.CCT_Address_Clean_prim_range,left,right)!='',l.CCT_Address_Clean_prim_range,l.Business_Address_Clean_prim_range)		;

self.predir								:= if(trim(l.CCT_Address_Clean_predir,left,right)!='',l.CCT_Address_Clean_predir,l.Business_Address_Clean_predir)									;
self.prim_name							:= if(trim(l.CCT_Address_Clean_prim_name,left,right)!='',l.CCT_Address_Clean_prim_name,l.Business_Address_Clean_prim_name)			;
self.addr_suffix						:= if(trim(l.CCT_Address_Clean_addr_suffix,left,right)!='',l.CCT_Address_Clean_addr_suffix,l.Business_Address_Clean_addr_suffix);
self.postdir							:= if(trim(l.CCT_Address_Clean_postdir,left,right)!='',l.CCT_Address_Clean_postdir,l.Business_Address_Clean_postdir)							;
self.unit_desig							:= if(trim(l.CCT_Address_Clean_unit_desig,left,right)!='',l.CCT_Address_Clean_unit_desig,l.Business_Address_Clean_unit_desig)		;
self.sec_range							:= if(trim(l.CCT_Address_Clean_sec_range,left,right)!='',l.CCT_Address_Clean_sec_range,l.Business_Address_Clean_sec_range)			;
self.city								:= if(trim(l.CCT_Address_Clean_p_city_name,left,right)!='',l.CCT_Address_Clean_p_city_name,l.Business_Address_Clean_p_city_name)		;
self.state								:= if(trim(l.CCT_Address_Clean_st,left,right)!='',l.CCT_Address_Clean_st,l.Business_Address_Clean_st)												;
self.zip								:= (unsigned3)if(trim(l.CCT_Address_Clean_zip,left,right)!='',l.CCT_Address_Clean_zip,l.Business_Address_Clean_zip)						;
self.zip4								:= (unsigned2)if(trim(l.CCT_Address_Clean_zip4,left,right)!='',l.CCT_Address_Clean_zip4,l.Business_Address_Clean_zip4)				;

self.county								:=if(trim(l.CCT_Address_Clean_fipscounty,left,right)!='',l.CCT_Address_Clean_fipscounty,l.Business_Address_Clean_fipscounty);
self.msa								:= if(trim(l.CCT_Address_Clean_msa,left,right)!='',l.CCT_Address_Clean_msa,l.Business_Address_Clean_msa)											;
self.geo_lat							:= if(trim(l.CCT_Address_Clean_geo_lat,left,right)!='',l.CCT_Address_Clean_geo_lat,l.Business_Address_Clean_geo_lat)				;
self.geo_long							:= if(trim(l.CCT_Address_Clean_geo_long,left,right)!='',l.CCT_Address_Clean_geo_long,l.Business_Address_Clean_geo_long)			;
self.phone								:= (unsigned6)l.ContactTelephone_clean						;
self.email_address							:= ''																				;
self.ssn												:= 0																				;
self.company_source_group				:= ''												;
self.company_name								:= l.businessname														;
self.company_prim_range					:= l.Business_Address_Clean_prim_range			;
self.company_predir							:= l.Business_Address_Clean_predir					;
self.company_prim_name					:= l.Business_Address_Clean_prim_name				;
self.company_addr_suffix				:= l.Business_Address_Clean_addr_suffix			;
self.company_postdir						:= l.Business_Address_Clean_postdir					;
self.company_unit_desig					:= l.Business_Address_Clean_unit_desig			;
self.company_sec_range	 				:= l.Business_Address_Clean_sec_range				;
self.company_city								:= l.Business_Address_Clean_p_city_name			;
self.company_state							:= l.Business_Address_Clean_st	 						;
self.company_zip								:= (unsigned3)l.Business_Address_Clean_zip	;
self.company_zip4								:= (unsigned2)l.Business_Address_Clean_zip4	;
self.company_phone							:= (unsigned6)l.BusinessTelephone_clean			;
self.company_fein								:= 0																				;

  SELF.dt_first_seen := map(L.filingdate <> ''=> (UNSIGNED4)L.filingdate, 
														L.date_last_updated >'200308' => (UNSIGNED4)L.date_last_updated,
														0);
  SELF.dt_last_seen := map(L.date_last_updated >'200308' => (UNSIGNED4)L.date_last_updated,
												   L.filingdate <> ''=> (UNSIGNED4)L.filingdate,
														0);
self.record_type := 'C';
end;

//--------------------------------------------
// Normalize names
//--------------------------------------------
from_fbn_out := Project(fbn_cont_slim,Translate_fbn_to_BCF(left));

// Removed extra contacts with blank addresses
from_fbn_dist := distribute(from_fbn_out, hash(trim(vendor_id), trim(company_name)));

from_fbn_sort := sort(from_fbn_dist, vendor_id, company_name,
                     fname, mname, lname, name_suffix, company_title, phone, if(zip <> 0, 0, 1), zip, prim_name, prim_range, 
					 local);

from_fbn_dedup := dedup(from_fbn_sort,
                             left.vendor_id = right.vendor_id and
							 left.company_name = right.company_name and
							 left.fname= right.fname and
							 left.mname = right.mname and
							 left.lname = right.lname and
							 left.name_suffix = right.name_suffix and
							 left.company_title = right.company_title and
							 ((left.zip = right.zip and
							 left.prim_name = right.prim_name and
							 left.prim_range = right.prim_range) or
                             (left.zip <> 0 and right.zip = 0)),
							 local);


export FBN_as_Business_Contact := from_fbn_dedup((integer)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix)) : persist('TEMP::infousa_fbn_Contacts_As_BC');