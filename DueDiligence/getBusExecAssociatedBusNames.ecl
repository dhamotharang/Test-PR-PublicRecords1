IMPORT Address, Business_Risk_BIP, BIPV2, BIPV2_Best;

EXPORT getBusExecAssociatedBusNames(DATASET(DueDiligence.LayoutsInternalReport.Associated_Businesses) InData, 
												 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
												 BIPV2.mod_sources.iParams linkingOptions )  := FUNCTION
											
  //*** extract out just the LINKID's from this result set - use call the KFETCH using linkID's only ***//
  linkIDsOnly := PROJECT(InData, TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2,
                                        #EXPAND(DueDiligence.Constants.mac_TRANSFORMFetch2Linkids())));                                    
  
	DDBestInformationRaw := BIPV2_Best.Key_LinkIds.kFetch2(linkIDsOnly,
																								Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								linkingOptions,
																								Business_Risk_BIP.Constants.Limit_Default,
																								Options.KeepLargeBusinesses);
	
	 
	// Add back our Seq numbers
	LOCAL DDBestInformationSeq := JOIN(DDBestInformationRaw, InData, 
												LEFT.UltID        = RIGHT.Busn_info.BIP_IDs.UltID.LinkID  AND  
										    LEFT.OrgID        = RIGHT.Busn_info.BIP_IDs.OrgID.LinkID  AND  
										    LEFT.SeleID       = RIGHT.Busn_info.BIP_IDs.SeleID.LinkID AND 
                        LEFT.uniqueID     = RIGHT.Busn_Info.BIP_IDs.seq,
												TRANSFORM({RECORDOF(LEFT), UNSIGNED6 seq, UNSIGNED4 historyDate},
																	SELF.seq         := RIGHT.Busn_Info.BIP_IDs.seq;
																	SELF.historyDate := RIGHT.historyDate;
																	SELF := LEFT), 
												FEW); 
                        
 
  // output(linkIDsOnly,          NAMED('linkIDsOnly'));  
  // output(DDBestInformationRaw, NAMED('DDBestInformationRaw'));  
  // output(DDBestInformationSeq, NAMED('DDBestInformationSeq'));  
  
	RETURN DDBestInformationSeq;
END;