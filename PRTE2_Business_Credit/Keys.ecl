import prte2_business_credit, doxie, data_services, BIPV2;

EXPORT Keys := module


export BusinessClassification  	:= INDEX(files.dsBusinessClassification, 
																				{Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported}, 
																				{files.dsBusinessClassification},
																				Data_services.data_location.prefix('DEFAULT') + prte2_business_credit.constants.key_prefix + doxie.Version_SuperKey + '::businessindustryclassification'); 
																			
export BusinessInfo    					:= INDEX(File_BusinessInformation, 
																				{Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported}, 
																				{File_BusinessInformation},
																				 Data_services.data_location.prefix('DEFAULT') + prte2_business_credit.constants.key_prefix + doxie.Version_SuperKey + '::businessinformation'); 

export BusinessOwner	      	  := INDEX(files.dsBusinessOwner, 
																				{Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported}, 
																				{files.dsBusinessOwner},
																				 Data_services.data_location.prefix('DEFAULT') + prte2_business_credit.constants.key_prefix + doxie.Version_SuperKey + '::businessowner'); 

export Collateral	    			  	:= INDEX(files.dsCollateral , 
																				{Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported}, 
																				{files.dsCollateral},
																				Data_services.data_location.prefix('DEFAULT') + prte2_business_credit.constants.key_prefix + doxie.Version_SuperKey + '::collateral'); 
																				
export History	     					  := INDEX(files.dsHistory, 
																				{Sbfe_Contributor_Number,Original_Contract_Account_Number}, 
																				{files.dsHistory},
																				Data_services.data_location.prefix('DEFAULT') + prte2_business_credit.constants.key_prefix + doxie.Version_SuperKey + '::history'); 

export IndvOwner     						:= INDEX(files.dsIndvOwner, 
																				{Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported}, 
																				{files.dsIndvOwner},
																				Data_services.data_location.prefix('DEFAULT') + prte2_business_credit.constants.key_prefix + doxie.Version_SuperKey + '::individualowner'); 

export IOInformation 	 					:= INDEX(file_IOInformation, {did}, {file_IOInformation}, 
																				 Data_services.data_location.prefix('DEFAULT') + prte2_business_credit.constants.key_prefix + doxie.Version_SuperKey + '::individualownerinformation'); 

export MasterAccount     				:= INDEX(files.dsMasterAccount, 
																			  {Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported}, 
																				{files.dsMasterAccount}, 
																				 Data_services.data_location.prefix('DEFAULT') + prte2_business_credit.constants.key_prefix + doxie.Version_SuperKey + '::masteraccount'); 

export MemberSpecific  					:= INDEX(files.dsMemberSpecific, 
																				{Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported}, 
																				{files.dsMemberSpecific}, 
																				Data_services.data_location.prefix('DEFAULT') + prte2_business_credit.constants.key_prefix + doxie.Version_SuperKey + '::memberspecific'); 

export ReleaseDates     			  := INDEX(files.dsReleaseDates, {version}, {files.dsReleaseDates}, 
																				Data_services.data_location.prefix('DEFAULT') + prte2_business_credit.constants.key_prefix + doxie.Version_SuperKey + '::releasedate'); 

export Tradeline							  := INDEX(file_Tradelines,
																				{Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,Cycle_End_Date},
																				{file_Tradelines}, 
																				Data_services.data_location.prefix('DEFAULT') + prte2_business_credit.constants.key_prefix + doxie.Version_SuperKey + '::tradeline'); 

export BusinessOwnerInfo  	   	:= INDEX(file_BOInformation, 
																				{ultid,orgid,seleid,proxid,powid,empid,dotid}, 
																				{file_BOInformation}, 
																				Data_services.data_location.prefix('DEFAULT') + prte2_business_credit.constants.key_prefix + doxie.Version_SuperKey + '::businessownerinformation'); 

export TradelineGuarantor     	:= INDEX(file_TradelinesBase, 
																				 {ultid,orgid,seleid,proxid,powid,empid,dotid}, 
																				 {file_TradelinesBase}, 
																				 Data_services.data_location.prefix('DEFAULT') + prte2_business_credit.constants.key_prefix + doxie.Version_SuperKey + '::tradelineguarantor'); 

// export Key_Best  							  := INDEX(files.dsKey_Best, 
																				// {ultid,orgid,seleid,proxid,powid,empid,dotid}, 
																				// {files.dsKey_Best}, 
																				// Data_services.data_location.prefix('DEFAULT') + prte2_business_credit.constants.key_prefix + doxie.Version_SuperKey + '::bipv2_best::linkids'); 

// export Linkids							   	:= INDEX(file_Linkids,
																				// {ultid,orgid,seleid,proxid,powid,empid,dotid},
																				// {file_Linkids}, 
																				// Data_services.data_location.prefix('DEFAULT') + prte2_business_credit.constants.key_prefix + doxie.Version_SuperKey + '::linkids'); 

export Key_Scoring   					  := INDEX(files.dsScoring, 
																				{ultid,orgid,seleid,proxid,powid,empid,dotid}, 
																				{files.dsScoring}, 
																				Data_services.data_location.prefix('DEFAULT') + prte2_business_credit.constants.KEY_PREFIX_scoring + doxie.Version_SuperKey + '::scoringindex'); 

EXPORT linkids := MODULE
		
		BIPV2.IDmacros.mac_IndexWithXLinkIDs(file_Linkids, k,  prte2_business_credit.constants.key_prefix + doxie.Version_SuperKey +  '::linkids')
		export Key := k;
	
			
		//DEFINE THE INDEX ACCESS
		export kFetch(
			dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs, 
			string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																									//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																									//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
			unsigned2 ScoreThreshold = 0,								//Applied at lowest leve of ID
			joinLimit = 25000,
			unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
			) :=
		FUNCTION

			BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, out, Level, joinLimit, JoinType);
			return out;																					

		END;
	
	END;
		
																				
end;																				
