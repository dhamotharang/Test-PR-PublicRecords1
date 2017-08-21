import lib_fileservices,_control,lib_stringlib;
/******************************** we have to make sure that
if we receive updates from Experian  
we have to run  this Â“FBNV2.fsprayFBNfilesÂ”  attribute passing file date 
for spray and to add new update raw files to 
Â“thor_data400::in::experian::sprayed::fbnÂ” supper file and
This is the superfile where all updates reside.
********************************/

// NOTES: This spray process serves a dual purpose. Not only does it have it's original purpose for spraying data for the
// FBNv2 build process, but it also places the latest Experian data into a FBN_extract superfile to be used by the FBN_CP_Extract
// build. 


export spray_raw_data(string st,string filedate):= function
		CreateSuper:=FileServices.CreateSuperFile(FBNv2.cluster.cluster_out + 'in::'+filedate+'::fbn_allStates',false);
								
		CreateSuperfileIfNotExist := if(NOT FileServices.SuperFileExists(FBNv2.cluster.cluster_out + 'in::'+filedate+'::fbn_allStates'),CreateSuper); 

		do_spray:=FileServices.SprayFixed(_control.IPAddress.bctlpedata11,'/data/data_build_4/fbn/sources/experian/'+filedate+'/'+st+'.txt',601,'thor400_44',cluster.cluster_out+'in::'+filedate+'::Fbn::'+st,-1,,,true,true);
		raw_fbn:=dataset(FBNv2.cluster.cluster_out+'in::'+filedate+'::Fbn::'+st,fbnv2.Layout_fbn_experian.fbn_direct,flat);


		fbnv2.Layout_fbn_experian.fbn_direct_raw trfNewLayout(raw_fbn input)	:=	transform
			self.Filing_state	:=	st;
			self				:=	input;
			self				:=	[];
		end;

		newfile:=OUTPUT(PROJECT(raw_fbn, trfNewLayout(left)), ,FBNv2.cluster.cluster_out+'in::'+filedate+'::Raw_Fbn::'+st);

		addSuper:=FileServices.AddSuperFile(FBNv2.cluster.cluster_out + 'in::'+filedate+'::fbn_allStates', 
				                         FBNv2.cluster.cluster_out+'in::'+filedate+'::Raw_Fbn::'+st);
										 
		Delete_old:=FileServices.DeleteLogicalFile(FBNv2.cluster.cluster_out+'in::'+filedate+'::Fbn::'+st);
		
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///// Check to see if state sprayed file is already in superfile.
///// If state sprayed file is present remove sprayed file from subsuperfile and respray and add to superfile again. 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		doSeq:= sequential(CreateSuperfileIfNotExist,
									  if (
									   fileservices.findsuperfilesubname(FBNv2.cluster.cluster_out + 'in::'+filedate+'::fbn_allStates', cluster.cluster_out+'in::'+filedate+'::Raw_Fbn::'+st) > 0,
									   fileservices.removesuperfile(FBNv2.cluster.cluster_out + 'in::'+filedate+'::fbn_allStates', cluster.cluster_out+'in::'+filedate+'::Raw_Fbn::'+st)),
									   sequential(do_spray,newfile,addSuper,Delete_old)
									   );									 
		return doSeq;
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///// Spray all states sequentially 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
export fsprayFBNfiles(string filedate):=function
			allStates_spray := sequential (spray_raw_data('AL',filedate)
											,spray_raw_data('AZ',filedate)
											,spray_raw_data('AR',filedate)
											,spray_raw_data('AK',filedate)
											,spray_raw_data('CO',filedate)
											,spray_raw_data('CT',filedate)
											,spray_raw_data('CA',filedate)
											,spray_raw_data('DC',filedate)
											,spray_raw_data('DE',filedate)
											,spray_raw_data('FL',filedate)
											,spray_raw_data('GA',filedate)
											,spray_raw_data('HI',filedate)
											,spray_raw_data('ID',filedate)
											,spray_raw_data('IN',filedate)
											,spray_raw_data('IA',filedate)
											,spray_raw_data('IL',filedate)
											,spray_raw_data('KS',filedate)
											,spray_raw_data('KY',filedate)
											,spray_raw_data('LA',filedate)
											,spray_raw_data('MA',filedate)
											,spray_raw_data('MD',filedate)
											,spray_raw_data('ME',filedate)
											,spray_raw_data('MI',filedate)
											,spray_raw_data('MN',filedate)
											,spray_raw_data('MO',filedate)
											,spray_raw_data('MS',filedate)
											,spray_raw_data('MT',filedate)
											,spray_raw_data('NC',filedate)
											,spray_raw_data('ND',filedate)
											,spray_raw_data('NE',filedate)
											,spray_raw_data('NH',filedate)
											,spray_raw_data('NJ',filedate)
											,spray_raw_data('NM',filedate)
											,spray_raw_data('NV',filedate)
											,spray_raw_data('NY',filedate)
											,spray_raw_data('OH',filedate)
											,spray_raw_data('OK',filedate)
											,spray_raw_data('OR',filedate)
											,spray_raw_data('PA',filedate)
											,spray_raw_data('RI',filedate)
											,spray_raw_data('SC',filedate)
											,spray_raw_data('SD',filedate)
											,spray_raw_data('TN',filedate)
											,spray_raw_data('TX',filedate)
											,spray_raw_data('UT',filedate)
											,spray_raw_data('VA',filedate)
											,spray_raw_data('VT',filedate)
											,spray_raw_data('WA',filedate)
											,spray_raw_data('WI',filedate)
											,spray_raw_data('WV',filedate)
											,spray_raw_data('WY',filedate) );
											
			sprayLocTable := sequential (	FileServices.SprayVariable(_control.IPAddress.bctlpedata11,'/data/data_build_4/fbn/sources/experian/'+filedate+'/LOCC.txt',1000,'|','\\n,\\r\\n',,
																		'thor400_44',cluster.cluster_out + 'lookup::'+filedate+'::fbn_experian::locationcode_table',-1,,,true,true),
																		FileServices.StartSuperFileTransaction(),
																		FileServices.ClearSuperFile(cluster.cluster_out + 'lookup::fbn_experian::locationcode_table'),
																		FileServices.AddSuperFile(cluster.cluster_out + 'lookup::fbn_experian::locationcode_table', 
																															cluster.cluster_out + 'lookup::'+filedate+'::fbn_experian::locationcode_table'), 
																		FileServices.FinishSuperFileTransaction()
																	);
																		
			CreateSuperfiles 							:=	FileServices.CreateSuperFile(cluster.cluster_out + 'in::experian::sprayed::fbn',false);
			
			CreateExtractSuperfiles				:=	FileServices.CreateSuperFile(cluster.cluster_out + 'in::fbn_extract::sprayed::experian',false);
								
			CreateSuperIfNotExist 				:= 	if(NOT FileServices.SuperFileExists(cluster.cluster_out + 'in::experian::sprayed::fbn'),CreateSuperfiles); 
			
			CreateExtractSuperIfNotExist 	:= 	if(NOT FileServices.SuperFileExists(cluster.cluster_out + 'in::fbn_extract::sprayed::experian'),CreateExtractSuperfiles); 

			ConsolidatedFile	:=	dataset(FBNv2.cluster.cluster_out + 'in::'+filedate+'::fbn_allStates', fbnv2.Layout_fbn_experian.fbn_direct_raw, thor);
			consolidate				:=	output(ConsolidatedFile,,FBNv2.cluster.cluster_out + 'prep::'+filedate+'::fbn_experian_consolidated', compressed);
		
			super_main 				:= sequential(	
																				FileServices.StartSuperFileTransaction(),
																				FileServices.AddSuperFile(cluster.cluster_out + 'in::experian::sprayed::fbn', 
																																	FBNv2.cluster.cluster_out + 'prep::'+filedate+'::fbn_experian_consolidated'), 
																				FileServices.FinishSuperFileTransaction()
																			);
									 
			superExtractMain 	:= sequential(	
																				FileServices.StartSuperFileTransaction(),
																				FileServices.ClearSuperFile(cluster.cluster_out + 'in::fbn_extract::sprayed::experian'),
																				FileServices.AddSuperFile(cluster.cluster_out + 'in::fbn_extract::sprayed::experian', 
																																	FBNv2.cluster.cluster_out + 'prep::'+filedate+'::fbn_experian_consolidated'), 
																				FileServices.FinishSuperFileTransaction()
																			);
									 
			add_super 				:= if(FileServices.FindSuperFileSubName(cluster.cluster_out + 'in::experian::sprayed::fbn', cluster.cluster_out + 'prep::'+filedate+'::fbn_experian_consolidated') = 0,super_main); 
			
			addExtractSuper 	:= if(FileServices.FindSuperFileSubName(cluster.cluster_out + 'in::fbn_extract::sprayed::experian',	cluster.cluster_out + 'prep::'+filedate+'::fbn_experian_consolidated') = 0,superExtractMain); 
			
			DeleteFiledateSuper	:=	FileServices.DeleteSuperFile(FBNv2.cluster.cluster_out + 'in::'+filedate+'::fbn_allStates', TRUE);

			do_super := sequential
														(	CreateSuperIfNotExist,
															CreateExtractSuperIfNotExist,  	//This is for the FBN_CP_Extract build process - see notes at top of attribute
															allStates_spray,
															consolidate,
															add_super,
															addExtractSuper,  							//This is for the FBN_CP_Extract build process - see notes at top of attribute
															sprayLocTable,
															DeleteFiledateSuper
															,notify('Experian FBN Spray Complete','*')
															);

			return do_super;

end;
							
							