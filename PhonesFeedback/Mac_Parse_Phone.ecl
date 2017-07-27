export Mac_Parse_Phone(ds1, field, recordid, results) := MACRO;

// Parse routine to find US Phone numbers in the input data
// Parameters: input data set, field to search, record id field, returned data set
// Self-contained for portability to customer systems
#uniquename(numbers)
#uniquename (ws)
#uniquename (separation)
#uniquename (digit)
pattern %digit% := pattern('[0-9]');
pattern %numbers% := %digit%+; // String of one or more numbers
pattern %ws% := PATTERN('[ \t\r\n]')*; // String of zero or more white space
#uniquename (sepchar)
pattern %sepchar% := pattern('[-./ ]');
pattern %separation% := %ws% %sepchar% %ws%; // Separator for SSNs

#uniquename(OpenParen)
#uniquename(CloseParen)
pattern %OpenParen% := ['[','(','{','<'];
pattern %CloseParen% := [']', ')', '}', '>'];

// Pattern for leading 0/1stuff
#uniquename(FrontDigit)
pattern %FrontDigit% := ['1', '0', '01', '011'] OPT(%separation%);

#uniquename(ac)
#uniquename(accore)
pattern %accore% := pattern('[2-9]') %numbers% length(2);
pattern %ac% := OPT(%FrontDigit%) OPT(%OpenParen%)  %accore% opt(%CloseParen%);
#uniquename(sevens)
// Seven digits
pattern %sevens% := %numbers% length(3) %sepchar%+ %numbers% length(4);

// Full phone number
#uniquename(phone1)
#uniquename(phone)
pattern %phone% := %accore% (%sepchar% | ')')+ %sevens%;
//pattern %phone% := %phone1% not after %digit% not before %digit%;


#uniquename (phonerec)
%phonerec% := RECORD
// qstring4 areaCode := stringlib.stringfilter(matchtext(%accore%), '0123456789');
// qstring7 phonenumber := stringlib.stringfilter(matchtext(%sevens%), '0123456789');
string PhoneNumber := stringlib.stringfilter(matchtext(%phone%), '0123456789');
// integer4 location := matchposition(%phone%);
// ds1.recordid;
end;

// Run the parse
results := parse(ds1, field, %phone%, %phonerec%, first, scan)
ENDMACRO;
