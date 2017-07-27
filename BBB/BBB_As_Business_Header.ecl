import business_header,business_header_ss,ut,mdr;



dBBB	:= bbb.File_BBB_Base;
dBBBWithCompany := dBBB(company_name <> '');

dBBB_Non_Member := bbb.File_BBB_Non_Member_Base;
dBBB_Non_Member_WithCompany := dBBB_Non_Member(company_name <> '');


Layout_BBB_Local := record
unsigned6 record_id := 0;
Layout_BBB_Base;
end;

// Add unique record id to BBB file
Layout_BBB_Local AddRecordID(Layout_BBB_Base L) := transform
self := L;
end;

BBB_Init := project(dBBBWithCompany, AddRecordID(left));

Layout_BBB_Non_Member_Local := record
unsigned6 record_id := 0;
Layout_BBB_Non_Member_Base;
end;

// Add unique record id to BBB file
Layout_BBB_Non_Member_Local AddNonMemberRecordID(Layout_BBB_Non_Member_Base L) := transform
self := L;
end;

BBB_Non_Member_Init := project(dBBB_Non_Member_WithCompany, AddNonMemberRecordID(left));

ut.MAC_Sequence_Records(BBB_Init, record_id, BBB_Seq)
ut.MAC_Sequence_Records(BBB_Non_Member_Init, record_id, BBB_Non_Member_Seq)


business_header.Layout_Business_Header t2busheaderformat(Layout_BBB_Local pInput)
 :=
  transform
	self.source 					:=	'BM';  //  BBB Member
	self.group1_id 					:=	pInput.record_id;
	self.dppa						:=	false;
	self.dt_first_seen 				:=	if((integer)business_header.validatedate(pInput.member_since_date) = 0, 
										(integer)business_header.validatedate(pInput.report_date),
										(integer)business_header.validatedate(pInput.member_since_date));
	self.dt_last_seen 				:=	if((integer)business_header.validatedate(pInput.report_date) = 0, self.dt_first_seen,
										(integer)business_header.validatedate(pInput.report_date));
	self.dt_vendor_last_reported  	:=	(integer)business_header.validatedate(pInput.report_date);
	self.dt_vendor_first_reported 	:=	self.dt_vendor_last_reported;
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
	self.current 					:=	true;
	self.phone 						:=	(UNSIGNED6)((UNSIGNED8)pInput.phone10);
    self.phone_score 				:=  IF(self.phone = 0, 0, 1);
	self.company_name 				:=	pInput.company_name;
	self.bdid 						:=	pInput.bdid;
  end
 ;

dBBBAsBusHdr				:=	project(BBB_Seq,t2busheaderformat(left));

business_header.Layout_Business_Header t2busheaderformat_non_member(Layout_BBB_Non_Member_Local pInput)
 :=
  transform
	self.source 					:=	'BN';  //  BBB Non-Member
	self.group1_id 					:=	pInput.record_id;
	self.dppa						:=	false;
	self.dt_first_seen 				:=	(integer)business_header.validatedate(pInput.report_date);
	self.dt_last_seen 				:=	(integer)business_header.validatedate(pInput.report_date);
	self.dt_vendor_last_reported  	:=	(integer)business_header.validatedate(pInput.report_date);
	self.dt_vendor_first_reported 	:=	self.dt_vendor_last_reported;
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
	self.current 					:=	true;
	self.phone 						:=	(UNSIGNED6)((UNSIGNED8)pInput.phone10);
    self.phone_score 				:=  IF(self.phone = 0, 0, 1);
	self.company_name 				:=	pInput.company_name;
	self.bdid 						:=	pInput.bdid;
  end
 ;

dBBB_Non_Member_AsBusHdr		:=	project(BBB_Non_Member_Seq,t2busheaderformat_non_member(left));

BBB_clean_rollup := Business_Header.As_Business_Header_Function(dBBBAsBusHdr, false, false);
BBB_Non_Member_clean_rollup := Business_Header.As_Business_Header_Function(dBBB_Non_Member_AsBusHdr, false, false);


export BBB_As_Business_Header
 :=	BBB_clean_rollup + BBB_Non_Member_clean_rollup
 :	persist('persist::bushdr_BBB_as_bus_hdr')
 ;
