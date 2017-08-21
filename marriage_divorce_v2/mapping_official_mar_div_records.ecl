/*2007-09-06T18:59:39Z (Khurram Humayun_Prod)

*/
import ut;

// transform that maps the raw input files into an intermediate layout.
marriage_divorce_v2.layout_mar_div_intermediate t_map_to_common(marriage_divorce_v2.File_Official_Mar_Div_Records_In le) := transform
 
 boolean Unknown_type													  := (le.master_party_type_cd='1' and le.master_party_type_cd2='1') or
																								   (le.master_party_type_cd='5' and le.master_party_type_cd2='5');
	
 
 
 //Not relevant because there's no address information
 self.dt_first_seen            := 0;
 self.dt_last_seen             := 0;
 self.dt_vendor_first_reported := 0;
 self.dt_vendor_last_reported  := 0;
 

 self.filing_type  					:= le.filing_type;
 self.filing_subtype				:= le.doc_type_desc;
 self.vendor       					:= 'OFR'+le.vendor;
 self.source_file  					:= 'OFR-'+le.state_origin+'-'+le.county_name[1..18];
 self.process_date 					:= le.process_date;
 self.state_origin 					:= le.state_origin;
 


//Entity1									  R = grantor or U = Unknown
 self.party1_type 					:= if(Unknown_type,'U','R');
 															     
 self.party1_name_format 		:= 'L';
 self.party1_name        		:= if(le.entity_nm != '',le.entity_nm,'UNKNOWN');	

 

//Entity2										T = grantee	or U = Unknown

 self.party2_type 					:= if(Unknown_type,'U','T');
 self.party2_name_format 		:= 'L';
 self.party2_name        		:= if(le.entity_nm2 != '',le.entity_nm2,'UNKNOWN');	



 //marriage info
 self.marriage_filing_dt			:= if(le.filing_type = '3',le.doc_filed_dt,'');
 
 self.marriage_county			  	:= if(le.filing_type = '3',le.county_name,'');
 
 self.marriage_filing_number	:= if(le.filing_type = '3',le.doc_instrument_or_clerk_filing_num,'');

//divorce info
 self.divorce_filing_dt				:= if(le.filing_type = '7',le.doc_filed_dt,'');
																 
 self.divorce_county 				  := if(le.filing_type = '7',le.county_name,'');
 
 self.divorce_filing_number		:= if(le.filing_type = '7',le.doc_instrument_or_clerk_filing_num,'');
 self := [];

 
end;

export mapping_official_mar_div_records := project(marriage_divorce_v2.File_Official_Mar_Div_Records_In,t_map_to_common(left)) : persist('official_mar_div_records');

