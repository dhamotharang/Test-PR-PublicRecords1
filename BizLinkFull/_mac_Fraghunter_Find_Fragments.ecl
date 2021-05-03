import BizLinkFull;

EXPORT _mac_Fraghunter_Find_Fragments(

   pInput_Ids   = 'DATASET([],{unsigned6 proxid})'  //or seleids
  ,pId          = 'proxid'
  ,pKey_Payload = 'BizLinkFull.Process_Biz_Layouts.key'
  
) := 
functionmacro

  IMPORT SALT44;
  
  // -- Set Template vars, id source(id number 1)
  #uniquename(hdrkey  )
  #uniquename(IDSource)

  #SET(IDSource ,trim(#TEXT(pId)) + 'Source')
  
  // -- Get full payload xlink key
	%hdrkey% := PULL(pKey_Payload);

  // -- add uniqueid for tracking
  p_hdr := PROJECT(pInput_Ids ,transform({unsigned6 uniqueid,unsigned6 pId} ,self.uniqueid := counter ,self := left ));
  
	//Pull header data for each proxid
	x_hdr := JOIN(  DISTRIBUTE(%hdrkey% ,pId) ,DISTRIBUTE(p_hdr ,pId  ) ,LEFT.pId = RIGHT.pId ,TRANSFORM({unsigned6 uniqueid,recordof(left)}  ,SELF.uniqueid := RIGHT.uniqueid  ,SELF := LEFT ),LOCAL);
	
	//Propagate fields
  DSAfter_cnp_btype         := SALT44.MAC_Field_Prop_Do(x_hdr                ,cnp_btype          ,pId);
  DSAfter_company_fein      := SALT44.MAC_Field_Prop_Do(DSAfter_cnp_btype    ,company_fein       ,pId);
  DSAfter_company_sic_code1 := SALT44.MAC_Field_Prop_Do(DSAfter_company_fein ,company_sic_code1  ,pId);
	
	//Find fragments
  SmallJob      := TRUE;
  InUpdateIDs   := FALSE;
  GetAllScores  := TRUE ;
  DisableForce  := FALSE;
  DoClean       := TRUE ;
  // Mapping := 'UniqueID:rcid,zip_cases:zip';
  Mapping := 'zip_cases:zip';

  MyInfile := SALT44.FromFlat(DSAfter_company_sic_code1,BizLinkFull.Process_Biz_Layouts.InputLayout,Mapping);

  BizLinkFull.MAC_Meow_Biz_Batch(
     MyInfile,UniqueId,/* MY_proxid */,/* MY_seleid */,/* MY_orgid */,/* MY_ultid */
    ,parent_proxid  ,sele_proxid        ,org_proxid           ,ultimate_proxid,has_lgid         ,empid              ,source     ,source_record_id
    ,source_docid   ,company_name       ,company_name_prefix  ,cnp_name       ,cnp_number       ,cnp_btype          ,cnp_lowv   ,company_phone
    ,company_phone_3,company_phone_3_ex ,company_phone_7      ,company_fein   ,company_sic_code1,active_duns_number
    ,prim_range     ,prim_name          ,sec_range            ,city           ,city_clean       ,st,zip_cases       ,company_url,isContact    ,contact_did  ,title
    ,fname          ,fname_preferred    ,mname,lname          ,name_suffix    ,contact_ssn      ,contact_email      ,sele_flag  ,org_flag     ,ult_flag
    ,fallback_value ,CONTACTNAME        ,STREETADDRESS        ,OutFile        ,SmallJob         ,InUpdateIDs        ,Stats      ,GetAllScores ,DisableForce
    ,DoClean
  );

	out_appended := JOIN(p_hdr,Outfile,LEFT.uniqueid=RIGHT.reference,TRANSFORM({recordof(right),unsigned6 %IDSource%}
    ,SELF.%IDSource%      := LEFT.pId
    ,SELF.results         := RIGHT.results          
    ,self.results_seleid  := right.results_seleid
    ,self.results_orgid   := right.results_orgid
    ,self.results_powid   := right.results_powid
    ,self.results_ultid   := right.results_ultid
    ,self.reference       := right.reference
  ),hash,LEFT OUTER);

  set_p_hdr_uniqueids   := set(topn(p_hdr  ,10,uniqueid )  ,uniqueid );
  set_Outfile_uniqueids := set(topn(Outfile,10,reference)  ,reference);
  
  export debug_fraghunter := parallel(
    output(choosen(pInput_Ids                 ,300),named('BizLinkFull_Biz_Fraghunter_V1_pInput_Ids'                ),all)
   ,output(choosen(%hdrkey%                   ,300),named('BizLinkFull_Biz_Fraghunter_V1_hdr'                       ),all)
   ,output(choosen(p_hdr                      ,300),named('BizLinkFull_Biz_Fraghunter_V1_p_hdr'                     ),all)
   ,output(choosen(x_hdr                      ,300),named('BizLinkFull_Biz_Fraghunter_V1_x_hdr'                     ),all)
   ,output(choosen(DSAfter_cnp_btype          ,300),named('BizLinkFull_Biz_Fraghunter_V1_DSAfter_cnp_btype'         ),all)
   ,output(choosen(DSAfter_company_fein       ,300),named('BizLinkFull_Biz_Fraghunter_V1_DSAfter_company_fein'      ),all)
   ,output(choosen(DSAfter_company_sic_code1  ,300),named('BizLinkFull_Biz_Fraghunter_V1_DSAfter_company_sic_code1' ),all)
   ,output(choosen(MyInfile                   ,300),named('BizLinkFull_Biz_Fraghunter_V1_MyInfile'                  ),all)
   ,output(choosen(Outfile                    ,100),named('BizLinkFull_Biz_Fraghunter_V1_Outfile'                   ),all)
   ,output(choosen(out_appended               ,100),named('BizLinkFull_Biz_Fraghunter_V1_out_appended'              ),all)
   ,output(set_p_hdr_uniqueids                     ,named('BizLinkFull_Biz_Fraghunter_V1_set_p_hdr_uniqueids'       ),all)
   ,output(set_Outfile_uniqueids                   ,named('BizLinkFull_Biz_Fraghunter_V1_set_Outfile_uniqueids'     ),all)
  );
	
	return when(out_appended  ,debug_fraghunter);
	
endmacro;