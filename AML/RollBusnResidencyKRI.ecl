import  ut, riskwise;

EXPORT RollBusnResidencyKRI (  DATASET(Layouts.BusnExecsLayoutV2) ExecResidencyIn ) := FUNCTION

//version 2

ResidencySlimLayout := RECORD
    unsigned4 	seq;
		unsigned6 	origbdid;
		unsigned2   ResidencyKRI1Cnt;
		unsigned2   ResidencyKRI2Cnt;
		unsigned2   ResidencyKRI3Cnt;
		unsigned2   ResidencyKRI4Cnt;
		unsigned2   ResidencyKRI5Cnt;
		unsigned2   ResidencyKRI6Cnt;
		unsigned2   ResidencyKRI7Cnt;
		unsigned2   ResidencyKRI8Cnt;
		unsigned2   ResidencyKRI9Cnt;
		unsigned2   ResidencyKRI0Cnt;
		string2   FinalResidencyKRI;
END;
   
	 
ResidencySlimLayout PrepKRI(ExecResidencyIn le) := TRANSFORM
		SELF.seq               := le.seq;
		SELF.origbdid          := le.origbdid;
		SELF.ResidencyKRI1Cnt    := if(le.ResidencyKRI = '1', 1, 0);
		SELF.ResidencyKRI2Cnt    := if(le.ResidencyKRI = '2', 1, 0);
		SELF.ResidencyKRI3Cnt    := if(le.ResidencyKRI = '3', 1, 0);
		SELF.ResidencyKRI4Cnt    := if(le.ResidencyKRI = '4', 1, 0);
		SELF.ResidencyKRI5Cnt    := if(le.ResidencyKRI = '5', 1, 0);
		SELF.ResidencyKRI6Cnt    := if(le.ResidencyKRI = '6', 1, 0);
		SELF.ResidencyKRI7Cnt    := if(le.ResidencyKRI = '7', 1, 0);
		SELF.ResidencyKRI8Cnt    := if(le.ResidencyKRI = '8', 1, 0);
		SELF.ResidencyKRI9Cnt    := if(le.ResidencyKRI = '9', 1, 0);
		SELF.ResidencyKRI0Cnt    := if(le.ResidencyKRI = '0', 1, 0);
		SELF.FinalResidencyKRI   := '0';
		
END;

PrepResdKri  := sort(project(ExecResidencyIn, PrepKRI(left)), seq, origbdid);

ResidencySlimLayout RollKRI(PrepResdKri le, PrepResdKri ri) := TRANSFORM
		SELF.seq               := le.seq;
		SELF.origbdid          := le.origbdid;
		SELF.ResidencyKRI1Cnt    := le.ResidencyKRI1Cnt + ri.ResidencyKRI1Cnt;
		SELF.ResidencyKRI2Cnt    := le.ResidencyKRI2Cnt + ri.ResidencyKRI2Cnt;
		SELF.ResidencyKRI3Cnt    := le.ResidencyKRI3Cnt + ri.ResidencyKRI3Cnt;
		SELF.ResidencyKRI4Cnt    := le.ResidencyKRI4Cnt + ri.ResidencyKRI4Cnt;
		SELF.ResidencyKRI5Cnt    := le.ResidencyKRI5Cnt + ri.ResidencyKRI5Cnt;
		SELF.ResidencyKRI6Cnt    := le.ResidencyKRI6Cnt + ri.ResidencyKRI6Cnt;
		SELF.ResidencyKRI7Cnt    := le.ResidencyKRI7Cnt + ri.ResidencyKRI7Cnt;
		SELF.ResidencyKRI8Cnt    := le.ResidencyKRI8Cnt + ri.ResidencyKRI8Cnt;
		SELF.ResidencyKRI9Cnt    := le.ResidencyKRI9Cnt + ri.ResidencyKRI9Cnt;
		SELF.ResidencyKRI0Cnt    := le.ResidencyKRI0Cnt + ri.ResidencyKRI0Cnt;
		SELF.FinalResidencyKRI   := '0';
		
END;


RolledCitzKRI   :=  rollup(PrepResdKri, RollKRI(left,right), seq, origbdid);

ResidencySlimLayout  GetFinalKRI(RolledCitzKRI le) := TRANSFORM
		SELF.seq               := le.seq;
		SELF.origbdid          := le.origbdid;
		SELF.ResidencyKRI1Cnt    := le.ResidencyKRI1Cnt;
		SELF.ResidencyKRI2Cnt    := le.ResidencyKRI2Cnt;
		SELF.ResidencyKRI3Cnt    := le.ResidencyKRI3Cnt;
		SELF.ResidencyKRI4Cnt    := le.ResidencyKRI4Cnt;
		SELF.ResidencyKRI5Cnt    := le.ResidencyKRI5Cnt;
		SELF.ResidencyKRI6Cnt    := le.ResidencyKRI6Cnt;
		SELF.ResidencyKRI7Cnt    := le.ResidencyKRI7Cnt;
		SELF.ResidencyKRI8Cnt    := le.ResidencyKRI8Cnt;
		SELF.ResidencyKRI9Cnt    := le.ResidencyKRI9Cnt;
		SELF.ResidencyKRI0Cnt    := le.ResidencyKRI0Cnt;
		SELF.FinalResidencyKRI   := MAP (
																	le.ResidencyKRI9Cnt  > 0 																		=>  '9',
																	le.ResidencyKRI8Cnt > 0																			=>  '8',
																	le.ResidencyKRI7Cnt > 0  																		=>  '7',
																	le.ResidencyKRI6Cnt  >   0 								  								=>  '6',
																	le.ResidencyKRI5Cnt > 0 																		=>  '5',
																	le.ResidencyKRI4Cnt  > 0  																	=>  '4',
																	le.ResidencyKRI3Cnt >  0 																		=>  '3',
																	le.ResidencyKRI2Cnt > 0  or  le.ResidencyKRI1Cnt > 0 			=>  '2',
																// value = 1 is set in main code, 1 means no execs they wouldn't make it to this attrib.
																	'0');
END;
																		

FinalResidencyKRI  := project(RolledCitzKRI, GetFinalKRI(left));


RETURN FinalResidencyKRI;

END;
