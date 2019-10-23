import std;
EXPORT quick_diff(

   string pECL_Code1
  ,string pECL_Code2

) :=
function

  ds_ECL_Code1 := dataset([{pECL_Code1}],{string code});
  ds_ECL_Code2 := dataset([{pECL_Code2}],{string code});

  lstringextract(string pString,unsigned2 pinstance,string1 pdelim = '\n')	:= 
    map( pinstance 																			 = 1 	=> pString[1..(stringlib.stringfind(pString,pdelim,1) - 1)]
        ,stringlib.stringfind(pString,pdelim,pinstance) != 0	=> pString[(stringlib.stringfind(pString,pdelim,pinstance - 1) + 1)..(stringlib.stringfind(pString,pdelim,pinstance) - 1)]
        ,																												 pString[(stringlib.stringfind(pString,pdelim,pinstance - 1) + 1)..]
    );
  
  fParseLines(STRING s):= NORMALIZE(
     DATASET([{'\n'+s+'\n'}],{STRING s;})
    ,LENGTH(REGEXREPLACE('[^\n]',s,''))+1
    ,TRANSFORM(
       {unsigned lineno,string1 lastchar,string5 last5chars,string5 last5chars_line,boolean islf,string line},
       tempstring := trim(LEFT.s[(Std.Str.Find(LEFT.s,'\n',COUNTER) + 1)..(Std.Str.Find(LEFT.s,'\n',COUNTER+1) - 1)],right);
       self.lastchar          := tempstring[length(tempstring)];
       self.islf              := if(self.lastchar = '\n'  ,true,false);
       // SELF.line              := tempstring[1..length(tempstring) - 1];
       SELF.line              := if(self.islf  ,tempstring[1..length(tempstring) - 1] ,tempstring);
       SELF.lineno            := COUNTER;
       self.last5chars        := tempstring[length(tempstring) - 4..length(tempstring)];
       self.last5chars_line   := SELF.line[length(SELF.line) - 4..length(SELF.line)];
    )
  );
  datts_norm1 := fParseLines(pECL_Code1);
  datts_norm2 := fParseLines(pECL_Code2);
  
  // datts_norm1 := normalize(ds_ECL_Code1, stringlib.stringfindcount(left.code,'\n') + 1  
  // ,transform(
   // {unsigned lineno,string line}
  // ,self.lineno	  := counter
  // ,self.line 			:= std.str.findreplace(lstringextract(left.code,counter),'\n','')
  // ));

  // datts_norm2 := normalize(ds_ECL_Code2, stringlib.stringfindcount(left.code,'\n') + 1  
  // ,transform(
   // {unsigned lineno,string line}
  // ,self.lineno	  := counter
  // ,self.line 			:= std.str.findreplace(lstringextract(left.code,counter),'\n','')
  // ));

  ds_same_lines := join(datts_norm1  ,datts_norm2 ,trim(left.line) = trim(right.line) ,transform(
   {unsigned lineno_left,unsigned lineno_right,string line}
   // ,self.fullname := left.fullname
   ,self.lineno_left  := left.lineno
   ,self.lineno_right := right.lineno
   ,self.line         := left.line
  ));

  ds_remove_same_lines1  := join(datts_norm1 ,ds_same_lines ,left.lineno = right.lineno_left ,transform(left),left only);
  ds_remove_same_lines2  := join(datts_norm2 ,ds_same_lines ,left.lineno = right.lineno_right,transform(left),left only);

  return_result := parallel(
     output(datts_norm1            ,named('datts_norm1'           ),all)
    ,output(datts_norm2            ,named('datts_norm2'           ),all)
    ,output(ds_same_lines          ,named('ds_same_lines'         ),all)
    ,output(ds_remove_same_lines1  ,named('ds_remove_same_lines1' ),all) 
    ,output(ds_remove_same_lines2  ,named('ds_remove_same_lines2' ),all)
    ,output(count(ds_remove_same_lines1 ) ,named('count_ds_remove_same_lines1' ),all)
    ,output(count(ds_remove_same_lines2 ) ,named('count_ds_remove_same_lines2' ),all)
    ,output(if(count(ds_remove_same_lines1 ) > count(ds_remove_same_lines2 ) ,count(ds_remove_same_lines1 )  ,count(ds_remove_same_lines2 ))  ,named('Count_diff'))
  );

  // return return_result;
  return if(count(ds_remove_same_lines1 ) > count(ds_remove_same_lines2 ) ,count(ds_remove_same_lines1 )  ,count(ds_remove_same_lines2 ));

end;