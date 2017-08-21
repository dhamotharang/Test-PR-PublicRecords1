/*
	Count the number of matches across all concept components using appropriately selected component
  xxx_cnt count. Since the e1p_cnt and e2p_cnt counts represent the number of instances where both EDIT1/2 
  and PHONETIC matches were detected, an adjustment is made in these two cases to use e1_cnt+p_cnt-e1p_cnt
  or e2_cnt+p_cnt-e2p_cnt instead, as these counts represent the number of instances where either EDIT1/2 
  or PHONETIC matches were detected.
	Additionally, when edit_threshold is defined, indicating that infieldx has an EDITX defined, then e1 counts
  will be used for those strings whose length does not exceed the threshold
*/
EXPORT MAC_Concept4_Specificities(addfield,infile1,infield1,countfield1,ed_threshold1,infile2,infield2,countfield2,ed_threshold2,infile3,infield3,countfield3,ed_threshold3,infile4,infield4,countfield4,ed_threshold4,outfile) := MACRO
#uniquename(is_eandp_cnt1)
%is_eandp_cnt1% := REGEXFIND('e[1|2]p_cnt', #TEXT(countfield1),NOCASE);
#uniquename(e_cnt1)
%e_cnt1% := IF(%is_eandp_cnt1%,REGEXREPLACE('p_cnt', #TEXT(countfield1),'_cnt',NOCASE),'');
#uniquename(e1_e_cnt1)
%e1_e_cnt1% := REGEXREPLACE('2', %e_cnt1%,'1',NOCASE);
#uniquename(e1_countfield1)
%e1_countfield1% := REGEXREPLACE('2', #TEXT(countfield1),'1',NOCASE);
#uniquename(is_eandp_cnt2)
%is_eandp_cnt2% := REGEXFIND('e[1|2]p_cnt', #TEXT(countfield2),NOCASE);
#uniquename(e_cnt2)
%e_cnt2% := IF(%is_eandp_cnt2%,REGEXREPLACE('p_cnt', #TEXT(countfield2),'_cnt',NOCASE),'');
#uniquename(e1_e_cnt2)
%e1_e_cnt2% := REGEXREPLACE('2', %e_cnt2%,'1',NOCASE);
#uniquename(e1_countfield2)
%e1_countfield2% := REGEXREPLACE('2', #TEXT(countfield2),'1',NOCASE);
#uniquename(is_eandp_cnt3)
%is_eandp_cnt3% := REGEXFIND('e[1|2]p_cnt', #TEXT(countfield3),NOCASE);
#uniquename(e_cnt3)
%e_cnt3% := IF(%is_eandp_cnt3%,REGEXREPLACE('p_cnt', #TEXT(countfield3),'_cnt',NOCASE),'');
#uniquename(e1_e_cnt3)
%e1_e_cnt3% := REGEXREPLACE('2', %e_cnt3%,'1',NOCASE);
#uniquename(e1_countfield3)
%e1_countfield3% := REGEXREPLACE('2', #TEXT(countfield3),'1',NOCASE);
#uniquename(is_eandp_cnt4)
%is_eandp_cnt4% := REGEXFIND('e[1|2]p_cnt', #TEXT(countfield4),NOCASE);
#uniquename(e_cnt4)
%e_cnt4% := IF(%is_eandp_cnt4%,REGEXREPLACE('p_cnt', #TEXT(countfield4),'_cnt',NOCASE),'');
#uniquename(e1_e_cnt4)
%e1_e_cnt4% := REGEXREPLACE('2', %e_cnt4%,'1',NOCASE);
#uniquename(e1_countfield4)
%e1_countfield4% := REGEXREPLACE('2', #TEXT(countfield4),'1',NOCASE);
#uniquename(r)
%r% := RECORD
  infile1;
  UNSIGNED8 addfield;
  END;
	
#uniquename(file1)
%file1%:=IF(ed_threshold1>0 AND LENGTH(TRIM((SALT38.StrType)infile1[1].infield1))<ed_threshold1,
            PROJECT(infile1,TRANSFORM(%r%,SELF.addfield:=#IF(%is_eandp_cnt1%) LEFT.#EXPAND(%e1_e_cnt1%)+LEFT.p_cnt-LEFT.#EXPAND(%e1_countfield1%) #ELSE LEFT.#EXPAND(%e1_countfield1%) #END;;SELF:=LEFT))
            ,PROJECT(infile1,TRANSFORM(%r%,SELF.addfield:=#IF(%is_eandp_cnt1%) LEFT.#EXPAND(%e_cnt1%)+LEFT.p_cnt-LEFT.countfield1 #ELSE LEFT.countfield1 #END;;SELF:=LEFT))
						);	
#uniquename(file2)
%file2%:=IF(ed_threshold2>0 AND LENGTH(TRIM((SALT38.StrType)infile2[1].infield2))<ed_threshold2,
            JOIN(%file1%,infile2,LEFT.infield1=(TYPEOF (infile1.infield1))RIGHT.infield2,TRANSFORM(%r%,SELF.addfield:=LEFT.addfield+#IF(%is_eandp_cnt2%) (RIGHT.#EXPAND(%e1_e_cnt2%)+RIGHT.p_cnt-RIGHT.#EXPAND(%e1_countfield2%)) #ELSE RIGHT.#EXPAND(%e1_countfield2%) #END;;SELF:=LEFT;),LEFT OUTER,SMART)
            ,JOIN(%file1%,infile2,LEFT.infield1=(TYPEOF (infile1.infield1))RIGHT.infield2,TRANSFORM(%r%,SELF.addfield:=LEFT.addfield+#IF(%is_eandp_cnt2%) (RIGHT.#EXPAND(%e1_e_cnt2%)+RIGHT.p_cnt-RIGHT.countfield2) #ELSE RIGHT.countfield2 #END;;SELF:=LEFT;),LEFT OUTER,SMART)
						);
						
#uniquename(file3)
%file3%:=IF(ed_threshold3>0 AND LENGTH(TRIM((SALT38.StrType)infile3[1].infield3))<ed_threshold3,
            JOIN(%file2%,infile3,LEFT.infield1=(TYPEOF (infile1.infield1))RIGHT.infield3,TRANSFORM(%r%,SELF.addfield:=LEFT.addfield+#IF(%is_eandp_cnt3%) (RIGHT.#EXPAND(%e1_e_cnt3%)+RIGHT.p_cnt-RIGHT.#EXPAND(%e1_countfield3%)) #ELSE RIGHT.#EXPAND(%e1_countfield3%) #END;;SELF:=LEFT;),LEFT OUTER,SMART)
            ,JOIN(%file2%,infile3,LEFT.infield1=(TYPEOF (infile1.infield1))RIGHT.infield3,TRANSFORM(%r%,SELF.addfield:=LEFT.addfield+#IF(%is_eandp_cnt3%) (RIGHT.#EXPAND(%e1_e_cnt3%)+RIGHT.p_cnt-RIGHT.countfield3) #ELSE RIGHT.countfield3 #END;;SELF:=LEFT;),LEFT OUTER,SMART)
						);
#uniquename(file4)
%file4%:=IF(ed_threshold4>0 AND LENGTH(TRIM((SALT38.StrType)infile4[1].infield4))<ed_threshold4,
            JOIN(%file3%,infile4,LEFT.infield1=(TYPEOF (infile1.infield1))RIGHT.infield4,TRANSFORM(%r%,SELF.addfield:=LEFT.addfield+#IF(%is_eandp_cnt4%) (RIGHT.#EXPAND(%e1_e_cnt4%)+RIGHT.p_cnt-RIGHT.#EXPAND(%e1_countfield4%)) #ELSE RIGHT.#EXPAND(%e1_countfield4%) #END;;SELF:=LEFT;),LEFT OUTER,SMART)
            ,JOIN(%file3%,infile4,LEFT.infield1=(TYPEOF (infile1.infield1))RIGHT.infield4,TRANSFORM(%r%,SELF.addfield:=LEFT.addfield+#IF(%is_eandp_cnt4%) (RIGHT.#EXPAND(%e1_e_cnt4%)+RIGHT.p_cnt-RIGHT.countfield4) #ELSE RIGHT.countfield4 #END;;SELF:=LEFT;),LEFT OUTER,SMART)
						);
outfile:=%file4%;	
ENDMACRO;
