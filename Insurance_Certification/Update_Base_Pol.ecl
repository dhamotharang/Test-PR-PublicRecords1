IMPORT Insurance_Certification,lib_stringlib,AID,ut;

EXPORT Update_Base_Pol(DATASET(Layouts_policy.Input) pUpdateFilePol,
									     DATASET(Layouts_policy.Base)	 pBaseFilePol,
									     STRING	pversion) := FUNCTION
	
	 dStdzInputFilePol := 	Insurance_Certification.StandardizeInputFile.fAllPol (pUpdateFilePol, pversion);
   	
	 Insurance_Certification.Layouts_policy.Base tMappingPol(Layouts_policy.Temp L) := TRANSFORM
			self.Date_FirstSeen :=  (integer) pversion;
			self.Date_LastSeen  :=  (integer) pversion;		
		  SELF                :=  l;
	 END;
	 
	 dMappingPol := PROJECT(dStdzInputFilePol,tMappingPol(LEFT));
	 update_combinedPol	 := IF(Insurance_Certification._Flags('Policy','Policy').Update, 
											       dMappingPol + pBaseFilePol, 
											       dMappingPol) : PERSIST('persist::Insurance_Certification::policy::Combined'); 
	 HasAddressPol       :=  (trim( update_combinedPol.Append_MailAddressLast, left,right) != '') AND
	                         (update_combinedPol.InsuranceProviderState IN 
													      /* 10 US Territories & 50 US States */
															['AS','CZ','DC','GU','MH','FM','MP','PW','PR','VI',  
															 'AK','AL','AZ','AR','CA','CO','CT','DE','FL','GA',  
															 'HI','ID','IL','IN','IA','KS','KY','LA','ME','MD',  
															 'MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ',  
															 'NM','NY','NC','ND','OH','OK','OR','PA','RI','SC',  
															 'SD','TN','TX','UT','VT','VA','WA','WV','WI','WY'] );									
	 isGoodRec  :=  (string)update_combinedPol.LNInsCertRecordID != 'LNInsCertRecordID';	
	 
	 dWith_addressPol    :=  update_combinedPol(HasAddressPol AND isGoodRec);
	 dWithout_addressPol :=  update_combinedPol(not(HasAddressPol) AND isGoodRec);			
	 
	 lFlagsPol := AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
	 AID.MacAppendFromRaw_2Line(dWith_addressPol, Append_MailAddress1, Append_MailAddresslast, Append_MailRawAID, dwithAIDPol, lFlagsPol);
	 
	 Insurance_Certification.layouts_policy.keybuild tGetStdzAddressPol(dwithAIDPol l)	:=	transform
			self.Append_MailRawAID := l.AIDWork_RawAID;
		  self.Append_MailACEAID := l.AIDWork_ACECache.aid; 
			self.m_prim_range			 :=	l.AIDWork_ACECache.prim_range;
			self.m_predir					 :=	l.AIDWork_ACECache.predir;
			self.m_prim_name			 :=	l.AIDWork_ACECache.prim_name;
			self.m_addr_suffix		 :=	l.AIDWork_ACECache.addr_suffix;
			self.m_postdir				 :=	l.AIDWork_ACECache.postdir;
			self.m_unit_desig			 :=	l.AIDWork_ACECache.unit_desig;
			self.m_sec_range		   :=	l.AIDWork_ACECache.sec_range;		
			self.m_p_city_name		 :=	l.AIDWork_ACECache.p_city_name;	
			self.m_v_city_name		 :=	l.AIDWork_ACECache.v_city_name;	
			self.m_st							 :=	l.AIDWork_ACECache.st;	
			self.m_zip						 :=	l.AIDWork_ACECache.zip5;	
			self.m_zip4						 :=	l.AIDWork_ACECache.zip4;	
			self.m_cart						 :=	l.AIDWork_ACECache.cart;	
			self.m_cr_sort_sz			 :=	l.AIDWork_ACECache.cr_sort_sz;	
			self.m_lot						 :=	l.AIDWork_ACECache.lot;				
			self.m_lot_order			 :=	l.AIDWork_ACECache.lot_order;
			self.m_dbpc						 :=	l.AIDWork_ACECache.dbpc;	
			self.m_chk_digit			 :=	l.AIDWork_ACECache.chk_digit;	
			self.m_rec_type				 :=	l.AIDWork_ACECache.rec_type;
			self.m_fips_state			 :=	l.AIDWork_ACECache.county[1..2];	
			self.m_fips_county		 :=	l.AIDWork_ACECache.county[3..5];	
			self.m_geo_lat				 :=	l.AIDWork_ACECache.geo_lat;	
			self.m_geo_long				 :=	l.AIDWork_ACECache.geo_long;	
			self.m_msa						 :=	l.AIDWork_ACECache.msa;	
			self.m_geo_blk				 :=	l.AIDWork_ACECache.geo_blk;	
			self.m_geo_match			 :=	l.AIDWork_ACECache.geo_match;
			self.m_err_stat				 :=	l.AIDWork_ACECache.err_stat;
			self									 := l;
	 end;
		
	 dAddressAppendedPol:=	project(dwithAIDPol, tGetStdzAddressPol(left)) + 
											  	project(dWithout_addressPol,
													TRANSFORM(Insurance_Certification.layouts_policy.keybuild,
													SELF := LEFT; SELF :=	[];));
  
	dAppendIds :=  Append_Ids.fAllPolicy (dAddressAppendedPol);
		
	dDistNewBase :=	distribute(dAppendIds,hash(LNInsCertRecordID));										
														
	dRollupBase :=  Rollup_Base.Rollup_Base_Pol (dDistNewBase);   
		
	RETURN dRollupBase;
	
END;