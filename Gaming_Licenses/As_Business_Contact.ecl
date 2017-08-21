export As_Business_Contact(
	
	boolean pUsingInBusinessHeader = true	//if true, use using_in_business_header superfiles

) :=
module

	#OPTION('multiplePersistInstances',FALSE);
	
	shared basefile := if(pUsingInBusinessHeader, files().base.NJ.BusinessHeader, files().base.NJ.QA);
	
	export NJ := fAs_Business_Contact_NJ(basefile) : persist(persistnames.AsBusinessContactNJ);

	export all :=
	sequential(

		 output(enth(NJ,1000),named('As_Business_Contact_NJ'),all)
	
	);
	
end;