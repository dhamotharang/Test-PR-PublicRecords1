EXPORT Standardize_Entity       := 
MODULE

EXPORT Clean_Name(pInputFile) := 
FUNCTIONMACRO
	import address, ut;
	pInputFile tr(pInputFile l) := TRANSFORM
			clean_full_name := if(l.raw_full_name='', ut.CleanSpacesAndUpper(l.raw_first_name + ' ' + l.raw_middle_name + ' ' + l.raw_last_name), l.raw_full_name);
			cleanperson73								:= Address.cleanperson73(clean_full_name);
			SELF.cleaned_name.fname				:= ut.CleanSpacesAndUpper(cleanperson73[6..25]);
			SELF.cleaned_name.mname				:= ut.CleanSpacesAndUpper(cleanperson73[26..45]); 
			SELF.cleaned_name.lname				:= ut.CleanSpacesAndUpper(cleanperson73[46..65]);
			SELF.cleaned_name.name_score		:= ut.CleanSpacesAndUpper(cleanperson73[71..73]);		

			SELF.cleaned_name.title 				:= ut.fGetTitle(ut.CleanSpacesAndUpper(regexreplace('\\n|\\t',l.raw_Title,'')));
			SELF.cleaned_name.name_suffix 	:= ut.fGetSuffix(ut.CleanSpacesAndUpper(regexreplace('\\n|\\t',l.raw_Orig_Suffix,''))); 	
			SELF:=l;
	END;

	cleaned_name := project(pInputFile,tr(left));

  RETURN cleaned_name;
	
ENDMACRO;

EXPORT Clean_Phone( pInputFile ) := 
FUNCTIONMACRO
	import tools;
	tools.mac_AppENDCleanPhone(pInputFile ,phone_number	,dphone_number	,clean_phones.phone_number	,,true);
	tools.mac_AppENDCleanPhone(dphone_number	,cell_phone		,dcell_phone		,clean_phones.cell_phone		,,true);
  RETURN dphone_number;
	
ENDMACRO;

EXPORT Clean_InputFields(pInputFile) := 
FUNCTIONMACRO
	import std,_Validate,ut;
	pInputFile tr(pInputFile l) := TRANSFORM

		SELF.clean_ssn				:= If(regexfind('^[0-9]*$',ut.CleanSpacesAndUpper(l.ssn)) = true,ut.CleanSpacesAndUpper(l.ssn),'');
		SELF.clean_Ip_address := If(Count(Std.Str.SplitWords(l.ip_address,'.')) =4,l.ip_address,''); 
		SELF.clean_Zip				:= If(regexfind('^[0-9]*$',	STD.Str.CleanSpaces(regexreplace('-',l.zip,''))) = true,
						if(length(STD.Str.CleanSpaces(regexreplace('-',l.zip,''))) in [5,9],l.zip,'')
						,'');

		valid_dl := if (ut.CleanSpacesAndUpper(l.Drivers_License_State) <> ''
						AND ut.CleanSpacesAndUpper(l.Drivers_License) <> ''	
						AND ut.CleanSpacesAndUpper(l.Drivers_License_State) IN FraudGovPlatform.Constants().states,
						true,false);

		SELF.clean_Drivers_License.Drivers_License := if (valid_dl,l.Drivers_License,'');
		SELF.clean_Drivers_License.Drivers_License_State := if (valid_dl,l.Drivers_License_State,'');
		SELF.clean_dob				:= if (_Validate.Date.fIsValid(l.dob) and 
														(unsigned)l.dob <= (unsigned)(STRING8)Std.Date.Today(),
														_validate.date.fCorrectedDateString(l.dob),
														'00000000');	
		SELF:=l;
	END;

	Cleaned_InputFields := project(pInputFile,tr(left));

  RETURN Cleaned_InputFields;
	
ENDMACRO;

EXPORT dRefreshLexid(pInputFile) := 
FUNCTIONMACRO

	// Append Lexid only to those records without DID
	DID_unassigned := pInputFile;
	RefreshLexid := Standardize_Entity.Append_Lexid (DID_unassigned);
	
	pInputFile t1(pInputFile L, RefreshLexid R) := transform
		self.did := IF(R.did > 0, R.did, L.did);
		self.did_score := IF(R.did_score > 0, R.did_score, L.did_score);
		self := IF(R.did > 0, R, L);
	end;
	
	updateInputFile := join(pInputFile,
					 RefreshLexid,
					 left.unique_id = right.unique_id,
					 t1(left,right),
					 left outer);
	
	RETURN updateInputFile;
	
ENDMACRO;

END; 
