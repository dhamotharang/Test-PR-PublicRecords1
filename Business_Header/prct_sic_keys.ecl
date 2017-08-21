import prte_csv,tools;
/*
Business_Header.key_commercial_SIC_Zip	Business_Header.BH_BDID_SIC(bdid, sic_code), business header file
Business_Header.Key_SIC_Code						Business_Header.BH_BDID_SIC(bdid,sic_code)
Risk_Indicators.Key_Sic_Description			Risk_Indicators.Files().SicLookup.built(sic_code, sic_description)

HereÂ’s the fields:
string8                  sic_code;
unsigned3           zip;
unsigned2           zip4;       
unsigned6           bdid;
string80                sic_description  ;


Business_Header.BH_BDID_SIC -- bdid,sic_code
*/
shared laypl	:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__search__bdid_pl;
shared dpl		:= PRTE_CSV.Business_Header.dthor_data400__key__business_header__search__bdid_pl;

export prct_sic_keys(

	 string										pversion										
	,dataset(laypl					)	pBdidpl		= dpl
	,dataset(Layout_SIC_Code)	pbdidsic	= prct_bdid_sic()

) :=
function

	//change name of keys before building so don't interfere with production keys

	dbdidpl := pBdidpl;
	dproj 	:= project(dbdidpl	,transform(business_header.Layout_Business_Header_Base_Plus_Orig	,self := left;self.rcid := counter;self := []; )) : global;

	lroxiekeys	:= business_header.RoxieKeys(pversion,,,,'prte',,pbdidsic,dproj).Sics;
	
	Build_Key1  := tools.macf_WriteIndex('lroxiekeys.key_SicZip.New'			,true);
	Build_Key2  := tools.macf_WriteIndex('lroxiekeys.key_SicCode.New'			,true);
	Build_Key3  := tools.macf_WriteIndex('lroxiekeys.key_SicDescrip.New'	,true);
		                                                                          
	return 
		parallel(
			 Build_Key1
			,Build_Key2
			,Build_Key3
		);

end;