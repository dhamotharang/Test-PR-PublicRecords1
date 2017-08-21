import _control,VINA,vehlic,PromoteSupers;

rVINA_Candidates := record
	string22	vin;
	string1		lf;
end;

dCandidates	:=	dataset('~thor_data400::in::vehiclev2::vina_candidates',rVINA_Candidates,thor,unsorted);

// Reformat to VINA layout
VehLic.Layout_VINA	tConvert2VINA(dCandidates pCandidates)	:= transform
	self.vin_input	:=	pCandidates.vin;
	self						:=	[];
end;

dVINACandidates	:=	project(dCandidates,tConvert2VINA(left));

// Vina file
dVina	:=	dataset('~thor_data400::in::vehreg_vina_info_all',VehLic.Layout_VINA,thor);

// Get the updated list of the VINA candidates
dCombinedVINs			:=	dVINACandidates	+	dVina;
dCombinedVINDist	:=	distribute(dCombinedVINs,hash(vin_input));
//Sort by record to keep record count of dCombinedVINRollup consistent
dCombinedVINSort	:=	sort(dCombinedVINDist,record,local);

vehlic.Layout_VINA	tRollup(dCombinedVINSort	le,dCombinedVINSort	ri)	:=
transform
	self.vin_error_status				:=	if(le.vin_error_status	!=	'',le.vin_error_status,ri.vin_error_status);
	self.vin_pattern_indicator	:=	if(le.vin_pattern_indicator	!=	'',le.vin_pattern_indicator,ri.vin_pattern_indicator);
	self.bypass_code						:=	if(le.bypass_code	!=	'',le.bypass_code,ri.bypass_code);
	self.variable_segment				:=	if(le.variable_segment	!=	'',le.variable_segment,ri.variable_segment);
	self.vp_restraint						:=	if(le.vp_restraint	!=	'',le.vp_restraint,ri.vp_restraint);
	self.vp_model								:=	if(le.vp_model	!=	'',le.vp_model,ri.vp_model);
	self.vp_reserved						:=	if(le.vp_reserved	!=	'',le.vp_reserved,ri.vp_reserved);
	self.vina_model							:=	if(le.vina_model	!=	'',le.vina_model,ri.vina_model);
	self.series_description			:=	if(le.series_description	!=	'',le.series_description,ri.series_description);
	self												:=	le;
end;

dCombinedVINRollup	:=	rollup(	dCombinedVINSort,
																left.vin_input	=	right.vin_input,
																tRollup(left,right),
																local
															);

// Populate the VINA information
dAppendVINAInfo	:=	VINA.append_vin_info(dCombinedVINRollup);
//Dedup records
dAppendVINAInfoDedup := DEDUP(SORT(DISTRIBUTE(dAppendVINAInfo,HASH(vin_input)),RECORD,LOCAL),RECORD,LOCAL);

PromoteSupers.MAC_SF_BuildProcess(dAppendVINAInfoDedup,'~thor_data400::in::vehreg_vina_info_all',bPopulateVINInfo,,,true);

// Delete the VINA candidates file
zClearFile := FileServices.ClearSuperFile('~thor_data400::in::vehiclev2::vina_candidates',true);

export	Populate_VINA_Info	:=	if(	fileservices.getsuperfilesubcount('~thor_data400::in::vehiclev2::vina_candidates') > 0,
																		sequential(bPopulateVINInfo,zClearFile),
																		output('No VIN files available, hence not running the VINA process')
																	 );