import strata;
export Strata_Population_Stats(

	 boolean																		pUseOtherEnvironment	= false
	,dataset(Layout_Business_Header_Base			)	pInput								= Files(,pUseOtherEnvironment).Base.Business_Headers.built
	,dataset(Layout_Business_Contact_Full_new	)	pCont									= Files(,pUseOtherEnvironment).Base.Business_Contacts.built
	,dataset(Layout_Business_Relative					)	pRel									= Files(,pUseOtherEnvironment).base.business_relatives.built
	,dataset(Layout_BH_Best										)	pBest									= Files(,pUseOtherEnvironment).base.Business_Header_Best.built
	,dataset(Layout_BH_Super_Group						)	pGroup								= Files(,pUseOtherEnvironment).base.Super_Group.built
	,dataset(Layout_BDL2											)	pBDL2									= Files(,pUseOtherEnvironment).base.BDL2.built
	
) :=
module

  shared laybiznew := 
	record
	  Layout_Business_Header_Base;
		unsigned8 aceaid := 0;
	end;
	
	shared laycontnew := 
	record
	  Layout_Business_Contact_Full_new;
		unsigned8		aceAID	:= 0;    // Added for Address_id
		unsigned8		Company_aceAID	:= 0;    // Added for Address_id
	end;
	
	shared dbiz := project(pInput, transform(laybiznew, self := left));
	shared dcont := project(pCont, transform(laycontnew, self := left));
	
	// Contacts Strata
	Strata.mac_Pops		(dCont	,dContNoGrouping												);
	Strata.mac_Pops		(dCont	,dContSource						,'source'				);
	Strata.mac_Pops		(dCont	,dContState							,'state'				);
	Strata.mac_Pops		(dCont	,dContRectype						,'record_type'	);
	Strata.mac_Pops		(dCont	,dContfrom_hdr					,'from_hdr'			);
	Strata.mac_Uniques(dCont	,dUniqueContNoGrouping									);
	Strata.mac_Uniques(dCont	,dUniqueContSource			,'source'				);
	Strata.mac_Uniques(dCont	,dUniqueContState				,'state'				);
	
	// Business Header Strata
	Strata.mac_Pops		(dBiz	,dBaseNoGrouping												);
	Strata.mac_Pops		(dBiz	,dBaseSource						,'source'				);
	Strata.mac_Pops		(dBiz	,dBaseState							,'state'				);
	Strata.mac_Uniques(dBiz	,dUniqueBaseNoGrouping									);
	Strata.mac_Uniques(dBiz	,dUniqueBaseSource			,'source'				);
	Strata.mac_Uniques(dBiz	,dUniqueBaseState				,'state'				);

	// Business Header Best Strata
	Strata.mac_Pops		(pBest	,dBestNoGrouping				,				,,,,,,,	['addr_source','phone_source']	);
	Strata.mac_Pops		(pBest	,dBestState							,'state',,,,,,,	['addr_source','phone_source']	);
	Strata.mac_Uniques(pBest	,dBestUniquesNoGrouping	,				,,,,		['addr_source','phone_source']	);
	Strata.mac_Uniques(pBest	,dBestUniquesState			,'state',,,,		['addr_source','phone_source']	);

	// Business Groups Strata
	Strata.mac_Pops		(pGroup	,dGroups																);
	Strata.mac_Uniques(pGroup	,dGroupUniques													);

	// BDL2 Strata
	Strata.mac_Pops		(pBDL2	,dBDL2				,,,,,,,false,['bdid','bdl','group_id']);
	Strata.mac_Uniques(pBDL2	,dBDL2Uniques	   ,,,,false,['bdid','bdl','group_id']);

	// Business Relatives Strata
	Strata.mac_Pops(pRel	 ,dRel,'','dummygroup','string','BR',false,true,,['bdid1','bdid2','lien_properties','liens_v2'],true);

end;