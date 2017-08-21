export MAC_555_phones(infile, field, outfile) := macro

#uniquename(phoneFix)
typeof(infile) %phoneFix%(infile l) := transform

 #uniquename(v_phone)
 #uniquename(phone_length)

 %v_phone%      := l.field; 
 %phone_length% := length(trim(%v_phone%));
 
 self.field := if(%phone_length%=10 and %v_phone%[4..6]='555',                 '',
               if(%phone_length%=7  and %v_phone%[1..3]='555',                 '',
			   if(stringlib.stringfind(trim(%v_phone%,left,right),' ',1)!=0,   '',//fix 21872
		       if(trim(stringlib.stringfilterout(%v_phone%,'0'),left,right)='','',//fix 31571,
			   //see cases of an area-code followed by 7 zeroes
			   if(stringlib.stringfind(stringlib.stringfilterout(%v_phone%,'-'),'0000000',1)!=0,              '',
			   %v_phone%)))));
 self          := l;

end;

outfile := project(infile, %phoneFix%(left));

endmacro;