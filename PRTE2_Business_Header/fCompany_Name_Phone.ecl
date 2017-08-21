import  Business_Header, Business_Header_SS;

export fCompany_Name_Phone(

	 dataset(Business_Header.Layout_Business_Header_Base	)	pBusHeaders		= PRTE2_Business_Header.Files().Base.Business_Headers.Built
	,dataset(Business_Header.Layout_BH_Best								)	pBH_Best			= PRTE2_Business_Header.Files().Base.Business_Header_Best.Built
	,string																									pPersistName	= PRTE2_Business_Header.persistnames().CompanyNamePhone

) :=
function

	out_cn_phone := Business_Header_SS.CompanyName_Phone(pBusHeaders, pBH_Best, pPersistName);

	return out_cn_phone;

end;