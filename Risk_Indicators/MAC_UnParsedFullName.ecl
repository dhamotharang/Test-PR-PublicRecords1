/*2016-09-28T16:35:40Z (khuls)
C:\Users\hulske01\AppData\Roaming\HPCC Systems\eclide\khuls\New_Dataland\Risk_Indicators\MAC_UnParsedFullName\2016-09-28T16_35_40Z.ecl
*/
/*2016-05-21T00:43:45Z (Kevin Huls)
Automated reinstate from 2016-05-19T17:50:17Z
*/
export MAC_UnParsedFullName(title_val,fname_val,mname_val,lname_val,suffix_val,fname,mname,lname,NameSuffix) := MACRO
	#uniquename(unparsed_fullname_value)
	string120 %unparsed_fullname_value% :='':stored('UnParsedFullName');

	#uniquename(useFML)
	boolean %useFML% := false : stored('cleanNameFML');		// for services still using the old option (Identifier2), set name parser to FML if on
								 
	#uniquename(nameSeq)
	string 	%nameSeq% 	:= '' : stored('NameInputOrder');		// this indicates sequence of input name (FML or LFM)
	
  #uniquename(cleaned_name)
	%cleaned_name% := Stringlib.StringToUppercase(
										map(trim(Stringlib.StringToUppercase(%nameSeq%)) = 'FML' or %useFML% => Address.CleanPersonFML73(%unparsed_fullname_value%),
												trim(Stringlib.StringToUppercase(%nameSeq%)) = 'LFM' 						 => Address.CleanPersonLFM73(%unparsed_fullname_value%),
																																														Address.CleanPerson73(%unparsed_fullname_value%)));

	#uniquename(valid_cleaned)
	boolean %valid_cleaned% := %unparsed_fullname_value%<>'';

	#uniquename(pre_fname_val)
	string30 %pre_fname_val% := '' : stored(fname);
	string30 fname_val :=if(%pre_fname_val%='' AND %valid_cleaned%,%cleaned_name%[6..25],%pre_fname_val%);

	#uniquename(pre_mname_val)
	string30 %pre_mname_val% := '' : stored(mname);
	string30 mname_val :=if(%pre_mname_val%='' AND %valid_cleaned%,%cleaned_name%[26..45],%pre_mname_val%);

	#uniquename(pre_lname_val)
	string30 %pre_lname_val% := '' : stored(lname);
	string30 lname_val :=if(%pre_lname_val%='' AND %valid_cleaned%,%cleaned_name%[46..65],%pre_lname_val%);

	#uniquename(pre_suffix_val)
	string5 %pre_suffix_val% :='' : stored(NameSuffix);
	string5 suffix_val := if(%pre_suffix_val%='' AND %valid_cleaned%,%cleaned_name%[66..70],%pre_suffix_val%);

	string5 title_val :=if(%valid_cleaned%,%cleaned_name%[1..5],'');
ENDMACRO;
