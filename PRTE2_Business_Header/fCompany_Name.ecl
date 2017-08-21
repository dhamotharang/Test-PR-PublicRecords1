import Business_Header, Business_Header_SS;

export fCompany_Name(

	dataset(Business_Header.Layout_Business_Header_Base	)	pBusHeaders	= PRTE2_Business_Header.Files().Base.Business_Headers.Built

) :=
function

out_cn := Business_Header_SS.CompanyName(pBusHeaders);

return out_cn;

end;