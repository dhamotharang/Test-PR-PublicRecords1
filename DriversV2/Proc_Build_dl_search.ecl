import doxie_build, DriversV2, Roxiekeybuild;

export proc_build_dl_search(string filedate) :=
function

dofirst  := DriversV2.Proc_Build_DL_Search_Base;

dosecond := DriversV2.Proc_Build_DL_Search_Keys(filedate);

movetoqa := DriversV2.Proc_AcceptSK_dl_toQA;

dothird  := DriversV2.Proc_Build_DL_Keys(filedate);

dofourth := Driversv2.Proc_Build_DL_CP_Keys(filedate);

dolast   := Driversv2.Proc_Build_Boolean_keys(filedate);

// Update dops page upon keybuild completion
dlv2_dops_update := sequential(RoxieKeybuild.updateversion('DLV2Keys',DriversV2.Version_Development,'fhumayun@seisint.com'));

e_mail_success := fileservices.sendemail('roxiebuilds@seisint.com;fhumayun@seisint.com;vniemela@seisint.com;giri.rajulapalli@lexisnexis.com',
										 'DL2 Roxie Build Succeeded ' + filedate,
										 'DL keys: ------, \n' +
										 '    1) ~thor_data400::key::dl2::qa::dl_public(~thor_data400::key::dl2::'+filedate+'::dl_public),\n' + 
										 '	  2) ~thor_data400::key::dl2::qa::dl_number_public(~thor_data400::key::dl2::'+filedate+'::dl_number_public),\n' + 
										 '    3) ~thor_data400::key::dl2::qa::dl_indicatives_public(~thor_data400::key::dl2::'+filedate+'::indicatives_public),\n' + 
										 '    4) ~thor_data400::key::dl2::qa::dl_did_public(~thor_data400::key::dl2::'+filedate+'::did_public),\n' + 
										 '    5) ~thor_data400::key::dl2::qa::bocaShell_DL_DID(~thor_data400::key::dl2::'+filedate+'::bocashell_did),\n' + 
										 '    6) ~thor_data400::key::dl2::fcra::qa::bocaShell.DID(~thor_data400::key::dl2::fcra::'+filedate+'::bocashell.did),\n' + 
                                         '    7) ~thor_data400::key::dl2::qa::DL_Seq(~thor_data400::key::dl2::'+filedate+'::DL_Seq),\n' + 
										 '    8) ~thor_data400::key::dl2::autokey::qa::payload(~thor_data400::key::dl2::'+filedate+'::autokey::payload),\n' + 
										 '    9) ~thor_data400::key::dl2::autokey::qa::SSN2(~thor_data400::key::dl2::'+filedate+'::autokey::SSN2),\n' + 
										 '   10) ~thor_data400::key::dl2::autokey::qa::Address(~thor_data400::key::dl2::'+filedate+'::autokey::Address),\n' + 
										 '   11) ~thor_data400::key::dl2::autokey::qa::Name(~thor_data400::key::dl2::'+filedate+'::autokey::Name),\n' + 
										 '   12) ~thor_data400::key::dl2::autokey::qa::StName(~thor_data400::key::dl2::'+filedate+'::autokey::StName),\n' + 
										 '   13) ~thor_data400::key::dl2::autokey::qa::CityStName(~thor_data400::key::dl2::'+filedate+'::autokey::CityStName),\n' + 
										 '   14) ~thor_data400::key::dl2::autokey::qa::Zip(~thor_data400::key::dl2::'+filedate+'::autokey::Zip),\n' + 
										 'DL Boolean Keys: -------, \n' +
										 '   15) ~thor_data400::key::dlv2::qa::dictindx(~thor_data400::key::dlv2::'+filedate+'::dictindx),\n' + 
										 '   16) ~thor_data400::key::dlv2::qa::docref.dlseq(~thor_data400::key::dlv2::'+filedate+'::docref.dlseq),\n' + 
										 '   17) ~thor_data400::key::dlv2::qa::nidx(~thor_data400::key::dlv2::'+filedate+'::nidx),\n' + 
										 '   18) ~thor_data400::key::dlv2::qa::xdstat(~thor_data400::key::dlv2::'+filedate+'::xdstat),\n' + 
										 '   19) ~thor_data400::key::dlv2::qa::xseglist(~thor_data400::key::dlv2::'+filedate+'::xseglist),\n' + 
										 'DL Conviction Keys: -------, \n' +
										 '   20) ~thor_data400::key::dl2::qa::Conviction_DLCP_Key(~thor_data400::key::dl2::'+filedate+'::Conviction_DLCP_Key),\n' + 
										 '   21) ~thor_data400::key::dl2::qa::Suspension_DLCP_Key(~thor_data400::key::dl2::'+filedate+'::Suspension_DLCP_Key),\n' + 
										 '   22) ~thor_data400::key::dl2::qa::DR_Info_DLCP_Key(~thor_data400::key::dl2::'+filedate+'::DR_Info_DLCP_Key),\n' + 
										 '   23) ~thor_data400::key::dl2::qa::Accident_DLCP_Key(~thor_data400::key::dl2::'+filedate+'::Accident_DLCP_Key),\n' + 
										 '   24) ~thor_data400::key::dl2::qa::FRA_Insur_DLCP_Key(~thor_data400::key::dl2::'+filedate+'::FRA_Insur_DLCP_Key),\n' + 
										 '    have been built and ready to be deployed to QA.');
				
e_mail_fail := fileservices.sendemail('fhumayun@seisint.com;giri.rajulapalli@lexisnexis.com',
                                      'DL2 Roxie Build FAILED',
									  failmessage);

email_notify := sequential(dofirst, dosecond, movetoqa, dothird, dofourth, dolast,dlv2_dops_update) : 
				success(e_mail_success), 
				FAILURE(e_mail_fail);

return email_notify;

end;