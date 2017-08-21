import business_header;

EXPORT Edit_Distance_Input(

	 dataset(business_header.Layout_Business_Header_base) pBH						= business_header.files().base.business_headers.qa
	,real																									pPercentFile	=	.01
	,string																								pPersistname	= '~thor_data400::persist::lbentley::Edit_Distance_Input'

) :=
function

	countpBH 				:= count(pBH);
	dSampleBH				:= enth	(pBH	,(unsigned)(countpBH * (pPercentFile /100.0)));
	dSampleBH_slim 	:= table(table(dSampleBH,{company_name},company_name, local),{company_name},company_name)
		: persist(pPersistname);
		
	return dSampleBH_slim;

end;