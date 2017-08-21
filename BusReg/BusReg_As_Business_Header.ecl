import business_header,business_headerv2;

export BusReg_As_Business_Header(
	
	boolean pUsingInBusinessHeader = true	//if true, use using_in_business_header superfiles

) :=
module
	
	#OPTION('multiplePersistInstances',FALSE);
	
	shared basefile := if(pUsingInBusinessHeader, files().base.companies.businessheader, files().base.companies.QA);
	
	export Busreg := fBusReg_As_Business_Header(basefile) : persist(persistnames().AsBusinessHeader);

	export all :=
	sequential(

		 output(enth(Busreg,1000),named('As_Business_Header_Busreg'),all)
	                              
	);

end;