//* PRTE2_PropertyInfo.BWR_PropertyInfo //*
//* Generate PRCT-PII files, RID and ADDRESS using old data plus new customer test data.
IMPORT PRTE, PRTE_CSV, PRTE2, ut,_control;
#WORKUNIT ('name', 'CustTest PropertyInfo');
string filedate     := ut.GetDate; 
 Sequential(
					PRTE2_PropertyInfo.New_process_build_propertyinfo(filedate)
//* Uncomment and Update Version after verifying the build:
/*					PRTE.UpdateVersion(	'PropertyInformationKeys',					//	Package name
															filedate,												//	Package version
															_control.MyInfo.EmailAddressNormal,		//	Who to email with specifics
															'B',																	//	B = Boca,A = Alpharetta
															'N',																	//	N = Non-FCRA,F = FCRA
															'N'																		//	N = Do not also include boolean,Y = Include boolean,too
															)
*/
						); 
OUTPUT ('NEW Customer Test PropertyInfo KEYS BUILT');