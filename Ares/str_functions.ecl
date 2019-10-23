EXPORT str_functions := Module
import python;

//Pad left <, right >, center ^
string padx(string s, string where, string pad_char, integer count_x) := EMBED(PYTHON)
form =  "{:"+pad_char+where+str(count_x)+"}"
s =form.format(s)
return s
ENDEMBED;
Export pad(string s, string where, string pad_char, integer count_x) := padx(s, where, pad_char, count_x);



string mask_string(string instr, string format) := EMBED(PYTHON)
s = ""
cnt = 0
for c in format:
	if c == "#":
		if len(instr) > cnt:
			s+=instr[cnt]
		cnt+=1
	else:
		s+=c
return s
ENDEMBED;

Export mask(string instr, string format) := mask_string(instr, format);
// instr := '00863227';
// format := '##-###/####';
// mask(instr, format);

End;