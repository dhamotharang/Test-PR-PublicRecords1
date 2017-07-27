#OPTION('multiplePersistInstances',FALSE);
export As_Business_Contact(

	boolean pUsingInBusinessHeader = true	//if true, use using_in_business_header superfiles

) := 
function

	asbc := fAs_Business_Contact_Combined(
		if(pUsingInBusinessHeader	,files().base.Combined.BusinessHeader,files().base.Combined.qa)
	) : persist(persistnames.AsBusinessContactCombined);
	 
	return asbc;
	
end;