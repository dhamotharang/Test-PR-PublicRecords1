import Business_Header, Business_Header_SS;

export fCompany_Name_Addr_Broad(

	 dataset(Business_Header.Layout_Business_Header_Base	)	pBusHeaders		= PRTE2_Business_Header.Files().Base.Business_Headers.Built
	,string																									pPersistName	= PRTE2_Business_Header.persistnames().CompanyNameAddressBroad

) :=
function
	
	out_cn_addr_broad := Business_Header_SS.CompanyName_Address_Broad(pBusHeaders, pPersistName);
	
	return out_cn_addr_broad;

end;