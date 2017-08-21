import address,Gong_v2;
/*
	This appends the work phone by bdid
*/
export Append_Work_Phone(

	 dataset(Layouts.Base									) pBell_Thrive
	,dataset(Gong_v2.layout_gongMasterAid	) pGongMasterBase	= Gong_v2.Files().base.gongmaster.root
	,string																	pPersistname		= persistnames().AppendWorkPhone

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
	dGongMasterBase_filt := project(pGongMasterBase(listing_type_bus = 'B',current_record_flag = 'Y', bdid != 0),
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
		
	dGongMasterBase_dedup := dedup(sort(distribute(dGongMasterBase_filt	,bdid),bdid,-dt_first_seen,local),bdid, local);
	
	pBell_Thrive_withphone 		:= pBell_Thrive(not(bdid != 0 and (unsigned5)clean_phones.phone_work  = 0));
	pBell_Thrive_withoutphone := pBell_Thrive(bdid != 0,(unsigned5)clean_phones.phone_work  = 0);
	
	//join Bell_Thrive to gong master on company phone, taking latest record
	djoin2gong := join(
		 distribute(pBell_Thrive_withoutphone				,bdid)
		,dGongMasterBase_dedup
		,left.bdid = right.bdid
		,transform(
			Layouts.Base,
				self.clean_phones.phone_work			:= (string10)right.company_phone					;
				self								 							:= left																		;
		)
		,local
		,left outer
	);

	dconcat := djoin2gong + pBell_Thrive_withphone 
	: persist(pPersistname);

	return dconcat;

end;