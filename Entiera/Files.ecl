import	ut;

export Files
 :=
	module

		// Dataset reference for the sprayed file.  Must pass the full filename of the sprayed file.  Used only to read to write prep.
		export 	In_Sprayed(string pFileName)
		 :=
			dataset(pFileName,Layouts.In_Sprayed,csv(heading(single),
																							 quote(Constants.InFileCSVQuote),
																							 separator(Constants.InFileCSVSeparator),
																							 terminator(Constants.InFileCSVTerminator),
																							 maxlength(Constants.InFileCSVMaxLength)
																							)
						 );

		// Dataset reference for the prepped file (from sprayed).  If omitted parameter, will grab superfile with all prepped files in it.  Otherwise, can be single prepped file.
		export 	In_Prepped(string pFileName = Constants.PreppedFileSuperFileName)
		 :=
			dataset(/*ut.foreign_prod +*/ pFileName,Layouts.In_Prepped,csv(heading(single),
																																 quote(Constants.PrepFileCSVQuote),
																																 separator(Constants.PrepFileCSVSeparator),
																																 terminator(Constants.PrepFileCSVTerminator),
																																 maxlength(Constants.PrepFileCSVMaxLength)
																																)
						 );

		export	Base	:=	dataset(/*ut.foreign_prod +*/ Constants.BaseFileSuperFileName,Layouts.Base,thor);
	end
 ;