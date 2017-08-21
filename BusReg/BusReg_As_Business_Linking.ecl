// #OPTION('multiplePersistInstances',FALSE);
import business_header;

export BusReg_As_Business_Linking(
	
	boolean pUsingInBusinessHeader = true	//if true, use using_in_business_header superfiles

) :=
module

	shared dCompanybase := if(pUsingInBusinessHeader, BusReg.files(,true).base.companies.businessheader	,BusReg.files().base.companies.QA);
	shared dContactbase := if(pUsingInBusinessHeader, BusReg.files(,true).base.contacts.businessheader	,BusReg.files().base.contacts.QA	);
	
	export Busreg := BusReg.fBusReg_As_Business_Linking(dCompanybase,dContactbase) : persist(BusReg.persistnames().AsBusinessLinking);

	export all :=
	sequential(

		 output(enth(Busreg,1000),named('As_Business_Linking_Busreg'),all)
	                              
	);

end;