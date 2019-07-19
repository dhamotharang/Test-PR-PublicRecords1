IMPORT BatchShare,BusinessMatchCode_Services;

EXPORT iParam :=
MODULE

  // JIRA RR-10621 Exclude Experian records (default = FALSE)
  EXPORT BatchParams :=
  INTERFACE(BatchShare.IParam.BatchParamsV2)
		
      EXPORT  BOOLEAN ExcludeExperian;
		  EXPORT  UNSIGNED2 InMatchCode_score;
		  EXPORT  INTEGER2   InMatchCode_cname;
      EXPORT  INTEGER2   InMatchCode_prim_name;
      EXPORT  INTEGER2   InMatchCode_prim_range;
      EXPORT  INTEGER2   InMatchCode_sec_range;
      EXPORT  INTEGER2   InMatchCode_city;
      EXPORT  INTEGER2   InMatchCode_st;
			EXPORT  INTEGER2   InMatchCode_zip5;
			EXPORT  INTEGER2   InMatchCode_company_phone;
			EXPORT  INTEGER2   InMatchCode_company_url;
			EXPORT  INTEGER2   InMatchCode_company_fein;
			EXPORT  INTEGER2   InMatchCode_fname;
			EXPORT  INTEGER2   InMatchCode_mname;
			EXPORT  INTEGER2   InMatchCode_lname;
			EXPORT  INTEGER2   InMatchCode_contact_ssn;
			EXPORT  INTEGER2   InMatchCode_contact_did;
			EXPORT  INTEGER2   InMatchCode_contact_email;
			EXPORT  INTEGER2   InMatchCode_company_sic_code1;
						 
  END;

  // Function to initalize the params
	EXPORT getBatchParams() :=
	FUNCTION
			BaseBatchParams := BatchShare.IParam.getBatchParamsV2();
			
			inMod := MODULE(PROJECT(BaseBatchParams,BatchParams,OPT))				
			   EXPORT UNSIGNED8 MaxResultsPerAcct := BusinessMatchCode_services.Constants.Defaults.MaxResultsPerAcctno : STORED('Max_Results_Per_Acct');
				 EXPORT  INTEGER2   InMatchCode_cname         := 0 : STORED('InMatchCode_cname');
				 EXPORT  INTEGER2   InMatchCode_prim_name     := 0 : STORED('InMatchCode_prim_name');
				 EXPORT  INTEGER2   InMatchCode_prim_range    := 0 : STORED('InMatchCode_prim_range');
				 EXPORT  INTEGER2   InMatchCode_sec_range     := 0 : STORED('InMatchCode_sec_range');
				 EXPORT  INTEGER2   InMatchCode_city          := 0 : STORED('InMatchCode_city');
				 EXPORT  INTEGER2   InMatchCode_st            := 0 : STORED('InMatchCode_st');
				 EXPORT  INTEGER2   InMatchCode_zip5          := 0 : STORED('InMatchCode_zip5');
				 EXPORT  INTEGER2   InMatchCode_company_phone := 0 : STORED('InMatchCode_company_phone');
				 EXPORT  UNSIGNED2 InMatchCode_score         := 0 : STORED('InMatchCode_score');
				 EXPORT  INTEGER2   InMatchCode_company_url   := 0 : STORED('InMatchCode_company_url');
				 EXPORT  INTEGER2   InMatchCode_company_fein  := 0 : STORED('InMatchCode_company_fein');
				 EXPORT  INTEGER2   InMatchCode_fname         := 0 : STORED('InMatchCode_fname');
				 EXPORT  INTEGER2   InMatchCode_mname         := 0 : STORED('InMatchCode_mname');
				 EXPORT  INTEGER2   InMatchCode_lname         := 0 : STORED('InMatchCode_lname');
				 EXPORT  INTEGER2   InMatchCode_contact_ssn   := 0 : STORED('InMatchCode_contact_ssn');
				 EXPORT  INTEGER2   InMatchCode_contact_did   := 0 : STORED('InMatchCode_contact_did');
				 EXPORT  INTEGER2   InMatchCode_contact_email := 0 : STORED('InMatchCode_contact_email');				 				
				 EXPORT  INTEGER2   InMatchCode_company_sic_code1 := 0 : STORED('InMatchCode_company_sic_code1');
         EXPORT  BOOLEAN ExcludeExperian := FALSE : STORED('ExcludeExperian');
			END;
			
			RETURN inMod;
		END;
END;
