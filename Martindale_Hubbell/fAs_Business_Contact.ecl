import Business_Header, ut,address;

export fAs_Business_Contact(

	 dataset(layouts.base.Affiliated_Individuals) pAffBase	= files().base.Affiliated_individuals.qa
	,dataset(layouts.base.Organizations					) pOrgBase	= files().base.Organizations.qa

) :=
function

	// get company address first
	lay_aff_plus :=
	record
		layouts.base.Affiliated_Individuals;
		Address.Layout_Clean182_fips								Clean_mailing_address						;
		Address.Layout_Clean182_fips								Clean_location_address					;
		unsigned8																		company_RawAid_mailing								:= 0;
		unsigned8																		company_RawAid_Location								:= 0;
		unsigned6																		CONTACT_PHONES_PHONE_NUMBER;
	end;

	daffbase_plus := join(
	
		 pAffBase
		,pOrgBase
		,		left.rawfields.ORG_AUDIT_FIRMNO = right.rawfields.ORG_AUDIT_FIRMNO
		and left.dt_vendor_first_reported between right.dt_vendor_first_reported and right.dt_vendor_last_reported
		,transform(lay_aff_plus
			,self.Clean_mailing_address 	:= right.Clean_mailing_address	;
			 self.Clean_location_address 	:= right.Clean_location_address	;
			 self.company_RawAid_mailing	:= right.RawAid_mailing					;
			 self.company_RawAid_Location	:= right.RawAid_Location				;
			 self.CONTACT_PHONES_PHONE_NUMBER	:= (unsigned6)right.clean_phones.CONTACT_PHONES_PHONE_NUMBER;
			 self													:= left													;
		)
		,keep(1)
	);
	
	daffbase_plus_dist := distribute(daffbase_plus, random());

	layout_BH_contact 	:= Business_Header.Layout_Business_Contact_Full_New;

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Map to Business Contact Layout
	//////////////////////////////////////////////////////////////////////////////////////////////
	layout_BH_contact tbusiness_contact(lay_aff_plus l, unsigned2 cnt) :=
	transform

		phone :=	choose(((cnt - 1) % 5) + 1
			,l.clean_phones.CONTACT_FAXS_FAX_NUMBER									
			,l.clean_phones.CONTACT_PHONES_PHONE_NUMBER							
			,l.clean_phones.HEADER_AFF_INDIV_INDIV_CELL_PHONE_NUMBER	
			,l.clean_phones.HEADER_AFF_INDIV_INDIV_FAX_FAX_NUMBER		
			,l.clean_phones.HEADER_AFF_INDIV_INDIV_PHONE_PHONE_NUMBER
		);

		contaddcnt	:= ((cnt - 1) % 2) + 1;
		compaddcnt	:= (((unsigned8)((cnt - 1) / 2) + 1) % 2) + 1;
		
    self.vl_id						    := trim(l.rawfields.ORG_AUDIT_FIRMNO) + '-' + trim(l.rawfields.HEADER_AFF_INDIV_INDIV_AUDIT_ISLN,left,right); 
		self.vendor_id						:= self.vl_id;
		self.dt_first_seen				:= l.dt_first_seen;
		self.dt_last_seen					:= l.dt_last_seen;
		self.source               := Source_Codes.Affiliated_Individuals;
		self.record_type          := 'C';
		self.from_hdr             := 'N';
		self.glb                  := false;
		self.dppa									:= false;
		self.company_title        := l.rawfields.HEADER_AFF_INDIV_POSITION;
		self.company_department   := '';
		self.title                := l.clean_contact_name.title      	;
		self.fname                := l.clean_contact_name.fname      	;
		self.mname								:= l.clean_contact_name.mname				;
		self.lname                := l.clean_contact_name.lname      	;
		self.name_suffix          := l.clean_contact_name.name_suffix	;
		self.name_score           := Business_Header.CleanName(self.fname,self.mname,self.lname,self.name_suffix)[142];
		SELF.prim_range						:= choose(contaddcnt	,L.Clean_contact_location_address.prim_range				,L.Clean_contact_mailing_address.prim_range				);
		SELF.predir								:= choose(contaddcnt	,L.Clean_contact_location_address.predir						,L.Clean_contact_mailing_address.predir						);
		SELF.prim_name						:= choose(contaddcnt	,L.Clean_contact_location_address.prim_name					,L.Clean_contact_mailing_address.prim_name				);
		SELF.addr_suffix					:= choose(contaddcnt	,L.Clean_contact_location_address.addr_suffix				,L.Clean_contact_mailing_address.addr_suffix			);
		SELF.postdir							:= choose(contaddcnt	,L.Clean_contact_location_address.postdir						,L.Clean_contact_mailing_address.postdir					);
		SELF.unit_desig						:= choose(contaddcnt	,L.Clean_contact_location_address.unit_desig				,L.Clean_contact_mailing_address.unit_desig				);
		SELF.sec_range						:= choose(contaddcnt	,L.Clean_contact_location_address.sec_range					,L.Clean_contact_mailing_address.sec_range				);
		SELF.city									:= choose(contaddcnt	,L.Clean_contact_location_address.v_city_name				,L.Clean_contact_mailing_address.v_city_name			);
		SELF.state								:= choose(contaddcnt	,L.Clean_contact_location_address.st								,L.Clean_contact_mailing_address.st								);
		SELF.zip									:= choose(contaddcnt	,(UNSIGNED3)	L.Clean_contact_location_address.zip	,(UNSIGNED3)L.Clean_contact_mailing_address.zip		);
		SELF.zip4									:= choose(contaddcnt	,(UNSIGNED2)	L.Clean_contact_location_address.zip4	,(UNSIGNED2)L.Clean_contact_mailing_address.zip4	);
		SELF.county								:= choose(contaddcnt	,L.Clean_contact_location_address.fips_county				,L.Clean_contact_mailing_address.fips_county			);
		SELF.msa									:= choose(contaddcnt	,L.Clean_contact_location_address.msa								,L.Clean_contact_mailing_address.msa							);
		SELF.geo_lat							:= choose(contaddcnt	,L.Clean_contact_location_address.geo_lat						,L.Clean_contact_mailing_address.geo_lat					);				
		SELF.geo_long							:= choose(contaddcnt	,L.Clean_contact_location_address.geo_long					,L.Clean_contact_mailing_address.geo_long					);
		self.phone                := (UNSIGNED6)phone;
		self.email_address				:= '';
		self.ssn                  := 0;
		self.company_source_group := trim(L.rawfields.ORG_AUDIT_FIRMNO,left,right);
		self.company_name         := l.rawfields.HEADER_AFF_INDIV_NAME_ORG_NAME;
		self.company_prim_range   := choose(compaddcnt	,L.Clean_location_address.prim_range				,L.Clean_mailing_address.prim_range					);
		self.company_predir				:= choose(compaddcnt	,L.Clean_location_address.predir						,L.Clean_mailing_address.predir							);
		self.company_prim_name    := choose(compaddcnt	,L.Clean_location_address.prim_name					,L.Clean_mailing_address.prim_name					);
		self.company_addr_suffix  := choose(compaddcnt	,L.Clean_location_address.addr_suffix				,L.Clean_mailing_address.addr_suffix				);
		self.company_postdir      := choose(compaddcnt	,L.Clean_location_address.postdir						,L.Clean_mailing_address.postdir						);
		self.company_unit_desig   := choose(compaddcnt	,L.Clean_location_address.unit_desig				,L.Clean_mailing_address.unit_desig					);
		self.company_sec_range		:= choose(compaddcnt	,L.Clean_location_address.sec_range					,L.Clean_mailing_address.sec_range					);
		self.company_city         := choose(compaddcnt	,L.Clean_location_address.v_city_name				,L.Clean_mailing_address.v_city_name				);
		self.company_state        := choose(compaddcnt	,L.Clean_location_address.st								,L.Clean_mailing_address.st									);
		self.company_zip          := choose(compaddcnt	,(UNSIGNED3)	L.Clean_location_address.zip	,(UNSIGNED3)L.Clean_mailing_address.zip			);
		self.company_zip4         := choose(compaddcnt	,(UNSIGNED2)	L.Clean_location_address.zip4	,(UNSIGNED2)L.Clean_mailing_address.zip4		);
		self.company_phone				:= l.CONTACT_PHONES_PHONE_NUMBER;
		self.company_fein					:= 0;
		self.rawaid								:= choose(contaddcnt,L.RawAid_Location				,L.RawAid_mailing					);
		self.company_rawaid				:= choose(compaddcnt,L.company_RawAid_Location,L.company_RawAid_mailing	);
	end;

	asbc := normalize(daffbase_plus_dist, 20, tbusiness_contact(LEFT,counter));
	
	asbc_dedup := dedup(
									sort(
										distribute(asbc
										,hash(vendor_id, company_name,lname,fname,prim_range, prim_name, city,state,zip, phone, company_prim_range, company_prim_name, company_city,company_state,company_zip, company_phone))
										,hash(vendor_id, company_name,lname,fname,prim_range, prim_name, city,state,zip, phone, company_prim_range, company_prim_name, company_city,company_state,company_zip, company_phone), local)
										,hash(vendor_id, company_name,lname,fname,prim_range, prim_name, city,state,zip, phone, company_prim_range, company_prim_name, company_city,company_state,company_zip, company_phone), local);

	return	asbc_dedup(
							 company_name != ''
							,(
									prim_name	!= ''
									or city		!= ''
									or state	!= ''
									or zip		!= 0
								)
							or phone 					!= 0
//							,company_prim_name	!= '' or company_phone	!= 0
					);

end;