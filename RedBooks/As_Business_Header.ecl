#OPTION('multiplePersistInstances',FALSE);

export As_Business_Header(

	boolean pUsingInBusinessHeader = true	//if true, use using_in_business_header superfiles

) :=
function

	asbh := fAs_Business_Header_Combined(
		if(pUsingInBusinessHeader	,files().base.Combined.BusinessHeader,files().base.Combined.qa)
	) : persist(persistnames.AsBusinessHeaderCombined);

	return asbh;

end;
