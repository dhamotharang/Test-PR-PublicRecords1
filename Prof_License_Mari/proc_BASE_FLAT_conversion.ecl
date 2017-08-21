/* ************************************************************************************************************ */	
//  The purpose of this development is take MARIBASE common layout and convert to MARIFLAT file prep data for MARIFLAT SCHEMA that include
//  the following relational files: LICENSOR, LICENSE, ENTITY, DBA for ROXIE development.
//  NOTE: Future development will be required to address ADDRESS ID business logic.
/* ************************************************************************************************************ */	

import ut
       ,Prof_License_Mari
	   ,Lib_FileServices
	   ,lib_stringlib
	   ,Lib_date;


// Processing only Real Estate Licenses
inFile 	:= file_MARIBASE_in(STD_PROF_CD IN ['RLE','APR','MTG','LND']);



// Mapping MARIBASE file into MARIFLAT_out Layout
Prof_License_Mari.layouts_reference.MARIFLAT_out     xformMARIBASE(layouts_reference.MARIBASE pInput) 
    := 
	   TRANSFORM
		   self.PRIMARY_KEY			:= 0;
		   
		   // Modifying National Source Name to expected name abbreviation
		   self.STD_SOURCE_DESC		:= MAP(pInput.STD_SOURCE_UPD = 'SO404' => 'VETA',
										   pInput.STD_SOURCE_UPD = 'S0643' => 'FDIC',
										   pInput.STD_SOURCE_UPD = 'S0645' => 'HUD',
										   pInput.STD_SOURCE_UPD = 'S0648' => 'NCUA',
										   pInput.STD_SOURCE_UPD = 'S0814' => 'ASC',
										   pInput.STD_SOURCE_DESC);
			
			// Identifying source as either (S)tate or (N)ational source
		   self.TYPE_CD				:= IF(REGEXFIND('^(?:(?!S0404|S0643|S0645|S0648|S0814).)*$',pInput.STD_SOURCE_UPD)= TRUE,'S','N');
		   
		   // Business Logic to standardize names
		   self.NAME_ORG_ORIG       := IF(pInput.NAME_ORG_ORIG = ',','',pInput.NAME_ORG_ORIG);
	       self.NAME_MARI_DBA	    := IF(pInput.NAME_MARI_DBA = '--','',StringLib.StringToUpperCase(pInput.NAME_MARI_DBA)); 
		   self.PHN_MARI_1			:= IF(pInput.PHN_MARI_1 <> '0000000000', 
											stringlib.stringfilter(pInput.PHN_MARI_1,'0123456789')[1..10], '');
		   self.PHN_MARI_FAX_1		:= IF(pInput.PHN_MARI_FAX_1 <> '0000000000', 
											stringlib.stringfilter(pInput.PHN_MARI_FAX_1,'0123456789')[1..10],'');
		   
		   //Verifying WHITESPACE in NOTES field before concatenating to prevent outputting unnecessary WHITESPACE
           self.PROVNOTE_123		:= StringLib.StringToUpperCase(TRIM(TRIM(pInput.PROVNOTE_1,LEFT,RIGHT) + IF(pInput.PROVNOTE_1 <> '','',''),LEFT) 
												+ TRIM(TRIM(pInput.PROVNOTE_2,LEFT,RIGHT) + IF(pInput.PROVNOTE_2 <> '','',''),LEFT)        
													+ TRIM(TRIM(pInput.PROVNOTE_3,LEFT,RIGHT) + IF(pInput.PROVNOTE_3 <> '','',''),LEFT));
											
		   //Identify Company name via AFFIL_TYPE_CD
		   self.TMP_NAME_COMPANY	:= MAP((pInput.AFFIL_TYPE_CD = 'IN' and pInput.NAME_MARI_ORG <> '')	=> StringLib.StringToUpperCase(pInput.NAME_MARI_ORG),
										   (pInput.AFFIL_TYPE_CD = 'IN' and pInput.NAME_MARI_ORG = '')		=> StringLib.StringToUpperCase(pInput.NAME_OFFICE),
										   (pInput.AFFIL_TYPE_CD <> 'IN' and pInput.NAME_MARI_ORG <> '')	=> StringLib.StringToUpperCase(pInput.NAME_MARI_ORG),
										   (pInput.AFFIL_TYPE_CD <> 'IN' and pInput.NAME_MARI_ORG = '')  	=> StringLib.StringToUpperCase(pInput.NAME_ORG),
										   '');
										   
		   self.TMP_NAME_DBA		:= IF(pInput.NAME_MARI_DBA <> '', StringLib.StringToUpperCase(pInput.NAME_MARI_DBA), pInput.NAME_DBA);
		   self.LICENSOR_KEY		:= HASH(pInput.STD_SOURCE_UPD);
		   
		   // Create LICENSE HASH key for LICENSE FILE for splitting process
		   self.LICENSE_KEY			:= HASH(self.LICENSOR_KEY
										  + pInput.STD_PROF_DESC
										  + pInput.LICENSE_NBR
										  + pInput.OFF_LICENSE_NBR
										  + pInput.STD_LICENSE_DESC
										  + pInput.STD_STATUS_DESC
										  + pInput.ORIG_ISSUE_DTE
										  + pInput.CURR_ISSUE_DTE
										  + pInput.EXPIRE_DTE);
			
		  // Create PRIME HASH key for ENTITY FILE for splitting process								
		  // Signature for ADDRESS1 if ADDRESS1 is populated or not
		   self.PRIME_KEY_1			:= HASH(self.LICENSE_KEY
										+ self.TMP_NAME_COMPANY
										+ pInput.NAME_LAST
										+ pInput.NAME_FIRST
										+ pInput.NAME_MID
										+ pInput.NAME_SUFX
										+ pInput.BIRTH_DTE
								//		+ self.ADDR_BUS_IND
										+ pInput.ADDR_ADDR1_1
										+ pInput.ADDR_ADDR1_2
										+ pInput.ADDR_CITY_1
										+ pInput.ADDR_STATE_1
										+ pInput.ADDR_ZIP5_1
										+ pInput.ADDR_ZIP4_1
										+ pInput.PHN_MARI_1
										+ pInput.PHN_MARI_FAX_1);
										
		 // Create signature for ADDRESS2 only if ADDRESS1 is populated								
		   self.PRIME_KEY_2			:= IF(pInput.ADDR_ADDR2_1 <> '', HASH(self.LICENSE_KEY
																	+ self.TMP_NAME_COMPANY
																	+ pInput.NAME_LAST
																	+ pInput.NAME_FIRST
																	+ pInput.NAME_MID
																	+ pInput.NAME_SUFX
																	+ pInput.BIRTH_DTE
															//		+ self.ADDR_BUS_IND
																	+ pInput.ADDR_ADDR2_1
																	+ pInput.ADDR_ADDR2_2
																	+ pInput.ADDR_CITY_2
																	+ pInput.ADDR_STATE_2
																	+ pInput.ADDR_ZIP5_2
																	+ pInput.ADDR_ZIP4_2
																	+ pInput.PHN_MARI_1
																	+ pInput.PHN_MARI_FAX_1),0);
		  
		   // Create DBA HASH key for DBA FILE for splitting process											
		   self.DBA_KEY				:= IF(self.TMP_NAME_DBA <> '', HASH(self.PRIME_KEY_1,'D',self.TMP_NAME_DBA),0);
										
			// Create CONTACT HASH key for DBA FILE for splitting process							
		   self.CONTACT_KEY			:= IF(pInput.NAME_CONTACT_LAST <> '',
											HASH(self.PRIME_KEY_1,'C',TRIM(TRIM(pInput.NAME_CONTACT_LAST,LEFT,RIGHT) 
												+ IF(pInput.NAME_CONTACT_LAST <> '',', ',''),LEFT) + TRIM(TRIM(pInput.NAME_CONTACT_FIRST,LEFT,RIGHT) 
												      + IF(pInput.NAME_CONTACT_FIRST <> '','',''),LEFT) + TRIM(TRIM(pInput.NAME_CONTACT_MID,LEFT,RIGHT) 
													        + IF(pInput.NAME_CONTACT_MID <> '','',''),LEFT) + TRIM(pInput.NAME_CONTACT_SUFX,LEFT,RIGHT)),0);
		   
		   self  := pInput;
	       self	 := [];
		  	   
END;


dsBaseRecOut     := PROJECT(file_MARIBASE_in, xformMARIBASE(left));


// Creating Record Key to be used to bump against previous processed base file
Prof_License_Mari.layouts_reference.MARIFLAT_out xformMARIBasePrimary(dsBaseRecOut pInput) 
    := 
	   TRANSFORM
	       self.PRIMARY_KEY			:= HASH(pInput.STD_SOURCE_UPD
											+ pInput.TMP_NAME_COMPANY
											+ pInput.NAME_LAST
											+ pInput.NAME_FIRST
											+ pInput.NAME_MID
											+ pInput.ADDR_ADDR1_1
											+ pInput.ADDR_ADDR1_2
											+ pInput.ADDR_CITY_1
											+ pInput.ADDR_STATE_1
											+ pInput.ADDR_ZIP5_1
											+ pInput.ADDR_ZIP4_1
											+ pInput.LICENSE_NBR
											+ pInput.STD_LICENSE_TYPE
											+ pInput.STD_LICENSE_STATUS
											+ pInput.ORIG_ISSUE_DTE);
		   self  := pInput;	       
	   
END;

dsAllMARIBaseOut     := PROJECT(dsBaseRecOut, xformMARIBasePrimary(left));

// Creating Main/Branch Logic via AFFIL_TYPE_CD				
layouts_reference.MARIFLAT_relate xformMARIBaseRelate(dsAllMARIBaseOut pInput) 
    := 
	   TRANSFORM
		   self.ENTITY_FOREIGN		:= 0;
		   self.RELATION_KEY		:= IF(pInput.AFFIL_TYPE_CD[1..2] in['IN','CO',''], 0, 1);
		   self.NOTES				:= ' ';
		   self  := pInput;	       
	   
END;
rsRelateRecOut     := PROJECT(dsAllMARIBaseOut, xformMARIBaseRelate(left));


// Relating Main records to Branch records
layouts_reference.MARIFLAT_relate	doForeignJoin(rsRelateRecOut Linput, rsRelateRecOut Rinput) := TRANSFORM
			self.ENTITY_FOREIGN		:= Rinput.PRIME_KEY_1;
			self := Linput;
END;
	  

ds_RelateBrch	:= JOIN(rsRelateRecOut , rsRelateRecOut,
					     LEFT.PCMC_SLPK = RIGHT.CMC_SLPK 
						   and LEFT.PCMC_SLPK <> 0,
						   doForeignJoin(LEFT,RIGHT), LEFT OUTER, LOCAL, LOOKUP);

// "PROMOTE" Branch records to Main if Main/Branch relationship does not exist
layouts_reference.MARIFLAT_relate xformBranchToMain(ds_RelateBrch pInput) 
    := 
	   TRANSFORM
	       self.RELATION_KEY		:= IF(pInput.RELATION_KEY = 1 and pInput.ENTITY_FOREIGN = 0,0,pInput.RELATION_KEY);
		   self.NOTES				:= IF(pInput.AFFIL_TYPE_CD = 'BR' and pInput.ENTITY_FOREIGN = 0,
											'THIS IS NOT A MAIN OFFICE. IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.','');

		   self  := pInput;	       
	   
END;
rsAllEntityRecOut     := PROJECT(ds_RelateBrch, xformBranchToMain(left));


//output(choosen(dsAllMARIKeyRecsOut,1000));

//output(rsAllEntityRecOut,,'~thor_data400::out::Prof_License_MARI_base',overwrite);


export proc_MARI_base_full := output(rsAllEntityRecOut,,'~thor_data400::out::proflic::mari::incremental',overwrite);

export proc_BASE_FLAT_conversion := '';