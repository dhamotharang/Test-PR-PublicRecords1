IMPORT BKForeclosure,ut;

EXPORT Normalize_Nod(DATASET(Layout_BK.Nod) ds_nod) := FUNCTION	
//Input files
//input and row identifier appended layouts
  Nod_in    := BKForeclosure.Layout_BK.Nod;
//-----------------------------------------------------------------
//NORMALIZE Names
//-----------------------------------------------------------------
/*
  'CT'   = Contact Name
  'TR'   = Trustee Name
*/
Co_Pattern  := '( AND | ASSOCIATES|ASSOCIATION| PC$| OF | PLLC$| PLC$| PA$| FIRM$| LP$| INC| LLC$| LLC |L L C| LC$| LLP$|MORTGAGE|INSURANCE|REGISTRATION| LAW | LAW$|' +
               'SOLUTION|&| AGENCY|COMPANY| RE$| BANKS|BANK| BANKER| GROUP| PROPERTIES| REALTY|INVESTMENT|DEVELOPMENT|OFFICE|INVESTORS|TRULIANT FCU|' +
							 ' MTG$| MTG | CORP$| CORPS$| FUND | CORPORATION| CO$| CO NA$| LENDING| TRUST| HOME| ASSISTANCE| SERVICE|^THE | BBQ|^HUD$|FDIC$|' +
							 'FINANCIAL|NATIONAL|PARTNERS| LTD$|LTD |FAMILY|REAL ESTATE|NETWORK|UNITED|CLUB|^ASSET |ASSET|MANAGEMENT| AT | CREDIT| FINANCE|EVERBANK|'+
							 'FANNIE MAE| UNION| AUTHORITY|COUNTY|^FNMA|CONDOMINIUM|AMERICA|BUSINESS|COMMUNITIES|SCHOOL| LOAN|CERTIFICATE|FEDERAL| FUND| CHURCH|'+
							 ' BRANCH| FCU$| PROFIT|PRIVATE|COMMERCIAL|ANNUNITY|FIRST| CNTY$)';
invalid_Pattern := '(NOT PROVIDED|NOT GIVEN|NO PROVIDED| NONE)';

// Normalized Name records
Layout_BK.Norm_Names_nod t_norm_name_nod (Nod_in le, INTEGER C) := TRANSFORM
  trim_contact_fname  := ut.CleanSpacesAndUpper(le.contact_fname);
  trim_contact_lname  := ut.CleanSpacesAndUpper(le.contact_lname);
	trim_trustee_fname  := ut.CleanSpacesAndUpper(le.trustee_fname);
	trim_trustee_lname  := ut.CleanSpacesAndUpper(le.trustee_lname);

	contact_fname       := IF(NOT REGEXFIND(Co_Pattern, trim_contact_fname) AND NOT REGEXFIND(invalid_pattern, trim_contact_fname) 
	                           AND trim_contact_fname != '',StringLib.StringCleanSpaces(trim_contact_fname),'');
	contact_lname       := IF(NOT REGEXFIND(Co_Pattern, trim_contact_lname) AND NOT REGEXFIND(invalid_pattern, trim_contact_lname) 
	                           AND trim_contact_lname != '',StringLib.StringCleanSpaces(trim_contact_lname),'');		
  trustee_fname       := IF(NOT REGEXFIND(Co_Pattern, trim_trustee_fname) AND NOT REGEXFIND(invalid_pattern, trim_trustee_fname) 
	                           AND trim_trustee_fname != '',StringLib.StringCleanSpaces(trim_trustee_fname),'');
	trustee_lname       := IF(NOT REGEXFIND(Co_Pattern, le.trustee_lname) AND NOT REGEXFIND(invalid_pattern, trim_trustee_lname) 
	                           AND trim_trustee_lname != '',StringLib.StringCleanSpaces(trim_trustee_lname),'');		

	company_Name1	      := MAP(REGEXFIND(Co_Pattern, trim_contact_fname) AND NOT REGEXFIND(invalid_pattern, trim_contact_fname)=> StringLib.StringCleanSpaces(trim_contact_fname),
													  REGEXFIND(Co_Pattern, trim_contact_lname) AND NOT REGEXFIND(invalid_pattern, trim_contact_lname)=> StringLib.StringCleanSpaces(trim_contact_lname),
	                          '');
	
	Company_Name2	      := MAP(REGEXFIND(Co_Pattern, trim_trustee_fname) AND NOT REGEXFIND(invalid_pattern, trim_trustee_fname) => StringLib.StringCleanSpaces(trim_trustee_fname),
	                          REGEXFIND(Co_Pattern, trim_trustee_lname) AND NOT REGEXFIND(invalid_pattern, trim_trustee_lname) => StringLib.StringCleanSpaces(trim_trustee_lname),
													  ''); 															 
  SELF.NAME_FIRST       := CHOOSE(C,contact_fname,trustee_fname);
	SELF.NAME_LAST				:= CHOOSE(C,contact_lname,trustee_lname);
	SELF.COMPANY_NAME     := CHOOSE(C,company_Name1,company_Name2);
  SELF.TYPE_CODE        := IF(SELF.Company_Name != '','B','P');	// 'B' stand for Business record, 'P' stand for Individual record
	SELF.NAME_FULL        := IF(SELF.TYPE_CODE = 'P',TRIM(SELF.NAME_LAST + ' ' + SELF.NAME_FIRST,LEFT,RIGHT), SELF.COMPANY_NAME);
	SELF.NAME_TYPE        := CHOOSE(C,'CT','TR');
	SELF 					:= le;
	SELF					:= [];
END;

	Norm_Name 	  := DEDUP(NORMALIZE(ds_nod,4,t_norm_name_Nod(LEFT,COUNTER)),ALL,RECORD);
  GoodNormName  := Norm_Name(TRIM(Name_Last + Name_First + Company_Name,ALL) <> '');	
  ds_Norm_name  := PROJECT(GoodNormName,TRANSFORM(Layout_BK.Norm_Names_Nod,SELF := LEFT;SELF:=[])): PERSIST('~thor_data400::in::BKForeclosure::NormName_Nod_Test');

//-----------------------------------------------------------------
//NORMALIZE Address
//-----------------------------------------------------------------
Layout_BK.Norm_Addr_NOD t_norm_addr_nod (Layout_BK.Norm_Names_nod le, INTEGER C) := TRANSFORM
  contact_mail_full_addr:= ut.CleanSpacesAndUpper(le.contact_mail_full_addr);
  trustee_mail_full_addr:= ut.CleanSpacesAndUpper(le.trustee_mail_full_addr);
  property_full_addr  := ut.CleanSpacesAndUpper(le.property_full_addr);
	contact_mail_city   := ut.CleanSpacesAndUpper(le.contact_mail_city);
	trustee_mail_city   := ut.CleanSpacesAndUpper(le.trustee_mail_city);
	prop_addr_city      := ut.CleanSpacesAndUpper(le.prop_addr_city);
	contact_mail_state  := ut.CleanSpacesAndUpper(le.contact_mail_state);
	trustee_mail_state  := ut.CleanSpacesAndUpper(le.trustee_mail_state);
	prop_addr_state     := ut.CleanSpacesAndUpper(le.prop_addr_state);
	SELF.Orig_Address   := CHOOSE(C, contact_mail_full_addr, trustee_mail_full_addr,property_full_addr); 
	SELF.Orig_Unit      := CHOOSE(C, le.contact_mail_unit, le.trustee_mail_unit, le.prop_addr_unit_no);
	SELF.Orig_City      := CHOOSE(C, contact_mail_city, trustee_mail_city, prop_addr_city);
	SELF.Orig_State     := CHOOSE(C, contact_mail_state, trustee_mail_state, prop_addr_state);
	SELF.Orig_Zip5      := CHOOSE(C, le.contact_mail_zip5, le.trustee_mail_zip5, le.prop_addr_zip5);
	SELF.Orig_Zip4      := CHOOSE(C, le.contact_mail_zip4, le.trustee_mail_zip4, le.prop_addr_zip4);	
	SELF.AddrType       := CHOOSE(C,'CM','TM','PF');	
	SELF 					:= le;
	SELF					:= [];
END;

Norm_Addr    := DEDUP(NORMALIZE(ds_Norm_name, 3, t_norm_addr_nod(LEFT, COUNTER)),ALL,RECORD);
GoodNormAddr := Norm_Addr(TRIM(Orig_Address + Orig_City + Orig_State + Orig_zip5 + Orig_zip4,ALL) <> '');
ds_final     := PROJECT(GoodNormAddr, Layout_BK.Norm_Addr_NOD) : PERSIST('~thor_data400::in::BKForeclosure::Normalized_Nod_Test');

	RETURN ds_final;
END;