shared laypl	:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__search__bdid_pl;
shared dpl		:= PRTE_CSV.Business_Header.dthor_data400__key__business_header__search__bdid_pl;


export prct_BH_Baseprct_bdid_sic(

	 dataset(laypl														)	pBdidpl				= dpl2
	,dataset(Risk_Indicators.Layouts.SicLookup)	pSicLookup		= Risk_Indicators.Files().SicLookup.built
	,unsigned4																	pPercentFile	=	10
	,string																			pPersistname	= '~thor_data400::persist::Business_Header::prct_bdid_sic'
	
) :=
function

	countpBdidpl := count(pBdidpl);

	dSampleBH	:= enth(pBdidpl	,(unsigned)(countpBdidpl / pPercentFile));

	dsamplebh_slim := table(dSampleBH	,{bdid,source});
	
	setSics	:= set(pSicLookup	,sic_code);
	
	countsetSics := count(setSics);
	
	//generate random sic codes for records
	dproj := project(dsamplebh_slim,transform(Layout_SIC_Code
		,self.sic_code	:= setSics[((((real8)random()/4294967296.0) * countsetSics) + 1)]
		,self						:= left
	))
	: persist(pPersistname)
	;

	return dproj;
	
end;