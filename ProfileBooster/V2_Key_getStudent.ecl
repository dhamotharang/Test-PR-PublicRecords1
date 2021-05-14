IMPORT _Control, american_student_list, RiskWise, ut, mdr, risk_indicators, std, Inquiry_AccLogs, Doxie;
onThor := _Control.Environment.OnThor;

EXPORT V2_Key_getStudent(DATASET(ProfileBooster.V2_Key_Layouts.Layout_PB2_Slim_emergence) PBslim) := FUNCTION

ProfileBooster.V2_Key_Layouts.Layout_PB2_Slim_student	addStudent(PBslim le, american_student_list.key_DID ri) := transform
    OlderErmgRecord                 := (UNSIGNED6)(((STRING)ri.DATE_FIRST_SEEN)[1..6]) <= (UNSIGNED6)(((STRING)le.EmrgDt_first_seen)[1..6]) OR ProfileBooster.V2_Key_Common.convertDateTo8((STRING)le.EmrgDt_first_seen) IN ['0','99998','99998888']; 
    EmrgDt_first_seen               := IF(ri.DATE_FIRST_SEEN='0',ProfileBooster.V2_Key_Common.convertDateTo8((STRING)le.EmrgDt_first_seen),ProfileBooster.V2_Key_Common.convertDateTo8((STRING)ri.DATE_FIRST_SEEN));
    self.EmrgDt_first_seen          := IF(OlderErmgRecord,(UNSIGNED6)ProfileBooster.V2_Key_Common.convertDateTo8((STRING)ri.DATE_FIRST_SEEN),(UNSIGNED6)EmrgDt_first_seen);
    self.EmrgSrc                    := IF(OlderErmgRecord,ri.source,le.EmrgSrc);
    self.EmrgDob                    := IF(OlderErmgRecord or (UNSIGNED)le.EmrgDob<=0,ProfileBooster.V2_Common.convertDateTo8((STRING)ri.DOB_FORMATTED),ProfileBooster.V2_Common.convertDateTo8((STRING)le.EmrgDob));
    self.EmrgPrimaryRange           := IF(OlderErmgRecord,ri.prim_range,le.EmrgPrimaryRange);
    self.EmrgPredirectional	        := IF(OlderErmgRecord,ri.predir,le.EmrgPredirectional);
    self.EmrgPrimaryName	          := IF(OlderErmgRecord,ri.prim_name,le.EmrgPrimaryName);
    self.EmrgSuffix	                := IF(OlderErmgRecord,ri.addr_suffix,le.EmrgSuffix);	
    self.EmrgPostdirectional        := IF(OlderErmgRecord,ri.postdir,le.EmrgPostdirectional);
    self.EmrgUnitDesignation        := IF(OlderErmgRecord,ri.unit_desig,le.EmrgUnitDesignation);
    self.EmrgSecondaryRange	        := IF(OlderErmgRecord,ri.sec_range,le.EmrgSecondaryRange);
    self.EmrgCity_Name	            := IF(OlderErmgRecord,ri.p_city_name,le.EmrgCity_Name);	
    self.EmrgSt			                := IF(OlderErmgRecord,ri.st,le.EmrgSt);
    self.EmrgZIP5			              := IF(OlderErmgRecord,ri.z5,le.EmrgZIP5);
    self.EmrgZIP4		                := IF(OlderErmgRecord,ri.zip4,le.EmrgZIP4);
    self.student_date_first_seen	  := ProfileBooster.V2_Key_Common.convertDateTo8((STRING)ri.date_first_seen);
    self.student_date_last_seen		  := ProfileBooster.V2_Key_Common.convertDateTo8((STRING)ri.date_last_seen);
    self.student_college_code			  := MAP(ri.college_code = '1' => '3',
                                           ri.college_code = '2' => '1',
                                           ri.college_code = '4' => '2',
                                           '0');    
		self.student_college_type			  := ri.college_type;
		self.student_college_tier			  := ri.tier2;
    self.student_file_type          := ri.file_type;
    self.student_college_major      := TRIM(ri.college_major);
    self.student_college_name       := TRIM(ri.college_name);
    self.student_new_college_major  := ri.new_college_major;
    self.student_college_class      := MAP(ri.college_class='0' => 'FR',
                                           ri.college_class='1' => 'SO',
                                           ri.college_class='2' => 'JR',
                                           ri.college_class='3' => 'SR',
                                           ri.college_class='4' => 'GR',
                                                                   '-99997');
		self.src := ri.source;
    within4Years											:= ri.college_code = '4' and ProfileBooster.Common.MonthsApart_YYYYMMDD(risk_indicators.iid_constants.myGetDate((unsigned3)(ProfileBooster.V2_Key_Common.convertDateTo8((STRING)(le.historydate)))[1..6]),ProfileBooster.V2_Key_Common.convertDateTo8((STRING)ri.date_first_seen),true) < 49;
    within2Years											:= ri.college_code = '2' and ProfileBooster.Common.MonthsApart_YYYYMMDD(risk_indicators.iid_constants.myGetDate((unsigned3)(ProfileBooster.V2_Key_Common.convertDateTo8((STRING)(le.historydate)))[1..6]),ProfileBooster.V2_Key_Common.convertDateTo8((STRING)ri.date_first_seen),true) < 25;
    self.DemEduCollCurrFlag           := IF(within4Years or within2Years, 1, 0);
    self.DemEduCollFlagEv             := MAP(ri.file_type IN ['C','H','O'] => 1, 
                                             ri.file_type='M' and ri.college_name<>'' => 1,                                      
                                             0);
    self.DemEduCollNewLevelEv         := MAP(ri.college_code = '1' => 3,
                                           ri.college_code = '2' => 1,
                                           ri.college_code = '4' => 2,
                                           -99997);
    self.DemEduCollNewPvtFlag         := MAP(ri.college_type = 'P' => 1,
                                             ri.college_type = 'R' => 1,
                                                                      0);//1: PL_EduCollRecNewInstTypeEv = P or R
    TierInvalidSet                    := ['','0'];    
    self.DemEduCollNewTierIndx        := MAP(~ri.tier2 IN TierInvalidSet => (INTEGER3)ri.tier2,
                                             ~ri.tier IN TierInvalidSet => (INTEGER3)ri.tier,
                                                               -99997);
    self.DemEduCollLevelHighEv        := MAP(ri.college_code = '1' => 3,
                                           ri.college_code = '2' => 1,
                                           ri.college_code = '4' => 2,
                                           -99997);
    self.DemEduCollRecNewInstTypeEv   := ri.college_type;
    self.DemEduCollTierHighEv         := MAP(~ri.tier2 IN TierInvalidSet => (INTEGER3)ri.tier2,
                                             ~ri.tier IN TierInvalidSet => (INTEGER3)ri.tier,
                                                               -99997);
    NewMajorTypeEv  := MAP(ri.college_major IN ['A','E','L','Q','T','V']    => 1,
                                             (INTEGER)ri.new_college_major BETWEEN 100 and 199 => 1, 
                                             (INTEGER)ri.new_college_major BETWEEN 500 and 599 => 1, 
                                             ri.college_major IN ['D','H','M','N']              => 2,
                                             (INTEGER)ri.new_college_major BETWEEN 400 and 499   => 2, 
                                             (INTEGER)ri.new_college_major BETWEEN 1100 and 1199 => 2, 
                                             (INTEGER)ri.new_college_major BETWEEN 1600 and 1699 => 2,
                                             ri.college_major IN ['J'] => 3,
                                             (INTEGER)ri.new_college_major BETWEEN 1300 and 1399 => 3,
                                             ri.college_major IN ['F', 'I', 'K', 'O', 'W', 'Y'] => 4,
                                             (INTEGER)ri.new_college_major BETWEEN 600 and 699 => 4,
                                             (INTEGER)ri.new_college_major BETWEEN 700 and 799 => 4,
                                             (INTEGER)ri.new_college_major BETWEEN 800 and 899 => 4,
                                             (INTEGER)ri.new_college_major BETWEEN 1200 and 1299 => 4,
                                             (INTEGER)ri.new_college_major BETWEEN 1400 and 1499 => 4,
                                             (INTEGER)ri.new_college_major BETWEEN 1800 and 1899 => 4,
                                             (INTEGER)ri.new_college_major BETWEEN 1500 and 1599 => 5,
                                             (INTEGER)ri.new_college_major BETWEEN 1900 and 1999 => 5,
                                             ri.college_major IN ['B', 'P', 'R', 'S', 'Z'] => 6,
                                             (INTEGER)ri.new_college_major BETWEEN 200 and 299 => 6,
                                             ri.college_major IN ['C'] => 7,
                                              (INTEGER)ri.new_college_major BETWEEN 300 and 399 => 7,
                                             ri.college_major IN ['G'] => 8,
                                             (INTEGER)ri.new_college_major BETWEEN 900 and 999   => 8,
                                             (INTEGER)ri.new_college_major BETWEEN 1000 and 1099 => 8,
                                             ri.college_major IN ['U'] => -99997,
                                             (INTEGER)ri.new_college_major BETWEEN 1700 and 1799 => -99997,
                                             -99997);
    self.DemEduCollRecNewMajorTypeEv  := NewMajorTypeEv;
    self.DemEduCollEvidFlagEv         := MAP(ri.date_first_seen <> '' => 1, 0);
    DemEduCollSrcNewRecOldMsnc        := ProfileBooster.Common.MonthsApart_YYYYMMDD(risk_indicators.iid_constants.myGetDate((INTEGER)le.historydate),(STRING)ri.date_first_seen,true);
    self.DemEduCollSrcNewRecOldMsncEv := DemEduCollSrcNewRecOldMsnc;
    DemEduCollSrcNewRecNewMsnc        := ProfileBooster.Common.MonthsApart_YYYYMMDD(risk_indicators.iid_constants.myGetDate((INTEGER)le.historydate/*[1..6]*/),(STRING)ri.date_last_seen,true);
    self.DemEduCollSrcNewRecNewMsncEv := DemEduCollSrcNewRecNewMsnc;
    self.DemEduCollRecSpanEv          := IF(DemEduCollSrcNewRecOldMsnc-DemEduCollSrcNewRecNewMsnc<0,-99997,DemEduCollSrcNewRecOldMsnc-DemEduCollSrcNewRecNewMsnc);
    self.DemEduCollRecNewClassEv      := MAP(ri.college_class='FR' => 0,
                                             ri.college_class='SO' => 1,
                                             ri.college_class='JR' => 2,
                                             ri.college_class='SR' => 3,
                                             ri.college_class='GR' => 4, -99997);
    PL_EduCollRecNewLevelEv           := MAP(ri.college_code = '1' => 3,
                                           ri.college_code = '2' => 1,
                                           ri.college_code = '4' => 2,
                                           0);
    isValidDateFirstSeen              := Doxie.DOBTools((unsigned8)ri.date_first_seen).IsValidDOB;
    isValidDateLastSeen               := Doxie.DOBTools((unsigned8)ri.date_last_seen).IsValidDOB;
    PL_EduCollSrcNewRecOldDtEv        := ri.date_first_seen;
    PL_EduCollSrcNewRecNewDtEv        := ri.date_last_seen;
    ExpBeginDate                      := ProfileBooster.V2_Key_Common.convertDateTo8((STRING)PL_EduCollSrcNewRecOldDtEv);
    ExpGradYr2Yrs                     := (INTEGER3)((STRING)STD.Date.AdjustDate((UNSIGNED4)(ExpBeginDate),2,0,0))[1..4];
    ExpGradYr4Yrs                     := (INTEGER3)((STRING)STD.Date.AdjustDate((UNSIGNED4)(ExpBeginDate),4,0,0))[1..4];
    ExpEndDate                        := ProfileBooster.V2_Key_Common.convertDateTo8((STRING)STD.Date.AdjustDate((UNSIGNED4)(ExpBeginDate),4,0,0));
    IsWithin100Yrs                    := STD.Date.YearsBetween((UNSIGNED4)ExpEndDate,(UNSIGNED4)STD.Date.Today())<=100; //need a function to test this
    self.DemEduCollSrcNewExpGradYr    := MAP(
                                             PL_EduCollRecNewLevelEv=1 AND isValidDateFirstSeen AND IsWithin100Yrs => ExpGradYr2Yrs,//+2 years
                                             PL_EduCollRecNewLevelEv=2 AND isValidDateFirstSeen AND IsWithin100Yrs => ExpGradYr4Yrs,//+4 years
                                             ~IsWithin100Yrs                                                       => -99997,
                                             ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT
                                             );
    self.DemEduCollInstPvtFlagEv      := MAP(
                                             ri.college_type IN ['P','R'] => 1,
                                                                             0);
    self.DemEduCollMajorMedicalFlagEv := MAP(
                                             NewMajorTypeEv = 1 => 1,
                                             ri.college_major IN ['A','E','L','Q','T','V'] => 1,
                                             (INTEGER)ri.new_college_major BETWEEN 100 and 199 => 1, 
                                             (INTEGER)ri.new_college_major BETWEEN 500 and 599 => 1, 
                                                                                                  0);
    self.DemEduCollMajorPhysSciFlagEv := MAP(
                                             NewMajorTypeEv = 2 => 1,
                                             ri.college_major IN ['D','H','M','N'] => 1,
                                             (INTEGER)ri.new_college_major BETWEEN 400 and 499 => 1, 
                                             (INTEGER)ri.new_college_major BETWEEN 1100 and 1199 => 1, 
                                             (INTEGER)ri.new_college_major BETWEEN 1600 and 1699 => 1, 
                                                                                                    0);
    self.DemEduCollMajorSocSciFlagEv := MAP(
                                             NewMajorTypeEv = 3 => 1,
                                             ri.college_major IN ['J'] => 1,
                                             (INTEGER)ri.new_college_major BETWEEN 1300 and 1399 => 1,
                                                                                                    0);
    self.DemEduCollMajorLibArtsFlagEv := MAP(
                                             NewMajorTypeEv = 4 => 1,
                                             ri.college_major IN ['F', 'I', 'K', 'O', 'W', 'Y'] => 1,
                                             (INTEGER)ri.new_college_major BETWEEN 600 and 699 => 1,
                                             (INTEGER)ri.new_college_major BETWEEN 700 and 799 => 1,
                                             (INTEGER)ri.new_college_major BETWEEN 800 and 899 => 1,
                                             (INTEGER)ri.new_college_major BETWEEN 1200 and 1299 => 1,
                                             (INTEGER)ri.new_college_major BETWEEN 1400 and 1499 => 1,
                                             (INTEGER)ri.new_college_major BETWEEN 1800 and 1899 => 1,
                                                                                                    0);
    self.DemEduCollMajorTechnicalFlagEv := MAP(
                                             NewMajorTypeEv = 5 => 1,
                                             (INTEGER)ri.new_college_major BETWEEN 1500 and 1599 => 1,
                                             (INTEGER)ri.new_college_major BETWEEN 1900 and 1999 => 1,
                                                                                                    0);
    self.DemEduCollMajorBusFlagEv := MAP(
                                             NewMajorTypeEv = 6 => 1,
                                             ri.college_major IN ['B', 'P', 'R', 'S', 'Z'] => 1,
                                             (INTEGER)ri.new_college_major BETWEEN 200 and 299 => 1,
                                                                                                  0);
    self.DemEduCollMajorEduFlagEv := MAP(
                                             NewMajorTypeEv = 7 => 1,
                                             ri.college_major IN ['C'] => 1,
                                             (INTEGER)ri.new_college_major BETWEEN 300 and 399 => 1,
                                                                                                  0);
    self.DemEduCollMajorLawFlagEv := MAP(
                                             NewMajorTypeEv = 8 => 1,
                                             ri.college_major IN ['G'] => 1,
                                             (INTEGER)ri.new_college_major BETWEEN 900 and 999   => 1,
                                             (INTEGER)ri.new_college_major BETWEEN 1000 and 1099 => 1,
                                                                                                    0);
		self := le;
    self := [];
	end; 

students_roxie := join(PBslim, american_student_list.key_DID,
		left.did2!=0
		and keyed(left.did2=right.l_did)
		and (unsigned3)(right.date_first_seen[1..6]) < left.historydate
		and ~(right.source=mdr.sourceTools.src_OKC_Student_List and right.collegeid in Risk_Indicators.iid_constants.Set_Restricted_Colleges_For_Marketing), // can't use this source in marketing products
		addStudent(left,right), left outer, atmost(keyed(left.did2=right.l_did), 100));

students_thor := join(
	distribute(PBslim, did2), 
	distribute(pull(american_student_list.key_DID), l_did),
		left.did2!=0
		and left.did2=right.l_did
		and (unsigned3)(right.date_first_seen[1..6]) < left.historydate
		and ~(right.source=mdr.sourceTools.src_OKC_Student_List and right.collegeid in Risk_Indicators.iid_constants.Set_Restricted_Colleges_For_Marketing), // can't use this source in marketing products
		addStudent(left,right), left outer, local);
			
#IF(onThor)
	students := students_thor;
#ELSE
	students := students_roxie;
#END

  hsStudents := dedup(sort(students((NOT student_file_type IN ['C','H','O']) OR (student_file_type='M' and student_college_name='')), seq, DID2, -student_date_last_seen, -student_date_first_seen,src),seq, DID2, local);
  collStudents := SORT(students(student_file_type IN ['C','H','O'] OR (student_file_type='M' and student_college_name<>'')), seq, DID2, -student_date_last_seen, -student_date_first_seen,src, local);
//rollup to accumulate the counts 
  ProfileBooster.V2_Key_Layouts.Layout_PB2_Slim_student rollStudents(ProfileBooster.V2_Key_Layouts.Layout_PB2_Slim_student le, ProfileBooster.V2_Key_Layouts.Layout_PB2_Slim_student ri) := transform
    PL_EduCollSrcEmrgOldestDt       := map(le.student_date_first_seen = '0'		=> (INTEGER)ri.student_date_first_seen,
                                           ri.student_date_first_seen = '0'		=> (INTEGER)le.student_date_first_seen,
																													 min((INTEGER)le.student_date_first_seen, (INTEGER)ri.student_date_first_seen));
		self.student_date_first_seen		:= (STRING)PL_EduCollSrcEmrgOldestDt;
    PL_EduCollSrcEmrgNewestDt       := max(le.student_date_last_seen, ri.student_date_last_seen);
		self.student_date_last_seen			:= (STRING)PL_EduCollSrcEmrgNewestDt;

    within4Years										:= ri.student_college_code = '4' and ProfileBooster.Common.MonthsApart_YYYYMMDD(risk_indicators.iid_constants.myGetDate((INTEGER)ri.historydate[1..6]),(STRING)ri.student_date_first_seen,true) < 49;
    within2Years										:= ri.student_college_code = '2' and ProfileBooster.Common.MonthsApart_YYYYMMDD(risk_indicators.iid_constants.myGetDate((INTEGER)ri.historydate[1..6]),(STRING)ri.student_date_first_seen,true) < 25;
		self.student_college_code			  := MAP(NOT le.student_college_code IN ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_SET => le.student_college_code, 
                                         NOT ri.student_college_code IN ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_SET => ri.student_college_code,
                                         ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
		self.student_college_type			  := MAP(NOT le.student_college_type IN ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_SET => le.student_college_type, 
                                         NOT ri.student_college_type IN ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_SET => ri.student_college_type,
                                         ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
		self.student_college_tier			  := MAP(NOT le.student_college_tier IN ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_SET => le.student_college_tier, 
                                         NOT ri.student_college_tier IN ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_SET => ri.student_college_tier,
                                         ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
    self.student_file_type          := MAP(NOT le.student_file_type IN ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_SET => le.student_file_type, 
                                         NOT ri.student_file_type IN ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_SET => ri.student_file_type,
                                         ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
    self.student_college_major      := MAP(NOT le.student_college_major IN ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_SET => le.student_college_major, 
                                         NOT ri.student_college_major IN ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_SET => ri.student_college_major,
                                         ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
    self.student_new_college_major  := MAP(NOT le.student_new_college_major IN ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_SET => le.student_new_college_major, 
                                         NOT ri.student_new_college_major IN ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_SET => ri.student_new_college_major,
                                         ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
    self.student_college_class      := MAP(NOT le.student_college_class IN ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_SET => le.student_college_class, 
                                         NOT ri.student_college_class IN ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_SET => ri.student_college_class,
                                         ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
		self.src                        := MAP(NOT le.src IN ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_SET => le.src, 
                                         NOT ri.src IN ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_SET => ri.src,
                                         ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
    NewerRecord                     := (INTEGER)ri.student_date_first_seen>=(INTEGER)le.student_date_first_seen;
    self.DemEduCollCurrFlag         := if(le.DemEduCollCurrFlag=1 or ri.DemEduCollCurrFlag=1, 1, 0);
    self.DemEduCollFlagEv           := if(le.DemEduCollFlagEv=1 or ri.DemEduCollFlagEv=1, 1, 0);
    self.DemEduCollNewLevelEv       := if(NewerRecord,ri.DemEduCollNewLevelEv,le.DemEduCollNewLevelEv);
    self.DemEduCollNewPvtFlag       := if(NewerRecord,ri.DemEduCollNewPvtFlag,le.DemEduCollNewPvtFlag);
    self.DemEduCollNewTierIndx      := if(NewerRecord,ri.DemEduCollNewTierIndx,le.DemEduCollNewTierIndx);
    
    self.DemEduCollLevelHighEv      := MAX(le.DemEduCollLevelHighEv,ri.DemEduCollLevelHighEv);
    self.DemEduCollRecNewInstTypeEv := MAP(NewerRecord => ri.DemEduCollRecNewInstTypeEv,
                                                            le.DemEduCollRecNewInstTypeEv);
    self.DemEduCollTierHighEv       := MAP(le.DemEduCollTierHighEv=0 and ri.DemEduCollTierHighEv=0 => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,
                                             MAX(le.DemEduCollTierHighEv,ri.DemEduCollTierHighEv));
    self.DemEduCollRecNewMajorTypeEv := MAP(NewerRecord => ri.DemEduCollRecNewMajorTypeEv,
                                             NOT le.DemEduCollRecNewMajorTypeEv = ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT => le.DemEduCollRecNewMajorTypeEv,
                                             ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
    self.DemEduCollEvidFlagEv       := MAX(le.DemEduCollEvidFlagEv,ri.DemEduCollEvidFlagEv);
                                            // IF(le.student_date_first_seen <> '' => 1,
                                            //  ri.student_date_first_seen <> '' => 1, 0);
    PL_EduCollRecNewLevelEv         := MAP(NewerRecord => ri.student_college_code, 
                                             NOT le.student_college_code = ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND => le.student_college_code,
                                             ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
    PL_EduCollSrcNewRecOldDtEv      := MAP(NewerRecord => ri.student_date_first_seen, 
                                             NOT le.student_date_first_seen IN ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_SET => le.student_date_first_seen,
                                             ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
    PL_EduCollSrcNewRecNewDtEv      := MAP(NewerRecord => ri.student_date_last_seen, 
                                             NOT le.student_date_last_seen IN ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_SET => le.student_date_last_seen,
                                             ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
    self.DemEduCollSrcNewRecOldMsncEv := ProfileBooster.Common.MonthsApart_YYYYMMDD(risk_indicators.iid_constants.myGetDate(ri.historydate),(STRING)PL_EduCollSrcNewRecOldDtEv,true);
    self.DemEduCollSrcNewRecNewMsncEv := ProfileBooster.Common.MonthsApart_YYYYMMDD(risk_indicators.iid_constants.myGetDate(ri.historydate),(STRING)PL_EduCollSrcNewRecNewDtEv,true);
    self.DemEduCollRecSpanEv        := ProfileBooster.Common.MonthsApart_YYYYMMDD((STRING)PL_EduCollSrcEmrgOldestDt,(STRING)PL_EduCollSrcEmrgNewestDt,true);
    self.DemEduCollRecNewClassEv    := MAP(NewerRecord => ri.DemEduCollRecNewClassEv, 
                                             NOT le.DemEduCollRecNewClassEv = ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT => le.DemEduCollRecNewClassEv,
                                             ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
    self.DemEduCollSrcNewExpGradYr  := MAP(
                                             PL_EduCollRecNewLevelEv='1' => (INTEGER3)((STRING)STD.Date.AdjustDate((UNSIGNED4)((STRING)(PL_EduCollSrcNewRecOldDtEv+'01')),2,0,0))[1..4],//+2 years
                                             PL_EduCollRecNewLevelEv='2' => (INTEGER3)((STRING)STD.Date.AdjustDate((UNSIGNED4)((STRING)(PL_EduCollsrcNewRecOldDtEv+'01')),4,0,0))[1..4],//+4 years
                                             ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT
                                             );
    self.DemEduCollInstPvtFlagEv    := MAX(le.DemEduCollInstPvtFlagEv,ri.DemEduCollInstPvtFlagEv);
    self.DemEduCollMajorMedicalFlagEv := MAX(le.DemEduCollMajorMedicalFlagEv,ri.DemEduCollMajorMedicalFlagEv);
    self.DemEduCollMajorPhysSciFlagEv := MAX(le.DemEduCollMajorPhysSciFlagEv,ri.DemEduCollMajorPhysSciFlagEv);
    self.DemEduCollMajorSocSciFlagEv  := MAX(le.DemEduCollMajorSocSciFlagEv,ri.DemEduCollMajorSocSciFlagEv);
    self.DemEduCollMajorLibArtsFlagEv := MAX(le.DemEduCollMajorLibArtsFlagEv,ri.DemEduCollMajorLibArtsFlagEv);
    self.DemEduCollMajorTechnicalFlagEv := MAX(le.DemEduCollMajorTechnicalFlagEv,ri.DemEduCollMajorTechnicalFlagEv);
    self.DemEduCollMajorBusFlagEv   := MAX(le.DemEduCollMajorBusFlagEv,ri.DemEduCollMajorBusFlagEv);
    self.DemEduCollMajorEduFlagEv   := MAX(le.DemEduCollMajorEduFlagEv,ri.DemEduCollMajorEduFlagEv);
    self.DemEduCollMajorLawFlagEv   := MAX(le.DemEduCollMajorLawFlagEv,ri.DemEduCollMajorLawFlagEv);
    OlderErmgRecord := (UNSIGNED6)(((STRING)ri.EmrgDt_first_seen)[1..6]) <= (UNSIGNED6)(((STRING)le.EmrgDt_first_seen)[1..6]) OR ProfileBooster.V2_Key_Common.convertDateTo8((STRING)le.EmrgDt_first_seen) IN ['0','99998','99998888'];
		self.EmrgDt_first_seen          := IF(OlderErmgRecord,(UNSIGNED6)ProfileBooster.V2_Key_Common.convertDateTo8((STRING)ri.EmrgDt_first_seen),(UNSIGNED6)ProfileBooster.V2_Key_Common.convertDateTo8((STRING)le.EmrgDt_first_seen));
		self.EmrgSrc                    := IF(OlderErmgRecord,ri.EmrgSrc,le.EmrgSrc);
		EmrgDob					                := IF(OlderErmgRecord,ri.EmrgDob,le.EmrgDob);
		self.EmrgDob			              := EmrgDob;
		EmrgAge     			              := if(OlderErmgRecord,ri.EmrgAge,le.EmrgAge);
		self.EmrgAge   			            := EmrgAge;
		self.EmrgPrimaryRange           := IF(OlderErmgRecord,ri.EmrgPrimaryRange,le.EmrgPrimaryRange);
		self.EmrgPredirectional	        := IF(OlderErmgRecord,ri.EmrgPredirectional,le.EmrgPredirectional);
		self.EmrgPrimaryName	          := IF(OlderErmgRecord,ri.EmrgPrimaryName,le.EmrgPrimaryName);
		self.EmrgSuffix	                := IF(OlderErmgRecord,ri.EmrgSuffix,le.EmrgSuffix);	
		self.EmrgPostdirectional        := IF(OlderErmgRecord,ri.EmrgPostdirectional,le.EmrgPostdirectional);
		self.EmrgUnitDesignation        := IF(OlderErmgRecord,ri.EmrgUnitDesignation,le.EmrgUnitDesignation);
		self.EmrgSecondaryRange	        := IF(OlderErmgRecord,ri.EmrgSecondaryRange,le.EmrgSecondaryRange);
		self.EmrgCity_Name	            := IF(OlderErmgRecord,ri.EmrgCity_Name,le.EmrgCity_Name);	
		self.EmrgSt			                := IF(OlderErmgRecord,ri.EmrgSt,le.EmrgSt);
		self.EmrgZIP5			              := IF(OlderErmgRecord,ri.EmrgZIP5,le.EmrgZIP5);
		self.EmrgZIP4		                := IF(OlderErmgRecord,ri.EmrgZIP4,le.EmrgZIP4);  
		self									          := le;
	end;
	
  rolledStudents := rollup(collStudents, rollStudents(left,right), seq, local);

  ProfileBooster.V2_Key_Layouts.Layout_PB2_Slim_student xfm_HS_Students(ProfileBooster.V2_Key_Layouts.Layout_PB2_Slim_student le) := transform
    self.DemEduCollCurrFlag         := 0;
    self.DemEduCollFlagEv           := 0;
    self.DemEduCollNewLevelEv       := IF(le.DemEduCollFlagEv=1 AND le.student_college_code='',
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,//-99997
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);//-99998
    self.DemEduCollNewPvtFlag       := IF(le.DemEduCollFlagEv=1 AND le.student_college_type='',
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
    self.DemEduCollNewTierIndx      := IF(le.DemEduCollFlagEv=1 AND ~le.DemEduCollNewTierIndx IN [1,2,3,4,5,6],
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,        
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);        
    self.DemEduCollLevelHighEv      := IF(le.DemEduCollFlagEv=1 AND le.DemEduCollLevelHighEv =-99997,
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,        
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT); 
    self.DemEduCollRecNewInstTypeEv := IF(le.DemEduCollFlagEv=1 AND le.DemEduCollRecNewInstTypeEv = '',
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE,        
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND); 
    self.DemEduCollTierHighEv       := IF(le.DemEduCollFlagEv=1 AND le.DemEduCollTierHighEv=0,
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,        
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
    self.DemEduCollRecNewMajorTypeEv := IF(le.DemEduCollFlagEv=1 AND le.DemEduCollRecNewMajorTypeEv = -99997,
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,        
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
    self.DemEduCollEvidFlagEv       := 0;
    self.DemEduCollSrcNewRecOldMsncEv := IF(le.DemEduCollFlagEv=1 AND le.DemEduCollSrcNewRecOldMsncEv = 0,
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,        
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
    self.DemEduCollSrcNewRecNewMsncEv := IF(le.DemEduCollFlagEv=1 AND le.DemEduCollSrcNewRecNewMsncEv = 0,
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,        
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
    self.DemEduCollRecSpanEv        := IF(le.DemEduCollFlagEv=1 AND le.DemEduCollRecSpanEv = 0,
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,        
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
    self.DemEduCollRecNewClassEv    := IF(le.DemEduCollFlagEv=1 AND le.DemEduCollRecNewClassEv = -99997,
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,        
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
    self.DemEduCollSrcNewExpGradYr  := IF(le.DemEduCollFlagEv=1 AND (INTEGER)le.DemEduCollSrcNewExpGradYr <= 0,
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,        
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
    self.DemEduCollInstPvtFlagEv    := IF(le.DemEduCollFlagEv=1 AND le.DemEduCollInstPvtFlagEv = -99997,
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,        
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
    self.DemEduCollMajorMedicalFlagEv := IF(le.DemEduCollFlagEv=1 AND le.DemEduCollMajorMedicalFlagEv = -99997,
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,        
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
    self.DemEduCollMajorPhysSciFlagEv := IF(le.DemEduCollFlagEv=1 AND le.DemEduCollMajorPhysSciFlagEv = -99997,
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,        
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
    self.DemEduCollMajorSocSciFlagEv := IF(le.DemEduCollFlagEv=1 AND le.DemEduCollMajorSocSciFlagEv = -99997,
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,        
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
    self.DemEduCollMajorLibArtsFlagEv := IF(le.DemEduCollFlagEv=1 AND le.DemEduCollMajorLibArtsFlagEv = -99997,
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,        
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
    self.DemEduCollMajorTechnicalFlagEv := IF(le.DemEduCollFlagEv=1 AND le.DemEduCollMajorTechnicalFlagEv = -99997,
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,        
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
    self.DemEduCollMajorBusFlagEv   := IF(le.DemEduCollFlagEv=1 AND le.DemEduCollMajorBusFlagEv = -99997,
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,        
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
    self.DemEduCollMajorEduFlagEv   := IF(le.DemEduCollFlagEv=1 AND le.DemEduCollMajorEduFlagEv = -99997,
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,        
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
    self.DemEduCollMajorLawFlagEv   := IF(le.DemEduCollFlagEv=1 AND le.DemEduCollMajorLawFlagEv = -99997,
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,        
                                            ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
    
		self									          := le;
	end;
  
  onlyHSStudents := JOIN(DISTRIBUTE(hsStudents,seq),DISTRIBUTE(rolledStudents,seq),
                         LEFT.seq=right.seq,
                         xfm_HS_Students(LEFT),
                         LEFT ONLY, local);
  allStudents := onlyHSStudents+rolledStudents;	

// DEBUGGING
// output(CHOOSEN(students,100), named('students'));
// output(CHOOSEN(hsStudents,100), named('hsStudents'));
// output(CHOOSEN(collStudents,100), named('collStudents'));
// output(CHOOSEN(rolledStudents,100), named('rolledStudents'));
// output(CHOOSEN(onlyHSStudents,100), named('onlyHSStudents'));
// output(CHOOSEN(allStudents,100), named('allStudents'));
// OUTPUT(onlyHSStudents,, '~thor400::out::profile_booster11_attributes_onlyHSStudents_' + thorlib.wuid(),CSV(HEADING(single), QUOTE('"')),overwrite);
// OUTPUT(rolledStudents,, '~thor400::out::profile_booster11_attributes_rolledStudents_' + thorlib.wuid(),CSV(HEADING(single), QUOTE('"')),overwrite);
// OUTPUT(allStudents,, '~thor400::out::profile_booster11_attributes_allStudents_' + thorlib.wuid(),CSV(HEADING(single), QUOTE('"')),overwrite);

RETURN allStudents;

END;										