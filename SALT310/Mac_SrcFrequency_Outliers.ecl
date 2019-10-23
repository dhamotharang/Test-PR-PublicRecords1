/*
MACRO: Mac_SrcFrequency_Outliers
				This macro computes various kinds of source outliers wrt a given field in the input data.
Inputs: 1)infile - the input data file 
				2)infield - the field wrt which the source outliers are identified 
				3)srcfield - the field in infile that specifies the source
Outputs: All outlier outputs(o1, o21, o31, o41) are in the form of {fieldname, fieldvalue, src, cnt}.
				 All oulier_source outputs (o22, o32, o42) are in the form of {source, score}. In the following paragraph, 'size' of a source refers to the total number of records it reported.
				 We have used Tukey's test to detect the outliers in o21, o31, and o41. For more infoemation on the why's and how's pls refer to https://en.wikipedia.org/wiki/Tukey's_range_test
				 1)o1 - All the fieldvalues in infield that are in the top 50 for a source that are not in the top 1000 across all files.
				 2)o21 - All the fieldvalues in infield that are 1)unique (single instance in data - have been reported only once,by only one source) and, 2)the corresponding source has reported way too many unique records wrt its size.
				 3)o22 - All the sources that have reported way too many unique values wrt their size. The score for every source is the ratio: (number of unique values repoted/size)
				 4)o31 - All the distinct fieldvalues in infield, that have been reported by those sources which have reported way too many distinct values wrt their size.  
				 5)o32 - All the sources that have reported way too many distict values wrt their size. The score for every source is the ratio: (number of distinct values repoted/size)
				 6)o41 - All the fieldvalues in infield that are 1) in the Top5 fieldvalues in the whole data 2) the corresponding source has reported way too many of these top5 values wrt its size 
				 7)o42 - All the sources that have reported way too many top5 values. The score for every source is the ratio: (number of top5 values reported/size)
-Supriya Nirkhiwale
*/
EXPORT Mac_SrcFrequency_Outliers(infile,infield,srcfield,o1,o21,o22,o31,o32,o41,o42) := MACRO
  #uniquename(r)
  %r% := RECORD
	  SALT310.Str30Type fieldname := #TEXT(infield);
	  SALT310.StrType fieldvalue {MAXLENGTH(200000)} := (SALT310.StrType)infile.infield ;
		SALT310.StrType src {MAXLENGTH(30)} := infile.srcfield ;
		UNSIGNED c := COUNT(GROUP);
	  END;
		
	#uniquename(t1)
	SHARED %t1% := TABLE( infile, %r%, infield, srcfield, MERGE );
	
  #uniquename(r2)
  SHARED %r2% := RECORD
						%t1%.fieldname;
						%t1%.fieldvalue;		
						UNSIGNED c := SUM(GROUP,%t1%.c);
					END;
		
	#uniquename(tots)
	%tots% := TOPN( TABLE( %t1%, %r2%, fieldname, fieldvalue ), 1000, -c );// Dedup to avoid high frequency errors
  #uniquename(sg)
	%sg% := DEDUP( SORT( DISTRIBUTE(%t1%, HASH(src)), src, -c, fieldvalue,LOCAL ), src, KEEP(50),LOCAL );
  EXPORT o1 := SORT(JOIN( %sg%, %tots%, LEFT.fieldvalue=RIGHT.fieldvalue,TRANSFORM(LEFT), LEFT ONLY ), -c, src );	
	
	#uniquename(sfc) //SortedFieldCounts
	SHARED %sfc% := SORT(TABLE(%t1%, %r2%, fieldname, fieldvalue), -c);	
	
  #uniquename(r3) //recSrcScore	
	SHARED %r3% := RECORD
						SALT310.StrType src := %t1%.src;
						UNSIGNED size := SUM(GROUP,%t1%.c);
						REAL score := 0.0;
					END;
	
	#uniquename(ss) //SrcSize
		SHARED %ss% := TABLE(%t1%,%r3%,src,FEW);
	#uniquename(s1) //s1
		%s1% := %t1%(c = 1);
	#uniquename(s2) //s2
		%s2% := %sfc%(c = 1);
	#uniquename(st) //Singletons
		SHARED %st%:= SORT(JOIN( %s1%, %s2%, LEFT.fieldvalue=RIGHT.fieldvalue,TRANSFORM(LEFT)),src );
	#uniquename(ast) //AggSingletons
		%ast% := TABLE(%st%, {%st%.src; unsigned Unique_cnt := SUM(GROUP, %st%.c);}, src,FEW);
	#uniquename(uss) //ComputeUniqueSrcScores
		%r3% %uss%(recordof(%ast%) l, %r3% r) := TRANSFORM
			SELF.score := l.Unique_cnt/r.size;
			SELF.src := r.src;
			SELF.size := r.size;
		END;
	#uniquename(sus) //SrcUniqueScores
		%sus% := SORT(JOIN(%ast%, %ss%, LEFT.src = RIGHT.src, %uss%(LEFT, RIGHT), RIGHT OUTER), score);
	#uniquename(suc) //SrcCount for unique
		%suc% := COUNT(%sus%);
	#uniquename(iqru) //InterQuantileRange for unique	outliers	
		%iqru% := %sus%[%suc% * 0.75].score - %sus%[%suc% * 0.25].score;
	//LowerCutoff := %sus%[%suc% * 0.25].score - %iqru%;
	#uniquename(ucu) //UpperCutoff for unique outliers 
		%ucu% := %sus%[%suc% * 0.75].score + %iqru%;
	#uniquename(osu) //OutlierSrc for unique outliers
		SHARED %osu%:= TABLE(%sus%(score > %ucu%));
		
EXPORT o21 := JOIN(%st%, %osu%, LEFT.src = RIGHT.src, TRANSFORM(LEFT), LOOKUP);  //SingletonOutliers
EXPORT o22 := TABLE(%osu%, {SALT310.Str30Type fieldname := #TEXT(infield);SALT310.Str30Type OutlierType := 'Unique'; SALT310.StrType src := %osu%.src; REAL score := %osu%.score;});
	
	#uniquename(r4) //Rec_Src_count	
		%r4% := RECORD 
			SALT310.StrType src := %t1%.src;
			UNSIGNED Distinct_cnt := COUNT(GROUP);
		END;
	#uniquename(dcs) //Distinct_count_bysrc
		%dcs% := TABLE(%t1%, %r4%, src, FEW); //count all the disticnt values for every source
	#uniquename(cds) //ComputeDistinctSrcScores
		%r3% %cds%(recordof(%dcs%) l, %r3% r) := TRANSFORM
			SELF.score := l.Distinct_cnt/r.size;
			SELF.src := r.src;
			SELF.size := r.size;
		END;
	#uniquename(sds) //SrcDistinctScores
		%sds%:= SORT(JOIN(%dcs%, %ss%, LEFT.src = RIGHT.src, %cds%(LEFT, RIGHT), RIGHT OUTER), score);
	#uniquename(sdc) //SrcCount
	 %sdc%:= COUNT(%sds%);
	#uniquename(iqrd) //InterQuantileRange for distinct values
		%iqrd% := %sds%[%sdc% * 0.75].score - %sds%[%sdc% * 0.25].score;
	//LowerCutoff := SrcDistinctScores[%sdc% * 0.25].score - %iqrd%;
	#uniquename(ucd) //UpperCutoff for source outliers based on disticnt values 
		%ucd% := %sds%[%sdc% * 0.75].score + %iqrd%;
	#uniquename(osd) //OutlierSrcDistinct
		SHARED %osd% := TABLE(%sds%(score > %ucd%));
	EXPORT o31 := JOIN(%t1%, %osd%, LEFT.src = RIGHT.src, TRANSFORM(LEFT), LOOKUP); //DistinctOutliers
	EXPORT o32 := TABLE(%osd%,{SALT310.Str30Type fieldname := #TEXT(infield);SALT310.Str30Type OutlierType := 'Distinct'; SALT310.StrType src := %osd%.src; REAL score := %osd%.score;});
	
	#uniquename(t5c) //Top5thCount	
	 %t5c% := TOPN(%sfc%, 5, -c)[5].c;
	#uniquename(t5fv) //Top5Fieldvalues	
	 SHARED %t5fv% := TABLE(%sfc%(c >= %t5c%), {fieldvalue, c});
	#uniquename(t5sc) //Top5SrcCounts
	 %t5sc% := TABLE(JOIN(%t1%, %t5fv%, LEFT.fieldvalue = RIGHT.fieldvalue,TRANSFORM(LEFT), LOOKUP), {src; UNSIGNED top5Count := SUM(GROUP, c)}, src);
	#uniquename(ct5ss) //ComputeTop5SrcScores
	%r3% %ct5ss%(recordof(%t5sc%) l, %r3% r) := TRANSFORM
		SELF.score := l.top5Count/r.size;
		SELF.src := r.src;
		SELF.size := r.size;
	END;
	#uniquename(st5s) //SrcTop5Scores
	 %st5s% := SORT(JOIN(%t5sc%, %ss%, LEFT.src = RIGHT.src, %ct5ss%(LEFT, RIGHT), RIGHT OUTER), score);
	#uniquename(st5sc) //SrcTop5Scores
		%st5sc% := COUNT(%st5s%); 
	#uniquename(iqrt5) //InterQuantileRange for source outliers based on Top 5 counts 
	 %iqrt5% := %st5s%[%st5sc% * 0.75].score - %st5s%[%st5sc% * 0.25].score;	
	//LowerCutoff := SrcTop5Scores[SrcCount * 0.25].score - %iqrt5%;
	#uniquename(uct5) //UpperCutoff for Top5
	 %uct5% := %st5s%[%st5sc% * 0.75].score + %iqrt5%;
	#uniquename(ot5s) //OutlierTop5Src
		SHARED %ot5s% := TABLE(%st5s%(score > %uct5%));
	#uniquename(t1t5)//t1(fieldvalue is in top5)
		%t1t5% := JOIN(%t1%, %t5fv%, LEFT.fieldvalue = RIGHT.fieldvalue, TRANSFORM(LEFT), LOOKUP);
	EXPORT o41 := JOIN(%t1t5%, %ot5s%, LEFT.src = RIGHT.src, TRANSFORM(LEFT), LOOKUP); //Top 5 Outliers
	EXPORT o42 := TABLE(%ot5s%,{SALT310.Str30Type fieldname := #TEXT(infield);SALT310.Str30Type OutlierType := 'Top5'; SALT310.StrType src := %ot5s%.src; REAL score := %ot5s%.score;});
  ENDMACRO;
