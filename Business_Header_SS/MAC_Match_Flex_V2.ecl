import business_header, bipv2,_control;
EXPORT MAC_Match_Flex_V2
(
   infile
  ,matchset             //defined in Business_Header_SS.MAC_Add_BDID_FLEX
  ,company_name_field
  ,prange_field
  ,pname_field
  ,zip_field
  ,srange_field
  ,state_field
  ,phone_field
  ,fein_field
  ,BDID_field
  ,outrec
  ,bool_outrec_has_score
  ,BDID_Score_field       //these should default to zero in definition
  ,outfile2
  ,keep_count             = '1'
  ,score_threshold        = '75'
  
  //not quite sure if i need these next two
  ,pFileVersion           = '\'prod\''                            // default to use prod version of superfiles
  ,pUseOtherEnvironment   = business_header._Dataset().IsDataland // default is to hit prod on dataland, and on prod hit prod.
  ,pSetLinkingVersions    = BIPV2.IDconstants.xlink_versions_default  //
  ,pURL                   = ''
  ,pEmail                 = ''
  ,pCity                  = ''
  ,pContact_fname         = ''
  ,pContact_mname         = ''
  ,pContact_lname         = ''
  ,pContact_ssn            = ''
  ,pSource                 = ''
  ,pSource_record_id       = ''
  ,src_matching_is_priority = FALSE
  ,bGetAllScores=TRUE
) :=
MACRO
import _control;
#IF(_Control.ThisEnvironment.Name[..5]='Alpha')
  #UNIQUENAME(lBatchInput)
  %lBatchInput%:=RECORD
    UNSIGNED   acctno;
    STRING120  company_name;
    STRING10   prim_range;
    STRING28   prim_name;
    STRING8    sec_range;
    STRING25   city;
    STRING2    st;
    STRING5    zip;
    STRING20   fname;
    STRING20   mname;
    STRING20   lname;
    STRING2    source;
    UNSIGNED   source_record_id;
    STRING10   company_phone;
    STRING9    company_fein;
    STRING8    company_sic_code1;
    STRING80   company_url;
    STRING9    contact_ssn;
    STRING60   contact_email;
    UNSIGNED6  entered_proxid;
  END;
  #UNIQUENAME(lBatchOutput)
  %lBatchOutput%:=  RECORD
    UNSIGNED6  acctno;
    UNSIGNED6  proxid;
    UNSIGNED6  seleid;
    UNSIGNED6  orgid;
    UNSIGNED6  ultid;
    UNSIGNED2  weight;
    UNSIGNED2  score;
    UNSIGNED6  rcid;
    UNSIGNED6  empid;
    UNSIGNED6  powid;
    UNSIGNED6  dotid;
    UNSIGNED6  parent_proxid;
    UNSIGNED6  sele_proxid;
    UNSIGNED6  org_proxid;
    UNSIGNED6  ultimate_proxid;
    BOOLEAN    has_lgid;
    STRING120  company_name;
    STRING5    title;
    STRING20   fname;
    STRING20   mname;
    STRING20   lname;
    STRING5    name_suffix;
    STRING1    iscontact;
    STRING9    contact_ssn;
    STRING60   contact_email;
    UNSIGNED8  company_rawaid;
    UNSIGNED8  company_aceaid;
    STRING10   prim_range;
    STRING2    predir;
    STRING28   prim_name;
    STRING4    addr_suffix;
    STRING2    postdir;
    STRING10   unit_desig;
    STRING8    sec_range;
    STRING25   p_city_name;
    STRING25   v_city_name;
    STRING2    st;
    STRING5    zip;
    STRING4    zip4;
    STRING3    fips_county;
    STRING25   county_name;
    STRING2    source;
    UNSIGNED4  dt_first_seen;
    UNSIGNED4  dt_last_seen;
    UNSIGNED4  dt_vendor_last_reported;
    STRING9    duns_number;
    UNSIGNED6  company_bdid;
    STRING9    company_fein;
    STRING10   company_phone;
    STRING1    phone_type;
    STRING80   company_url;
    STRING8    company_sic_code1;
    STRING50   company_status_derived;
    STRING34   vl_id;
    UNSIGNED8  source_record_id;
    UNSIGNED6  contact_did;
    STRING30   contact_email_domain;
    STRING50   contact_job_title_derived;
    UNSIGNED8  rid;
    UNSIGNED6  cnp_nameid;
    STRING250  cnp_name;
    STRING30   cnp_number;
    STRING10   cnp_store_number;
    STRING10   cnp_btype;
    STRING20   cnp_lowv;
    BOOLEAN    cnp_translated;
    INTEGER4   cnp_classid;
    STRING5    company_name_prefix;
    STRING25   city;
    STRING25   city_clean;
    STRING3    company_phone_3;
    STRING3    company_phone_3_ex;
    STRING7    company_phone_7;
    STRING20   fname_preferred;
    STRING1    sele_flag;
    STRING1    org_flag;
    STRING1    ult_flag;
    BOOLEAN    fullmatch_required;
    BOOLEAN    has_fullmatch;
    BOOLEAN    recordsonly;
    BOOLEAN    is_fullmatch;
    INTEGER2   record_score;
    INTEGER2   match_parent_proxid;
    INTEGER2   match_ultimate_proxid;
    INTEGER2   match_has_lgid;
    INTEGER2   match_empid;
    INTEGER2   match_powid;
    INTEGER2   match_source;
    INTEGER2   match_source_record_id;
    INTEGER2   match_company_name;
    INTEGER2   match_company_name_prefix;
    INTEGER2   match_cnp_name;
    INTEGER2   match_cnp_number;
    INTEGER2   match_cnp_btype;
    INTEGER2   match_cnp_lowv;
    INTEGER2   match_company_phone;
    INTEGER2   match_company_phone_3;
    INTEGER2   match_company_phone_3_ex;
    INTEGER2   match_company_phone_7;
    INTEGER2   match_company_fein;
    INTEGER2   match_company_sic_code1;
    INTEGER2   match_prim_range;
    INTEGER2   match_prim_name;
    INTEGER2   match_sec_range;
    INTEGER2   match_city;
    INTEGER2   match_city_clean;
    INTEGER2   match_st;
    INTEGER2   match_zip;
    INTEGER2   match_company_url;
    INTEGER2   match_iscontact;
    INTEGER2   match_contact_did;
    INTEGER2   match_title;
    INTEGER2   match_fname;
    INTEGER2   match_fname_preferred;
    INTEGER2   match_mname;
    INTEGER2   match_lname;
    INTEGER2   match_name_suffix;
    INTEGER2   match_contact_ssn;
    INTEGER2   match_contact_email;
    INTEGER2   match_sele_flag;
    INTEGER2   match_org_flag;
    INTEGER2   match_ult_flag;
    INTEGER2   match_contactname;
    INTEGER2   match_streetaddress;
  END;
  #UNIQUENAME(dInputSequenced)
  #UNIQUENAME(_uid)
  %dInputSequenced%:=PROJECT(infile,TRANSFORM({RECORDOF(LEFT);UNSIGNED %_uid%;},SELF.%_uid%:=COUNTER;SELF:=LEFT;));
  
  #UNIQUENAME(dInputFormatted)
  %dInputFormatted%:=PROJECT(%dInputSequenced%,TRANSFORM({%lBatchInput%},
    SELF.acctno:=LEFT.%_uid%;
    #IF(#TEXT(company_name_field)<>'') SELF.company_name:=LEFT.company_name_field;    #END
    #IF(#TEXT(prange_field)<>'')       SELF.prim_range:=LEFT.prange_field;            #END
    #IF(#TEXT(pname_field)<>'')        SELF.prim_name:=LEFT.pname_field;              #END
    #IF(#TEXT(srange_field)<>'')       SELF.sec_range:=LEFT.srange_field;             #END
    #IF(#TEXT(pCity)<>'')              SELF.city:=LEFT.pCity;                         #END
    #IF(#TEXT(state_field)<>'')        SELF.st:=LEFT.state_field;                     #END
    #IF(#TEXT(zip_field)<>'')          SELF.zip:=LEFT.zip_field;                      #END
    #IF(#TEXT(pContact_fname)<>'')     SELF.fname:=LEFT.pContact_fname;               #END
    #IF(#TEXT(pContact_mname)<>'')     SELF.mname:=LEFT.pContact_mname;               #END
    #IF(#TEXT(pContact_lname)<>'')     SELF.lname:=LEFT.pContact_lname;               #END
    #IF(#TEXT(pSource)<>'')            SELF.source:=LEFT.pSource;                     #END
    #IF(#TEXT(pSource_record_id)<>'')  SELF.source_record_id:=LEFT.pSource_record_id; #END
    #IF(#TEXT(phone_field)<>'')        SELF.company_phone:=LEFT.phone_field;          #END
    #IF(#TEXT(fein_field)<>'')         SELF.company_fein:=LEFT.fein_field;            #END
    #IF(#TEXT(pURL)<>'')               SELF.company_url:=LEFT.pURL;                   #END
    #IF(#TEXT(pContact_ssn)<>'')       SELF.contact_ssn:=LEFT.pContact_ssn;           #END
    #IF(#TEXT(pEmail)<>'')             SELF.contact_email:=LEFT.pEmail;               #END
    SELF:=[];
  ));
  // For testing on the 190, change "roxiecertossvip.sc.seisint.com:9876" to "roxiedevvip.sc.seisint.com:9876"
  #UNIQUENAME(dResults)
  %dResults%:=PIPE(%dInputFormatted%,
    'roxiepipe -iw '+ SIZEOF(%lBatchInput%)+' -t 1 -ow '+ SIZEOF(%lBatchOutput%)+' -b 1000 -mr 2 -h roxiecertossvip.sc.seisint.com:9876 -vip -r Results '+
    '-q "<BizLinkFull.svcbatch format=\'raw\'><best_level>FULLRESULTS</best_level><batch_in id=\'id\' format=\'raw\'></batch_in></BizLinkFull.svcbatch>"',
    %lBatchOutput%);
  // The #IF block below is a manual force on address elements if those fields
  // are present in the call
  Outfile2:=JOIN
  (
    %dInputSequenced%,
    %dResults%,
    LEFT.%_uid%=RIGHT.acctno
      #if('A' in matchset)
        AND
        ( 
          (LEFT.prange_field <> '' AND LEFT.prange_field = RIGHT.prim_Range) OR NOT
          (
            (LEFT.prange_field <> '' AND RIGHT.prim_range <> '' AND NOT SALT28.WithinEditN(LEFT.prange_field,RIGHT.prim_range,1)) OR
            (LEFT.pname_field <> '' AND RIGHT.prim_name <> '' AND NOT SALT28.WithinEditN(LEFT.pname_field,RIGHT.prim_name,1))
          )
        )
      #end
    ,TRANSFORM(outrec,
      SELF.proxweight:=RIGHT.weight;
      SELF.proxscore:=RIGHT.score;
      SELF.proxid:=RIGHT.proxid;
      SELF.seleid := right.seleid;
      SELF.orgid := RIGHT.orgid;
      SELF.ultid := RIGHT.ultid;      
      SELF:=LEFT;),LEFT OUTER
  );
#ELSE
import BIPV2_Company_Names, BizLinkFull,ut,_Control;
//add counter
#uniquename(zipset)
#uniquename(infilec)
#uniquename(outfile1)
#uniquename(infilecnp)
%infilec% :=
project(
  infile,
  transform(
    {infile, unsigned6 cntr, DATASET(BizLinkFull.Process_Biz_layouts.layout_zip_cases) %zipset%},
    self.cntr := counter,
    self.%zipset% :=
      #if('A' in matchset)
        If(left.zip_field <> '', DATASET([{left.zip_field,100}],BizLinkFull.Process_Biz_layouts.layout_zip_cases), DATASET([],BizLinkFull.Process_Biz_layouts.layout_zip_cases));
      #else
        DATASET([],BizLinkFull.Process_Biz_layouts.layout_zip_cases);
      #end
    self := left
  )
) /*:  //CAUSING BDID TO RUN TWICE!
success(
  Business_Header_SS.LogEmail(
    'started','',infile,matchset,keep_count,score_threshold,pFileVersion,pUseOtherEnvironment,pSetLinkingVersions
  )
)*/;
//clean up company names
BIPV2_Company_Names.functions.mac_go(%infilec%,%infilecnp%,cntr,company_name_field,,FALSE);
//decide whether to use keyed or pulled joins
#uniquename(force)
#uniquename(NodesUnder400)
#uniquename(InfileSmall)
#uniquename(ThorForced)
#uniquename(useKeyedJoins)
string4 %force% := '' : stored('did_add_force');
boolean %NodesUnder400% := thorlib.nodes() < 400;
boolean %InfileSmall% := count(infile) < 10000000;
boolean %ThorForced% := %force% = 'thor';
%useKeyedJoins% := (%NodesUnder400% /*or %InfileSmall%*/) and not %ThorForced%;  //motivated by bug 112406
//if version 3 selected, go bleeding edge route
#if(BIPV2.IDconstants.xlink_version_BIP_dev in pSetLinkingVersions)
  // BIPV2_xLink.MAC_MEOW_Biz_Batch(
  Business_Header_SS.MAC_MEOW_Biz_Batch_version_BIP_dev(
  // new (infile,Ref='',Input_parent_proxid = '',Input_ultimate_proxid = '',Input_has_lgid = '',Input_empid = '',Input_powid = '',Input_orgid = '',Input_ultid = '',Input_pSource = '',Input_pSource_record_id = ''
  // ,Input_company_name = '',Input_cnp_name = '',Input_company_phone = '',Input_company_fein = '',Input_company_sic_code1 = '',Input_prim_range = '',Input_prim_name = '',Input_sec_range = '',
  // Input_p_city_name = '',Input_st = '',Input_zip = '',Input_company_url = '',Input_isContact = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',
  // Input_contact_email = '',Input_CONTACTNAME = '',Input_STREETADDRESS = '',OutFile,AsIndex='true',Stats='') := MACRO
  // old (infile,Ref='',Input_empid = '',Input_powid = '',Input_orgid = '',Input_ultid = '',Input_pSource = '',Input_pSource_record_id = '',Input_company_name = '',Input_cnp_name = '',Input_company_phone = '',Input_company_fein = '',Input_company_sic_code1 = '',Input_company_prim_range = '',Input_company_prim_name = '',Input_company_sec_range = '',Input_company_p_city_name = '',Input_company_st = '',Input_company_zip5 = '',Input_company_url = '',Input_isContact = '',Input_contact_title = '',Input_contact_fname = '',Input_contact_mname = '',Input_contact_lname = '',Input_contact_name_suffix = '',Input_contact_email = '',OutFile,AsIndex='true',Stats='') := MACRO
    %infilecnp%             //infile
    ,cntr                   //Ref=''
    ,                       //Input_parent_proxid = ''
    ,                       //Input_ultimate_proxid = ''
    ,                       //Input_has_lgid = ''
    ,                       //Input_empid = ''
    ,                       //,Input_powid = ''
    ,                       //Input_orgid = ''
    ,                       //Input_ultid = ''
    ,                       //Input_pSource = ''
    ,                       //Input_pSource_record_id = ''
    ,company_name_field     //Input_company_name = ''  //not sure why/if we need both
    ,cnp_name               //Input_cnp_name = ''
    #if('P' in matchset)
      ,phone_field        //Input_company_phone = ''
    #else 
      ,   
    #end  
    #if('F' in matchset)
      ,fein_field           //Input_company_fein = ''
    #else 
      ,   
    #end  
    ,                       //Input_company_sic_code1 = ''
    #if('A' in matchset)
      ,prange_field           //Input_company_prim_range = ''
      ,pname_field            //Input_company_prim_name = ''
      ,srange_field           //Input_company_sec_range = ''
      ,pCity                  //Input_company_p_city_name = ''
      ,state_field            //Input_company_st = ''
      ,%zipset%               //Input_company_zip5 = ''
    #else 
      ,,,,,   
    #end  
    ,                       //Input_company_url
    ,                       //Input_isContact = ''
    ,                       //Input_contact_title = ''
    ,pContact_fname         //Input_contact_fname = ''
    ,pContact_mname         //Input_contact_mname = ''
    ,pContact_lname         //Input_contact_lname = ''
    ,                       //Input_contact_name_suffix = ''
    ,                       //Input_contact_email
    ,cnp_number             //Input_cnp_number = ''
    ,cnp_btype              //Input_cnp_btype = ''
    ,cnp_lowv               //Input_cnp_lowv = '',    
    
    ,                       //Input_CONTACTNAME = ''
    ,                       //Input_STREETADDRESS = ''
    ,%OutFile1%             //OutFile
    ,%useKeyedJoins%        //AsIndex='true'
    ,                       //Stats=''
  )
  
  #uniquename(outnorm)
  %outnorm% :=
  normalize(
    %OutFile1%(results[1].score >= (integer)score_threshold), //filter not necessary here, but might save some work
    (integer)keep_count,
    transform(
      {%OutFile1%.reference, %OutFile1%.results.proxid, %OutFile1%.results.weight, %OutFile1%.results.score},
      self.reference := left.reference;
      self.proxid := left.results[counter].proxid;
      self.weight := left.results[counter].weight;
      self.score := left.results[counter].score;
    )
  )(score >= (integer)score_threshold);
  // output(%outnorm%, named('outnorm'));
    
  #uniquename(outfile20);
  %outfile20% :=
  join(
    %infilec%,
    // %OutFile1%(results[1].score >= (integer)score_threshold),
    %outnorm%,
    left.cntr = right.reference,
    transform(
      outrec, 
      
      //*** Real values
      self.dotid := 0;//right.results[1].dotid,
      self.dotweight := 0;//right.results[1].weight,
      self.dotscore := 0;//right.results[1].score,
      
      self.proxid := right.proxid;//if(right.results[1].proxid > 0, right.results[1].proxid, right.results[1].dotid), //some mysterious blanks under investigation
      self.proxweight := right.weight;
      self.proxscore := right.score;
      
      //*** Faked out values
      self.orgid := if(right.results[1].orgid > 0, right.results[1].orgid, self.proxid);
      self.orgweight := self.proxweight,
      self.orgscore := self.proxscore,
      
      self.ultid := if(right.results[1].ultid > 0, right.results[1].ultid, self.proxid);
      self.ultweight := self.proxweight,
      self.ultscore := self.proxscore,  
      
      //*** Empty values
      
      self.empid := 0,
      self.empweight := 0,
      self.empscore := 0,   
      self.powid := 0,
      self.powweight := 0,
      self.powscore := 0,   
      
      self := left,
    ),
    left outer
  );
  // Business_Header_SS.LogEmail(  //CAUSING BDID TO TRUN TWICE - actually, i think it was just the one at the start, but i dont need this on anyway.
      // 'finished',
      // 'count(%outfile20%(dotid > 0)): ' + count(%outfile20%(dotid > 0)) + '\n' +
      // 'count(%outfile20%(proxid > 0)): ' + count(%outfile20%(proxid > 0)) + '\n' +
      // 'count(%outfile20%(orgid > 0)): ' + count(%outfile20%(orgid > 0)) + '\n' +
      // 'count(%outfile20%(ultid > 0)): ' + count(%outfile20%(ultid > 0)) + '\n' +
      // 'count(%outfile20%(empid > 0)): ' + count(%outfile20%(empid > 0)) + '\n' +
      // 'count(%outfile20%(powid > 0)): ' + count(%outfile20%(powid > 0)) + '\n' ,
      // infile,matchset,keep_count,score_threshold,pFileVersion,pUseOtherEnvironment,pSetLinkingVersions
    // ); 
  outfile2 := %outfile20%; //USE OF SUCCES AND FAILURE HERE CAUSES AN EXTRA LINKING GRAPH (W20130204-090200)
#else
  Business_Header_SS.MAC_MEOW_Biz_Batch_version_BIP(
    %infilecnp%             //infile
    ,cntr                   //Ref=''
    ,                       //Input_SELEid = ''
    ,                       //Input_orgid = ''
    ,                       //Input_ultid = ''
    ,pSource_record_id       //Input_pSource_record_id = ''
    #if('P' in matchset)
      ,phone_field        //Input_company_phone = ''
    #else 
      ,
    #end
    #if('F' in matchset)
      ,fein_field           //Input_company_fein = ''
    #else 
      ,
    #end
    ,                       //Input_company_url = ''
    ,company_name_field     //Input_company_name = ''  //not sure why/if we need both
    ,cnp_number             //Input_cnp_number
    ,cnp_btype              //Input_cnp_btype
    ,cnp_lowv             //Input_cnp_lowv
    ,cnp_name               //Input_cnp_name = ''
    ,                       //Input_CONTACTNAME
    ,                       //Input_STREETADDRESS
    #if('A' in matchset)
      ,pname_field            //Input_company_prim_name = ''  
      ,%zipset%               //Input_company_zip5 = ''     
      ,prange_field           //Input_company_prim_range = ''
      ,srange_field           //Input_sec_range = ''
      ,pCity                  //Input_company_p_city_name = ''
    #else 
      ,,,,,   
    #end  
    ,                       //Input_company_sic_code1
    ,pContact_lname         //Input_contact_lname = ''
    ,pContact_mname         //Input_contact_mname = ''
    ,pContact_fname         //Input_contact_fname = ''
    ,                       //Input_contact_name_suffix = ''
    #if('A' in matchset)
      ,state_field          //Input_st = ''
    #else 
      , 
    #end
    ,pSource                 //Input_pSource = ''
    ,                       //Input_isContact
    ,                       //Input_title
    
    ,                       //Input_parent_proxid = ''
    ,                       //Input_ultimate_proxid = ''
    ,                       //Input_has_lgid = ''
    ,                       //Input_empid = ''
    ,                       //Input_powid = ''
    ,pContact_ssn            //Input_pContact_ssn = ''        // ****     NEEDS NEW VERSION OF BizLinkFull
    ,                       //Input_contact_email = ''
    ,src_matching_is_priority                               // ****     WE CAN DROP THIS HERE FOR NOW SINCE WE ARENT USING IT YET
    
    ,%OutFile1%             //OutFile
    ,%useKeyedJoins%        //AsIndex='true'
    ,                       //Stats=''
    ,bGetAllScores
  )
  
  // output(%OutFile1%, named('OutFile1'));
  #uniquename(outnorm)
  %outnorm% :=
  normalize(
    %OutFile1%((results[1].score >= (integer)score_threshold or results_ultid[1].score >= (integer)score_threshold), (results[1].proxid > 0 or results_ultid[1].ultid > 0)), //filter not necessary here, but might save some work
    (integer)keep_count,
    transform(
      {%OutFile1%.reference, %OutFile1%.results.proxid, %OutFile1%.results.weight, %OutFile1%.results.score, %OutFile1%.results.seleid, %OutFile1%.results.orgid, %OutFile1%.results.ultid, %OutFile1%.results.powid
      , unsigned4 seleweight, unsigned4 selescore, unsigned4 orgweight, unsigned4 orgscore, unsigned4 ultweight, unsigned4 ultscore, UNSIGNED4 powweight, UNSIGNED4 powscore
        //part 1 of 2 of the street force hack, but not harmful if left in 
        ,%OutFile1%.results.prim_Range, %OutFile1%.results.prim_Rangeweight, %OutFile1%.results.prim_name, %OutFile1%.results.prim_nameweight
        //end hack
        ,%OutFile1%.results.cnp_nameweight
      },
      PG := left.results[counter].score >= (integer)score_threshold;
      SG := PG or left.results_seleid[counter].score >= (integer)score_threshold;
      OG := SG or left.results_orgid[counter].score >= (integer)score_threshold;
      UG := OG or left.results_ultid[counter].score >= (integer)score_threshold;
      POWG := UG or left.results_powid[counter].score >= (integer)score_threshold;
      self.reference := left.reference;
      
      self.weight := if(PG,left.results[counter].weight,0);
      self.score := if(PG,left.results[counter].score,0);
      self.proxid := if(PG,left.results[counter].proxid,0);
      
      self.seleweight := if(SG,left.results_seleid[counter].weight,0);
      self.selescore  := if(SG,left.results_seleid[counter].score,0);
      self.seleid := if(SG,IF(left.results_seleid[counter].seleid=0,LEFT.results[COUNTER].seleid,left.results_seleid[counter].seleid),0);
      
      self.orgweight := if(OG,left.results_orgid[counter].weight,0);
      self.orgscore := if(OG,left.results_orgid[counter].score,0);
      self.orgid := if(OG,IF(left.results_orgid[counter].orgid=0,LEFT.results[COUNTER].orgid,left.results_orgid[counter].orgid),0);
      
      self.ultweight := if(UG,left.results_ultid[counter].weight,0);
      self.ultscore := if(UG,left.results_ultid[counter].score,0);
      self.ultid := if(UG,IF(left.results_ultid[counter].ultid=0,LEFT.results[COUNTER].ultid,left.results_ultid[counter].ultid),0);
      
      self.powweight := if(UG,left.results_powid[counter].weight,0);
      self.powscore := if(UG,left.results_powid[counter].score,0);
      self.powid := if(UG,IF(left.results_powid[counter].powid=0,LEFT.results[COUNTER].powid,left.results_powid[counter].powid),0);
      self:= left.results[counter];    
    )
  )((score >= (integer)score_threshold or ultscore >= (integer)score_threshold), (proxid > 0 or ultid > 0));// proxid > 0 also because of case where threshold is zero (without this you get keep_count records even with no IDs on them)
  #uniquename(outfile20);
  %outfile20% :=
  join(
    %infilec%,
    // %infilecnp%,        //THIS COULD VERY WELL BE A DISASTER!!!!!!! 
    %outnorm%,
    left.cntr = right.reference
    
        //part 2 of 2 of the street force hack - SLIGHTLY HARMFUL IF LEFT IN
        //v1
        // and not(
        // (left.prange_field <> '' and right.prim_Range <> '' and right.prim_Rangeweight <= 0)
        // OR
        // (left.pname_field <> '' and right.prim_name <> '' and right.prim_nameweight <= 0)
        // )
        
        //v2
        #if('A' in matchset)
          and( 
            (left.prange_field <> '' and left.prange_field = right.prim_Range) //exact nonblank pr match
            or not(                                                            //or just not a complete miss on both pr and pn
              (left.prange_field <> '' and right.prim_Range <> '' and right.prim_Rangeweight <= 0)
              OR
              (left.pname_field <> '' and right.prim_name <> '' and right.prim_nameweight <= 0)
            )
          )
        #end
        
    
    ,transform(
      outrec, 
      
      //*** Real values
      self.proxid := right.proxid;
      self.proxweight := right.weight;
      self.proxscore := right.score;
      //*** Faked out values
      self.seleID := right.SELEid;
      self.SELEweight := right.SELEweight, 
      self.SELEscore := right.SELEscore,       
      
      self.orgid := right.orgid;
      self.orgweight := right.orgweight,  
      self.orgscore := right.orgscore,
      
      self.ultid := right.ultid;
      self.ultweight := right.ultweight,  
      self.ultscore := right.ultscore,  
      
      self.powid := RIGHT.powid,
      self.powweight := RIGHT.powweight,
      self.powscore := RIGHT.powscore,   
      
      //*** Empty values
      self.dotid := 0;
      self.dotweight := 0;
      self.dotscore := 0;
      
      self.empid := 0,
      self.empweight := 0,
      self.empscore := 0,   
            
      self := left
      
    ),
    hash,       //the LHS hasnt moved, so there may be more clever way to distribute RHS, but it would involve using something more than just counter as the reference
    left outer
  );
  
  // Business_Header_SS.LogEmail(  //this call still causing problems for vehicle and possibly foreclosure
      // 'finished',
      // 'count(%outfile20%(dotid > 0)): ' + count(%outfile20%(dotid > 0)) + '\n' +
      // 'count(%outfile20%(proxid > 0)): ' + count(%outfile20%(proxid > 0)) + '\n' +
      // 'count(%outfile20%(orgid > 0)): ' + count(%outfile20%(orgid > 0)) + '\n' +
      // 'count(%outfile20%(ultid > 0)): ' + count(%outfile20%(ultid > 0)) + '\n' +
      // 'count(%outfile20%(empid > 0)): ' + count(%outfile20%(empid > 0)) + '\n' +
      // 'count(%outfile20%(powid > 0)): ' + count(%outfile20%(powid > 0)) + '\n'  ,
      // infile,matchset,keep_count,score_threshold,pFileVersion,pUseOtherEnvironment,pSetLinkingVersions
    // );  
// output(CHOOSEN(%infilec%, 50), named('infilec'));
// output(CHOOSEN( %outnorm%, 50), named('outnorm'), extend);
// output(CHOOSEN( %outfile20%, 50), named('outfile20'), extend);
// output(keep_count, named('keep_count'));
// output(CHOOSEN(%OutFile1%, 50), named('OutFile1'), extend);
// output(CHOOSEN(%OutFile1%(results[1].weight < results_ultid[1].weight), 50), named('OutFile1_weight_diff'), extend);
// output(CHOOSEN(%OutFile1%(results[1].score < results_ultid[1].score), 50), named('OutFile1_score_diff'), extend);
// output(CHOOSEN(%OutFile1%(results[1].weight > results_ultid[1].weight), 50), named('OutFile1_weight_diff_backwards'), extend);
// output(CHOOSEN(%OutFile1%(results[1].score > results_ultid[1].score), 50), named('OutFile1_score_diff_backwards'), extend);
  outfile2 := %outfile20%/* : //USE OF SUCCES AND FAILURE HERE CAUSES AN EXTRA LINKING GRAPH (W20130204-090200)
  success(
    Business_Header_SS.LogEmail(
      'finished',
      'count(%outfile20%(dotid > 0)): ' + count(%outfile20%(dotid > 0)) + '\n' +
      'count(%outfile20%(proxid > 0)): ' + count(%outfile20%(proxid > 0)) + '\n' +
      'count(%outfile20%(orgid > 0)): ' + count(%outfile20%(orgid > 0)) + '\n' +
      'count(%outfile20%(ultid > 0)): ' + count(%outfile20%(ultid > 0)) + '\n' +
      'count(%outfile20%(empid > 0)): ' + count(%outfile20%(empid > 0)) + '\n' +
      'count(%outfile20%(powid > 0)): ' + count(%outfile20%(powid > 0)) + '\n'  ,
      infile,matchset,keep_count,score_threshold,pFileVersion,pUseOtherEnvironment,pSetLinkingVersions
    )
  ),
  failure(
    Business_Header_SS.LogEmail(
      'FAILED','',infile,matchset,keep_count,score_threshold,pFileVersion,pUseOtherEnvironment,pSetLinkingVersions
    ) 
  )*/;
#end;
// !!!! NEED TO RESPECT keep_count AND THRESHOLD on diff levels (currently, just on dot)
#END
// output(choosen(%infilec%, 200), named('infilec'));
// output(choosen(%outfile20%, 200), named('outfile20'));
// output(%outfHasSELE%, named('outfHasSELE'));
// output(score_threshold, named('score_threshold'));
ENDMACRO;
