IMPORT hxmx, ut;

EXPORT consolidate_in_file := MODULE

	EXPORT hx (STRING pVersion, BOOLEAN pUseProd) := FUNCTION

			raw_hx_file			:= DATASET(hxmx.Filenames(pVersion,pUseProd).hx_lInputTemplate,
																	{STRING75 filename {VIRTUAL(logicalfilename)}, hxmx.layouts.input.hx_record},
																	CSV(terminator(['\r\n', '\n']), separator(['|']), quote([''])),
																	__compressed__);

			new_hx_consol		:= PROJECT(raw_hx_file, TRANSFORM(hxmx.Layouts.consolidated.hx_record, SELF := LEFT));

			new_hx_file	:= OUTPUT(new_hx_consol,,hxmx.Filenames(pVersion,pUseProd).hx_consol_lConsolTemplate, 
								CSV(separator('|'), quote(''), terminator('\n')), cluster('thor400_44'),OVERWRITE, compressed);
								
			write_and_move	:= SEQUENTIAL(
						new_hx_file,
						FileServices.StartSuperFileTransaction(),
						FileServices.AddSuperFile(hxmx.Filenames(pVersion,pUseProd).hx_consol_lInputTemplate, hxmx.Filenames(pVersion,pUseProd).hx_consol_lConsolTemplate),
						FileServices.AddSuperFile(hxmx.Filenames(pVersion,pUseProd).hx_lDeleteTemplate,hxmx.Filenames(pVersion,pUseProd).hx_lInputTemplate,addcontents := true),
						FileServices.ClearSuperFile(hxmx.Filenames(pVersion,pUseProd).hx_lInputTemplate),
						FileServices.AddSuperFile(hxmx.Filenames(pVersion,pUseProd).hx_lInputTemplate, hxmx.Filenames(pVersion,pUseProd).hx_consol_lConsolTemplate),
						FileServices.FinishSuperFileTransaction());

			RETURN write_and_move;

	END;

	EXPORT mx (STRING pVersion, BOOLEAN pUseProd) := FUNCTION

			raw_mx_file			:= DATASET(hxmx.Filenames(pVersion,pUseProd).mx_lInputTemplate,
																	{STRING75 filename {VIRTUAL(logicalfilename)}, hxmx.layouts.input.mx_record},
																	CSV(terminator(['\r\n', '\n']), separator(['|']), quote([''])),
																	__compressed__);

			new_mx_consol		:= PROJECT(raw_mx_file, TRANSFORM(hxmx.Layouts.consolidated.mx_record, SELF := LEFT));

			new_mx_file	:= OUTPUT(new_mx_consol,,hxmx.Filenames(pVersion,pUseProd).mx_consol_lConsolTemplate, 
								CSV(separator('|'), quote(''), terminator('\n')), cluster('thor400_44'),OVERWRITE, compressed);

			write_and_move	:= SEQUENTIAL(
						new_mx_file,
						FileServices.StartSuperFileTransaction(),
						FileServices.AddSuperFile(hxmx.Filenames(pVersion,pUseProd).mx_consol_lInputTemplate, hxmx.Filenames(pVersion,pUseProd).mx_consol_lConsolTemplate),
						FileServices.AddSuperFile(hxmx.Filenames(pVersion,pUseProd).mx_lDeleteTemplate,hxmx.Filenames(pVersion,pUseProd).mx_lInputTemplate,addcontents := true),
						FileServices.ClearSuperFile(hxmx.Filenames(pVersion,pUseProd).mx_lInputTemplate),
						FileServices.AddSuperFile(hxmx.Filenames(pVersion,pUseProd).mx_lInputTemplate, hxmx.Filenames(pVersion,pUseProd).mx_consol_lConsolTemplate),
						FileServices.FinishSuperFileTransaction());

			RETURN write_and_move;

	END;
	
END;