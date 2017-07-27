import mdr;
EXPORT constants := module

	// Sources
	export string2 LNCA 	:= mdr.sourceTools.src_DCA;
	export string2 DB 		:= 'D';//not in MDR.sourceTools for some reason
	export string2 EBR	 	:= mdr.sourceTools.src_EBR;
	
	export superCore := [LNCA];	
	export triCore := superCore + [DB, EBR];
	
	//tom reed: corp or d&b fein or ucc or property or ca sales tax are better than others like bizreg or fbn
	//now, for bug 148881, add	Experian CRDB, FRANCHISE - FranData - Frandex, DNB FEIN, Experian FEINS, BankruptcyV2
	export secondTierSources := [MDR.sourceTools.set_CorpV2, MDR.sourceTools.set_LnPropertyV2,  MDR.sourceTools.set_UCCS, MDR.sourceTools.set_Liens, MDR.sourceTools.set_State_Sales_Tax
	,MDR.sourceTools.set_Experian_CRDB, MDR.sourceTools.set_Frandx, MDR.sourceTools.set_Dunn_Bradstreet_Fein, MDR.sourceTools.set_Experian_FEIN, MDR.sourceTools.set_bk
	];

	
	export bizRegSources := [MDR.sourceTools.src_FBNV2_BusReg,MDR.sourceTools.src_AK_Busreg,MDR.sourceTools.src_Business_Registration];

// TriCore             				3 Core Sources (LNCA, D&B, EBR)
// DualCore            				2 Core Sources
// TrustedSource       				Core Source <= 1, TotalSource >  1 and TotalRecords > 1
// SingleSource        				Core Source <= 1, TotalSource =  1 and TotalRecords > 1
// TrustedSrcSingleton 				Total Records = 1 and LastSeenDate <= 2 years
// NoActivity 								Max(LastSeenDate) > 2 years
// Inactive Reported					Max(LastSeenDate) <= 18 months and reported inactive

	// Gold
	export mGold := module
		export string1  s1 	 := 'G';
		export string20 desc := 'Gold';
	end;
	
	// Probation
	export mProbation := module
		export string1  s1 	 := 'P';
		export string20 desc := 'Probation';
	end;	
	
	// Segment Definition
	export mTriCore := module
		export string1  s1 	 := '3';
		export string20 desc := 'TriCore';
	end;
	
	export mDualCore := module
		export string1  s1 	 := '2';
		export string20 desc := 'DualCore';
	end;	
	
	export mTrustedSource := module
		export string1  s1 	 := 'T';
		export string20 desc := 'TrustedSource';
	end;	

	export mSingleSource := module
		export string1  s1 	 := '1';
		export string20 desc := 'SingleSource';
	end;
	
	export mTrustedSrcSingleton := module
		export string1  s1 	 := 'E';
		export string20 desc := 'TrustedSrcSingleton';
	end;
	
	export mNoActivity := module
		export string1  s1 	 := 'I';
		export string20 desc := 'NoActivity';
	end;
	
	export mInactiveReported := module
		export string1  s1 	 := 'D';
		export string20 desc := 'ReportedInactive';
	end;	
	
	export Core_Tri				:= mTriCore.s1;
	export Core_TC				:= mTriCore.desc;
	
	export Core_Dual 			:= mDualCore.s1;
	export Core_DC 				:= mDualCore.desc;
	
	export Core_TrustedSrc:= mTrustedSource.s1;
	export Core_TS 				:= mTrustedSource.desc;
	
	export Core_SingleSrc	:= mSingleSource.s1;
	export Core_SS				:= mSingleSource.desc;
	
	export Ecore_SingleSrcSingleton	:= mTrustedSrcSingleton.s1;
	export Ecore_TS 								:= mTrustedSrcSingleton.desc;

	export Inactive_NoActivity			:= mNoActivity.s1;
	export Inactive_NA 							:= mNoActivity.desc;
	
	export Inactive_Reported 				:= mInactiveReported.s1;
	export Inactive_RI 							:= mInactiveReported.desc;
	
	export string20 Core					:= 'CORE';
	export string20 Ecore					:= 'EMERGINGCORE';
	export string20 Inactive			:= 'INACTIVE';
	
	export fCoreDesc(string2 pType) := 
			case(pType			
				,mTriCore.s1 				=> mTriCore.desc
				,mDualCore.s1 			=> mDualCore.desc
				,mTrustedSource.s1 	=> mTrustedSource.desc
				,mSingleSource.s1 	=> mSingleSource.desc
				, ''
			);

	export fECoreDesc(string2 pType) := 
			case(pType			
				,mTrustedSrcSingleton.s1 => mTrustedSrcSingleton.desc
				, ''
			);
			
	export fInactiveDesc(string2 pType) := 
			case(pType			
				,mInactiveReported.s1 		=> mInactiveReported.desc
				,mNoActivity.s1						=> mNoActivity.desc
				, ''
			);
			
	export fDesc(string2 pType) := trim(fCoreDesc(pType)) + trim(fECoreDesc(pType)) + trim(fInactiveDesc(pType));
	
	
end;