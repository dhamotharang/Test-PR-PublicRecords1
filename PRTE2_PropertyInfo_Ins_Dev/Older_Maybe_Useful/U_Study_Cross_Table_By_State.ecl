// NOTE: Numbers this returns count both so addresses ~= 1/2 count
// adding also review by B records and D records!!  

IMPORT PRTE2_PropertyInfo;

Files := PRTE2_PropertyInfo.Files;
Layouts := PRTE2_PropertyInfo.Layouts;

DataIn := Files.PII_ALPHA_BASE_SF_DS;
OUTPUT(COUNT(dataIn));
OUTPUT(dataIn);

report0 := RECORD
	// recTypeSrc	 := DataIn.st;
	recTypeSrc	 := DataIn.st+':'+DataIn.Vendor_Source;
	GroupCount := COUNT(GROUP);
END;
REPORT2 := RECORD
	STRING2 state;
	INTEGER BCnt;
	INTEGER DCnt;
	// Later TODO - add a maxCnt which is the max of Bcnt or Dcnt
	// that is not exactly the answer of how many are in that state, but neither is the sum of them.
	// a cross table can't answer how many unique addresses are in each state so it's just an estimate
	// IE: FL might have Bcnt=500 and Dcnt=400 and for unique addresses the 500 would count but 
	//     Dcnt might have 300 that are for the addresses in that 500 - therefore the answer would be 500+200=700
	//     But you just cannot know from a cross table report.
END;

RepTable0 := TABLE(DataIn,report0,st,Vendor_Source);
// OUTPUT(SORT(RepTable0,recTypeSrc),ALL);

// The following is only required if you try to summarize by state broken out by record type
// if you just want raw counts ignoring record type then:
//    comment all lines below this 
//		and uncomment line 25 
//		and reverse commenting on lines 14 and 15
InitialDS := SORT(RepTable0,recTypeSrc);
IBDS := InitialDS(recTypeSrc[4]='B');
IDDS := InitialDS(recTypeSrc[4]='D');

REPORT2 xform(IBDS L, IDDS R) := TRANSFORM
	SELF.state := IF(L.recTypeSrc[1..2]='',R.recTypeSrc[1..2],L.recTypeSrc[1..2]);
	SELF.BCnt := L.GroupCount;
	SELF.DCnt := R.GroupCount;
END;

FinalDS := JOIN(IBDS, IDDS
								, left.recTypeSrc[1..2] = right.recTypeSrc[1..2]
								, xform(left,right)
								);
OUTPUT(SORT(FinalDS,state),ALL);


