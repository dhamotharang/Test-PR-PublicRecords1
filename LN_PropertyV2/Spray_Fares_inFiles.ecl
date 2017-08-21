import lib_fileservices,_control;

export	Spray_Fares_inFiles(string	filedate)	:=
function
	sourceMachineIP	:=	_control.IPAddress.edata12;
	targetGroupName	:=	'thor400_30';

	assessSpray	:=	fileservices.sprayfixed(	sourceMachineIP,'/thor_back5/fares/faresV2/out/faresV2_assessor.d00'
																						, 3039, targetGroupName,'~thor_data400::in::ln_propertyv2::'+filedate+'::fares_assessor' 
																						,,,,true,true,true);

	deedsSpray	:=	fileservices.sprayfixed(	sourceMachineIP,'/thor_back5/fares/faresV2/out/faresV2_deeds.d00'
																						, 1531, targetGroupName,'~thor_data400::in::ln_propertyv2::'+filedate+'::fares_deeds'
																						,,,,true,true,true);
					
	searchSpray	:=	fileservices.sprayfixed(	sourceMachineIP,'/thor_back5/fares/faresV2/out/faresV2_search.d00'
																						, 613, targetGroupName,'~thor_data400::in::ln_propertyv2::'+filedate+'::fares_search_init'
																						,,,,true,true,true);

	sprayFiles	:=	parallel(assessSpray,deedsSpray,searchSpray);
	
	dSearchInit	:=	dataset('~thor_data400::in::ln_propertyv2::'+filedate+'::fares_search_init',LN_PropertyV2.Layout_Fares_Search_in,thor);
	
	// Reformat to the LN common layout
	LN_PropertyV2.layout_deed_mortgage_property_search	tReformat2Common(dSearchInit	pInput)	:=
	transform
		self.dt_first_seen            :=	(integer)pInput.dt_first_seen; 
		self.dt_last_seen             :=	(integer)pInput.dt_last_seen; 
		self.dt_vendor_first_reported	:=	(integer)pInput.dt_vendor_first_reported; 
		self.dt_vendor_last_reported  :=	(integer)pInput.dt_vendor_last_reported; 
		self.conjunctive_name_seq     :=	pInput.conjunctive_name_seq ; 
		self.phone_number             :=	pInput.phone_number;
		self.ln_fares_id              :=	pInput.fares_id;
		self.cname                    :=	pInput._company;
		self.vendor_source_flag       :=	if(pInput.vendor	=	'FAR_F','F','S');
		self                          :=	pInput;
	end;
	
	dSearch2Common	:=	project(dSearchInit,tReformat2Common(left));
	
	// Append AID for new search records
	LN_PropertyV2.Append_AID(dSearch2Common,dSearchAID,false);
	
	// Clean the names using the new name cleaner
	dSearchCleanName	:=	LN_PropertyV2.fn_Clean_Names(dSearchAID,false,true);
	
	dSearchOut	:=	output(dSearchCleanName,,'~thor_data400::in::ln_propertyv2::'+filedate+'::fares_search',__compressed__,overwrite);

	assessorsSuper	:=	fileservices.AddSuperFile('~thor_data400::in::ln_propertyv2::fares_assessor','~thor_data400::in::ln_propertyv2::'+filedate+'::fares_assessor');
	deedsSuper			:=	fileservices.AddSuperFile('~thor_data400::in::ln_propertyv2::fares_deeds','~thor_data400::in::ln_propertyv2::'+filedate+'::fares_deeds');
	searchSuper			:=	fileservices.AddSuperFile('~thor_data400::in::ln_propertyv2::fares_search','~thor_data400::in::ln_propertyv2::'+filedate+'::fares_search');

	addSuper	:=	parallel(assessorsSuper,deedsSuper,searchSuper);
	
	deleteSearchInit	:=	fileservices.deletelogicalfile('~thor_data400::in::ln_propertyv2::'+filedate+'::fares_search_init');
	
	sprayFares	:=	sequential(	sprayFiles,
 															dSearchOut,
   														addSuper,
   														deleteSearchInit
														);

	return	sprayFares;

end;