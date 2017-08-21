
import lib_stringlib;


 Filing_In := File_CP_Hist_Filing_raw_in;


alnum_filter := '[^[:alnum:]]';

//The function to clean the leading non alpha numberic [@%&[]]characters from a given string.
string cleanLeadingNonAlpNumChars(string instr) := function
  s := regexreplace(alnum_filter, instr, '', nocase);
	fchar := if (length(s) > 0, s[1], '');  //take only first byte
	pos := if (fchar = '', 0, lib_stringlib.StringLib.StringFind(instr, fchar, 1));
  return(if (pos > 0, instr[pos..], ''));
end;

//Excluding the records when specialChar as Filing number form filing file "ex: ~ ~,`,/,+,# ")
specialChar_Filings:=  Filing_In(stringlib.StringReverse(cleanLeadingNonAlpNumChars(FILING_NUM1))<>'' ) ; 

//Transform to removing special charecter as first charecter in Filing number form filing file  "ex: "[990406920", "!006-0000254","&990403452" ...etc;
Layout_FBN_CP_HIST.Layout_In_Filing trans_removeSpecialChar(specialChar_Filings l):=transform


self.FILING_NUM1:=cleanLeadingNonAlpNumChars(l.FILING_NUM1);
self:=l;

end;

ds_Valid_FilingNumber:=project(specialChar_Filings,trans_removeSpecialChar(left)):persist(cluster.cluster_out+'persist::FBNV2::CP_HIST_validfilings');

export FBN_CP_HIST_Validations := ds_Valid_FilingNumber;

