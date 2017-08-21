export File_IN_Raw := dataset(Prof_License.Constants.cluster + 'in::prolic::IN_Raw_updates::Superfile',Prof_License.Layout_IN_raw.input,csv(Heading(1),separator('|'),terminator('\n'),quote('"'),maxlength(999999)))(trim(stringlib.StringToUppercase(DartID),left,right)<>'DARTID');

