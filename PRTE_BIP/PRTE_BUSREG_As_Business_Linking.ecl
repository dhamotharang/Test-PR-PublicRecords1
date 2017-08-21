// #OPTION('multiplePersistInstances',FALSE);
import busreg, prte_bip;

export PRTE_BUSREG_As_Business_Linking(
	
	boolean pUsingInBusinessHeader = false	//if true, use using_in_business_header superfiles

) :=
module

	ds_Company := prte_bip.persistnames().prepped_busreg_companies;
	ds_Contact := prte_bip.persistnames().prepped_busreg_contacts;
	
  #OPTION('multiplePersistInstances',FALSE);
	export Busreg := BusReg.fBusReg_As_Business_Linking(ds_Company,ds_Contact) : persist(prte_bip.persistnames('busreg').abl);

	export all :=
	sequential(

		 output(enth(Busreg,1000),named('PRTE_As_Business_Linking_Busreg'),all)
	                              
	);

end;