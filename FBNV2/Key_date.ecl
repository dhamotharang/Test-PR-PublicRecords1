import  FBNV2,RoxieKeyBuild,ut,autokey,doxie ;

KeyName       		:= cluster.cluster_out+'Key::FBNV2::';
dBase 	 			:= File_FBN_BUsiness_Base;

Layout_date      :=record
unsigned6    Date;
dbase.tmsid;
dbase.rmsid;
end;

layout_date  tNormalizePhone(dBase  pInput, unsigned1 pCounter)
    :=TRANSFORM
		  SELF.date		:=choose(pCounter,
								 pInput.Filing_date,
								 pInput.orig_filing_date,
								 pInput.cancellation_date,
								 pInput.expiration_date,
								 pInput.bus_comm_dATE);	 
		  SELF		    :=pInput;
	
	 END;
				
dDist                   := distribute(dedup(normalize(dBase ,5,tNormalizephone(left,counter))(date<>0),all)
                                        ,HASH(date)); 
dSort                   := sort(dDist,date,tmsid,rmsid,local);

export Key_date := INDEX(dSort  ,{date},{tmsid,rmsid},KeyName +doxie.Version_SuperKey+'::date');
