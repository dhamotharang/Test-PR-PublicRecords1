#OPTION('multiplePersistInstances',FALSE);
import mdr,business_header;

laybus := Business_Header.Layout_Business_Contact_Full_New;

export As_Business_Contact(

	 boolean 													pUsingInBizHdr		= true
	,boolean 													pUseOtherEnviron	= _Constants().IsDataland
	,dataset(layouts.Base.contacts)		pDataset					= if(pUsingInBizHdr
																												,files(,pUseOtherEnviron).base.contacts.BusinessHeader
																												,files(,pUseOtherEnviron).base.contacts.qa
																											)
	,string1													pTodo							= 'R'	//'R' = recalculate persist,'P' = pull from persist(don't recalculate),'N' = Don't persist code
	,string														pPersistname			= persistnames(									).AsBusinessContact
	,dataset(laybus									) pPersist 					= persists		(pUseOtherEnviron	).AsBusinessContact
	,dataset(layouts.Base.companies	)	pCompaniesBase		= if(pUsingInBizHdr
																													,files(,pUseOtherEnviron).base.companies.BusinessHeader
																													,files(,pUseOtherEnviron).base.companies.qa
																												)
	
) :=
function

	dca_contacts := pDataset;


	//*************************************************************************
	// Translate Contact from dca to Business Contact Format
	//*************************************************************************

	Business_Header.Layout_Business_Contact_Full_New Translate_dca_to_BCF(layouts.Base.contacts l, integer CTR) := 
	TRANSFORM
		self.title								:= l.clean_name.title				;
		self.fname 								:= l.clean_name.fname 			;
		self.mname								:= l.clean_name.mname				;
		self.lname								:= l.clean_name.lname				;
		self.name_suffix					:= l.clean_name.name_suffix	;
		self.vl_id 								:= L.rawfields.enterprise_num;
		self.company_title 				:= stringlib.stringtouppercase(trim(L.rawfields.executive.title)[1..35]); 
		self.vendor_id 						:= L.rawfields.enterprise_num;
		self.source								:= MDR.sourceTools.src_DCA;
		self.name_score 					:= Business_Header.CleanName(l.clean_name.fname,l.clean_name.mname,l.clean_name.lname, l.clean_name.name_suffix)[142];
		SELF.prim_range 					:= CHOOSE(CTR ,L.physical_address.prim_range			,L.mailing_address.prim_range				,L.physical_address.prim_range			,L.mailing_address.prim_range				);
		SELF.predir 							:= CHOOSE(CTR ,L.physical_address.predir					,L.mailing_address.predir						,L.physical_address.predir					,L.mailing_address.predir						);
		SELF.prim_name 						:= CHOOSE(CTR ,L.physical_address.prim_name				,L.mailing_address.prim_name				,L.physical_address.prim_name				,L.mailing_address.prim_name				);
		SELF.addr_suffix 					:= CHOOSE(CTR ,L.physical_address.addr_suffix			,L.mailing_address.addr_suffix			,L.physical_address.addr_suffix			,L.mailing_address.addr_suffix			);
		SELF.postdir 							:= CHOOSE(CTR ,L.physical_address.postdir					,L.mailing_address.postdir					,L.physical_address.postdir					,L.mailing_address.postdir					);
		SELF.unit_desig 					:= CHOOSE(CTR ,L.physical_address.unit_desig			,L.mailing_address.unit_desig				,L.physical_address.unit_desig			,L.mailing_address.unit_desig				);
		SELF.sec_range 						:= CHOOSE(CTR ,L.physical_address.sec_range				,L.mailing_address.sec_range				,L.physical_address.sec_range				,L.mailing_address.sec_range				);
		SELF.city 								:= CHOOSE(CTR ,L.physical_address.v_city_name			,L.mailing_address.v_city_name			,L.physical_address.v_city_name			,L.mailing_address.v_city_name			);
		SELF.state 								:= CHOOSE(CTR ,L.physical_address.st							,L.mailing_address.st								,L.physical_address.st							,L.mailing_address.st								);
		SELF.zip 									:= CHOOSE(CTR ,(UNSIGNED3)L.physical_address.zip	,(UNSIGNED3)L.mailing_address.zip		,(UNSIGNED3)L.physical_address.zip	,(UNSIGNED3)L.mailing_address.zip		);
		SELF.zip4 								:= CHOOSE(CTR ,(UNSIGNED2)L.physical_address.zip4	,(UNSIGNED2)L.mailing_address.zip4	,(UNSIGNED2)L.physical_address.zip4	,(UNSIGNED2)L.mailing_address.zip4	);
		SELF.county 							:= CHOOSE(CTR ,L.physical_address.fips_county			,L.mailing_address.fips_county			,L.physical_address.fips_county			,L.mailing_address.fips_county			);
		SELF.msa 									:= CHOOSE(CTR ,L.physical_address.msa							,L.mailing_address.msa							,L.physical_address.msa							,L.mailing_address.msa							);
		SELF.geo_lat 							:= CHOOSE(CTR ,L.physical_address.geo_lat					,L.mailing_address.geo_lat					,L.physical_address.geo_lat					,L.mailing_address.geo_lat					);
		SELF.geo_long 						:= CHOOSE(CTR ,L.physical_address.geo_long				,L.mailing_address.geo_long					,L.physical_address.geo_long				,L.mailing_address.geo_long					);
		self.rawaid								:= CHOOSE(CTR	,l.physical_RawAID									,l.mailing_RawAID										,l.physical_RawAID									,l.mailing_RawAID										);
		SELF.company_name 				:= '';
		self.company_source_group := L.rawfields.enterprise_num;
		SELF.company_prim_range 	:= CHOOSE(CTR ,L.physical_address.prim_range			,L.mailing_address.prim_range				,L.mailing_address.prim_range				,L.physical_address.prim_range			);
		SELF.company_predir 			:= CHOOSE(CTR ,L.physical_address.predir					,L.mailing_address.predir						,L.mailing_address.predir						,L.physical_address.predir					);
		SELF.company_prim_name		:= CHOOSE(CTR ,L.physical_address.prim_name				,L.mailing_address.prim_name				,L.mailing_address.prim_name				,L.physical_address.prim_name				);
		SELF.company_addr_suffix 	:= CHOOSE(CTR ,L.physical_address.addr_suffix			,L.mailing_address.addr_suffix			,L.mailing_address.addr_suffix			,L.physical_address.addr_suffix			);
		SELF.company_postdir 			:= CHOOSE(CTR ,L.physical_address.postdir					,L.mailing_address.postdir					,L.mailing_address.postdir					,L.physical_address.postdir					);
		SELF.company_unit_desig 	:= CHOOSE(CTR ,L.physical_address.unit_desig			,L.mailing_address.unit_desig				,L.mailing_address.unit_desig				,L.physical_address.unit_desig			);
		SELF.company_sec_range		:= CHOOSE(CTR ,L.physical_address.sec_range				,L.mailing_address.sec_range				,L.mailing_address.sec_range				,L.physical_address.sec_range				);
		SELF.company_city 				:= CHOOSE(CTR ,L.physical_address.v_city_name			,L.mailing_address.v_city_name			,L.mailing_address.v_city_name			,L.physical_address.v_city_name			);
		SELF.company_state 				:= CHOOSE(CTR ,L.physical_address.st							,L.mailing_address.st								,L.mailing_address.st								,L.physical_address.st							);
		SELF.company_zip 					:= CHOOSE(CTR ,(UNSIGNED3)L.physical_address.zip	,(UNSIGNED3)L.mailing_address.zip		,(UNSIGNED3)L.mailing_address.zip		,(UNSIGNED3)L.physical_address.zip	);
		SELF.company_zip4					:= CHOOSE(CTR ,(UNSIGNED2)L.physical_address.zip4	,(UNSIGNED2)L.mailing_address.zip4	,(UNSIGNED2)L.mailing_address.zip4	,(UNSIGNED2)L.physical_address.zip4	);
		self.Company_RawAID				:= CHOOSE(CTR	,l.physical_RawAID									,l.mailing_RawAID										,l.mailing_RawAID										,l.physical_RawAID									);
		self.company_phone 				:= (UNSIGNED6)((UNSIGNED8)if(L.rawfields.address1.state <> '' or L.rawfields.address1.country = '', l.clean_phones.Phone, ''));
		self.company_fein 				:= 0;
		self.phone 								:= (UNSIGNED6)((UNSIGNED8)if(L.rawfields.address1.state <> '' or L.rawfields.address1.country = '', l.clean_phones.Phone, ''));
		self.email_address 				:= '';
		SELF.dt_first_seen 				:= l.date_first_seen	;
		SELF.dt_last_seen 				:= l.date_last_seen		;
		self.record_type 					:= 'C';
		self 											:= l;
	end;

	//--------------------------------------------
	// Normalize addresses
	//--------------------------------------------
	from_dca_norm := NORMALIZE(dca_contacts, 4, Translate_dca_To_BCF(LEFT, COUNTER));

	// Removed extra contacts with blank addresses
	from_dca_dist := distribute(from_dca_norm, hash(trim(vendor_id), trim(company_name)));

	from_dca_sort := sort(from_dca_dist, vendor_id, company_name,
						 fname, mname, lname, name_suffix, company_title, phone, if(zip <> 0, 0, 1), zip, prim_name, prim_range, 
						 local);

	from_dca_dedup := dedup(from_dca_sort,
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


	ddedup_filt := from_dca_dedup((integer)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix));

	dcompanies_slim := table(pCompaniesBase	,{qstring120 company_name := rawfields.name,qstring34 vendor_id := rawfields.enterprise_num,string60 email_address := rawfields.e_mail});
	
	dasbc := join(
		 ddedup_filt
		,dcompanies_slim
		,left.vendor_id = right.vendor_id
		,transform(recordof(ddedup_filt)
			,self.company_name 	:= right.company_name
			,self.email_address := right.email_address
			,self								:= left
		)
	);


	dasbc_persisted := dasbc : persist(pPersistname);
	dasbc_persist		:= pPersist;
	
	decision := map(
		 pTodo = 'R' => dasbc_persisted
		,pTodo = 'P' => dasbc_persist
		,pTodo = 'N' => dasbc
		,								dasbc_persisted
	);

	return decision;

end;
