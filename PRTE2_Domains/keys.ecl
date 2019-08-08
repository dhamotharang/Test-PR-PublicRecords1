import doxie,bipv2,ut,Data_Services,autokeyb2,domains;

EXPORT keys := module

  EXPORT key_bdid := 
    INDEX(Files.file_key_bdid,
          {bdid},
          {Files.file_key_bdid}, 
          constants.KeyName_internetServices + doxie.Version_SuperKey + '::bdid');
  
  EXPORT key_did := 
    INDEX(Files.file_key_did,
          {did},
          {Files.file_key_did},
          constants.KeyName_internetServices + doxie.Version_SuperKey + '::did');																															
          
  EXPORT key_domain := 
    INDEX(Files.file_key_domain,
          {domain_name}, 
          {Files.file_key_domain},
          constants.KeyName_InternetServices + doxie.Version_SuperKey + '::domain');																																	
          
  EXPORT key_id := 
    INDEX(Files.file_key_id,
          {internetservices_id},
          {Files.file_key_id}, 
          constants.KeyName_InternetServices + doxie.Version_SuperKey + '::id');


  EXPORT Key_LinkIds := MODULE
    SHARED  base_recs 					:= files.file_key_linkids;
    EXPORT  out_logicalKeyName  := constants.KeyName_InternetServices+'qa::linkids'; // linkids Key Super FileName
    
    BIPV2.IDmacros.mac_IndexWithXLinkIDs(base_recs, out_key, out_logicalKeyName);
    EXPORT Key := out_key;
    
    //DEFINE THE INDEX ACCESS
    EXPORT KeyFetch(
      DATASET(BIPV2.IDlayouts.l_xlink_ids) in_ds_withids, 
      STRING1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
                                                           //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
                                                          //Should be enumerated or something?  at least need constants defined somewhere if you keep string1
      UNSIGNED2 ScoreThreshold = 0											 //Applied at lowest leve of ID
                  ) :=FUNCTION

      BIPV2.IDmacros.mac_IndexFetch(in_ds_withids, Key, out_fetch, Level)
      RETURN out_fetch;	
    END;

  END;

  EXPORT Key_Whois_Bdid := 
    INDEX(Files.file_key_whois_bdid,
          {bdid},
          {Files.file_key_whois_bdid},
          constants.KeyName_WhoIs + doxie.Version_SuperKey + '::bdid');
  
  EXPORT Key_Whois_Did := 
    INDEX(Files.file_key_whois_did,
          {d},
          {Files.file_key_whois_did},
          constants.KeyName_WhoIs + doxie.Version_SuperKey + '::did');
 
  EXPORT Key_Whois_Domain := 
      INDEX(Files.file_key_whois_domain,
            {dn},
            {Files.file_key_whois_domain},
            constants.KeyName_WhoIs + doxie.Version_SuperKey + '::domain');

  EXPORT Key_Whois_LinkIds := MODULE
    SHARED  base_recs 						:= files.file_key_linkids_whois;
    EXPORT  out_superfileKeyName  := constants.KeyName_WhoIs+'qa::linkids'; // linkids Key Super FileName

    BIPV2.IDmacros.mac_IndexWithXLinkIDs(base_recs, out_key, out_superfileKeyName);
    EXPORT Key := out_key;
    
    //DEFINE THE INDEX ACCESS
    EXPORT KeyFetch(
      DATASET(BIPV2.IDlayouts.l_xlink_ids) in_ds_withids, 
      STRING1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
                                                           //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
                                                          //Should be enumerated or something?  at least need constants defined somewhere if you keep string1
      UNSIGNED2 ScoreThreshold = 0											 //Applied at lowest leve of ID
                  ) :=FUNCTION

      BIPV2.IDmacros.mac_IndexFetch(in_ds_withids, Key, out_fetch, Level)
      RETURN out_fetch;	
    END;

  END;

  fakepf := DATASET([],RECORDOF(files.file_whois_autokey));           
  autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',did,bdid,constants.KeyName_InternetServices+'qa::autokey::Payload',plk,'');            
  EXPORT key_internetservices_AutoKeyPayload := plk;

end;