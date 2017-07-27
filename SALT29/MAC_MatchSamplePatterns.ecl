// Create field match/mismatch patterns based on the Keys.MatchSample file
EXPORT MAC_MatchSamplePatterns(inFile,outFile, id1,id2, out_number=0, conf_range='') := MACRO
	LOADXML('<xml/>');
  #EXPORTXML(AllFields, RECORDOF(inFile));
	#DECLARE(IfStatements) #SET (IfStatements, '')
	#DECLARE(s_name) #SET(s_name,'')
	#DECLARE(fieldname) #SET(fieldname,'')
	#DECLARE(s) #SET(s,1)
	#DECLARE(fmmp_assignment) #SET(fmmp_assignment,'')
	#FOR (AllFields)
		#FOR (Field)
    #IF(REGEXFIND('_score',%'@name'%))
        #SET(s_name,'s'+%s%)
        #SET(fieldname,REGEXREPLACE('^(.+)_score$',%'@name'%,'$1'))
        #APPEND(IfStatements, %'s_name'% + ':=IF(le.' + %'@name'% + '<>0,IF(le.' + %'@name'% + '>0,\',' + %'fieldname'% + '\',\',-' + %'fieldname'% + '\'),\'\');')
	      #IF(%s% = 1 )
					#APPEND(fmmp_assignment,%'s_name'%)
        #ELSE
					#APPEND(fmmp_assignment,'+'+%'s_name'%)
        #END			
 				#SET(s,%s%+1)
    #END
	#END
	#SET(fmmp_assignment,'SELF.fmmp:=REGEXREPLACE(\'^[, ]+\',' + %'fmmp_assignment'% + ',\'\');')
	#END
	
	#UNIQUENAME(hyphen_index)
	%hyphen_index%:=StringLib.StringFind(#TEXT(conf_range),'-',1);
  #UNIQUENAME(min_conf)
	%min_conf% := MAP(LENGTH(#TEXT(conf_range))=0 OR %hyphen_index%=1 => MIN(inFile,conf),
                    %hyphen_index%=0 => (UNSIGNED)(#TEXT(conf_range)),
										(UNSIGNED)(#TEXT(conf_range)[..(%hyphen_index%-1)]));
 
	#UNIQUENAME(max_conf)
  %max_conf% := MAP(LENGTH(#TEXT(conf_range))=0 OR %hyphen_index%=0 OR %hyphen_index%=LENGTH(#TEXT(conf_range)) => MIN(inFile,conf),
                    (UNSIGNED)(#TEXT(conf_range)[(%hyphen_index%+1)..]));

  #UNIQUENAME(layout)
  %layout% := RECORDOF(inFile);

  #UNIQUENAME(a_pair_rec)
  %a_pair_rec% := RECORD
    UNSIGNED id1;
    UNSIGNED id2;
  END;
	
  #UNIQUENAME(layout_PositiveScoreStrings)
  %layout_PositiveScoreStrings% := RECORD
     INTEGER2 conf;
     UNSIGNED cnt;
     STRING fmmp:='';
     DATASET(%a_pair_rec%) match_pairs:=DATASET([],%a_pair_rec%);
  END;
	
	#UNIQUENAME(projectScores2FieldMatchMismatchPatterns)
  %layout_PositiveScoreStrings%   %projectScores2FieldMatchMismatchPatterns%(%layout% le) := TRANSFORM
			%IfStatements%
			%fmmp_assignment%
			SELF.conf:=le.conf;
      SELF.cnt:=1;
      SELF.match_pairs:=DATASET([{le.id1,le.id2}],%a_pair_rec%);
  END;

	#UNIQUENAME(my_ds0)
  %my_ds0% := SORT(PROJECT(SORT(inFile,-conf),%projectScores2FieldMatchMismatchPatterns%(LEFT)),-conf,fmmp);

	#UNIQUENAME(rollupFMMPs)
  %layout_PositiveScoreStrings% %rollupFMMPs%( %layout_PositiveScoreStrings% le, %layout_PositiveScoreStrings% ri ) := TRANSFORM
			DATASET(%a_pair_rec%) match_pairs := IF(COUNT(ri.match_pairs)=0,le.match_pairs
			  																					                    ,IF(COUNT(le.match_pairs)=0,ri.match_pairs,le.match_pairs + ri.match_pairs));
      SELF.cnt:=COUNT(match_pairs);
      SELF.match_pairs := match_pairs;
      SELF:=le;
  END;

	#UNIQUENAME(my_ds1)
  %my_ds1% := SORT(ROLLUP(%my_ds0%,(LEFT.conf=RIGHT.conf) AND (LEFT.fmmp=RIGHT.fmmp),%rollupFMMPs%(LEFT,RIGHT)),-conf,-cnt );

  outFile := IF(out_number=0 // 0 means all match pairs of each fmmp pattern will be output
								,%my_ds1%
								,PROJECT(SORT(%my_ds1%,-conf,-cnt),TRANSFORM(RECORDOF(%my_ds1%),SELF.match_pairs:=IF(out_number>=LEFT.cnt,LEFT.match_pairs,LEFT.match_pairs[1..out_number]),SELF:=LEFT))
               )((conf<=%max_conf%) AND (conf>=%min_conf%));

ENDMACRO;
