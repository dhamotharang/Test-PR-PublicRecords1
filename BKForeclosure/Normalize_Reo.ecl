IMPORT BKForeclosure,ut, STD;
#option('multiplePersistInstances',FALSE);

EXPORT Normalize_Reo(DATASET(RECORDOF(Layout_BK.Base_Reo_ext)) ds_reo) := Function	

//-----------------------------------------------------------------
//NORMALIZE Names
//-----------------------------------------------------------------
/*
  'B1'  = 1st Buyer Name
	'B2'  = 2nd Buyer Name
  'S1'  = 1st Seller Name
	'S2'  = 2nd Seller Name
*/

//-----------------------------------------------------------------
//NORMALIZE Address
//-----------------------------------------------------------------
/*
  'PF'   = Property Address
	'BM'	 = Buyer's Mailing Address
*/

Co_Pattern  := '( AND | ASSOCIATES|ASSOCIATION| PC$| OF | PLLC$| PLC$| PA$| FIRM$| LP$| INC| LLC$| LLC |L L C| LC$| LLP$|MORTGAGE|INSURANCE|REGISTRATION| LAW | LAW$|' +
               'SOLUTION|&| AGENCY|COMPANY| RE$| BANKS|BANK| BANKER| GROUP| PROPERTIES| REALTY|INVESTMENT|DEVELOPMENT|OFFICE|INVESTORS|TRULIANT FCU|' +
							 ' MTG$| MTG | CORP$| CORPS$| FUND | CORPORATION| CO$| CO NA$| LENDING| TRUST| HOME| ASSISTANCE| SERVICE|^THE | BBQ|^HUD$|FDIC$|' +
							 'FINANCIAL|NATIONAL|PARTNERS| LTD$|LTD |FAMILY|REAL ESTATE|NETWORK|UNITED|CLUB|^ASSET |ASSET|MANAGEMENT| AT | CREDIT| FINANCE|EVERBANK|'+
							 'FANNIE MAE| UNION| AUTHORITY|COUNTY|^FNMA|CONDOMINIUM|AMERICA|BUSINESS|COMMUNITIES|SCHOOL| LOAN|CERTIFICATE|FEDERAL| FUND| CHURCH|'+
							 ' BRANCH| FCU$| PROFIT|PRIVATE|COMMERCIAL|ANNUNITY|FIRST| CNTY$)';
invalid_Pattern := '(NOT PROVIDED|NOT GIVEN|NO PROVIDED| NONE|(NOT P\\[ROVIDED)|(NOT \\[PROVIDED)|(NOT PROVIDED \\|))';
DBApattern	:= '^(.*)( D/B/A |DBA | C/O |C/0 |ATTN:|ATT:|ATTENTION:|ATN:| A/K/A | T/A | F/K/A )(.*)';

//Get name w/o DBA/AKA name from name field
 varstring GetName(string dname)	:= FUNCTION
				string uppername	:= TRIM(STD.Str.ToUpperCase(dname),LEFT,RIGHT);
				string temp_name	:= IF(REGEXFIND('^DBA ',uppername), REGEXFIND(DBApattern,uppername,3), REGEXFIND(DBApattern,uppername,1));
				return STD.Str.CleanSpaces(trim(temp_name,left,right));
END;

// Normalized Name records
Layout_BK.CleanFields_REO t_norm_reo (Layout_BK.Base_Reo_ext  le, INTEGER C) := TRANSFORM
	trim_buyer_fname1      := ut.CleanSpacesAndUpper(le.buyer1_fname);
	trim_buyer_lname1      := ut.CleanSpacesAndUpper(le.buyer1_lname);
	trim_buyer_fname2      := ut.CleanSpacesAndUpper(le.buyer2_fname);
	trim_buyer_lname2      := ut.CleanSpacesAndUpper(le.buyer2_lname);
	trim_seller_fname1     := ut.CleanSpacesAndUpper(le.seller1_fname);
	trim_seller_lname1     := ut.CleanSpacesAndUpper(le.seller1_lname);
	trim_seller_fname2     := ut.CleanSpacesAndUpper(le.seller2_fname);
	trim_seller_lname2     := ut.CleanSpacesAndUpper(le.seller2_lname);	

	buyer_fname1	    := IF(NOT REGEXFIND(invalid_pattern, trim_buyer_fname1)
													AND trim_buyer_fname1 != '',REGEXREPLACE('=',trim_buyer_fname1,' '),'');
	buyer_lname1	    := IF(NOT REGEXFIND(invalid_pattern, trim_buyer_lname1) 
													AND trim_buyer_lname1 != '',REGEXREPLACE('=',trim_buyer_lname1,' '),'');
	buyer_fname2	    := IF(NOT REGEXFIND(invalid_pattern, trim_buyer_fname2) 
													AND trim_buyer_fname2 != '',REGEXREPLACE('=',trim_buyer_fname2,' '),'');
	buyer_lname2	    := IF(NOT REGEXFIND(invalid_pattern, trim_buyer_lname2) 
													AND trim_buyer_lname2 != '',REGEXREPLACE('=',trim_buyer_lname2,' '),'');  
	seller_fname1	    := IF(NOT REGEXFIND(invalid_pattern, trim_seller_fname1)
													AND trim_seller_fname1 != '',REGEXREPLACE('=',trim_seller_fname1,' '),'');
	seller_lname1	    := IF(NOT REGEXFIND(invalid_pattern, trim_seller_lname1) 
													AND trim_seller_lname1 != '',REGEXREPLACE('=',trim_seller_lname1,' '),'');
	seller_fname2	    := IF(NOT REGEXFIND(invalid_pattern, trim_seller_fname2) 
													AND trim_seller_fname2 != '',REGEXREPLACE('=',trim_seller_fname2,' '),'');
	seller_lname2	    := IF(NOT REGEXFIND(invalid_pattern, trim_seller_lname2) 
													AND trim_seller_lname2 != '',REGEXREPLACE('=',trim_seller_lname2,' '),'');  
																																		
	SELF.Name_First   := CHOOSE(C,buyer_fname1,buyer_fname2,seller_fname1,seller_fname2);
	SELF.Name_Last		:= CHOOSE(C,buyer_lname1,buyer_lname2,seller_lname1,seller_lname2);
	SELF.name_type    := CHOOSE(C,'B1','B2','S1','S2');
	TempNameFull			:= TRIM(SELF.NAME_FIRST,LEFT,RIGHT)+' '+TRIM(SELF.NAME_LAST,LEFT,RIGHT);
	ClnNameFull				:= IF(REGEXFIND(DBApattern,TempNameFull), GetName(TempNameFull), TempNameFull);
	SELF.NAME_FULL    := STD.Str.CleanSpaces(REGEXREPLACE('^(/|-+|\\*|\\.|,|"|&)',ClnNameFull,''));
//	SELF.NAME_FULL    := GetName(TRIM(SELF.NAME_FIRST,LEFT,RIGHT)+' '+TRIM(SELF.NAME_LAST,LEFT,RIGHT));
	prop_full_addr        := ut.CleanSpacesAndUpper(le.prop_full_addr);
	prop_addr_city        := ut.CleanSpacesAndUpper(le.prop_addr_city);
	prop_addr_state       := ut.CleanSpacesAndUpper(le.prop_addr_state);
	buyer_mail_full_addr  := ut.CleanSpacesAndUpper(le.buyer_mail_full_addr);
	buyer_mail_city       := ut.CleanSpacesAndUpper(le.buyer_mail_city);
	buyer_mail_state      := ut.CleanSpacesAndUpper(le.buyer_mail_state);
	buyer_mail_zip4      	:= REGEXREPLACE('NULL',le.buyer_mail_zip4,'',NOCASE);
  prepAddress     := CHOOSE(C,buyer_mail_full_addr,prop_full_addr);
	prepcity        := CHOOSE(C,buyer_mail_city,prop_addr_city);
	prepState       := CHOOSE(C,buyer_mail_state,prop_addr_state);
	prepzip5        := CHOOSE(C,le.buyer_mail_zip5,le.prop_addr_zip5);
	prepzip4        := CHOOSE(C,buyer_mail_zip4,le.prop_addr_zip4);
	prepAddrType    := CHOOSE(C,'BM','PF');
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
	SELF 					:= le;
	SELF					:= [];
END;

	Norm_Name 	  := DEDUP(NORMALIZE(ds_reo,4,t_norm_reo(LEFT,COUNTER)),ALL,RECORD);
  GoodNormName  := Norm_Name(TRIM(Name_Last + Name_First,ALL) <> '');	
  ds_final		  := PROJECT(GoodNormName,TRANSFORM(Layout_BK.CleanFields_REO,SELF := LEFT;SELF:=[])): PERSIST('~thor_data400::in::BKForeclosure::Normalized_Reo');

	RETURN ds_final;
END;