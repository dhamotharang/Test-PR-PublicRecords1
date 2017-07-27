import crimsrch,fcra,lib_fileservices,_control;

// Function to create csv files to export to CROSS - Runs only when there is new crim corrections
// Parameters : filedate - Function uses this date to determine the logical file to 
// 				use for creating the export files


export Proc_Cross_Crim_Export(string filedate) := function

// Crim base file
Crim_Orig := Crimsrch.File_Moxie_Offender_Dev(offender_key <> '');
// FCRA Corrections flag records
Flag_Crim_Record := dataset('~thor_data400::in::override::fcra::'+filedate+'::flag',fcra.Layout_override_flag,flat,opt)(file_id = 'crim' and record_id[1..2] <> 'C2');
// FCRA Corrections Crim override records
Crim_Override := project(dataset('~thor_data400::in::override::fcra::'+filedate+'::crim_offender',fcra.layout_override_crim_offender,flat,opt)
				(offender_key <> '' and offender_key[1..2] <> 'C2' and data_type <> '4'),transform(fcra.layout_override_crim_offender-lf,self := left));

// Corrected records - csv file to export
// START
//**********************************************************************************************

//corrected_out := output(Crim_Override,,'~thor_data400::out::override::fcra::crim_offender_cross::corrected',overwrite,csv(heading(single)));
//**********************************************************************************************
// END

// Corrected original - corrected record in override, corresponding original record from base
// START
//**********************************************************************************************
typeof(Crimsrch.File_Moxie_Offender_Dev) get_corr(Crim_Orig l,Crim_Override r) := transform
	self := l;
end;

get_corr_join := dedup(join(Crim_Orig,Crim_Override,
							left.offender_key = right.offender_key,
							get_corr(left,right),
							lookup
							),record);

corr_out := output(get_corr_join,,'~thor_data400::out::orig::fcra::crim_offender_cross::corrected',overwrite,csv(heading(single)));
//**********************************************************************************************
// END

// Not corrected - deleted - offender key from base file available in flag file but 
// not in override file 
//**********************************************************************************************
// START

fcra.Layout_override_flag notcorrected(Flag_Crim_Record l,Crim_Override r) := transform
self := l;
end;

not_corr_join := join(Flag_Crim_Record,Crim_Override,
						left.record_id = right.offender_key,
						notcorrected(left,right),								
								left only);

typeof(Crimsrch.File_Moxie_Offender_Dev) get_not_corr(Crim_Orig l,not_corr_join r) := transform
	self := l;
end;

get_not_corr_join := dedup(join(Crim_Orig,not_corr_join,
							left.offender_key = right.record_id,
							get_not_corr(left,right),
							lookup
							),record);

not_corr_out := output(get_not_corr_join,,'~thor_data400::out::orig::fcra::crim_offender_cross::notcorrected',overwrite,csv(heading(single)));
//**********************************************************************************************
// END

// Despray all files to export to CROSS to edata12
//**********************************************************************************************
// START

despray_orig_notcorr := lib_fileservices.FileServices.Despray('~thor_data400::out::orig::fcra::crim_offender_cross::notcorrected',
					_control.IPAddress.edata12,'/thor_back5/riskwise/cross/orig_for_suppressed_'+filedate+'.csv',,,,TRUE);
despray_orig_corr := lib_fileservices.FileServices.Despray('~thor_data400::out::orig::fcra::crim_offender_cross::corrected',
					_control.IPAddress.edata12,'/thor_back5/riskwise/cross/orig_for_corrected_'+filedate+'.csv',,,,TRUE);
despray_override := lib_fileservices.FileServices.Despray('~thor_data400::out::override::fcra::crim_offender_cross::corrected',
					_control.IPAddress.edata12,'/thor_back5/riskwise/cross/override_'+filedate+'.csv',,,,TRUE);

//**********************************************************************************************
// END
					

return sequential(/*corrected_out*/not_corr_out,corr_out,
				despray_override,despray_orig_notcorr,despray_orig_corr);

end;