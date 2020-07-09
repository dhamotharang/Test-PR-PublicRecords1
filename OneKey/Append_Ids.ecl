IMPORT business_header, Header_Slimsort, didville, ut, DID_Add, Business_Header_SS, Business_HeaderV2, OneKey;

EXPORT Append_Ids := MODULE

  //////////////////////////////////////////////////////////////////////////////////////
  // -- function: fAppendBdid
  // -- Adds proprietary id: BDID
  //////////////////////////////////////////////////////////////////////////////////////
  EXPORT fAppendBdid(DATASET(OneKey.Layouts.Base) pDataset) := FUNCTION
	
    OneKey.Layouts.Temporary.UniqueId tAddUniqueId(OneKey.Layouts.Base l, UNSIGNED8 cnt) := TRANSFORM
      SELF.unique_id     := cnt;
      SELF               := l;
    END;   
		
    dAddUniqueId := PROJECT(pDataset, tAddUniqueId(LEFT, COUNTER));

    //////////////////////////////////////////////////////////////////////////////////////
    // -- Slim record for Bdiding
    //////////////////////////////////////////////////////////////////////////////////////
    OneKey.Layouts.Temporary.BdidSlim tSlimForBdiding(OneKey.Layouts.Temporary.UniqueId l) := TRANSFORM
		
      SELF.unique_id     := l.unique_id;
      SELF.bus_nm        := l.bus_nm;
      SELF.prim_range    := l.prim_range;
      SELF.prim_name     := l.prim_name;
      SELF.zip5          := l.zip;
      SELF.sec_range     := l.sec_range;
      SELF.p_city_name   := l.p_city_name;
      SELF.st            := l.st;
      SELF.Clean_Phone   := l.Clean_Phone;
      SELF.fname         := l.fname;
      SELF.mname         := l.mname;
      SELF.lname         := l.lname;
      SELF.bdid          := 0;
      SELF.bdid_score    := 0;
      SELF               := [];
    END;   
						
    dSlimForBdiding := PROJECT(dAddUniqueId, tSlimForBDiding(LEFT));

    //*** Match set for BDIDing
    BDID_Matchset := ['A','P'];
		
    //**** External id macro that appends BDID's and BIPV2 xlinkids
    Business_Header_SS.MAC_Add_BDID_Flex(
      dSlimForBdiding                         // Input Dataset						
     ,BDID_Matchset                           // BDID Matchset what fields to match on           
     ,bus_nm                                  // company_name	              
     ,prim_range                              // prim_range		              
     ,prim_name                               // prim_name		              
     ,zip5                                    // zip5					              
     ,sec_range                               // sec_range		              
     ,st                                      // state				              
     ,clean_phone                             // phone				              
     ,fein_not_used                           // fein              
     ,bdid                                    // bdid												
     ,OneKey.Layouts.Temporary.BdidSlim       // Output Layout 
     ,TRUE                                    // output layout has bdid score field?                       
     ,bdid_score                              // bdid_score                 
     ,dBdidOut                                // Output Dataset   
     ,                                        // deafult threshold
     ,                                        // use prod version of superfiles
     ,                                        // default is to hit prod from dataland, and on prod hit prod.		
     ,BIPV2.xlink_version_set                 // Create BID Keys only
     ,                                        // Url
     ,                                        // Email
     ,p_City_name                             // City
     ,fname                                   // fname
     ,mname                                   // mname
     ,lname                                   // lname
		);
		
    dBdidOut_dist      := DISTRIBUTE(dBdidOut(bdid != 0 OR 
                                              UltID != 0 OR 
                                              OrgID 	!= 0 OR 
                                              ProxID 	!= 0 OR
                                              SELEID 	!= 0 OR
                                              POWID 	!= 0 OR 
                                              EmpID 	!= 0 OR 
                                              DotID 	!= 0)
                                    ,unique_id);
    dBdidOut_sort      := SORT(dBdidOut_dist, unique_id, -bdid_score, -ProxScore, LOCAL);
    dBdidOut_dedup     := DEDUP(dBdidOut_sort, unique_id, LOCAL);

    dAddUniqueId_dist  := DISTRIBUTE(dAddUniqueId, unique_id);

			 
    OneKey.Layouts.Base tAssignBdids(OneKey.Layouts.Temporary.UniqueId l, OneKey.Layouts.Temporary.BdidSlim r) := TRANSFORM

      SELF.bdid          := IF(r.bdid         <> 0, r.bdid,        0);
      SELF.bdid_score    := IF(r.bdid_score   <> 0, r.bdid_score,  0);
      SELF.Ultid         := IF(r.Ultid        <> 0, r.Ultid,       0);
      SELF.Ultscore      := IF(r.Ultscore     <> 0, r.Ultscore,    0);
      SELF.UltWeight     := IF(r.UltWeight    <> 0, r.UltWeight,   0);
      SELF.OrgID         := IF(r.OrgID        <> 0, r.OrgID,       0);
      SELF.Orgscore      := IF(r.Orgscore     <> 0, r.Orgscore,    0);
      SELF.OrgWeight     := IF(r.OrgWeight    <> 0, r.OrgWeight,   0);
      SELF.ProxID        := IF(r.ProxID       <> 0, r.ProxID,      0);
      SELF.Proxscore     := IF(r.Proxscore    <> 0, r.Proxscore,   0);
      SELF.ProxWeight    := IF(r.ProxWeight   <> 0, r.ProxWeight,  0);
      SELF.SELEID        := IF(r.SELEID       <> 0, r.SELEID,      0);
      SELF.SELEScore     := IF(r.SELEScore    <> 0, r.SELEScore,   0);
      SELF.SELEWeight    := IF(r.SELEWeight   <> 0, r.SELEWeight,  0);
      SELF.POWID         := IF(r.POWID        <> 0, r.POWID,       0);
      SELF.POWscore      := IF(r.POWscore     <> 0, r.POWscore,    0);
      SELF.POWWeight     := IF(r.POWWeight    <> 0, r.POWWeight,   0);
      SELF.EmpID         := IF(r.EmpID        <> 0, r.EmpID,       0);
      SELF.Empscore      := IF(r.Empscore     <> 0, r.Empscore,    0);
      SELF.EmpWeight     := IF(r.EmpWeight    <> 0, r.EmpWeight,   0);
      SELF.DotID         := IF(r.DotID        <> 0, r.DotID,       0);
      SELF.Dotscore      := IF(r.Dotscore     <> 0, r.Dotscore,    0);
      SELF.DotWeight     := IF(r.DotWeight    <> 0, r.DotWeight,   0);
      SELF               := l;

    END;

    dAssignBdids := JOIN(dAddUniqueId_dist
                        ,dBdidOut_dedup
                        ,LEFT.unique_id = RIGHT.unique_id
                        ,tAssignBdids(LEFT, RIGHT)
                        ,LEFT OUTER
                        ,LOCAL);
		
    RETURN dAssignBdids;
				
  END;
	
	
  EXPORT fAll(DATASET(OneKey.Layouts.Base) pDataset) := FUNCTION
	
    dAppendBdid := fAppendBdid(pDataset) : PERSIST(OneKey.Filenames().PersistAppendIds);
				                                                              
    RETURN dAppendBdid;
	
  END;


END;