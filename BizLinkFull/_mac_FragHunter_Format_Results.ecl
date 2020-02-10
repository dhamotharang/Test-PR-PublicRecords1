IMPORT bizlinkfull,bipv2;

EXPORT _mac_FragHunter_Format_Results(

   pHdr             = 'bipv2.CommonBase.ds_clean'  
  ,pId              = 'proxid'                    // proxid or seleid
  ,pFrag_Threshold  = '50'

) := 
functionmacro

  // -- Set Template vars, id source(id number 1)
  #uniquename(ID)
  #uniquename(IDSource)
  #uniquename(Results_Child)

  #SET(ID       ,trim(#TEXT(pId)))
  #SET(IDSource ,trim(#TEXT(pId)) + 'Source')
  #IF(trim(#TEXT(pId)) = 'proxid')
    #SET(Results_Child ,'results')
  #ELSE
    #SET(Results_Child ,'results_seleid')
  #END

	//Input data
	allproxidsIn := DEDUP(SORT(DISTRIBUTE(pHdr,pId),pId,LOCAL),pId,LOCAL);
	dsIn         := PROJECT(allproxidsIn,{unsigned6 pId});

	//Fraghunter thor function
	SHARED dsOut := BizLinkFull._mac_Fraghunter_Find_Fragments(dsIn,pId) :PERSIST('~persist::BizLinkFull::_mac_FragHunter_Format_Results::dsout_' + trim(%'ID'%),EXPIRE(10));
	
	//Normalize data
	SHARED Layout_Scoring := RECORD
		UNSIGNED6 uniqueid;
		UNSIGNED6 %IDSource%;
		UNSIGNED6 pId;
		INTEGER2 	weight;
	END;
	
	SHARED ChildRec := BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch;
	
	Layout_Scoring normFrags(dsOut L, ChildRec R) := TRANSFORM
		SELF.uniqueid := L.reference;
		SELF.pId      := R.pId;
		SELF.weight   := R.weight;
		SELF          := L;
	END;
	
	EXPORT pFrags := NORMALIZE(dsOut, LEFT.%Results_Child%(%'ID'% = 'seleid' or (prim_rangeweight > 0 and prim_nameweight > 0)),normFrags(LEFT,RIGHT)) : PERSIST('~persist::BizLinkFull::_mac_FragHunter_Format_Results::pFrags_' + trim(%'ID'%),EXPIRE(10));
	
	//Filter any fragments that are below the weight threshold
	EXPORT vFrags := pFrags(pId <> %IDSource% AND weight > pFrag_Threshold);
	
	//Bring in segmentation data and join to filtered fragments
	//Prevents Core and Dead proxids from showing up as fragments
	// SHARED proxids := DISTRIBUTE(InsuranceHeader_PostProcess.corecheck(ind <> 'CORE',ind <> 'DEAD'),proxid);
	SHARED proxids    := DISTRIBUTE(pHdr(sele_gold = 'G'),pId);
	SHARED vFragsDist := DISTRIBUTE(vFrags,pId);
	
	EXPORT fullRec := RECORD
		Layout_Scoring;
		STRING sele_gold;
	END;
   
	fullRec combineThem(proxids L, vFragsDist R) := TRANSFORM
		SELF.sele_gold := L.sele_gold;
		SELF := R;
	END;
   
	EXPORT onlyFrags:= JOIN(proxids,vFragsDist,LEFT.pId = RIGHT.pId,combineThem(LEFT,RIGHT),LOCAL) : PERSIST('~persist::BizLinkFull::_mac_FragHunter_Format_Results::onlyFrags_' + trim(%'ID'%),EXPIRE(10));

  export debug_fraghunter := parallel(
    output(choosen(dsOut      ,300),named('BizLinkFull_fragHunter_dsOut'      ),all)
   ,output(choosen(pFrags     ,300),named('BizLinkFull_fragHunter_pFrags'     ),all)
   ,output(choosen(vFrags     ,300),named('BizLinkFull_fragHunter_vFrags'     ),all)
   ,output(choosen(proxids    ,300),named('BizLinkFull_fragHunter_proxids'    ),all)
   ,output(choosen(vFragsDist ,300),named('BizLinkFull_fragHunter_vFragsDist' ),all)
   ,output(choosen(onlyFrags  ,300),named('BizLinkFull_fragHunter_onlyFrags'  ),all)
  
  );
  return when(vFrags  ,debug_fraghunter);
  
ENDMACRO;