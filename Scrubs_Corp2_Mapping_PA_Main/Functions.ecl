IMPORT corp2, corp2_raw_pa;
	
EXPORT Functions := MODULE

		// invalid_name_type_code: 	returns true or false based upon the incoming code.
		EXPORT invalid_name_type_code(STRING s, STRING recordOrigin) := FUNCTION
      
			 isValidCD := map(recordOrigin = 'T'     => true, //Contact recs have blank name type codes
											  s in ['AB','A','01','02','HS','IN','PE','PH','10','P','12','07','14'] => true,
											  false);
									
			 RETURN if(isValidCD,1,0);
    END;
	
		// set_valid_addr_desc:  valid address descriptions
		EXPORT set_valid_addr_desc := [
						'ABANDON',
						'APPLICANT ADDRESS',
						'ASSOCIATION ADDRESS',	
						'CURRENT MAILING',
						'FOREIGN ADDRESS',
						'LISTING',
						'NAME REGISTRATION ADDRESS',
						'PENDING',
						'PRINCIPAL PLACE OF BUSINESS',
						'PREVIOUS MAILING',
						'PREVIOUS APPLICANT',
						'PREVIOUS PRINCIPAL PLACE OF BUSINESS',
						'PREVIOUS PRINICIPAL',
						'PREVIOUS REGISTERED MAILING',
						'PREVIOUS REGISTERED OFFICE',
						'PREVIOUS UCC ADDRESS',
						'BUSINESS',
						'REGISTERED OFFICE',
						'UCC ADDRESS',
						'WITHDRAWAL ADDRESS',
						''];


    // set_valid_conttitle1_desc:  valid contact title descriptions
		EXPORT set_valid_conttitle1_desc := [
						'APPLICANT',
						'ASSISTANT TREASURER',
						'ASSISTANT SECRETARY',
						'DEBTORS',
						'DIRECTOR ONLY',
						'DIRECTOR NAME',
						'GENERAL PARTNER',
						'INCORPORATOR NAME',
						'MEMBER NAME',
						'MANAGER NAME',
						'OTHER',
						'OWNER',
						'PARTNER NAME',
						'PRESIDENT',
						'REGISTERED AGENT WITH POWER OF ATTORNEY',
						'SECRETARY',
						'SECURED PARTIES',
						'TAX RESPONSIBLE PARTY',
						'TREASURER',
						'VICE PRESIDENT',
						''];	
						
						
		// set_valid_nametype_desc:  valid name type descriptions
		EXPORT set_valid_nametype_desc := [
						'ABANDON',
						'ALIAS',
						'LEGAL',
						'DBA',
						'HOME STATE',
						'INFORMAL',
						'PENDING',
						'PREVIOUS HOME STATE',
						'PREVIOUS REGISTERED ALIAS',
						'PRIOR',
						'REGISTERED ALIAS',
						'RESERVED',
						'TAX ID',
						''];	

						
		// set_valid_orgstruc_cd:  valid org structure codes
		EXPORT set_valid_orgstruc_cd := [
						'1' ,'3' ,'4' ,'5' ,'6' ,'7' ,'8' ,'9' ,'10','11',
						'12','13','14','15','16','17','18','19','20','21',
						'22','23','24','25','26','27','28','29','30','31',
						'32','33','34','35','36','37','38','39','40','41','42','']; 
						
						
	  // set_valid_orgstruc_desc:  valid org structure descriptions
		EXPORT set_valid_orgstruc_desc := [
						'BUSINESS CORPORATION',
						'PA CLOSE CORPORATION',
						'PA COOPERATIVE BUSINESS CORPORATION',
						'PA INSURANCE BUSINESS CORPORATION',
						'PA MANAGEMENT CORP',
						'PA NON STOCK CORPORATION',
						'PA MISCELLANEOUS BUSINESS CORPORATION',
						'PA NON-PROFIT COOPERATIVE CORPORATION',
						'BUSINESS TRUST',
						'LIMITED LIABILITY COMPANY',
						'PROFESSIONAL LIMITED LIABILITY COMPANY',
						'LIMITED LIABILITY GENERAL PARTNERSHIP',
						'LIMITED LIABILITY LIMITED PARTNERSHIP',
						'LIMITED PARTNERSHIP',
						'PROFESSIONAL CORPORATION',
						'PA PROFESSIONAL CORPORATION (CLOSE)',
						'PA PROFESSIONAL CORPORATION (COOPERATIVE)',
						'PA PROFESSIONAL CORPORATION (INSURANCE)',
						'PA PROFESSIONAL CORPORATION (MANAGEMENT)',
						'PA PROFESSIONAL CORPORATION (NON-STOCK)',
						'NON-PROFIT CORPORATION (EDUCATIONAL)',
						'PA NON-PROFIT CORPORATION (STOCK)',
						'PA MISCELLANEOUS COOPERATIVE CORPORATION',
						'PA MUNICIPAL AUTHORITY',
						'UNINCORPORATED ASSOCIATION',
						'NON-PROFIT (NON STOCK)',
						'FICTITIOUS NAMES',
						'PARKING AUTHORITY',
						'ECONOMIC DEVELOPMENT FINANCING AUTHORITY',
						'REDEVELOPMENT AUTHORITY',
						'HOUSING AUTHORITY',
						'PA FINANCIAL INSTITUTION',
						'NAME RESERVATION',
						'NOT QUALIFIED IN PA',
						'MISCELLANEOUS AUTHORITY',
						'HOME RULE CHARTER',
						'SURETY BOND',
						'BENEFIT CORPORATION',
						'LAND BANK',
						'UNINCORPORATED NONPROFIT ASSOCIATION',
						'PROFESSIONAL ASSOCIATION',
						''];			

	  // set_valid_status_desc:  valid status descriptions						
		EXPORT set_valid_status_desc := [
						'ACTIVE',
						'ABANDON',
						'CANCELLED',
						'EXPIRED',
						'INACTIVE',
						'MERGED',
						'NON QUALIFIED',
						'PENDING',
						'RECEIVED',
						'REVENUE MEMO',
						'REVOKED',
						'SURETY BONDS',
						'WITHDRAWN',
						'WITHDRAWN - CONSOLIDATED INACTIVE',
						'MERGE',
						''];		
						
						
END;

 