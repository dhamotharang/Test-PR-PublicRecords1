
IMPORT Data_Services, ut,doxie;


EXPORT RiskViewReport_keys := MODULE

	shared locat := Data_Services.Data_location.Prefix('NONAMEGIVEN') + 'thor_data400::key::riskviewreport::';
	
	d := Seed_Files.RiskviewReport_files.Summary;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.in_ssn, '', d.zip, d.hphone, '');
	  d;
	end;
	newtable := table(d, newrec);
	export Summary := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											locat + 'Summary_'+ doxie.Version_SuperKey);


	d := Seed_Files.RiskviewReport_files.AddressHistory;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.in_ssn, '', d.zip, d.hphone, '');
	  d;
	end;
	newtable := table(d, newrec);
	export AddressHistory := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											locat + 'addresshistory_'+ doxie.Version_SuperKey);		

	d := Seed_Files.RiskviewReport_files.RealProperty;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.in_ssn, '', d.zip, d.hphone, '');
	  d;
	end;
	newtable := table(d, newrec);
	export RealProperty := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											locat + 'realproperty_'+ doxie.Version_SuperKey);		

	d := Seed_Files.RiskviewReport_files.PersonalProperty;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.in_ssn, '', d.zip, d.hphone, '');
	  d;
	end;
	newtable := table(d, newrec);
	export PersonalProperty := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											locat + 'personalproperty_'+ doxie.Version_SuperKey);		

	d := Seed_Files.RiskviewReport_files.Filing;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.in_ssn, '', d.zip, d.hphone, '');
	  d;
	end;
	newtable := table(d, newrec);
	export filing := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											locat + 'filing_'+ doxie.Version_SuperKey);		

	d := Seed_Files.RiskviewReport_files.Bankruptcy;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.in_ssn, '', d.zip, d.hphone, '');
	  d;
	end;
	newtable := table(d, newrec);
	export Bankruptcy := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											locat + 'bankruptcy_'+ doxie.Version_SuperKey);		

	d := Seed_Files.RiskviewReport_files.Criminal;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.in_ssn, '', d.zip, d.hphone, '');
	  d;
	end;
	newtable := table(d, newrec);
	export Criminal := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											locat + 'criminal_'+ doxie.Version_SuperKey);		

	d := Seed_Files.RiskviewReport_files.Education;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.in_ssn, '', d.zip, d.hphone, '');
	  d;
	end;
	newtable := table(d, newrec);
	export Education := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											locat + 'education_'+ doxie.Version_SuperKey);		

	d := Seed_Files.RiskviewReport_files.License;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.in_ssn, '', d.zip, d.hphone, '');
	  d;
	end;
	newtable := table(d, newrec);
	export License := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											locat + 'license_'+ doxie.Version_SuperKey);		

	d := Seed_Files.RiskviewReport_files.BusinessAssociation;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.in_ssn, '', d.zip, d.hphone, '');
	  d;
	end;
	newtable := table(d, newrec);
	export BusinessAssociation := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											locat + 'businessassociation_'+ doxie.Version_SuperKey);		

	d := Seed_Files.RiskviewReport_files.LoanOffer;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.in_ssn, '', d.zip, d.hphone, '');
	  d;
	end;
	newtable := table(d, newrec);
	export LoanOffer := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											locat + 'loanoffer_'+ doxie.Version_SuperKey);		

	d := Seed_Files.RiskviewReport_files.CreditInquiry;
	newrec := record
		data16 hashvalue := seed_files.Hash_InstantID(d.fname, d.lname, d.in_ssn, '', d.zip, d.hphone, '');
	  d;
	end;
	newtable := table(d, newrec);
	export CreditInquiry := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											locat + 'creditinquiry_'+ doxie.Version_SuperKey);		
END;