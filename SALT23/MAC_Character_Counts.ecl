export MAC_Character_Counts := module
shared MaxExamples := 300;
shared MaxChars := 256; // Change to allow more than 256 different characters in string
export Data_Layout := RECORD
  SALT23.StrType Fld { MAXLENGTH(200000) };
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
  SALT23.CharType c;
	unsigned cnt;
  end;	
	
shared Pattern_Layout := record
  SALT23.StrType data_pattern {maxlength(200000)};
	unsigned cnt;
	end;
	
shared Value_Layout := record
  SALT23.StrType val  {maxlength(200000)};
	unsigned cnt;
	end;
export Field_Identification := RECORD
  unsigned2 FldNo;
  SALT23.StrType FieldName;
  END;
shared ResultLine_Layout := record(Field_Identification)
	unsigned                  Cardinality;
  dataset(Length_Layout)    Len {MAXCOUNT(MaxChars)} := dataset([],Length_Layout);
	dataset(Words_Layout)     Words {MAXCOUNT(MaxChars)} := dataset([],Words_Layout);
	dataset(Character_Layout) Characters {MAXCOUNT(MaxChars)} := dataset([],Character_Layout);
	dataset(Pattern_Layout)   Patterns {MAXCOUNT(MaxExamples)}:= dataset([],Pattern_Layout);
	dataset(Value_Layout)   Frequent_Terms {MAXCOUNT(MaxExamples)}:= dataset([],Value_Layout);
  end;

EXPORT EclRecord(DATASET(ResultLine_Layout) d, STRING RName='Record_Layout') := FUNCTION
	R := RECORD
	d.FldNo;
	d.FieldName;
	HasNeg := EXISTS(d.Characters(c='-'));
	HasDot := EXISTS(d.Characters(c='.'));
	NoNum := ~EXISTS(d.Characters(c IN ['0','1','2','3','4','5','6','7','8','9','.','-']));
	AllNum := ~EXISTS(d.Characters(NOT c IN ['0','1','2','3','4','5','6','7','8','9','e','E','.','-']));
	MaxLen := MAX(d.Len,len);
	END;
	t := TABLE(d,r);
	r1 := RECORD
	  t.FldNo;
		STRING Txt;
	END;
	Len2Size(UNSIGNED2 c) := MAP ( c < 3 => 1, c < 5 => 2, c < 7 => 3, c < 9 => 4, c < 11 => 5, c < 14 => 6, c < 16 => 7, 8 );
	boiler := DATASET([{0,RName+' := RECORD'},{100000,'  END;'}],r1);
	r1 WriteEcl(t le) := TRANSFORM
		SELF.Txt := '  '+MAP( ~le.AllNum => 'STRING' + IF(le.MaxLen<100,(STRING)le.MaxLen, ''),
													le.HasDot => 'REAL' + IF(le.MaxLen<8,'4','8'),
													le.HasNeg => 'INTEGER' + Len2Size(le.MaxLen),
													'UNSIGNED'+Len2Size(le.MaxLen) ) + ' ' + le.FieldName +';';
		SELF := le;
	END;
	P := TABLE(SORT(PROJECT(t,WriteEcl(LEFT))+boiler,FldNo,FEW),{Txt});
	RETURN P;
END;
	
export FN_Profile(dataset(Data_Layout) TheData,dataset(Field_Identification)TheFields) := FUNCTION
IRecTot := RECORD
  TheData.Fld;
  TheData.FldNo;
  UNSIGNED Cnt := COUNT(GROUP);
END;
FldInv1 := TABLE(TheData,IRecTot,FldNo,Fld,MERGE);
glbl_field_cnts := record
  FldInv1;
	unsigned2 xx_l := length(trim((SALT23.StrType)FldInv1.Fld));
	unsigned2 xx_wc := SALT23.WordCount((SALT23.StrType)FldInv1.Fld);
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
  SALT23.CharType c;
	unsigned cnt;
	unsigned2 FldNo;
	end;
	
r tr(FldInv le,unsigned co) := transform
  self.c := ((SALT23.StrType)le.Fld)[co];
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
	  SALT23.StrType Fld  {maxlength(200000)} := SALT23.fn_data_pattern(FldInv.Fld);
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

// Extended section - this deals with the case where cluster IDs and source_field information is available
EXPORT X_Data_Layout := RECORD(Data_Layout)
  SALT23.UIDType id := 0;
	SALT23.StrType src := '';
  END;

EXPORT SRC_Profile(DATASET(X_Data_Layout) TheData,DATASET(Field_Identification)TheFields) := FUNCTION
  // First get the regular counts and non-blank counts
	fldcnt := TABLE(TheData,{Cnt := COUNT(GROUP),NonBlank := COUNT(GROUP,Fld<>''),src,fldno},src,fldno,FEW);
	d := DISTRIBUTE(TheData(fld<>''),HASH(id));
	t1 := TABLE(d,{id,src,fldno,fld},id,src,fldno,fld,LOCAL);
	val_in_1 := TABLE(t1,{id,fldno,fld,c:=COUNT(GROUP)},id,fldno,fld,LOCAL)(c=1);
	srcperid := TABLE(t1,{id,fldno,src},id,fldno,src,LOCAL);
	singlesrc := TABLE(t1,{id,fldno,c:=COUNT(GROUP)},id,fldno,LOCAL)(c=1);
	srcglobal := TABLE(t1,{fldno,src,fld},src,fldno,fld,MERGE);
	srcglobalsingle := TABLE(srcglobal,{fldno,fld,msrc := MAX(GROUP,src),c := COUNT(GROUP)},fldno,fld,MERGE)(c=1);
	srcs_gs := TABLE(srcglobalsingle,{fldno,src := msrc,unique_value_global := COUNT(GROUP)},fldno,msrc,FEW);
	srcids := TABLE(srcperid,{fldno,src,TotalIdsForSrc := COUNT(GROUP)},src,fldno,FEW);
	ires := RECORD
	  t1;
	  BOOLEAN unique_val := FALSE; // True if the only source providing this value for this cluster
		BOOLEAN only_src := FALSE;   // True if the only source providing any value for this field for this cluster
	END;
	ires note_uval(t1 le,val_in_1 ri) := TRANSFORM
	  SELF.unique_val := ri.id<>0;
	  SELF := le;
	END;
	f1 := JOIN(t1,val_in_1,LEFT.id=RIGHT.id AND LEFT.fldno=RIGHT.fldno AND LEFT.fld=RIGHT.fld,note_uval(LEFT,RIGHT),LOCAL,LEFT OUTER);
	ires note_usrc(f1 le,singlesrc ri) := TRANSFORM
	  SELF.only_src := ri.id<>0;
	  SELF := le;
	END;
	f2 := JOIN(f1,singlesrc,LEFT.id=RIGHT.id AND LEFT.fldno=RIGHT.fldno,note_usrc(LEFT,RIGHT),LOCAL,LEFT OUTER);
  src_sums := TABLE(f2,{unique_value := COUNT(GROUP,unique_val),only_value := COUNT(GROUP,only_src),fldno,src},src,fldno,FEW);
	ss0 := JOIN(src_sums,srcs_gs,LEFT.src=RIGHT.src AND LEFT.fldno=RIGHT.fldno);
	ss1 := JOIN(ss0,srcids,LEFT.src=RIGHT.src AND LEFT.fldno=RIGHT.fldno);
	rrec := RECORD
		SALT23.StrType Field;
		UNSIGNED  unique_value;
		UNSIGNED  only_value;
		UNSIGNED  globally_unique_value;
		UNSIGNED  IdsWithSrc;
	END;
	resrec := RECORD
	  ss1.src;
		DATASET(rrec) fields := DATASET([{TheFields(fldno=ss1.fldno)[1].FieldName,ss1.unique_value,ss1.only_value,ss1.unique_value_global,ss1.TotalIdsForSrc}],rrec);
	END;
	ss2 := TABLE(ss1,resrec);
	resrec rl(ss2 le,ss2 ri) := TRANSFORM
	  SELF.fields := le.fields+ri.fields;
	  SELF := le;
	END;
	ss3 := SORT( DISTRIBUTE(ss2,HASH(src)),src,fields[1].Field,LOCAL);
	RETURN SORT(ROLLUP(ss3,LEFT.src=RIGHT.src,rl(LEFT,RIGHT)),SRC);
END;
	
END;
  
