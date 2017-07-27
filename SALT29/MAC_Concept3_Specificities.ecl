/*
	Count the number of matches across all concept components using appropriately selected component
  xxx_cnt count. Since the e1p_cnt and e2p_cnt counts represent the number of instances where both EDIT1/2 
  and PHONETIC matches were detected, an adjustment is made in these two cases to use e1_cnt+p_cnt-e1p_cnt
  or e2_cnt+p_cnt-e2p_cnt instead, as these counts represent the number of instances where either EDIT1/2 
  or PHONETIC matches were detected.
*/
EXPORT MAC_Concept3_Specificities(addfield,infile1,infield1,countfield1,infile2,infield2,countfield2,infile3,infield3,countfield3,outfile) := MACRO
#uniquename(change_countfield1)
%change_countfield1% := REGEXFIND('e[1|2]p_cnt', #TEXT(countfield1),NOCASE);
#uniquename(changed_countfield1)
%changed_countfield1% := IF(%change_countfield1%,REGEXREPLACE('p_cnt', #TEXT(countfield1),'_cnt',NOCASE),'');
#uniquename(change_countfield2)
%change_countfield2% := REGEXFIND('e[1|2]p_cnt', #TEXT(countfield2),NOCASE);
#uniquename(changed_countfield2)
%changed_countfield2% := IF(%change_countfield2%,REGEXREPLACE('p_cnt', #TEXT(countfield2),'_cnt',NOCASE),'');
#uniquename(change_countfield3)
%change_countfield3% := REGEXFIND('e[1|2]p_cnt', #TEXT(countfield3),NOCASE);
#uniquename(changed_countfield3)
%changed_countfield3% := IF(%change_countfield3%,REGEXREPLACE('p_cnt', #TEXT(countfield3),'_cnt',NOCASE),'');
#uniquename(r)
%r% := RECORD
  infile1;
  UNSIGNED8 addfield;
  END;
#uniquename(file1)
%file1%:=PROJECT(infile1,TRANSFORM(%r%,SELF.addfield:=#IF(%change_countfield1%) LEFT.#EXPAND(%changed_countfield1%)+LEFT.p_cnt-LEFT.countfield1 #ELSE LEFT.countfield1 #END;;SELF:=LEFT));	
#uniquename(file2)
%file2%:=JOIN(%file1%,infile2,LEFT.infield1=(TYPEOF (infile1.infield1))RIGHT.infield2,TRANSFORM(%r%,SELF.addfield:=LEFT.addfield+#IF(%change_countfield2%) (RIGHT.#EXPAND(%changed_countfield2%)+RIGHT.p_cnt-RIGHT.countfield2) #ELSE RIGHT.countfield2 #END;;SELF:=LEFT;),LEFT OUTER);
#uniquename(file3)
%file3%:=JOIN(%file2%,infile3,LEFT.infield1=(TYPEOF (infile1.infield1))RIGHT.infield3,TRANSFORM(%r%,SELF.addfield:=LEFT.addfield+#IF(%change_countfield3%) (RIGHT.#EXPAND(%changed_countfield3%)+RIGHT.p_cnt-RIGHT.countfield3) #ELSE RIGHT.countfield3 #END;;SELF:=LEFT;),LEFT OUTER);
outfile:=%file3%;
ENDMACRO;
