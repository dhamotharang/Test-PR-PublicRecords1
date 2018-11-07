// Create field match/mismatch patterns based on the Keys.MatchSample file and a child dataset of samples for each (at individual confidence levels)
// default to 10 samples per match pattern/conf
// confidence minimum and maximum will default to the minimum conf in inFile if conf_range is not provided
EXPORT MAC_MatchSamplePatterns(inFile,outFile, id1,id2, out_number=10, conf_range='') := MACRO
	// using score fields in the layout of inFile, build up a string of field names for match/mismatch
	// for example, "orgid,st,zip,-v_city_name,addr1" (where the "-" indicates a mismatch)
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
	#UNIQUENAME(max_conf)
	#IF(TRIM(#TEXT(conf_range)) > '')
		%min_conf% := MAP(%hyphen_index%=1 => MIN(inFile,conf),
                      %hyphen_index%=0 => (UNSIGNED)(#TEXT(conf_range)),
										  (UNSIGNED)(#TEXT(conf_range)[..(%hyphen_index%-1)]));
		%max_conf% := MAP(%hyphen_index%=0 OR %hyphen_index%=LENGTH(#TEXT(conf_range)) => MIN(inFile,conf),
                    (UNSIGNED)(#TEXT(conf_range)[(%hyphen_index%+1)..]));
	#ELSE
		%min_conf% := MIN(inFile,conf);
		%max_conf% := MIN(inFile,conf);
	#END
 
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
		 UNSIGNED sequenceNum := 0;
     STRING fmmp := '';
     DATASET(%a_pair_rec%) match_pairs:=DATASET([],%a_pair_rec%);
  END;
	
	#UNIQUENAME(projectScores2FieldMatchMismatchPatterns)
  %layout_PositiveScoreStrings%   %projectScores2FieldMatchMismatchPatterns%(%layout% le) := TRANSFORM
			%IfStatements%
			%fmmp_assignment%
			SELF.conf := le.conf;
      SELF.cnt := 1;
      SELF.match_pairs := DATASET([{le.id1,le.id2}],%a_pair_rec%);
  END;
	
	// initial project into rollup layout
	#UNIQUENAME(confAndFieldMatches0)
  %confAndFieldMatches0% := SORT(PROJECT(SORT(inFile,-conf),%projectScores2FieldMatchMismatchPatterns%(LEFT)),-conf,fmmp);
	
	// number samples per conf/fmmp (fmmp = set of match/mismatch criteria) to filter out extras if desired (i.e. if out_number = 0, but hopefully that will be rare)
	#UNIQUENAME(confAndFieldMatches1)
	%confAndFieldMatches1% := ITERATE(%confAndFieldMatches0%(conf<=%max_conf% AND conf>=%min_conf%), TRANSFORM(RECORDOF(LEFT), SELF.sequenceNum := IF(LEFT.conf = RIGHT.conf AND LEFT.fmmp = RIGHT.fmmp, LEFT.sequenceNum + 1, 1), SELF := RIGHT));
	
	// filter out extras (saves processing cost of rolling up all the data and then throwing most of it away)
	#UNIQUENAME(confAndFieldMatches2)
	%confAndFieldMatches2% := IF(out_number = 0, %confAndFieldMatches0%, %confAndFieldMatches1%(sequenceNum > 0 AND sequenceNum <= out_number));
	
	
	#UNIQUENAME(rollupFMMPs)
  %layout_PositiveScoreStrings% %rollupFMMPs%( %layout_PositiveScoreStrings% le, %layout_PositiveScoreStrings% ri ) := TRANSFORM
			match_pairs := le.match_pairs + ri.match_pairs;
      SELF.match_pairs := match_pairs;
      SELF:=le;
  END;
	
	// count matches per conf/fmmp to append at the end
	// use MERGE under the assumption that we aren't looking for samples in a ridiculously huge confidence range or will have
	// a huge number of possible match/mismatch combinations
	#UNIQUENAME(tConfMatchCount)
  %tConfMatchCount% := TABLE(%confAndFieldMatches0%, {conf, fmmp, cntMatches := COUNT(GROUP)}, conf, fmmp, MERGE);
	// do rollup and join to get counts
	#UNIQUENAME(rollMatchSamples)
	%rollMatchSamples% := ROLLUP(%confAndFieldMatches2%,(LEFT.conf=RIGHT.conf) AND (LEFT.fmmp=RIGHT.fmmp),%rollupFMMPs%(LEFT,RIGHT));
	#UNIQUENAME(rollMatchSamples_WithCounts)
	%rollMatchSamples_WithCounts%  := JOIN(%rollMatchSamples%,
																				 %tConfMatchCount%,
																				 LEFT.conf = RIGHT.conf AND LEFT.fmmp = RIGHT.fmmp,
																				 TRANSFORM(RECORDOF(LEFT) -[sequenceNum], SELF.cnt := RIGHT.cntMatches, SELF := LEFT),
																				 ALL);
  outFile   := SORT(%rollMatchSamples_WithCounts%, -conf, -cnt);
	
ENDMACRO;
