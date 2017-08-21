import tools;

EXPORT Files(STRING  pversion = '', BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	// -- Input File 
	EXPORT Input := MODULE
	
	  tools.mac_FilesInput(Corp2_Raw_NJ.Filenames(pversion, pUseOtherEnvironment).Input.Business, Corp2_Raw_NJ.Layouts.BlobRec, Corporation,
		           'CSV', , pTerminator := ['\r\n','\n'], pSeparator := '', pHeading := 1);
							 
		Corp2_Raw_NJ.Layouts.BlobRec blobTrf(Corp2_Raw_NJ.Layouts.BlobRec l):= transform
			self.blob := StringLib.StringFindReplace(l.blob,'","','"|"');
		end; 
		
		cleanBlob	:= project(Corporation.Logical, blobTrf(left));
		output(cleanBlob,,'~thor_data400::in::corp2::'+pversion+'::pipedelim::business::nj',csv,overwrite);

		EXPORT PipeDelim := dataset('~thor_data400::in::corp2::'+pversion+'::pipedelim::business::nj'
					,corp2_raw_nj.layouts.BusinessLayoutIn ,CSV(SEPARATOR(['|']), QUOTE('"'), TERMINATOR(['\r\n', '\n'])));		
	END;
                  
	// -- Base File 
	EXPORT Base := MODULE
		tools.mac_FilesBase(Filenames(pversion, pUseOtherEnvironment).Base.Business, Corp2_Raw_NJ.Layouts.BusinessLayoutBase, Corporation);
	END;

END;