import Business_HeaderV2;

export As_Business_Header(
	
	boolean pUsingInBusinessHeader = true	//if true, use using_in_business_header superfiles

) :=
module

	#OPTION('multiplePersistInstances',FALSE);
	
	shared basefile := if(pUsingInBusinessHeader, files().base.NJ.BusinessHeader, files().base.NJ.QA);

	export NJ := fAs_Business_Header_NJ(basefile) : persist(persistnames.AsBusinessHeaderNJ);

	export all :=
	sequential(

		 output(enth(NJ,1000),named('As_Business_Header_NJ'),all)
	                              
	);

end;