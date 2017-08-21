import address,Gong_v2;
/*
	This is for datasets that go into POE that don't have company info already, but have a work phone.  It will append the company info for them to get ready for ingestion into POE
	need to add yellowpages too
*/
export Append_EDA(

	 dataset(Layouts.Base									) pPOE
	,dataset(Gong_v2.layout_gongMasterAid	) pGongMasterBase	= Gong_v2.Files().base.gongmaster.root
	,string																	pPersistname		= persistnames().AppendEDA

) :=
function
	
	lay_gong_slim := record
		unsigned4  									dt_first_seen							;
		unsigned6  									bdid											;
		string120  									company_name							;
		Address.Layout_Clean_Slim		company_address						;
		unsigned5  									company_phone							;
		unsigned4  									company_fein							;
		unsigned8										company_rawaid				:= 0;
		unsigned8										company_aceaid				:= 0;
	end;
	
	// phones in gong master file are not unique
	dGongMasterBase_filt := project(pGongMasterBase(listing_type_bus = 'B',current_record_flag = 'Y'),
		transform(lay_gong_slim,
			self.dt_first_seen								:= if((unsigned4)left.dt_last_seen > 0	,(unsigned4)left.dt_last_seen	,(unsigned4)left.dt_first_seen);
			self.bdid													:= left.bdid							;
			self.company_name 								:= left.company_name			;
			self.company_address.prim_range		:= left.prim_range				;
			self.company_address.predir			 	:= left.predir						;
			self.company_address.prim_name		:= left.prim_name					;
			self.company_address.addr_suffix	:= left.suffix						;
			self.company_address.postdir			:= left.postdir						;
			self.company_address.unit_desig	 	:= left.unit_desig				;
			self.company_address.sec_range		:= left.sec_range					;
			self.company_address.city_name		:= left.v_city_name				;
			self.company_address.st					 	:= left.st								;
			self.company_address.zip					:= left.z5								;
			self.company_address.zip4				 	:= left.z4								;
			self.company_phone	 							:= (unsigned5)left.phone10;
			self.company_fein	 								:= 0											;
			self.company_rawaid 							:= left.rawaid						;	
			self.company_aceaid 							:= 0											;
			
		));
		
	dGongMasterBase_dedup := dedup(sort(distribute(dGongMasterBase_filt	,company_phone),company_phone,-dt_first_seen,local),company_phone, local);
	
	pPOE_withphone 		:= pPOE(company_phone != 0);
	pPOE_withoutphone := pPOE(company_phone  = 0);
	
	//join poe to gong master on company phone, taking latest record
	djoin2gong := join(
		 distribute(pPOE_withphone				,company_phone)
		,dGongMasterBase_dedup
		,left.company_phone = right.company_phone
		,transform(
			Layouts.Base,
				self.bdid					 								:= right.bdid															;
				self.company_name 								:= right.company_name											;
				self.company_address.prim_range		:= right.company_address.prim_range				;
				self.company_address.predir			 	:= right.company_address.predir			 			;
				self.company_address.prim_name		:= right.company_address.prim_name				;
				self.company_address.addr_suffix	:= right.company_address.addr_suffix			;
				self.company_address.postdir			:= right.company_address.postdir					;
				self.company_address.unit_desig	 	:= right.company_address.unit_desig	 			;
				self.company_address.sec_range		:= right.company_address.sec_range				;
				self.company_address.city_name		:= right.company_address.city_name				;
				self.company_address.st					 	:= right.company_address.st					 			;
				self.company_address.zip					:= right.company_address.zip							;
				self.company_address.zip4				 	:= right.company_address.zip4				 			;
				self.company_phone	 							:= right.company_phone										;
				self.company_rawaid 							:= right.company_rawaid										;	
				self								 							:= left																		;
		)
		,local
		,left outer
	);

	dconcat := djoin2gong + pPOE_withoutphone 
	: persist(pPersistname);

	return dconcat;

end;