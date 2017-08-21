export MAC_Character_Counts := module
shared MaxExamples := 300;
shared MaxChars := 256; // Change to allow more than 256 different characters in string
export Data_Layout := RECORD
  SALT21.StrType Fld { MAXLENGTH(200000) };
	UNSIGNED2 FldNo;
  END;
	
shared Length_Layout := record
  unsigned2 len;
	unsigned  cnt;
  end;
	
shared Words_Layout := record
  unsigned2 words;
	unsigned  cnt;
	end;
	
shared Character_Layout := record
  SALT21.CharType c;
	unsigned cnt;
  end;	
	
shared Pattern_Layout := record
  SALT21.StrType data_pattern {maxlength(200000)};
	unsigned cnt;
	end;
	
shared Value_Layout := record
  SALT21.StrType val  {maxlength(200000)};
	unsigned cnt;
	end;
export Field_Identification := RECORD
  unsigned2 FldNo;
  SALT21.StrType FieldName;
  END;
shared ResultLine_Layout := record(Field_Identification)
	unsigned                  Cardinality;
  dataset(Length_Layout)    Len {MAXCOUNT(MaxChars)} := dataset([],Length_Layout);
	dataset(Words_Layout)     Words {MAXCOUNT(MaxChars)} := dataset([],Words_Layout);
	dataset(Character_Layout) Characters {MAXCOUNT(MaxChars)} := dataset([],Character_Layout);
	dataset(Pattern_Layout)   Patterns {MAXCOUNT(MaxExamples)}:= dataset([],Pattern_Layout);
	dataset(Value_Layout)   Frequent_Terms {MAXCOUNT(MaxExamples)}:= dataset([],Value_Layout);
  end;
export FN_Profile(dataset(Data_Layout) TheData,dataset(Field_Identification)TheFields) := FUNCTION
IRecTot := RECORD
  TheData.Fld;
  TheData.FldNo;
  UNSIGNED Cnt := COUNT(GROUP);
END;
FldInv1 := TABLE(TheData,IRecTot,FldNo,Fld,MERGE);
glbl_field_cnts := record
  FldInv1;
	unsigned2 xx_l := length(trim((SALT21.StrType)FldInv1.Fld));
	unsigned2 xx_wc := SALT21.WordCount((SALT21.StrType)FldInv1.Fld);
  end;
	
FldInv := table( FldInv1, glbl_field_cnts );
card_rec := record
  FldInv.FldNo;
	unsigned Cardinality := COUNT(GROUP);
  end;	
	
Cardinalities := table(FldInv,card_rec,FldNo,FEW);
ResultLine_Layout NoteCard(TheFields Le,Cardinalities ri) := transform
    SELF := ri;
		SELF := le;
  end;
With_Cards := JOIN(TheFields,Cardinalities,left.FldNo=right.FldNo,NoteCard(LEFT,RIGHT));
// Produce highest 'MaxExamples' frequency for each fieldtype
so := SORT(FldInv,FldNo,-Cnt,LOCAL);
gci := RECORD
  so;
	unsigned4 ctr := 0;
	END;
	
gci iter1(gci le,gci ri) := transform
  self.ctr := IF (le.fldno=ri.fldno,le.ctr+1,1);
  self := ri;
  end;	
first_pass := ITERATE(SORT(DISTRIBUTE(ITERATE(TABLE(so,gci),iter1(left,right),local)(Ctr<=MaxExamples),FldNo),FldNo,-Cnt,LOCAL),iter1(left,right),LOCAL)(Ctr<=MaxExamples);
ResultLine_Layout AddField1(With_Cards le,first_pass ri) := transform
  SELF.Frequent_Terms := le.Frequent_Terms+ROW({ri.Fld,ri.Cnt},Value_layout);
  SELF := le;
  end;
With_Frequent := DENORMALIZE(With_Cards,first_pass,left.FldNo=right.FldNo,AddField1(left,right));	
length_rec := record
  FldInv.FldNo;
	unsigned2 len := FldInv.xx_l;
	unsigned  Cnt := sum(group,FldInv.cnt);
	END;
	
FieldLengths := SORT(TABLE(FldInv,length_rec,FldNo,xx_l,FEW),FldNo,-cnt);	
ResultLine_Layout AddField2(With_Frequent le,FieldLengths ri) := transform
  SELF.Len := IF(COUNT(le.Len)<255,le.Len+ROW({ri.len,ri.Cnt},Length_layout),le.Len);
  SELF := le;
  end;
With_Lens := DENORMALIZE(With_Frequent,FieldLengths,left.FldNo=right.FldNo,AddField2(left,right));	
word_cnts_rec := record
  FldInv.FldNo;
	unsigned2 Words := FldInv.xx_wc;
	unsigned  Cnt := sum(group,FldInv.cnt);
	END;
	
WordCounts := SORT(TABLE(FldInv,word_cnts_rec,FldNo,xx_wc,FEW),FldNo,-cnt);	
ResultLine_Layout AddField3(With_Lens le,WordCounts ri) := transform
  SELF.Words := le.Words+ROW({ri.Words,ri.Cnt},Words_layout);
  SELF := le;
  end;
With_WCS := DENORMALIZE(With_Lens,WordCounts,left.FldNo=right.FldNo,AddField3(left,right));	
r := record
  SALT21.CharType c;
	unsigned cnt;
	unsigned2 FldNo;
	end;
	
r tr(FldInv le,unsigned co) := transform
  self.c := ((SALT21.StrType)le.Fld)[co];
	self := le;
  end;
	
AllChars := normalize(FldInv,left.xx_l,tr(left,counter));
rc := record
  AllChars.c;
	AllChars.FldNo;
	unsigned cnt := sum(group,AllChars.cnt);
	end;
CharCounts	:= SORT( table(AllChars,rc,c,FldNo,FEW), FldNo, -Cnt );
ResultLine_Layout AddField4(With_WCS le,CharCounts ri) := transform
  SELF.Characters := le.Characters+ROW({ri.c,ri.Cnt},Character_layout);
  SELF := le;
  end;
With_Chars := DENORMALIZE(With_WCS,CharCounts,left.FldNo=right.FldNo,AddField4(left,right));	
dr := record
	  SALT21.StrType Fld  {maxlength(200000)} := SALT21.fn_data_pattern(FldInv.Fld);
		FldInv.Cnt;
		FldInv.FldNo;
  end;
t := table(FldInv,dr);
r1 := record
	  t.Fld;
		t.FldNo;
		unsigned cnt := sum(group,t.cnt);
  end;
DataPatterns0 := SORT(table(t,r1,FldNo,Fld,few),FldNo,-Cnt,LOCAL); // Few is slightly risky - could have many, high cardinality fields with odd patterns ...
gcid := RECORD
  DataPatterns0;
	unsigned4 ctr := 0;
	END;
	
gcid iter1d(gcid le,gcid ri) := transform
  self.ctr := IF (le.fldno=ri.fldno,le.ctr+1,1);
  self := ri;
  end;	
first_passd := ITERATE(SORT(DISTRIBUTE(ITERATE(TABLE(DataPatterns0,gcid),iter1d(left,right),local)(Ctr<=MaxExamples),FldNo),FldNo,-Cnt,LOCAL),iter1d(left,right),LOCAL)(Ctr<=MaxExamples);
ResultLine_Layout AddField5(With_Chars le,first_passd ri) := transform
  SELF.Patterns := le.Patterns+ROW({ri.fld,ri.Cnt},Pattern_layout);
  SELF := le;
  end;
RETURN DENORMALIZE(With_Chars,First_Passd,left.FldNo=right.FldNo,AddField5(left,right));
  END;
	
end;
  
