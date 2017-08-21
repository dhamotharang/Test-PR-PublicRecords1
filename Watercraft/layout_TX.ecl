export layout_TX := record
  //string2   state_origin;
  //string8   process_date;
  string3   STATEABREV;
  string22  REG_NUM;
  string23  HULL_ID;
  string15  PROP;
  string15  VEH_TYPE;
  string10  FUEL;
  string10  HULL;
  string15  USE_1;
  string25  MAKE;
  string5   TOTAL_INCH;
  string8   REG_DATE;
  string4   YEAR;
  string100 NAME;
  string50  FIRST_NAME;
  string15  MID;
  string50  LAST_NAME;
  string75  ADDRESS_1;
  string30  CITY;
  string2   STATE;
  string10  ZIP;
  string50  COUNTY;
  string5   FIPS;
  string7   BATCH_RECORD_ID;
  string8   BATCH_OUT_DATE;
  string10  RECORD_TYPE;
  string8   ORIGINAL_CERTIFICATE_DATE;
  string8   EXPIRATION_DATE;
  string1   IS_DECAL_NOT_GENERATED;
  string30  DECAL_NUMBER;
  string8   TITLE_ISSUE_DATE;
  string20  TITLE_NUMBER;
  string1   IS_TITLE_REPLACED;
  string1   IS_TITLE_BONDED;
  string20  BONDED_TITLE_AUTHORIZATION_NUM;
  string120 LAST_TRANSACTION;
  string30  MODEL;
  string4   YEAR_BUILT;
  string80  HULL_MATERIAL_OTHER;
  string35  HULL_COLOR_PRIMARY;
  string80  HULL_COLOR_PRIMARY_OTHER;
  string35  HULL_COLOR_SECONDARY;
  string80  HULL_COLOR_SECONDARY_OTHER;
  string80  PROPULSION_OTHER;
  string80  FUEL_OTHER;
  string35  BOAT_CLASS;
  string80  BOAT_TYPE_OTHER;
  string35  ADMINISTRATIVE_NOTIFICATION;
  string10  MTR_1_HORSEPOWER;
  string30  MTR_1_OUTDRIVE;
  string30  MTR_1_SERIAL;
  string10  MTR_2_HORSEPOWER;
  string30  MTR_2_OUTDRIVE;
  string30  MTR_2_SERIAL;
  string8   DATE_OF_SALE;
  string10  SALE_PRICE;
  string10  TRADE_IN_AMOUNT;
  string6   TRADE_IN_TX_NUMBER;
  string4   TRADE_IN_MODEL_YEAR;
  string20  TRADE_IN_MAKE;
  string4   TRADE_IN_LENGTH;
  string4   TRADE_IN_HORSEPOWER;
  string20  TRADE_IN_HULL_ID_NUMBER;
  string1   IS_ONLY_SALE_TAX_PAID;
  string1   IS_FROM_OUT_OF_STATE;
  string30  STATE_BOAT_IS_FROM;
  string10  TAX_AMOUNT_PAID_OUT_OF_STATE;
  string1   IS_USCG_DOCUMENTED;
  string20  USCG_DOCUMENT_NUMBER;
  string6   USCG_TX_MARINE_LICENSEE_NUMBER;
  string40  USCG_BOAT_NAME;
  string30  USCG_PORT_CITY;
  string2   USCG_PORT_STATE;
  string1   IS_USCG_TAX_NOT_PAID;
  string10  USCG_TAX_AMOUNT;
  string1   IS_ANTIQUE_BOAT;
  string1   IS_GAME_WARDEN_INSPECTED;
  string20  PRIMARY_OWNER_SUFFIX;
  string50  PRIMARY_OWNER_COMPANY;
  string1   PRIMARY_OWNER_IS_US_CITIZEN;
  string1   PRIMARY_OWNER_IS_CURRENT_OWNER;
  string1   PRIMARY_OWNER_IS_RIGHT_OF_SURVIVOR;
  string8   PRIMARY_OWNER_DATE_OWNED_BOAT_FROM;
  string8   PRIMARY_OWNER_DATE_OWNED_BOAT_TO;
  string40  PRIMARY_OWNER_PROVINCE;
  string20  PRIMARY_OWNER_DELIVERY_CODE;
  string40  PRIMARY_OWNER_COUNTRY_NAME;
  string35  PRIMARY_OWNER_ADDRESS_TYPE;
  string1   PRIMARY_OWNER_IS_CURRENT_ADDRESS;
  string1   PRIMARY_OWNER_IS_BAD_ADDRESS;
  string1   PRIMARY_OWNER_IS_DOMESTIC_ADDRESS;
  string20  PRIMARY_OWNER_PHONE_PRIMARY;
  string20  PRIMARY_OWNER_PHONE_OTHER;
  string20  PRIMARY_OWNER_PHONE_FAX;
  string8   PRIMARY_LIEN_DATE;
  string8   PRIMARY_LIEN_RELEASE_DATE;
  string35  PRIMARY_LIEN_LIENHOLDER_TYPE;
  string50  PRIMARY_LIEN_LAST;
  string20  PRIMARY_LIEN_FIRST;
  string20  PRIMARY_LIEN_MIDDLE;
  string20  PRIMARY_LIEN_SUFFIX;
  string60  PRIMARY_LIEN_BUSINESS;
  string50  PRIMARY_LIEN_ADDRESS1;
  string50  PRIMARY_LIEN_ADDRESS2;
  string40  PRIMARY_LIEN_CITY;
  string2   PRIMARY_LIEN_STATE;
  string10  PRIMARY_LIEN_ZIP;
  string6   PRIMARY_LIEN_ZIP4;
  string2   lf;
  //string73  pname;
  //string100 cname;
  //string182 clean_address;
end;