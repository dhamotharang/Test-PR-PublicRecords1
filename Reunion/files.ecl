IMPORT header,mdr;

EXPORT files:=MODULE

  EXPORT file_header_nonglb_dppa := header.file_headers_NonGLB(~mdr.Source_is_on_Probation(src) and ~mdr.Source_is_DPPA(src) and ((prim_range<>'' or prim_name<>'') and zip<>'')):persist('~thor::persist::reunion::headernonglb');

  SHARED lRawIn01:=RECORD
   STRING user_num;
   STRING first_name;
   STRING last_name;
   STRING dob;
   STRING zip;
   STRING gender;
  END;
  EXPORT dRawIn01(STRING sVersion=constants.sVersion):=DATASET(constants.sLocationIn+sVersion+'::mylife1.dat',lRawIn01,CSV(QUOTE(''),TERMINATOR(['\r\n','\n\r','\n']),SEPARATOR(','),HEADING(9)));

  SHARED lRawIn02:=RECORD
   STRING user_num;
   STRING first_name;
   STRING last_name;
   STRING street;
   STRING city;
   STRING state;
   STRING zip;
   STRING gender := '';
   STRING dob := '';
  END;
 
  EXPORT dRawIn02(STRING sVersion=constants.sVersion):= 
					DATASET(constants.sLocationIn+sVersion+'::mylife2.dat',lRawIn02,CSV(QUOTE('"'),TERMINATOR(['\r\n','\n']),SEPARATOR('|')));
  EXPORT dRawIn03(STRING sVersion=constants.sVersion):=DATASET(constants.sLocationIn+sVersion+'::mylife3.dat',lRawIn02,CSV(QUOTE('"'),TERMINATOR(['\r\n','\n']),SEPARATOR(','),HEADING(11)));
  EXPORT dRawIn04(STRING sVersion=constants.sVersion):=DATASET(constants.sLocationIn+sVersion+'::mylife4.dat',lRawIn02,CSV(QUOTE(''),TERMINATOR(['\r\n','\n']),SEPARATOR(','),HEADING(10)));
  EXPORT dRawIn05(STRING sVersion=constants.sVersion):=DATASET(constants.sLocationIn+sVersion+'::mylife5.dat',lRawIn02,CSV(QUOTE(''),TERMINATOR(['\r\n','\n']),SEPARATOR('|'),HEADING(10)));
  //EXPORT dRawIn06(STRING sVersion=constants.sVersion):=DATASET(constants.sLocationIn+sVersion+'::mylife6.dat',lRawIn02,CSV(QUOTE(''),TERMINATOR(['\r\n','\n']),SEPARATOR(','),HEADING(1)));
  EXPORT dRawIn06(STRING sVersion=constants.sVersion):=DATASET(constants.sLocationIn+sVersion+'::mylife6.dat',lRawIn01,CSV(QUOTE(''),TERMINATOR(['\r\n','\n']),SEPARATOR(','),HEADING(1)),OPT);

  EXPORT dCustomerDB:=DATASET('~thor::base::mylife::customer_database',reunion.layouts.lCustomerDB,FLAT);
	EXPORT dThirdPartyDB:=DATASET('~thor::base::mylife::third_party_database',reunion.layouts.lThirdPartyDB,FLAT);
  EXPORT dMain:=DATASET('~thor::base::mylife::main',reunion.layouts.lMain,FLAT);
  EXPORT dOldAddresses:=DATASET('~thor::base::mylife::old_addresses',reunion.layouts.lOldAddresses,FLAT);
  EXPORT dRelatives:=DATASET('~thor::base::mylife::relatives',reunion.layouts.lRelatives,FLAT);
  EXPORT dAliases:=DATASET('~thor::base::mylife::alias',reunion.layouts.lAlias,FLAT);
  EXPORT dAdlScore:=DATASET('~thor::base::mylife::adl_score',reunion.layouts.lAdlScore,FLAT);
  EXPORT dCollege:=DATASET('~thor::base::mylife::college',reunion.layouts.lCollege,FLAT);
  EXPORT dEmail:=DATASET('~thor::base::mylife::email',reunion.layouts.lEmail,FLAT);
  EXPORT dTax:=DATASET('~thor::base::mylife::tax',reunion.layouts.l_tax,FLAT);
  EXPORT dDeed:=DATASET('~thor::base::mylife::deeds',reunion.layouts.l_deed,FLAT);
  EXPORT dFlags:=DATASET('~thor::base::mylife::flags',reunion.layouts.l_flags,FLAT);
END;