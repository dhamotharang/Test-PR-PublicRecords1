//---------------------------------------------------------------------------
// Unified module to process any search or external append request
//---------------------------------------------------------------------------
IMPORT BIPV2;
// IMPORT BIPV2_Company_Names;
IMPORT lib_stringlib;
IMPORT business_header;
EXPORT _Search:=MODULE
  // List of common alternative names for fields in the BIP external base file
  // In situations where an exact field name match does not exist, the system
  // will check to see if one of these alternatives exists, and if so will
  // perform the replacement.
  EXPORT sAlternatives:='<alternatives>'+
  '<row field="uniqueid" alternative="rid" placement="after"/>'+
  '<row field="uniqueid" alternative="rcid" placement="after"/>'+
  '<row field="uniqueid" alternative="uid" placement="after"/>'+
  '<row field="uniqueid" alternative="id" placement="after"/>'+
  '<row field="uniqueid" alternative="acctno" placement="after"/>'+
  '<row field="source" alternative="src" placement="after"/>'+
  '<row field="source_record_id" alternative="src_record_id" placement="after"/>'+
  '<row field="source_record_id" alternative="src_rec_id" placement="after"/>'+
  '<row field="company_name" alternative="corp_legal_name" placement="after"/>'+
  '<row field="company_name" alternative="cname" placement="after"/>'+
  '<row field="company_name" alternative="company" placement="after"/>'+
  '<row field="company_name" alternative="name" placement="after"/>'+
  '<row field="company_phone" alternative="corp_phone_number" placement="after"/>'+
  '<row field="company_phone" alternative="telephone_number" placement="after"/>'+
  '<row field="company_phone" alternative="phone" placement="after"/>'+
  '<row field="company_fein" alternative="fein" placement="after"/>'+
  '<row field="company_sic_code1" alternative="company_sic_code" placement="after"/>'+
  '<row field="company_sic_code1" alternative="sic_code" placement="after"/>'+
  '<row field="prim_range" alternative="corp_addr1_prim_range" placement="before"/>'+
  '<row field="prim_range" alternative="company_prim_range" placement="before"/>'+
  '<row field="prim_name" alternative="corp_addr1_prim_name" placement="before"/>'+
  '<row field="prim_name" alternative="company_prim_name" placement="before"/>'+
  '<row field="sec_range" alternative="corp_addr1_sec_range" placement="before"/>'+
  '<row field="sec_range" alternative="company_sec_range" placement="before"/>'+
  '<row field="city" alternative="corp_addr1_p_city_name" placement="before"/>'+
  '<row field="city" alternative="company_city" placement="before"/>'+
  '<row field="city" alternative="p_city_name" placement="after"/>'+
  '<row field="city" alternative="v_city_name" placement="after"/>'+
  '<row field="st" alternative="corp_addr1_state" placement="before"/>'+
  '<row field="st" alternative="company_state" placement="before"/>'+
  '<row field="st" alternative="company_st" placement="before"/>'+
  '<row field="st" alternative="state" placement="before"/>'+
  '<row field="zip_cases" alternative="corp_addr1_zip5" placement="after"/>'+
  '<row field="zip_cases" alternative="zip5" placement="after"/>'+
  '<row field="zip_cases" alternative="company_zip" placement="before"/>'+
  '<row field="zip_cases" alternative="zip" placement="after"/>'+
  '<row field="zip_radius" alternative="zip_radius_miles" placement="before"/>'+
  '<row field="company_url" alternative="url" placement="after"/>'+
  '<row field="title" alternative="contact_title" placement="before"/>'+
  '<row field="fname" alternative="contact_fname" placement="before"/>'+
  '<row field="fname" alternative="first_name" placement="after"/>'+
  '<row field="fname" alternative="name_first" placement="after"/>'+
  '<row field="mname" alternative="contact_mname" placement="before"/>'+
  '<row field="mname" alternative="middle_name" placement="after"/>'+
  '<row field="mname" alternative="name_middle" placement="after"/>'+
  '<row field="lname" alternative="contact_lname" placement="before"/>'+
  '<row field="lname" alternative="last_name" placement="after"/>'+
  '<row field="lname" alternative="name_last" placement="after"/>'+
  '<row field="name_suffix" alternative="suffix" placement="after"/>'+
  '<row field="contact_ssn" alternative="ssn" placement="after"/>'+
  '<row field="contact_email" alternative="contact_email_address" placement="before"/>'+
  '<row field="contact_email" alternative="email_address" placement="after"/>'+
  '<row field="contact_email" alternative="email" placement="after"/>'+
  '<row field="maxids" alternative="results_limit" placement="after"/>'+
  '<row field="entered_proxid" alternative="proxid" placement="after"/>'+
  '<row field="entered_seleid" alternative="seleid" placement="after"/>'+
  '<row field="entered_orgid" alternative="orgid" placement="after"/>'+
  '<row field="entered_ultid" alternative="ultid" placement="after"/>'+
  '<row field="entered_powid" alternative="powid" placement="after"/>'+
  '</alternatives>';
  // Augmented layout includes the zip radius that is not in the SALT layout,
  // as well as boolean fields used to determine the output behaviour.
  EXPORT lInputAugmented:=RECORD
    BizLinkFull.Process_Biz_Layouts.InputLayout;
    UNSIGNED zip_radius;
    BOOLEAN allow7digitmatch;
    BOOLEAN HierarchicalSort;
    BOOLEAN SoapCallMode;
  END;
  // Go through the input layout and add in all the alternatives, either before
  // or after the official names, depending on the placement field in the xml
  LOADXML(sAlternatives);
  #DECLARE(fieldnames) #SET(fieldnames,'<fieldnames>')
  #DECLARE(inChild) #SET(inChild,0)
  #EXPORTXML(fields,lInputAugmented)
  #FOR(fields)
    #FOR(Field)
      #IF(%inChild%=0)
        #APPEND(fieldnames,'<row field="'+%'{@label}'%+'" alternative="'+%'{@label}'%+'" placement="match"/>')
      #END
      #IF(%'{@isDataset}'%='1' OR %'{@isEnd}'%='1') #SET(inChild,IF(%inChild%=1,0,1)) #END
    #END
  #END
  #APPEND(fieldnames,'</fieldnames>')
  #FOR(row)
    #IF(%'{@placement}'%='before')
      #SET(fieldnames,REGEXREPLACE('(<[^>]+"'+%'{@field}'%+'"[^>]+"match"/>)',%'fieldnames'%,'<row field="'+%'{@field}'%+'" alternative="'+%'{@alternative}'%+'" placement="before"/>$1'))
    #ELSE
      #SET(fieldnames,REGEXREPLACE('(.*"'+%'{@field}'%+'"[^>]+/>)',%'fieldnames'%,'$1<row field="'+%'{@field}'%+'" alternative="'+%'{@alternative}'%+'" placement="after"/>'))
    #END
  #END
  EXPORT sFieldnames:=%'fieldnames'%;
  // Construct a string that represents the input parameters for the MAC_MEOW
  // attributes.
  #SET(inChild,0)
  #DECLARE(f) #SET(f,'')
  #EXPORTXML(fields,BizLinkFull.Process_Biz_Layouts.InputLayout)
  #FOR(fields)
    #FOR(Field)
      #IF(%inChild%=0)
        #APPEND(f,','+%'{@label}'%)
      #END
      #IF(%'{@isDataset}'%='1' OR %'{@isEnd}'%='1')
        #SET(inChild,IF(%inChild%=1,0,1))
      #END
    #END
  #END
  #SET(f,REGEXREPLACE(',maxids,',%'f'%,','))
  #SET(f,REGEXREPLACE(',leadthreshold,',%'f'%,','))
  #SET(f,REGEXREPLACE(',matchrecords.*',%'f'%,''))
  EXPORT sMEOWParameters:=%'f'%[2..];
  // Process through which the formalizer maps the input fields to the
  // official field list.
  EXPORT macFieldMap(d,f=''):=FUNCTIONMACRO
    // If there are any forced field assignments, place those at the top of
    // the list of field names so they get assigned before the normal ones
    #IF(#TEXT(f)='')
      a:=BizLinkFull._Search.sFieldnames;
    #ELSE
      a:=REGEXREPLACE('(<fieldnames>)(<)',BizLinkFull._Search.sFieldnames,'$1'+REGEXREPLACE(',?([^=]+)=([^,]+)',f,'<row field="$1" alternative="$2" placement="force"/>')+'$2');
    #END
    LOADXML(a);
    // Build a template for populating the InputLayout structure.  Initially,
    // all fields are assigned "___".  Names of field from the input data are
    // added in shortly.
    #DECLARE(pbl) #SET(pbl,'PROJECT('+#TEXT(d)+',TRANSFORM(BizLinkFull._Search.lInputAugmented,')
    #DECLARE(inChild) #SET(inChild,0)
    #EXPORTXML(fields,BizLinkFull._Search.lInputAugmented)
    #FOR(fields)
      #FOR(Field)
        #IF(%inChild%=0)
          #APPEND(pbl,'SELF.'+%'{@label}'%+':=(TYPEOF(BizLinkFull._Search.lInputAugmented.'+%'{@label}'%+'))')
          #IF(%'{@label}'% IN ['uniqueid','maxids','leadthreshold','zip_cases','matchrecords','fullmatch','entered_rcid','entered_proxid','entered_seleid','entered_orgid','entered_ultid','entered_powid','zip_radius','allow7digitmatch','hierarchicalsort','soapcallmode','bgetallscores','disableforce'])
            #APPEND(pbl,'___;\n')
          #ELSE
            #APPEND(pbl,'BizLinkFull.Fields.Make_'+%'{@label}'%+'((STRING)___);\n')
          #END
        #END
        #IF(%'{@isDataset}'%='1' OR %'{@isEnd}'%='1')
          #SET(inChild,IF(%inChild%=1,0,1))
        #END
      #END
    #END
    // Get a list of all the fields in the input dataset
    #DECLARE(input_fields) #SET(input_fields,'')
    #EXPORTXML(fields,RECORDOF(d))
    #FOR(fields)
      #FOR(Field)
        #APPEND(input_fields,':'+%'{@label}'%+':')
      #END
    #END
    // Now go through the field list sequentially and assign the mapping of
    // fields in the input table to the fields in the formalize layout
    #FOR(row)
      #IF(REGEXFIND(':'+%'{@alternative}'%+':',%'input_fields'%))
        #SET(pbl,REGEXREPLACE('(SELF[.]'+%'{@field}'%+':[^;]+)___',%'pbl'%,'$1LEFT.'+%'{@alternative}'%))
      #END
    #END
    // Special cases:
    // If the uniqueid field is blank, populate it with a sequential number
    #SET(pbl,REGEXREPLACE('(SELF.uniqueid:=[^;]+)___',%'pbl'%,'$1COUNTER'))
    // Set all unassigned fields to blank, add in the suffix
    // #SET(pbl,REGEXREPLACE('___',%'pbl'%,'\'\'')+'SELF.zip_weights:=DATASET([],BizLinkFull.Process_Biz_Layouts.Zip_Weights_Layout);))');
    #SET(pbl,REGEXREPLACE('___',%'pbl'%,'\'\'')+'))');
    // fields ending in "_cases" are MULTIPLE fields, so we need to wrap those
    // into a dataset
    #SET(pbl,REGEXREPLACE('(SELF.[^_]+_cases:=)[^)]+[)][)]([^;]+)',%'pbl'%,'$1DATASET([{TRIM($2),0}],BizLinkFull.Process_Biz_Layouts.layout_zip_cases)'))
    RETURN %'pbl'%;
  ENDMACRO;
  // Dataset showing the mappings being performed based on input
  EXPORT macShowMapping(d,f=''):=FUNCTIONMACRO
    sMapped:=BizLinkFull._Search.macFieldMap(d,f);
    dMapped:=REGEXREPLACE(',[^{}]*[)][)]',REGEXREPLACE('.+lInputAugmented,',REGEXREPLACE('SELF[^;]+COUNTER;',REGEXREPLACE('SELF[.]([^:]+):=[^;]+(\'\')[^;]*;',REGEXREPLACE('SELF[.]([^:]+):=[^;]+LEFT[.]([^);]+)[^;]*;',sMapped,'{\'$2\',\'$1\'},'),'{\'\',\'$1\'},'),'{\'auto-generated uniqueid\',\'uniqueid\'},'),'DATASET(['),'],{STRING input_field;STRING mapped_field;})');
    RETURN #EXPAND(dMapped);
  ENDMACRO;
  // FunctionMacro takes a dataset of indeterminite layout and formalizes it
  // into an augmented, unified layout.  Any fields that match a field name
  // in the unified layout, or are a common alternative name for one of those
  // fields, will be translated directly.  The user also has the ability to
  // specify field translations using the second parameter in the form of
  // a string with the format:
  // 'official_field_name=input_field_name,official_field_name=input_field_name,...'
  // Setting bZipExtrapolate to FALSE will keep the original zip information
  // that was entered rather than extrapolate it to a dataset of known zips
  // for the city/state entered. (should be used when running a thor batch
  // job)
  // The macro automatically augments the input (e.g. calculating cnp_name,
  // determining preferred first name, splitting the phone number, etc.) unless
  // the user passes FALSE to the third argument.
  EXPORT macFormalize(d,f='',bAugment=TRUE,bZipExtrapolate=TRUE):=FUNCTIONMACRO
    IMPORT BIPV2_Company_Names;
    sMapped:=BizLinkFull._Search.macFieldMap(d,f);
    // Update the input data to match InputLayout, then perform company name
    // cleaning and then all of the other augmentations.
    // RETURN %'pbl'%;
    dFormatted:=#EXPAND(sMapped);
    BIPV2_Company_Names.functions.mac_go(dFormatted,dCompany,uniqueid,company_name,,FALSE);
    dAugmented:=PROJECT(dCompany,TRANSFORM(BizLinkFull._Search.lInputAugmented,
      dAirportReplacement:=BIPV2.fn_translate_city(stringlib.StringToUpperCase(LEFT.city));
      sTmpState:=IF(LENGTH(TRIM(LEFT.city))=3,IF(COUNT(dAirportReplacement)=0,LEFT.st,dAirportReplacement[2]),LEFT.st);
      SELF.city:=IF(LENGTH(TRIM(LEFT.city))=3,IF(COUNT(dAirportReplacement)=0,LEFT.city,dAirportReplacement[1]),LEFT.city);
      dZips:=BIPV2.fn_get_zips_2(SELF.city,sTmpState,TRIM(LEFT.zip_cases[1].zip),LEFT.zip_radius);
      Input_zip_radius:=LEFT.zip_radius;
      SELF.zip_cases:=MAP(
        ~bZipExtrapolate AND TRIM(LEFT.zip_cases[1].zip)='' => DATASET([],BizLinkFull.Process_Biz_Layouts.layout_zip_cases),
        ~bZipExtrapolate => DATASET([{TRIM(LEFT.zip_cases[1].zip),100}],BizLinkFull.Process_Biz_Layouts.layout_zip_cases),
        dZips[1].zip='' => DATASET([],BizLinkFull.Process_Biz_Layouts.layout_zip_cases),
        PROJECT(dZips,TRANSFORM(BizLinkFull.Process_Biz_Layouts.layout_zip_cases,SELF.weight:=100-((LEFT.radius/Input_zip_radius)*50);SELF:=LEFT;))
      );
      SELF.st:=dZips[1].state;
      SELF.company_name_prefix:=BizLinkFull.fn_company_name_prefix(LEFT.cnp_name);
      sPhone3:=IF(LENGTH(TRIM(LEFT.company_phone))=10,LEFT.company_phone[..3],'');
      SELF.company_phone_3:=IF(LEFT.allow7digitmatch,'',sPhone3);
      SELF.company_phone_3_ex:=IF(LEFT.allow7digitmatch,sPhone3,'');
      SELF.company_phone_7:=IF(LENGTH(TRIM(LEFT.company_phone))=10,LEFT.company_phone[4..],IF(LENGTH(TRIM(LEFT.company_phone))=7,LEFT.company_phone,''));
      SELF.fname_preferred:=BizLinkFull.fn_PreferredName(LEFT.fname);
      SELF.sele_flag:=IF(LEFT.HierarchicalSort,'T','_');
      SELF.org_flag:=IF(LEFT.HierarchicalSort,'T','_');
      SELF.ult_flag:=IF(LEFT.HierarchicalSort,'T','_');
      SELF.contactname:=REGEXREPLACE('^ | $',REGEXREPLACE('[ ]+',TRIM(LEFT.fname)+' '+TRIM(LEFT.mname)+' '+TRIM(LEFT.lname),' '),'');
      SELF.streetaddress:=REGEXREPLACE('^ | $',REGEXREPLACE('[ ]+',TRIM(LEFT.prim_range)+' '+TRIM(LEFT.prim_name)+' '+TRIM(LEFT.sec_range),' '),'');
      SELF.MaxIDs:=IF(LEFT.MaxIDs=0,50,LEFT.MaxIDs);
      SELF.SoapCallMode:=TRUE;
//      SELF.LeadThreshold:=10;
      SELF:=LEFT;
      SELF:=[];
    ));
    RETURN IF(bAugment,dAugmented,dFormatted);
    // RETURN %'pbl'%;
  ENDMACRO;
  // Builds the call to MAC_MEOW_Biz_Batch using InputLayout as the template
  // and then submits the input dataset
  EXPORT BatchSubmit(DATASET(lInputAugmented) d,BOOLEAN bIncludeFilter=FALSE, BOOLEAN bGetAllScores=TRUE):=FUNCTION
    // #EXPAND('BizLinkFull.MAC_MEOW_Biz_Batch('+#TEXT(d)+','+REGEXREPLACE(',address_type_derived',REGEXREPLACE('input_company_name_prefix',sMEOWParameters,'',NOCASE),'',NOCASE)+',dResults,,dStats,bIncludeFilter,bGetAllScores)');
    #EXPAND('BizLinkFull.MAC_MEOW_Biz_Batch(\ninfile:=d,\nRef:=uniqueid,\nOutFile:=dResults,'+REGEXREPLACE('input_zip_cases',REGEXREPLACE('([^,]+)',REGEXREPLACE('(uniqueid,|address_type_derived,|input_company_name_prefix,|bgetallscores,|disableforce,)',sMEOWParameters,'',NOCASE),'\nInput_$1:=$1',NOCASE),'input_zip',NOCASE)+')')
    // RETURN 'BizLinkFull.MAC_MEOW_Biz_Batch(\ninfile:=d,\nRef:=uniqueid,\nOutFile:=dResults,'+REGEXREPLACE('input_zip_cases',REGEXREPLACE('([^,]+)',REGEXREPLACE('(uniqueid,|address_type_derived,|input_company_name_prefix,|bgetallscores,|disableforce,)',sMEOWParameters,'',NOCASE),'\nInput_$1:=$1',NOCASE),'input_zip',NOCASE)+')';
    RETURN dResults;
  END;
  // Take a formalized dataset and SOAP it through the search service
/*  EXPORT SoapSubmit(DATASET(lInputAugmented) d,STRING IP='http://10.239.190.1:9876'):=FUNCTION
    // lResponse:=RECORDOF(BizLinkFull.MEOW_Biz(DATASET([],BizLinkFull.Process_Biz_Layouts.InputLayout)).Raw_Results);
    // RETURN SOAPCALL(d,IP,'bip_header_soap',{d},DATASET(lResponse),PARALLEL(1));
    #EXPAND('BizLinkFull.MAC_MEOW_Biz_Online('+#TEXT(d)+','+sMEOWParameters+',dResults)');
    RETURN dResults;
  END;*/
  // Function takes results from a scored fetch, and optionally the input data
  // in formalized format, and formats the results for easy readability
  EXPORT fMatchResults(DATASET(BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch) d,DATASET(lInputAugmented) dIn=DATASET([],lInputAugmented)):=FUNCTION
    #DECLARE(fScored) #SET(fScored,'')
    #DECLARE(fIn) #SET(fIn,'')
    #EXPORTXML(fields,RECORDOF(dIn))
    #FOR(fields)
      #FOR(Field)
        #APPEND(fIn,','+%'{@label}'%+',')
      #END
    #END
    #EXPORTXML(fields,RECORDOF(d))
    #FOR(fields)
      #FOR(Field)
         #IF(%'{@label}'%[LENGTH(%'{@label}'%)-5..]='weight' OR %'{@label}'%[LENGTH(%'{@label}'%)-9..]='match_code')
           #APPEND(fScored,',LEFT.'+%'{@label}'%)
         #ELSE
           #APPEND(fScored,'},\n{\''+%'{@label}'%+'\',LEFT.'+%'{@label}'%+#IF(REGEXFIND(','+%'{@label}'%+',',%'fIn'%,NOCASE)) ',RIGHT.'+%'{@label}'% #ELSE ',\'\'' #END)
         #END
      #END
    #END
    #SET(fScored,REGEXREPLACE('[{][^{]+[{][^}]+_hash[^{]+[{][^}]+[}],',%'fScored'%,''))
    #SET(fScored,REGEXREPLACE('(_cases)(,[^}]+_cases)[}][^{]+[{][^L]+LEFT[.]([^,}]+)[^{]+[{][^}]+(LEFT[^,]+weight[^}]+)',%'fScored'%,'$1[1].$3$2[1].$3,$4'))
    lMatches:={STRING fieldname;STRING val;STRING orig:='';INTEGER weight:=0;UNSIGNED matchcode:=0;};
    lRowResults:={UNSIGNED proxid;INTEGER weight;DATASET(lMatches) field_matches;};
    lJoinedResults:={UNSIGNED reference;DATASET(lRowResults) results};
    dIDs:=TABLE(d,{reference;},reference);
    dWithIDs:=IF(COUNT(dIDs)=1 AND dIDs[1].reference=0,PROJECT(d,TRANSFORM(RECORDOF(LEFT),SELF.reference:=dIn[1].uniqueid;SELF:=LEFT;)),d);
    dJoinedResults:=JOIN(dWithIDs,dIn,LEFT.reference=RIGHT.uniqueid,TRANSFORM(lJoinedResults,
      SELF.Results:=DATASET([{LEFT.proxid,LEFT.weight,DATASET([#EXPAND(%'fScored'%[3..]+'}')],lMatches)(weight>0 AND fieldname!='proxid')}],lRowResults);
      SELF:=LEFT;
    ),LEFT OUTER);
    RETURN ROLLUP(dJoinedResults,TRANSFORM(RECORDOF(LEFT),SELF.results:=LEFT.results+RIGHT.results;SELF:=LEFT;),reference);
  END;
  // Quick index searches and appends
  EXPORT Search_ADDRESS1(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw);
    SALT30.mac_wordbag_appendspecs_rx(d[1].cnp_name,BizLinkFull.Specificities(BizLinkFull.File_BizHead).cnp_name_values_key,cnp_name,cnp_name_spec);
    d01:=BizLinkFull.Key_BizHead_L_ADDRESS1.ScoredproxidFetch(d[1].prim_name,d[1].city,d[1].st,d[1].prim_range,cnp_name_spec,d[1].zip_cases,d[1].company_sic_code1,d[1].cnp_number,d[1].cnp_btype,d[1].cnp_lowv,d[1].sec_range,d[1].parent_proxid,d[1].sele_proxid,d[1].org_proxid,d[1].ultimate_proxid,d[1].sele_flag,d[1].org_flag,d[1].ult_flag) ;
    RETURN BizLinkFull._Search.fMatchResults(d01,d);
  ENDMACRO;
  EXPORT Search_ADDRESS2(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw);
    SALT30.mac_wordbag_appendspecs_rx(d[1].cnp_name,BizLinkFull.Specificities(BizLinkFull.File_BizHead).cnp_name_values_key,cnp_name,cnp_name_spec);
    d01:=BizLinkFull.Key_BizHead_L_ADDRESS2.ScoredproxidFetch(d[1].prim_name,d[1].zip_cases,d[1].prim_range,cnp_name_spec,d[1].st,d[1].city,d[1].company_sic_code1,d[1].cnp_number,d[1].cnp_btype,d[1].cnp_lowv,d[1].sec_range,d[1].parent_proxid,d[1].sele_proxid,d[1].org_proxid,d[1].ultimate_proxid,d[1].sele_flag,d[1].org_flag,d[1].ult_flag) ;
    RETURN BizLinkFull._Search.fMatchResults(d01,d);
  ENDMACRO;
  EXPORT Search_ADDRESS3(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw);
    SALT30.mac_wordbag_appendspecs_rx(d[1].cnp_name,BizLinkFull.Specificities(BizLinkFull.File_BizHead).cnp_name_values_key,cnp_name,cnp_name_spec);
    d01:=BizLinkFull.Key_BizHead_L_ADDRESS3.ScoredproxidFetch(d[1].prim_name,d[1].prim_range,d[1].zip_cases,cnp_name_spec,d[1].st,d[1].city,d[1].company_sic_code1,d[1].cnp_number,d[1].cnp_btype,d[1].cnp_lowv,d[1].sec_range,d[1].parent_proxid,d[1].sele_proxid,d[1].org_proxid,d[1].ultimate_proxid,d[1].sele_flag,d[1].org_flag,d[1].ult_flag) ;
    RETURN BizLinkFull._Search.fMatchResults(d01,d);
  ENDMACRO;
  EXPORT Search_CNPNAME(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw);
    SALT30.mac_wordbag_appendspecs_rx(d[1].cnp_name,BizLinkFull.Specificities(BizLinkFull.File_BizHead).cnp_name_values_key,cnp_name,cnp_name_spec);
    d01:=BizLinkFull.Key_BizHead_L_CNPNAME.ScoredproxidFetch(cnp_name_spec,d[1].prim_name,d[1].st,d[1].city,d[1].company_sic_code1,d[1].cnp_number,d[1].cnp_btype,d[1].cnp_lowv,d[1].prim_range,d[1].sec_range,d[1].parent_proxid,d[1].sele_proxid,d[1].org_proxid,d[1].ultimate_proxid,d[1].sele_flag,d[1].org_flag,d[1].ult_flag,d[1].zip_cases) ;
    RETURN BizLinkFull._Search.fMatchResults(d01,d);
  ENDMACRO;
  EXPORT Search_CNPNAME_FUZZY(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw);
    SALT30.mac_wordbag_appendspecs_rx(d[1].cnp_name,BizLinkFull.Specificities(BizLinkFull.File_BizHead).cnp_name_values_key,cnp_name,cnp_name_spec);
    d01:=BizLinkFull.Key_BizHead_L_CNPNAME_FUZZY.ScoredproxidFetch(d[1].company_name_prefix,cnp_name_spec,d[1].zip_cases,d[1].city,d[1].st,d[1].company_sic_code1,d[1].cnp_number,d[1].cnp_btype,d[1].cnp_lowv,d[1].prim_range,d[1].sec_range,d[1].parent_proxid,d[1].sele_proxid,d[1].org_proxid,d[1].ultimate_proxid,d[1].sele_flag,d[1].org_flag,d[1].ult_flag) ;
    RETURN BizLinkFull._Search.fMatchResults(d01,d);
  ENDMACRO;
  EXPORT Search_CNPNAME_ST(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw);
    SALT30.mac_wordbag_appendspecs_rx(d[1].cnp_name,BizLinkFull.Specificities(BizLinkFull.File_BizHead).cnp_name_values_key,cnp_name,cnp_name_spec);
    d01:=BizLinkFull.Key_BizHead_L_CNPNAME_ST.ScoredproxidFetch(cnp_name_spec,d[1].st,d[1].prim_name,d[1].zip_cases,d[1].city,d[1].company_sic_code1,d[1].cnp_number,d[1].cnp_btype,d[1].cnp_lowv,d[1].prim_range,d[1].sec_range,d[1].parent_proxid,d[1].sele_proxid,d[1].org_proxid,d[1].ultimate_proxid,d[1].sele_flag,d[1].org_flag,d[1].ult_flag) ;
    RETURN BizLinkFull._Search.fMatchResults(d01,d);
  ENDMACRO;
  EXPORT Search_CNPNAME_ZIP(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw);
    SALT30.mac_wordbag_appendspecs_rx(d[1].cnp_name,BizLinkFull.Specificities(BizLinkFull.File_BizHead).cnp_name_values_key,cnp_name,cnp_name_spec);
    d01:=BizLinkFull.Key_BizHead_L_CNPNAME_ZIP.ScoredproxidFetch(cnp_name_spec,d[1].zip_cases,d[1].prim_name,d[1].st,d[1].city,d[1].company_sic_code1,d[1].cnp_number,d[1].cnp_btype,d[1].cnp_lowv,d[1].prim_range,d[1].sec_range,d[1].parent_proxid,d[1].sele_proxid,d[1].org_proxid,d[1].ultimate_proxid,d[1].sele_flag,d[1].org_flag,d[1].ult_flag) ;
    RETURN BizLinkFull._Search.fMatchResults(d01,d);
  ENDMACRO;
  EXPORT Search_CONTACT(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw);
    SALT30.mac_wordbag_appendspecs_rx(d[1].cnp_name,BizLinkFull.Specificities(BizLinkFull.File_BizHead).cnp_name_values_key,cnp_name,cnp_name_spec);
    d01:=BizLinkFull.Key_BizHead_L_CONTACT.ScoredproxidFetch(d[1].fname_preferred,d[1].lname,d[1].mname,cnp_name_spec,d[1].zip_cases,d[1].st,d[1].fname,d[1].company_sic_code1,d[1].cnp_number,d[1].cnp_btype,d[1].cnp_lowv,d[1].prim_name,d[1].city,d[1].prim_range,d[1].sec_range,d[1].parent_proxid,d[1].sele_proxid,d[1].org_proxid,d[1].ultimate_proxid,d[1].sele_flag,d[1].org_flag,d[1].ult_flag) ;
    RETURN BizLinkFull._Search.fMatchResults(d01,d);
  ENDMACRO;
  EXPORT Search_CONTACT_DID(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw);
    d01:=BizLinkFull.Key_BizHead_L_CONTACT_DID.ScoredproxidFetch(d[1].contact_did) ;
    RETURN BizLinkFull._Search.fMatchResults(d01,d);
  ENDMACRO;
  EXPORT Search_CONTACT_SSN(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw);
    SALT30.mac_wordbag_appendspecs_rx(d[1].cnp_name,BizLinkFull.Specificities(BizLinkFull.File_BizHead).cnp_name_values_key,cnp_name,cnp_name_spec);
    d01:=BizLinkFull.Key_BizHead_L_CONTACT_SSN.ScoredproxidFetch(d[1].contact_ssn,d[1].contact_email,d[1].company_sic_code1,cnp_name_spec,d[1].cnp_number,d[1].cnp_btype,d[1].cnp_lowv,d[1].zip_cases,d[1].prim_name,d[1].city,d[1].st,d[1].prim_range,d[1].sec_range,d[1].parent_proxid,d[1].sele_proxid,d[1].org_proxid,d[1].ultimate_proxid,d[1].sele_flag,d[1].org_flag,d[1].ult_flag) ;
    RETURN BizLinkFull._Search.fMatchResults(d01,d);
  ENDMACRO;
  EXPORT Search_EMAIL(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw);
    SALT30.mac_wordbag_appendspecs_rx(d[1].cnp_name,BizLinkFull.Specificities(BizLinkFull.File_BizHead).cnp_name_values_key,cnp_name,cnp_name_spec);
    d01:=BizLinkFull.Key_BizHead_L_EMAIL.ScoredproxidFetch(d[1].contact_email,d[1].company_sic_code1,cnp_name_spec,d[1].cnp_number,d[1].cnp_btype,d[1].cnp_lowv,d[1].zip_cases,d[1].prim_name,d[1].city,d[1].st,d[1].prim_range,d[1].sec_range,d[1].parent_proxid,d[1].sele_proxid,d[1].org_proxid,d[1].ultimate_proxid,d[1].sele_flag,d[1].org_flag,d[1].ult_flag) ;
    RETURN BizLinkFull._Search.fMatchResults(d01,d);
  ENDMACRO;
  EXPORT Search_FEIN(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw);
    SALT30.mac_wordbag_appendspecs_rx(d[1].cnp_name,BizLinkFull.Specificities(BizLinkFull.File_BizHead).cnp_name_values_key,cnp_name,cnp_name_spec);
    d01:=BizLinkFull.Key_BizHead_L_FEIN.ScoredproxidFetch(d[1].company_fein,d[1].company_sic_code1,cnp_name_spec,d[1].cnp_number,d[1].cnp_btype,d[1].cnp_lowv,d[1].zip_cases,d[1].prim_name,d[1].city,d[1].st,d[1].prim_range,d[1].sec_range,d[1].parent_proxid,d[1].sele_proxid,d[1].org_proxid,d[1].ultimate_proxid,d[1].sele_flag,d[1].org_flag,d[1].ult_flag) ;
    RETURN BizLinkFull._Search.fMatchResults(d01,d);
  ENDMACRO;
  EXPORT Search_PHONE(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw);
    SALT30.mac_wordbag_appendspecs_rx(d[1].cnp_name,BizLinkFull.Specificities(BizLinkFull.File_BizHead).cnp_name_values_key,cnp_name,cnp_name_spec);
    d01:=BizLinkFull.Key_BizHead_L_PHONE.ScoredproxidFetch(d[1].company_phone_7,cnp_name_spec,d[1].company_phone_3,d[1].company_phone_3_ex,d[1].company_sic_code1,d[1].cnp_number,d[1].cnp_btype,d[1].cnp_lowv,d[1].zip_cases,d[1].prim_name,d[1].city,d[1].st,d[1].prim_range,d[1].sec_range,d[1].parent_proxid,d[1].sele_proxid,d[1].org_proxid,d[1].ultimate_proxid,d[1].sele_flag,d[1].org_flag,d[1].ult_flag) ;
    RETURN BizLinkFull._Search.fMatchResults(d01,d);
  ENDMACRO;
  EXPORT Search_SIC(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw);
    SALT30.mac_wordbag_appendspecs_rx(d[1].cnp_name,BizLinkFull.Specificities(BizLinkFull.File_BizHead).cnp_name_values_key,cnp_name,cnp_name_spec);
    d01:=BizLinkFull.Key_BizHead_L_SIC.ScoredproxidFetch(d[1].company_sic_code1,d[1].zip_cases,cnp_name_spec,d[1].prim_name) ;
    RETURN BizLinkFull._Search.fMatchResults(d01,d);
  ENDMACRO;
  EXPORT Search_SOURCE(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw);
    SALT30.mac_wordbag_appendspecs_rx(d[1].cnp_name,BizLinkFull.Specificities(BizLinkFull.File_BizHead).cnp_name_values_key,cnp_name,cnp_name_spec);
    d01:=BizLinkFull.Key_BizHead_L_SOURCE.ScoredproxidFetch(d[1].source_record_id,d[1].source,cnp_name_spec,d[1].prim_name,d[1].zip_cases,d[1].city,d[1].st,d[1].company_sic_code1,d[1].cnp_number,d[1].cnp_btype,d[1].cnp_lowv,d[1].prim_range,d[1].sec_range,d[1].parent_proxid,d[1].sele_proxid,d[1].org_proxid,d[1].ultimate_proxid,d[1].sele_flag,d[1].org_flag,d[1].ult_flag) ;
    RETURN BizLinkFull._Search.fMatchResults(d01,d);
  ENDMACRO;
  EXPORT Search_URL(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw);
    SALT30.mac_wordbag_appendspecs_rx(d[1].cnp_name,BizLinkFull.Specificities(BizLinkFull.File_BizHead).cnp_name_values_key,cnp_name,cnp_name_spec);
    d01:=BizLinkFull.Key_BizHead_L_URL.ScoredproxidFetch(d[1].company_url,d[1].st,d[1].company_sic_code1,cnp_name_spec,d[1].cnp_number,d[1].cnp_btype,d[1].cnp_lowv,d[1].zip_cases,d[1].prim_name,d[1].city,d[1].prim_range,d[1].sec_range,d[1].parent_proxid,d[1].sele_proxid,d[1].org_proxid,d[1].ultimate_proxid,d[1].sele_flag,d[1].org_flag,d[1].ult_flag) ;
    RETURN BizLinkFull._Search.fMatchResults(d01,d);
  ENDMACRO;
  EXPORT Batch_ADDRESS1(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw,,,FALSE);
    d01:=PROJECT(d,TRANSFORM({RECORDOF(LEFT);STRING cnp_name_;},SELF.cnp_name_:=LEFT.cnp_name;SELF.cnp_name:='';SELF:=LEFT;));
    d02:=SALT29.mac_wordbag_appendspecs_th(d01,cnp_name_,cnp_name,BizLinkFull.Specificities(BizLinkFull.File_BizHead).cnp_name_values_key,cnp_name,TRUE);
    d03:=BizLinkFull.Key_BizHead_L_ADDRESS1.ScoredFetch_Batch(PROJECT(d02,TRANSFORM(BizLinkFull.Key_BizHead_L_ADDRESS1.InputLayout_Batch,SELF.Reference:=LEFT.uniqueid;SELF:=LEFT;)),TRUE);
    RETURN BizLinkFull._Search.fMatchResults(d03,d);
  ENDMACRO;
  EXPORT Batch_ADDRESS2(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw,,,FALSE);
    d01:=PROJECT(d,TRANSFORM({RECORDOF(LEFT);STRING cnp_name_;},SELF.cnp_name_:=LEFT.cnp_name;SELF.cnp_name:='';SELF:=LEFT;));
    d02:=SALT29.mac_wordbag_appendspecs_th(d01,cnp_name_,cnp_name,BizLinkFull.Specificities(BizLinkFull.File_BizHead).cnp_name_values_key,cnp_name,TRUE);
    d03:=BizLinkFull.Key_BizHead_L_ADDRESS2.ScoredFetch_Batch(PROJECT(d02,TRANSFORM(BizLinkFull.Key_BizHead_L_ADDRESS2.InputLayout_Batch,SELF.Reference:=LEFT.uniqueid;SELF:=LEFT;)),TRUE);
    RETURN BizLinkFull._Search.fMatchResults(d03,d);
  ENDMACRO;
  EXPORT Batch_ADDRESS3(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw,,,FALSE);
    d01:=PROJECT(d,TRANSFORM({RECORDOF(LEFT);STRING cnp_name_;},SELF.cnp_name_:=LEFT.cnp_name;SELF.cnp_name:='';SELF:=LEFT;));
    d02:=SALT29.mac_wordbag_appendspecs_th(d01,cnp_name_,cnp_name,BizLinkFull.Specificities(BizLinkFull.File_BizHead).cnp_name_values_key,cnp_name,TRUE);
    d03:=BizLinkFull.Key_BizHead_L_ADDRESS3.ScoredFetch_Batch(PROJECT(d02,TRANSFORM(BizLinkFull.Key_BizHead_L_ADDRESS3.InputLayout_Batch,SELF.Reference:=LEFT.uniqueid;SELF:=LEFT;)),TRUE);
    RETURN BizLinkFull._Search.fMatchResults(d03,d);
  ENDMACRO;
  EXPORT Batch_CNPNAME(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw,,,FALSE);
    d01:=PROJECT(d,TRANSFORM({RECORDOF(LEFT);STRING cnp_name_;},SELF.cnp_name_:=LEFT.cnp_name;SELF.cnp_name:='';SELF:=LEFT;));
    d02:=SALT29.mac_wordbag_appendspecs_th(d01,cnp_name_,cnp_name,BizLinkFull.Specificities(BizLinkFull.File_BizHead).cnp_name_values_key,cnp_name,TRUE);
    d03:=BizLinkFull.Key_BizHead_L_CNPNAME.ScoredFetch_Batch(PROJECT(d02,TRANSFORM(BizLinkFull.Key_BizHead_L_CNPNAME.InputLayout_Batch,SELF.Reference:=LEFT.uniqueid;SELF:=LEFT;)),TRUE);
    RETURN BizLinkFull._Search.fMatchResults(d03,d);
  ENDMACRO;
  EXPORT Batch_CNPNAME_FUZZY(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw,,,FALSE);
    d01:=PROJECT(d,TRANSFORM({RECORDOF(LEFT);STRING cnp_name_;},SELF.cnp_name_:=LEFT.cnp_name;SELF.cnp_name:='';SELF:=LEFT;));
    d02:=SALT29.mac_wordbag_appendspecs_th(d01,cnp_name_,cnp_name,BizLinkFull.Specificities(BizLinkFull.File_BizHead).cnp_name_values_key,cnp_name,TRUE);
    d03:=BizLinkFull.Key_BizHead_L_CNPNAME_FUZZY.ScoredFetch_Batch(PROJECT(d02,TRANSFORM(BizLinkFull.Key_BizHead_L_CNPNAME_FUZZY.InputLayout_Batch,SELF.Reference:=LEFT.uniqueid;SELF:=LEFT;)),TRUE);
    RETURN BizLinkFull._Search.fMatchResults(d03,d);
  ENDMACRO;
  EXPORT Batch_CNPNAME_ST(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw,,,FALSE);
    d01:=PROJECT(d,TRANSFORM({RECORDOF(LEFT);STRING cnp_name_;},SELF.cnp_name_:=LEFT.cnp_name;SELF.cnp_name:='';SELF:=LEFT;));
    d02:=SALT29.mac_wordbag_appendspecs_th(d01,cnp_name_,cnp_name,BizLinkFull.Specificities(BizLinkFull.File_BizHead).cnp_name_values_key,cnp_name,TRUE);
    d03:=BizLinkFull.Key_BizHead_L_CNPNAME_ST.ScoredFetch_Batch(PROJECT(d02,TRANSFORM(BizLinkFull.Key_BizHead_L_CNPNAME_ST.InputLayout_Batch,SELF.Reference:=LEFT.uniqueid;SELF:=LEFT;)),TRUE);
    RETURN BizLinkFull._Search.fMatchResults(d03,d);
  ENDMACRO;
  EXPORT Batch_CNPNAME_ZIP(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw,,,FALSE);
    d01:=PROJECT(d,TRANSFORM({RECORDOF(LEFT);STRING cnp_name_;},SELF.cnp_name_:=LEFT.cnp_name;SELF.cnp_name:='';SELF:=LEFT;));
    d02:=SALT29.mac_wordbag_appendspecs_th(d01,cnp_name_,cnp_name,BizLinkFull.Specificities(BizLinkFull.File_BizHead).cnp_name_values_key,cnp_name,TRUE);
    d03:=BizLinkFull.Key_BizHead_L_CNPNAME_ZIP.ScoredFetch_Batch(PROJECT(d02,TRANSFORM(BizLinkFull.Key_BizHead_L_CNPNAME_ZIP.InputLayout_Batch,SELF.Reference:=LEFT.uniqueid;SELF:=LEFT;)),TRUE);
    RETURN BizLinkFull._Search.fMatchResults(d03,d);
  ENDMACRO;
  EXPORT Batch_CONTACT(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw,,,FALSE);
    d01:=PROJECT(d,TRANSFORM({RECORDOF(LEFT);STRING cnp_name_;},SELF.cnp_name_:=LEFT.cnp_name;SELF.cnp_name:='';SELF:=LEFT;));
    d02:=SALT29.mac_wordbag_appendspecs_th(d01,cnp_name_,cnp_name,BizLinkFull.Specificities(BizLinkFull.File_BizHead).cnp_name_values_key,cnp_name,TRUE);
    d03:=BizLinkFull.Key_BizHead_L_CONTACT.ScoredFetch_Batch(PROJECT(d02,TRANSFORM(BizLinkFull.Key_BizHead_L_CONTACT.InputLayout_Batch,SELF.Reference:=LEFT.uniqueid;SELF:=LEFT;)),TRUE);
    RETURN BizLinkFull._Search.fMatchResults(d03,d);
  ENDMACRO;
  EXPORT Batch_CONTACT_DID(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw,,,FALSE);
    d01:=PROJECT(d,TRANSFORM({RECORDOF(LEFT);STRING cnp_name_;},SELF.cnp_name_:=LEFT.cnp_name;SELF.cnp_name:='';SELF:=LEFT;));
    d02:=SALT29.mac_wordbag_appendspecs_th(d01,cnp_name_,cnp_name,BizLinkFull.Specificities(BizLinkFull.File_BizHead).cnp_name_values_key,cnp_name,TRUE);
    d03:=BizLinkFull.Key_BizHead_L_CONTACT_DID.ScoredFetch_Batch(PROJECT(d02,TRANSFORM(BizLinkFull.Key_BizHead_L_CONTACT_DID.InputLayout_Batch,SELF.Reference:=LEFT.uniqueid;SELF:=LEFT;)),TRUE);
    RETURN BizLinkFull._Search.fMatchResults(d03,d);
  ENDMACRO;
  EXPORT Batch_CONTACT_SSN(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw,,,FALSE);
    d01:=PROJECT(d,TRANSFORM({RECORDOF(LEFT);STRING cnp_name_;},SELF.cnp_name_:=LEFT.cnp_name;SELF.cnp_name:='';SELF:=LEFT;));
    d02:=SALT29.mac_wordbag_appendspecs_th(d01,cnp_name_,cnp_name,BizLinkFull.Specificities(BizLinkFull.File_BizHead).cnp_name_values_key,cnp_name,TRUE);
    d03:=BizLinkFull.Key_BizHead_L_CONTACT_SSN.ScoredFetch_Batch(PROJECT(d02,TRANSFORM(BizLinkFull.Key_BizHead_L_CONTACT_SSN.InputLayout_Batch,SELF.Reference:=LEFT.uniqueid;SELF:=LEFT;)),TRUE);
    RETURN BizLinkFull._Search.fMatchResults(d03,d);
  ENDMACRO;
  EXPORT Batch_EMAIL(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw,,,FALSE);
    d01:=PROJECT(d,TRANSFORM({RECORDOF(LEFT);STRING cnp_name_;},SELF.cnp_name_:=LEFT.cnp_name;SELF.cnp_name:='';SELF:=LEFT;));
    d02:=SALT29.mac_wordbag_appendspecs_th(d01,cnp_name_,cnp_name,BizLinkFull.Specificities(BizLinkFull.File_BizHead).cnp_name_values_key,cnp_name,TRUE);
    d03:=BizLinkFull.Key_BizHead_L_EMAIL.ScoredFetch_Batch(PROJECT(d02,TRANSFORM(BizLinkFull.Key_BizHead_L_EMAIL.InputLayout_Batch,SELF.Reference:=LEFT.uniqueid;SELF:=LEFT;)),TRUE);
    RETURN BizLinkFull._Search.fMatchResults(d03,d);
  ENDMACRO;
  EXPORT Batch_FEIN(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw,,,FALSE);
    d01:=PROJECT(d,TRANSFORM({RECORDOF(LEFT);STRING cnp_name_;},SELF.cnp_name_:=LEFT.cnp_name;SELF.cnp_name:='';SELF:=LEFT;));
    d02:=SALT29.mac_wordbag_appendspecs_th(d01,cnp_name_,cnp_name,BizLinkFull.Specificities(BizLinkFull.File_BizHead).cnp_name_values_key,cnp_name,TRUE);
    d03:=BizLinkFull.Key_BizHead_L_FEIN.ScoredFetch_Batch(PROJECT(d02,TRANSFORM(BizLinkFull.Key_BizHead_L_FEIN.InputLayout_Batch,SELF.Reference:=LEFT.uniqueid;SELF:=LEFT;)),TRUE);
    RETURN BizLinkFull._Search.fMatchResults(d03,d);
  ENDMACRO;
  EXPORT Batch_PHONE(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw,,,FALSE);
    d01:=PROJECT(d,TRANSFORM({RECORDOF(LEFT);STRING cnp_name_;},SELF.cnp_name_:=LEFT.cnp_name;SELF.cnp_name:='';SELF:=LEFT;));
    d02:=SALT29.mac_wordbag_appendspecs_th(d01,cnp_name_,cnp_name,BizLinkFull.Specificities(BizLinkFull.File_BizHead).cnp_name_values_key,cnp_name,TRUE);
    d03:=BizLinkFull.Key_BizHead_L_PHONE.ScoredFetch_Batch(PROJECT(d02,TRANSFORM(BizLinkFull.Key_BizHead_L_PHONE.InputLayout_Batch,SELF.Reference:=LEFT.uniqueid;SELF:=LEFT;)),TRUE);
    RETURN BizLinkFull._Search.fMatchResults(d03,d);
  ENDMACRO;
  EXPORT Batch_SIC(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw,,,FALSE);
    d01:=PROJECT(d,TRANSFORM({RECORDOF(LEFT);STRING cnp_name_;},SELF.cnp_name_:=LEFT.cnp_name;SELF.cnp_name:='';SELF:=LEFT;));
    d02:=SALT29.mac_wordbag_appendspecs_th(d01,cnp_name_,cnp_name,BizLinkFull.Specificities(BizLinkFull.File_BizHead).cnp_name_values_key,cnp_name,TRUE);
    d03:=BizLinkFull.Key_BizHead_L_SIC.ScoredFetch_Batch(PROJECT(d02,TRANSFORM(BizLinkFull.Key_BizHead_L_SIC.InputLayout_Batch,SELF.Reference:=LEFT.uniqueid;SELF:=LEFT;)),TRUE);
    RETURN BizLinkFull._Search.fMatchResults(d03,d);
  ENDMACRO;
  EXPORT Batch_SOURCE(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw,,,FALSE);
    d01:=PROJECT(d,TRANSFORM({RECORDOF(LEFT);STRING cnp_name_;},SELF.cnp_name_:=LEFT.cnp_name;SELF.cnp_name:='';SELF:=LEFT;));
    d02:=SALT29.mac_wordbag_appendspecs_th(d01,cnp_name_,cnp_name,BizLinkFull.Specificities(BizLinkFull.File_BizHead).cnp_name_values_key,cnp_name,TRUE);
    d03:=BizLinkFull.Key_BizHead_L_SOURCE.ScoredFetch_Batch(PROJECT(d02,TRANSFORM(BizLinkFull.Key_BizHead_L_SOURCE.InputLayout_Batch,SELF.Reference:=LEFT.uniqueid;SELF:=LEFT;)),TRUE);
    RETURN BizLinkFull._Search.fMatchResults(d03,d);
  ENDMACRO;
  EXPORT Batch_URL(dRaw):=FUNCTIONMACRO
    d:=BizLinkFull._Search.macFormalize(dRaw,,,FALSE);
    d01:=PROJECT(d,TRANSFORM({RECORDOF(LEFT);STRING cnp_name_;},SELF.cnp_name_:=LEFT.cnp_name;SELF.cnp_name:='';SELF:=LEFT;));
    d02:=SALT29.mac_wordbag_appendspecs_th(d01,cnp_name_,cnp_name,BizLinkFull.Specificities(BizLinkFull.File_BizHead).cnp_name_values_key,cnp_name,TRUE);
    d03:=BizLinkFull.Key_BizHead_L_URL.ScoredFetch_Batch(PROJECT(d02,TRANSFORM(BizLinkFull.Key_BizHead_L_URL.InputLayout_Batch,SELF.Reference:=LEFT.uniqueid;SELF:=LEFT;)),TRUE);
    RETURN BizLinkFull._Search.fMatchResults(d03,d);
  ENDMACRO;
// End Quick index searches and appends
END;
