import doxie,BankruptcyV2_Services,iesp,AutoStandardI,PersonReports,TopBusiness_Services;
export Bankruptcies_Records(dataset(doxie.layout_references) dsDids, dataset(doxie.layout_ref_bdid) dsBdids) := module
	shared getBusBankruptcy(dataset(doxie.layout_ref_bdid) dsBdids, string ssnMaskValue) := function
			// Below code taken from TopBusiness_Services.BankruptcySource_Records
			out_rec := iesp.bankruptcy.t_BankruptcyReport2Record;
			bankruptcies := BankruptcyV2_Services.bankruptcy_raw(false).source_view (in_bdids := dsBdids, in_ssn_mask := ssnMaskValue); 
			return iesp.transform_bankruptcy_v2(bankruptcies);
	end;
	emptyMod := module(project (AutoStandardI.GlobalModule(), PersonReports.input.dummy_search, opt))
					export STRING30 	LastName := '';      			
					export STRING30 	FirstName := '';
					export STRING30 	MiddleName := '';
					export string120  CompanyName := '';
					export string11 	Fein := '';
					export string25 	City := '';
					export string2	 	State := '';
					export string6	 	Zip := '';
					export unsigned8 	DOB := 0;
					export string		 	LicenseNumber := '';
					export string2	 	LicenseState := '';
					export string11 	SSN := '';
					export real 			latitude  := 0.0;
					export real 			longitude := 0.0;
					export string			BDL := '';
					export string50		DriversLicense := '';
	end;
	dsBankruptciesInd := choosen(PersonReports.bankruptcy_records(dsDids,module (project (emptyMod, PersonReports.input.bankruptcy, opt)) end).bankruptcy_v2,iesp.Constants.BR.MaxBankruptcies);
	export dsBankruptciesIndividual := project(dsBankruptciesInd, transform(iesp.bankruptcy.t_BankruptcyReport2Record,
																														dsDebtors:=project(left.debtors,transform(doxie.layout_references,self.did:=(unsigned6)left.uniqueid));
																														RecFound:=if(count(join(dsDebtors,dsDids,left.did=right.did))>0,true,false);
																														self.corpflag := if(RecFound,left.corpflag,skip);
																														self := left;));
	dsBankruptciesBus := choosen(getBusBankruptcy(dsBdids,AutoStandardI.GlobalModule().ssnmask),iesp.Constants.BR.MaxBankruptcies);
	export dsBankruptciesBusiness := project(dsBankruptciesBus, transform(iesp.bankruptcy.t_BankruptcyReport2Record,
																														dsDebtors:=project(left.debtors,transform(doxie.layout_ref_bdid,self.bdid:=(unsigned6)left.businessid));
																														RecFound:=if(count(join(dsDebtors,dsBdids,left.bdid=right.bdid))>0,true,false);
																														self.corpflag := if(RecFound,left.corpflag,skip);
																														self := left;));
end;
