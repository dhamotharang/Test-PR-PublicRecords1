#workunit('name', 'Yogurt:Vehicle Picker File');

import ut, Vehlic, VehicleV2, vehicle_wildcard,lib_fileservices, _control;

export	GetMakeModel(string	filedate)	:=
function
	// phase 1 get current info from picker file

	rMakeModel_layout := 
	RECORD
		string MakeID;
		string MakeCode;
		string MakeDescription;
		string ModelDescription;
	END;

	dMakeModel := dataset('~thor_data400::out::vehicle_valid_make_model', rMakeModel_layout, csv(separator('|')));

	rPickerOut_layout	:=
	record
		string Make_Code;
		string Make_Description;
		string Model_Description;
	end;

	rPickerOut_layout	tConvert2Picker(dMakeModel le)	:=
	transform
		self.make_code					:=	le.MakeCode;
		self.make_description		:=	le.MakeDescription;
		self.model_description	:=	le.ModelDescription;
	end;

	dPicker	:=	project(dMakeModel(stringlib.stringtolowercase(MakeCode) != 'makecode'), tConvert2Picker(left));

	//phase2 get new stuff from VINA

	dVINADistrix := vehiclev2.File_VINA_For_Distrix; 

	rDistrixStat_layout :=
	record
		dVINADistrix.NCIC_MAKE;
		dVINADistrix.make_description;
		dVINADistrix.model_description;
		unsigned integer4 b_total := count(group);
	end;

	dVINAMakeModelStats := table(dVINADistrix(make_description <> 'Courier'), rDistrixStat_layout, NCIC_make, model_description,make_description,few);

	rPickerOut_layout tFormat(dVINAMakeModelStats l) :=
	transform
		self.make_code					:= l.ncic_make;
		self.make_description 	:= map(L.ncic_make = 'AUTC' => 'AUTOCAR LLC',
																	 L.ncic_make = 'CPIU' => 'CPI MOTOR COMPANY',
																	 L.ncic_make = 'MAYB' => 'MAYBACH MAYB',
																	 L.ncic_make = 'MNNI' => 'MINI',
																	 L.ncic_make = 'SPNR' => 'DCX SPRINTER',
																	 L.ncic_make = 'ZONG' => 'ZONGSHEN ZONG', L.make_description);
		self.model_description  := if(trim(l.model_description, left, right) in ['Oliver City:jv' , 'GTR:JA49'], '', stringlib.StringToUpperCase(l.model_description));
	end;

	dVINAMakeModel  := project(dVINAMakeModelStats(make_description <> '' or model_description <> '' ), tFormat(left));

	//phase3 add the make model from vehicle base file as required - 'VESPA', 'NISSAN TITAN'

	dVehiclesMain	:= vehicleV2.file_VehicleV2_Main(trim(best_make_code, all) = 'VESP' and trim(orig_make_desc, all) = 'VESPA')
									+ vehicleV2.file_VehicleV2_Main(trim(orig_model_desc,all) = 'Titan' and trim(best_make_code, all) = 'NISS' and trim(orig_make_desc, all) = 'Nissan');

	rPickerOut_layout tFromVeh(dVehiclesMain L) :=
	transform
		self.make_code 					:= l.best_make_code;
		self.make_description 	:= l.orig_make_desc;
		self.model_description	:= stringlib.StringToUpperCase(l.orig_model_desc);
	end;

	dAddlVehicleMakeModel	:= project(dVehiclesMain, tFromVeh(left));

	//phase4 add make/model only in veh base file

	dVehicleMakeModel := dataset('~thor_data400::out::veh_base_make_model_file', rPickerOut_layout, flat);

	//combine VINA, original make/model, make/model only in veh base

	dCombined := dPicker + dVINAMakeModel + dAddlVehicleMakeModel + dVehicleMakeModel;

	rPickerOut_layout	tConvert2Upper(dCombined pInput)	:=
	transform
		tmake_code					    :=	stringlib.stringtouppercase(pInput.make_code);
		tmake_description		    :=	stringlib.stringtouppercase(regexreplace('[ ]+', stringlib.stringfindreplace(pInput.make_description, '-', ' '), ' '));

		self.make_code := map(tmake_description='DIAMOND REO'  and tmake_code='DIAT' => 'DIAR' ,
											tmake_description ='EAGLE'          and tmake_code='EGIL' => 'EAGL' ,
											tmake_description ='JEEP'           and tmake_code='JEP'  => 'JEEP' ,
											tmake_description ='KAWASAKI'       and tmake_code='KAW' => 'KAWK' ,
											tmake_description ='LAND ROVER'     and tmake_code='LNDR' => 'LAND' ,
											tmake_description ='LEXUS'          and tmake_code='LEXU' => 'LEXS' ,
											tmake_description ='MINI'           and tmake_code='MIN'  => 'MINC' ,
                      tmake_description ='MINI'           and tmake_code='MNNI' => 'MINC' ,
                      tmake_description ='MINI COOPER'    and tmake_code='MINI' => 'MINC' ,											tmake_description ='NISSAN DIESEL'  and tmake_code='UD'   => 'NDMC' ,
											tmake_description ='POLARIS'        and tmake_code='POLA' => 'POLS' ,
											tmake_description ='PONTIAC'        and tmake_code='PONI' => 'PONT' ,
											tmake_description ='RANGE ROVER'    and tmake_code='ROV'  => 'RANG' ,
											tmake_description ='SATURN'         and tmake_code='SATU' => 'STRN' ,           
											tmake_description ='SUZUKI'         and tmake_code='SUZI' => 'SUZU' ,
											tmake_description ='TRIUMPH'        and tmake_code='TRUM' => 'TRIU' ,
											tmake_description ='YAMAHA'         and tmake_code='YAM'  => 'YAMA' ,
											tmake_description ='CHRYSLER'       and tmake_code='IMPE' => 'CHRY' ,
											tmake_description ='YUGO'           and tmake_code='ZCZY' => 'YUGO' ,
											tmake_description ='STERLING'       and tmake_code='STLG' => 'STER' ,
											tmake_description ='STERLING'       and tmake_code='STRG' => 'STER' , tmake_code ); 
    self.make_description	  :=  tmake_description; 
		self.model_description	:=	stringlib.stringtouppercase(pInput.model_description);
	end;

	dCombinedUpper	:=	project(dCombined, tConvert2Upper(left));

	dCombined_dedup := dedup(sort(dCombinedUpper(make_code <> '' and make_description<>'' and model_description <> ''),
																make_code,
																make_description,
																model_description
															),
													make_code,
													make_description,
													model_description
													);

	// output(dCombined_dedup, named('combined_make_model'));
	// output(count(dCombined_dedup), named('cnt_combined_make_model'));

	rMakeStats_layout	:=
	record
		dCombined_dedup;
		unsigned4	cntModel	:=	0;
	end;

	dCombinedCntModel	:=	table(dCombined_dedup, rMakeStats_layout);

	rMakeStats_layout	tCountModels(dCombinedCntModel le, dCombinedCntModel ri)	:=
	transform
		self.cntModel	:=	le.cntModel + 1;
		self					:=	le;
	end;

	dCombinedMakeStats	:=	rollup(	dCombinedCntModel,
																	left.make_code				=	right.make_code	and
																	left.make_description	=	right.make_description,
																	tCountModels(left, right)
																);

	dCombinedMakeStats_sort		:=	sort(dCombinedMakeStats, make_code, -cntModel);
	dCombinedMakeStats_dedup	:=	dedup(dCombinedMakeStats_sort, make_code);

	// output(dCombinedMakeStats_dedup, all, named('make_code_stats'));

	//add make_id 

	rList_layout := 
	RECORD
		string MakeID;
		string MakeCode;
		string MakeDescription;
		string ModelDescription;
	 END;
	 
	rList_layout tSetMakeID(dCombinedMakeStats_dedup l, integer C) :=
	transform
		self.MakeID 					:= (string)c ;
		self.MakeCode 				:= l.make_code;
		self.MakeDescription	:= l.make_description;
		self.ModelDescription	:= '';
	end;

	dMakeID  := project(dCombinedMakeStats_dedup, tSetMakeID(left, counter));

	// output(dMakeID, all, named('added_makeID'));

	//set ID for all make/model

	rList_layout tAssignMakeID(dCombined_dedup l, dMakeID r) :=
	transform
		self.MakeID						:= stringlib.StringFilterOut(r.MakeID, '"');
		self.makecode					:= stringlib.StringFilterOut(l.make_code, '"');
		self.MakeDescription	:= stringlib.StringFilterOut(r.MakeDescription, '"');
		self.ModelDescription	:= stringlib.StringFilterOut(l.model_description, '"');
	end;

	dAssignMakeID := join(dCombined_dedup,
												dMakeID,
												left.make_code	=	right.MakeCode,
												tAssignMakeID(left,right)
												);

	dAssignMakeID_dedup	:=	dedup(sort(dAssignMakeID, record), record);

	vehiclev2.MAC_SF_BuildProcess(dAssignMakeID_dedup,
																'~thor_data400::out::vehicle_valid_make_model',
																dPickerCSVFile,2,true);
							 
	//despray file

	desprayPickerFile	:=	lib_fileservices.fileservices.Despray('~thor_data400::out::vehicle_valid_make_model',
																															_control.IPAddress.bctlpedata11,
																															'/data/data_999/vehreg_make_model/vehicle_valid_make_model_'+filedate+'.csv',
																															,,,TRUE);

	//verify nothing drop from the original file 

	dPicker tVerifyOriginal(dPicker le, dCombined_dedup ri)	:=
	transform
		self := le;
	end;

	dPickerOnly	:=	join(	dPicker,
												dCombined_dedup,
												left.make_code = right.make_code and
												left.make_description = right.make_description and
												left.model_description = right.model_description,
												tVerifyOriginal(left, right),
												left only
											);

	dPickerDroppedRecs	:=	if(	count(dPickerOnly) = 0,
															output('Nothing dropped from original file'),
															output('Check code again')
														);

	//build picker file on Thor and despray to edata12

	return	sequential(	dPickerCSVFile,
											desprayPickerFile,
											dPickerDroppedRecs,
											VehicleV2.BuildBodyStylePicker(filedate)
										);
end;