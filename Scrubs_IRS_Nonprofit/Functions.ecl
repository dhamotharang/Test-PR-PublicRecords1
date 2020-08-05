IMPORT Scrubs_IRS_Nonprofit, Scrubs, ut, _validate, std, Codes;
	
EXPORT Functions := MODULE
		
	
  //************************************************************************************
	//fn_invalid_addr:  returns true if length not 1 or greater, or contains bad addresses
	//************************************************************************************
	EXPORT fn_invalid_addr(STRING s) := function  
    cln_str := ut.CleanSpacesAndUpper(s);
	  RETURN IF(LENGTH(cln_str) > 1 AND NOT REGEXFIND('^LOCAL$|LOCAL',cln_str),1,0);
  END;

	//****************************************************************************
	//fn_verify_state:  returns true or false based upon whether or not there is
  //                  a valid state abbreviation.
	//****************************************************************************
	EXPORT fn_verify_state(STRING code) := function    
	  cln_code := ut.CleanSpacesAndUpper(code);
	  RETURN IF(LENGTH(cln_code) = 2 and LENGTH(Codes.St2Name(cln_code)) > 0, 1, 0);
  END;
	
	//****************************************************************************
	//fn_verify_full_zip: returns true or false based upon whether or not there is
	// a numeric value.
	//****************************************************************************
	EXPORT fn_verify_full_zip(STRING zip) := function 
		RETURN IF(LENGTH(trim(zip, all)) = 10 AND Stringlib.StringFilterOut(trim(zip, all), '0123456789-') = '' AND trim(zip) <> '00000-0000', 1, 0);
	END;

  //****************************************************************************
	//fn_verify_grp_exempt_num: returns true or false based upon whether or not there is
	// a numeric value.
	//****************************************************************************
	EXPORT fn_verify_grp_exempt_num(STRING num) := function 
		RETURN IF(LENGTH(trim(num, all)) = 4 AND Stringlib.StringFilterOut(trim(num, all), '0123456789') = '' AND trim(num) <> '0000', 1, 0);
	END;
		
	//****************************************************************************
	//fn_verify_affiliation_code: returns true or false based upon whether or not the
	// sffiliation code is valid.
	//****************************************************************************
	EXPORT fn_verify_affiliation_code(STRING code) := function
	  valid_codes := ['1','2','3','4','5','6','7','8','9',''];
		RETURN IF(trim(code, all) in valid_codes, 1, 0);
	END;
	
	//****************************************************************************
	//fn_verify_subsctn_code: returns true or false based upon whether or not the
	// subsection code is valid.
	//****************************************************************************
	EXPORT fn_verify_subsctn_code(STRING code) := function
	  valid_codes := ['01','02','03','04','05','06','07','08','09','10','11',
		                '12','13','14','15','16','17','18','19','20','21','22',
										'23','24','25','26','27','40','50','60','70','71','81','91','92',''];
		RETURN IF(trim(code, all) in valid_codes, 1, 0);
	END;
	
	//****************************************************************************
	//fn_verify_class_code: returns true or false based upon whether or not the
	// classification code is valid.
	//****************************************************************************
	EXPORT fn_verify_class_code(STRING code) := function
	  valid_codes := ['1','2','3','4','5','6','7','8',''];
		RETURN IF(trim(code, all) in valid_codes, 1, 0);
	END;
	
	//********************************************************************************
	//fn_invalid_date:  Returns true if valid past date.
	//********************************************************************************
	EXPORT fn_invalid_date(STRING s) := function   
     dte_str := trim(s) + '01';
		 RETURN IF(Scrubs.Functions.fn_past_yyyymmdd(dte_str) > 0, 1, 0);
  END;

  //****************************************************************************
	//fn_verify_deductibility_code: returns true or false based upon whether or 
	// not the deductibility code is valid.
	//****************************************************************************
	EXPORT fn_verify_deductibility_code(STRING code) := function
	  valid_codes := ['1','2','4',''];
		RETURN IF(trim(code, all) in valid_codes, 1, 0);
	END;
	
	//****************************************************************************
	//fn_verify_foundation_code: returns true or false based upon whether or 
	// not the foundation code is valid.
	//****************************************************************************
	EXPORT fn_verify_foundation_code(STRING code) := function
	  valid_codes := ['00','02','03','04','09','10','11','12','13','14','15','16','17','18',''];
		RETURN IF(trim(code, all) in valid_codes, 1, 0);
	END;
	
	//****************************************************************************
	//fn_verify_activity_code: returns true or false based upon whether or 
	// not the activity code is valid.
	//****************************************************************************
	EXPORT fn_verify_activity_code(STRING code) := function
	  valid_codes := ['001','002','003','004','005','006','007','008','029','030','031','032','033','034','035',
										'036','037','038','039','040','041','042','043','044','045','046','059','060','061','062',
										'063','064','065','088','089','090','091','092','093','094','119','120','121','122','123',
										'124','125','126','149','150','151','152','153','154','155','156','157','158','159','160',
										'161','162','163','164','165','166','167','168','169','179','180','181','199','200','201',
										'202','203','204','205','206','207','208','209','210','211','212','213','229','230','231',
										'232','233','234','235','236','237','249','250','251','252','253','254','259','260','261',
										'262','263','264','265','266','267','268','269','279','280','281','282','283','284','285',
										'286','287','288','296','297','298','299','300','301','317','318','319','320','321','322',
										'323','324','325','326','327','328','349','350','351','352','353','354','355','356','379',
										'380','381','382','398','399','400','401','402','403','404','405','406','407','408','429',
										'430','431','432','449','460','461','462','463','465','480','481','482','483','484','509',
										'510','511','512','513','514','515','516','517','518','519','520','521','522','523','524',
										'525','526','527','528','529','530','531','532','533','534','535','536','537','538','539',
										'540','541','542','543','559','560','561','562','563','564','565','566','567','568','569',
										'572','573','574','575','600','601','602','603','900','901','902','903','904','905','906',
										'907','908','909','910','911','912','913','914','915','916','917','918','919','920','921',
										'922','923','924','925','926','927','928','930','931','990','994','995','998',''];
		RETURN IF(trim(code, all) in valid_codes, 1, 0);
	END;
	
	//****************************************************************************
	//fn_verify_org_code: returns true or false based upon whether or 
	// not the organization code is valid.
	//****************************************************************************
	EXPORT fn_verify_org_code(STRING code) := function
	  valid_codes := ['1','2','3','4','5',''];
		RETURN IF(trim(code, all) in valid_codes, 1, 0);
	END;
	
	//****************************************************************************
	//fn_verify_org_exempt_code: returns true or false based upon whether or 
	// not the exemption organization status code is valid.
	//****************************************************************************
	EXPORT fn_verify_org_exempt_code(STRING code) := function
	  valid_codes := ['01','02','12','25','32',''];
		RETURN IF(trim(code, all) in valid_codes, 1, 0);
	END;
	
	//****************************************************************************
	//fn_verify_asset_inc_code: returns true or false based upon whether or 
	// not the asset/income code is valid.
	//****************************************************************************
	EXPORT fn_verify_asset_inc_code(STRING code) := function
	  valid_codes := ['0','1','2','3','4','5','6','7','8','9',''];
		RETURN IF(trim(code, all) in valid_codes, 1, 0);
	END;
	
	//****************************************************************************
	//fn_fil_req_pt1_code: returns true or false based upon whether or 
	// not the filing requirement code part 1 is valid.
	//****************************************************************************
	EXPORT fn_fil_req_pt1_code(STRING code) := function
	  valid_codes := ['','00','01','02','03','06','07','13','14',''];
		RETURN IF(trim(code, all) in valid_codes, 1, 0);
	END;
	
	//****************************************************************************
	//fn_fil_req_pt2_code: returns true or false based upon whether or 
	// not the filing requirement code part 2 is valid.
	//****************************************************************************
	EXPORT fn_fil_req_pt2_code(STRING code) := function
	  valid_codes := ['','0','1'];
		RETURN IF(trim(code, all) in valid_codes, 1, 0);
	END;
	
	//****************************************************************************
	//fn_acct_period_code: returns true or false based upon whether or 
	// not the accounting period code is valid.
	//****************************************************************************
	EXPORT fn_acct_period_code(STRING code) := function
	  valid_codes := ['','01','02','03','04','05','06','07','08','09','10','11','12'];
		RETURN IF(trim(code, all) in valid_codes, 1, 0);
	END;
	
	//************************************************************************************
	//fn_valid_amount:  returns true or false based upon whether or not the asset amount
	// or the income amount is valid
	//************************************************************************************
	EXPORT fn_valid_amount(STRING s) := function  
    nmbr := ut.CleanSpacesAndUpper(s);
	  RETURN IF(nmbr = '' or ut.isNumeric(nmbr),1,0);
  END;
	
	//**********************************************************************************
	//fn_valid_form990_amt: returns true or false based upon whether or not the Form 990
	// Revenue Amount is valid 
	//**********************************************************************************
	EXPORT fn_valid_form990_amt(STRING s) := FUNCTION
    nmbr := ut.CleanSpacesAndUpper(s);
		RETURN IF(nmbr = '' OR Stringlib.StringFilterOut(nmbr, '0123456789-') = '', 1, 0);
	END;	
  	
	//*******************************************************************************************
	//fn_valid_natl_tax_exempt_code: returns true or false based upon whether or not the National
	// Taxonomy Exemption Code is valid 
	//*******************************************************************************************
	EXPORT fn_valid_natl_tax_exempt_code(STRING s) := FUNCTION
    cln_str := ut.CleanSpacesAndUpper(s);
		RETURN IF(cln_str = '' OR 
		          cln_str[1] in ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'] AND
							Stringlib.StringFilterOut(cln_str[2..3], '0123456789ABCE') = '', 1, 0);
	END;	
	

END;