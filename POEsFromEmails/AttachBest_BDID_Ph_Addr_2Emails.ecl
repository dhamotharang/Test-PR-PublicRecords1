// AttachBest_BDID_Ph_Addr_2Emails.ecl
import Email_Data, Address, business_header, ut, mdr, Business_Header_SS, BIPV2;
#option('maxLength', 1310720); 				// have to increase for the remote directory child datasets

export AttachBest_BDID_Ph_Addr_2Emails (

   string                                                	pversion
  ,dataset(Email_Data.Layout_Email.base                	) pEmails      										= Email_Data.File_Email_Base
  ,dataset(business_header.Layout_Business_Header_base	)	pBHBaseFile											= business_header.files().base.business_headers.qa
  ,dataset(Business_Header.Layout_BH_Best								) pBHBestFile											= business_header.files().base.business_header_best.qa
  ,dataset(business_header.Layout_BH_Super_Group      	) pSGBaseFile											= business_header.files().base.Super_Group.qa
  ,dataset(layouts.EmailsWithRegistrantInfo  						) EmailsWithDomainRegistrantBDID	= POEsFromEmails.Add_DomainBDID_2Emails_With_Patterns()

) := function

  /*========================================================================================================
    Step1:
    Use Ã‚â€˜email_rec_keyÃ‚â€™ to get clean_address.geo_lat & geo_long (if these donÃ‚â€™t exists, use orig_zip
    & orig_zip4 to calculate person_addr_geo_lat and person_addr_geo_lat) for each email.
  ----------------------------------------------------------------------------------------------------------*/
  LatLonRec := RECORD
     typeof(pEmails.did) did;
     POEsFromEmails.layouts.EmailsWithRegistrantInfo;
  END;
	
  LatLonRec afixLatLon(EmailsWithDomainRegistrantBDID l, pEmails r) := TRANSFORM
  geo := fcn_zip9ToLatLong(r.clean_address.zip,r.clean_address.zip4);
  set of string LatLon := 
     IF( r.clean_address.geo_lat <> ''
         , [ r.clean_address.geo_lat, r.clean_address.geo_long ]
         , IF( geo='', [], [ geo[1..10], geo[11..20]] )
     );
     self.person_addr_geo_lat     := IF( LatLon=[], skip, (string10)LatLon[1]);
     self.person_addr_geo_long    := (string11)LatLon[2];
     self.did                     := r.did;
     self.person_addr.prim_range  := r.clean_address.prim_range;
     self.person_addr.prim_name   := r.clean_address.prim_name;
     self.person_addr.predir      := r.clean_address.predir;
     self.person_addr.addr_suffix := r.clean_address.addr_suffix;
     self.person_addr.postdir     := r.clean_address.postdir;
     self.person_addr.unit_desig  := r.clean_address.unit_desig;
     self.person_addr.sec_range   := r.clean_address.sec_range;
     self.person_addr.p_city_name := r.clean_address.p_city_name;
     self.person_addr.v_city_name := r.clean_address.v_city_name;
     self.person_addr.st          := r.clean_address.st;
     self.person_addr.zip         := r.clean_address.zip;
     self.person_addr.zip4        := r.clean_address.zip4;
		 //mapping thrive sources to a different source code, so there are no conflicts with royaties because thrive is being added in the regular POE build
		 self.email_src								:= map(l.email_src = mdr.sourceTools.src_Thrive_LT => mdr.sourceTools.src_Thrive_LT_POE_Email,
																				 l.email_src = mdr.sourceTools.src_Thrive_PD => mdr.sourceTools.src_Thrive_PD_POE_Email,
																				 l.email_src);
     self                         := l;
  END;

  EmailsWithDomainRegistrantBDID1 := 
     join(
          distribute(EmailsWithDomainRegistrantBDID(bdid<>0),email_rec_key)
          , distribute(pEmails,email_rec_key)
          , left.email_rec_key = right.email_rec_key
          , afixLatLon( LEFT, RIGHT )
          , local
     );
    //output(sort(EmailsWithDomainRegistrantBDID1, email_rec_key),named('EmailsWithDomainRegistrantBDID1'));
    //output(count(EmailsWithDomainRegistrantBDID1),named('Cnt_EmailsWithDomainRegistrantBDID1'));
  //========================================================================================================

  /*========================================================================================================
    Step2:
    Use dedup to get a list of all BDIDs associated with the domain names of these emails. Here, I do a
    local dedup after sorting locally. Then I globally sort and do another dedup. My last step is to
    project list of domain names into a record that only contains the bdid associated with the domain name.
  ----------------------------------------------------------------------------------------------------------*/
  deduped_domains := 
     project(
             dedup(
                    sort(
                         distribute(
                             dedup(
                                   sort(
                                         distribute(EmailsWithDomainRegistrantBDID1,random())
                                         , append_domain, -date_last_seen
                                         , local
                                   )
                                   , append_domain
                                   , local
                             )
                         , hash64(append_domain)
                         )
                         , append_domain, -date_last_seen
                         , local
                    )
                    , append_domain
                    , local
             )
             , {EmailsWithDomainRegistrantBDID1.bdid}
     );
  //output(count(deduped_domains),named('size_of_deduped_domains'));
  //========================================================================================================

  /*========================================================================================================
    Step3:
    g1: Join each BDID against the supergroup to get group ids. And outputing the slimed file with just BDID
    group_id fields.
  ----------------------------------------------------------------------------------------------------------*/
  OwnerBdidsAndGroupIds := 
     join(
          //distribute(pSGBaseFile, hash64(random()))
          pSGBaseFile
          , dedup(sort(deduped_domains,bdid),bdid)
          , left.bdid = right.bdid
          , transform({deduped_domains.bdid;pSGBaseFile.group_id;}
                      , self.group_id := left.group_id
                      , self := right
            )
          , LOOKUP
     );
  //output(count(OwnerBdidsAndGroupIds),named('size_of_super_BDID_group_ids'));
  //output(OwnerBdidsAndGroupIds,named('super_BDID_group_ids'));
  //========================================================================================================

  /*========================================================================================================
    Step4:
    g2: Then, get all bdids for each group id.
  ----------------------------------------------------------------------------------------------------------*/
  AllBdidsOfAllGroups :=
     join(
          //distribute(pSGBaseFile,hash64(random()))
          pSGBaseFile
          , OwnerBdidsAndGroupIds
          , left.group_id = right.group_id
          , transform({OwnerBdidsAndGroupIds;typeof(pSGBaseFile.bdid) agrp_bdid;}
                      , self.agrp_bdid := left.bdid
                      , self.bdid      := right.bdid
                      , self.group_id  := left.group_id;
                      //, self            := left
            )
          , LOOKUP
     );
  //output(count(AllBdidsOfAllGroups),named('size_of_other_BDIDs_for_these_BDID_group_ids'));
  //output(AllBdidsOfAllGroups,named('other_BDIDs_for_these_BDID_group_ids'));
  //========================================================================================================

  /*========================================================================================================
    Step5:
    g3: Then, get all business header records for each bdid and append geo_lat/geo_long
  ----------------------------------------------------------------------------------------------------------*/
AllDataForAllBdidsRec := POEsFromEmails.Layouts.AllDataForAllBdidsRec;
  
  AllDataForAllBdidsRec getBHAddr(pBHBaseFile  l, AllBdidsOfAllGroups r ) := TRANSFORM
     self.bh_company_name              := l.company_name;
     self.bh_phone                    := l.phone;
     self.bh_company_addr.prim_range  := l.prim_range;
     self.bh_company_addr.predir      := l.predir;
     self.bh_company_addr.prim_name    := l.prim_name;
     self.bh_company_addr.addr_suffix  := l.addr_suffix;
     self.bh_company_addr.postdir      := l.postdir;
     self.bh_company_addr.unit_desig  := l.unit_desig;
     self.bh_company_addr.sec_range    := l.sec_range;
     self.bh_company_addr.city_name    := l.city;
     self.bh_company_addr.st          := l.state;
     self.bh_company_addr.zip         := if(l.zip  = 0	,''	,intformat(l.zip ,5,1));
     self.bh_company_addr.zip4        := if(l.zip4 = 0	,''	,intformat(l.zip4,4,1));
     self.bh_company_addr_geo_lat      := l.geo_lat;
     self.bh_company_addr_geo_long    := l.geo_long;
     self.bh_rawaid                    := l.rawaid;
     self                             := r;
  end;
  
  AllDataForAllBdidsOfAllGroups0 := 
     project(
              dedup(  
                sort(
                  distribute(
                     join(
                          //distribute(pBHBaseFile, hash64(random()))
                          pBHBaseFile
                          , AllBdidsOfAllGroups
                          , (left.bdid = right.agrp_bdid) and (left.phone<>0)
                          , getBHAddr(left,right)
                          ,  LOOKUP
                     )
                  ,bdid)
                ,record,local)
              ,record, except bh_company_addr_geo_lat, bh_company_addr_geo_long, local)  
             , transform(AllDataForAllBdidsRec
                         , self.bh_rec_key := counter
                         , self := left
               )   
     );


  /*========================================================================================================
    Step5b:
     Get the best name and address from the BDID Best file. Then, compute lat/long for the BDID's best zip
     and zip4.
  ----------------------------------------------------------------------------------------------------------*/
  BH_Best_Layout := Business_Header.Layout_BH_Best;
  
  AllDataForAllBdidsRec getBestBHNameAndAddr(AllDataForAllBdidsRec  l, BH_Best_Layout r ) := TRANSFORM
  best_geo := fcn_zip9ToLatLong(intformat(r.zip,5,1),intformat(r.zip4,4,1));
     self.bh_company_name              := r.company_name;
     self.bh_phone                     := r.phone;
     self.bh_company_addr.prim_range   := r.prim_range;
     self.bh_company_addr.predir       := r.predir;
     self.bh_company_addr.prim_name    := r.prim_name;
     self.bh_company_addr.addr_suffix  := r.addr_suffix;
     self.bh_company_addr.postdir      := r.postdir;
     self.bh_company_addr.unit_desig   := r.unit_desig;
     self.bh_company_addr.sec_range    := r.sec_range;
     self.bh_company_addr.city_name    := r.city;
     self.bh_company_addr.st           := r.state;
     self.bh_company_addr.zip          := if(r.zip  = 0	,''	,intformat(r.zip	,5,1));
     self.bh_company_addr.zip4         := if(r.zip4 = 0	,''	,intformat(r.zip4	,4,1));
     self.bh_company_addr_geo_lat      := IF(regexfind('[0-9]\\.[0-9]', best_geo[1..10]), best_geo[1..10], SKIP);
     self.bh_company_addr_geo_long     := IF(regexfind('[0-9]\\.[0-9]', best_geo[11..20]), best_geo[11..20], SKIP);
     self.bh_rawaid                    := r.rawaid;
     self                              := l;
  end;

AllDataForAllBdidsOfAllGroups :=
   dedup(
         join(distribute(AllDataForAllBdidsOfAllGroups0,agrp_bdid)
              , distribute(pBHBestFile,bdid)
              , left.agrp_bdid=right.bdid
              , getBestBHNameAndAddr( LEFT, RIGHT )
              , local
         )
         , agrp_bdid
         , local
   );
  //output(count(AllDataForAllBdidsOfAllGroups),named('size_of_AllDataForAllBdidsOfAllGroups'));
  //output(AllDataForAllBdidsOfAllGroups,named('AllDataForAllBdidsOfAllGroups'));
  //========================================================================================================

  /*========================================================================================================
    Step6:
    Put group_id in EmailsWithDomainRegistrantBDID. I will use group_id when I calculate distance, below.
  ----------------------------------------------------------------------------------------------------------*/
  EmailsWithDomainRegistrantBDID_GID := 
  join(
       //distribute(EmailsWithDomainRegistrantBDID1, hash64(random()))
				 EmailsWithDomainRegistrantBDID1
       , OwnerBdidsAndGroupIds
       , left.bdid=right.bdid
       , transform({EmailsWithDomainRegistrantBDID1; pSGBaseFile.group_id;}
                   , self.group_id := right.group_id
                   , self := left
         )
       , LOOKUP  
  );
  //output(count(EmailsWithDomainRegistrantBDID),named('size_of_EmailsWithDomainRegistrantBDID'));
  //output(EmailsWithDomainRegistrantBDID,named('EmailsWithDomainRegistrantBDID'));
  //========================================================================================================
//take EmailsWithDomainRegistrantBDID_GID, dedup on groupid, did
//rollup on groupid, creating child dataset with dids in it
//do join like EmailsWithDistanceBetweenDidAndBdid on groupid, grabbing the child dataset dids
//normalize out the dids to one per record
//join back to EmailsWithDomainRegistrantBDID_GID on did, grabbing person info and calculating distance
	EmailsWithDomainRegistrantBDID_GID_dedup	:= dedup(EmailsWithDomainRegistrantBDID_GID,group_id, did, hash);
	EmailsWithDomainRegistrantBDID_GID_proj		:= project(EmailsWithDomainRegistrantBDID_GID_dedup
		,transform(layouts.rollupgroupids
			,self.group_id	:= left.group_id
			,self.dids			:= dataset([{left.did}],{unsigned6 did});
	));
	EmailsWithDomainRegistrantBDID_GID_rollup	:= rollup(
		 sort(distribute(EmailsWithDomainRegistrantBDID_GID_proj, group_id), group_id, local)
		,left.group_id = right.group_id
		,transform(layouts.rollupgroupids
			,self.group_id 	:= left.group_id
			,self.dids			:= left.dids + right.dids;
		)
		,local
	);

  /*========================================================================================================
    Step7:
    For each email/DID, D, calculate the distance between D and every BDID in its domainÃ‚â€™s BDID super group.
  ----------------------------------------------------------------------------------------------------------*/
  AllDataForAllBdidsOfAllGroups_withdids := 
     join( 
						 distribute(AllDataForAllBdidsOfAllGroups							,group_id)
           , distribute(EmailsWithDomainRegistrantBDID_GID_rollup	,group_id)
           , left.group_id = right.group_id
           ,transform(
                     {
                      POEsFromEmails.Layouts.temp;
                     }
                     , self.dids            := right.dids
                     , self                 := left
            )
            , local
     );
	AllDataForAllBdidsOfAllGroups_withdid := normalize(distribute(AllDataForAllBdidsOfAllGroups_withdids,random())
		,left.dids
		,transform(
			 POEsFromEmails.Layouts.temp2	
			,self.did := right.did
			,self			:= left;
		)
	);
	AllDataForAllBdidsOfAllGroups_withdid_dedup := dedup(AllDataForAllBdidsOfAllGroups_withdid,did,agrp_bdid,hash);
	EmailsWithDomainRegistrantBDID_GID_dedup2		:= dedup(sort(distribute(EmailsWithDomainRegistrantBDID_GID_dedup,did),did,-date_last_seen,local),did,local);

  EmailsWithDistanceBetweenDidAndBdid := 
     join( 
						 distribute(AllDataForAllBdidsOfAllGroups_withdid_dedup	,did)
           , distribute(EmailsWithDomainRegistrantBDID_GID_dedup2		,did)
           , left.did = right.did
           ,transform(POEsFromEmails.Layouts.base
                     , self.did             := right.did
//										 , self.bdid						:= left.agrp_bdid
                     , self.date_first_seen := (unsigned4)right.date_first_seen
                     , self.date_last_seen  := (unsigned4)right.date_last_seen

                     , self.group_id        := left.group_id
                     , self.bh_rec_key      := left.bh_rec_key
                     , self.distance        := ut.ll_dist((real)right.person_addr_geo_lat, (real)right.person_addr_geo_long,
                                                          (real)left.bh_company_addr_geo_lat, (real)left.bh_company_addr_geo_long);
                     , self                 := left;
                     , self                 := right;
            )
            , local
     );
	//join back to EmailsWithDomainRegistrantBDID1 to get registrant name
	//weight bdids with close to that name more than other ones
	djoin2getRegistrantName := join(
		 distribute(EmailsWithDistanceBetweenDidAndBdid			,random())
		,dedup(sort(distribute(EmailsWithDomainRegistrantBDID1,did)	,did, -date_last_seen,local),did,local)
		,left.did = right.did
		,transform(
			{POEsFromEmails.Layouts.base, string registrant_name,boolean islikeregistrantname}
			,clean_registrant_name	:= ut.cleancompany(right.registrant_name);
			 clean_bh_comp_name			:= ut.cleancompany(left.bh_company_name);
			 self.registrant_name 			:= right.registrant_name
			,self.islikeregistrantname	:= (		clean_registrant_name[1..8] = clean_bh_comp_name[1..8]
																		and ut.CompanySimilar100(clean_registrant_name, clean_bh_comp_name) <= 10
																		) 
//																		or regexfind(clean_registrant_name,clean_bh_comp_name,nocase)
//																		or regexfind(clean_bh_comp_name,clean_registrant_name,nocase)
			,self.bdid									:= right.bdid																
			,self												:= left
		)
		,lookup
	);	//should be able to keep inner join since the bdids came from dEmailsWithDomainRegistrantBDID1, so 
			//shouldn't lose any records
  //output(count(EmailsWithDistanceBetweenDidAndBdid),named('size_of_EmailsWithDistanceBetweenDidAndBdid'));
  //========================================================================================================

  /*========================================================================================================
    Step8:
    Then, For each DID find the BDID that is closest to them with the most recent date_last_seen
    
    This block 1st randomly distributes the emails with all the potential POE BDIDs and the distance between
    the DID and BDID. Then, locally it sorts 1st by did, then group_id (because did my have more than one
    POE domain in different super BDID groups), then by distance (with small distances 1st). Then it locally 
    dedups by did & group_id (which should result in the closest bdid for each did on the node). Then it 
    distributes by DID and then sorts locally by did, group_id and distance. This is folowed by a local dedup
    by did & group_id. Because a DID may have more than one POE BDID in different super BDID groups, the
    last thing I do is sort by DID, -date_last_seen (so the most recent date is 1st). And then, dedup on did.
  ----------------------------------------------------------------------------------------------------------*/
  ClosestPOE_BDIDforEmailsWithPOEDomainBDIDs0 :=
     dedup(
           sort(
                dedup(
                      sort(
                           distribute(
                               dedup(
                                     sort(
                                          distribute(djoin2getRegistrantName, random())
                                          , did, group_id, if(distance < 30,0,1),if(distance < 30 and islikeregistrantname,0,1), distance
                                          , local
                                     )
                                     , did, group_id
                                     , local
                               )
                           , did
                           )
                           , did, group_id, if(distance < 30,0,1),if(distance < 30 and islikeregistrantname,0,1),distance
                           , local
                      )
                      , did, group_id
                      , local
                )
                , did, -date_last_seen
                , local
           )
           , did
           , local
     );
	dreturndataset := project(ClosestPOE_BDIDforEmailsWithPOEDomainBDIDs0,transform(POEsFromEmails.Layouts.base, self.bdid := left.agrp_bdid;self := left));

	Layouts.temp_base ConvertToTemp(POEsFromEmails.Layouts.base l) := transform
	  self.prim_range		:= l.bh_Company_addr.prim_range ;
	  self.prim_name		:= l.bh_Company_addr.prim_name	;
	  self.sec_range		:= l.bh_Company_addr.sec_range	;
	  self.city_name		:= l.bh_Company_addr.city_name	;
	  self.st						:= l.bh_Company_addr.st         ;
	  self.zip					:= l.bh_Company_addr.zip       	;	 
	  self.fname				:= l.pname.fname               	;
	  self.mname				:= l.pname.mname              	;
	  self.lname				:= l.pname.lname              	;
		self.phone        := if(l.bh_phone	!= 0,(string10)l.bh_phone,'');
		self              := l                            ;
	END;
	
BDIDdataset   := project(dreturndataset,ConvertToTemp(left));
  
BDID_Matchset := ['A','P']; 

//This BDID Flwx call is only for appending the BIPV2 linkids.  This is why the number 2 is used 
//instead of using BIPV2.xlink_version_set which stamps both the BDIDs and linkids.
Business_Header_SS.MAC_Add_BDID_Flex(																						
			 BDIDdataset  									  // Input Dataset													
			,BDID_Matchset                    // BDID Matchset what fields to match on  
			,bh_company_name                  // company_name	                          
			,prim_range		                    // prim_range		                          
			,prim_name		                    // prim_name		                          
			,zip					                		// zip5					                          
			,sec_range		                    // sec_range		                          
			,st   				                		// state				                          
			,phone  			               			// phone				                          
			,fein_not_used                    // fein                                   
			,bdid															// bdid												            
			,Layouts.temp_base                // Output Layout                          
			,FALSE                            // output layout has bdid score field?                       
			,bdid_score                       // bdid_score                             
			,dreturnbdidset                   // Output Dataset                         
	    ,                                 // score_threshold
	    ,     														// pFileVersion - default to use prod version of superfiles
	    ,                                 // pUseOtherEnvironment - default is to hit prod from dataland, and on prod hit prod.
	    ,[2]                              // BIPV2 IDs - only want to stamp the BIP IDs on the records	
	    ,                                 // URL
	    ,clean_email                      // Email
	    ,city_name	                    	// City
	    ,fname                            // fname
      ,mname                            // mname
	    ,lname                            // lname
  		,                                 // contact_ssn
			,                                 // source - MDR.sourceTools
			,                                 // source_record_id
			,FALSE                            // src_matching_is_priority
      );                              			

dReturnBdidset_w_linkids		:= project(dreturnbdidset,transform(Layouts.base,self := left));

addGlobalSID								:=  MDR.macGetGlobalSID(dReturnBdidset_w_linkids,'POEsFromEmails_Virtual','','global_sid'); //DF-26532: Populate Global_SID
			
dEmailsWithDomainRegistrantBDID1							:= EmailsWithDomainRegistrantBDID1((did = 427717391) or (bdid in [35546914/*lexisnexis*/,15962941/*harcourt*/,13144]) or (regexfind('rob',pname.fname,nocase) and regexfind('holp',pname.lname,nocase)));
ddeduped_domains 															:= deduped_domains(bdid in [35546914/*lexisnexis*/,15962941/*harcourt*/,13144]);
dOwnerBdidsAndgroup_ids												:= OwnerBdidsAndgroupids(bdid in [35546914/*lexisnexis*/,15962941/*harcourt*/] or group_id = 13144);
dAllBdidsOfAllGroups													:= AllBdidsOfAllGroups(bdid in [35546914/*lexisnexis*/,15962941/*harcourt*/] or group_id = 13144 or agrp_bdid in [35546914/*lexisnexis*/,15962941/*harcourt*/]);
dAllDataForAllBdidsOfAllGroups0								:= AllDataForAllBdidsOfAllGroups0(bdid in [35546914/*lexisnexis*/,15962941/*harcourt*/] or group_id = 13144 or agrp_bdid in [35546914/*lexisnexis*/,15962941/*harcourt*/]);
dAllDataForAllBdidsOfAllGroups								:= AllDataForAllBdidsOfAllGroups(bdid in [35546914/*lexisnexis*/,15962941/*harcourt*/,13144] or group_id = 13144 or agrp_bdid in [35546914/*lexisnexis*/,15962941/*harcourt*/]);
dEmailsWithDomainRegistrantBDID_GID						:= EmailsWithDomainRegistrantBDID_GID				((did = 427717391));
dEmailsWithDomainRegistrantBDID_GID_dedup			:= EmailsWithDomainRegistrantBDID_GID_dedup	((did = 427717391));
dEmailsWithDomainRegistrantBDID_GID_proj			:= EmailsWithDomainRegistrantBDID_GID_proj	(group_id in set(dEmailsWithDomainRegistrantBDID_GID, group_id));
dEmailsWithDomainRegistrantBDID_GID_rollup		:= EmailsWithDomainRegistrantBDID_GID_rollup(group_id in set(dEmailsWithDomainRegistrantBDID_GID, group_id));
dAllDataForAllBdidsOfAllGroups_withdids				:= AllDataForAllBdidsOfAllGroups_withdids		(group_id in set(dEmailsWithDomainRegistrantBDID_GID, group_id));
dAllDataForAllBdidsOfAllGroups_withdid				:= AllDataForAllBdidsOfAllGroups_withdid		(did = 427717391);
dEmailsWithDistanceBetweenDidAndBdid					:= sort(EmailsWithDistanceBetweenDidAndBdid(did = 427717391),distance);
ddjoin2getRegistrantName 											:= sort(djoin2getRegistrantName(did = 427717391),-islikeregistrantname,distance);
dClosestPOE_BDIDforEmailsWithPOEDomainBDIDs0 	:= sort(ClosestPOE_BDIDforEmailsWithPOEDomainBDIDs0(did = 427717391),distance);
ddreturndataset 															:= sort(dreturndataset(did = 427717391),distance);

countdEmailsWithDomainRegistrantBDID1						 	:= count(dEmailsWithDomainRegistrantBDID1							);
countddeduped_domains 														:= count(ddeduped_domains 														);
countdOwnerBdidsAndgroup_ids											:= count(dOwnerBdidsAndgroup_ids											);
countdAllBdidsOfAllGroups												 	:= count(dAllBdidsOfAllGroups													);
countdAllDataForAllBdidsOfAllGroups0							:= count(dAllDataForAllBdidsOfAllGroups0							);
countdAllDataForAllBdidsOfAllGroups							 	:= count(dAllDataForAllBdidsOfAllGroups								);
countdEmailsWithDomainRegistrantBDID_GID					:= count(dEmailsWithDomainRegistrantBDID_GID					);
countdEmailsWithDomainRegistrantBDID_GID_dedup		:= count(dEmailsWithDomainRegistrantBDID_GID_dedup		);
countdEmailsWithDomainRegistrantBDID_GID_proj			:= count(dEmailsWithDomainRegistrantBDID_GID_proj			);
countdEmailsWithDomainRegistrantBDID_GID_rollup		:= count(dEmailsWithDomainRegistrantBDID_GID_rollup		);
countdAllDataForAllBdidsOfAllGroups_withdids			:= count(dAllDataForAllBdidsOfAllGroups_withdids			);
countdAllDataForAllBdidsOfAllGroups_withdid				:= count(dAllDataForAllBdidsOfAllGroups_withdid				);
countdEmailsWithDistanceBetweenDidAndBdid				 	:= count(dEmailsWithDistanceBetweenDidAndBdid					);
countddjoin2getRegistrantName 										:= count(ddjoin2getRegistrantName 										);
countdClosestPOE_BDIDforEmailsWithPOEDomainBDIDs0 := count(dClosestPOE_BDIDforEmailsWithPOEDomainBDIDs0	);
countddreturndataset 														 	:= count(ddreturndataset 															);
/*
return parallel(
	 output(countdEmailsWithDomainRegistrantBDID1						 	,named('countdEmailsWithDomainRegistrantBDID1'						))
	,output(countddeduped_domains 														,named('countddeduped_domains' 														))
	,output(countdOwnerBdidsAndgroup_ids											,named('countdOwnerBdidsAndgroup_ids'											))
	,output(countdAllBdidsOfAllGroups												 	,named('countdAllBdidsOfAllGroups'												))
	,output(countdAllDataForAllBdidsOfAllGroups0							,named('countdAllDataForAllBdidsOfAllGroups0'							))
	,output(countdAllDataForAllBdidsOfAllGroups							 	,named('countdAllDataForAllBdidsOfAllGroups'							))
	,output(countdEmailsWithDomainRegistrantBDID_GID					,named('countdEmailsWithDomainRegistrantBDID_GID'					))
	,output(countdEmailsWithDomainRegistrantBDID_GID_dedup		,named('countdEmailsWithDomainRegistrantBDID_GID_dedup'		))
	,output(countdEmailsWithDomainRegistrantBDID_GID_proj			,named('countdEmailsWithDomainRegistrantBDID_GID_proj'		))
	,output(countdEmailsWithDomainRegistrantBDID_GID_rollup		,named('countdEmailsWithDomainRegistrantBDID_GID_rollup'	))
	,output(countdAllDataForAllBdidsOfAllGroups_withdids			,named('countdAllDataForAllBdidsOfAllGroups_withdids'			))
	,output(countdAllDataForAllBdidsOfAllGroups_withdid				,named('countdAllDataForAllBdidsOfAllGroups_withdid'			))
	,output(countdEmailsWithDistanceBetweenDidAndBdid				 	,named('countdEmailsWithDistanceBetweenDidAndBdid'				))
	,output(countddjoin2getRegistrantName 										,named('countddjoin2getRegistrantName'										))
	,output(countdClosestPOE_BDIDforEmailsWithPOEDomainBDIDs0 ,named('countdClosestPOE_BDIDforEmailsWithPOEDomainBDIDs0'))
	,output(countddreturndataset 														 	,named('countddreturndataset'															))

	,output(dEmailsWithDomainRegistrantBDID1						 	,named('dEmailsWithDomainRegistrantBDID1'							))
	,output(ddeduped_domains 															,named('ddeduped_domains' 														))
	,output(choosen(dOwnerBdidsAndgroup_ids,100)					,named('dOwnerBdidsAndgroup_ids'											))
	,output(choosen(dAllBdidsOfAllGroups,100)							,named('dAllBdidsOfAllGroups'													))
	,output(dAllDataForAllBdidsOfAllGroups0								,named('dAllDataForAllBdidsOfAllGroups0'							))
	,output(dAllDataForAllBdidsOfAllGroups							 	,named('dAllDataForAllBdidsOfAllGroups'								))
	,output(dEmailsWithDomainRegistrantBDID_GID						,named('dEmailsWithDomainRegistrantBDID_GID'					))
	,output(dEmailsWithDomainRegistrantBDID_GID_dedup			,named('dEmailsWithDomainRegistrantBDID_GID_dedup'		))
	,output(dEmailsWithDomainRegistrantBDID_GID_proj			,named('dEmailsWithDomainRegistrantBDID_GID_proj'			))
	,output(dEmailsWithDomainRegistrantBDID_GID_rollup		,named('dEmailsWithDomainRegistrantBDID_GID_rollup'		))
	,output(dAllDataForAllBdidsOfAllGroups_withdids				,named('dAllDataForAllBdidsOfAllGroups_withdids'			))
	,output(dAllDataForAllBdidsOfAllGroups_withdid				,named('dAllDataForAllBdidsOfAllGroups_withdid'				))
	,output(dEmailsWithDistanceBetweenDidAndBdid				 	,named('dEmailsWithDistanceBetweenDidAndBdid'					),all)
	,output(ddjoin2getRegistrantName 											,named('ddjoin2getRegistrantName'											),all)
	,output(dClosestPOE_BDIDforEmailsWithPOEDomainBDIDs0 	,named('dClosestPOE_BDIDforEmailsWithPOEDomainBDIDs0'	),all)
	,output(ddreturndataset 														 	,named('ddreturndataset'															),all)
);
*/
  return addGlobalSID;
end;

//========================================================================================================
