#OPTION('multiplePersistInstances',FALSE);
import _validate, ut, business_header, mdr, lib_stringlib, email_data;

EXPORT As_Business_Linking ( boolean pUseOtherEnviron = _Constants().IsDataland
														,dataset(CClue.layouts.Base) pBase = files(,pUseOtherEnviron).base.qa	
	) := function
	
		pBase_Business_recs := pBase(trim(business_name) <> '');
		
		bad_cnames := ['*****FILE DOES NOT EXIST*****','NONE','(CONTINUED)','(SEE CONTINUED NAMED INSURED','/WA','(',')','2','C/O','THE','"',';','A','B','O','S'];
		
		DBApattern		:= '^(.*?)([ ]+[(]*[/]*[,]*D[/]*[ ]*[.]*[/]*[:]*B[/]*[ ]*[.]*[/]*[:]*A[/]*[ ]*[.]*[/]*[:]*[-]*[)]*)(.*)$';
		CareOfpattern := '^(.*?)( C/O | C/O|C/O | C / O |- C/O |-C/O |-C / O | C/ O,|,C/O |, C/O |\\(C/O\\)|\\(C/0\\)|C/0 | C/0| C/0 | C/0,)(.*)$';
				
		//COMPANY MAPPING
		business_header.layout_business_linking.linking_interface	trfMapBLInterface(CClue.layouts.Base l) := transform,
																				 skip(ut.CleanSpacesAndUpper(l.business_name) in bad_cnames)
																							 
				isCompanyDBA										 := if (regexfind(DBApattern, ' '+ut.CleanSpacesAndUpper(l.business_name), nocase), true, false);
				isCompanyCareOf									 := if (regexfind(CareOfpattern, ut.CleanSpacesAndUpper(l.business_name), nocase), true, false);
				tmpCareOfCnamePart1							 := if (isCompanyCareOf, regexfind(CareOfpattern, ut.CleanSpacesAndUpper(l.business_name), 1), '');
				//tmpCareOfCnamePart2							 := if (isCompanyCareOf, regexfind(CareOfpattern, ut.CleanSpacesAndUpper(l.business_name), 3), '');
				
				self.source_record_id            := l.header_rid;
				self.vl_id                       := trim(l.ambest_no) + '|' + trim(l.claim_no) + '|' + trim(l.policy_type);
				self.source                      := mdr.sourcetools.src_Cclue;
				
				self.company_phone               := if((integer)l.phone <> 0, ut.cleanPhone(l.phone),'');
				self.phone_score                 := if((integer)self.company_phone=0,0,1);
				self.phone_type     						 := if((integer)self.company_phone=0,'','T');
				self.company_bdid			   	       := l.bdid;
				self.company_rawaid			         := l.raw_aid ;
				//self.company_name 			         := if (isCompanyCareOf, if(trim(tmpCareOfCnamePart1) <> '', trim(tmpCareOfCnamePart1), trim(tmpCareOfCnamePart2)), ut.CleanSpacesAndUpper(l.business_name)); // Suppressing the Careof (C/O) and the string followed				
				self.company_name 			         := if (isCompanyCareOf, trim(tmpCareOfCnamePart1), ut.CleanSpacesAndUpper(l.business_name)); // Suppressing the Careof (C/O) and the string followed
				self.company_name_type_raw 			 := if (isCompanyDBA,'DBA','LEGAL');
				self.best_fein_Indicator         := '';
				self.company_sic_code1           := '';
				self.company_address_type_raw    := map(ut.CleanSpacesAndUpper(l.address_ind) = 'LO' => 'BUSINESS ADDRESS',
																								ut.CleanSpacesAndUpper(l.address_ind) = 'PA' => 'PRIMARY ADDRESS',
																								ut.CleanSpacesAndUpper(l.address_ind) = 'MA' => 'MAILING ADDRESS',
																								''
																							 );
				self.company_address.prim_range  := l.clean_addr.prim_range;
				self.company_address.predir      := l.clean_addr.predir;
				self.company_address.prim_name   := l.clean_addr.prim_name;
				self.company_address.addr_suffix := l.clean_addr.addr_suffix;
				self.company_address.postdir     := l.clean_addr.postdir;
				self.company_address.unit_desig  := l.clean_addr.unit_desig;
				self.company_address.sec_range   := l.clean_addr.sec_range;
				self.company_address.p_city_name := l.clean_addr.p_city_name;
				self.company_address.v_city_name := l.clean_addr.v_city_name;
				self.company_address.st          := l.clean_addr.st;
				self.company_address.zip	       := l.clean_addr.zip;
				self.company_address.zip4        := l.clean_addr.zip4;
				self.company_address.fips_state  := l.clean_addr.fips_state;
				self.company_address.fips_county := l.clean_addr.fips_county;
				self.company_address.msa         := l.clean_addr.msa;
				self.company_address.geo_lat     := l.clean_addr.geo_lat;
				self.company_address.geo_long    := l.clean_addr.geo_long;
				self.company_url								 := '';
				self.duns_number								 := if ((integer)l.duns_no <> 0, trim(l.duns_no), '');
				self.dt_first_seen               := if (_validate.date.fIsValid(l.claim_date) and 
																								_validate.date.fIsValid(l.claim_date,_validate.date.rules.DateInPast), (unsigned6)l.claim_date,0);
				self.dt_last_seen                := if (_validate.date.fIsValid(l.claim_date) and 
																								_validate.date.fIsValid(l.claim_date,_validate.date.rules.DateInPast), (unsigned6)l.claim_date,0);
				self.dt_vendor_last_reported     := 0;
				self.dt_vendor_first_reported    := 0;
				self.current					           := true;
				self.dppa						             := false;
				self.company_fein                := if ((integer)l.tax_id <> 0, trim(l.tax_id), '');
				self.contact_job_title_raw       := '';
				self.contact_name.title          := '';
				self.contact_name.fname          := '';
				self.contact_name.mname          := '';
				self.contact_name.lname          := '';
				self.contact_name.name_suffix		 := '';
				self.contact_name.name_score     := '';
				self.contact_email							 := '';
				self.contact_email_username			 := '';
				self.contact_email_domain				 := '';
				self 							   						 := l;
				self 							   						 := [];
		end;
																	

		Cclue_as_biz	:= project(pBase_Business_recs, trfMapBLInterface(left));
		
		Cclue_as_biz_srt	:= sort(distribute(Cclue_as_biz, hash(vl_id)), vl_id, record, except dt_first_seen, dt_last_seen, local);
		
		business_header.layout_business_linking.linking_interface trfRollup(Cclue_as_biz_srt l, Cclue_as_biz_srt r) := transform
				self.dt_first_seen		:= ut.EarliestDate(l.dt_first_seen,	r.dt_first_seen);
				self.dt_last_seen 		:= max(l.dt_last_seen,	r.dt_last_seen);
				self.source_record_id	:= if (l.source_record_id < r.source_record_id, l.source_record_id, r.source_record_id);
				self 									:= l;
		end;
		
		Cclue_as_biz_ded := rollup(Cclue_as_biz_srt, trfRollup(left, right), except dt_first_seen, dt_last_seen, source_record_id, local);
		
		Cclue_as_biz_Non_DBA := Cclue_as_biz_ded(company_name_type_raw = 'LEGAL');
		
		Cclue_as_biz_DBA := Cclue_as_biz_ded(company_name_type_raw = 'DBA');

		//*** fuinction to suppress the leading or trailing hypen or ampersand from a company name.
		BlankLTBadChar(string cname) := function
				return StringLib.StringCleanSpaces(regexreplace('^-|-$|^&|&$|^,',trim(cname),''));
		end;
		
		business_header.layout_business_linking.linking_interface trfDBAName(Cclue_as_biz_DBA l, integer c) := transform
			temp_Company_name1          := StringLib.StringCleanSpaces(regexfind(DBApattern, ' '+trim(l.company_name),1));
			temp_Company_name2          := StringLib.StringCleanSpaces(regexfind(DBApattern, ' '+trim(l.company_name), 3));
			self.company_name						:= choose(c, BlankLTBadChar(temp_Company_name1), BlankLTBadChar(temp_Company_name2));
			self.company_name_type_raw	:= choose(c, 'LEGAL', 'DBA');  
			self												:= l;
		end; 
			
		Cclue_as_biz_norm_DBA 	:= normalize(Cclue_as_biz_DBA, 2, trfDBAName(left, counter));
		
		Cclue_as_biz_recs := Cclue_as_biz_Non_DBA(trim(company_name) <> '' and trim(company_name) not in bad_cnames) + Cclue_as_biz_norm_DBA(trim(company_name) <> '' and trim(company_name) not in bad_cnames);
																	
		Cclue_as_biz_full_dedp_recs  := dedup(sort(distribute(Cclue_as_biz_recs,hash(vl_id)), vl_id, record, local),record, except source_record_id, local)
																			: persist(CClue.persistnames().root + '::As_Business_Linking');

		Cclue_as_biz_out_recs  := Cclue_as_biz_full_dedp_recs;
		
		return Cclue_as_biz_out_recs;

end;