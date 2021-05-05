/*--SOAP--
<message name="How_Did_This_Link_Service">
<part name="id_value"   type="xsd:string"/>
<part name="regexname1" type="xsd:string"/>
<part name="regexname2" type="xsd:string"/>
<part name="id_name"    type="xsd:string"/>
<part name="keyversion" type="xsd:string"/>
</message>
*/
/*--INFO-- Compare two IDs to see if they should be joined.<p>If it is easier you may place the two IDs on the first line and they will be parsed into first and second.</p>*/
EXPORT How_Did_This_Link_Service := 
MACRO


  IMPORT BIPV2_Tools,BIPV2,Bizlinkfull,ut,BIPV2_Proxid,SALT311,tools,BIPV2_Build;

  string id_value    := ''        : stored('id_value'  ) ;
  string regexname1  := ''        : stored('regexname1') ;
  string regexname2  := ''        : stored('regexname2') ;
  // string id_name     := 'seleid'  : stored('id_name'   ) ;
  string keyversion  := 'qa'      : stored('keyversion') ;

  // #workunit('name'  ,my_id_type + ': ' + (string)my_id + ' ' + regexname1 + ',' + regexname2 + ' how did this link');

  BIPV2_Tools.mac_How_Did_This_Link(
     (unsigned6)id_value 
    ,regexname1 
    ,regexname2                        
    // ,pID_Type             := #EXPAND(id_name)
    ,pLinkids_key         := BIPV2_Build.BIPV2FullKeys_Package(keyversion).linkids.logical
    ,pLinkids_key_hidden  := BIPV2_Build.BIPV2FullKeys_Package(keyversion).linkids_hidden.logical
    ,pKeyproxidUp         := BIPV2_Build.BIPV2FullKeys_Package(keyversion).Xlinksup_proxid.logical
    ,pKeyseleidUp         := BIPV2_Build.BIPV2FullKeys_Package(keyversion).Xlinksup_seleid.logical
  );

  // STRING50 LGID3onestr := ''  : STORED('LGID3One');
  // STRING20 LGID3twostr := '*'  : STORED('LGID3two');
  // BIPV2_LGID3._fn_CompareService((unsigned6)LGID3onestr,(unsigned6)LGID3twostr);
  
ENDMACRO;