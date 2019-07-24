import doxie, BankruptcyV2_Services, iesp, AutoStandardI, PersonReports;

export Bankruptcies_Records(dataset(doxie.layout_references) dsDids, dataset(doxie.layout_ref_bdid) dsBdids) := module

	shared getBusBankruptcy(dataset(doxie.layout_ref_bdid) dsBdids, string ssnMaskValue) := function
			// Below code taken from TopBusiness_Services.BankruptcySource_Records
			out_rec := iesp.bankruptcy.t_BankruptcyReport2Record;
			bankruptcies := BankruptcyV2_Services.bankruptcy_raw(false).source_view (in_bdids := dsBdids, in_ssn_mask := ssnMaskValue); 
			return iesp.transform_bankruptcy_v2(bankruptcies);
	end;

  shared gmod := AutoStandardI.GlobalModule();
  shared mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(gmod);
  bk_mod := PROJECT (gmod, PersonReports.IParam.bankruptcy, OPT);
	dsBankruptciesInd := choosen(PersonReports.bankruptcy_records(dsDids, mod_access, bk_mod).bankruptcy_v2,iesp.Constants.BR.MaxBankruptcies);

	export dsBankruptciesIndividual := project(dsBankruptciesInd, transform(iesp.bankruptcy.t_BankruptcyReport2Record,
																														dsDebtors:=project(left.debtors,transform(doxie.layout_references,self.did:=(unsigned6)left.uniqueid));
																														RecFound:=if(count(join(dsDebtors,dsDids,left.did=right.did))>0,true,false);
																														self.corpflag := if(RecFound,left.corpflag,skip);
																														self := left;));
	dsBankruptciesBus := choosen(getBusBankruptcy(dsBdids,mod_access.ssn_mask),iesp.Constants.BR.MaxBankruptcies);

	export dsBankruptciesBusiness := project(dsBankruptciesBus, transform(iesp.bankruptcy.t_BankruptcyReport2Record,
																														dsDebtors:=project(left.debtors,transform(doxie.layout_ref_bdid,self.bdid:=(unsigned6)left.businessid));
																														RecFound:=if(count(join(dsDebtors,dsBdids,left.bdid=right.bdid))>0,true,false);
																														self.corpflag := if(RecFound,left.corpflag,skip);
																														self := left;));
end;
