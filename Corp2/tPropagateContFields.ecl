export Layout_Corporate_Direct_Cont_AID tPropagateContFields(

	 Layout_Corporate_Direct_Cont_AID	l
	,Layout_Corporate_Direct_Cont_AID	r
	,unsigned4													cnt 

) := 
transform

	IsRegisteredAgent := 			regexfind('REGISTERED AGENT'	,l.cont_type_desc					,nocase)
												or	regexfind('REGISTERED AGENT'	,l.cont_title_desc				,nocase)
												or	regexfind('REGISTERED AGENT'	,l.cont_address_type_desc	,nocase)
												or	regexfind('^RA$'							,l.cont_type_cd						,nocase)
												or	cnt = 1
												;

	PropagateField(address_type) := 
		(address_type = 1 and (cnt = 1 or (r.corp_address1_effective_date <> '' or r.corp_address1_line1 <> '' or r.corp_address1_line2 <> ''))) or
		(address_type = 2 and (IsRegisteredAgent or (r.cont_effective_date <> '' or r.cont_address_line1 <> '' or r.cont_address_line2 <> '')));

	cCorp_address(string pright, string pleft) := if(cnt = 1 or (r.corp_address1_effective_date <> '' or r.corp_address1_line1 <> '' or r.corp_address1_line2 <> '')
		,pright
		,pleft
	);

	cCorp_phone(string pright, string pleft) := if(cnt = 1 or r.corp_phone_number <> ''
		,pright
		,pleft
	);
	
	cCont_filing(string pright, string pleft) := if(IsRegisteredAgent or (r.cont_filing_reference_nbr <> '' or r.cont_filing_date <> '' or r.cont_filing_cd <> '' or r.cont_filing_desc <> '')
		,pright
		,pleft
	);

	cCont_type(string pright, string pleft) := if(IsRegisteredAgent or (r.cont_type_cd <> '' or r.cont_type_desc <> '')
		,pright
		,pleft
	);

	cCont_Name(string pright, string pleft) := if(IsRegisteredAgent or (r.cont_name <> '' or r.cont_effective_date <> '')
		,pright
		,pleft
	);

	cCont_Address(string pright, string pleft) := if(IsRegisteredAgent or (r.cont_name <> '' or r.cont_effective_date <> '' or r.cont_address_effective_date <> '' or r.cont_address_line1 <> '' or r.cont_address_line2 <> '')
		,pright
		,pleft
	);

	cCont_Phone(string pright, string pleft) := if(IsRegisteredAgent or (r.cont_name <> '' or r.cont_effective_date <> '' or r.cont_phone_number <> '')
		,pright
		,pleft
	);

self.corp_vendor 									:= if(cnt = 1 or r.corp_vendor 			<> '', r.corp_vendor		, l.corp_vendor			);
self.corp_legal_name							:= if(cnt = 1 or r.corp_legal_name	<> '', r.corp_legal_name, l.corp_legal_name	);

// check to propagate corp address1
self.corp_address1_type_cd 				:= cCorp_address(r.corp_address1_type_cd				,l.corp_address1_type_cd				);
self.corp_address1_type_desc			:= cCorp_address(r.corp_address1_type_desc			,l.corp_address1_type_desc			);
self.corp_address1_line1 					:= cCorp_address(r.corp_address1_line1					,l.corp_address1_line1					);
self.corp_address1_line2 					:= cCorp_address(r.corp_address1_line2					,l.corp_address1_line2					);
self.corp_address1_line3 					:= cCorp_address(r.corp_address1_line3					,l.corp_address1_line3					);
self.corp_address1_line4 					:= cCorp_address(r.corp_address1_line4					,l.corp_address1_line4					);
self.corp_address1_line5 					:= cCorp_address(r.corp_address1_line5					,l.corp_address1_line5					);
self.corp_address1_line6 					:= cCorp_address(r.corp_address1_line6					,l.corp_address1_line6					);
self.corp_address1_effective_date := cCorp_address(r.corp_address1_effective_date	,l.corp_address1_effective_date	);

// check to propagate phone number
self.corp_phone_number  					:= cCorp_phone( r.corp_phone_number						,l.corp_phone_number						);
self.corp_phone_number_type_cd  	:= cCorp_phone( r.corp_phone_number_type_cd		,l.corp_phone_number_type_cd		);
self.corp_phone_number_type_desc  := cCorp_phone( r.corp_phone_number_type_desc	,l.corp_phone_number_type_desc	);
                                           
//corp email, web
self.corp_email_address 					:= if(cnt = 1 or r.corp_email_address	<> ''	,r.corp_email_address	,l.corp_email_address	);
self.corp_web_address							:= if(cnt = 1 or r.corp_web_address 	<> ''	,r.corp_web_address		,l.corp_web_address		);

// check to propagate cont filing info
self.cont_filing_reference_nbr 		:= cCont_filing(r.cont_filing_reference_nbr	,l.cont_filing_reference_nbr	);
self.cont_filing_date 						:= cCont_filing(r.cont_filing_date					,l.cont_filing_date						);
self.cont_filing_cd 							:= cCont_filing(r.cont_filing_cd						,l.cont_filing_cd							);
self.cont_filing_desc 						:= cCont_filing(r.cont_filing_desc					,l.cont_filing_desc						);

// check to propagate type info
self.cont_type_cd									:= cCont_type(r.cont_type_cd		,l.cont_type_cd		);
self.cont_type_desc 							:= cCont_type(r.cont_type_desc	,l.cont_type_desc	);

// check to propagate contact name info
self.cont_name 										:= cCont_Name(r.cont_name						,l.cont_name						);
self.cont_title_desc 							:= cCont_Name(r.cont_title_desc			,l.cont_title_desc			);
self.cont_fein 										:= cCont_Name(r.cont_fein						,l.cont_fein						);
self.cont_ssn 										:= cCont_Name(r.cont_ssn						,l.cont_ssn							);
self.cont_dob 										:= cCont_Name(r.cont_dob						,l.cont_dob							);
self.cont_effective_date 					:= cCont_Name(r.cont_effective_date	,l.cont_effective_date	);

// check to propagate contact address info
self.cont_address_type_cd 				:= cCont_Address(r.cont_address_type_cd					,l.cont_address_type_cd					);
self.cont_address_type_desc 			:= cCont_Address(r.cont_address_type_desc				,l.cont_address_type_desc				);
self.cont_address_line1 					:= cCont_Address(r.cont_address_line1						,l.cont_address_line1						);
self.cont_address_line2 					:= cCont_Address(r.cont_address_line2						,l.cont_address_line2						);
self.cont_address_line3 					:= cCont_Address(r.cont_address_line3						,l.cont_address_line3						);
self.cont_address_line4 					:= cCont_Address(r.cont_address_line4						,l.cont_address_line4						);
self.cont_address_line5 					:= cCont_Address(r.cont_address_line5						,l.cont_address_line5						);
self.cont_address_line6 					:= cCont_Address(r.cont_address_line6						,l.cont_address_line6						);
self.cont_address_effective_date	:= cCont_Address(r.cont_address_effective_date	,l.cont_address_effective_date	);

// check to propagate contact phone info
self.cont_phone_number 						:= cCont_Phone(r.cont_phone_number						, l.cont_phone_number						);
self.cont_phone_number_type_cd		:= cCont_Phone(r.cont_phone_number_type_cd		, l.cont_phone_number_type_cd		);
self.cont_phone_number_type_desc	:= cCont_Phone(r.cont_phone_number_type_desc	, l.cont_phone_number_type_desc	);

self.cont_email_address						:= if(IsRegisteredAgent or (r.cont_name <> '' or r.cont_effective_date <> '' or r.cont_email_address	<> '')	,r.cont_email_address	,l.cont_email_address	);
self.cont_web_address							:= if(IsRegisteredAgent or (r.cont_name <> '' or r.cont_effective_date <> '' or r.cont_web_address 		<> '')	,r.cont_web_address		,l.cont_web_address		);

// Check to propagate clean corporate addresses
self.corp_addr1_prim_range          := if(PropagateField(1), r.corp_addr1_prim_range         ,l.corp_addr1_prim_range);
self.corp_addr1_predir              := if(PropagateField(1), r.corp_addr1_predir             ,l.corp_addr1_predir);
self.corp_addr1_prim_name           := if(PropagateField(1), r.corp_addr1_prim_name          ,l.corp_addr1_prim_name);
self.corp_addr1_addr_suffix         := if(PropagateField(1), r.corp_addr1_addr_suffix        ,l.corp_addr1_addr_suffix);
self.corp_addr1_postdir             := if(PropagateField(1), r.corp_addr1_postdir            ,l.corp_addr1_postdir);
self.corp_addr1_unit_desig          := if(PropagateField(1), r.corp_addr1_unit_desig         ,l.corp_addr1_unit_desig);
self.corp_addr1_sec_range           := if(PropagateField(1), r.corp_addr1_sec_range          ,l.corp_addr1_sec_range);
self.corp_addr1_p_city_name         := if(PropagateField(1), r.corp_addr1_p_city_name        ,l.corp_addr1_p_city_name);
self.corp_addr1_v_city_name         := if(PropagateField(1), r.corp_addr1_v_city_name        ,l.corp_addr1_v_city_name);
self.corp_addr1_state               := if(PropagateField(1), r.corp_addr1_state              ,l.corp_addr1_state);
self.corp_addr1_zip5                := if(PropagateField(1), r.corp_addr1_zip5               ,l.corp_addr1_zip5);
self.corp_addr1_zip4                := if(PropagateField(1), r.corp_addr1_zip4               ,l.corp_addr1_zip4);
self.corp_addr1_cart                := if(PropagateField(1), r.corp_addr1_cart               ,l.corp_addr1_cart);
self.corp_addr1_cr_sort_sz          := if(PropagateField(1), r.corp_addr1_cr_sort_sz         ,l.corp_addr1_cr_sort_sz);
self.corp_addr1_lot                 := if(PropagateField(1), r.corp_addr1_lot                ,l.corp_addr1_lot);
self.corp_addr1_lot_order           := if(PropagateField(1), r.corp_addr1_lot_order          ,l.corp_addr1_lot_order);
self.corp_addr1_dpbc                := if(PropagateField(1), r.corp_addr1_dpbc               ,l.corp_addr1_dpbc);
self.corp_addr1_chk_digit           := if(PropagateField(1), r.corp_addr1_chk_digit          ,l.corp_addr1_chk_digit);
self.corp_addr1_rec_type            := if(PropagateField(1), r.corp_addr1_rec_type           ,l.corp_addr1_rec_type);
self.corp_addr1_ace_fips_st         := if(PropagateField(1), r.corp_addr1_ace_fips_st        ,l.corp_addr1_ace_fips_st);
self.corp_addr1_county              := if(PropagateField(1), r.corp_addr1_county             ,l.corp_addr1_county);
self.corp_addr1_geo_lat             := if(PropagateField(1), r.corp_addr1_geo_lat            ,l.corp_addr1_geo_lat);
self.corp_addr1_geo_long            := if(PropagateField(1), r.corp_addr1_geo_long           ,l.corp_addr1_geo_long);
self.corp_addr1_msa                 := if(PropagateField(1), r.corp_addr1_msa                ,l.corp_addr1_msa);
self.corp_addr1_geo_blk             := if(PropagateField(1), r.corp_addr1_geo_blk            ,l.corp_addr1_geo_blk);
self.corp_addr1_geo_match           := if(PropagateField(1), r.corp_addr1_geo_match          ,l.corp_addr1_geo_match);
self.corp_addr1_err_stat            := if(PropagateField(1), r.corp_addr1_err_stat           ,l.corp_addr1_err_stat);
// Check to propagate clean contact names
self.cont_title 			:= cCont_Name(r.cont_title				,l.cont_title				);
self.cont_fname 			:= cCont_Name(r.cont_fname				,l.cont_fname				);
self.cont_mname 			:= cCont_Name(r.cont_mname				,l.cont_mname				);
self.cont_lname 			:= cCont_Name(r.cont_lname				,l.cont_lname				);
self.cont_name_suffix := cCont_Name(r.cont_name_suffix	,l.cont_name_suffix	);
self.cont_score 			:= cCont_Name(r.cont_score				,l.cont_score				);
self.cont_cname 			:= cCont_Name(r.cont_cname				,l.cont_cname				);
self.cont_cname_score := cCont_Name(r.cont_cname_score	,l.cont_cname_score	);
// Check to propagate clean contact address
self.cont_prim_range                := if(PropagateField(2), r.cont_prim_range               ,l.cont_prim_range);
self.cont_predir                    := if(PropagateField(2), r.cont_predir                   ,l.cont_predir);
self.cont_prim_name                 := if(PropagateField(2), r.cont_prim_name                ,l.cont_prim_name);
self.cont_addr_suffix               := if(PropagateField(2), r.cont_addr_suffix              ,l.cont_addr_suffix);
self.cont_postdir                   := if(PropagateField(2), r.cont_postdir                  ,l.cont_postdir);
self.cont_unit_desig                := if(PropagateField(2), r.cont_unit_desig               ,l.cont_unit_desig);
self.cont_sec_range                 := if(PropagateField(2), r.cont_sec_range                ,l.cont_sec_range);
self.cont_p_city_name               := if(PropagateField(2), r.cont_p_city_name              ,l.cont_p_city_name);
self.cont_v_city_name               := if(PropagateField(2), r.cont_v_city_name              ,l.cont_v_city_name);
self.cont_state                     := if(PropagateField(2), r.cont_state                    ,l.cont_state);
self.cont_zip5                      := if(PropagateField(2), r.cont_zip5                     ,l.cont_zip5);
self.cont_zip4                      := if(PropagateField(2), r.cont_zip4                     ,l.cont_zip4);
self.cont_cart                      := if(PropagateField(2), r.cont_cart                     ,l.cont_cart);
self.cont_cr_sort_sz                := if(PropagateField(2), r.cont_cr_sort_sz               ,l.cont_cr_sort_sz);
self.cont_lot                       := if(PropagateField(2), r.cont_lot                      ,l.cont_lot);
self.cont_lot_order                 := if(PropagateField(2), r.cont_lot_order                ,l.cont_lot_order);
self.cont_dpbc                      := if(PropagateField(2), r.cont_dpbc                     ,l.cont_dpbc);
self.cont_chk_digit                 := if(PropagateField(2), r.cont_chk_digit                ,l.cont_chk_digit);
self.cont_rec_type                  := if(PropagateField(2), r.cont_rec_type                 ,l.cont_rec_type);
self.cont_ace_fips_st               := if(PropagateField(2), r.cont_ace_fips_st              ,l.cont_ace_fips_st);
self.cont_county                    := if(PropagateField(2), r.cont_county                   ,l.cont_county);
self.cont_geo_lat                   := if(PropagateField(2), r.cont_geo_lat                  ,l.cont_geo_lat);
self.cont_geo_long                  := if(PropagateField(2), r.cont_geo_long                 ,l.cont_geo_long);
self.cont_msa                       := if(PropagateField(2), r.cont_msa                      ,l.cont_msa);
self.cont_geo_blk                   := if(PropagateField(2), r.cont_geo_blk                  ,l.cont_geo_blk);
self.cont_geo_match                 := if(PropagateField(2), r.cont_geo_match                ,l.cont_geo_match);
self.cont_err_stat                  := if(PropagateField(2), r.cont_err_stat                 ,l.cont_err_stat);
self := r;
end;