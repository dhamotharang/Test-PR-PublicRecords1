import  Business_Header, Business_Header_SS;

export fCompany_Name_FEIN(

	 dataset(Business_Header.Layout_Business_Header_Base	)	pBusHeaders		= PRTE2_Business_Header.Files().Base.Business_Headers.Built
	,string																									pPersistName	= PRTE2_Business_Header.persistnames().CompanyNameFein

) :=
function

	out_cn_fein := Business_Header_SS.CompanyName_FEIN(pBusHeaders, pPersistName);

	return out_cn_fein;

end;