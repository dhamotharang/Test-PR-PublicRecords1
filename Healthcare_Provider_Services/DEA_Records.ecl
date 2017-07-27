import iesp,doxie,DeaV2_Services,DEA;
export DEA_Records(dataset(Doxie.layout_best) dsDids, dataset(doxie.layout_ref_bdid) dsBdids, dataset(doxie.ingenix_provider_module.layout_ingenix_provider_report) providers) := module
	shared getDEADataBackwardCompatibility(string deaNumber) := function
			rec:=if(trim(deaNumber,all)<> '',DEA.Key_dea_reg_num(dea_registration_number=deaNumber));
			iesp.healthcare.t_DEAControlledSubstanceRecordEx xform(DEA.layout_DEA_Out inRec) := TRANSFORM
				self.Number:=inRec.Dea_Registration_Number;
				self.RegistrationNumber:=inRec.Dea_Registration_Number;
				self.SSN := inRec.Best_SSN;
				self.CompanyName := inRec.Cname;
				self.Name := iesp.ecl2esp.SetName (inRec.fname, inRec.mname, inRec.lname, inRec.name_suffix, inRec.title, '');
				self.Address := iesp.ecl2esp.SetAddress (
						 inRec.prim_name, inRec.prim_range, inRec.predir, inRec.postdir,
						 inRec.addr_suffix, inRec.unit_desig, inRec.sec_range, inRec.p_city_name,
						 inRec.st, inRec.zip, inRec.zip4, '','', '', '', '');
				self.BusinessType := '';
				self.DrugSchedules := inRec.Drug_Schedules;
				self.ExpirationDate := iesp.ecl2esp.toDatestring8(inRec.expiration_date);
				self := [];
			end;

			recFmt:=project(sort(project(rec,transform(DEA.layout_DEA_Out, self:=left)),-expiration_date,-date_last_reported),xform(left));
			return recFmt;
	end;
	dsDeaRaw := doxie.DeaV2_records(dsDids,dsBdids);
	layout_dea_backward := record
		string deanumber:='';
	end;
	providerDea := dedup(normalize(providers,left.dea,transform(layout_dea_backward,self.deanumber :=right.deanumber;)),all);
	dsDeaBackwardCompatibility := if(not exists(dsDeaRaw) and exists(providerDea),getDEADataBackwardCompatibility(providerDea[1].deanumber));
	deaRecfmt := DeaV2_Services.Assorted_Layouts.Layout_Output;
	deaChild := DeaV2_Services.Assorted_Layouts.Layout_Output_Child;
	newfmt := record
		String9 Dea_Registration_Number;
		deaChild;
	end;
	outrec := iesp.healthcare.t_DEAControlledSubstanceRecordEx;

	newfmt NormIt(deaRecfmt L, INTEGER C) := TRANSFORM
		tmp := project(L.children[C],transform(deaChild, self := left)); 
		SELF.Dea_Registration_Number := L.Dea_Registration_Number;
		self := tmp;
	END;
	deaNorm := dedup(sort(NORMALIZE(dsDeaRaw,left.children,normit(left,counter)),-expiration_date,Dea_Registration_Number),expiration_date, Dea_Registration_Number);

	outrec xform(newfmt inRec) := TRANSFORM
		self.Number:=inRec.Dea_Registration_Number;
		self.RegistrationNumber:=inRec.Dea_Registration_Number;
		self.SSN := inRec.Best_SSN;
		self.CompanyName := inRec.Cname;
		self.Name := iesp.ecl2esp.SetName (inRec.fname, inRec.mname, inRec.lname, inRec.name_suffix, inRec.title, inRec.Name);
		self.Address := iesp.ecl2esp.SetAddress (
				 inRec.prim_name, inRec.prim_range, inRec.predir, inRec.postdir,
				 inRec.addr_suffix, inRec.unit_desig, inRec.sec_range, inRec.p_city_name,
				 inRec.st, inRec.zip, inRec.zip4, '','', inRec.Address, '', '');
		self.BusinessType := inRec.Bussiness_Type;
		self.DrugSchedules := inRec.Drug_Schedules;
		self.ExpirationDate := iesp.ecl2esp.toDatestring8(inRec.expiration_date);
		self := [];
	end;

	export dsDEA := choosen(if(exists(dsDeaRaw),project(deaNorm,xform(left)),dsDeaBackwardCompatibility),iesp.Constants.HPR.MAX_DEAS);
end;
