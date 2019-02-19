/*
3.	VERSION 1 OF AN ALGORITHM TO MEASURE DEGREE OF VANITY BETWEEN A LEXID AND BIP ENTITY.
The first version of this algorithm is complete, and pushed into production on  XX MM YYYY.   This algorithm delivers: 
XXM LexID Ã¢â‚¬â€œ ProxID 
XXM LexID - POWID
XXM LexID Ã¢â‚¬â€œ SELEID
XXM LexID Ã¢â‚¬â€œ OrgID
XXM LexID - UltID

*/
import bipv2_build,paw,bipv2,strata;

EXPORT mac_Vanity_Lexid_VS_BIP_ID(

   pversion     = 'bipv2.KeySuffix'                           // build date
  ,pBIP_Base    = 'bipv2.CommonBase.ds_built'
  ,pEmail_List  = 'BIPV2_Build.mod_email.emailList'           // email list 
  ,pIsTesting   = 'false'
  ,pOverwrite   = 'false'
  
) :=
functionmacro

  import bipv2_build,paw,bipv2,strata;
  
  ds_base_v := distribute(table(pBIP_Base(vanity_owner_did != 0),{vanity_owner_did,proxid, seleid, powid, orgid,ultid})) : independent;
  ds_base_c := distribute(table(pBIP_Base(contact_did      != 0),{contact_did     ,proxid, seleid, powid, orgid,ultid})) : independent;

  Proxids_with_vanity_Did   := table(ds_base_v  ,{unsigned6 did := vanity_owner_did ,proxid}  ,vanity_owner_did ,proxid ,merge);  // ,named('ProxidsWithVanityDid'));
  Seleids_with_vanity_Did   := table(ds_base_v  ,{unsigned6 did := vanity_owner_did ,seleid}  ,vanity_owner_did ,seleid ,merge);  // ,named('SeleidsWithVanityDid'));
  Powids_with_vanity_Did    := table(ds_base_v  ,{unsigned6 did := vanity_owner_did ,powid }  ,vanity_owner_did ,powid  ,merge);  // ,named('PowidsWithVanityDid' ));
  Orgids_with_vanity_Did    := table(ds_base_v  ,{unsigned6 did := vanity_owner_did ,orgid }  ,vanity_owner_did ,orgid  ,merge);  // ,named('OrgidsWithVanityDid' ));
  Ultids_with_vanity_Did    := table(ds_base_v  ,{unsigned6 did := vanity_owner_did ,ultid }  ,vanity_owner_did ,ultid  ,merge);  // ,named('UltidsWithVanityDid' ));

  Proxids_with_contact_Did  := table(ds_base_c  ,{unsigned6 did := contact_did      ,proxid}  ,contact_did      ,proxid ,merge);  // ,named('ProxidsWithContactDid'));
  Seleids_with_contact_Did  := table(ds_base_c  ,{unsigned6 did := contact_did      ,seleid}  ,contact_did      ,seleid ,merge);  // ,named('SeleidsWithContactDid'));
  Powids_with_contact_Did   := table(ds_base_c  ,{unsigned6 did := contact_did      ,powid }  ,contact_did      ,powid  ,merge);  // ,named('PowidsWithContactDid' ));
  Orgids_with_contact_Did   := table(ds_base_c  ,{unsigned6 did := contact_did      ,orgid }  ,contact_did      ,orgid  ,merge);  // ,named('OrgidsWithContactDid' ));
  Ultids_with_contact_Did   := table(ds_base_c  ,{unsigned6 did := contact_did      ,ultid }  ,contact_did      ,ultid  ,merge);  // ,named('UltidsWithContactDid' ));

  Proxids_with_both_dids  := table(Proxids_with_vanity_Did + Proxids_with_contact_Did ,{did ,proxid}  ,did  ,proxid ,merge);  
  Seleids_with_both_dids  := table(Seleids_with_vanity_Did + Seleids_with_contact_Did ,{did ,seleid}  ,did  ,seleid ,merge);  
  Powids_with_both_dids   := table(Powids_with_vanity_Did  + Powids_with_contact_Did  ,{did ,powid }  ,did  ,powid  ,merge);  
  Orgids_with_both_dids   := table(Orgids_with_vanity_Did  + Orgids_with_contact_Did  ,{did ,orgid }  ,did  ,orgid  ,merge);  
  Ultids_with_both_dids   := table(Ultids_with_vanity_Did  + Ultids_with_contact_Did  ,{did ,ultid }  ,did  ,ultid  ,merge);  
  
  ds_total := dataset([
  
     {'Proxid' ,count(Proxids_with_both_dids)  ,count(Proxids_with_vanity_Did)  ,count(Proxids_with_contact_Did)}
    ,{'Seleid' ,count(Seleids_with_both_dids)  ,count(Seleids_with_vanity_Did)  ,count(Seleids_with_contact_Did)}
    ,{'Powid'  ,count(Powids_with_both_dids )  ,count(Powids_with_vanity_Did )  ,count(Powids_with_contact_Did )}
    ,{'Orgid'  ,count(Orgids_with_both_dids )  ,count(Orgids_with_vanity_Did )  ,count(Orgids_with_contact_Did )}
    ,{'Ultid'  ,count(Ultids_with_both_dids )  ,count(Ultids_with_vanity_Did )  ,count(Ultids_with_contact_Did )}
    
  ],{string bip_id,unsigned countgroup,unsigned vanity_did,unsigned contact_did}) : independent;  //countgroup is a count of both dids deduped per BIP ID

  return Strata.macf_CreateXMLStats (ds_total ,'BIPV2','2.2'  ,pversion	,pEmail_List	,'VS_BIP_ID' ,'VANITY_LEXID'	,pIsTesting,pOverwrite);

endmacro;
