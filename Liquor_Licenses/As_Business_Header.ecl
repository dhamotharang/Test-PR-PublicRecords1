import Business_HeaderV2;

export As_Business_Header :=
module

	#OPTION('multiplePersistInstances',FALSE);
	
	export CA := fAs_Business_Header_CA(files().base.CA.BusinessHeader) : persist(persistnames.AsBusinessHeaderCA);
	export CT := fAs_Business_Header_CT(files().base.CT.BusinessHeader) : persist(persistnames.AsBusinessHeaderCT);
	export IN := fAs_Business_Header_IN(files().base.IN.BusinessHeader) : persist(persistnames.AsBusinessHeaderIN);
	export LA := fAs_Business_Header_LA(files().base.LA.BusinessHeader) : persist(persistnames.AsBusinessHeaderLA);
	export OH := fAs_Business_Header_OH(files().base.OH.BusinessHeader) : persist(persistnames.AsBusinessHeaderOH);
	export PA := fAs_Business_Header_PA(files().base.PA.BusinessHeader) : persist(persistnames.AsBusinessHeaderPA);
	export TX := fAs_Business_Header_TX(files().base.TX.BusinessHeader) : persist(persistnames.AsBusinessHeaderTX);

	export all :=
	sequential(

		 output(enth(CA,1000),named('As_Business_Header_CA'),all)
		,output(enth(CT,1000),named('As_Business_Header_CT'),all)
		,output(enth(IN,1000),named('As_Business_Header_IN'),all)
		,output(enth(LA,1000),named('As_Business_Header_LA'),all)
		,output(enth(OH,1000),named('As_Business_Header_OH'),all)
		,output(enth(PA,1000),named('As_Business_Header_PA'),all)
		,output(enth(TX,1000),named('As_Business_Header_TX'),all)
	                              
	);

end;