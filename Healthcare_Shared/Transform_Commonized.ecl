Import doxie,ut,std,HealthCare_Shared;
EXPORT Transform_Commonized := module
	Export Healthcare_Shared.Layouts.userInputCleanMatch convertDidtoAutokey(doxie.layout_references l, integer c) := TRANSFORM
		self.acctno := (String)c;
		self := l;
		self:=[];
	END;
	Export Healthcare_Shared.Layouts.userInputCleanMatch convertBdidtoAutokey(doxie.layout_ref_bdid l, integer c) := TRANSFORM
		self.acctno := (String)c;
		self := l;
		self:=[];
	END;
	Export Healthcare_Shared.Layouts.userInputCleanMatch backupRaw(Healthcare_Shared.Layouts.autokeyInput rec) := TRANSFORM
		self.rawinput.rawNameFull := rec.name_full;
		self.rawinput.rawFname:=rec.name_first;
		self.rawinput.rawMname:=rec.name_middle;
		self.rawinput.rawLname:=rec.name_last;
		self.rawinput.rawSuffix:=rec.name_suffix;
		self.rawinput.rawProfSuffix := rec.name_prof_suffix;
		self.rawinput.rawTitle := rec.name_title;
		self.rawinput.rawAddressLine1 := rec.AddressLine1;
		self.rawinput.rawAddressLine2 := rec.AddressLine2;
		self.rawinput.rawPrim_range		:= rec.prim_range;
		self.rawinput.rawPredir				:= rec.predir;
		self.rawinput.rawPrim_name		:= rec.prim_name;
		self.rawinput.rawAddr_suffix	:= rec.addr_suffix;
		self.rawinput.rawPostdir			:= rec.postdir;
		self.rawinput.rawUnit_desig		:= rec.unit_desig;
		self.rawinput.rawSec_range		:= rec.sec_range;
		self.rawinput.rawCity					:= rec.p_city_name;
		self.rawinput.rawState				:= rec.st;
		self.rawinput.rawZip					:= rec.z5;
		self.rawinput.rawZip4					:= rec.zip4;
		self.rawinput.rawBillingAddressLine1 	:= rec.bill_AddressLine1;
		self.rawinput.rawBillingAddressLine2 	:= rec.bill_AddressLine2;
		self.rawinput.rawBillingPrim_range		:= rec.bill_prim_range;
		self.rawinput.rawBillingPredir				:= rec.bill_predir;
		self.rawinput.rawBillingPrim_name			:= rec.bill_prim_name;
		self.rawinput.rawBillingAddr_suffix		:= rec.bill_addr_suffix;
		self.rawinput.rawBillingPostdir				:= rec.bill_postdir;
		self.rawinput.rawBillingUnit_desig		:= rec.bill_unit_desig;
		self.rawinput.rawBillingSec_range			:= rec.bill_sec_range;
		self.rawinput.rawBillingCity					:= rec.bill_p_city_name;
		self.rawinput.rawBillingState					:= rec.bill_st;
		self.rawinput.rawBillingZip						:= rec.bill_z5;
		self.rawinput.rawBillingZip4					:= rec.bill_zip4;
		self.rawinput.rawCompanyName			    := rec.comp_name;
		self.rawinput.rawBillCompanyName 			:= rec.bill_company_name;
		self.rawinput.rawSsn := rec.ssn;
		self.rawinput.rawDob := rec.dob;
		self.rawinput.rawPhone := rec.workphone;
		self.rawinput.rawFax := rec.FaxVerification;
		self.rawinput.rawBillPhone := rec.bill_phone;
		self.rawinput.rawBillFax := rec.bill_fax;
		self.rawinput.rawLicenseType := rec.license_type;
		self.rawinput.rawLicenseNumber := rec.license_number;
		self.rawinput.rawLicenseState := rec.license_state;
		self.rawinput.rawFEIN := rec.FEIN;
		self.rawinput.rawTaxID := rec.TaxID;
		self.rawinput.rawUPIN := rec.UPIN;
		self.rawinput.rawNPI := rec.NPI;
		self.rawinput.rawDEA := rec.DEA;
		self.rawinput.rawDEA2 := rec.DEA2;
		self.rawinput.rawCLIANumber := rec.CLIANumber;
		self.rawinput.rawNCPDPNumber := rec.NCPDPNumber;
		self.rawinput.rawMedicareNumber := rec.MedicareNumber;
		self.rawinput.rawMedicaidNumber := rec.MedicaidNumber;
		self.rawinput.rawGender := rec.GenderVerification;
		self.rawinput.rawTaxonomy1 := rec.Taxonomy1Verification;
		self.rawinput.rawTaxonomy2 := rec.Taxonomy2Verification;
		self.rawinput.rawTaxonomy3 := rec.Taxonomy3Verification;
		self.rawinput.rawTaxonomy4 := rec.Taxonomy4Verification;
		self.rawinput.rawTaxonomy5 := rec.Taxonomy5Verification;
		self.rawinput.rawStateLicense1 := rec.StateLicense1Verification;
		self.rawinput.rawStateLicense1State := rec.StateLicense1StateVerification;
		self.rawinput.rawStateLicense2 := rec.StateLicense2Verification;
		self.rawinput.rawStateLicense2State := rec.StateLicense2StateVerification;
		self.rawinput.rawStateLicense3 := rec.StateLicense3Verification;
		self.rawinput.rawStateLicense3State := rec.StateLicense3StateVerification;
		self.rawinput.rawStateLicense4 := rec.StateLicense4Verification;
		self.rawinput.rawStateLicense4State := rec.StateLicense4StateVerification;
		self.rawinput.rawStateLicense5 := rec.StateLicense5Verification;
		self.rawinput.rawStateLicense5State := rec.StateLicense5StateVerification;
		self.rawinput.rawStateLicense6 := rec.StateLicense6Verification;
		self.rawinput.rawStateLicense6State := rec.StateLicense6StateVerification;
		self.rawinput.rawStateLicense7 := rec.StateLicense7Verification;
		self.rawinput.rawStateLicense7State := rec.StateLicense7StateVerification;
		self.rawinput.rawStateLicense8 := rec.StateLicense8Verification;
		self.rawinput.rawStateLicense8State := rec.StateLicense8StateVerification;
		self.rawinput.rawStateLicense9 := rec.StateLicense9Verification;
		self.rawinput.rawStateLicense9State := rec.StateLicense9StateVerification;
		self.rawinput.rawStateLicense10 := rec.StateLicense10Verification;
		self.rawinput.rawStateLicense10State := rec.StateLicense10StateVerification;
		self.rawinput.rawBoardCertifiedSpecialty := rec.BoardCertifiedSpecialtyVerification;
		self.rawinput.rawBoardCertifiedSubSpecialty := rec.BoardCertifiedSubSpecialtyVerification;
		self.rawinput.rawBoardCertifiedSpecialty2 := rec.BoardCertifiedSpecialty2Verification;
		self.rawinput.rawBoardCertifiedSubSpecialty2 := rec.BoardCertifiedSubSpecialty2Verification;
		self.rawinput.rawBoardCertifiedSpecialty3 := rec.BoardCertifiedSpecialty3Verification;
		self.rawinput.rawBoardCertifiedSubSpecialty3 := rec.BoardCertifiedSubSpecialty3Verification;
		self.rawinput.rawBoardCertifiedSpecialty4 := rec.BoardCertifiedSpecialty4Verification;
		self.rawinput.rawBoardCertifiedSubSpecialty4 := rec.BoardCertifiedSubSpecialty4Verification;
		self.rawinput.rawBoardCertifiedSpecialty5 := rec.BoardCertifiedSpecialty5Verification;
		self.rawinput.rawBoardCertifiedSubSpecialty5 := rec.BoardCertifiedSubSpecialty5Verification;
		self.rawinput.rawServiceFromDate := rec.ServiceFromDate;
		self.rawinput.rawServiceToDate := rec.ServiceToDate;
		self := rec;
		self := [];
	END;
	export Healthcare_Shared.Layouts.userInputCleanMatch setStandardizedInput(Healthcare_Shared.Layouts.userInputCleanMatch inRecs, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg):= TRANSFORM
		self.StatBits.Dos_From_Date_st 		:= map( trim(inRecs.ServiceFromDate) 	= '' => Healthcare_Shared.Constants.stat_Core_Missing,
																							HealthCare_Shared.Functions.getDateStat(inRecs.ServiceFromDate));
		self.StatBits.Dos_Through_Date_st := map( trim(inRecs.ServiceToDate) 		= '' => Healthcare_Shared.Constants.stat_Core_Missing,
																							HealthCare_Shared.Codes_Dos.getDateStat(inRecs.ServiceToDate));
		self.ServiceFromDate 							:= map( self.StatBits.Dos_From_Date_st 		= 0 => inRecs.ServiceFromDate,ut.GetDate);
		self.ServiceToDate 								:= map( self.StatBits.Dos_Through_Date_st = 0 => inRecs.ServiceToDate  ,ut.GetDate);
		name_in := inRecs.name_first + ' ' + inRecs.name_middle + ' ' + inRecs.name_last + ' ' + inRecs.name_suffix;
		nameKeyPrefix := IF(inRecs.clnName.name_prefered <> '',inRecs.clnName.name_prefered,inRecs.name_first);
		self.name_key:= nameKeyPrefix + '_' + STD.Metaphone.Primary(name_in);		
		self.StatBits.name_st:= if(name_in = '',Healthcare_Shared.Constants.stat_Missing, 0);
		self.addr_key	:= healthcare_shared.Fn_StandardizeInput.fn_make_address_key(inRecs.clnAddr);
		self.AddressLine1 := healthcare_shared.Fn_StandardizeInput.make_primary_address_string(inRecs.clnAddr);
		self.bill_AddressLine1 := healthcare_shared.Fn_StandardizeInput.make_primary_address_string(inRecs.clnBillAddr);		
		  missing := inRecs.rawinput.rawAddressLine1='' and inRecs.rawinput.rawAddressLine2='' and inRecs.rawinput.rawCity='' and inRecs.rawinput.rawState='' and inRecs.rawinput.rawZip='';
			missing_st              := if(missing or inRecs.clnAddr.err_stat = 'E502',Healthcare_Shared.Constants.stat_Core_Missing, 0);
			notDeliverable_st       := if(inRecs.clnAddr.err_type = 'E' AND inRecs.clnAddr.err_stat <> 'E600',Healthcare_Shared.Constants.stat_Addr_NotDeliverable, 0);
			badFormat_st            := if(inRecs.clnAddr.err_type = 'E' AND inRecs.clnAddr.err_stat NOT IN ['E600','E605','E601'],Healthcare_Shared.Constants.stat_Core_BadFormat, 0);
			pobox_st                := if(inRecs.clnAddr.rec_type[1] = 'P',Healthcare_Shared.Constants.stat_Addr_Pobox, 0);
			npsr_st                 := if(inRecs.clnAddr.non_postal_unit <> '' or inRecs.clnAddr.non_postal_unit_nbr <> '',Healthcare_Shared.Constants.stat_Addr_Npsr, 0);
			sigstd_st               := if(missing_st = 0 AND inRecs.clnAddr.err_stat NOT IN ['S80000','S80100','S00100','S00000','S800','S801','S001','S000'],Healthcare_Shared.Constants.stat_Addr_SigStd, 0);
			residential_st          := if(inRecs.clnAddr.rdi = 'Y',Healthcare_Shared.Constants.stat_Addr_Residential, 0);
		self.StatBits.addr_st		:= missing_st+notDeliverable_st+badFormat_st+pobox_st+npsr_st+sigstd_st+residential_st;
		  billingmissing := inRecs.rawinput.rawBillingAddressLine1='' and inRecs.rawinput.rawBillingAddressLine2='' and inRecs.rawinput.rawBillingCity='' and inRecs.rawinput.rawBillingState='' and inRecs.rawinput.rawBillingZip='';
			billmissing_st          := if(billingmissing or inRecs.clnBillAddr.err_code = 'E502',Healthcare_Shared.Constants.stat_Missing, 0);
			billnotDeliverable_st   := if(inRecs.clnBillAddr.err_type = 'E' AND inRecs.clnBillAddr.err_stat <> 'E600',Healthcare_Shared.Constants.addressUndeliverable, 0);
			billbadFormat_st        := if(inRecs.clnBillAddr.err_type = 'E' AND inRecs.clnBillAddr.err_stat NOT IN ['E600','E605','E601'],Healthcare_Shared.Constants.stat_BadFormat, 0);
			billpobox_st            := if(inRecs.clnBillAddr.rec_type[1] = 'P',Healthcare_Shared.Constants.pobox, 0);
			billnpsr_st             := if(inRecs.clnBillAddr.non_postal_unit <> '' or inRecs.clnBillAddr.non_postal_unit_nbr <> '',Healthcare_Shared.Constants.npsr, 0);
			billsigstd_st           := if(billmissing_st = 0 AND inRecs.clnBillAddr.err_stat NOT IN ['S80000','S80100','S00100','S00000','S800','S801','S001','S000'],Healthcare_Shared.Constants.significantStandardizationOccurred, 0);
			billresidential_st      := if(inRecs.clnBillAddr.rdi = 'Y',Healthcare_Shared.Constants.isResidential, 0);
		self.StatBits.billAddr_st	:= billmissing_st+billnotDeliverable_st+billbadFormat_st+billpobox_st+billnpsr_st+billsigstd_st+billresidential_st;
		fn_dob := healthcare_shared.Fn_StandardizeInput.set_birthdate(inRecs.dob);
		self.dob:= fn_dob.birthdate;
		self.StatBits.birthdate_st:= fn_dob.birthdate_st;
		fn_ssn := healthcare_shared.Fn_StandardizeInput.set_ssn(inRecs.ssn);
		self.ssn:=fn_ssn.ssn;
		fn_gender := healthcare_shared.Fn_StandardizeInput.set_gender(inRecs.rawinput.rawGender);
		self.GenderVerification := fn_gender.male_female;
		self.StatBits.male_female_st:= fn_gender.male_female_st;
		self.StatBits.ssn_st:=fn_ssn.ssn_st;
		fn_Phone := healthcare_shared.Fn_StandardizeInput.set_phone(inRecs.workphone);
		self.workphone := fn_Phone.phone;
		self.StatBits.phone_st := fn_Phone.phone_st;
		fn_Fax := healthcare_shared.Fn_StandardizeInput.set_fax(inRecs.FaxVerification);
		self.FaxVerification := fn_Fax.fax;
		self.StatBits.fax_st := fn_Fax.fax_st;
		fn_BillPhone := healthcare_shared.Fn_StandardizeInput.set_phone(inRecs.bill_phone);
		self.bill_phone := fn_BillPhone.phone;
		self.StatBits.billphone_st := fn_BillPhone.phone_st;
		fn_BillFax := healthcare_shared.Fn_StandardizeInput.set_fax(inRecs.bill_fax);
		self.bill_fax := fn_BillFax.fax;
		self.StatBits.billfax_st := fn_BillFax.fax_st;
		fn_email := healthcare_shared.Fn_StandardizeInput.set_email(inRecs.EmailVerification);
		self.EmailVerification := fn_email.email_addr;
		self.StatBits.email_addr_st := fn_email.email_addr_st;
		fn_upin := healthcare_shared.Fn_StandardizeInput.set_UPIN(inRecs.upin);
		self.upin :=  fn_upin.upin;
		self.StatBits.upin_st := fn_upin.upin_st;
		fn_tin := healthcare_shared.Fn_StandardizeInput.set_tin(inRecs.taxid);
		self.taxid := fn_tin.tin;
		self.StatBits.tin_st := fn_tin.tin_st;
		fn_dea1 := healthcare_shared.Fn_StandardizeInput.set_DEA(inRecs.dea,inRecs.name_last);
		self.dea := fn_dea1.dea_num;
		self.StatBits.dea_num_st := fn_dea1.dea_num_st;
		fn_dea2 := healthcare_shared.Fn_StandardizeInput.set_DEA(inRecs.dea2,inRecs.name_last);
		self.dea2 := fn_dea2.dea_num;
		self.StatBits.dea2_num_st := fn_dea2.dea_num_st;
		fn_ncpdp := healthcare_shared.Fn_StandardizeInput.set_NCPDP(inRecs.ncpdpnumber);
		self.ncpdpnumber := fn_ncpdp.ncpdp_id;
		self.StatBits.ncpdp_id_st := fn_ncpdp.ncpdp_id_st;
		fn_specialty1 :=  healthcare_shared.Fn_StandardizeInput.set_specialty(inRecs.BoardCertifiedSpecialtyVerification,inRecs.BoardCertifiedSubSpecialtyVerification);
		self.Specialty1 := fn_specialty1.specialty;
		self.StatBits.specialty1_st := fn_specialty1.specialty_st;
		fn_specialty2 :=  healthcare_shared.Fn_StandardizeInput.set_specialty(inRecs.BoardCertifiedSpecialty2Verification,inRecs.BoardCertifiedSubSpecialty2Verification);
		self.Specialty2 := fn_specialty2.specialty;
		self.StatBits.specialty2_st := fn_specialty2.specialty_st;
		fn_specialty3 :=  healthcare_shared.Fn_StandardizeInput.set_specialty(inRecs.BoardCertifiedSpecialty3Verification,inRecs.BoardCertifiedSubSpecialty3Verification);
		self.Specialty3 := fn_specialty3.specialty;
		self.StatBits.specialty3_st := fn_specialty3.specialty_st;
		fn_specialty4 :=  healthcare_shared.Fn_StandardizeInput.set_specialty(inRecs.BoardCertifiedSpecialty4Verification,inRecs.BoardCertifiedSubSpecialty4Verification);
		self.Specialty4 := fn_specialty4.specialty;
		self.StatBits.specialty4_st := fn_specialty4.specialty_st;
		fn_specialty5 :=  healthcare_shared.Fn_StandardizeInput.set_specialty(inRecs.BoardCertifiedSpecialty5Verification,inRecs.BoardCertifiedSubSpecialty5Verification);
		self.Specialty5 := fn_specialty5.specialty;
		self.StatBits.specialty5_st := fn_specialty5.specialty_st;
		// fn_specialty6 :=  healthcare_shared.Fn_StandardizeInput.set_specialty(inRecs.BoardCertifiedSpecialty6Verification,inRecs.BoardCertifiedSubSpecialty6Verification);
		// self.Specialty6 := fn_specialty6.specialty;
		// self.StatBits.specialty6_st := fn_specialty6.specialty_st;
		// fn_specialty7 :=  healthcare_shared.Fn_StandardizeInput.set_specialty(inRecs.BoardCertifiedSpecialty7Verification,inRecs.BoardCertifiedSubSpecialty7Verification);
		// self.Specialty7 := fn_specialty7.specialty;
		// self.StatBits.specialty7_st := fn_specialty7.specialty_st;
		// fn_specialty8 :=  healthcare_shared.Fn_StandardizeInput.set_specialty(inRecs.BoardCertifiedSpecialty8Verification,inRecs.BoardCertifiedSubSpecialty8Verification);
		// self.Specialty8 := fn_specialty8.specialty;
		// self.StatBits.specialty8_st := fn_specialty8.specialty_st;
		// fn_specialty9 :=  healthcare_shared.Fn_StandardizeInput.set_specialty(inRecs.BoardCertifiedSpecialty9Verification,inRecs.BoardCertifiedSubSpecialty9Verification);
		// self.Specialty9 := fn_specialty9.specialty;
		// self.StatBits.specialty9_st := fn_specialty9.specialty_st;
		// fn_specialty10 :=  healthcare_shared.Fn_StandardizeInput.set_specialty(inRecs.BoardCertifiedSpecialty10Verification,inRecs.BoardCertifiedSubSpecialty10Verification);
		// self.Specialty10 := fn_specialty10.specialty;
		// self.StatBits.specialty10_st := fn_specialty10.specialty_st;
		fn_lic0 := healthcare_shared.Fn_StandardizeInput.set_license(inRecs.license_number,inRecs.license_state,inRecs.license_type,inRecs.st,cfg[1].subPracStateForEmptyLicState);
		self.license_number := fn_lic0.lic_num;
		self.license_state := fn_lic0.lic_state;
		self.license_type := fn_lic0.lic_type;
		self.StatBits.lic_st := fn_lic0.lic_st;
		fn_lic1 := healthcare_shared.Fn_StandardizeInput.set_license(inRecs.StateLicense1Verification,inRecs.StateLicense1StateVerification,inRecs.license_type,inRecs.st,cfg[1].subPracStateForEmptyLicState);
		self.StateLicense1Verification := fn_lic1.lic_num;
		// self.StatBits.lic_st := fn_lic1.lic_st;
		fn_lic2 := healthcare_shared.Fn_StandardizeInput.set_license(inRecs.StateLicense2Verification,inRecs.StateLicense2StateVerification,inRecs.license_type,inRecs.st,cfg[1].subPracStateForEmptyLicState);
		self.StateLicense2Verification := fn_lic2.lic_num;
		self.StatBits.lic2_st := fn_lic2.lic_st;
		fn_lic3 := healthcare_shared.Fn_StandardizeInput.set_license(inRecs.StateLicense3Verification,inRecs.StateLicense3StateVerification,inRecs.license_type,inRecs.st,cfg[1].subPracStateForEmptyLicState);
		self.StateLicense3Verification := fn_lic3.lic_num;
		self.StatBits.lic3_st := fn_lic3.lic_st;
		fn_lic4 := healthcare_shared.Fn_StandardizeInput.set_license(inRecs.StateLicense4Verification,inRecs.StateLicense4StateVerification,inRecs.license_type,inRecs.st,cfg[1].subPracStateForEmptyLicState);
		self.StateLicense4Verification := fn_lic4.lic_num;
		self.StatBits.lic4_st := fn_lic4.lic_st;
		fn_lic5 := healthcare_shared.Fn_StandardizeInput.set_license(inRecs.StateLicense5Verification,inRecs.StateLicense5StateVerification,inRecs.license_type,inRecs.st,cfg[1].subPracStateForEmptyLicState);
		self.StateLicense5Verification := fn_lic5.lic_num;
		self.StatBits.lic5_st := fn_lic1.lic_st;
		fn_lic6 := healthcare_shared.Fn_StandardizeInput.set_license(inRecs.StateLicense6Verification,inRecs.StateLicense6StateVerification,inRecs.license_type,inRecs.st,cfg[1].subPracStateForEmptyLicState);
		self.StateLicense6Verification := fn_lic6.lic_num;
		self.StatBits.lic6_st := fn_lic6.lic_st;
		fn_lic7 := healthcare_shared.Fn_StandardizeInput.set_license(inRecs.StateLicense7Verification,inRecs.StateLicense7StateVerification,inRecs.license_type,inRecs.st,cfg[1].subPracStateForEmptyLicState);
		self.StateLicense7Verification := fn_lic7.lic_num;
		self.StatBits.lic7_st := fn_lic7.lic_st;
		fn_lic8 := healthcare_shared.Fn_StandardizeInput.set_license(inRecs.StateLicense8Verification,inRecs.StateLicense8StateVerification,inRecs.license_type,inRecs.st,cfg[1].subPracStateForEmptyLicState);
		self.StateLicense8Verification := fn_lic8.lic_num;
		self.StatBits.lic8_st := fn_lic8.lic_st;
		fn_lic9 := healthcare_shared.Fn_StandardizeInput.set_license(inRecs.StateLicense9Verification,inRecs.StateLicense9StateVerification,inRecs.license_type,inRecs.st,cfg[1].subPracStateForEmptyLicState);
		self.StateLicense9Verification := fn_lic9.lic_num;
		self.StatBits.lic9_st := fn_lic9.lic_st;
		fn_lic10 := healthcare_shared.Fn_StandardizeInput.set_license(inRecs.StateLicense10Verification,inRecs.StateLicense10StateVerification,inRecs.license_type,inRecs.st,cfg[1].subPracStateForEmptyLicState);
		self.StateLicense10Verification := fn_lic10.lic_num;
		self.StatBits.lic10_st := fn_lic10.lic_st;
		fn_npi := healthcare_shared.Fn_StandardizeInput.set_npi(inRecs.npi,Inrecs.Taxonomy1Verification);
		self.npi := fn_npi.npi_num;
		self.StatBits.npi_st := fn_npi.npi_st;
		fn_taxonomy:=healthcare_shared.Fn_StandardizeInput.set_taxonomy(inRecs.Taxonomy1Verification);
		self.Taxonomy1Verification := fn_taxonomy.taxonomy;
		self.StatBits.taxonomy_st := fn_taxonomy.taxonomy_st;
		fn_taxonomy2:=healthcare_shared.Fn_StandardizeInput.set_taxonomy(inRecs.Taxonomy2Verification);
		self.Taxonomy2Verification := fn_taxonomy2.taxonomy;
		self.StatBits.taxonomy2_st := fn_taxonomy2.taxonomy_st;
		fn_taxonomy3:=healthcare_shared.Fn_StandardizeInput.set_taxonomy(inRecs.Taxonomy3Verification);
		self.Taxonomy3Verification := fn_taxonomy3.taxonomy;
		self.StatBits.taxonomy3_st := fn_taxonomy3.taxonomy_st;
		fn_taxonomy4:=healthcare_shared.Fn_StandardizeInput.set_taxonomy(inRecs.Taxonomy4Verification);
		self.Taxonomy4Verification := fn_taxonomy4.taxonomy;
		self.StatBits.taxonomy4_st := fn_taxonomy4.taxonomy_st;
		fn_taxonomy5:=healthcare_shared.Fn_StandardizeInput.set_taxonomy(inRecs.Taxonomy5Verification);
		self.Taxonomy5Verification := fn_taxonomy5.taxonomy;
		self.StatBits.taxonomy5_st := fn_taxonomy5.taxonomy_st;
		fn_clia := healthcare_shared.Fn_StandardizeInput.set_clia(inRecs.clianumber);
		self.clianumber:=fn_clia.clia_num;
		self.StatBits.clia_data_st:=fn_clia.clia_data_st;
		fn_medicare := healthcare_shared.Fn_StandardizeInput.set_medicare(inRecs.medicarenumber);
		self.medicarenumber:= fn_medicare.medicare_fac_num;
		self.StatBits.medicare_fac_num_st:= fn_medicare.medicare_fac_num_st;
		fn_medicaid := healthcare_shared.Fn_StandardizeInput.set_medicaid(inRecs.medicaidnumber);
		self.medicaidnumber:=fn_medicaid.medicaid_fac_num;
		self.StatBits.medicaid_fac_num_st:=fn_medicaid.medicaid_fac_num_st;
		self.ValidInputs := Healthcare_Shared.InputRequirements_Common(inRecs);
		self := inRecs;
	end;
End;