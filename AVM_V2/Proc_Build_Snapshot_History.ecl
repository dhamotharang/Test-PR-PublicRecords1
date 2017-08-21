EXPORT Proc_Build_Snapshot_History := module
import LN_PropertyV2,ut;
/////////////////////////////////////////////////////////////////////
// step 0:  caluculate date variables 
/////////////////////////////////////////////////////////////////////

string8 archive_date := map ( ut.Getdate[5..6] between '01' and '03' => ut.date_math(ut.Getdate,-180)[1..4]+'1230' ,
                 ut.Getdate[5..6] between '04' and '06' => ut.Getdate[1..4]+'0330',
								 ut.Getdate[5..6] between '07' and '09' => ut.Getdate[1..4]+'0630',
								 ut.Getdate[1..4]+'0930');
								 
string2 quarter := map ( ut.Getdate[5..6] between '01' and '03' => 'Q1' ,
                 ut.Getdate[5..6] between '04' and '06' => 'Q2',
								 ut.Getdate[5..6] between '07' and '09' => 'Q3',
								 'Q4');
								 
string4 year := ut.Getdate[1..4];

string8 build_date := ut.Getdate;

/////////////////////////////////////////////////////////////////////
// step 1:  make sure all the files it needs to build are available on thor
/////////////////////////////////////////////////////////////////////
								 
f1 := LN_PropertyV2.File_Search_DID;
f2 := LN_PropertyV2.File_Assessment;
f3 := LN_PropertyV2.File_Deed;
f4 := AVM_V2.File_OFHEO(archive_date);
f5 := AVM_V2.File_Hedonic_Weights_Table;
f6 := AVM_V2.File_Model_Accuracy_Table;

dFileChecks := if ( count(f1) > 10 and 
                    count(f2) > 10 and 
										count(f3) > 10 and 
										count(f4) > 10 and
										count(f5) > 10 and
										count(f6) > 10 , 'success', error('All of the inputs do not exist') );
										
										
/////////////////////////////////////////////////////////////////////
// step 2:  create history build
/////////////////////////////////////////////////////////////////////

	build_base := AVM_V2.File_AVM(archive_date);
	build_medians := AVM_V2.File_AVM_Medians(build_base, archive_date);
	
		
	build_median := sequential(
                            output(build_base,,   '~thor_data400::avm_v2::' + archive_date + '_automated_valuations_' + build_date, __compressed__);
                            output(build_medians,,'~thor_data400::avm_v2::' + archive_date + '_median_valuations_' + build_date, __compressed__)
                            );
	
	superfile_transaction := Sequential(
	                                     FileServices.StartSuperfiletransaction(),
																			 if ( FileServices.SuperFileExists('~thor_data400::avm_v2::'+year+'_'+quarter+'_automated_valuations'),
																			 FileServices.ClearSuperFile('~thor_data400::avm_v2::'+year+'_'+quarter+'_automated_valuations'),

																			 FileServices.CreateSuperfile('~thor_data400::avm_v2::'+year+'_'+quarter+'_automated_valuations')
																			 ),
                                      if ( FileServices.SuperFileExists	('~thor_data400::avm_v2::'+year+'_'+quarter+'_median_valuations'),
																			 FileServices.ClearSuperFile('~thor_data400::avm_v2::'+year+'_'+quarter+'_median_valuations'),

																			 FileServices.CreateSuperfile('~thor_data400::avm_v2::'+year+'_'+quarter+'_median_valuations')
																			 ),
																			 FileServices.AddSuperFile('~thor_data400::avm_v2::'+year+'_'+quarter+'_automated_valuations', '~thor_data400::avm_v2::' + archive_date + '_automated_valuations_' + build_date),
																			 FileServices.AddSuperFile('~thor_data400::avm_v2::'+year+'_'+quarter+'_median_valuations', '~thor_data400::avm_v2::' + archive_date + '_median_valuations_' + build_date),
																		FileServices.FinishSuperfiletransaction()
																		);
																		

																			 
	
export	dall := Sequential(
	                             dFileChecks,
															 build_median,
															 superfile_transaction
															 
															 );
end;															 
															 
									
	