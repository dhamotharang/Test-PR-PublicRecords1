dss :=
DATASET('~images::in::pa_info20031211', Layout_PAdc_Info,
		csv(HEADING(0), SEPARATOR(','), TERMINATOR(['\n', '\r\n']), QUOTE('"'))) +
DATASET('~images::in::pa_info20040108', Layout_PAdc_Info,
		csv(HEADING(0), SEPARATOR(','), TERMINATOR(['\n', '\r\n']), QUOTE('"'))) + 
DATASET('~images::in::pa_info20040209', Layout_PAdc_Info,
		csv(HEADING(0), SEPARATOR(','), TERMINATOR(['\n', '\r\n']), QUOTE('"'))) +
DATASET('~images::in::pa_info20040305', Layout_PAdc_Info,
		csv(HEADING(0), SEPARATOR(','), TERMINATOR(['\n', '\r\n']), QUOTE('"')));



openParen(string str) := Stringlib.stringfind(str, '{', 1);
closeParen(string str) := Stringlib.stringfind(str, '}', 1)+LENGTH('.jpg');


Images.Layout_PAdc_Info getfilename(Images.Layout_PAdc_Info L) :=
TRANSFORM
	SELF.filename := L.filename[openParen(L.filename)..closeParen(L.filename)];
	SELf := L;
END;
p := PROJECT(dss, getfilename(LEFT));

export File_PAdc_Info := p;