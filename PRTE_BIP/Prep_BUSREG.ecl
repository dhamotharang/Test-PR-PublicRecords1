import BusReg, PRTE_CSV, ut;

export Prep_BUSREG := module

	shared ds_company  := PRTE_CSV.BusReg().dthor_data400__key__BusReg__company_bdid(ut.fnTrim2Upper(company_name)<>'');
  shared ds_contact	 := PRTE_CSV.BusReg().dthor_data400__key__BusReg__contact_bdid(name_first <> '' or name_last <> '');

	export prte_busreg_companies_prepped	:= project(ds_company,transform(PRTE_BIP.Layouts_BusReg.Companies,self := left; self := [];))
																				:  persist(PRTE_BIP.persistnames('busreg_companies').prepped);														
																								
	export prte_busreg_contacts_prepped		:= project(ds_contact,transform(PRTE_BIP.Layouts_BusReg.Contacts,self := left; self := [];))
																				:  persist(PRTE_BIP.persistnames('busreg_contacts').prepped);
	
	export All := sequential(output(prte_busreg_companies_prepped), output(prte_busreg_contacts_prepped));
	
end;				