import dnb_dmi, Business_Header, Business_Header_SS, MDR, ut;
Inputfile := choosen(dnb_dmi.Files().base.companies.qa,20);//just 20 records or less is fine.  Inline dataset would be great, but a project of a choosen of something available on thor would be fine too
BDID_Matchset := ['A','P'];

/* ********
  FIRST, LET'S DO THE OLD SCHOOL CALLS WITH THESE SETTINGS
******** */
OLD_outrec := dnb_dmi.Layouts.Temporary.BdidSlim;

// END SETTINGS

Business_Header.MAC_Source_Match(
	 Inputfile														// infile
	,dSourceMatchOut											// outfile
	,FALSE																// bool_bdid_field_is_string12
	,bdid																	// bdid_field
	,FALSE																// bool_infile_has_source_field
	,MDR.sourceTools.src_Dunn_Bradstreet	// source_type_or_field
	,TRUE																	// bool_infile_has_source_group
	,rawfields.duns_number								// source_group_field
	,rawfields.business_name							// company_name_field
	,clean_address.prim_range							// prim_range_field
	,clean_address.prim_name							// prim_name_field
	,clean_address.sec_range							// sec_range_field
	,clean_address.zip										// zip_field
	,TRUE																	// bool_infile_has_phone
	,rawfields.telephone_number						// phone_field
	,FALSE																// bool_infile_has_fein
	,fein_field														// fein_field
	,TRUE																	// bool_infile_has_vendor_id	= 'false'
	,rawfields.duns_number								// vendor_id_field						= 'vendor_id'
);

dnb_dmi.Layouts.Temporary.BdidSlim tSlimForBdiding(dnb_dmi.Layouts.Base.Companies l) :=
transform

	self.unique_id		:= l.rid																;
	self.company_name	:= if(l.rawfields.trade_style = '' or (l.rawfields.trade_style <> '' and l.rawfields.parent_duns_number = '' and l.rawfields.ultimate_duns_number = ''),
														Stringlib.StringToUpperCase(l.rawfields.business_name),
														Stringlib.StringToUpperCase(l.rawfields.trade_style));
	self.prim_range		:= l.Clean_address.prim_range		;
	self.prim_name		:= l.Clean_address.prim_name		;
	self.zip5					:= l.Clean_address.zip					;
	self.sec_range		:= l.Clean_address.sec_range		;
	self.state				:= l.Clean_address.st						;
	self.phone				:= l.rawfields.telephone_number									;
	self.bdid					:= 0																		;
	self.bdid_score		:= 0																		;
	self.source_group := IF(l.active_duns_number = 'Y', l.rawfields.duns_number, 'D' + l.rawfields.duns_number + '-' + stringlib.stringtouppercase(l.rawfields.business_name));
	self.fein					:= '';
end;   

dSlimForBdiding :=  project(Inputfile,tSlimForBdiding(left));

Business_Header_SS.MAC_Add_BDID_Flex(
	 dSlimForBdiding											// Input Dataset						
	,BDID_Matchset                        // BDID Matchset what fields to match on           
	,company_name	                        // company_name	              
	,prim_range		                        // prim_range		              
	,prim_name		                        // prim_name		              
	,zip5					                        // zip5					              
	,sec_range		                        // sec_range		              
	,state				                        // state				              
	,phone				                        // phone				              
	,fein_not_used                        // fein              
	,bdid													        // bdid												
	,OLD_outrec   												// Output Layout 
	,true                                 // output layout has bdid score field?                       
	,bdid_score                           // bdid_score                 
	,dBdidFlexOut                         // Output Dataset                   
);   

Business_Header_SS.MAC_Match_Flex
(
	 dSlimForBdiding											// Input Dataset						
	,BDID_Matchset                        // BDID Matchset what fields to match on           
	,company_name	                        // company_name	              
	,prim_range		                        // prim_range		              
	,prim_name		                        // prim_name		              
	,zip5					                        // zip5					              
	,sec_range		                        // sec_range		              
	,state				                        // state				              
	,phone				                        // phone				              
	,fein_not_used                        // fein              
	,bdid													        // bdid												
	,OLD_outrec   												// Output Layout 
	,true                                 // output layout has bdid score field?                       
	,bdid_score                           // bdid_score                 
	,dMatchFlexOut                         // Output Dataset                   
);

dnb_dmi.Layouts.Base.Companies tAssignBdids(dnb_dmi.Layouts.Base.Companies l, dnb_dmi.Layouts.Temporary.BdidSlim r) :=
transform

	self.bdid				:= if(r.bdid 				<> 0, r.bdid				, 0);
	self.bdid_score	:= if(r.bdid_score	<> 0, r.bdid_score	, 0);
	self 						:= l;

end;

dAssignBdids_bdidflex := join(
									 distribute(Inputfile			,rid			)
									,distribute(dBdidFlexOut	,unique_id)
									,left.rid = right.unique_id
									,tAssignBdids(left, right)
									,left outer
									,local
									);

dAssignBdids_Matchflex := join(
									 distribute(Inputfile			,rid			)
									,distribute(dMatchFlexOut	,unique_id)
									,left.rid = right.unique_id
									,tAssignBdids(left, right)
									,left outer
									,local
									);

output(choosen(dSourceMatchOut				,200)	,named('dSourceMatchOut'				),all);
output(choosen(dAssignBdids_bdidflex	,200)	,named('dAssignBdids_bdidflex'	),all);
output(choosen(dAssignBdids_Matchflex	,200)	,named('dAssignBdids_Matchflex'	),all);


/* ********
  NOW, REPEAT WITH THE BIP FIELDS WITH THESE SETTINGS
******** */
NEW_outrec 							:= {dnb_dmi.Layouts.Temporary.BdidSlim, BIPV2.IDlayouts.l_xlink_ids};
NEW_SetLinkingVersions 	:= BIPV2.IDconstants.xlink_versions_BDID_BIP;
NEW_SRC_RID_field				:= BIPV2.IDconstants.SRC_RID_field_default;
NEW_Inputfile := 
project(
	Inputfile, 
	transform(
		{Inputfile, BIPV2.IDlayouts.l_xlink_ids}
		,self := left
		,self := []
	)
);

// END SETTINGS

Business_Header.MAC_Source_Match(
	 NEW_Inputfile												// infile
	,dSourceMatchOut2											// outfile
	,FALSE																// bool_bdid_field_is_string12
	,bdid																	// bdid_field
	,FALSE																// bool_infile_has_source_field
	,MDR.sourceTools.src_Dunn_Bradstreet	// source_type_or_field
	,TRUE																	// bool_infile_has_source_group
	,rawfields.duns_number								// source_group_field
	,rawfields.business_name							// company_name_field
	,clean_address.prim_range							// prim_range_field
	,clean_address.prim_name							// prim_name_field
	,clean_address.sec_range							// sec_range_field
	,clean_address.zip										// zip_field
	,TRUE																	// bool_infile_has_phone
	,rawfields.telephone_number						// phone_field
	,FALSE																// bool_infile_has_fein
	,fein_field														// fein_field
	,TRUE																	// bool_infile_has_vendor_id	= 'false'
	,rawfields.duns_number								// vendor_id_field						= 'vendor_id'
	
	,																			//pFileVersion								= '\'prod\''
	,																			//pUseOtherEnvironment				= business_header._Dataset().IsDataland	
	,NEW_SetLinkingVersions								//pSetLinkingVersions 				= BIPV2.IDconstants.xlink_versions_default
	,NEW_SRC_RID_field										//pSRC_RID_field							= BIPV2.IDconstants.SRC_RID_field_default
);

NEW_outrec tSlimForBdiding2(NEW_Inputfile l) :=
transform

	self.unique_id		:= l.rid																;
	self.company_name	:= if(l.rawfields.trade_style = '' or (l.rawfields.trade_style <> '' and l.rawfields.parent_duns_number = '' and l.rawfields.ultimate_duns_number = ''),
														Stringlib.StringToUpperCase(l.rawfields.business_name),
														Stringlib.StringToUpperCase(l.rawfields.trade_style));
	self.prim_range		:= l.Clean_address.prim_range		;
	self.prim_name		:= l.Clean_address.prim_name		;
	self.zip5					:= l.Clean_address.zip					;
	self.sec_range		:= l.Clean_address.sec_range		;
	self.state				:= l.Clean_address.st						;
	self.phone				:= l.rawfields.telephone_number									;
	self.bdid					:= 0																		;
	self.bdid_score		:= 0																		;
	self.source_group := IF(l.active_duns_number = 'Y', l.rawfields.duns_number, 'D' + l.rawfields.duns_number + '-' + stringlib.stringtouppercase(l.rawfields.business_name));
	self.fein					:= '';
	BIPV2.IDmacros.mac_SetIDsZero()
end;   

dSlimForBdiding2 :=  project(NEW_Inputfile,tSlimForBdiding2(left));

Business_Header_SS.MAC_Add_BDID_Flex(
	 dSlimForBdiding2											// Input Dataset						
	,BDID_Matchset                        // BDID Matchset what fields to match on           
	,company_name	                        // company_name	              
	,prim_range		                        // prim_range		              
	,prim_name		                        // prim_name		              
	,zip5					                        // zip5					              
	,sec_range		                        // sec_range		              
	,state				                        // state				              
	,phone				                        // phone				              
	,fein_not_used                        // fein              
	,bdid													        // bdid												
	,NEW_outrec  													// Output Layout 
	,true                                 // output layout has bdid score field?                       
	,bdid_score                           // bdid_score                 
	,dBdidFlexOut2                         // Output Dataset                   
);   

Business_Header_SS.MAC_Match_Flex
(
	 dSlimForBdiding2											// Input Dataset						
	,BDID_Matchset                        // BDID Matchset what fields to match on           
	,company_name	                        // company_name	              
	,prim_range		                        // prim_range		              
	,prim_name		                        // prim_name		              
	,zip5					                        // zip5					              
	,sec_range		                        // sec_range		              
	,state				                        // state				              
	,phone				                        // phone				              
	,fein_not_used                        // fein              
	,bdid													        // bdid												
	,NEW_outrec   												// Output Layout 
	,true                                 // output layout has bdid score field?                       
	,bdid_score                           // bdid_score                 
	,dMatchFlexOut2                         // Output Dataset                   
);

{dnb_dmi.Layouts.Base.Companies,BIPV2.IDlayouts.l_xlink_ids} tAssignBdids2(dnb_dmi.Layouts.Base.Companies l, NEW_outrec r) :=
transform

		self 						:= r;
		self 						:= l;

end;

dAssignBdids_bdidflex2 := join(
									 distribute(Inputfile			,rid			)
									,distribute(dBdidFlexOut2	,unique_id)
									,left.rid = right.unique_id
									,tAssignBdids2(left, right)
									,left outer
									,local
									);

dAssignBdids_Matchflex2 := join(
									 distribute(Inputfile			,rid			)
									,distribute(dMatchFlexOut2	,unique_id)
									,left.rid = right.unique_id
									,tAssignBdids2(left, right)
									,left outer
									,local
									);

output(choosen(dSourceMatchOut2				,200)	,named('dSourceMatchOut2'				),all);
output(choosen(dBdidFlexOut2	,200)	,named('dBdidFlexOut2'	),all);
output(choosen(dAssignBdids_bdidflex2	,200)	,named('dAssignBdids_bdidflex2'	),all);
output(choosen(dMatchFlexOut2	,200)	,named('dMatchFlexOut2'	),all);
output(choosen(dAssignBdids_Matchflex2	,200)	,named('dAssignBdids_Matchflex2'	),all);
