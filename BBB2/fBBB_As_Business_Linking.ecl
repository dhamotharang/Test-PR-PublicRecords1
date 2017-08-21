import business_header, business_header_ss, ut, mdr, _validate, lib_datalib;

export fBBB_As_Business_Linking(

	 dataset(Layouts_Files.Base.Member_BIP		)	pMemberBase
	,dataset(Layouts_Files.Base.NonMember_BIP	)	pNonMemberBase

):=
function

	Layout_Member_NonMember_Combine := 
	record
		Layouts_Files.Base.Member_BIP AND NOT [member_title,member_category];
		boolean is_member;
		string100	title;
		string100	category;
	end;
	
	Layout_Member_NonMember_Combine CombineMember(Layouts_Files.Base.Member_BIP L) := 
	transform
		self.is_member := TRUE;
	  self.title := L.member_title;
		self.category := L.member_category;
		self := L;
	end;

	Member_Init := project(pMemberBase(company_name <> ''), CombineMember(left));

	Layout_Member_NonMember_Combine CombineNonMember(pNonMemberBase L) := 
	transform
		self.is_member := FALSE;
	  self.title := L.non_member_title;
		self.category := L.non_member_category;
		self.member_since_date := '';
		self := L;
	end;

	NonMember_Init := project(pNonMemberBase(company_name <> ''), CombineNonMember(left));
  
	///////////////////////////////////////////////////////////////////////
	// -- Base Files Used
	///////////////////////////////////////////////////////////////////////	
	BBB_All_Base := Member_Init + NonMember_Init;

	///////////////////////////////////////////////////////////////////////
	// -- Convert File to Business Linking format
	///////////////////////////////////////////////////////////////////////
	business_header.Layout_Business_Linking.Company_ t2buslinkingformat(Layout_Member_NonMember_Combine pInput)
	 :=
	  transform
		self.source 					              := IF(pInput.is_member, 
		                                          MDR.sourceTools.src_BBB_Member,
																							MDR.sourceTools.src_BBB_Non_Member);  //  BBB Member or NonMember
		self.dt_first_seen 				          := if(_validate.date.fIsValid((STRING)pInput.date_first_seen),
		                                          pInput.date_first_seen, 0);
		self.dt_last_seen 				          := if(_validate.date.fIsValid((STRING)pInput.date_last_seen),
		                                          pInput.date_last_seen, 0);
		self.dt_vendor_first_reported 	    := if(_validate.date.fIsValid((STRING)pInput.dt_vendor_first_reported),
		                                          pInput.dt_vendor_first_reported, 0);
		self.dt_vendor_last_reported  	    := if(_validate.date.fIsValid((STRING)pInput.dt_vendor_last_reported),
		                                          pInput.dt_vendor_last_reported, 0);
		self.company_bdid 						      := pInput.bdid;
		self.company_name 			      	    := ut.CleanSpacesAndUpper(pInput.company_name);
		self.company_address.prim_range     := pInput.prim_range;
		self.company_address.predir         := pInput.predir;
		self.company_address.prim_name      := pInput.prim_name;
		self.company_address.addr_suffix    := pInput.addr_suffix;
		self.company_address.postdir        := pInput.postdir;
		self.company_address.unit_desig     := pInput.unit_desig;
		self.company_address.sec_range      := pInput.sec_range;
		self.company_address.p_city_name    := pInput.p_city_name;
		self.company_address.v_city_name    := pInput.v_city_name;
		self.company_address.st             := pInput.st;
		self.company_address.zip            := pInput.zip;
		self.company_address.zip4           := pInput.zip4;
		self.company_address.cart           := pInput.cart;
		self.company_address.cr_sort_sz     := pInput.cr_sort_sz;
		self.company_address.lot            := pInput.lot;
		self.company_address.lot_order      := pInput.lot_order;
		self.company_address.dbpc           := pInput.dbpc;
		self.company_address.chk_digit      := pInput.chk_digit;
		self.company_address.rec_type       := pInput.rec_type;
		self.company_address.fips_state     := pInput.fips_state;
		self.company_address.fips_county    := pInput.fips_county;
		self.company_address.geo_lat        := pInput.geo_lat;
		self.company_address.geo_long       := pInput.geo_long;
		self.company_address.msa            := pInput.msa;
		self.company_address.geo_blk        := pInput.geo_blk;
		self.company_address.geo_match      := pInput.geo_match;
		self.company_address.err_stat       := pInput.err_stat;
    self.company_phone                  := ut.CleanPhone(pInput.phone10);
    self.phone_type                     := IF((INTEGER)self.company_phone=0,'','T');
    self.company_foreign_domestic       := '';  //if(pInput.country = 'US','D','');;
		self.source_record_id								:= pInput.source_rec_id;
   	self.vl_id 			            		    := ''; //Mapping blank since the bbb_id is not persistent		
		self.current                     		:= IF(pInput.record_type='C',TRUE,FALSE); // Known values C, H, S & HD
		self.phone_score                 		:= IF((integer)self.company_phone=0,0,1);
		self 																:= pInput;
		self 																:= [];
  END;

	dBBBAsBusLnk				:=	project(BBB_All_Base,t2buslinkingformat(left));

	///////////////////////////////////////////////////////////////////////
	// -- Rollup BBB file
	///////////////////////////////////////////////////////////////////////
	BBB_rollup			    := fRollupBaseBusLnk(dBBBAsBusLnk);

	///////////////////////////////////////////////////////////////////////
	// -- Pass to As_Business_Linking_Function to cleanup company name
	//    and rollup
	///////////////////////////////////////////////////////////////////////
	
	RETURN	PROJECT(BBB_rollup,TRANSFORM({Business_Header.Layout_Business_Linking.Linking_Interface},
												               SELF:=LEFT,SELF:=[]));
 
END;