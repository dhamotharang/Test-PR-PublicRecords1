IMPORT ProfileBooster, _Control, dx_ProfileBooster, STD;
onThor := _Control.Environment.OnThor;

EXPORT V2_getEmrgAddress(DATASET(ProfileBooster.V2_Layouts.Layout_PB2_Slim_emergence) slimShell) := FUNCTION
    
    lexidKey := dx_ProfileBooster.Key_Lexid(0);
    addressKey := dx_ProfileBooster.Key_Address(0);

    ProfileBooster.V2_Layouts.Layout_PB2_Slim_emergence xfm_AddEmergence(slimShell le, lexidKey ri) := TRANSFORM
        SELF.EmrgLexIDsAtEmrgAddrCnt1Y := IF(le.did2<>ri.did,1,0);
        SELF := le;
        SELF := [];
    END;

    withLexIDEmrg := JOIN(slimShell,
                          lexidKey,
                          LEFT.did2<>RIGHT.did AND
                          LEFT.emrgprimaryrange=RIGHT.emrgprimaryrange AND 	
                          LEFT.emrgpredirectional=RIGHT.emrgpredirectional AND
                          LEFT.emrgprimaryname=RIGHT.emrgprimaryname AND
                          LEFT.emrgprimaryname<>'' AND
                          LEFT.emrgsuffix=RIGHT.emrgsuffix AND
                          LEFT.emrgpostdirectional=RIGHT.emrgpostdirectional AND
                          LEFT.emrgunitdesignation=RIGHT.emrgunitdesignation AND
                          LEFT.emrgsecondaryrange=RIGHT.emrgsecondaryrange AND
                          LEFT.emrgzip5=RIGHT.emrgzip5 AND 
                          RIGHT.emrgdt_first_seen BETWEEN STD.Date.AdjustDate(LEFT.emrgdt_first_seen,0,-6,0) AND STD.Date.AdjustDate(LEFT.emrgdt_first_seen,0,6,0),
                          xfm_AddEmergence(LEFT,RIGHT));
    
    withLexIDEmrg_sorted :=  sort(withLexIDEmrg, emrgzip5,emrgprimaryrange,emrgpredirectional,emrgprimaryname,emrgsuffix,
                                                             emrgpostdirectional,emrgunitdesignation,emrgsecondaryrange);

    // withLexIDEmrg_distributed := distribute(withLexIDEmrg_sorted, HASH64(emrgzip5,emrgprimaryrange,emrgpredirectional,emrgprimaryname,emrgsuffix,
    //                                                        emrgpostdirectional,emrgunitdesignation,emrgsecondaryrange));
	   

    d_addr := TABLE(withLexIDEmrg_sorted, {emrgzip5,emrgprimaryrange,emrgpredirectional,emrgprimaryname,emrgsuffix,
                                           emrgpostdirectional,emrgunitdesignation,emrgsecondaryrange,EmrgLexIDsAtEmrgAddrCnt1Yb := count(group)},
                                           emrgzip5,emrgprimaryrange,emrgpredirectional,emrgprimaryname,emrgsuffix,
                                           emrgpostdirectional,emrgunitdesignation,emrgsecondaryrange);
    
    emergenceLayout := RECORD
    	STRING10 		EmrgPrimaryRange;
		STRING6  		EmrgPredirectional;
		STRING28 		EmrgPrimaryName;
		STRING6  		EmrgSuffix;
		STRING6  		EmrgPostdirectional;
		STRING10 		EmrgUnitDesignation;
		STRING8  		EmrgSecondaryRange;
		STRING6  		EmrgZIP5;
		// STRING6  		EmrgZIP4;
		STRING25 		EmrgCity_Name;
		STRING6  		EmrgSt;
   		INTEGER3		EmrgLexIDsAtEmrgAddrCnt1Yb;
		STRING6  		EmrgAddrType;
    END;

    emergenceLayout xfm_AddAddrType(d_addr le, addressKey ri) := TRANSFORM
        SELF.EmrgPrimaryRange := le.EmrgPrimaryRange;
		SELF.EmrgPredirectional := le.EmrgPredirectional;
		SELF.EmrgPrimaryName := le.EmrgPrimaryName;
		SELF.EmrgSuffix := le.EmrgSuffix;
		SELF.EmrgPostdirectional := le.EmrgPostdirectional;
		SELF.EmrgUnitDesignation := le.EmrgUnitDesignation;
		SELF.EmrgSecondaryRange := le.EmrgSecondaryRange;
		SELF.EmrgZIP5 := le.EmrgZIP5;
		// SELF.EmrgZIP4 := (STRING)le.EmrgZIP4;
		// SELF.EmrgCity_Name := le.EmrgCity_Name;
		// SELF.EmrgSt := le.EmrgSt;
   		SELF.EmrgLexIDsAtEmrgAddrCnt1Yb := le.EmrgLexIDsAtEmrgAddrCnt1Yb-1;
        SELF.EmrgAddrType := IF(ri.AddrType IN ['F','G','H','P','R','S','U'], ri.AddrType, '-99997');
        SELF := le;
        SELF := [];
    END;

    withAddressType := JOIN(d_addr, addressKey,
                            LEFT.emrgprimaryrange=RIGHT.primaryrange AND 	
                            LEFT.emrgpredirectional=RIGHT.predirectional AND
                            LEFT.emrgprimaryname=RIGHT.primaryname AND
                            LEFT.emrgprimaryname<>'' AND
                            LEFT.emrgsuffix=RIGHT.suffix AND
                            LEFT.emrgpostdirectional=RIGHT.postdirectional AND
                            LEFT.emrgunitdesignation=RIGHT.unitdesignation AND
                            LEFT.emrgsecondaryrange=RIGHT.secondaryrange AND
                            LEFT.emrgzip5=RIGHT.zip5,
                            xfm_AddAddrType(LEFT,RIGHT), LEFT OUTER, KEEP(1));

    //DEBUGGING OUTPUTS
    // OUTPUT(CHOOSEN(withLexIDEmrg,100),named('V2GEA_withLexIDEmrg'));
    // OUTPUT(CHOOSEN(withLexIDEmrg_sorted,100),named('V2GEA_withLexIDEmrg_sorted'));
    // OUTPUT(CHOOSEN(rolledEmergence,100),named('V2GEA_rolledEmergence'));
    OUTPUT(CHOOSEN(d_addr,100),named('V2GEA_d_addr'));
    OUTPUT(CHOOSEN(withAddressType,100),named('V2GEA_withAddressType'));
    RETURN withAddressType;
END;