EXPORT Functions := MODULE
  IMPORT Std;
  EXPORT GenerateJoinEquality(Val) := FUNCTIONMACRO
    Layout := {STRING ColumnName};
    Columns := DATASET(Std.Str.SplitWords(Std.Str.FindReplace(Val, ' ', ''), ','), Layout);
    ColumnEqualities := PROJECT(Columns, TRANSFORM(RECORDOF(LEFT), SELF.ColumnName := 'LEFT.' + LEFT.ColumnName + ' = RIGHT.' + LEFT.ColumnName));
    Layout t(ColumnEqualities L, ColumnEqualities R) := TRANSFORM
      SELF.ColumnName := L.ColumnName + ' AND ' + R.ColumnName;
    END;
    JoinEquality := ROLLUP(ColumnEqualities, 
        true, t(LEFT, RIGHT));    
    RETURN JoinEquality[1].ColumnName;
  ENDMACRO;  
  

	EXPORT CalculatePercentile(InDs, Grouping, Val, PercentileRankColumnName, QuartileRank) := FUNCTIONMACRO
		//LOCAL t1 := TABLE(InDs, #EXPAND('{, ' + Grouping + ', INTEGER cnt := count(group)}'), #EXPAND(Grouping), MERGE);
    LOCAL Me := PROJECT(InDS, TRANSFORM({RECORDOF(LEFT), STRING HashID}, SELF.HashID := #EXPAND('LEFT.' + REGEXREPLACE(',', Grouping, ' + \'|\' + LEFT.')), SELF := LEFT));
		LOCAL t1 := TABLE(Me, {HashID, Val, INTEGER cnt := count(group)}, HashID, Val, MERGE);
    LOCAL TotalCandidates := TABLE(Me, {HashID, INTEGER TotalCandidates := count(group)}, HashID, MERGE);
    LOCAL t2 := JOIN(t1, TotalCandidates, LEFT.HashID=RIGHT.HashID, HASH);   
    
		LOCAL ResType := RECORD
			RECORDOF(t2);
			INTEGER CandidatesCount;
			#EXPAND('UNSIGNED1 ' + PercentileRankColumnName);
			#EXPAND('UNSIGNED1 ' + QuartileRank);
		END;

		LOCAL ResType T(ResType L, ResType R) := TRANSFORM
			SELF.CandidatesCount := L.CandidatesCount + L.Cnt;
			#EXPAND('SELF.' +PercentileRankColumnName) := ROUND(SELF.CandidatesCount / L.TotalCandidates * 100);
			#EXPAND('SELF.' +QuartileRank) := MAP(#EXPAND('SELF.' +PercentileRankColumnName)<25=>4, MAP(#EXPAND('SELF.' +PercentileRankColumnName)>=25 AND #EXPAND('SELF.' +PercentileRankColumnName)<50=>3,MAP(#EXPAND('SELF.' +PercentileRankColumnName)>=50 AND #EXPAND('SELF.' +PercentileRankColumnName)<75=>2,1)));
			SELF := R;
		END;
		
		LOCAL i1 := UNGROUP(ITERATE(PROJECT(GROUP(SORT(t2,HashID, Val, RECORD), HashID), TRANSFORM(ResType, self := LEFT, self := [])), T(LEFT,RIGHT)));
    
		LOCAL Final := JOIN(Me, i1, LEFT.HashID=RIGHT.HashID AND LEFT.Val=RIGHT.Val, TRANSFORM({RECORDOF(LEFT), #EXPAND('RIGHT.' + PercentileRankColumnName), #EXPAND('RIGHT.' +QuartileRank)}, self := LEFT, self := RIGHT), HASH);
		RETURN Final;
    
	ENDMACRO;

END;