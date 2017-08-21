export As_Business :=
module

	#OPTION('multiplePersistInstances',FALSE);
	
	export Header := Spoke.fAs_business.fHeader(files().base.BusinessHeader)
		: PERSIST(persistnames().asbusinessheader);

	export Contact := Spoke.fAs_business.fContact(files().base.BusinessHeader)
		: PERSIST(persistnames().asbusinessContact);
	

end;