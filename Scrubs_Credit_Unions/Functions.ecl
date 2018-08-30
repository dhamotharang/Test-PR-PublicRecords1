IMPORT ut, Scrubs, Codes;

EXPORT Functions := MODULE


  //********************************************************************************
	//fn_bdid:  returns true if is a 1 to 9 digit numeric value, else returns false
	//********************************************************************************
	EXPORT fn_bdid(STRING s) := function    
	  RETURN IF(LENGTH(s) in [1,2,3,4,5,6,7,8,9,10] AND Stringlib.StringFilterOut(s, '0123456789') = '', 1, 0);
  END;

  //****************************************************************************
  //fn_numeric: 	returns true if only populated with numbers
  //****************************************************************************
  EXPORT fn_numeric(STRING nmbr, UNSIGNED1 size = 0) := FUNCTION
    RETURN IF(IF(size = 0, LENGTH(TRIM(nmbr, ALL)) > 0, LENGTH(TRIM(nmbr, ALL)) = size) AND
              Stringlib.StringFilterOut(nmbr, '0123456789') = '',1,0);
  END;

  //****************************************************************************
	//fn_numeric_or_blank:  returns true if numeric or blank
	//****************************************************************************
	EXPORT fn_numeric_or_blank(STRING s) := function    
	  RETURN IF(Stringlib.StringFilterOut(s, '0123456789') = '', 1, 0);
  END;

  //*******************************************************************************
  //fn_valid_past_Date: 	returns true or false based upon the incoming date.
  //													
  //Returns true if valid past date or blank
  //*******************************************************************************
  EXPORT fn_valid_past_Date(STRING sDate) := FUNCTION
    
    clean_date  := TRIM(sDate, ALL);
    isValidDate := IF(LENGTH(clean_date) = 8, Scrubs.fn_valid_pastDate(clean_date) > 0,
		                  IF(clean_date = '',TRUE,FALSE));
    
    RETURN IF(isValidDate, 1, 0);
  END;
	
	//****************************************************************************
	//fn_verify_st_code:  returns true or false based upon whether or not there is
  //                  a valid state abbreviation.
	//****************************************************************************
	EXPORT fn_verify_st_code(STRING code) := function    
	  RETURN IF(LENGTH(Codes.St2Name(code)) > 0, 1, 0);
  END;

  //*******************************************************************************
  //fn_verify_state_name: returns true or false based upon whether or not there is
  //                      a valid state name.
  //Returns true if valid state name
  //*******************************************************************************
  EXPORT fn_verify_state_name(STRING str) := FUNCTION
    
    st_names := ['ALABAMA','ALASKA','ARKANSAS','AMERICAN SAMOA','ARIZONA','CALIFORNIA','COLORADO',
		             'CONNECTICUT','DISTRICT OF COLUMBIA','DELAWARE','FLORIDA','GEORGIA','GUAM','HAWAII',
								 'IOWA','IDAHO','ILLINOIS','INDIANA','KANSAS','KENTUCKY','LOUISIANA','MASSACHUSETTS',
								 'MARYLAND','MAINE','MICHIGAN','MINNESOTA','MISSOURI','MISSISSIPPI','MONTANA',
								 'NORTH CAROLINA','NORTH DAKOTA','NEBRASKA','NEW HAMPSHIRE','NEW JERSEY','NEW MEXICO',
								 'NEVADA','NEW YORK','OHIO','OKLAHOMA','OREGON','PENNSYLVANIA','PUERTO RICO',
								 'RHODE ISLAND','SOUTH CAROLINA','SOUTH DAKOTA','TENNESSEE','TEXAS','UTAH','VIRGINIA',
								 'VIRGIN ISLANDS','VERMONT','WASHINGTON','WISCONSIN','WEST VIRGINIA','WYOMING',''];
    RETURN IF(ut.CleanSpacesAndUpper(str) IN st_names, 1, 0);
  END;


  //*******************************************************************************
  //fn_verify_country: returns true or false based upon whether or not there is
  //                      a valid country.
  //Returns true if valid country
  //*******************************************************************************
  EXPORT fn_verify_country(STRING str) := FUNCTION
    
    country_names := ['AFGHANISTAN','ALBANIA','ALAND ISLANDS','ALGERIA','AMERICAN SAMOA','ANDORRA',
											'ANGOLA','ANGUILLA','ANTARCTICA','ANTIGUA AND BARBUDA','ARGENTINA','ARMENIA',
											'ARUBA','AUSTRALIA','AUSTRIA','AZERBAIJAN','BAHAMAS','BAHRAIN','BANGLADESH',
											'BARBADOS','BELARUS','BELGIUM','BELIZE','BENIN','BERMUDA','BHUTAN','BOLIVIA',
											'BOSNIA AND HERZEGOWINA','BOTSWANA','BOUVET ISLAND','BRAZIL',
											'BRITISH INDIAN OCEAN TERRITORY','BRUNEI DARUSSALAM','BULGARIA','BURKINA FASO',
											'BURUNDI','CAMBODIA','CAMEROON','CANADA','CAPE VERDE','CAYMAN ISLANDS',
											'CENTRAL AFRICAN REPUBLIC','CHAD','CHILE','CHINA','CHRISTMAS ISLAND',
											'COCOS (KEELING) ISLANDS','COLOMBIA','COMOROS','CONGO','CONGO, THE DRC',
											'COOK ISLANDS','COSTA RICA','COTE DIVOIRE','CROATIA','CUBA','CYPRUS',
											'CZECH REPUBLIC','DENMARK','DJIBOUTI','DOMINICA','DOMINICAN REPUBLIC',
											'EAST TIMOR','ECUADOR','EGYPT','EL SALVADOR','ENGLAND','EQUATORIAL GUINEA',
											'ERITREA','ESTONIA','ETHIOPIA','FALKLAND ISLANDS (MALVINAS)','FAROE ISLANDS',
											'FIJI','FINLAND','FRANCE','FRANCE, METROPOLITAN','FRENCH GUIANA','FRENCH POLYNESIA',
											'FRENCH SOUTHERN TERRITORIES','GABON','GAMBIA','GEORGIA','GERMANY','GHANA','GIBRALTAR',
											'GREECE','GREENLAND','GRENADA','GUADELOUPE','GUAM','GUATEMALA','GUINEA','GUINEA-BISSAU',
											'GUYANA','HAITI','HEARD AND MC DONALD ISLANDS','HOLY SEE (VATICAN CITY STATE)','HONDURAS',
											'HONG KONG','HUNGARY','ICELAND','INDIA','INDONESIA','IRAN (ISLAMIC REPUBLIC OF)','IRAQ',
											'IRELAND','ISLE OF MAN','ISRAEL','ITALY','JAMAICA','JAPAN','JERSEY','JORDAN','KAZAKHSTAN',
											'KENYA','KIRIBATI','KOREA, D.P.R.O.','KOREA, REPUBLIC OF','KOREA, SOUTH','KUWAIT',
											'KYRGYZSTAN','LAOS','LATVIA','LEBANON','LESOTHO','LIBERIA','LIBYAN ARAB JAMAHIRIYA',
											'LIECHTENSTEIN','LITHUANIA','LUXEMBOURG','MACAU','MACEDONIA','MADAGASCAR','MALAWI',
											'MALAYSIA','MALDIVES','MALI','MALTA','MARSHALL ISLANDS','MARTINIQUE','MAURITANIA',
											'MAURITIUS','MAYOTTE','MEXICO','MICRONESIA, FEDERATED STATES OF','MOLDOVA, REPUBLIC OF',
											'MONACO','MONGOLIA','MONTENEGRO','MONTSERRAT','MOROCCO','MOZAMBIQUE','MYANMAR (Burma)',
											'NAMIBIA','NAURU','NEPAL','NETHERLANDS','NETHERLANDS ANTILLES','NEW CALEDONIA',
											'NEW ZEALAND','NICARAGUA','NIGER','NIGERIA','NIUE','NORFOLK ISLAND','NORTHERN MARIANA ISLANDS',
											'NORWAY','OMAN','PAKISTAN','PALAU','PALESTINIAN TERRITORY, OCCUPIED','PANAMA',
											'PAPUA NEW GUINEA','PARAGUAY','PERU','PHILIPPINES','PITCAIRN','POLAND','PORTUGAL',
											'PUERTO RICO','QATAR','REUNION','ROMANIA','ROMANIA','RUSSIAN FEDERATION','RWANDA',
											'SAINT-BARTHELEMY','SAINT-MARTIN (FRENCH PART)','SAINT KITTS AND NEVIS','SAINT LUCIA',
											'SAINT VINCENT AND THE GRENADINES','SAMOA','SAN MARINO','SAO TOME AND PRINCIPE',
											'SAUDI ARABIA','SENEGAL','SERBIA','SEYCHELLES','SIERRA LEONE','SINGAPORE',
											'SLOVENIA','SOLOMON ISLANDS','SOMALIA','SOUTH AFRICA','SOUTH SUDAN','SOUTH GEORGIA AND SOUTH S.S.',
											'SPAIN','SRI LANKA','ST. HELENA','ST. PIERRE AND MIQUELON','SUDAN','SURINAME',
											'SVALBARD AND JAN MAYEN ISLANDS','SWAZILAND','SWEDEN','SWITZERLAND','SYRIAN ARAB REPUBLIC',
											'TAIWAN, PROVINCE OF CHINA','TAJIKISTAN','TANZANIA, UNITED REPUBLIC OF','THAILAND',
											'TOGO','TOKELAU','TONGA','TRINIDAD AND TOBAGO','TUNISIA','TURKEY','TURKMENISTAN',
											'TURKS AND CAICOS ISLANDS','TUVALU','UGANDA','UKRAINE','UNITED ARAB EMIRATES',
											'UNITED KINGDOM','UNITED STATES','U.S. MINOR ISLANDS','URUGUAY','UZBEKISTAN',
											'VANUATU','VENEZUELA','VIET NAM','VIRGIN ISLANDS','WALLIS AND FUTUNA ISLANDS',
											'WESTERN SAHARA','YEMEN','ZAMBIA','ZIMBABWE',''];
	   RETURN IF(ut.CleanSpacesAndUpper(str) IN country_names, 1, 0);
  END;

  //****************************************************************************
	//fn_verify_phone:  returns true or false based upon whether its a valid
  //                  phone #
	//****************************************************************************
	EXPORT fn_verify_phone(STRING phone) := function    
   clean_phone := TRIM(phone, ALL);
   RETURN IF(ut.CleanPhone(clean_phone) != '', 1, 0);
  END;





END;