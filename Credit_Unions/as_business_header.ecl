import mdr,business_header;

laybus := business_header.Layout_Business_Header_New;

export as_business_header(

	 boolean 								pUsingInBizHdr		= true
	,boolean 								pUseOtherEnviron	= _Constants().IsDataland
	,dataset(layouts.Base)	pDataset					= if(pUsingInBizHdr
																								,files(,pUseOtherEnviron).base.BusinessHeader
																								,files(,pUseOtherEnviron).base.qa
																							)
	,string1								pTodo							= 'R'	//'R' = recalculate persist,'P' = pull from persist(don't recalculate),'N' = Don't persist code
	,string									pPersistname			= persistnames(									).AsBusinessHeader
	,dataset(laybus				) pPersist 					= persists		(pUseOtherEnviron	).AsBusinessHeader
	
) :=
function

	dasbh := project(pDataset,transform(
		laybus,
		
		self.rcid                    := 0;
		self.bdid                    := 0;
		self.source                  := MDR.sourceTools.src_Credit_Unions;
		self.Source_Group            := trim(left.state) + left.charter;
		self.pflag                   := '';
		self.group1_id               := 0;
		self.vendor_id               := self.Source_Group;
		self.dt_first_seen           := 0;
		self.dt_last_seen            := 0;
		self.dt_vendor_first_reported:= left.dt_vendor_first_reported	;
		self.dt_vendor_last_reported := left.dt_vendor_last_reported	;
		self.company_name            := if(regexfind('(CREDIT UNION|CREDIT UN|C U | C U|C[.]U[.]|C[.] U[.])',left.cu_name,nocase)
																			,Stringlib.StringToUpperCase(left.CU_NAME)
																			,trim(Stringlib.StringToUpperCase(left.CU_NAME)) + ' CREDIT UNION'
																		);
		self.prim_range              := left.prim_range ;
		self.predir                  := left.predir     ;
		self.prim_name               := left.prim_name  ;
		self.addr_suffix             := left.addr_suffix;
		self.postdir                 := left.postdir    ;
		self.unit_desig              := left.unit_desig ;
		self.sec_range               := left.sec_range  ;
		self.city                    := left.v_city_name;
		self.state                   := left.st      		;
		self.zip                     := (unsigned3)left.zip       	;
		self.zip4                    := (unsigned2)left.zip4       	;
		self.county                  := left.fips_county ;
		self.msa                     := left.msa        ;
		self.geo_lat                 := left.geo_lat    ;
		self.geo_long                := left.geo_long   ;
		self.phone                   := (unsigned6)left.phone;
		self.phone_score             := if(self.phone = 0, 0, 1);
		self.fein                    := 0;
		self.current                 := if(left.record_type = 'C',true,false);
		self.DPPA                    := false;
		self.vl_id                   := self.Source_Group;
		self.RawAID                  := left.raw_aid;

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
