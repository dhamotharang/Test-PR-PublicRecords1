IMPORT RoxieKeyBuild, AutoKeyB2, PRTE, _control, autokey, Business_Header_SS, business_header, ut, corp2, doxie, address, corp2_services, PRTE2_Common, Data_Services, doxie, BIPV2, Cortera, UT, PromoteSupers, std, Prte2, PRTE2_Cortera, Address, AID, AID_Support;

EXPORT Keys := MODULE


  //DEFINE THE INDEX
  EXPORT Attributes_Link_Id := INDEX(files.Key_attr (ultimate_linkID > 0) , {ULTIMATE_LINKID}, {files.Key_attr},
         Data_Services.Data_location.Prefix('DEFAULT')+ constants.key_prefix + doxie.Version_SuperKey + '::attr_linkid');


  EXPORT Header_Link_Id := INDEX(files.Key_hdr (link_id > 0), {link_id}, {files.Key_hdr},
         Data_Services.Data_location.Prefix('DEFAULT')+ constants.key_prefix + doxie.Version_SuperKey + '::hdr_linkid');

 
  EXPORT Exec_Link_Id := INDEX(files.execlinkid (link_id > 0), {link_id,persistent_record_id}, {files.execlinkid},
         Data_Services.Data_location.Prefix('DEFAULT')+ constants.key_prefix + doxie.Version_SuperKey + '::executive_linkid'); 
 
  	
  EXPORT LinkIds := MODULE
  
   //DEFINE THE INDEX
   EXPORT Cortera_LinkIds_Name := constants.KEY_PREFIX+doxie.Version_SuperKey+'::linkids';
   EXPORT Base  := Files.Key_hdr(COUNTRY='US');

   BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, Cortera_LinkIds_Name)
   EXPORT Key := k;


  //DEFINE THE INDEX ACCESS
   EXPORT kFetch(
                 dataset(BIPV2.IDlayouts.l_xlink_ids) inputs,
                 STRING1 Level = BIPV2.IDconstants.Fetch_Level_DotID,  //The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
                                                                       // Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
                                                                       // Should be enumerated or something?  at least need constants defined somewhere if you keep string1
                 UNSIGNED2 ScoreThreshold = 0                          //Applied at lowest leve of ID
                ) :=
  FUNCTION

    BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level)
    RETURN out;

  END;

    //DEFINE THE INDEX ACCESS
    EXPORT kFetch2(
                   dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs,
                   STRING1 Level = BIPV2.IDconstants.Fetch_Level_DotID,
                   UNSIGNED2 ScoreThreshold = 0,
                   joinLimit = 25000,
                   UNSIGNED1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
                  ) :=
           FUNCTION

    BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, out, Level, joinLimit, JoinType);
    RETURN out;
    END;

END;
END;