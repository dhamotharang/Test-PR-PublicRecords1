export applyRegulatory := module

	export simple_append(base_ds, filename, Drop_Layout) := functionmacro

		import header_services;
		
		header_services.Supplemental_Data.mac_verify(filename, Drop_Layout, attr);

		Base_File_Append_In := attr();
	 
		recordof(base_ds) reformat_append(Base_File_Append_In L) := transform
			self := L;
			self := [];
		end;
	 
		Base_File_Append := project(Base_File_Append_In, reformat_append(left));

		return base_ds + Base_file_append;

	endmacro; // simple_append

	export simple_sup(base_ds, filename, hashFunc) := functionmacro
		import header_services;
		supLayout := header_services.Supplemental_Data.layout_in;
		header_services.Supplemental_Data.mac_verify(filename, supLayout, sup_In);
		dSuppressedIn := project(sup_In(), header_services.Supplemental_Data.in_to_out(left));
		
		return join(base_ds, dSuppressedIn, hashFunc(left) = right.hval, transform(left), left only, lookup);

		// return base_ds;
	endmacro;

	export applyBIPV2(ds) := functionmacro
		bdidAddrSupHash(recordof(ds) rec) := hashmd5(intformat(rec.company_bdid, 12, 1), rec.st, rec.zip,
		                                             rec.v_city_name, rec.prim_name, rec.prim_range, rec.predir,
		                                             rec.addr_suffix, rec.postdir, rec.sec_range);
		bdidAddrSup := Suppress.applyRegulatory.simple_sup(ds, 'didaddressbusiness_sup.txt', bdidAddrSupHash);

		contactsAllSupHash(recordof(ds) rec) := hashmd5(intformat(rec.company_bdid, 12, 1));
		contactsAllSup := bdidAddrSup(isContact != 'T')
		                + Suppress.applyRegulatory.simple_sup(bdidAddrSup(isContact = 'T'), 'businesscontactsall_sup.txt', contactsAllSupHash);

		contactsSupHash(recordof(ds) rec) := hashmd5(intformat(rec.company_bdid, 12, 1), intformat(rec.contact_did, 12, 1));
		contactsSup := contactsAllSup(isContact != 'T')
		             + Suppress.applyRegulatory.simple_sup(contactsAllSup(isContact = 'T'), 'businesscontacts_sup.txt', contactsSupHash);

		contactsTitleSupHash(recordof(ds) rec) := hashmd5(intformat(rec.company_bdid, 12, 1), rec.contact_job_title_raw, rec.lname, rec.fname);
		contactsTitleSup := contactsSup(isContact != 'T')
		                  + Suppress.applyRegulatory.simple_sup(contactsSup(isContact = 'T'), 'businesscontactsbytitle_sup.txt', contactsTitleSuphash);

		return Suppress.applyRegulatory.simple_append(contactsTitleSup, 'file_bipv2_inj.txt', recordof(ds));
	endmacro;

end;