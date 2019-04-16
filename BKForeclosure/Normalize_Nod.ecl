IMPORT BKForeclosure,ut,STD;

EXPORT Normalize_Nod(DATASET(Layout_BK.Base_Nod_ext) ds_nod) := FUNCTION	

//-----------------------------------------------------------------
//NORMALIZE Names
//-----------------------------------------------------------------
/*
  'BR'   = Borrower Name
	'B2'   = Borrower2 Name
	'CT'	 = Contact Name
  'TR'   = Trustee Name
*/

//-----------------------------------------------------------------
//NORMALIZE Address
//-----------------------------------------------------------------
/*
  'PF'   = Property Address
	'CM'	 = Contact Address
  'TM'   = Trustee Address
*/

Co_Pattern  := '( AND | ASSOCIATES|ASSOCIATION| PC$| OF | PLLC$| PLC$| PA$| FIRM$| LP$| INC| LLC$| LLC |L L C| LC$| LLP$|MORTGAGE|INSURANCE|REGISTRATION| LAW | LAW$|' +
               'SOLUTION|&| AGENCY|COMPANY| RE$| BANKS|BANK| BANKER| GROUP| PROPERTIES| REALTY|INVESTMENT|DEVELOPMENT|OFFICE|INVESTORS|TRULIANT FCU|' +
							 ' MTG$| MTG | CORP$| CORPS$| FUND | CORPORATION| CO$| CO NA$| LENDING| TRUST| HOME| ASSISTANCE| SERVICE|^THE | BBQ|^HUD$|FDIC$|' +
							 'FINANCIAL|NATIONAL|PARTNERS| LTD$|LTD |FAMILY|REAL ESTATE|NETWORK|UNITED|CLUB|^ASSET |ASSET|MANAGEMENT| AT | CREDIT| FINANCE|EVERBANK|'+
							 'FANNIE MAE| UNION| AUTHORITY|COUNTY|^FNMA|CONDOMINIUM|AMERICA|BUSINESS|COMMUNITIES|SCHOOL| LOAN|CERTIFICATE|FEDERAL| FUND| CHURCH|'+
							 ' BRANCH| FCU$| PROFIT|PRIVATE|COMMERCIAL|ANNUNITY|FIRST| CNTY$)';
invalid_Pattern := '(NOT PROVIDED|NOT GIVEN|NO PROVIDED| NONE)';

// Normalized Name records
Layout_BK.CleanFields_NOD t_norm_nod (layout_BK.base_nod_ext le, INTEGER C) := TRANSFORM
  trim_borrower1_fname  := ut.CleanSpacesAndUpper(le.borrower1_fname);
  trim_borrower1_lname  := ut.CleanSpacesAndUpper(le.borrower1_lname);
	trim_borrower2_fname  := ut.CleanSpacesAndUpper(le.borrower2_fname);
  trim_borrower2_lname  := ut.CleanSpacesAndUpper(le.borrower2_lname);
	trim_contact_fname  := ut.CleanSpacesAndUpper(le.contact_fname);
  trim_contact_lname  := ut.CleanSpacesAndUpper(le.contact_lname);
	trim_trustee_fname  := ut.CleanSpacesAndUpper(le.trustee_fname);
	trim_trustee_lname  := ut.CleanSpacesAndUpper(le.trustee_lname);

	borrower1_fname     := IF(NOT REGEXFIND(invalid_pattern, trim_borrower1_fname) 
	                           ,trim_borrower1_fname,'');
	borrower1_lname     := IF(NOT REGEXFIND(invalid_pattern, trim_borrower1_lname) 
	                           ,trim_borrower1_lname,'');	
	borrower2_fname     := IF(NOT REGEXFIND(invalid_pattern, trim_borrower2_fname) 
	                           ,trim_borrower2_fname,'');
	borrower2_lname     := IF(NOT REGEXFIND(invalid_pattern, trim_borrower2_lname) 
	                           ,trim_borrower2_lname,'');
	contact_fname       := IF(NOT REGEXFIND(invalid_pattern, trim_contact_fname) 
	                           ,trim_contact_fname,'');
	contact_lname       := IF(NOT REGEXFIND(invalid_pattern, trim_contact_lname) 
	                          ,trim_contact_lname,'');
  trustee_fname       := IF(NOT REGEXFIND(invalid_pattern, trim_trustee_fname) 
	                          ,trim_trustee_fname,'');
	trustee_lname       := IF(NOT REGEXFIND(invalid_pattern, trim_trustee_lname) 
	                           ,trim_trustee_lname,'');
														 
	contact_phone				:= STD.Str.Filter(le.contact_telephone,'1234567890');
	trustee_phone				:= STD.Str.Filter(le.trustee_telephone,'1234567890');
			 
  SELF.NAME_FIRST       := CHOOSE(C,borrower1_fname,borrower2_fname,contact_fname,trustee_fname);
	SELF.NAME_LAST				:= CHOOSE(C,trim_borrower1_lname,trim_borrower2_lname,contact_lname,trustee_lname);
	SELF.NAME_FULL        := STD.Str.CleanSpaces(TRIM(SELF.NAME_FIRST,LEFT,RIGHT)+' '+TRIM(SELF.NAME_LAST,LEFT,RIGHT));
	SELF.NAME_TYPE        := CHOOSE(C,'BR','B2','CT','TR');
	SELF.phone						:= CHOOSE(C,'','',contact_phone,trustee_phone);
	contact_addr:= ut.CleanSpacesAndUpper(le.contact_mail_full_addr);
  trustee_addr:= ut.CleanSpacesAndUpper(le.trustee_mail_full_addr);
  property_addr  := ut.CleanSpacesAndUpper(le.property_full_addr);
	contact_city   := ut.CleanSpacesAndUpper(le.contact_mail_city);
	trustee_city   := ut.CleanSpacesAndUpper(le.trustee_mail_city);
	prop_city      := ut.CleanSpacesAndUpper(le.prop_addr_city);
	contact_state  := ut.CleanSpacesAndUpper(le.contact_mail_state);
	trustee_state  := ut.CleanSpacesAndUpper(le.trustee_mail_state);
	prop_state     := ut.CleanSpacesAndUpper(le.prop_addr_state);
	SELF.Orig_Address   := CHOOSE(C, property_addr, property_addr, contact_addr, trustee_addr); 
	SELF.Orig_Unit      := CHOOSE(C, le.prop_addr_unit_no, le.prop_addr_unit_no, le.contact_mail_unit, le.trustee_mail_unit);
	SELF.Orig_City      := CHOOSE(C, prop_city, prop_city, contact_city, trustee_city);
	SELF.Orig_State     := CHOOSE(C, prop_state, prop_state, contact_state, trustee_state);
	SELF.Orig_Zip5      := CHOOSE(C, le.prop_addr_zip5, le.prop_addr_zip5, le.contact_mail_zip5, le.trustee_mail_zip5);
	SELF.Orig_Zip4      := CHOOSE(C, le.prop_addr_zip4, le.prop_addr_zip4, le.contact_mail_zip4, le.trustee_mail_zip4);	
	SELF.AddrType       := CHOOSE(C,'PF','PF','CM','TM');
	SELF 					:= le;
	SELF					:= [];
END;

	Norm_Name 	  := DEDUP(NORMALIZE(ds_nod,4,t_norm_Nod(LEFT,COUNTER)),ALL,RECORD);
  GoodNormName  := Norm_Name(TRIM(Name_Last + Name_First,ALL) <> '');	
  ds_final		  := PROJECT(GoodNormName,TRANSFORM(Layout_BK.CleanFields_NOD,SELF := LEFT;SELF:=[])): PERSIST('~thor_data400::in::BKForeclosure::Normalized_Nod');

	RETURN ds_final;
END;