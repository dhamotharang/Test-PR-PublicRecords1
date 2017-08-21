import Business_HeaderV2,ut;

export As_Business_Header(
	
	boolean pUsingInBusinessHeader = true	//if true, use using_in_business_header superfiles

) :=
module
	
	#OPTION('multiplePersistInstances',FALSE);
	
	shared basefile := if(pUsingInBusinessHeader, Business_HeaderV2.Source_Files.gongv2_master.BusinessHeader, dataset(ut.foreign_prod + gong_v2.thor_cluster+'base::gongv2_master',Gong_v2.layout_gongMasterAid,thor));

	export GongV2 := fAs_Business_Header(basefile) : persist('~thor_data400::persist::Gong_v2::As_Business_Header');

	export all :=
	sequential(

		 output(enth(GongV2,1000),named('As_Business_Header_GongV2'			),all)
		,output(count(GongV2		),named('countAs_Business_Header_GongV2'),all)
	                              
	);

end;