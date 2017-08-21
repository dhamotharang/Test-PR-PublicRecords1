IMPORT tools, ut;

EXPORT Build_Bases(

	STRING																												pfiledate,
	STRING																												pversion,	
	BOOLEAN																								        pUseOtherEnvironment,
	DATASET(Corp2_Raw_OH.Layouts.Business_AddressLayoutIn)				pInBusiness_Address   		  = Corp2_Raw_OH.Files(pfiledate,pUseOtherEnvironment).Input.Business_Address.Logical,
	DATASET(Corp2_Raw_OH.Layouts.Business_AddressLayoutBase)			pBaseBusiness_Address 		  = IF(Corp2_Raw_OH._Flags.Base.Business_Address, Corp2_Raw_OH.Files(,pUseOtherEnvironment := FALSE).Base.Business_Address.qa, DATASET([], Corp2_Raw_OH.Layouts.Business_AddressLayoutBase)),
	DATASET(Corp2_Raw_OH.Layouts.Agent_ContactLayoutIn)						pInAgent_Contact   					= Corp2_Raw_OH.Files(pfiledate,pUseOtherEnvironment).Input.Agent_Contact.Logical,
	DATASET(Corp2_Raw_OH.Layouts.Agent_ContactLayoutBase)					pBaseAgent_Contact 					= IF(Corp2_Raw_OH._Flags.Base.Agent_Contact, Corp2_Raw_OH.Files(,pUseOtherEnvironment := FALSE).Base.Agent_Contact.qa, DATASET([], Corp2_Raw_OH.Layouts.Agent_ContactLayoutBase)),
	DATASET(Corp2_Raw_OH.Layouts.Business_AssociateLayoutIn)			pInBusiness_Associate   		= Corp2_Raw_OH.Files(pfiledate,pUseOtherEnvironment).Input.Business_Associate.Logical,
	DATASET(Corp2_Raw_OH.Layouts.Business_AssociateLayoutBase)		pBaseBusiness_Associate 		= IF(Corp2_Raw_OH._Flags.Base.Business_Associate, Corp2_Raw_OH.Files(,pUseOtherEnvironment := FALSE).Base.Business_Associate.qa, DATASET([], Corp2_Raw_OH.Layouts.Business_AssociateLayoutBase)),
	DATASET(Corp2_Raw_OH.Layouts.BusinessLayoutIn)								pInBusiness   							= Corp2_Raw_OH.Files(pfiledate,pUseOtherEnvironment).Input. Business.Logical,
  DATASET(Corp2_Raw_OH.Layouts.BusinessLayoutBase)							pBaseBusiness 							= IF(Corp2_Raw_OH._Flags.Base.Business, Corp2_Raw_OH.Files(,pUseOtherEnvironment := FALSE).Base.Business.qa, DATASET([], Corp2_Raw_OH.Layouts. BusinessLayoutBase)),
	DATASET(Corp2_Raw_OH.Layouts.ExplanationLayoutIn)							pInExplanation  						= Corp2_Raw_OH.Files(pfiledate,pUseOtherEnvironment).Input.Explanation.Logical,
	DATASET(Corp2_Raw_OH.Layouts.ExplanationLayoutBase)						pBaseExplanation						= IF(Corp2_Raw_OH._Flags.Base.Explanation, Corp2_Raw_OH.Files(,pUseOtherEnvironment := FALSE).Base.Explanation.qa, DATASET([], Corp2_Raw_OH.Layouts.ExplanationLayoutBase)),
	DATASET(Corp2_Raw_OH.Layouts.Old_NameLayoutIn)								pInOld_Name   			 				= Corp2_Raw_OH.Files(pfiledate,pUseOtherEnvironment).Input.Old_Name.Logical,
	DATASET(Corp2_Raw_OH.Layouts.Old_NameLayoutBase)							pBaseOld_Name			 					= IF(Corp2_Raw_OH._Flags.Base.Old_Name, Corp2_Raw_OH.Files(,pUseOtherEnvironment := FALSE).Base.Old_Name.qa, DATASET([], Corp2_Raw_OH.Layouts.Old_NameLayoutBase)),
	DATASET(Corp2_Raw_OH.Layouts.Authorized_ShareLayoutIn)				pInAuthorized_Share   			= Corp2_Raw_OH.Files(pfiledate,pUseOtherEnvironment).Input. Authorized_Share.Logical,
  DATASET(Corp2_Raw_OH.Layouts.Authorized_ShareLayoutBase)			pBaseAuthorized_Share 			= IF(Corp2_Raw_OH._Flags.Base.Authorized_Share, Corp2_Raw_OH.Files(,pUseOtherEnvironment := FALSE).Base.Authorized_Share.qa, DATASET([], Corp2_Raw_OH.Layouts.Authorized_ShareLayoutBase)),
	DATASET(Corp2_Raw_OH.Layouts.Document_TransactionLayoutIn) 		pInDocument_Transaction  		= Corp2_Raw_OH.Files(pfiledate,pUseOtherEnvironment).Input.Document_Transaction.Logical,
	DATASET(Corp2_Raw_OH.Layouts.Document_TransactionLayoutBase)	pBaseDocument_Transaction		= IF(Corp2_Raw_OH._Flags.Base.Document_Transaction, Corp2_Raw_OH.Files(,pUseOtherEnvironment := FALSE).Base.Document_Transaction.qa, DATASET([], Corp2_Raw_OH.Layouts.Document_TransactionLayoutBase)),
	DATASET(Corp2_Raw_OH.Layouts.Text_InformationLayoutIn)	 			pInText_Information   			= Corp2_Raw_OH.Files(pfiledate,pUseOtherEnvironment).Input.Text_Information.Logical,
	DATASET(Corp2_Raw_OH.Layouts.Text_InformationLayoutBase) 			pBaseText_Information				= IF(Corp2_Raw_OH._Flags.Base.Text_Information, Corp2_Raw_OH.Files(,pUseOtherEnvironment := FALSE).Base.Text_Information.qa, DATASET([], Corp2_Raw_OH.Layouts.Text_InformationLayoutBase))
	
	
) := MODULE

	EXPORT full_build := sequential(	Corp2_Raw_OH.Build_Bases_Business_Address(pfiledate,pversion,pUseOtherEnvironment,pInBusiness_Address,pBaseBusiness_Address).ALL,
																		Corp2_Raw_OH.Build_Bases_Agent_Contact(pfiledate,pversion,pUseOtherEnvironment,pInAgent_Contact,pBaseAgent_Contact).ALL,
																		Corp2_Raw_OH.Build_Bases_Business_Associate(pfiledate,pversion,pUseOtherEnvironment,pInBusiness_Associate,pBaseBusiness_Associate).ALL,
																		Corp2_Raw_OH.Build_Bases_Business(pfiledate,pversion,pUseOtherEnvironment,pInBusiness,pBaseBusiness).ALL,
																		Corp2_Raw_OH.Build_Bases_Explanation(pfiledate,pversion,pUseOtherEnvironment,pInExplanation,pBaseExplanation).ALL,
																		Corp2_Raw_OH.Build_Bases_Old_Name(pfiledate,pversion,pUseOtherEnvironment,pInOld_Name,pBaseOld_Name).ALL,
																		Corp2_Raw_OH.Build_Bases_Authorized_Share(pfiledate,pversion,pUseOtherEnvironment,pInAuthorized_Share,pBaseAuthorized_Share).ALL,
																		Corp2_Raw_OH.Build_Bases_Document_Transaction(pfiledate,pversion,pUseOtherEnvironment,pInDocument_Transaction,pBaseDocument_Transaction).ALL,
																		Corp2_Raw_OH.Build_Bases_Text_Information(pfiledate,pversion,pUseOtherEnvironment,pInText_Information,pBaseText_Information).ALL,
																		Promote(pversion).BuildFiles.New2Built,
																		Promote().BuildFiles.Built2QA
																 );

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 full_build,
									 OUTPUT('No Valid version  parameter passed, skipping Corp2_Raw_OH.Build_Bases attribute')
									 );

END;
