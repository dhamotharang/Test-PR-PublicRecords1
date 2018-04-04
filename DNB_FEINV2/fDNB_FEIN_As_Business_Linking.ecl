﻿/*2017-04-24T21:24:45Z (Harrison Sun_prod)
Check in for S47 build RR-11124
*/
import ut, business_header,mdr,lib_stringlib,dnb_dmi,bipv2;

export fdnb_fein_as_business_linking(dataset(DNB_FEINV2.layout_DNB_fein_base_main_new) pcompany_base = dnb_feinv2.file_dnb_fein_base_main_new) := function 

		//Bug#106792.Excluding invalid company name records,  
		//We are receiving invalid company names from only one duns_source'SOUTH DAKOTA UCC FILINGS' 
		//Example  invalid company_names are:"022719990426AS 000","024020000203TE 000"  
		invalid_busName_filter 	:= (pcompany_base.duns_orig_Source = 'SOUTH DAKOTA UCC FILINGS' and 
													  (integer) pcompany_base.bdid=0 	and 
													  lib_stringlib.stringlib.stringfind(pcompany_base.orig_company_name,'000',1) <> 0);
														
		pcompany_base1 					:= pcompany_base(~invalid_busName_filter);
		
		//company mapping
		business_header.layout_business_linking.linking_interface	x3(DNB_FEINV2.layout_DNB_fein_base_main_new l,unsigned8 ctr) := 
    transform
																					// ,skip(ctr=2 and (trim(l.trade_style) = '' or 
																													 // ut.CompanySimilar100(ut.CleanCompany(ut.CleanSpacesAndUpper(l.trade_style)),ut.CleanCompany(ut.CleanSpacesAndUpper(l.company_name)))<= 10)
																							 // )
        // same_names := ut.CleanSpacesAndUpper(l.orig_company_name) = ut.CleanSpacesAndUpper(l.company_name);
        
	      self.source_record_id            := l.source_rec_id;
			  self.vl_id                       := l.tmsid;
			  self.source                      := mdr.sourcetools.src_dunn_bradstreet_fein;
			  // self.company_phone               := '';
			  self.company_phone               := if(ctr in [2,3] ,ut.cleanPhone(l.telephone_number)  ,'');
			  self.phone_score                 := if((integer)self.company_phone=0,0,1);
				self.phone_type     						 := if((integer)self.company_phone=0,'','T');
			  self.company_bdid			   	       := if(ctr = 1  ,(unsigned6) l.bdid ,0);  //bdid comes from business_name and address
			  self.company_rawaid			         := l.raw_aid ;
			  self.company_name 			         := choose(ctr  ,ut.CleanSpacesAndUpper(l.orig_Company_name)  ,ut.CleanSpacesAndUpper(l.Company_name) , ut.CleanSpacesAndUpper(l.trade_style) );
			  self.company_name_type_raw 			 := choose(ctr  ,'LEGAL'                                      ,'LEGAL'/*we are setting this to legal in dmi*/ ,'TRADE STYLE'                          );
				// self.company_sic_code1           := if(same_names = true  ,l.sic_code ,'');
				self.company_sic_code1           := if(ctr in [2,3] ,l.sic_code ,'');
        // -- address for non-public record company_name & trade style will be verified below by DMI data
			  self.company_address_type_raw    := 'CC';
			  self.company_address.prim_range  := l.prim_range;
			  self.company_address.predir      := l.predir;
			  self.company_address.prim_name   := l.prim_name;
			  self.company_address.addr_suffix := l.addr_suffix;
			  self.company_address.postdir     := l.postdir;
			  self.company_address.unit_desig  := l.unit_desig;
			  self.company_address.sec_range   := l.sec_range;
				self.company_address.p_city_name := l.p_city_name;
			  self.company_address.v_city_name := l.v_city_name;
			  self.company_address.st          := l.st;
			  self.company_address.zip         := l.zip;
			  self.company_address.zip4        := l.zip4;
				self.company_address.fips_state  := if(regexfind('[a-z]+',l.county[1..2],nocase),'',l.county[1..2]);
				self.company_address.fips_county := if(regexfind('[a-z]+',l.county[3..5],nocase),'',l.county[3..5]);
			  self.company_address.msa         := l.msa;
			  self.company_address.geo_lat     := l.geo_lat;
			  self.company_address.geo_long    := l.geo_long;
			  self.dt_first_seen               := (unsigned4)l.date_first_seen;
			  self.dt_last_seen                := (unsigned4)l.date_last_seen;
			  self.dt_vendor_last_reported     := (unsigned4)l.date_vendor_last_reported;
			  self.dt_vendor_first_reported    := (unsigned4)l.date_vendor_first_reported;
			  self.current					           := true;
			  self.dppa						             := false;
			  self.company_fein                := if(ctr = 1  ,if(business_header.validfein((unsigned4)stringlib.stringfilter(l.fein,'0123456789')), stringlib.stringfilter(l.fein,'0123456789'), '') ,'');
				self.best_fein_Indicator         := if(ctr = 1  ,l.best_fein_Indicator  ,'');
			  self.contact_job_title_raw       := if(ctr in [2,3] ,l.top_contact_title,'');
			  self.contact_name.title          := if(ctr in [2,3] ,l.title            ,'');
			  self.contact_name.fname          := if(ctr in [2,3] ,l.fname            ,'');
			  self.contact_name.mname          := if(ctr in [2,3] ,l.mname            ,'');
			  self.contact_name.lname          := if(ctr in [2,3] ,l.lname            ,'');
				self.contact_name.name_suffix		 := if(ctr in [2,3] ,l.name_suffix      ,'');
	      self.contact_name.name_score     := if(ctr in [2,3] ,l.name_score       ,'');
				self.duns_number								 := if(ctr in [2,3] ,l.case_duns_number ,'');
			  self 							   						 := l;
			  self 							   						 := [];
	 end;

		mapping_companys  		  := normalize(pcompany_base1,map( trim(left.Company_name) != '' and trim(left.trade_style) != '' => 3
                                                            ,trim(left.Company_name) != ''                                  => 2
                                                            ,                                                                  1 
                                                            ),x3(left,counter));
		// mapping_companys  		  := project(pcompany_base1,x3(left,counter));
		from_dnb_fein_dist 		  := distribute(mapping_companys(trim(company_name) <> ''),hash(vl_id));
		from_dnb_fein_sort    	:= sort(from_dnb_fein_dist ,vl_id,duns_number,company_name,-company_address.zip,-company_address.prim_name,-company_address.prim_range,-company_address.v_city_name,-company_address.st
		                                ,contact_name.fname,contact_name.mname,contact_name.lname,contact_job_title_raw,-company_phone,dt_vendor_first_reported,local);
		
	  business_header.layout_business_linking.linking_interface  x4(business_header.layout_business_linking.linking_interface  l, business_header.layout_business_linking.linking_interface  r) := transform
     	self.dt_first_seen		        := min(l.dt_first_seen,	r.dt_first_seen);
			self.dt_last_seen 		        := max(l.dt_last_seen,	r.dt_last_seen);
			self.dt_vendor_last_reported  := max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
			self.dt_vendor_first_reported := min(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
			self.source_record_id					:= if(l.dt_vendor_first_reported < r.dt_vendor_first_reported, l.source_record_id, r.source_record_id);
			self                          := l;
	  end;
		
		from_dnb_fein_rollup    := rollup(from_dnb_fein_sort,
																							    left.vl_id 							  				= right.vl_id
																			and					left.duns_number									= right.duns_number
																			and					left.company_fein									= right.company_fein
																			and         left.company_name	  						  = right.company_name
																			and(  (     left.company_address.zip			    =	right.company_address.zip 
																							and left.company_address.prim_name    =	right.company_address.prim_name 
																							and left.company_address.prim_range   = right.company_address.prim_range
																							and left.company_address.v_city_name  = right.company_address.v_city_name
																							and left.company_address.st           = right.company_address.st
																							and left.company_phone                = right.company_phone
																						 )      		OR 
																						 (     right.company_address.zip				='' 
																						   and right.company_address.prim_name  ='' 
																							 and right.company_address.prim_range	='' 
																							 and right.company_address.v_city_name='' 
																							 and right.company_address.st					=''
																							 and right.company_phone    					=''
																						  )
											                    )
																	 	   and(        left.contact_name.fname					= right.contact_name.fname
																					     and left.contact_name.mname    			= right.contact_name.mname
																					     and left.contact_name.lname   				= right.contact_name.lname
																					     and left.contact_job_title_raw 			= right.contact_job_title_raw
														              ),x4(left,right),local);
    // ----                                      
    ds_dmi        := DNB_DMI.As_Business_Linking();
    ds_dmi_table  := table(ds_dmi  ,{duns_number ,company_name  ,string prim_range := company_address.prim_range ,string prim_name := company_address.prim_name  ,string v_city_name := company_address.v_city_name   } ,duns_number ,company_name  ,company_address.prim_range ,company_address.prim_name  ,company_address.v_city_name ,merge);
        
    ds_result := 
        from_dnb_fein_rollup(trim(duns_number) = '')  //the public record fields don't have a duns associated
      + join(from_dnb_fein_rollup(trim(duns_number) != '')  ,ds_dmi_table  //the appended fields have duns, but might not be valid with the public record address, so verify it against DMI
          ,   left.duns_number                  = right.duns_number  
          and left.company_name                 = right.company_name
          and left.company_address.prim_range   = right.prim_range
          and left.company_address.prim_name    = right.prim_name
          and left.company_address.v_city_name  = right.v_city_name
          ,transform(left)  
          ,hash);

		return ds_result;
end;
