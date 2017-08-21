import ut, business_header,mdr,lib_stringlib;

export fdnb_fein_as_business_linking(dataset(DNB_FEINV2.layout_DNB_fein_base_main_new) pcompany_base = dnb_feinv2.file_dnb_fein_base_main_new) := function 

		//Bug#106792.Excluding invalid company name records,  
		//We are receiving invalid company names from only one duns_source'SOUTH DAKOTA UCC FILINGS' 
		//Example  invalid company_names are:"022719990426AS 000","024020000203TE 000"  
		invalid_busName_filter 	:= (pcompany_base.duns_orig_Source = 'SOUTH DAKOTA UCC FILINGS' and 
													  (integer) pcompany_base.bdid=0 	and 
													  lib_stringlib.stringlib.stringfind(pcompany_base.orig_company_name,'000',1) <> 0);
														
		pcompany_base1 					:= pcompany_base(~invalid_busName_filter);
		
		//company mapping
		business_header.layout_business_linking.linking_interface	x3(DNB_FEINV2.layout_DNB_fein_base_main_new l,unsigned8 ctr) := transform
																					,skip(ctr=2 and (trim(l.trade_style) = '' or 
																													 ut.CompanySimilar100(ut.CleanCompany(ut.CleanSpacesAndUpper(l.trade_style)),ut.CleanCompany(ut.CleanSpacesAndUpper(l.company_name)))<= 10)
																							 )
	      self.source_record_id            := l.source_rec_id;
			  self.vl_id                       := l.tmsid;
			  self.source                      := mdr.sourcetools.src_dunn_bradstreet_fein;
			  self.company_phone               := ut.cleanPhone(l.telephone_number);
			  self.phone_score                 := if((integer)self.company_phone=0,0,1);
				self.phone_type     						 := if((integer)self.company_phone=0,'','T');
			  self.company_bdid			   	       :=(unsigned6) l.bdid;
			  self.company_rawaid			         := l.raw_aid ;
			  self.company_name 			         := choose(ctr, ut.CleanSpacesAndUpper(l.Company_name), ut.CleanSpacesAndUpper(l.trade_style));
			  self.company_name_type_raw 			 := map(ctr=1 => 'LEGAL',
																								ctr=2 => 'TRADE STYLE',
																								'');
				self.best_fein_Indicator         := l.best_fein_Indicator;
				self.company_sic_code1           := l.sic_code;
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
			  self.company_fein                := if(business_header.validfein((unsigned4)stringlib.stringfilter(l.fein,'0123456789')), stringlib.stringfilter(l.fein,'0123456789'), '');
			  self.contact_job_title_raw       := l.top_contact_title;
			  self.contact_name.title          := l.title;
			  self.contact_name.fname          := l.fname;
			  self.contact_name.mname          := l.mname;
			  self.contact_name.lname          := l.lname;
				self.contact_name.name_suffix		 := l.name_suffix;
	      self.contact_name.name_score     := l.name_score;
				self.duns_number								 := l.case_duns_number;
			  self 							   						 := l;
			  self 							   						 := [];
	 end;

		mapping_companys  		  := normalize(pcompany_base1,2,x3(left,counter));
		from_dnb_fein_dist 		  := distribute(mapping_companys(trim(company_name) <> ''),hash(vl_id));
		from_dnb_fein_sort    	:= sort(from_dnb_fein_dist ,vl_id,duns_number,company_name,-company_address.zip,-company_address.prim_name,-company_address.prim_range,-company_address.v_city_name,-company_address.st,contact_name.fname,contact_name.mname,contact_name.lname,contact_job_title_raw,local);
		
	  business_header.layout_business_linking.linking_interface  x4(business_header.layout_business_linking.linking_interface  l, business_header.layout_business_linking.linking_interface  r) := transform
			self := l;
	  end;
		
		from_dnb_fein_rollup    := rollup(from_dnb_fein_sort,
																							    left.vl_id 							  				= right.vl_id
																			and					left.duns_number									= right.duns_number
																			and         left.company_name	  						  = right.company_name
																			and(  (     left.company_address.zip			    =	right.company_address.zip 
																							and left.company_address.prim_name    =	right.company_address.prim_name 
																							and left.company_address.prim_range   = right.company_address.prim_range
																							and left.company_address.v_city_name  = right.company_address.v_city_name
																							and left.company_address.st           = right.company_address.st
																						 )      		OR 
																						 (     right.company_address.zip				='' 
																						   and right.company_address.prim_name  ='' 
																							 and right.company_address.prim_range	='' 
																							 and right.company_address.v_city_name='' 
																							 and right.company_address.st					=''
																						  )
											                    )
																	 	   and(        left.contact_name.fname					= right.contact_name.fname
																					     and left.contact_name.mname    			= right.contact_name.mname
																					     and left.contact_name.lname   				= right.contact_name.lname
																					     and left.contact_job_title_raw 			= right.contact_job_title_raw
														              ),x4(left,right),local);
		return from_dnb_fein_rollup;
end;
