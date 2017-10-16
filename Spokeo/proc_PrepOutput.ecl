IMPORT STD;

EXPORT proc_PrepOutput(dataset(Spokeo.Layout_Out) fileIn) := FUNCTION

	Spokeo.Layout_Temp xForm(Spokeo.Layout_Out src) := TRANSFORM
				self.Prepped_name := STD.Str.CleanSpaces(Std.Str.ToUpperCase(src.name));
	
				SELF.prepped_addr1     := STD.Str.CleanSpaces(Std.Str.ToUpperCase(src.addr1));
				SELF.prepped_addr2     := STD.Str.CleanSpaces(
														trim(Std.Str.ToUpperCase(src.city)) + if(src.city <> '',',','')
															+ ' '+ Std.Str.ToUpperCase(src.State)
															+ ' '+ src.Zipcode);
															

				self := src;
				self := [];
	
	END;

	return PROJECT(fileIn, xForm(LEFT));

END;;