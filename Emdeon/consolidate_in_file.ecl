IMPORT Emdeon, ut;

EXPORT consolidate_in_file (STRING pVersion, BOOLEAN pUseProd) := FUNCTION

		raw_file			:= DATASET(Emdeon.Filenames(pVersion,pUseProd).claims_lInputPreTemplate,
																{STRING75 filename {virtual(logicalfilename)}, Emdeon.layouts.raw.pre_consolidated},
																CSV(terminator(['\r\n', '\n']), separator(['|']), quote([''])),
																__compressed__);
																
		new_consol		:= PROJECT(raw_file, TRANSFORM(Emdeon.Layouts.raw.orig_file, SELF := LEFT));

		new_file	:= OUTPUT(new_consol,,Emdeon.Filenames(pVersion,pUseProd).orig_lConsolTemplate, 
													CSV(separator('|'), quote(''), terminator('\n')), cluster('thor400_44'), OVERWRITE, compressed);
												
		write_and_move	:= SEQUENTIAL(
					new_file,
					FileServices.StartSuperFileTransaction(),
					FileServices.AddSuperFile(Emdeon.Filenames(pVersion,pUseProd).orig_lInputTemplate, Emdeon.Filenames(pVersion,pUseProd).orig_lConsolTemplate),
					FileServices.FinishSuperFileTransaction();
				);
					
		RETURN write_and_move;
	
END;
