IMPORT Seed_Files,Data_Services, ut,doxie, risk_indicators;
 
 export proc_build_riskview2report_Keys(string filedate) := function



	shared locat := Data_Services.Data_location.Prefix('NONAMEGIVEN') + 'prte::key::riskview2report::'+filedate+'::';
	
	d := Seed_Files.RiskView2_Report_files.Summary;
	d1 := project(dataset([],recordof(d)),transform(recordof(d),self := []));
	
	newrec := record
data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d1.fname)),
																									trim((string20)stringlib.stringtouppercase(d1.lname)),
																									trim((string9)d1.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d1.zip),
																									trim((string10)d1.hphone),
																									risk_indicators.nullstring); 	  
d1;
	end;
	newtable := table(d1, newrec);
	 Summary := index(newtable,{dataset_name,hashvalue}, {newtable}, 
											locat + 'Summary');


	d2 := Seed_Files.RiskView2_Report_files.AddressHistory;
		d3 := project(dataset([],recordof(d2)),transform(recordof(d2),self := []));

newrec13 := record
data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d3.fname)),
																									trim((string20)stringlib.stringtouppercase(d3.lname)),
																									trim((string9)d3.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d3.zip),
																									trim((string10)d3.hphone),
																									risk_indicators.nullstring); 
	d3;
	end;
	newtable2 := table(d3, newrec13);
	 
	 
	 AddressHistory := index(newtable2,{dataset_name,hashvalue}, {newtable2}, 
											locat + 'addresshistory');		

	d4 := Seed_Files.RiskView2_Report_files.RealProperty;
	
		d5 := project(dataset([],recordof(d4)),transform(recordof(d4),self := []));

	newrec1 := record
data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d5.fname)),
																									trim((string20)stringlib.stringtouppercase(d5.lname)),
																									trim((string9)d5.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d5.zip),
																									trim((string10)d5.hphone),
																									risk_indicators.nullstring); 
	d5;
	end;
	newtable3 := table(d5, newrec1);
	 RealProperty := index(newtable3,{dataset_name,hashvalue}, {newtable3}, 
											locat + 'realproperty');		

	d6 := Seed_Files.RiskView2_Report_files.PersonalProperty;
		d7 := project(dataset([],recordof(d6)),transform(recordof(d6),self := []));

	newrec2 := record
data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d7.fname)),
																									trim((string20)stringlib.stringtouppercase(d7.lname)),
																									trim((string9)d7.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d7.zip),
																									trim((string10)d7.hphone),
																									risk_indicators.nullstring); 
d7;
	end;
	newtable4 := table(d7, newrec2);
	 PersonalProperty := index(newtable4,{dataset_name,hashvalue}, {newtable4}, 
											locat + 'personalproperty');		

	d8 := Seed_Files.RiskView2_Report_files.Filing;
		d9 := project(dataset([],recordof(d8)),transform(recordof(d8),self := []));

	newrec3 := record
data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d9.fname)),
																									trim((string20)stringlib.stringtouppercase(d9.lname)),
																									trim((string9)d9.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d9.zip),
																									trim((string10)d9.hphone),
																									risk_indicators.nullstring); 
d9;
	end;
	newtable5 := table(d9, newrec3);
	 filing := index(newtable5,{dataset_name,hashvalue}, {newtable5}, 
											locat + 'filing');		

	d10 := Seed_Files.RiskView2_Report_files.Bankruptcy;
		d11 := project(dataset([],recordof(d10)),transform(recordof(d10),self := []));

	newrec4 := record
data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d11.fname)),
																									trim((string20)stringlib.stringtouppercase(d11.lname)),
																									trim((string9)d11.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d11.zip),
																									trim((string10)d11.hphone),
																									risk_indicators.nullstring); 
d11;
	end;
	newtable6 := table(d11, newrec4);
	 Bankruptcy := index(newtable6,{dataset_name,hashvalue}, {newtable6}, 
											locat + 'bankruptcy');		

	d12 := Seed_Files.RiskView2_Report_files.Criminal;
			d13 := project(dataset([],recordof(d12)),transform(recordof(d12),self := []));

	newrec5 := record
data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d13.fname)),
																									trim((string20)stringlib.stringtouppercase(d13.lname)),
																									trim((string9)d13.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d13.zip),
																									trim((string10)d13.hphone),
																									risk_indicators.nullstring); 
d13;
	end;
	newtable7 := table(d13, newrec5);
	 Criminal := index(newtable7,{dataset_name,hashvalue}, {newtable7}, 
											locat + 'criminal');		

	d14 := Seed_Files.RiskView2_Report_files.Education;
		d15 := project(dataset([],recordof(d14)),transform(recordof(d14),self := []));

	newrec6 := record
data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d15.fname)),
																									trim((string20)stringlib.stringtouppercase(d15.lname)),
																									trim((string9)d15.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d15.zip),
																									trim((string10)d15.hphone),
																									risk_indicators.nullstring); 
d15;
	end;
	newtable8 := table(d15, newrec6);
	 Education := index(newtable8,{dataset_name,hashvalue}, {newtable8}, 
											locat + 'education');		

	d16:= Seed_Files.RiskView2_Report_files.License;
		d17 := project(dataset([],recordof(d16)),transform(recordof(d16),self := []));

	newrec7 := record
data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d17.fname)),
																									trim((string20)stringlib.stringtouppercase(d17.lname)),
																									trim((string9)d17.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d17.zip),
																									trim((string10)d17.hphone),
																									risk_indicators.nullstring); 
d17;
	end;
	newtable9 := table(d17, newrec7);
	 License := index(newtable9,{dataset_name,hashvalue}, {newtable9}, 
											locat + 'license');		

	d18 := Seed_Files.RiskView2_Report_files.BusinessAssociation;
		d19 := project(dataset([],recordof(d18)),transform(recordof(d18),self := []));

	newrec8 := record
data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d19.fname)),
																									trim((string20)stringlib.stringtouppercase(d19.lname)),
																									trim((string9)d19.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d19.zip),
																									trim((string10)d19.hphone),
																									risk_indicators.nullstring); 
d19;
	end;
	newtable10 := table(d19, newrec8);
	 BusinessAssociation := index(newtable10,{dataset_name,hashvalue}, {newtable10}, 
											locat + 'businessassociation');		

	d20 := Seed_Files.RiskView2_Report_files.LoanOffer;
		d21 := project(dataset([],recordof(d20)),transform(recordof(d20),self := []));

	newrec9 := record
data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d21.fname)),
																									trim((string20)stringlib.stringtouppercase(d21.lname)),
																									trim((string9)d21.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d21.zip),
																									trim((string10)d21.hphone),
																									risk_indicators.nullstring); 
d21;
	end;
	newtable11 := table(d21, newrec9);
	 LoanOffer := index(newtable11,{dataset_name,hashvalue}, {newtable11}, 
											locat + 'loanoffer');		

	d22 := Seed_Files.RiskView2_Report_files.CreditInquiry;
		d23 := project(dataset([],recordof(d22)),transform(recordof(d22),self := []));

	newrec10 := record
data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d23.fname)),
																									trim((string20)stringlib.stringtouppercase(d23.lname)),
																									trim((string9)d23.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d23.zip),
																									trim((string10)d23.hphone),
																									risk_indicators.nullstring); 
d23;
	end;
	newtable12 := table(d23, newrec10);
	 CreditInquiry := index(newtable12,{dataset_name,hashvalue}, {newtable12}, 
											locat + 'creditinquiry');	
	
	d24 := Seed_Files.RiskView2_Report_files.Purchase;
	
		d25 := project(dataset([],recordof(d24)),transform(recordof(d24),self := []));
		
newrec11 := record
data16 hashvalue := seed_files.Hash_InstantID(trim((string15)stringlib.stringtouppercase(d25.fname)),
																									trim((string20)stringlib.stringtouppercase(d25.lname)),
																									trim((string9)d25.in_ssn),
																									risk_indicators.nullstring,
																									trim((string9)d25.zip),
																									trim((string10)d25.hphone),
																									risk_indicators.nullstring); 
d25;
	end;
	newtable13 := table(d25, newrec11);
	 Purchase := index(newtable13,{dataset_name,hashvalue}, {newtable13}, 
											locat + 'purchase');	
											
build_all := Sequential(
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
buildindex(CreditInquiry,overwrite),
buildindex(Purchase,overwrite));

return build_all;
end;





