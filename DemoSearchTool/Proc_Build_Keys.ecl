Import RoxieKeyBuild;
EXPORT Proc_Build_Keys(string filedate) := Function

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( demosearchtool.keys.People,
																							Constants.SearchTool_Prefix + '@version@::people',
																							Constants.SearchTool_Prefix + '' + filedate + '::people', 
																							build_people, TRUE);
																							
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( demosearchtool.keys.Businesses_bdid,
																							Constants.SearchTool_Prefix + '@version@::business_bdid',
																							Constants.SearchTool_Prefix + '' + filedate + '::business_bdid', 
																							build_businesses, 
																							TRUE);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( demosearchtool.keys.Combined_biz_bdid,
																							Constants.SearchTool_Prefix + '@version@::combined_biz_bdid',
																							Constants.SearchTool_Prefix + '' + filedate + '::combined_biz_bdid', 
																							build_combined_biz_bdid, 
																							TRUE);
																							
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( demosearchtool.keys.DTC,
																							Constants.SearchTool_Prefix + '@version@::dtc',
																							Constants.SearchTool_Prefix + '' + filedate + '::dtc', 
																							build_dtc, 
																							TRUE);
																						
																																													
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( demosearchtool.keys.Business_Address,
																							Constants.SearchTool_Prefix + '@version@::business_address',
																							Constants.SearchTool_Prefix + '' + filedate + '::business_address', 
																							build_Business_Address, 
																							TRUE);
																							
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( demosearchtool.keys.Businesses_linkids,
																							Constants.SearchTool_Prefix + '@version@::business_linkids',
																							Constants.SearchTool_Prefix + '' + filedate + '::business_linkids', 
																							build_businesses_linkids, 
																							TRUE);
																							
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local( demosearchtool.keys.Combined_biz_linkids,
																							Constants.SearchTool_Prefix + '@version@::combined_biz_linkids',
																							Constants.SearchTool_Prefix + '' + filedate + '::combined_biz_linkids', 
																							build_combined_biz_linkids, 
																							TRUE);			
																							
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( 	Constants.SearchTool_Prefix + '@version@::people', 
																					Constants.SearchTool_Prefix + '' + filedate + '::people',
																					move_built_people);
																					
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( 	Constants.SearchTool_Prefix + '@version@::business_bdid', 
																					Constants.SearchTool_Prefix + '' + filedate + '::business_bdid',
																					move_built_businesses);
																					
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( 	Constants.SearchTool_Prefix + '@version@::dtc', 
																					Constants.SearchTool_Prefix + '' + filedate + '::dtc',
																					move_built_dtc);
																							
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( 		Constants.SearchTool_Prefix + '@version@::combined_biz_bdid',
																						Constants.SearchTool_Prefix + '' + filedate + '::combined_biz_bdid', 
																						move_built_combined_biz_bdid);
																					
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( 	Constants.SearchTool_Prefix + '@version@::combined_biz_linkids', 
																					Constants.SearchTool_Prefix + '' + filedate + '::combined_biz_linkids',
																					move_built_combined_biz_linkids);
																		
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( 	Constants.SearchTool_Prefix + '@version@::business_address', 
																					Constants.SearchTool_Prefix + '' + filedate + '::business_address',
																					move_built_Business_Address);
																					
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2( 	Constants.SearchTool_Prefix + '@version@::business_linkids', 
																					Constants.SearchTool_Prefix + '' + filedate + '::business_linkids',
																					move_built_businesses_linkids);
																					
	RoxieKeyBuild.MAC_SK_Move_v2(	Constants.SearchTool_Prefix + '@version@::people', 
																'Q', 
																move_qa_people);																
	
	RoxieKeyBuild.MAC_SK_Move_v2(	Constants.SearchTool_Prefix + '@version@::business_bdid', 
																'Q', 
																move_qa_businesses);	
																
	RoxieKeyBuild.MAC_SK_Move_v2(	Constants.SearchTool_Prefix + '@version@::dtc', 
																'Q', 
																move_qa_dtc);							
																					
	RoxieKeyBuild.MAC_SK_Move_v2(	Constants.SearchTool_Prefix + '@version@::combined_biz_bdid',
																'Q', 
																move_qa_combined_biz_bdid);	
																
	RoxieKeyBuild.MAC_SK_Move_v2(	Constants.SearchTool_Prefix + '@version@::combined_biz_linkids', 
																'Q', 
																move_qa_combined_biz_linkids);																						

	RoxieKeyBuild.MAC_SK_Move_v2(	Constants.SearchTool_Prefix + '@version@::business_address', 
																'Q', 
																move_qa_Business_Address);	
							
  RoxieKeyBuild.MAC_SK_Move_v2(	Constants.SearchTool_Prefix + '@version@::business_linkids', 
																'Q', 
																move_qa_businesses_linkids);	
																
																
return sequential(	
											build_people, move_built_people, move_qa_people,
											build_businesses, move_built_businesses, move_qa_businesses,
											build_dtc, move_built_dtc, move_qa_dtc,
											build_combined_biz_bdid, move_built_combined_biz_bdid, move_qa_combined_biz_bdid,
											build_combined_biz_linkids, move_built_combined_biz_linkids, move_qa_combined_biz_linkids,
											build_Business_Address, move_built_Business_Address, move_qa_Business_Address,
											build_businesses_linkids, move_built_businesses_linkids, move_qa_businesses_linkids
											
											);

End;