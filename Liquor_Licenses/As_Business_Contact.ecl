export As_Business_Contact :=
module

	#OPTION('multiplePersistInstances',FALSE);
	
	export CA := fAs_Business_Contact_CA(files().base.CA.BusinessHeader) : persist(persistnames.AsBusinessContactCA);
	export CT := fAs_Business_Contact_CT(files().base.CT.BusinessHeader) : persist(persistnames.AsBusinessContactCT);
	export IN := fAs_Business_Contact_IN(files().base.IN.BusinessHeader) : persist(persistnames.AsBusinessContactIN);
	export LA := fAs_Business_Contact_LA(files().base.LA.BusinessHeader) : persist(persistnames.AsBusinessContactLA);
	export OH := fAs_Business_Contact_OH(files().base.OH.BusinessHeader) : persist(persistnames.AsBusinessContactOH);
	export PA := fAs_Business_Contact_PA(files().base.PA.BusinessHeader) : persist(persistnames.AsBusinessContactPA);
	export TX := fAs_Business_Contact_TX(files().base.TX.BusinessHeader) : persist(persistnames.AsBusinessContactTX);

	export all :=
	sequential(

		 output(enth(CA,1000),named('As_Business_Contact_CA'),all)
		,output(enth(CT,1000),named('As_Business_Contact_CT'),all)
		,output(enth(IN,1000),named('As_Business_Contact_IN'),all)
		,output(enth(LA,1000),named('As_Business_Contact_LA'),all)
		,output(enth(OH,1000),named('As_Business_Contact_OH'),all)
		,output(enth(PA,1000),named('As_Business_Contact_PA'),all)
		,output(enth(TX,1000),named('As_Business_Contact_TX'),all)
	
	);
	
end;