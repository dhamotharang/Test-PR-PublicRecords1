IMPORT NID, MDR, STD;		
EXPORT GetVerified_Recs := MODULE
		
		EXPORT getNameMatch(DATASET(PhoneFinder_Services.Layouts.PhoneFinder.IdentityIesp) dIdentitiesInfo, 
									DATASET(PhoneFinder_Services.Layouts.BatchIn) dIn_with_bestDIDs,
									BOOLEAN phoneticMatch = FALSE											 
									) :=	FUNCTION									 
											
		// performing a lexid , name match
		VRec := JOIN(dIdentitiesInfo, dIn_with_bestDIDs, 
		            left.acctno = right.acctno and							 
		            IF(phoneticMatch,  (right.did >0 and (UNSIGNED)left.UniqueId = right.did) OR 
		            (NID.mod_PFirstTools.PFLeqPFR(left.Name.First, STD.STR.ToUpperCase(right.name_first)) AND														 
		            (metaphonelib.DMetaPhone1(left.Name.Last) = metaphonelib.DMetaPhone1(STD.STR.ToUpperCase(right.name_last)))),   																
		            (right.did >0 and  (UNSIGNED)left.UniqueId = right.did) OR 
		            ((NID.mod_PFirstTools.PFLeqPFR(left.Name.First, STD.STR.ToUpperCase(right.name_first))) AND
		            (left.Name.Last = STD.STR.ToUpperCase(right.name_last)))),
		            TRANSFORM(PhoneFinder_Services.Layouts.PhoneFinder.IdentityIesp, SELF := LEFT), KEEP(1), LIMIT(0));
 	  
	 RETURN VRec;
	END;	
	
 	EXPORT getNameAddressMatch (DATASET(PhoneFinder_Services.Layouts.PhoneFinder.IdentityIesp) dIdentitiesInfo, 
                                DATASET(PhoneFinder_Services.Layouts.BatchIn) dIn_with_bestDIDs,
                                BOOLEAN phoneticMatch = FALSE											 
                                ):=	FUNCTION						
   					
   		// performing a lexid , name match
     VRec := JOIN(dIdentitiesInfo, dIn_with_bestDIDs,
                  left.acctno = right.acctno and
                  IF(phoneticMatch, ((right.did >0 and (UNSIGNED)left.UniqueId = right.did) OR 
                  ((NID.mod_PFirstTools.PFLeqPFR(left.Name.first, STD.STR.ToUpperCase(right.name_first))) AND 
                  (metaphonelib.DMetaPhone1(left.Name.Last) = metaphonelib.DMetaPhone1(STD.STR.ToUpperCase(right.name_last))) AND																	
                  ((left.vendor_id = MDR.sourceTools.src_Targus_Gateway AND left.RecentAddress.StreetNumber = '' AND left.RecentAddress.StreetName = '')) OR																	
                  (left.RecentAddress.StreetNumber = right.prim_range AND left.RecentAddress.StreetName = STD.STR.ToUpperCase(right.prim_name))) AND 																	
                  ((left.RecentAddress.City = STD.STR.ToUpperCase(right.p_city_name) AND left.RecentAddress.State = STD.STR.ToUpperCase(right.st)) OR																	
                  left.RecentAddress.Zip5 = right.z5)),								
      								       
                  ((right.did >0 and (unsigned)left.UniqueId = right.did) OR 
                  (NID.mod_PFirstTools.PFLeqPFR(left.Name.First, STD.STR.ToUpperCase(right.name_first)) AND left.Name.Last = STD.STR.ToUpperCase(right.name_last) AND
                  ((left.vendor_id = MDR.sourceTools.src_Targus_Gateway AND left.RecentAddress.StreetNumber = '' AND left.RecentAddress.StreetName = '') OR
                  (left.RecentAddress.StreetNumber = right.prim_range AND left.RecentAddress.StreetName = STD.STR.ToUpperCase(right.prim_name))) AND 
                  ((left.RecentAddress.City = STD.STR.ToUpperCase(right.p_city_name) AND left.RecentAddress.State = STD.STR.ToUpperCase(right.st)) OR left.RecentAddress.Zip5 = right.z5)))),
                  TRANSFORM(PhoneFinder_Services.Layouts.PhoneFinder.IdentityIesp, SELF := left), LIMIT(0),KEEP(1));
      RETURN VRec;
	END;
	
	EXPORT getVerifyRecs(PhoneFinder_Services.iParam.ReportParams inMod,
                         DATASET(PhoneFinder_Services.Layouts.PhoneFinder.IdentityIesp) dIdentitiesInfo, 
                         DATASET(PhoneFinder_Services.Layouts.batchIn) dIn_with_bestDIDs) :=	FUNCTION

	  v_recs := MAP(inMod.VerifyPhoneNameAddress => getNameAddressMatch(dIdentitiesInfo, dIn_with_bestDIDs, inMod.PhoneticMatch),
                    inMod.VerifyPhoneName => getNameMatch(dIdentitiesInfo, dIn_with_bestDIDs, inMod.PhoneticMatch),					
                    DATASET([], PhoneFinder_Services.Layouts.PhoneFinder.IdentityIesp));	 											 
										 
  RETURN v_recs;
	
	END;
END;