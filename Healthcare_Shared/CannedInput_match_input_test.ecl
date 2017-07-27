#Stored('DPPAPurpose',1);
#Stored('GLBPurpose',5);
#Stored('DataRestrictionMask','111111111111111111');
#WORKUNIT('name','HC MPRD Test - Match Input');    //name it "MyJob"
import Healthcare_Shared,Address,STD,zz_sburdick;
rec_in := Healthcare_Shared.layouts_commonized.std_record_struct;

rec_in setinput():=transform
			self.acctno := '1';
	//Name INPUT
		set_name := healthcare_shared.Fn_set_match_input.set_name('William B Abbott III');
			self.name_in := set_name.name_in;
			self.name_key:= set_name.name_key;		
			self.full_name := set_name.full_name;
			self.pre_name:= set_name.pre_name;
			self.first_name:= set_name.first_name;
			self.middle_name:= set_name.middle_name;
			self.last_name:= set_name.last_name;
			self.maturity_suffix:= set_name.maturity_suffix;
			self.other_suffix:= set_name.other_suffix;
			self.gender:= set_name.gender;
			self.preferred_name:= set_name.preferred_name;
			self.name_confidence:= set_name.name_confidence;
			self.name_st:= set_name.name_st;
	//UPIN
			self.upin_in := 'G84299';
			self.upin := healthcare_shared.Fn_set_match_input.set_UPIN(self.upin_in).upin;
			self.upin_st := healthcare_shared.Fn_set_match_input.set_UPIN(self.upin_in).upin_st;
	//NPI
			self.npi_in := healthcare_shared.Fn_Set_Match_Input.set_npi('').npi_in;
			self.npi_num := Healthcare_Shared.Functions.cleanOnlyNumbers(self.npi_in);
			self.npi_st := IF(self.npi_in = '', Healthcare_Shared.constants.stat_Missing, 0);
	//PracAddress 1
		self.prac1 := healthcare_shared.Fn_Set_Match_Input.create_address_rec('1528 Carraway Blvd', '', 'Birmingham', 'AL', '35234', '');
	//billAddress 1
		self.bill1 := healthcare_shared.Fn_Set_Match_Input.create_address_rec('', '', '', '', '', '');
	//PracPhone 1
		self.prac_phone1 := healthcare_shared.Fn_Set_Match_Input.set_phone('(205)487-7685');
	//PracFax 1
		self.prac_fax1 := healthcare_shared.Fn_Set_Match_Input.set_fax('2052506560');
	//BillPhone 1
		self.bill_phone1 := healthcare_shared.Fn_Set_Match_Input.set_phone('');
	//BillFax 1
		self.bill_fax1 := healthcare_shared.Fn_Set_Match_Input.set_fax('');
	//Email
		self.email_addr_in := healthcare_shared.Fn_Set_Match_Input.set_email('').email_addr_in;
		self.email_addr 	 := healthcare_shared.Fn_Set_Match_Input.set_email(self.email_addr_in).email_addr;
		self.email_addr_st := healthcare_shared.Fn_Set_Match_Input.set_email(self.email_addr_in).email_addr_st;
	//Website
		self.web_site_in := healthcare_shared.Fn_Set_Match_Input.set_website('').web_site_in;
		self.web_site 	 := healthcare_shared.Fn_Set_Match_Input.set_website(self.web_site_in).web_site;
		self.web_site_st := healthcare_shared.Fn_Set_Match_Input.set_website(self.web_site_in).web_site_st;
	//TIN
		self.tin1 := healthcare_shared.Fn_Set_Match_Input.set_tin('263792403');
	//DEA
		self.dea1 := healthcare_shared.Fn_set_match_input.set_DEA('BA6818213','','','');
	//License
		self.lic1 := healthcare_shared.Fn_set_match_input.set_license('18620MD','','',self.prac1.state);
		
		
end;
matchInput:=dataset([setinput()]);

inputRecords := PROJECT(matchInput,transform(healthcare_shared.layouts.autokeyInput,
																							self.acctno := left.acctno;
																							self.st := left.prac1.state;
																							self.z5 := left.prac1.zip;
																							self.NPI := left.npi_num;
																							self.DEA := left.dea1.dea_num;
																							self.UPIN := left.upin;
																							self.license_number:=left.lic1.lic_num;
																							self.license_state:=left.lic1.lic_state;
																							self.license_type:=left.lic1.lic_type;
																							// self.TaxID := left.tin1.tin;  //having tin assignment here causes key size mismatch failure. 7/14/2015.
																							self.workphone := left.prac_phone1.phone;
																							self.name_first:=left.first_name;
																							self.name_middle:=left.middle_name;
																							self.name_last:=left.last_name;
																							self.name_suffix:=left.maturity_suffix;
																							self.match_input:=left;
																								self.IsIndividualSearch := true;//Allow the user to force the search to be an individual
																								self.IsBusinessSearch := false;//Allow the user to force the search to be a business
																								self.IsUnknownSearchBoth := false;//Allow the user to force the search down both the Individual and Business paths
																							self := [];));


Healthcare_Shared.Layouts.common_runtime_config buildConfig():=transform
                self.BestOnly :=  Healthcare_Shared.Constants.CFG_False;
								self.DRM := '11111111111111111111111111';
								self.glb_ok := true;
								self.dppa_ok := true;
                // self:=[];Do not uncomment otherwise the default values will not get set.
end;
cfgData:=dataset([buildConfig()]);
// For Individual
getHeaderResults := Healthcare_Shared.Fn_search_Ind_Header.getHdrLNPids(InputRecords(IsIndividualSearch=true or IsUnknownSearchBoth=true),cfgData);
results := Healthcare_Shared.Fn_get_MPRD.get_mprd_entity(getHeaderResults(src = Healthcare_Shared.Constants.SRC_MPRD),cfgData);
output(matchInput,named('matchInput'));
output(InputRecords,named('InputRecords'));
// output(cfgData,named('cfgData'));
// output(getHeaderResults,named('getHeaderResults'));
output(results,named('IndividualResults'));
// For Business
getRawBusinesses := Healthcare_Shared.Fn_search_Bus_Header.getHdrLNPids(InputRecords(IsBusinessSearch=true or IsUnknownSearchBoth=true),cfgData);
resultsBus := Healthcare_Shared.Fn_get_MPRD.get_mprd_entity(getRawBusinesses(src = Healthcare_Shared.Constants.SRC_SELECTFILE),cfgData);
// output(resultsBus,named('BusinessResults'));
