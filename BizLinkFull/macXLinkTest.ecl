//---------------------------------------------------------------------------
// Macro accepts a dataset and runs it through the batch external linking
// process.  User does not need to be concerned with input layout or field
// order.  The only two requirements are that the dataset have a "Ref" field
// which contains the UID, and the name of any field that they want to be
// used during external linking must match the corresponding name in the
// external linking base file.
//---------------------------------------------------------------------------
IMPORT lib_stringlib;
EXPORT macXLinkTest(d,bDebug=FALSE,bShowIntermediate=FALSE):=FUNCTIONMACRO
  LOADXML('<xml/>');
  #DECLARE(MBB)
  #SET(MBB,'BizLinkFull.MAC_MEOW_Biz_Batch(infile,Ref,Input_parent_proxid,Input_ultimate_proxid,Input_has_lgid,Input_empid,Input_powid,Input_source,Input_source_record_id,Input_company_name,Input_company_name_prefix,Input_cnp_name,Input_cnp_number,Input_cnp_btype,Input_cnp_lowv,Input_company_phone,Input_company_phone_3,Input_company_phone_3_ex,Input_company_phone_7,Input_company_fein,Input_company_sic_code1,Input_prim_range,Input_prim_name,Input_sec_range,Input_city,Input_city_clean,Input_st,Input_zip,Input_company_url,Input_isContact,Input_contact_did,Input_title,Input_fname,Input_fname_preferred,Input_mname,Input_lname,Input_name_suffix,Input_contact_ssn,Input_contact_email,Input_sele_flag,Input_org_flag,Input_ult_flag,Input_CONTACTNAME,Input_STREETADDRESS,OutFile,AsIndex,Stats);')
  #EXPORTXML(x,RECORDOF(d));
  #FOR(x)
    #FOR(Field)
      #SET(MBB,REGEXREPLACE('Input_('+%'{@label}'%+',)',%'MBB'%,'$1',NOCASE))
      #IF(Stringlib.StringToUpperCase(%'{@label}'%)='COMPANY_NAME')
        #SET(MBB,REGEXREPLACE('Input_(cnp_name,)',%'MBB'%,'$1',NOCASE))
        #SET(MBB,REGEXREPLACE('Input_(cnp_number,)',%'MBB'%,'$1',NOCASE))
        #SET(MBB,REGEXREPLACE('Input_(cnp_btype,)',%'MBB'%,'$1',NOCASE))
        #SET(MBB,REGEXREPLACE('Input_(cnp_lowv,)',%'MBB'%,'$1',NOCASE))
        #SET(MBB,REGEXREPLACE('Input_(company_name_prefix,)',%'MBB'%,'$1',NOCASE))
      #END
      #IF(Stringlib.StringToUpperCase(%'{@label}'%)='COMPANY_PHONE')
        #SET(MBB,REGEXREPLACE('Input_(company_phone_3,)',%'MBB'%,'$1',NOCASE))
        #SET(MBB,REGEXREPLACE('Input_(company_phone_7,)',%'MBB'%,'$1',NOCASE))
      #END
      #IF(Stringlib.StringToUpperCase(%'{@label}'%)='FNAME')
        #SET(MBB,REGEXREPLACE('Input_(fname_preferred,)',%'MBB'%,'$1',NOCASE))
      #END
    #END
  #END
  
  #DECLARE(s) #SET(s,'')
  #UNIQUENAME(dCNP)
  #IF(REGEXFIND(',company_name,',%'MBB'%))
    #UNIQUENAME(cnptmp)
    #APPEND(s,'BIPV2_Company_Names.functions.mac_go('+#TEXT(d)+','+%'cnptmp'%+',Ref,company_name,,FALSE);\n')
    #APPEND(s,%'dCNP'%+':=TABLE('+%'cnptmp'%+',{'+%'cnptmp'%+';STRING5 company_name_prefix:=company_name[..5];});\n')
  #ELSE
    #APPEND(s,%'dCNP'%+':='+#TEXT(d)+';\n')
  #END
  
  #UNIQUENAME(dPhone)
  #IF(REGEXFIND(',company_phone,',%'MBB'%))
    #APPEND(s,%'dPhone'%+':=PROJECT('+%'dCNP'%+',TRANSFORM({RECORDOF(LEFT);STRING company_phone_3;STRING company_phone_7;},\n')
    #APPEND(s,'  SELF.company_phone_3:=IF(LENGTH(TRIM(LEFT.company_phone))=10,LEFT.company_phone[..3],\'\');\n')
    #APPEND(s,'  SELF.company_phone_7:=IF(LENGTH(TRIM(LEFT.company_phone))=10,LEFT.company_phone[4..],IF(LENGTH(TRIM(LEFT.company_phone))=7,LEFT.company_phone,\'\'));\n')
    #APPEND(s,'  SELF:=LEFT;\n));\n')
  #ELSE
    #APPEND(s,%'dPhone'%+':='+%'dCNP'%+';\n');
  #END
  // sFNamePreferred:=THISMODULE.fn_PreferredName(Input_fname);
  #UNIQUENAME(dFName)
  #IF(REGEXFIND(',fname,',%'MBB'%))
    #APPEND(s,%'dFName'%+':=PROJECT('+%'dPhone'%+',TRANSFORM({RECORDOF(LEFT);STRING fname_preferred;},SELF.fname_preferred:='+REGEXFIND('^([^.]+)',%'MBB'%,1)+'.fn_PreferredName(LEFT.fname);SELF:=LEFT;));\n');
  #ELSE
    #APPEND(s,%'dFName'%+':='+%'dPhone'%+';\n');
  #END
  
  #UNIQUENAME(o)
  #APPEND(s,'\n'+REGEXREPLACE('[(]infile',REGEXREPLACE(',OutFile[^)]+',REGEXREPLACE('Input_[^,]+,',%'MBB'%,','),','+%'o'%,NOCASE),'('+%'dFName'%,NOCASE)+'\n');
  
  
  #IF(bDebug)
    RETURN(%'s'%);
  #ELSE
    #EXPAND(%'s'%);
    #IF(bShowIntermediate)
      OUTPUT(#EXPAND(%'dFName'%),NAMED('Extended_Input'+%'dFName'%));
    #END
    RETURN(%o%);
  #END
ENDMACRO;

