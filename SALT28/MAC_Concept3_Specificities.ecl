EXPORT MAC_Concept3_Specificities(addfield,infile1,infield1,countfield1,infile2,infield2,countfield2,infile3,infield3,countfield3,outfile) := MACRO
#uniquename(r)
%r% := RECORD
  infile1;
  UNSIGNED8 addfield;
  END;
#uniquename(file1)
%file1%:=PROJECT(infile1,TRANSFORM(%r%,SELF.addfield:=LEFT.countfield1;SELF:=LEFT));	
#uniquename(file2)
%file2%:=JOIN(%file1%,infile2,LEFT.infield1=(TYPEOF (infile1.infield1))RIGHT.infield2,TRANSFORM(%r%,SELF.addfield:=LEFT.addfield+RIGHT.countfield2;SELF:=LEFT;),LEFT OUTER);
#uniquename(file3)
%file3%:=JOIN(%file2%,infile3,LEFT.infield1=(TYPEOF (infile1.infield1))RIGHT.infield3,TRANSFORM(%r%,SELF.addfield:=LEFT.addfield+RIGHT.countfield3;SELF:=LEFT;),LEFT OUTER);
outfile:=%file3%;
ENDMACRO;