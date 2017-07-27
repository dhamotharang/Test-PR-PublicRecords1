// The following macro appends a 10-character clean phone field to 
// an existing recordset.  The format of the output file will be the
// input file record layout with the new field added at the end.  The source
// field for the cleaning can be any existing string field in the record.
//

export MAC_CleanPhone_Append(infile, source_field, clean_phone_field_name, outfile) := macro

#uniquename(numbers)
pattern %numbers% := pattern('[0-9]')+;

#uniquename(alpha)
pattern %alpha% := pattern('[A-Za-z]')+;

#uniquename(ws)
pattern %ws% := [' ','\t']*;

#uniquename(sepchar)
pattern %sepchar% := pattern('[-./ ]');

#uniquename(seperator)
pattern %seperator% := %ws% %sepchar% %ws%;

// Area Code
#uniquename(OpenParen)
pattern %OpenParen% := ['[','(','{','<'];
#uniquename(CloseParen)
pattern %CloseParen% := [']',')','}','>'];
#uniquename(FrontDigit)
pattern %FrontDigit% := ['1', '0'] OPT(%Seperator%);
#uniquename(areacode)
pattern %areacode% := OPT(%FrontDigit%) OPT(%OpenParen%) %numbers% length(3) OPT(%CloseParen%);

// Last Seven digits
#uniquename(exchange)
pattern %exchange% := %numbers% length(3);
#uniquename(lastfour)
pattern %lastfour% := %numbers% length(4);
#uniquename(seven)
pattern %seven% := %exchange% OPT(%seperator%) %lastfour%;

// Extension
#uniquename(extension)
pattern %extension% := %ws% %alpha% OPT(%sepchar%) %ws% %numbers%;

#uniquename(phonenumber)
pattern %phonenumber% := OPT(%areacode%) OPT(%Seperator%) %seven%  opt(%extension%) %ws%;

#uniquename(layout_phone_append)
%layout_phone_append% := record
infile;
string10 clean_phone_field_name := MAP( NOT matched(%phonenumber%) => '',
                                        NOT matched(%areacode%) => '000' + matchtext(%exchange%) + matchtext(%lastfour%),
                                        matchtext(%areacode%/%numbers%) + matchtext(%exchange%) + matchtext(%lastfour%));
end;

outfile := parse(infile, source_field, %phonenumber%, %layout_phone_append%, first, not matched, whole);

endmacro;