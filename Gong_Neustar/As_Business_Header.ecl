import Business_HeaderV2,ut,gong_neustar;

export As_Business_Header(
	
	boolean pUsingInBusinessHeader = true	//if true, use using_in_business_header superfiles

) :=
module
	
	#OPTION('multiplePersistInstances',FALSE);
	
	shared basefile := if(pUsingInBusinessHeader, Business_HeaderV2.Source_Files.gong_Neustar.BusinessHeader, 
															gong_neustar.File_GongHistory);
	
	export GongV2 := gong_neustar.fAs_Business_Header(basefile) : persist('~thor_data400::persist::Gong_neu::As_Business_Header');

	export all :=
	sequential(

		 output(enth(GongV2,1000),named('As_Business_Header_GongV2'			),all)
		,output(count(GongV2		),named('countAs_Business_Header_GongV2'),all)
	                              
	);

end;