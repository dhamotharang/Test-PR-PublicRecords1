export Parse_Input :=
module
	
	/////////////////////////////////////////////////////////////////////////
	// -- Modify XML to work on thor
	/////////////////////////////////////////////////////////////////////////
	export PreProcess :=
	module
	
		export Companies(dataset(layouts.Input.Sprayed) pInputFile) :=
		function
			
			layouts.Input.Sprayed tPreProcess(layouts.Input.Sprayed l) :=
			transform
				
				line := regexreplace('<[?]xml version="1.0" standalone="no"[?].*|<FIELD .*|</FIELDS>|</METADATA>|<ROWDATA>|</ROWDATA>|</DATA>|&[^ ;]*?;|\r\n', l.line, ' ');
				self.line := if(line != '','<ROWDATA><ROWS>' + line + ' /> </ROWS></ROWDATA>', '');

			end;

			dPreProcess := project(pInputFile, tPreProcess(left));
			
			return dPreProcess(line != '');

		end;

		export Contacts(dataset(layouts.Input.Sprayed) pInputFile) :=
		function
			
			layouts.Input.Sprayed tPreProcess(layouts.Input.Sprayed l) :=
			transform
				
				line := regexreplace('<[?]xml version.*|<FIELD .*|</FIELDS>|</METADATA>|<ROWDATA>|</ROWDATA>|</DATA>|&[^ ;]*?;|\r\n'													, l.line, ' ');
				self.line := if(line != '','<ROWDATA><ROWS>' + line + ' /> </ROWS></ROWDATA>', '');

			end;

			dPreProcess := project(pInputFile, tPreProcess(left));
			
			return dPreProcess(line != '');

		end;
	
	end;

	export Companies(dataset(layouts.Input.Sprayed) pInputFile) :=
	function

		companies_parsed	:= parse(pInputFile, line, layouts.Input.Parsed.Companies, xml('ROWDATA/ROWS'));

		return companies_parsed;
	
	end;

	export Contacts(dataset(layouts.Input.Sprayed) pInputFile) :=
	function

		contacts_parsed	:= parse(pInputFile, line, layouts.Input.Parsed.Contacts, xml('ROWDATA/ROWS'));

		return contacts_parsed;
	
	end;

end;