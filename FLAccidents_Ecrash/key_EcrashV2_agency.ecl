IMPORT Data_Services, doxie;   

agency :=  PROJECT(Files.Base.AgencyCmbd, TRANSFORM(Layout_Keys_eCrash.Agency, SELF := LEFT;));

EXPORT key_EcrashV2_agency := INDEX(agency
																		,{Agency_State_Abbr,Agency_Name,Agency_ori}
																		,{agency}
																		,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2_agency_' + doxie.Version_SuperKey);		
																		
