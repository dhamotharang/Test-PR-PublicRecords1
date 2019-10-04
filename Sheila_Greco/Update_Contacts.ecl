import _control, MDR, std;

export Update_Contacts(

	 dataset(layouts.Input.Sprayed		)	pUpdateFile
	,dataset(Layouts.Base.Contacts		)	pBaseFile
	,dataset(Layouts.Base.Companies		)	pCompaniesBaseFile
	,string															pversion

) :=
function
  Contacts 								:= Prep_Contacts(pUpdateFile, pversion);
	dStandardizedInputFile	:= Standardize_Contacts.fAll(Contacts, pCompaniesBaseFile	);
	base_file 							:= project(pBaseFile, transform(Layouts.Base.Contacts, self.record_type := 'H'; self := left));

	update_combined					:= map(_Flags.Update.Contacts =>	 dStandardizedInputFile + base_file
																														,dStandardizedInputFile
															);

	addGlobalSID						:= MDR.macGetGlobalSid(update_combined, 'SheilaGrecoContact', '', 'global_sid'); //DF : Populate Global_SID;
	
	dStandardizedAddr				:= Standardize_Addr_Contacts	(addGlobalSID		);	
	dAppendIds							:= Append_Ids.fAppendDid			(dStandardizedAddr	);
	dRollup									:= Rollup_Contacts						(dAppendIds					);

	return dRollup;

end;