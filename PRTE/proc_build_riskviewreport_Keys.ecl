IMPORT Seed_Files,Data_Services, ut,doxie;
 
 export proc_build_riskviewreport_Keys(string filedate) := function



	shared locat := Data_Services.Data_location.Prefix('NONAMEGIVEN') + 'prte::key::riskviewreport::'+filedate+'::';
	
	d := Seed_Files.RiskviewReport_files.Summary;
	d1 := project(dataset([],recordof(d)),transform(recordof(d),self := []));
	
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(d1.fname, d1.lname, d1.in_ssn, '', d1.zip, d1.hphone, '');
	  d1;
	end;
	newtable := table(d1, newrec);
	 Summary := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											locat + 'Summary');


	d2 := Seed_Files.RiskviewReport_files.AddressHistory;
		d3 := project(dataset([],recordof(d2)),transform(recordof(d2),self := []));

newrec13 := record
		data16 hashvalue := seed_files.Hash_InstantID(d3.fname, d3.lname, d3.in_ssn, '', d3.zip, d3.hphone, '');
	  d3;
	end;
	newtable2 := table(d3, newrec13);
	 
	 
	 AddressHistory := index(newtable2,{dataset_name,hashvalue}, {newtable2}, 
											locat + 'addresshistory');		

	d4 := Seed_Files.RiskviewReport_files.RealProperty;
	
		d5 := project(dataset([],recordof(d4)),transform(recordof(d4),self := []));

	newrec1 := record
		data16 hashvalue := seed_files.Hash_InstantID(d5.fname, d5.lname, d5.in_ssn, '', d5.zip, d5.hphone, '');
	  d5;
	end;
	newtable3 := table(d5, newrec1);
	 RealProperty := index(newtable3,{dataset_name,hashvalue}, {newtable3}, 
											locat + 'realproperty');		

	d6 := Seed_Files.RiskviewReport_files.PersonalProperty;
		d7 := project(dataset([],recordof(d6)),transform(recordof(d6),self := []));

	newrec2 := record
		data16 hashvalue := seed_files.Hash_InstantID(d7.fname, d7.lname, d7.in_ssn, '', d7.zip, d7.hphone, '');
	  d7;
	end;
	newtable4 := table(d7, newrec2);
	 PersonalProperty := index(newtable4,{dataset_name,hashvalue}, {newtable4}, 
											locat + 'personalproperty');		

	d8 := Seed_Files.RiskviewReport_files.Filing;
		d9 := project(dataset([],recordof(d8)),transform(recordof(d8),self := []));

	newrec3 := record
		data16 hashvalue := seed_files.Hash_InstantID(d9.fname, d9.lname, d9.in_ssn, '', d9.zip, d9.hphone, '');
	  d9;
	end;
	newtable5 := table(d9, newrec3);
	 filing := index(newtable5,{dataset_name,hashvalue}, {newtable5}, 
											locat + 'filing');		

	d10 := Seed_Files.RiskviewReport_files.Bankruptcy;
		d11 := project(dataset([],recordof(d10)),transform(recordof(d10),self := []));

	newrec4 := record
		data16 hashvalue := seed_files.Hash_InstantID(d11.fname, d11.lname, d11.in_ssn, '', d11.zip, d11.hphone, '');
	  d11;
	end;
	newtable6 := table(d11, newrec4);
	 Bankruptcy := index(newtable6,{dataset_name,hashvalue}, {newtable6}, 
											locat + 'bankruptcy');		

	d12 := Seed_Files.RiskviewReport_files.Criminal;
			d13 := project(dataset([],recordof(d12)),transform(recordof(d12),self := []));

	newrec5 := record
		data16 hashvalue := seed_files.Hash_InstantID(d13.fname, d13.lname, d13.in_ssn, '', d13.zip, d13.hphone, '');
	  d13;
	end;
	newtable7 := table(d13, newrec5);
	 Criminal := index(newtable7,{dataset_name,hashvalue}, {newtable7}, 
											locat + 'criminal');		

	d14 := Seed_Files.RiskviewReport_files.Education;
		d15 := project(dataset([],recordof(d14)),transform(recordof(d14),self := []));

	newrec6 := record
		data16 hashvalue := seed_files.Hash_InstantID(d15.fname, d15.lname, d15.in_ssn, '', d15.zip, d15.hphone, '');
	  d15;
	end;
	newtable8 := table(d15, newrec6);
	 Education := index(newtable8,{dataset_name,hashvalue}, {newtable8}, 
											locat + 'education');		

	d16:= Seed_Files.RiskviewReport_files.License;
		d17 := project(dataset([],recordof(d16)),transform(recordof(d16),self := []));

	newrec7 := record
		data16 hashvalue := seed_files.Hash_InstantID(d17.fname, d17.lname, d17.in_ssn, '', d17.zip, d17.hphone, '');
	  d17;
	end;
	newtable9 := table(d17, newrec7);
	 License := index(newtable9,{dataset_name,hashvalue}, {newtable9}, 
											locat + 'license');		

	d18 := Seed_Files.RiskviewReport_files.BusinessAssociation;
		d19 := project(dataset([],recordof(d18)),transform(recordof(d18),self := []));

	newrec8 := record
		data16 hashvalue := seed_files.Hash_InstantID(d19.fname, d19.lname, d19.in_ssn, '', d19.zip, d19.hphone, '');
	  d19;
	end;
	newtable10 := table(d19, newrec8);
	 BusinessAssociation := index(newtable10,{dataset_name,hashvalue}, {newtable10}, 
											locat + 'businessassociation');		

	d20 := Seed_Files.RiskviewReport_files.LoanOffer;
		d21 := project(dataset([],recordof(d20)),transform(recordof(d20),self := []));

	newrec9 := record
		data16 hashvalue := seed_files.Hash_InstantID(d21.fname, d21.lname, d21.in_ssn, '', d21.zip, d21.hphone, '');
	  d21;
	end;
	newtable11 := table(d21, newrec9);
	 LoanOffer := index(newtable11,{dataset_name,hashvalue}, {newtable11}, 
											locat + 'loanoffer');		

	d22 := Seed_Files.RiskviewReport_files.CreditInquiry;
		d23 := project(dataset([],recordof(d22)),transform(recordof(d22),self := []));

	newrec10 := record
		data16 hashvalue := seed_files.Hash_InstantID(d23.fname, d23.lname, d23.in_ssn, '', d23.zip, d23.hphone, '');
	  d23;
	end;
	newtable12 := table(d23, newrec10);
	 CreditInquiry := index(newtable12,{dataset_name,hashvalue}, {newtable12}, 
											locat + 'creditinquiry');	
											
build_all := parallel(
buildindex(Summary,overwrite),
buildindex(AddressHistory,overwrite),
buildindex(RealProperty,overwrite),
buildindex(PersonalProperty,overwrite),
buildindex(filing,overwrite),
buildindex(Bankruptcy,overwrite),
buildindex(Criminal,overwrite),
buildindex(Education,overwrite),
buildindex(License,overwrite),
buildindex(BusinessAssociation,overwrite),
buildindex(LoanOffer,overwrite),
buildindex(CreditInquiry,overwrite));

return build_all;
end;





