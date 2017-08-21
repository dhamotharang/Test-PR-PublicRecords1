import Business_Header, ut,address,gong_v2;

export fAs_Business_Contact_Jigsaw(

	 dataset(Layouts.Base									) pInput							= Files().base.qa
	,dataset(Gong_v2.layout_gongMasterAid	) pGongMasterBase			= Gong_v2.Files().base.gongmaster.root
	,boolean																pShouldVerifyPhones = true

) :=
function

	layouts.Temporary.Jigsaw_UniqueId AddRecordID(Layouts.Base L) := 
	transform
		self := L;
		self.unique_id := 0;
	end;

	Jigsaw_Init := PROJECT(pInput, AddRecordID(LEFT));

	ut.MAC_Sequence_Records(Jigsaw_Init, unique_id, Jigsaw_Seq);
	Jigsaw_Seq_global := Jigsaw_Seq : global;
	
	//verify phones since they are unreliable
	Jigsaw_base_bdid	:= Verify_Phone(Jigsaw_Seq_global,pGongMasterBase,'B');
	Jigsaw_base_did 	:= Verify_Phone(Jigsaw_Seq_global,pGongMasterBase,'P');

	dputphonestogether := join(
		 Jigsaw_base_bdid
		,Jigsaw_base_did
		,left.unique_id = right.unique_id
		,transform(
			layouts.Temporary.Jigsaw_twophone,
			self.business_phone	:= (unsigned6)left.rawfields.Phone;
			self.person_phone		:= (unsigned6)right.rawfields.Phone;
			self								:= left;
		)
	);
	Jigsaw_Seq_global_proj := project(Jigsaw_Seq_global	,transform(layouts.Temporary.Jigsaw_twophone, self.business_phone := (unsigned6)left.rawfields.Phone;self.person_phone := (unsigned6)left.rawfields.Phone;self := left));
	
	djigsaw_should := if(pShouldVerifyPhones = true	,dputphonestogether	,Jigsaw_Seq_global_proj);

	layout_BH_contact 	:= Business_Header.Layout_Business_Contact_Full_New;

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Map to Business Contact Layout
	//////////////////////////////////////////////////////////////////////////////////////////////
	layout_BH_contact tbusiness_contact(layouts.Temporary.Jigsaw_twophone l) :=
	transform
	    		
	
		self.vendor_id			  := l.rawfields.CompanyId + '-' + l.rawfields.ContactId;
		self.vl_id			      := l.rawfields.CompanyId + '-' + l.rawfields.ContactId;
		self.dt_first_seen		  := l.dt_first_seen;
		self.dt_last_seen		  := l.dt_last_seen;
		self.source               := Source_Codes.Jigsaw;
		self.record_type          := l.record_type;
		self.from_hdr             := 'N';
		self.glb                  := false;
		self.dppa			      := false;
		self.company_title        := '';
		self.company_department   := '';
		self.title                := l.clean_name.title;
		self.fname                := l.clean_name.fname;
		self.mname				  := l.clean_name.mname;
		self.lname                := l.clean_name.lname;
		self.name_suffix          := l.clean_name.name_suffix;
		self.name_score           := Business_Header.CleanName(self.fname,self.mname,self.lname,self.name_suffix)[142];
		self.prim_range           := L.Clean_address.prim_range;                   
		self.predir				  := L.Clean_address.predir;
		self.prim_name            := L.Clean_address.prim_name;
		self.addr_suffix          := L.Clean_address.addr_suffix;
		self.postdir              := L.Clean_address.postdir;
		self.unit_desig           := L.Clean_address.unit_desig;
		self.sec_range			  := L.Clean_address.sec_range;
		self.city                 := L.Clean_address.v_city_name;
		self.state                := L.Clean_address.st;
		self.zip                  := (UNSIGNED3)L.Clean_address.zip;
		self.zip4                 := (UNSIGNED2)L.Clean_address.zip4;
		self.county				  := L.Clean_address.fips_county;
		self.msa                  := L.Clean_address.msa;
		self.geo_lat              := L.Clean_address.geo_lat;
		self.geo_long             := L.Clean_address.geo_long;
		self.phone                := l.person_phone; 
		self.email_address				:= '';
		self.ssn                  := 0;
		self.company_source_group := l.rawfields.CompanyId;
		self.company_name         := l.rawfields.CompanyName;
		
		self.company_prim_range   := L.Clean_address.prim_range;
		self.company_predir		  := L.Clean_address.predir;
		self.company_prim_name    := L.Clean_address.prim_name;
		self.company_addr_suffix  := L.Clean_address.addr_suffix;
		self.company_postdir      := L.Clean_address.postdir;
		self.company_unit_desig   := L.Clean_address.unit_desig;
		self.company_sec_range	  := L.Clean_address.sec_range;
		self.company_city         := L.Clean_address.v_city_name;
		self.company_state        := L.Clean_address.st;
		self.company_zip          := (UNSIGNED3)L.Clean_address.zip;
		self.company_zip4         := (UNSIGNED2)L.Clean_address.zip4;
		self.company_phone				:= l.business_phone;
		self.company_fein					:= 0;
		self := [];
	end;

	asbc := project( djigsaw_should(rawfields.CompanyName != ''),tbusiness_contact(LEFT));

	return	asbc( (integer)name_score < 2		//changed(lowered from 3) for this dataset after looking at the data
				 ,Business_Header.CheckPersonName(fname, mname, lname, name_suffix)
				 ,company_name				!= ''
				 ,ut.IsCompany(company_name)
				 ,prim_name					!= ''
				 ,company_prim_name	!= ''
				 ); 


end;