import Business_Header, prte_csv, Risk_Indicators;

//*** this is a copy of the business_header.prct_bdid_sic
export BDID_Sic(

	 dataset(Business_Header.Layout_Business_Header_Base_Plus_Orig)	pBdidpl				= File_Business_Header_Base_for_keybuild()
	,dataset(Risk_Indicators.Layouts.SicLookup)											pSicLookup		= Risk_Indicators.Files().SicLookup.built
	,unsigned4																											pPercentFile	=	10
	,string																													pPersistname	= '~prte::persist::Business_Header::bdid_sic'
	
) :=
function

	countpBdidpl := count(pBdidpl);

	dSampleBH	:= enth(pBdidpl	,(unsigned)(countpBdidpl / pPercentFile));

	dsamplebh_slim := table(dSampleBH	,{bdid,source});
	
	setSics	:= set(pSicLookup	,sic_code);
	
	countsetSics := count(setSics);
	
	//generate random sic codes for records
	dproj := project(dsamplebh_slim,transform(Business_Header.Layout_SIC_Code
		,self.sic_code	:= setSics[((((real8)random()/4294967296.0) * countsetSics) + 1)]
		,self						:= left
	))
	: persist(pPersistname)
	;

	return dproj;
	
end;