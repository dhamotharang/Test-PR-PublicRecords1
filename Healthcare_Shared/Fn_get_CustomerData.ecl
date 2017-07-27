Import iesp,Healthcare_CustomerLicense,Healthcare_CustomerDeath,Healthcare_Shared;
EXPORT Fn_get_CustomerData := MODULE
		Export getCustomerLicenseData(dataset(Healthcare_Shared.Layouts.autokeyInput) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := function
			covertedInput1 := project(input,transform(Healthcare_CustomerLicense.Layouts.autokeyInput,self.CustomerID:=cfg[1].CustomerID;self:=left));
			covertedInput2 := project(input,transform(Healthcare_CustomerLicense.Layouts.autokeyInput,self.CustomerID:=cfg[1].CustomerID;self.license_number:=left.statelicense2verification;self.license_state:=left.statelicense2stateverification;self:=left));
			covertedInput3 := project(input,transform(Healthcare_CustomerLicense.Layouts.autokeyInput,self.CustomerID:=cfg[1].CustomerID;self.license_number:=left.statelicense3verification;self.license_state:=left.statelicense3stateverification;self:=left));
			covertedInput4 := project(input,transform(Healthcare_CustomerLicense.Layouts.autokeyInput,self.CustomerID:=cfg[1].CustomerID;self.license_number:=left.statelicense4verification;self.license_state:=left.statelicense4stateverification;self:=left));
			covertedInput5 := project(input,transform(Healthcare_CustomerLicense.Layouts.autokeyInput,self.CustomerID:=cfg[1].CustomerID;self.license_number:=left.statelicense5verification;self.license_state:=left.statelicense5stateverification;self:=left));
			covertedInput6 := project(input,transform(Healthcare_CustomerLicense.Layouts.autokeyInput,self.CustomerID:=cfg[1].CustomerID;self.license_number:=left.statelicense6verification;self.license_state:=left.statelicense6stateverification;self:=left));
			covertedInput7 := project(input,transform(Healthcare_CustomerLicense.Layouts.autokeyInput,self.CustomerID:=cfg[1].CustomerID;self.license_number:=left.statelicense7verification;self.license_state:=left.statelicense7stateverification;self:=left));
			covertedInput8 := project(input,transform(Healthcare_CustomerLicense.Layouts.autokeyInput,self.CustomerID:=cfg[1].CustomerID;self.license_number:=left.statelicense8verification;self.license_state:=left.statelicense8stateverification;self:=left));
			covertedInput9 := project(input,transform(Healthcare_CustomerLicense.Layouts.autokeyInput,self.CustomerID:=cfg[1].CustomerID;self.license_number:=left.statelicense9verification;self.license_state:=left.statelicense9stateverification;self:=left));
			covertedInput10 := project(input,transform(Healthcare_CustomerLicense.Layouts.autokeyInput,self.CustomerID:=cfg[1].CustomerID;self.license_number:=left.statelicense10verification;self.license_state:=left.statelicense10stateverification;self:=left));
			covertedInput := covertedInput1+covertedInput2+covertedInput3+covertedInput4+covertedInput5+covertedInput6+covertedInput7+covertedInput8+covertedInput9+covertedInput10;
			Healthcare_Shared.Layouts.layout_customerLicense get_CustomerLicenseData(Healthcare_CustomerLicense.Layouts.LayoutOutput l) := transform
				self.acctno := l.acctno;
				self.InternalID := 0;
				self.CustomerDataSrc := (string)l.customer_id;
				self.Name := iesp.ECL2ESP.SetName (l.clean_name.fname, l.clean_name.mname, l.clean_name.lname,
																					 l.clean_name.name_suffix, l.clean_name.title, l.full_name);
				self.LicenseNumber := l.license_number;
				self.LicenseType := l.bull_license_type;
				self.LicenseTypeDesc := l.bull_lic_type_desc;
				self.LicenseBoardCd := l.license_number[1..2];
				self.LicenseBoardDesc := l.license_board_code_desc;
				self.LicenseStatusCd := l.sec_license_status;
				self.LicenseStatusDesc := l.license_status_desc;
				self.LastChangeDate := iesp.ECL2ESP.toDate((integer)l.license_status_date);
				self.ExpirationDate := iesp.ECL2ESP.toDate((integer)l.expiration_date);
				self := [];
			end;
			CustomerLicenseData := project(Healthcare_CustomerLicense.Raw.records(covertedInput(license_number<>''),10),
																			get_CustomerLicenseData(left));

			Healthcare_Shared.Layouts.layout_fullchild_customerLicense doRollup(Healthcare_Shared.Layouts.layout_customerLicense l, dataset(Healthcare_Shared.Layouts.layout_customerLicense) r) := TRANSFORM
				SELF.acctno := l.acctno;
				self.InternalID := l.InternalID;
				self.childinfo := project(r,iesp.healthcare.t_StateLicenseRecord);
			END;
			results_rolled := rollup(group(CustomerLicenseData,acctno),group,doRollup(left,rows(left)));
			return results_rolled;
		end;
		Export appendCustomerLicenseData (dataset(Healthcare_Shared.Layouts.autokeyInput) input, 
														dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inputRecs,
														dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := function
			fmtRec_CustomerLicenseData := getCustomerLicenseData(input,cfg);
			results := join(inputRecs,fmtRec_CustomerLicenseData, left.acctno=right.acctno,
																			transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
																								self.customerLicense := right.childinfo;
																								self := left),left outer,keep(Healthcare_Shared.Constants.IDS_PER_DID), limit(0));
			return results;
		end;
		Export getCustomerDeathData(dataset(Healthcare_Shared.Layouts.autokeyInput) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := function
			Healthcare_Shared.Layouts.layout_customerDeath get_CustomerDeathData(Healthcare_CustomerDeath.Layouts.LayoutOutput l) := transform
				self.acctno := l.acctno;
				self.InternalID := 0;
				self.CustomerDataSrc := (string)l.customer_id;
				self.Name := iesp.ECL2ESP.SetName (l.clean_name.fname, l.clean_name.mname, l.clean_name.lname,
																					 l.clean_name.name_suffix, l.clean_name.title, l.fname+' '+l.mname+ ' '+l.lname);
				self.DOD := iesp.ECL2ESP.toDate((integer)l.dod);
				self.SSN := l.ssn;
				self.LicenseNumber := '';//l.license_number;
				self.MatchPercent := l.MatchPercent;
				self.IsMatchFirst := l.isFirstNameMatch;
				self.IsMatchLast := l.isLastNameMatch;
				self.IsMatchDOB := l.isDOBMatch;
			end;
			DeathInputRecords := project(input,transform(Healthcare_CustomerDeath.Layouts.autokeyInput,self.CustomerID:=cfg[1].CustomerID;self:=left));
			CustomerDeathData := project(Healthcare_CustomerDeath.Raw.records(DeathInputRecords),
																			get_CustomerDeathData(left));

			Healthcare_Shared.Layouts.layout_fullchild_customerDeath doRollup(Healthcare_Shared.Layouts.layout_customerDeath l, dataset(Healthcare_Shared.Layouts.layout_customerDeath) r) := TRANSFORM
				SELF.acctno := l.acctno;
				self.InternalID := l.InternalID;
				self.childinfo := project(r,iesp.healthcare.t_StateVitalRecord);
			END;
			// output(DeathInputRecords,named('DeathInputRecords'));
			results_rolled := rollup(group(CustomerDeathData,acctno),group,doRollup(left,rows(left)));
			return results_rolled;
		end;
		Export appendCustomerDeathData (dataset(Healthcare_Shared.Layouts.autokeyInput) input, 
																		dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inputRecs,
																		dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := function
			fmtRec_CustomerDeathData := getCustomerDeathData(input,cfg);
			results := join(inputRecs,fmtRec_CustomerDeathData, left.acctno=right.acctno,
																			transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
																								self.customerDeath := right.childinfo;
																								self := left),left outer,keep(Healthcare_Shared.Constants.IDS_PER_DID), limit(0));
			return results;
			// return inputRecs;
		end;
end;