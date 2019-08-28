IMPORT ut,VersionControl,RoxieKeyBuild,AutokeyB2,promotesupers, PRTE2_Common, _control, PRTE;

EXPORT proc_build_keys(string filedate) := FUNCTION

  RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_domains.keys.key_bdid	     ,constants.KeyName_InternetServices+'bdid'   ,constants.KeyName_InternetServices + filedate + '::bdid'	  ,BuildRoxiebdidKey);		
  RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_domains.keys.key_did	       ,constants.KeyName_InternetServices+'did'    ,constants.KeyName_InternetServices + filedate + '::did'	  ,BuildRoxiedidKey);		
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_domains.keys.key_domain	   ,constants.KeyName_InternetServices+'domain' ,constants.KeyName_InternetServices + filedate + '::domain' ,BuildRoxieDomainKey);	
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_domains.keys.key_id	       ,constants.KeyName_InternetServices+'id'     ,constants.KeyName_InternetServices + filedate + '::id'	    ,BuildRoxieIDKey);	
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_domains.keys.Key_LinkIds.key,constants.KeyName_InternetServices+'LinkIds',constants.KeyName_InternetServices + filedate + '::LinkIds',BuildRoxieLinkIdsKey);	

	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(constants.KeyName_InternetServices + '@version@::bdid'   ,constants.KeyName_InternetServices + filedate + '::bdid'	 ,MoveRoxieBdid2Built);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(constants.KeyName_InternetServices + '@version@::did'    ,constants.KeyName_InternetServices + filedate + '::did'    ,MoveRoxieDid2Built);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(constants.KeyName_InternetServices + '@version@::domain' ,constants.KeyName_InternetServices + filedate + '::domain' ,MoveRoxieDomain2Built );
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2(constants.KeyName_InternetServices + '@version@::id'     ,constants.KeyName_InternetServices + filedate + '::id'     ,MoveRoxieID2Built );
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(constants.KeyName_InternetServices + '@version@::LinkIds',constants.KeyName_InternetServices + filedate + '::LinkIds',MoveRoxieLinkIds2Built ); 

	RoxieKeyBuild.Mac_SK_Move_V2(constants.KeyName_InternetServices + '@version@::bdid'   ,'Q',MoveRoxiebdid2QA   ,2);	
	RoxieKeyBuild.Mac_SK_Move_V2(constants.KeyName_InternetServices + '@version@::did'    ,'Q',MoveRoxiedid2QA    ,2);
	RoxieKeyBuild.Mac_SK_Move_V2(constants.KeyName_InternetServices + '@version@::domain' ,'Q',MoveRoxiedomain2QA ,2);
	RoxieKeyBuild.Mac_SK_Move_V2(constants.KeyName_InternetServices + '@version@::id'     ,'Q',MoveRoxieid2QA     ,2);
	RoxieKeyBuild.Mac_SK_Move_V2(constants.KeyName_InternetServices + '@version@::LinkIds','Q',MoveRoxieLinkIds2QA,2);


	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_domains.keys.Key_Whois_Bdid		   ,constants.KeyName_WhoIs + 'bdid'   ,constants.KeyName_WhoIs + filedate + '::bdid'   ,BuildBdidKey);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_domains.keys.Key_Whois_Did		     ,constants.KeyName_WhoIs + 'did'    ,constants.KeyName_WhoIs + filedate + '::did' 	  ,BuildDidKey);	
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_domains.keys.key_whois_domain	   ,constants.KeyName_WhoIs + 'domain' ,constants.KeyName_WhoIs + filedate + '::domain' ,BuildDomainKey);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(prte2_domains.keys.Key_Whois_LinkIds.key,constants.KeyName_WhoIs + 'LinkIds',constants.KeyName_WhoIs + filedate + '::LinkIds',BuildLinkIdsKey);	

	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(constants.KeyName_WhoIs + '@version@::bdid'   ,constants.KeyName_WhoIs + filedate + '::bdid'	 ,MoveBdid2Built);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(constants.KeyName_WhoIs + '@version@::did'    ,constants.KeyName_WhoIs + filedate + '::did'		 ,MoveDid2Built);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(constants.KeyName_WhoIs + '@version@::domain' ,constants.KeyName_WhoIs + filedate + '::domain' ,MoveDomain2Built);
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2(constants.KeyName_WhoIs + '@version@::LinkIds',constants.KeyName_WhoIs + filedate + '::LinkIds',MoveLinkIds2Built);

	RoxieKeyBuild.Mac_SK_Move_V2(constants.KeyName_WhoIs + '@version@::bdid'   ,'Q',MoveBDid2QA   ,2);
	RoxieKeyBuild.Mac_SK_Move_V2(constants.KeyName_WhoIs + '@version@::did'    ,'Q',MoveDid2QA 	  ,2);
	RoxieKeyBuild.Mac_SK_Move_V2(constants.KeyName_WhoIs + '@version@::domain' ,'Q',MoveDomain2QA ,2);
  RoxieKeyBuild.Mac_SK_Move_V2(constants.KeyName_WhoIs + '@version@::LinkIds','Q',MoveLinkIds2QA,2);	
 
  b := prte2_domains.files.file_whois_autokey;

  skip_set := prte2_domains.constants.ak_skipset;

  AutokeyB2.MAC_Build (b,
            fname,mname,lname, 
						zero, // SSN field
						zero,
						zero,
						prim_name,prim_range,state,v_city_name,zip,sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,
						did, // converted type of did_out to unsigned6
						compname,
						zero,
						zero,
						prim_name,prim_range,state,v_city_name,zip,sec_range,
						bdid,
						prte2_domains.constants.ak_keyname,
						prte2_domains.constants.ak_logicalname(filedate),
						outaction,false,
						skip_set,
						true,
						prte2_domains.constants.ak_typeStr,
						true,,,zero);

  AutoKeyB2.MAC_AcceptSK_to_QA(prte2_domains.constants.ak_keyname, mymove,, skip_set)

  retval := SEQUENTIAL(outaction,mymove);
 
	// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION  
    //flags for DOPS notification
    is_running_in_prod := PRTE2_Common.Constants.is_running_in_prod;  
 		notifyEmail					:= _control.MyInfo.EmailAddressNormal;
    NoUpdate 						:= OUTPUT('Skipping DOPS update because we are not in PROD'); 
		updatedops					:=	PRTE.UpdateVersion('WhoisKeys', filedate, notifyEmail,l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');
		
		PerformUpdateOrNot	:= IF(is_running_in_prod,updatedops,NoUpdate);
 
 	RETURN SEQUENTIAL(
                     BuildBdidKey	
                    ,BuildDidKey		
                    ,BuildDomainKey	
                    ,BuildLinkIdsKey
                    ,BuildRoxieIDKey
                    ,BuildRoxieDIDKey
                    ,BuildRoxieBDIDKey
                    ,BuildRoxieDomainKey
                    ,BuildRoxieLinkIdsKey
                    ,MoveBdid2Built
                    ,MoveDid2Built 		
                    ,MoveDomain2Built 
                    ,MoveLinkIds2Built 
                    ,MoveRoxieBdid2Built
                    ,MoveRoxieDid2Built 		
                    ,MoveRoxieDomain2Built 
                    ,MoveRoxieID2Built
                    ,MoveRoxieLinkIds2Built
                    ,MoveBDid2QA
                    ,Movedid2QA 	
                    ,MoveDomain2QA
                    ,MoveLinkIds2QA
                    ,MoveRoxiedid2QA 	
                    ,MoveRoxieBDid2QA 
                    ,MoveRoxieDomain2QA
                    ,MoveRoxieID2QA
                    ,MoveRoxieLinkIds2QA
                    ,retval
                    ,PerformUpdateOrNot
                  );
END;