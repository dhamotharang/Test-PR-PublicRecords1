EXPORT MAC_External_AddPcnt(infile,InScoreFormat,ResultLabel,OutFormat,BaseWeight,OutFile) := MACRO
#uniquename(f_newscore)
%f_newscore%(DATASET(OutFormat) ds) := FUNCTION
/*
1)    Take ALL of the results returned for a given ADL request
2)    Pretend there is one extra result with score BaseScore (this is for the
universality constraint; I can prove why you need this if anyone cares)
3)    For each assign a chance variable = 1/2^(MaxScore-Score)
4)    Assign probability to each as := chance / (sum of all chances)
As an example; suppose I have three records come back
David B                 = Score 45
David C                 = Score 44
David D                 = Score 42
Then with working
David B                 = Score 45 => Chance = 1         => Prob = 1 / (1.675)
David C                 = Score 44 => Chance = 1/2  => Prob = 0.5 / 1.675
David D                 = Score 42 => Chance = 1/8  => Prob = .125 / 1.675
Universe                  = Score BaseScore => Chance = 1/(2^15) => Prop = 0 (ish)
*/
    f_res(dataset(InScoreFormat) dsres) := FUNCTION
        maxweight := MAX(dsres, dsres.weight);
        REAL mychance(INTEGER weight) := 1/POWER(2,maxweight-weight);
        REAL sumchance := SUM(dsres, mychance(dsres.weight)) + mychance(BaseWeight);
        RETURN PROJECT(
            dsres,
            TRANSFORM(
                InScoreFormat,
                SELF.score := ROUND(100 * (REAL)(mychance(LEFT.weight) / sumchance));
                SELF := LEFT
            )
//        )(SALT311.DebugMode OR Score>0);
        ); // Score>0 cannot really be enforced; or Search mode fails
    END;//f_res function
    RETURN
    PROJECT(
        ds,
        TRANSFORM(
            OutFormat,
            SELF.ResultLabel := f_res(LEFT.ResultLabel),
            SELF := LEFT
        )
    );
END;
  OutFile := %f_newscore%(InFile);
	ENDMACRO;
