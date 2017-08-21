import Business_Header, ut,address;

export As_Business_Contact :=
module

	//#OPTION('multiplePersistInstances',FALSE);
	
	export fContacts(dataset(layouts.base.Contacts) pContactsBaseFile, dataset(layouts.base.Companies) pCompaniesBaseFile) :=
	function

		layout_BH_contact 	:= Business_Header.Layout_Business_Contact_Full_New;
		//join to companies file to get company info
		companies_layout :=
		record
			pCompaniesBaseFile.dt_last_seen							;
			pCompaniesBaseFile.rawfields.MainCompanyID	;
			pCompaniesBaseFile.rawfields.CompanyName		;
			pCompaniesBaseFile.Clean_address.prim_range	;
			pCompaniesBaseFile.Clean_address.predir			;
			pCompaniesBaseFile.Clean_address.prim_name	;
			pCompaniesBaseFile.Clean_address.addr_suffix;
			pCompaniesBaseFile.Clean_address.postdir		;
			pCompaniesBaseFile.Clean_address.unit_desig	;
			pCompaniesBaseFile.Clean_address.sec_range	;
			string25 city := pCompaniesBaseFile.Clean_address.v_city_name;
			pCompaniesBaseFile.Clean_address.st					;						
			unsigned3 zip		:= (unsigned3)pCompaniesBaseFile.Clean_address.zip;
			unsigned2 zip4	:= (unsigned2)pCompaniesBaseFile.Clean_address.zip4;
			unsigned6 company_phone := (unsigned6) pCompaniesBaseFile.Clean_phones.phone;
		
		end;
		pCompaniesBaseFile_trim := table(pCompaniesBaseFile, companies_layout);
		pCompaniesBaseFile_dedup := dedup(sort(distribute(pCompaniesBaseFile_trim, hash(trim(MainCompanyID))), MainCompanyID, -dt_last_seen, local), MainCompanyID,local);
		
		pContactsBaseFile_dist 	:= distribute(pContactsBaseFile					,hash(trim(rawfields.MainCompanyID,left,right)));
		pCompaniesBaseFile_dist := distribute(pCompaniesBaseFile_dedup	,hash(trim(MainCompanyID					,left,right)));
		
		Layouts.temporary.Contacts.asbusiness tGetCompanyFields(Layouts.Base.Contacts l, pCompaniesBaseFile_dist r) :=
		transform

			self.companyname	:= r.CompanyName	;
			self.prim_range		:= r.prim_range		;
			self.predir				:= r.predir				;
			self.prim_name		:= r.prim_name		;
			self.addr_suffix	:= r.addr_suffix	;
			self.postdir			:= r.postdir			;
			self.unit_desig		:= r.unit_desig		;
			self.sec_range		:= r.sec_range		;
			self.city					:= r.city					;
			self.st						:= r.st						;
			self.zip					:= r.zip					;
			self.zip4					:= r.zip4					;
			self.company_phone	:= r.company_phone					;
			self							:= l;
			
		end;
		
		ContactsAppend := join(	 pContactsBaseFile_dist
														,pCompaniesBaseFile_dist
														,trim(left.rawfields.MainCompanyID,left,right) = trim(right.MainCompanyID,left,right)
														,tGetCompanyFields(left,right)
														,local
														,left outer
													);
		

		//////////////////////////////////////////////////////////////////////////////////////////////
		// -- Map to Business Contact Layout
		//////////////////////////////////////////////////////////////////////////////////////////////
		layout_BH_contact tAsBusinessContact(Layouts.temporary.Contacts.asbusiness l, unsigned2 cnt) :=
		transform

			cnt1 := map(	 l.clean_phones.OfficePhone != '' =>	l.clean_phones.OfficePhone
										,l.clean_phones.DirectDial	!= '' =>	l.clean_phones.DirectDial
										,																			l.clean_phones.MobilePhone
							);
							
			cnt2 := map(	 l.clean_phones.DirectDial	!= '' =>	l.clean_phones.DirectDial
										,																			l.clean_phones.MobilePhone
							);

			phone := choose(cnt	,cnt1
													,cnt2
													,l.clean_phones.MobilePhone
							);
						
			self.source 							:=	Source_codes.contacts;
			self.dppa									:=	false;
			self.dt_first_seen 				:=	l.dt_first_seen;
			self.dt_last_seen 				:=	l.dt_last_seen;
			self.prim_range						:=	l.Clean_contact_address.prim_range;
			self.predir								:=	l.Clean_contact_address.predir;
			self.prim_name						:=	l.Clean_contact_address.prim_name;
			self.addr_suffix					:=	l.Clean_contact_address.addr_suffix;
			self.postdir							:=	l.Clean_contact_address.postdir;
			self.unit_desig						:=	l.Clean_contact_address.unit_desig;
			self.sec_range						:=	l.Clean_contact_address.sec_range;
			self.city									:=	l.Clean_contact_address.v_city_name;
			self.state								:=	l.Clean_contact_address.st;
			self.zip									:=	(unsigned)l.Clean_contact_address.zip;
			self.zip4									:=	(unsigned)l.Clean_contact_address.zip4;
			self.county								:=	l.Clean_contact_address.fips_county;
			self.msa									:=	l.Clean_contact_address.msa;
			self.geo_lat							:=	l.Clean_contact_address.geo_lat;
			self.geo_long							:=	l.Clean_contact_address.geo_long;
			self.record_type					:=	l.record_type;
			self.phone								:=	(unsigned6)phone;
			self.email_address				:=	l.rawfields.OfficeEmail;
			self.ssn									:=	0;
			self.title								:=	l.clean_contact_name.title;
			self.fname 								:=	l.clean_contact_name.fname;
			self.mname								:=	l.clean_contact_name.mname;
			self.lname								:=	l.clean_contact_name.lname;
			self.name_suffix					:=	l.clean_contact_name.name_suffix;
			self.name_score						:=	Business_Header.CleanName(self.fname,self.mname,self.lname,self.name_suffix)[142];
			self.vl_id						    :=	l.rawfields.MainCompanyID;
			self.vendor_id						:=	trim(l.rawfields.MainContactID) + '-' + trim(l.rawfields.MainCompanyID);
			self.company_title				:=	l.rawfields.PrimaryTitle;
			self.company_department		:=	l.rawfields.PrimaryDept;
			self.company_source_group	:=	'';
			self.company_name					:=	l.CompanyName	;
			self.company_prim_range		:=	l.prim_range	;
			self.company_predir				:=	l.predir			;
			self.company_prim_name		:=	l.prim_name		;
			self.company_addr_suffix	:=	l.addr_suffix	;
			self.company_postdir			:=	l.postdir			;
			self.company_unit_desig		:=	l.unit_desig	;
			self.company_sec_range		:=	l.sec_range		;
			self.company_city					:=	l.city				;
			self.company_state				:=	l.st					;
			self.company_zip					:=	l.zip					;
			self.company_zip4					:=	l.zip4				;
			self.company_phone				:=	l.company_phone;
			self.company_fein					:=	0;
			self.bdid									:=	0;
		end;

		choosey(
			 string pOfficePhone
			,string pDirectDial	
			,string pMobilePhone
		) :=       
		function
		
			OfficePhone_cnt := if(pOfficePhone != '', 1, 0);
			DirectDial_cnt	:= if(pDirectDial	 != '', 1, 0);
			MobilePhone_cnt := if(pMobilePhone != '', 1, 0);

			total := OfficePhone_cnt + DirectDial_cnt + MobilePhone_cnt;
			
			return if(total = 0, 1, total);
			
		end;
										
		dAsBusinessHeader	:= normalize(
														 ContactsAppend
														,choosey(left.clean_phones.OfficePhone, left.clean_phones.DirectDial, left.clean_phones.MobilePhone)
														,tAsBusinessContact(left,counter)
														);

		return	dAsBusinessHeader((integer)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix),(vendor_id != ''));

	end;

	export Contacts	:= fContacts(files().base.Contacts.BusinessHeader,files().base.Companies.BusinessHeader) : persist(persistnames.AsBusinessContact);

end;