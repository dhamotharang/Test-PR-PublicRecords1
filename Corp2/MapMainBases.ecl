IMPORT tools, Corp2_Mapping, Corp2;

EXPORT MapMainBases(dataset(Corp2_Mapping.LayoutsCommon.Temporary)	inCombined, 
										string	pversion, 
										dataset(corp2.Layout_Corp_EventDate) inEvents) := module

	corpBaseOrigin		:=	inCombined(recordOrigin='P');
	contBaseOrigin		:=	inCombined(recordOrigin='N');
	corpMainOrigin		:=	inCombined(recordOrigin='C');
	contMainOrigin		:=	inCombined(recordOrigin='T');
	
	ContCombined			:=	inCombined(	(cont_lname <> '' or corp_key<>'') and 
																		(recordOrigin = 'T' or recordOrigin='N')
																	 );
	
	contDist 					:= 	distribute(ContCombined, hash(corp_key));
	contNames					:= 	dedup(sort(contDist, corp_key,cont_lname,cont_fname,cont_mname,local),corp_key,cont_lname,cont_fname,cont_mname,local);

	pUpdateCorp				:=	corp2.MapCorpBase(corpBaseOrigin, corpMainOrigin, contNames, inEvents);
	pUpdateCont				:=	corp2.MapContBase(contBaseOrigin, contMainOrigin);	
	
	Update_Corp_Base	:= tools.macf_WriteFile(corp2.Filenames(pversion).Base_xtnd.corp.new		,KeyFilters.Corp(pUpdateCorp));	                                                                    	
	Update_Cont_Base	:= tools.macf_WriteFile(corp2.Filenames(pversion).Base_xtnd.cont.new		,KeyFilters.Cont(pUpdateCont));                                                                    

	export All := 
	
		parallel(
							Update_Corp_Base,
							Update_Cont_Base
						);
end;
