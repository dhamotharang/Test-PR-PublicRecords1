import roxiekeybuild, ut, LaborActions_MSHA;

export  Proc_Build_RoxieKeys(string Pversion) := function

	//PROCESS CONTRACTORID KEYS
	
	
	//Build the ContractorId_Accident key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
																						 LaborActions_MSHA.Key_ContractorId_Accident
																						,_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::@version@::ContractorID_Accident'
																						,_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::'+Pversion+'::ContractorID_Accident'
																						,build_contractorid_accident_key
																						);
	//Build the ContractorId_Contractor key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
																						 LaborActions_MSHA.Key_ContractorId_Contractor
																						,_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::@version@::ContractorID_Contractor'
																						,_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::'+Pversion+'::ContractorID_Contractor'
																						,build_contractorid_contractor_key
																						);
	//Build the ContractorId_Events key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
																						 LaborActions_MSHA.Key_ContractorId_Events
																						,_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::@version@::ContractorID_Events'
																						,_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::'+Pversion+'::ContractorID_Events'
																						,build_contractorid_events_key
																						);	
																						
	//Move ContractorId_Accident key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																				 _Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::@version@::ContractorID_Accident'
																				,_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::'+Pversion+'::ContractorID_Accident'
																				,mv_contractorid_accident_key_to_built
																				); 																						
											   
	//Move ContractorId_Contractor key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																				 _Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::@version@::ContractorID_Contractor'
																				,_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::'+Pversion+'::ContractorID_Contractor'
																				,mv_contractorid_contractor_key_to_built
																				); 	
	//Move ContractorId_Events key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																				 _Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::@version@::ContractorID_Events'
																				,_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::'+Pversion+'::ContractorID_Events'
																				,mv_contractorid_events_key_to_built
																				); 	
																				
	//Move ContractorId_Accident key to QA
	RoxieKeyBuild.MAC_SK_Move_v2(
																_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::@version@::ContractorID_Accident'
															 ,'Q'
															 ,mv_contractorid_accident_key_to_qa
															);
	//Move ContractorId_Contractor key to QA
	RoxieKeyBuild.MAC_SK_Move_v2(
																_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::@version@::ContractorID_Contractor'
															 ,'Q'
															 ,mv_contractorid_contractor_key_to_qa
															);
	//Move ContractorId_Events key to QA
	RoxieKeyBuild.MAC_SK_Move_v2(
																_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::@version@::ContractorID_Events'
															 ,'Q'
															 ,mv_contractorid_events_key_to_qa
															);															
  
	
	//PROCESS MINEID KEYS
	
	//Build the MineId_Accident key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
																						 LaborActions_MSHA.Key_MineId_Accident
																						,_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::@version@::MineID_Accident'
																					  ,_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::'+Pversion+'::MineID_Accident'
																						,build_mineid_accident_key
																						);
																						
	//Build the MineId_Contractor key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
																						 LaborActions_MSHA.Key_MineId_Contractor
																						,_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::@version@::MineID_Contractor'
																					  ,_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::'+Pversion+'::MineID_Contractor'
																						,build_mineid_contractor_key
																						);

	//Build the MineId_Events key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
																						 LaborActions_MSHA.Key_MineId_Events
																						,_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::@version@::MineID_Events'
																					  ,_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::'+Pversion+'::MineID_Events'
																						,build_mineid_events_key
																						);

	//Build the MineId_Mine key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
																						 LaborActions_MSHA.Key_MineId_Mine
																						,_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::@version@::MineID_Mine'
																					  ,_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::'+Pversion+'::MineID_Mine'
																						,build_mineid_mine_key
																						);

	//Build the MineId_Operator key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
																						 LaborActions_MSHA.Key_MineId_Operator
																						,_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::@version@::MineID_Operator'
																					  ,_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::'+Pversion+'::MineID_Operator'
																						,build_mineid_operator_key
																						);
	
	//Move MineId_Accident key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																				 _Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::@version@::MineID_Accident'
																				,_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::'+Pversion+'::MineID_Accident'
																				,mv_mineid_accident_key_to_built
																				); 																						
											   
	//Move MineId_Contractor key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																				 _Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::@version@::MineID_Contractor'
																				,_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::'+Pversion+'::MineID_Contractor'
																				,mv_mineid_contractor_key_to_built
																				); 																						

	//Move MineId_Events key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																				 _Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::@version@::MineID_Events'
																				,_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::'+Pversion+'::MineID_Events'
																				,mv_mineid_events_key_to_built
																				); 																						
											   											   												 
	//Move MineId_Mine key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																				 _Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::@version@::MineID_Mine'
																				,_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::'+Pversion+'::MineID_Mine'
																				,mv_mineid_mine_key_to_built
																				); 																						

	//Move MineId_Operator key to Built
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																				 _Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::@version@::MineID_Operator'
																				,_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::'+Pversion+'::MineID_Operator'
																				,mv_mineid_operator_key_to_built
																				); 																						

	//Move MineId_Accident key to QA
	RoxieKeyBuild.MAC_SK_Move_v2(	_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::@version@::MineID_Accident',
															 'Q',
															  mv_mineid_accident_key_to_qa
															);	
	//Move MineId_Contractor key to QA
	RoxieKeyBuild.MAC_SK_Move_v2(	_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::@version@::MineID_Contractor',
															 'Q',
															  mv_mineid_contractor_key_to_qa
															);	
	//Move MineId_Events key to QA
	RoxieKeyBuild.MAC_SK_Move_v2(	_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::@version@::MineID_Events',
															 'Q',
															  mv_mineid_events_key_to_qa
															);	
	//Move MineId_Mine key to QA
	RoxieKeyBuild.MAC_SK_Move_v2(	_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::@version@::MineID_Mine',
															 'Q',
															  mv_mineid_mine_key_to_qa
															);	
	//Move MineId_Operator key to QA
	RoxieKeyBuild.MAC_SK_Move_v2(	_Dataset().thor_cluster_Files+'key::'+_Dataset().Name+'::@version@::MineID_Operator',
															 'Q',
															  mv_mineid_operator_key_to_qa
															);																
										  										   
   keys := sequential(parallel(	build_contractorid_accident_key
															 ,build_contractorid_contractor_key
															 ,build_contractorid_events_key
															 ,build_mineid_accident_key
															 ,build_mineid_contractor_key
															 ,build_mineid_events_key
															 ,build_mineid_mine_key
															 ,build_mineid_operator_key
															),
											parallel( mv_contractorid_accident_key_to_built
															 ,mv_contractorid_contractor_key_to_built
															 ,mv_contractorid_events_key_to_built
															 ,mv_mineid_accident_key_to_built															 
															 ,mv_mineid_contractor_key_to_built															 
															 ,mv_mineid_events_key_to_built															 
															 ,mv_mineid_mine_key_to_built															 
															 ,mv_mineid_operator_key_to_built
															 ),
											parallel(	mv_contractorid_accident_key_to_qa
															 ,mv_contractorid_contractor_key_to_qa
															 ,mv_contractorid_events_key_to_qa
															 ,mv_mineid_accident_key_to_qa															 
															 ,mv_mineid_contractor_key_to_qa															 
															 ,mv_mineid_events_key_to_qa															 
															 ,mv_mineid_mine_key_to_qa															 
															 ,mv_mineid_operator_key_to_qa
															)
											);
								            
	return keys;
end;