import mdr,business_header;

laybus := Business_Header.Layout_Business_Contact_Full_New;

export as_business_contact(

	 boolean 								pUsingInBizHdr		= true
	,boolean 								pUseOtherEnviron	= _Constants().IsDataland
	,dataset(layouts.Base)	pDataset					= if(pUsingInBizHdr
																								,files(,pUseOtherEnviron).base.BusinessHeader
																								,files(,pUseOtherEnviron).base.qa
																							)
	,string1								pTodo							= 'R'	//'R' = recalculate persist,'P' = pull from persist(don't recalculate),'N' = Don't persist code
	,string									pPersistname			= persistnames(									).AsBusinessContact
	,dataset(laybus				) pPersist 					= persists		(pUseOtherEnviron	).AsBusinessContact
	
) :=
function

	dasbh := project(pDataset,transform(
		laybus,
		
		self.bdid                     := 0;
		self.did                      := left.did;
		self.contact_score            := 0;
		self.vendor_id                := trim(left.state) + left.charter;
		self.dt_first_seen            := 0;
		self.dt_last_seen             := 0;
		self.source                   := MDR.sourceTools.src_Credit_Unions;
		self.record_type              := left.record_type;
		self.from_hdr                 := 'N';
		self.GLB                      := false;
		self.DPPA                     := false;
		self.company_title            := '';
		self.company_department       := '';
		self.Title                    := left.title			;
		self.fname                    := left.fname      ;
		self.mname                    := left.mname      ;
		self.lname                    := left.lname      ;
		self.name_suffix              := left.name_suffix;
		self.name_score               := left.name_score ;
		self.prim_range               := left.prim_range			;
		self.predir                   := left.predir    			;
		self.prim_name                := left.prim_name  		  ;
		self.addr_suffix              := left.addr_suffix		  ;
		self.postdir                  := left.postdir    		  ;
		self.unit_desig               := left.unit_desig 		  ;
		self.sec_range                := left.sec_range  		  ;
		self.city                     := left.v_city_name		  ;
		self.state                    := left.st      				;
		self.zip                      := (unsigned3)left.zip  ;
		self.zip4                     := (unsigned2)left.zip4 ;
		self.county                   := left.fips_county 		;
		self.msa                      := left.msa        		  ;
		self.geo_lat                  := left.geo_lat    		  ;
		self.geo_long                 := left.geo_long   		  ;
		self.phone                    := (unsigned6)left.phone		;
		self.email_address            := '';
		self.ssn                      := 0;
		self.company_source_group     := self.vendor_id;
		self.company_name            := if(regexfind('(CREDIT UNION|CREDIT UN|C U | C U|C[.]U[.]|C[.] U[.])',left.cu_name,nocase)
																			,Stringlib.StringToUpperCase(left.CU_NAME)
																			,trim(Stringlib.StringToUpperCase(left.CU_NAME)) + ' CREDIT UNION'
																		);
		self.company_prim_range       := left.prim_range			;
		self.company_predir           := left.predir    			;
		self.company_prim_name        := left.prim_name  		  ;
		self.company_addr_suffix      := left.addr_suffix		  ;
		self.company_postdir          := left.postdir    		  ;
		self.company_unit_desig       := left.unit_desig 		  ;
		self.company_sec_range        := left.sec_range  		  ;
		self.company_city             := left.v_city_name		  ;
		self.company_state            := left.st      				;
		self.company_zip              := (unsigned3)left.zip  ;
		self.company_zip4             := (unsigned2)left.zip4 ;
		self.company_phone            := (unsigned6)left.phone;
		self.company_fein             := 0;
		self.vl_id                    := self.vendor_id;
		self.RawAID                   := left.raw_aid;
		self.Company_RawAID           := left.raw_aid;

	));

	dasbh_persisted := dasbh : persist(pPersistname);
	dasbh_persist		:= pPersist;
	
	decision := map(
		 pTodo = 'R' => dasbh_persisted
		,pTodo = 'P' => dasbh_persist
		,pTodo = 'N' => dasbh
		,								dasbh_persisted
	);

	return decision;

end;
