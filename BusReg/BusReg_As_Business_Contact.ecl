import business_header;

export BusReg_As_Business_Contact(
	
	boolean pUsingInBusinessHeader = true	//if true, use using_in_business_header superfiles

) :=
module
	
	#OPTION('multiplePersistInstances',FALSE);
	
	shared dCompanybase := if(pUsingInBusinessHeader, files().base.companies.businessheader	,files().base.companies.QA);
	shared dContactbase := if(pUsingInBusinessHeader, files().base.contacts.businessheader	,files().base.contacts.QA	);
	
	export Busreg := fBusReg_As_Business_Contact(dCompanybase,dContactbase) : persist(persistnames().AsBusinessContact);

	export all :=
	sequential(

		 output(enth(Busreg,1000),named('As_Business_Contact_Busreg'),all)
	                              
	);

end;