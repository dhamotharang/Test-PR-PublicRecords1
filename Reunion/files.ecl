IMPORT header,mdr,infutor;

EXPORT files(unsigned1 mode):=MODULE

  // EXPORT file_header_nonglb_dppa := header.file_headers_NonGLB(~mdr.Source_is_on_Probation(src) and ~mdr.Source_is_DPPA(src) and ((prim_range<>'' or prim_name<>'') and zip<>'')):persist('~thor::persist::reunion::headernonglb');

  inf_hdr := infutor.infutor_header(~mdr.Source_is_on_Probation(src) and ~mdr.Source_is_DPPA(src) and ((prim_range<>'' or prim_name<>'') and zip<>'')):persist('~thor::persist::reunion::headerinfutor', refresh(false));
  EXPORT infutor_header := header.fn_suppress_ccpa(inf_hdr, true);

  SHARED lRawIn01:=RECORD
   STRING user_num;
   STRING first_name;
   STRING last_name;
   STRING dob;
   STRING zip;
   STRING gender;
  END;
  EXPORT dRawIn01(STRING sVersion=reunion.constants.sVersion):=DATASET(constants.sLocationIn+sVersion+'::mylife1.dat',lRawIn01,CSV(QUOTE(''),TERMINATOR(['\r\n','\n\r','\n']),SEPARATOR(','),HEADING(9)));

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

  sPrefix := '~thor::base::mylife::' + reunion.Constants.sMode(mode) + '::';
  shared sFile(record_type) := sPrefix + reunion.Constants.sFile(record_type);

  EXPORT dCustomerDB:=DATASET(sFile(1),reunion.layouts.lCustomerDB,FLAT);
	EXPORT dThirdPartyDB:=DATASET(sFile(2),reunion.layouts.lThirdPartyDB,FLAT);
  EXPORT dMain:=DATASET(sFile(3),reunion.layouts.lMain,FLAT);
  EXPORT dOldAddresses:=DATASET(sFile(4),reunion.layouts.lOldAddresses,FLAT);
  EXPORT dRelatives:=DATASET(sFile(5),reunion.layouts.lRelatives,FLAT);
  EXPORT dAliases:=DATASET(sFile(6),reunion.layouts.lAlias,FLAT);
  EXPORT dAdlScore:=DATASET(sFile(7),reunion.layouts.lAdlScore,FLAT);
  EXPORT dEmail:=DATASET(sFile(8),reunion.layouts.lEmail,FLAT);
  EXPORT dCollege:=DATASET(sFile(9),reunion.layouts.lCollege,FLAT);  
  EXPORT dDeed:=DATASET(sFile(10),reunion.layouts.l_deed,FLAT);
  EXPORT dTax:=DATASET(sFile(11),reunion.layouts.l_tax,FLAT);  
  EXPORT dFlags:=DATASET(sFile(12),reunion.layouts.l_flags,FLAT);
  EXPORT dAttributes:=DATASET(sFile(13),reunion.layouts.lAttributes,FLAT);
  
END;