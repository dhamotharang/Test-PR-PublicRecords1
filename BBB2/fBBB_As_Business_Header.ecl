import business_header,business_header_ss,ut,mdr;

export fBBB_As_Business_Header(

	 dataset(Layouts_Files.Base.Member_BIP		)	pMemberBase
	,dataset(Layouts_Files.Base.NonMember_BIP	)	pNonMemberBase

):=
function

	///////////////////////////////////////////////////////////////////////
	// -- Base Files Used
	///////////////////////////////////////////////////////////////////////
	BBB_Member_Base 	:= pMemberBase(company_name <> '');
	BBB_NonMember_Base 	:= pNonMemberBase(company_name <> '');

	///////////////////////////////////////////////////////////////////////
	// -- Add Unique ID field to Member Base File
	///////////////////////////////////////////////////////////////////////
	Layout_Member_Base_Local := 
	record
		unsigned6 record_id := 0;
		Layouts_Files.Base.Member_BIP;
	end;

	Layout_Member_Base_Local AddRecordID(Layouts_Files.Base.Member_BIP L) := 
	transform
		self := L;
	end;

	Member_Init := project(BBB_Member_Base, AddRecordID(left));

	///////////////////////////////////////////////////////////////////////
	// -- Add Unique ID field to Non Member Base File
	///////////////////////////////////////////////////////////////////////
	Layout_NonMember_Base_Local := 
	record
		unsigned6 record_id := 0;
		Layouts_Files.Base.NonMember_BIP;
	end;

	Layout_NonMember_Base_Local AddNonMemberRecordID(Layouts_Files.Base.NonMember_BIP L) := 
	transform
		self := L;
	end;

	Non_Member_Init := project(BBB_NonMember_Base, AddNonMemberRecordID(left));

	///////////////////////////////////////////////////////////////////////
	// -- Sequence Member and Non Member Files
	///////////////////////////////////////////////////////////////////////
	ut.MAC_Sequence_Records(Member_Init, record_id, Member_Seq)
	ut.MAC_Sequence_Records(Non_Member_Init, record_id, Non_Member_Seq)


	///////////////////////////////////////////////////////////////////////
	// -- Convert Member File to Business Header format
	///////////////////////////////////////////////////////////////////////
	business_header.Layout_Business_Header_New t2busheaderformat(Layout_Member_Base_Local pInput)
	 :=
	  transform
		self.source 					:=	MDR.sourceTools.src_BBB_Member;  //  BBB Member
		self.group1_id 					:=	pInput.record_id;
		self.dppa						:=	false;
		self.dt_first_seen 				:=	pInput.date_first_seen;
		self.dt_last_seen 				:=	pInput.date_last_seen;
		self.dt_vendor_last_reported  	:=	pInput.dt_vendor_last_reported;
		self.dt_vendor_first_reported 	:=	pInput.dt_vendor_first_reported;
		self.vl_id 					    :=  pInput.bbb_id;
		self.vendor_id 					:=	intformat(self.dt_vendor_last_reported, 8, 1) + '-' + pInput.bbb_id;
		self.source_group 				:=  '';
		self.prim_range 				:=	pInput.prim_range;
		self.predir 					:=	pInput.predir;
		self.prim_name 					:=	pInput.prim_name;
		self.addr_suffix 				:=	pInput.addr_suffix;
		self.postdir 					:=	pInput.postdir;
		self.unit_desig 				:=	pInput.unit_desig;
		self.sec_range 					:=	pInput.sec_range;
		self.city 						:=	pInput.v_city_name;
		self.state 						:=	pInput.st;
		self.zip 						:=	(unsigned3)pInput.zip;
		self.zip4 						:=	(unsigned2)pInput.zip4;
		self.county 					:=	pInput.fips_county;
		self.msa 						:=	pInput.msa;
		self.geo_lat 					:=	pInput.geo_lat;
		self.geo_long 					:=	pInput.geo_long;
		self.current 					:=	if(pInput.record_type = 'C', true, false);
		self.phone 						:=	(UNSIGNED6)((UNSIGNED8)pInput.phone10);
		self.phone_score 				:=  IF(self.phone = 0, 0, 1);
		self.company_name 				:=	pInput.company_name;
		self.bdid 						:=	pInput.bdid;
	  end
	 ;

	dBBBAsBusHdr				:=	project(Member_Seq,t2busheaderformat(left));

	///////////////////////////////////////////////////////////////////////
	// -- Convert Non Member File to Business Header format
	///////////////////////////////////////////////////////////////////////
	business_header.Layout_Business_Header_New t2busheaderformat_non_member(Layout_NonMember_Base_Local pInput)
	 :=
	  transform
		self.source 					:=	MDR.sourceTools.src_BBB_Non_Member;  //  BBB Non-Member
		self.group1_id 					:=	pInput.record_id;
		self.dppa						:=	false;
		self.dt_first_seen 				:=	pInput.date_first_seen;
		self.dt_last_seen 				:=	pInput.date_last_seen;
		self.dt_vendor_last_reported  	:=	pInput.dt_vendor_last_reported;
		self.dt_vendor_first_reported 	:=	pInput.dt_vendor_first_reported;
		self.vl_id 					    :=  intformat(self.dt_vendor_last_reported, 8, 1) + '-' + pInput.bbb_id;
		self.vendor_id 					:=	intformat(self.dt_vendor_last_reported, 8, 1) + '-' + pInput.bbb_id;
		self.source_group 				:=  '';
		self.prim_range 				:=	pInput.prim_range;
		self.predir 					:=	pInput.predir;
		self.prim_name 					:=	pInput.prim_name;
		self.addr_suffix 				:=	pInput.addr_suffix;
		self.postdir 					:=	pInput.postdir;
		self.unit_desig 				:=	pInput.unit_desig;
		self.sec_range 					:=	pInput.sec_range;
		self.city 						:=	pInput.p_city_name;
		self.state 						:=	pInput.st;
		self.zip 						:=	(unsigned3)pInput.zip;
		self.zip4 						:=	(unsigned2)pInput.zip4;
		self.county 					:=	pInput.fips_county;
		self.msa 						:=	pInput.msa;
		self.geo_lat 					:=	pInput.geo_lat;
		self.geo_long 					:=	pInput.geo_long;
		self.current 					:=	if(pInput.record_type = 'C', true, false);
		self.phone 						:=	(UNSIGNED6)((UNSIGNED8)pInput.phone10);
		self.phone_score 				:=  IF(self.phone = 0, 0, 1);
		self.company_name 				:=	pInput.company_name;
		self.bdid 						:=	pInput.bdid;
	  end
	 ;

	dBBB_Non_Member_AsBusHdr		:=	project(Non_Member_Seq,t2busheaderformat_non_member(left));

	///////////////////////////////////////////////////////////////////////
	// -- Pass Both to As Business Header function
	///////////////////////////////////////////////////////////////////////
	BBB_clean_rollup			:= Business_Header.As_Business_Header_Function(dBBBAsBusHdr, false, false);
	BBB_Non_Member_clean_rollup := Business_Header.As_Business_Header_Function(dBBB_Non_Member_AsBusHdr, false, false);


	return	BBB_clean_rollup + BBB_Non_Member_clean_rollup;
 
end;