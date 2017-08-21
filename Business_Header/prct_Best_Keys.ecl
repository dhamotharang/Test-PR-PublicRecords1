import prte_csv,tools;

shared laypl	:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__search__bdid_pl;
shared dpl		:= PRTE_CSV.Business_Header.dthor_data400__key__business_header__search__bdid_pl;

export prct_Best_Keys(

	 string					pversion										
	,dataset(laypl)	pBdidpl		= dpl

) :=
function

	//change name of keys before building so don't interfere with production keys

	dbdidpl := pBdidpl;
	dproj 	:= project(dbdidpl	,transform(business_header.Layout_Business_Header_Base	,self := left;self.rcid := counter;self := []; )) : global;

	rkeys				:= roxiekeys(pversion,,,,'prte',,,,dproj).HeaderBest;

	Build_Key1  := tools.macf_WriteIndex('rkeys.key_FileposData.New'			,true);
	Build_Key2  := tools.macf_WriteIndex('rkeys.key_FileposData_Knowx.New',true);
		                                                                          
	return parallel(

			 Build_Key1
			,Build_Key2

	);

end;