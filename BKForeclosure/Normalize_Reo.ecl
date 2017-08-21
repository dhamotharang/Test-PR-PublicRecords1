IMPORT BKForeclosure,ut;

EXPORT Normalize_Reo(DATASET(RECORDOF(Layout_BK.reo)) ds_reo) := Function	
//input, and row identifier appended layouts
  reo_in    := BKForeclosure.Layout_BK.reo;
//-----------------------------------------------------------------
//NORMALIZE Names
//-----------------------------------------------------------------
/*
  'B1'  = 1st Buyer Name
	'B2'  = 2nd Buyer Name
  'S1'  = 1st Seller Name
	'S2'  = 2nd Seller Name
  'PF'  = Property Address
  'BM'  = Buyer Mailing Address
*/
Co_Pattern  := '( AND | ASSOCIATES|ASSOCIATION| PC$| OF | PLLC$| PLC$| PA$| FIRM$| LP$| INC| LLC$| LLC |L L C| LC$| LLP$|MORTGAGE|INSURANCE|REGISTRATION| LAW | LAW$|' +
               'SOLUTION|&| AGENCY|COMPANY| RE$| BANKS|BANK| BANKER| GROUP| PROPERTIES| REALTY|INVESTMENT|DEVELOPMENT|OFFICE|INVESTORS|TRULIANT FCU|' +
							 ' MTG$| MTG | CORP$| CORPS$| FUND | CORPORATION| CO$| CO NA$| LENDING| TRUST| HOME| ASSISTANCE| SERVICE|^THE | BBQ|^HUD$|FDIC$|' +
							 'FINANCIAL|NATIONAL|PARTNERS| LTD$|LTD |FAMILY|REAL ESTATE|NETWORK|UNITED|CLUB|^ASSET |ASSET|MANAGEMENT| AT | CREDIT| FINANCE|EVERBANK|'+
							 'FANNIE MAE| UNION| AUTHORITY|COUNTY|^FNMA|CONDOMINIUM|AMERICA|BUSINESS|COMMUNITIES|SCHOOL| LOAN|CERTIFICATE|FEDERAL| FUND| CHURCH|'+
							 ' BRANCH| FCU$| PROFIT|PRIVATE|COMMERCIAL|ANNUNITY|FIRST| CNTY$)';
invalid_Pattern := '(NOT PROVIDED|NOT GIVEN|NO PROVIDED| NONE)';

// Normalized Name records
Layout_BK.Norm_Names_reo t_norm_name_reo (Reo_in  le, INTEGER C) := TRANSFORM
	trim_buyer_fname1      := StringLib.StringCleanSpaces(ut.CleanSpacesAndUpper(le.buyer1_fname));
	trim_buyer_lname1      := StringLib.StringCleanSpaces(ut.CleanSpacesAndUpper(le.buyer1_lname));
	trim_buyer_fname2      := StringLib.StringCleanSpaces(ut.CleanSpacesAndUpper(le.buyer2_fname));
	trim_buyer_lname2      := StringLib.StringCleanSpaces(ut.CleanSpacesAndUpper(le.buyer2_lname));
	trim_seller_fname1     := StringLib.StringCleanSpaces(ut.CleanSpacesAndUpper(le.seller1_fname));
	trim_seller_lname1     := StringLib.StringCleanSpaces(ut.CleanSpacesAndUpper(le.seller1_lname));
	trim_seller_fname2     := StringLib.StringCleanSpaces(ut.CleanSpacesAndUpper(le.seller2_fname));
	trim_seller_lname2     := StringLib.StringCleanSpaces(ut.CleanSpacesAndUpper(le.seller2_lname));	

	buyer_fname1	    := IF(NOT REGEXFIND(Co_Pattern, trim_buyer_fname1) AND NOT REGEXFIND(invalid_pattern, trim_buyer_fname1)
	                        AND NOT REGEXFIND('[0-9/]', trim_buyer_fname1) AND trim_buyer_fname1 != '',StringLib.StringCleanSpaces(trim_buyer_fname1),'');
	buyer_lname1	    := IF(NOT REGEXFIND(Co_Pattern, trim_buyer_lname1) AND NOT REGEXFIND(invalid_pattern, trim_buyer_lname1) 
	                        AND NOT REGEXFIND('[0-9/]', trim_buyer_lname1) AND trim_buyer_lname1 != '',StringLib.StringCleanSpaces(trim_buyer_lname1),'');
	buyer_fname2	    := IF(NOT REGEXFIND(Co_Pattern, trim_buyer_fname2) AND NOT REGEXFIND(invalid_pattern, trim_buyer_fname2) 
	                        AND NOT REGEXFIND('[0-9/]', trim_buyer_fname2) AND trim_buyer_fname2 != '',StringLib.StringCleanSpaces(trim_buyer_fname2),'');
	buyer_lname2	    := IF(NOT REGEXFIND(Co_Pattern, trim_buyer_lname2) AND NOT REGEXFIND(invalid_pattern, trim_buyer_lname2) 
	                        AND NOT REGEXFIND('[0-9/]', trim_buyer_lname2) AND trim_buyer_lname2 != '',StringLib.StringCleanSpaces(trim_buyer_lname2),'');  
	seller_fname1	    := IF(NOT REGEXFIND(Co_Pattern, trim_seller_fname1) AND NOT REGEXFIND(invalid_pattern, trim_seller_fname1)
	                        AND NOT REGEXFIND('[0-9/]', trim_seller_fname1) AND trim_seller_fname1 != '',StringLib.StringCleanSpaces(trim_seller_fname1),'');
	seller_lname1	    := IF(NOT REGEXFIND(Co_Pattern, trim_seller_lname1) AND NOT REGEXFIND(invalid_pattern, trim_seller_lname1) 
	                        AND NOT REGEXFIND('[0-9/]', trim_seller_lname1) AND trim_seller_lname1 != '',StringLib.StringCleanSpaces(trim_seller_lname1),'');
	seller_fname2	    := IF(NOT REGEXFIND(Co_Pattern, trim_seller_fname2) AND NOT REGEXFIND(invalid_pattern, trim_seller_fname2) 
	                        AND NOT REGEXFIND('[0-9/]', trim_seller_fname2) AND trim_seller_fname2 != '',StringLib.StringCleanSpaces(trim_seller_fname2),'');
	seller_lname2	    := IF(NOT REGEXFIND(Co_Pattern, trim_seller_lname2) AND NOT REGEXFIND(invalid_pattern, trim_seller_lname2) 
	                        AND NOT REGEXFIND('[0-9/]', trim_seller_lname2) AND trim_seller_lname2 != '',StringLib.StringCleanSpaces(trim_seller_lname2),'');  
																									
	buyer_comp1	      := MAP(REGEXFIND(Co_Pattern, trim_buyer_fname1) AND NOT REGEXFIND(invalid_pattern, trim_buyer_fname1)=> StringLib.StringCleanSpaces(trim_buyer_fname1),
													REGEXFIND(Co_Pattern, trim_buyer_lname1) AND NOT REGEXFIND(invalid_pattern, trim_buyer_lname1)=> StringLib.StringCleanSpaces(trim_buyer_lname1),
													'');
	
	buyer_comp2	      := MAP(REGEXFIND(Co_Pattern, trim_buyer_fname2) AND NOT REGEXFIND(invalid_pattern, trim_buyer_fname2) => StringLib.StringCleanSpaces(trim_buyer_fname2),
	                        REGEXFIND(Co_Pattern, trim_buyer_lname2) AND NOT REGEXFIND(invalid_pattern, trim_buyer_lname2) => StringLib.StringCleanSpaces(trim_buyer_lname2),
													''); 												
	seller_comp1	      := MAP(REGEXFIND(Co_Pattern, trim_seller_fname1) AND NOT REGEXFIND(invalid_pattern, trim_seller_fname1)=> StringLib.StringCleanSpaces(trim_seller_fname1),
													   REGEXFIND(Co_Pattern, trim_seller_lname1) AND NOT REGEXFIND(invalid_pattern, trim_seller_lname1)=> StringLib.StringCleanSpaces(trim_seller_lname1),
													   '');
	
	seller_comp2	      := MAP(REGEXFIND(Co_Pattern, trim_seller_fname2) AND NOT REGEXFIND(invalid_pattern, trim_seller_fname2) => StringLib.StringCleanSpaces(trim_seller_fname2),
	                           REGEXFIND(Co_Pattern, trim_seller_lname2) AND NOT REGEXFIND(invalid_pattern, trim_seller_lname2) => StringLib.StringCleanSpaces(trim_seller_lname2),
													   ''); 												
	SELF.Name_First   := CHOOSE(C,buyer_fname1,buyer_fname2,seller_fname1,seller_fname2);
	SELF.Name_Last		:= CHOOSE(C,buyer_lname1,buyer_lname2,seller_lname1,seller_lname2);
	SELF.Company_Name := CHOOSE(C,buyer_comp1,buyer_comp2,seller_comp1,seller_comp2);
	SELF.Type_Code    := IF(SELF.Company_Name != '','B','P');// 'B' stands for Business, 'P' stands for Individual
	SELF.name_type    := CHOOSE(C,'B1','B2','S1','S2'); 
	SELF.NAME_FULL    := IF(SELF.Type_Code = 'P',SELF.Name_Last + ' ' + SELF.Name_First, SELF.company_name);
	SELF 					:= le;
	SELF					:= [];
END;

	Norm_Name 	  := DEDUP(NORMALIZE(ds_reo,4,t_norm_name_reo(LEFT,COUNTER)),ALL,RECORD);
  GoodNormName  := Norm_Name(TRIM(Name_Last + Name_First + Company_Name,ALL) <> '');	
  ds_Norm_name  := PROJECT(GoodNormName,TRANSFORM(Layout_BK.Norm_Names_Reo,SELF := LEFT;SELF:=[])): PERSIST('~thor_data400::in::BKForeclosure::NormName_Reo_Test');

//-----------------------------------------------------------------
//NORMALIZE Address
//-----------------------------------------------------------------
Layout_BK.Norm_Addr_REO t_norm_addr_reo (Layout_BK.Norm_Names_reo le, INTEGER C) := TRANSFORM
  prop_full_addr        := ut.CleanSpacesAndUpper(le.prop_full_addr);
	prop_addr_city        := ut.CleanSpacesAndUpper(le.prop_addr_city);
	prop_addr_state       := ut.CleanSpacesAndUpper(le.prop_addr_state);
	buyer_mail_full_addr  := ut.CleanSpacesAndUpper(le.buyer_mail_full_addr);
	buyer_mail_city       := ut.CleanSpacesAndUpper(le.buyer_mail_city);
	buyer_mail_state      := ut.CleanSpacesAndUpper(le.buyer_mail_state);
  prepAddress     := CHOOSE(C,prop_full_addr,buyer_mail_full_addr);
	prepcity        := CHOOSE(C,prop_addr_city,buyer_mail_city);
	prepState       := CHOOSE(C,prop_addr_state,buyer_mail_state);
	prepzip5        := CHOOSE(C,le.prop_addr_zip5,le.buyer_mail_zip5);
	prepzip4        := CHOOSE(C,le.prop_addr_zip4,le.buyer_mail_zip4);
	prepAddrType    := CHOOSE(C,'PF','BM');
	SELF.AddrType   := prepAddrType;		
	SELF 				  	:= le;
	SELF.Orig_Address := MAP(SELF.Name_Type = 'B1' and prepAddrType = 'BM' => prepAddress,
	                         SELF.Name_Type = 'B1' and prepAddrType = 'PF' => prepAddress,
													 SELF.Name_Type = 'B2' and prepAddrType = 'BM' => prepAddress,
													 SELF.Name_Type = 'B2' and prepAddrType = 'PF' => prepAddress,
													 SELF.Name_Type = 'S1' and prepAddrType = 'PF' => prepAddress,
													 SELF.Name_Type = 'S2' and prepAddrType = 'PF' => prepAddress,'');
	SELF.Orig_City    := MAP(SELF.Name_Type = 'B1' and prepAddrType = 'BM' => prepCity,
	                         SELF.Name_Type = 'B1' and prepAddrType = 'PF' => prepCity,
													 SELF.Name_Type = 'B2' and prepAddrType = 'BM' => prepCity,
													 SELF.Name_Type = 'B2' and prepAddrType = 'PF' => prepCity,
													 SELF.Name_Type = 'S1' and prepAddrType = 'PF' => prepCity,
													 SELF.Name_Type = 'S2' and prepAddrType = 'PF' => prepCity,'');
	SELF.Orig_State   := MAP(SELF.Name_Type = 'B1' and prepAddrType = 'BM' => prepState,
	                         SELF.Name_Type = 'B1' and prepAddrType = 'PF' => prepState,
													 SELF.Name_Type = 'B2' and prepAddrType = 'BM' => prepState,
													 SELF.Name_Type = 'B2' and prepAddrType = 'PF' => prepState,
													 SELF.Name_Type = 'S1' and prepAddrType = 'PF' => prepState,
													 SELF.Name_Type = 'S2' and prepAddrType = 'PF' => prepState,'');													 
	SELF.Orig_zip5    := MAP(SELF.Name_Type = 'B1' and prepAddrType = 'BM' => prepZip5,
	                         SELF.Name_Type = 'B1' and prepAddrType = 'PF' => prepZip5,
													 SELF.Name_Type = 'B2' and prepAddrType = 'BM' => prepZip5,
													 SELF.Name_Type = 'B2' and prepAddrType = 'PF' => prepZip5,
													 SELF.Name_Type = 'S1' and prepAddrType = 'PF' => prepZip5,
													 SELF.Name_Type = 'S2' and prepAddrType = 'PF' => prepZip5,'');													 
	SELF.Orig_zip4    := MAP(SELF.Name_Type = 'B1' and prepAddrType = 'BM' => prepZip4,
	                         SELF.Name_Type = 'B1' and prepAddrType = 'PF' => prepZip4,
													 SELF.Name_Type = 'B2' and prepAddrType = 'BM' => prepZip4,
													 SELF.Name_Type = 'B2' and prepAddrType = 'PF' => prepZip4,
													 SELF.Name_Type = 'S1' and prepAddrType = 'PF' => prepZip4,
													 SELF.Name_Type = 'S2' and prepAddrType = 'PF' => prepZip4,'');
											 												 
	SELF					:= [];
END;

Norm_Addr    := DEDUP(NORMALIZE(ds_Norm_name, 3, t_norm_addr_reo(LEFT, COUNTER)),ALL,RECORD);
GoodNormAddr := Norm_Addr(TRIM(Orig_Address + Orig_City + Orig_State + Orig_zip5 + Orig_zip4,ALL) <> '');
ds_final     := PROJECT(GoodNormAddr, Layout_BK.Norm_Addr_REO) : PERSIST('~thor_data400::in::BKForeclosure::Normalized_Reo_Test');

	RETURN ds_final;
END;