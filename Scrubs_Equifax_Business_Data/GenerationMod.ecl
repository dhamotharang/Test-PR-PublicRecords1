﻿// Machine-readable versions of the spec file and subsets thereof
EXPORT GenerationMod := MODULE
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_Equifax_Business_Data\n'
    + 'FILENAME:Equifax_Business_Data\n'
    + 'NAMESCOPE:Input\n'
    + '//-------------------------\n'
    + '//FIELDTYPE DEFINITIONS\n'
    + '//-------------------------\n'
    + 'FIELDTYPE:invalid_name:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_invalid_name > 0)\n'
    + 'FIELDTYPE:invalid_legal_name:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_invalid_legal_name > 0)\n'
    + 'FIELDTYPE:invalid_mandatory:LENGTHS(1..)\n'
    + 'FIELDTYPE:invalid_zero_integer:ENUM(0|)\n'
    + 'FIELDTYPE:invalid_record_type:ENUM(C|H)\n'
    + 'FIELDTYPE:invalid_numeric:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_numeric > 0)\n'
    + 'FIELDTYPE:invalid_numeric_or_blank:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_numeric_or_blank > 0)\n'
    + 'FIELDTYPE:invalid_percentage:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_range_numeric>0,0,100)\n'
    + 'FIELDTYPE:invalid_direction:ENUM(E|N|S|W|NE|NW|SE|SW|)\n'
    + 'FIELDTYPE:invalid_cart:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_alphanum>0,4)\n'
    + 'FIELDTYPE:invalid_cr_sort_sz:ENUM(A|B|C|D|)\n'
    + 'FIELDTYPE:invalid_lot:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_numeric>0,4)\n'
    + 'FIELDTYPE:invalid_lot_order:ENUM(A|D|)\n'
    + 'FIELDTYPE:invalid_dbpc:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_numeric>0,2)\n'
    + 'FIELDTYPE:invalid_chk_digit:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_numeric>0,1)\n'
    + 'FIELDTYPE:invalid_rec_type:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_addr_rec_type>0)\n'
    + 'FIELDTYPE:invalid_fips_state:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_numeric>0,2)\n'
    + 'FIELDTYPE:invalid_fips_county:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_numeric>0,3)\n'
    + 'FIELDTYPE:invalid_geo:ALLOW(-.0123456789)\n'
    + 'FIELDTYPE:invalid_msa:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_numeric>0,4)\n'
    + 'FIELDTYPE:invalid_geo_blk:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_numeric>0,7)\n'
    + 'FIELDTYPE:invalid_geo_match:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_numeric>0,1)\n'
    + 'FIELDTYPE:invalid_err_stat:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_alphanum>0,4)\n'
    + 'FIELDTYPE:invalid_raw_aid:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_range_numeric>0,10000000000,999999999999)\n'
    + 'FIELDTYPE:invalid_ace_aid:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_numeric>0,12)\n'
    + 'FIELDTYPE:invalid_st:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_verify_state>0,EFX_CTRYNAME)\n'
    + 'FIELDTYPE:invalid_zip5:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_numeric>0,5)\n'
    + 'FIELDTYPE:invalid_zip4:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_verify_zip4>0)\n'
    + 'FIELDTYPE:invalid_phone:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_verify_optional_phone>0)\n'
    + 'FIELDTYPE:invalid_rcid:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_rcid > 0)\n'
    + 'FIELDTYPE:invalid_sic:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_sic > 0)\n'
    + 'FIELDTYPE:invalid_naics:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_naics > 0)\n'
    + 'FIELDTYPE:invalid_url:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_url > 0)\n'
    + 'FIELDTYPE:invalid_address_type_code:ENUM(P|M)\n'
    + 'FIELDTYPE:invalid_norm_type:ENUM(D|L)\n'
    + 'FIELDTYPE:invalid_email:ALLOW( 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ\\\'-!#$%&*,./:;?@_{}~+=()^`><)\n'
    + 'FIELDTYPE:invalid_yes_blank:ENUM(Y| )\n'
    + 'FIELDTYPE:invalid_business_size:ENUM(L|S|X)\n'
    + 'FIELDTYPE:invalid_cert_or_class:ENUM(CERTIFIED|CLASSIFIED|CLASSIFICATION|CERTIFICATION|SELF-CLASSIFIED/NON VERIFIED|OTHER CLASSIFICATIONS|UNKNOWN| )\n'
    + 'FIELDTYPE:invalid_current_future_date:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_current_future_date > 0)\n'
    + 'FIELDTYPE:invalid_current_past_date:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_current_past_date > 0)\n'
    + 'FIELDTYPE:invalid_future_date:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_future_date > 0)\n'
    + 'FIELDTYPE:invalid_general_date:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_valid_generalDate > 0)\n'
    + 'FIELDTYPE:invalid_past_date:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_valid_past_Date > 0)\n'
    + 'FIELDTYPE:invalid_year_established:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_valid_year_established > 0)\n'
    + 'FIELDTYPE:invalid_date_created:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_valid_date_created > 0)\n'
    + 'FIELDTYPE:invalid_date_seen:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_current_past_date > 0)\n'
    + 'FIELDTYPE:invalid_reformated_date:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_valid_reformatedDate > 0)\n'
    + '\n'
    + 'FIELDTYPE:invalid_vendor_reported_date:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_current_past_date > 0)\n'
    + 'FIELDTYPE:invalid_process_date:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_current_past_date > 0)\n'
    + '\n'
    + 'FIELDTYPE:invalid_busstatcd:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_verify_busstatcd>0)\n'
    + 'FIELDTYPE:invalid_cmsa:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_verify_cmsa>0)\n'
    + 'FIELDTYPE:invalid_corpamountcd:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_verify_corpamountcd>0)\n'
    + 'FIELDTYPE:invalid_corpamountprec:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_verify_corpamountprec>0)\n'
    + 'FIELDTYPE:invalid_corpamounttp:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_verify_corpamounttp>0)\n'
    + 'FIELDTYPE:invalid_corpempcd:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_verify_corpempcd>0)\n'
    + '\n'
    + 'FIELDTYPE:invalid_ctryisocd:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_verify_ctryisocd>0)\n'
    + 'FIELDTYPE:invalid_ctrynum:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_verify_ctrynum>0)\n'
    + 'FIELDTYPE:invalid_ctrytelcd:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_verify_ctrytelcd>0)\n'
    + 'FIELDTYPE:invalid_geoprec:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_verify_geoprec>0)\n'
    + 'FIELDTYPE:invalid_merctype:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_verify_merctype>0)\n'
    + 'FIELDTYPE:invalid_mrkt_telescore:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_verify_mrkt_telescore>0)\n'
    + 'FIELDTYPE:invalid_mrkt_totalind:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_verify_mrkt_totalind>0)\n'
    + 'FIELDTYPE:invalid_mrkt_totalscore:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_verify_mrkt_totalscore>0)\n'
    + 'FIELDTYPE:invalid_public:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_verify_public>0)\n'
    + 'FIELDTYPE:invalid_statec:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_verify_statec>0)\n'
    + 'FIELDTYPE:invalid_stkexc:CUSTOM(Scrubs_Equifax_Business_Data.Functions.fn_verify_stkexc>0)\n'
    + '\n'
    + '\n'
    + '//--------------------------------------------------------------- \n'
    + '//FIELDS TO SCRUB -- Commented out fields are not being scrubbed\n'
    + '//---------------------------------------------------------------\n'
    + '//These could change once we get the fixed vendor data !!!!!!!!!!\n'
    + '//Check logic on all date validations\n'
    + 'FIELD:dt_first_seen:TYPE(STRING8):LIKE(invalid_reformated_date):0,0\n'
    + 'FIELD:dt_last_seen:TYPE(STRING8):LIKE(invalid_reformated_date):0,0\n'
    + 'FIELD:dt_vendor_first_reported:TYPE(STRING8):LIKE(invalid_reformated_date):0,0\n'
    + 'FIELD:dt_vendor_last_reported:TYPE(STRING8):LIKE(invalid_reformated_date):0,0\n'
    + '\n'
    + 'FIELD:process_date:TYPE(STRING8):LIKE(invalid_reformated_date):0,0\n'
    + 'FIELD:record_type:TYPE(STRING1):LIKE(invalid_record_type):0,0\n'
    + '\n'
    + 'FIELD:normcompany_type:TYPE(STRING1):LIKE(invalid_norm_type):0,0\n'
    + 'FIELD:normaddress_type:TYPE(STRING1):LIKE(invalid_address_type_code):0,0\n'
    + '\n'
    + 'FIELD:EFX_BUSSTATCD:TYPE(STRING10):LIKE(invalid_busstatcd):0,0\n'
    + 'FIELD:EFX_CMSA:TYPE(STRING1):LIKE(invalid_cmsa):0,0\n'
    + 'FIELD:EFX_CORPAMOUNTCD:TYPE(STRING1):LIKE(invalid_corpamountcd):0,0\n'
    + 'FIELD:EFX_CORPAMOUNTPREC:TYPE(STRING50):LIKE(invalid_corpamountprec):0,0\n'
    + 'FIELD:EFX_CORPAMOUNTTP:TYPE(STRING50):LIKE(invalid_corpamounttp):0,0\n'
    + 'FIELD:EFX_CORPEMPCD:TYPE(STRING1):LIKE(invalid_corpempcd):0,0\n'
    + 'FIELD:EFX_WEB:0,0\n'
    + '\n'
    + 'FIELD:EFX_CTRYISOCD:TYPE(STRING3):LIKE(invalid_ctryisocd):0,0\n'
    + 'FIELD:EFX_CTRYNUM:TYPE(STRING10):LIKE(invalid_ctrynum):0,0\n'
    + 'FIELD:EFX_CTRYTELCD:TYPE(STRING10):LIKE(invalid_ctrytelcd):0,0\n'
    + 'FIELD:EFX_GEOPREC:TYPE(STRING3):LIKE(invalid_geoprec):0,0\n'
    + 'FIELD:EFX_MERCTYPE:TYPE(STRING1):LIKE(invalid_merctype):0,0\n'
    + 'FIELD:EFX_MRKT_TELESCORE:TYPE(STRING10):LIKE(invalid_mrkt_telescore):0,0\n'
    + 'FIELD:EFX_MRKT_TOTALIND:TYPE(STRING2):LIKE(invalid_mrkt_totalind):0,0\n'
    + 'FIELD:EFX_MRKT_TOTALSCORE:TYPE(STRING0):LIKE(invalid_mrkt_totalscore):0,0\n'
    + 'FIELD:EFX_PUBLIC:TYPE(STRING1):LIKE(invalid_public):0,0\n'
    + 'FIELD:EFX_STATEC:TYPE(STRING2):LIKE(invalid_statec):0,0\n'
    + 'FIELD:EFX_STKEXC:TYPE(STRING1):LIKE(invalid_stkexc):0,0\n'
    + '\n'
    + 'FIELD:EFX_PRIMSIC:TYPE(STRING4):LIKE(invalid_sic):0,0\n'
    + 'FIELD:EFX_SECSIC1:TYPE(STRING4):LIKE(invalid_sic):0,0\n'
    + 'FIELD:EFX_SECSIC2:TYPE(STRING4):LIKE(invalid_sic):0,0\n'
    + 'FIELD:EFX_SECSIC3:TYPE(STRING4):LIKE(invalid_sic):0,0\n'
    + 'FIELD:EFX_SECSIC4:TYPE(STRING4):LIKE(invalid_sic):0,0\n'
    + 'FIELD:EFX_STATE:TYPE(STRING2):LIKE(invalid_st):0,0\n'
    + '\n'
    + 'FIELD:EFX_ID:TYPE(STRING10):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:EFX_NAME:TYPE(STRING75):LIKE(invalid_name):0,0\n'
    + 'FIELD:EFX_LEGAL_NAME:TYPE(STRING75):LIKE(invalid_legal_name):0,0\n'
    + 'FIELD:EFX_ADDRESS:TYPE(STRING75):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:EFX_CITY:TYPE(STRING75):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:EFX_REGION:0,0\n'
    + 'FIELD:EFX_CTRYNAME:TYPE(STRING100):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:EFX_COUNTYNM:0,0\n'
    + 'FIELD:EFX_CMSADESC:0,0\n'
    + 'FIELD:EFX_SOHO:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_BIZ:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_RES:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_CMRA:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_SECADR:0,0\n'
    + 'FIELD:EFX_SECCTY:0,0\n'
    + 'FIELD:EFX_SECSTAT:TYPE(STRING2):LIKE(invalid_st):0,0\n'
    + 'FIELD:EFX_STATEC2:TYPE(STRING2):LIKE(invalid_statec):0,0\n'
    + 'FIELD:EFX_SECGEOPREC:TYPE(STRING3):LIKE(invalid_geoprec):0,0\n'
    + 'FIELD:EFX_SECREGION:0,0\n'
    + 'FIELD:EFX_SECCTRYISOCD:TYPE(STRING3):LIKE(invalid_ctryisocd):0,0\n'
    + 'FIELD:EFX_SECCTRYNUM:TYPE(STRING10):LIKE(invalid_ctrynum):0,0\n'
    + 'FIELD:EFX_SECCTRYNAME:0,0\n'
    + 'FIELD:EFX_PHONE:TYPE(STRING18):LIKE(invalid_phone):0,0\n'
    + 'FIELD:EFX_FAXPHONE:TYPE(STRING18):LIKE(invalid_phone):0,0\n'
    + 'FIELD:EFX_BUSSTAT:0,0\n'
    + 'FIELD:EFX_YREST:TYPE(STRING18):LIKE(invalid_year_established):0,0\n'
    + 'FIELD:EFX_CORPEMPCNT:TYPE(STRING10):LIKE(invalid_numeric_or_blank):0,0\n'
    + 'FIELD:EFX_LOCEMPCNT:TYPE(STRING10):LIKE(invalid_numeric_or_blank):0,0\n'
    + 'FIELD:EFX_LOCEMPCD:TYPE(STRING1):LIKE(invalid_corpempcd):0,0\n'
    + 'FIELD:EFX_CORPAMOUNT:TYPE(STRING10):LIKE(invalid_numeric_or_blank):0,0\n'
    + 'FIELD:EFX_LOCAMOUNT:TYPE(STRING10):LIKE(invalid_numeric_or_blank):0,0\n'
    + 'FIELD:EFX_LOCAMOUNTCD:TYPE(STRING1):LIKE(invalid_corpamountcd):0,0\n'
    + 'FIELD:EFX_LOCAMOUNTTP:TYPE(STRING50):LIKE(invalid_corpamounttp):0,0\n'
    + 'FIELD:EFX_LOCAMOUNTPREC:TYPE(STRING50):LIKE(invalid_corpamountprec):0,0\n'
    + 'FIELD:EFX_TCKSYM:0,0\n'
    + 'FIELD:EFX_PRIMSICDESC:0,0\n'
    + 'FIELD:EFX_SECSICDESC1:0,0\n'
    + 'FIELD:EFX_SECSICDESC2:0,0\n'
    + 'FIELD:EFX_SECSICDESC3:0,0\n'
    + 'FIELD:EFX_SECSICDESC4:0,0\n'
    + 'FIELD:EFX_PRIMNAICSCODE:TYPE(STRING6):LIKE(invalid_naics):0,0\n'
    + 'FIELD:EFX_SECNAICS1:TYPE(STRING6):LIKE(invalid_naics):0,0\n'
    + 'FIELD:EFX_SECNAICS2:TYPE(STRING6):LIKE(invalid_naics):0,0\n'
    + 'FIELD:EFX_SECNAICS3:TYPE(STRING6):LIKE(invalid_naics):0,0\n'
    + 'FIELD:EFX_SECNAICS4:TYPE(STRING6):LIKE(invalid_naics):0,0\n'
    + 'FIELD:EFX_PRIMNAICSDESC:0,0\n'
    + 'FIELD:EFX_SECNAICSDESC1:0,0\n'
    + 'FIELD:EFX_SECNAICSDESC2:0,0\n'
    + 'FIELD:EFX_SECNAICSDESC3:0,0\n'
    + 'FIELD:EFX_SECNAICSDESC4:0,0\n'
    + 'FIELD:EFX_DEAD:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_DEADDT:TYPE(STRING8):LIKE(invalid_past_date):0,0\n'
    + 'FIELD:EFX_MRKT_TELEVER:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_MRKT_VACANT:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_MRKT_SEASONAL:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_MBE:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_WBE:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_MWBE:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_SDB:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_HUBZONE:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_DBE:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_VET:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_DVET:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_8a:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_8aEXPDT:TYPE(STRING8):LIKE(invalid_general_date):0,0\n'
    + 'FIELD:EFX_DIS:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_SBE:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_BUSSIZE:TYPE(STRING1):LIKE(invalid_business_size):0,0\n'
    + 'FIELD:EFX_LBE:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_GOV:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_FGOV:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_NONPROFIT:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_HBCU:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_GAYLESBIAN:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_WSBE:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_VSBE:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_DVSBE:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_MWBESTATUS:TYPE(STRING30):LIKE(invalid_cert_or_class):0,0\n'
    + 'FIELD:EFX_NMSDC:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_WBENC:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_CA_PUC:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_TX_HUB:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_TX_HUBCERTNUM:0,0\n'
    + 'FIELD:EFX_GSAX:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_CALTRANS:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_EDU:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_MI:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:EFX_ANC:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:AT_CERT1:0,0\n'
    + 'FIELD:AT_CERT2:0,0\n'
    + 'FIELD:AT_CERT3:0,0\n'
    + 'FIELD:AT_CERT4:0,0\n'
    + 'FIELD:AT_CERT5:0,0\n'
    + 'FIELD:AT_CERT6:0,0\n'
    + 'FIELD:AT_CERT7:0,0\n'
    + 'FIELD:AT_CERT8:0,0\n'
    + 'FIELD:AT_CERT9:0,0\n'
    + 'FIELD:AT_CERT10:0,0\n'
    + 'FIELD:AT_CERTDESC1:0,0\n'
    + 'FIELD:AT_CERTDESC2:0,0\n'
    + 'FIELD:AT_CERTDESC3:0,0\n'
    + 'FIELD:AT_CERTDESC4:0,0\n'
    + 'FIELD:AT_CERTDESC5:0,0\n'
    + 'FIELD:AT_CERTDESC6:0,0\n'
    + 'FIELD:AT_CERTDESC7:0,0\n'
    + 'FIELD:AT_CERTDESC8:0,0\n'
    + 'FIELD:AT_CERTDESC9:0,0\n'
    + 'FIELD:AT_CERTDESC10:0,0\n'
    + 'FIELD:AT_CERTSRC1:0,0\n'
    + 'FIELD:AT_CERTSRC2:0,0\n'
    + 'FIELD:AT_CERTSRC3:0,0\n'
    + 'FIELD:AT_CERTSRC4:0,0\n'
    + 'FIELD:AT_CERTSRC5:0,0\n'
    + 'FIELD:AT_CERTSRC6:0,0\n'
    + 'FIELD:AT_CERTSRC7:0,0\n'
    + 'FIELD:AT_CERTSRC8:0,0\n'
    + 'FIELD:AT_CERTSRC9:0,0\n'
    + 'FIELD:AT_CERTSRC10:0,0\n'
    + 'FIELD:AT_CERTLEV1:TYPE(STRING50):LIKE(invalid_cert_or_class):0,0\n'
    + 'FIELD:AT_CERTLEV2:TYPE(STRING50):LIKE(invalid_cert_or_class):0,0\n'
    + 'FIELD:AT_CERTLEV3:TYPE(STRING50):LIKE(invalid_cert_or_class):0,0\n'
    + 'FIELD:AT_CERTLEV4:TYPE(STRING50):LIKE(invalid_cert_or_class):0,0\n'
    + 'FIELD:AT_CERTLEV5:TYPE(STRING50):LIKE(invalid_cert_or_class):0,0\n'
    + 'FIELD:AT_CERTLEV6:TYPE(STRING50):LIKE(invalid_cert_or_class):0,0\n'
    + 'FIELD:AT_CERTLEV7:TYPE(STRING50):LIKE(invalid_cert_or_class):0,0\n'
    + 'FIELD:AT_CERTLEV8:TYPE(STRING50):LIKE(invalid_cert_or_class):0,0\n'
    + 'FIELD:AT_CERTLEV9:TYPE(STRING50):LIKE(invalid_cert_or_class):0,0\n'
    + 'FIELD:AT_CERTLEV10:TYPE(STRING50):LIKE(invalid_cert_or_class):0,0\n'
    + 'FIELD:AT_CERTNUM1:0,0\n'
    + 'FIELD:AT_CERTNUM2:0,0\n'
    + 'FIELD:AT_CERTNUM3:0,0\n'
    + 'FIELD:AT_CERTNUM4:0,0\n'
    + 'FIELD:AT_CERTNUM5:0,0\n'
    + 'FIELD:AT_CERTNUM6:0,0\n'
    + 'FIELD:AT_CERTNUM7:0,0\n'
    + 'FIELD:AT_CERTNUM8:0,0\n'
    + 'FIELD:AT_CERTNUM9:0,0\n'
    + 'FIELD:AT_CERTNUM10:0,0\n'
    + 'FIELD:AT_CERTEXP1:TYPE(STRING8):LIKE(invalid_general_date):0,0\n'
    + 'FIELD:AT_CERTEXP2:TYPE(STRING8):LIKE(invalid_general_date):0,0\n'
    + 'FIELD:AT_CERTEXP3:TYPE(STRING8):LIKE(invalid_general_date):0,0\n'
    + 'FIELD:AT_CERTEXP4:TYPE(STRING8):LIKE(invalid_general_date):0,0\n'
    + 'FIELD:AT_CERTEXP5:TYPE(STRING8):LIKE(invalid_general_date):0,0\n'
    + 'FIELD:AT_CERTEXP6:TYPE(STRING8):LIKE(invalid_general_date):0,0\n'
    + 'FIELD:AT_CERTEXP7:TYPE(STRING8):LIKE(invalid_general_date):0,0\n'
    + 'FIELD:AT_CERTEXP8:TYPE(STRING8):LIKE(invalid_general_date):0,0\n'
    + 'FIELD:AT_CERTEXP9:TYPE(STRING8):LIKE(invalid_general_date):0,0\n'
    + 'FIELD:AT_CERTEXP10:TYPE(STRING8):LIKE(invalid_general_date):0,0\n'
    + 'FIELD:EFX_EXTRACT_DATE:TYPE(STRING8):LIKE(invalid_past_date):0,0\n'
    + 'FIELD:EFX_MERCHANT_ID:TYPE(STRING20):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:EFX_PROJECT_ID:TYPE(STRING10):LIKE(invalid_numeric_or_blank):0,0\n'
    + 'FIELD:EFX_FOREIGN:TYPE(STRING1):LIKE(invalid_yes_blank):0,0\n'
    + 'FIELD:Record_Update_Refresh_Date:TYPE(STRING8):LIKE(invalid_past_date):0,0\n'
    + 'FIELD:EFX_DATE_CREATED:TYPE(STRING8):LIKE(invalid_date_created):0,0'
    ;
 
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
