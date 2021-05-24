IMPORT ProfileBooster, dx_ProfileBooster, Risk_Indicators, Models, iesp, doxie, ut;

EXPORT V2_getAttributes(DATASET(ProfileBooster.V2_Layouts.Layout_PB2_Shell) PB2Shell, 
                     string50 DataPermissionMask = risk_indicators.iid_constants.default_DataPermission) := FUNCTION
  
  ProfileBooster.V2_Layouts.tempAttributesLayout getAttr(PB2Shell le) := TRANSFORM
    nines                                                 := 9999999;
    noDid                                                 := le.did = 0;
    isMinor                                               := (le.ProspectAge > 0 and le.ProspectAge < 18); //check to see if person is a minor
    noHHID                                                := le.HHID <= 0;
    self.seq                                              := le.seq;
    self.AcctNo                                           := le.AcctNo;
    self.LexID                                            := le.did;
    self.rec_type                                         := le.rec_type;
    self.Did2                                             := le.Did2;
    self.attributes.version2.verdonotmailflag             := IF(noDid or isMinor, '-99999', le.DoNotMail);
    self.attributes.version2.verprospectfoundflag         := IF(noDid, '-99999', '1');  
    self.attributes.version2.verinpnameindx               := MAP(noDid or isMinor or le.fname = '' or le.lname = '' => '-99999', 
                                                                 le.firstcount > 0 and le.lastcount > 0 => '3',
                                                                 le.lastcount > 0                       => '2',
                                                                 le.firstcount > 0                      => '1',
                                                                                                           '0');
    self.attributes.version2.verinpssnflag                := MAP(noDid or isMinor or le.ssn = ''        => '-99999', 
                                                                 le.socscount > 0                       => '1', 
                                                                                                           '0');
    self.attributes.version2.verinpphoneflag              := MAP(noDid or isMinor or le.phone10 = ''    => '-99999', 
                                                                 le.phonecount > 0                      => '1', 
                                                                                                          '0');
    self.attributes.version2.VerInpAddrMatchIndx          := MAP(noDid or isMinor                       => '-99999', 
                                                                 le.VerifiedCurrResMatchIndex = ''      => '0',
                                                                                                           le.VerifiedCurrResMatchIndex);
    self.attributes.version2.VerInpEmailFlag              := MAP(noDid or isMinor                       => '-99999', 
                                                                                                           le.veremail = ''  => '0',
                                                                                                           '1');
    TimeOnRecord := IF(le.dt_first_seen = 0, '-1', (string)MIN(ut.MonthsApart((string6)le.dt_first_seen,risk_indicators.iid_constants.myGetDate(le.historydate)[1..6]),ProfileBooster.V2_Constants.Max960));
    INTEGER4 DrgNewMsnc7YHelper := IF(le.DrgNewMsnc7Y<=0,ut.MonthsApart((string6)le.dt_last_seen,risk_indicators.iid_constants.myGetDate(le.historydate)[1..6]),le.DrgNewMsnc7Y);
    TimeLastUpdate := IF(le.dt_last_seen = 0, '-1', (string)MIN(ut.MonthsApart((string6)le.dt_last_seen,risk_indicators.iid_constants.myGetDate(le.historydate)[1..6]), (integer4)DrgNewMsnc7YHelper, ProfileBooster.V2_Constants.Max960));
    self.attributes.version2.DemUpdtOldMsnc               := MAP(noDid or isMinor                       => '-99999', 
                                                                 (integer4)TimeOnRecord<0               => '-99997',
                                                                                                           TimeOnRecord);
    self.attributes.version2.DemUpdtNewMsnc               := MAP(noDid or isMinor                       => '-99999', 
                                                                 (integer4)TimeLastUpdate<0             => '-99997',
                                                                                                           TimeLastUpdate);
    self.attributes.version2.DemUpdtFlag1Y                := MAP(noDid or isMinor                       => '-99999', 
                                                                 TimeLastUpdate<>'-1' and (integer)TimeLastUpdate <= 12 => '1', 
                                                                 TimeLastUpdate='-1'                    => '-99997',
                                                                                                           '0');
    self.attributes.version2.DemAge                       := MAP(noDid                                  => '-99999',
                                                                 le.ProspectAge = 0 and NOT isMinor     => '-99998',
                                                                 le.ProspectAge > 17                    => (string)MIN(le.ProspectAge,120),
                                                                 isMinor                                => '0',
                                                                                                           '0'); 
    self.attributes.version2.DemGender                    := MAP(noDid or isMinor                       => '-99999',
                                                                 le.title = 'MR'                        => 'M',
                                                                 le.title = 'MS'                        => 'F',
                                                                 le.gender = 'M'                        => 'M',
                                                                 le.gender = 'F'                        => 'F', 
                                                                                                           '-99998');
    self.attributes.version2.DemIsMarriedFlag             := MAP(noDid or isMinor                       => '-99999', 
                                                                 stringlib.stringtouppercase(le.marital_status) = 'Y' => '1', 
                                                                                                           '0');
    isDeceased := le.dod > 0 or (Risk_Indicators.iid_constants.deathSSA_ok(DataPermissionMask) and le.dodSSA > 0);
    self.attributes.version2.DemDeceasedFlag              := MAP(noDid or isMinor                       => '-99999', 
                                                                 isDeceased                             => '1', 
                                                                                                           '0');
                                                                                                         
    self.attributes.version2.DemEstInc                    := MAP(noDid or isMinor                       => '-99999', 
                                                                                                          (string)MIN((integer)le.ProspectEstimatedIncomeRange,999999));
    self.attributes.version2.DemEduCollCurrFlag           := IF(noDid or isMinor, -99999, le.DemEduCollCurrFlag);
    self.attributes.version2.DemEduCollFlagEv             := IF(noDid or isMinor, -99999, le.DemEduCollFlagEv);
    self.attributes.version2.DemEduCollNewLevelEv         := MAP(noDid or isMinor                       => -99999, 
                                                                 le.DemEduCollNewLevelEv=0              => -99998,
                                                                                                           le.DemEduCollNewLevelEv);
    self.attributes.version2.DemEduCollNewPvtFlag         := MAP(noDid or isMinor                       => -99999, 
                                                                 le.DemEduCollFlagEv=0                  => -99998,
                                                                 le.DemEduCollNewPvtFlag>=0             => le.DemEduCollNewPvtFlag,
                                                                                                           -99997);
    self.attributes.version2.DemEduCollNewTierIndx        := MAP(noDid or isMinor                       => -99999, 
                                                                 le.DemEduCollNewTierIndx>0             => le.DemEduCollNewTierIndx,
                                                                                                           -99998);
    self.attributes.version2.DemEduCollLevelHighEv        := MAP(noDid or isMinor                       => -99999, 
                                                                 le.DemEduCollLevelHighEv>0             => le.DemEduCollLevelHighEv,
                                                                                                           -99998);
    self.attributes.version2.DemEduCollRecNewInstTypeEv   := MAP(noDid or isMinor                       => '-99999', 
                                                                 le.DemEduCollRecNewInstTypeEv=''       => '-99998',
                                                                                                           le.DemEduCollRecNewInstTypeEv);
    self.attributes.version2.DemEduCollTierHighEv         := MAP(noDid or isMinor                       => -99999, 
                                                                 le.DemEduCollTierHighEv=0              => -99998,
                                                                                                           le.DemEduCollTierHighEv);
    isMajorTypeCategorized := MAX(le.demeducollmajormedicalflagev,le.demeducollmajorphyssciflagev,le.demeducollmajorsocsciflagev,le.demeducollmajorlibartsflagev,le.demeducollmajortechnicalflagev,
    le.demeducollmajorbusflagev,le.demeducollmajoreduflagev,le.demeducollmajorlawflagev);
    self.attributes.version2.DemEduCollRecNewMajorTypeEv  := MAP(noDid or isMinor                       => -99999, 
                                                                 le.DemEduCollRecNewMajorTypeEv>0       => le.DemEduCollRecNewMajorTypeEv,
                                                                 isMajorTypeCategorized>=0 AND le.demeducollflagev=1 => -99997,
                                                                                                           -99998);
    self.attributes.version2.DemEduCollEvidFlagEv         := MAP(noDid or isMinor                       => -99999, 
                                                                                                           le.DemEduCollEvidFlagEv);
    self.attributes.version2.DemEduCollSrcNewRecOldMsncEv := MAP(noDid or isMinor                       => -99999, 
                                                                 le.DemEduCollFlagEv=0                  => -99998,
                                                                                                           MIN((INTEGER)le.DemEduCollSrcNewRecOldMsncEv,999));
    self.attributes.version2.DemEduCollSrcNewRecNewMsncEv := MAP(noDid or isMinor                       => -99999, 
                                                                 le.DemEduCollFlagEv=0                  => -99998,
                                                                                                           MIN((INTEGER)le.DemEduCollSrcNewRecNewMsncEv,999));
    self.attributes.version2.DemEduCollRecSpanEv          := MAP(noDid or isMinor                       => -99999, 
                                                                 le.DemEduCollFlagEv=0                  => -99998,
                                                                 le.DemEduCollRecSpanEv>-99997 AND le.DemEduCollRecSpanEv<0 => -99997,
                                                                                                           MIN((INTEGER)le.DemEduCollRecSpanEv,999));
    self.attributes.version2.DemEduCollRecNewClassEv      := MAP(noDid or isMinor                       => -99999, 
                                                                 le.DemEduCollFlagEv=0                  => -99998,
                                                                                                           le.DemEduCollRecNewClassEv);
    self.attributes.version2.DemEduCollSrcNewExpGradYr    := MAP(noDid or isMinor                       => -99999, 
                                                                 le.DemEduCollFlagEv=0                  => -99998,
                                                                                                           le.DemEduCollSrcNewExpGradYr);
    self.attributes.version2.DemEduCollInstPvtFlagEv      := MAP(noDid or isMinor                       => -99999, 
                                                                 le.DemEduCollFlagEv=0                  => -99998,
                                                                                                           le.DemEduCollInstPvtFlagEv);
    self.attributes.version2.DemEduCollMajorMedicalFlagEv := MAP(noDid or isMinor                       => -99999,
                                                                 le.DemEduCollFlagEv=0                  => -99998,
                                                                                                           le.DemEduCollMajorMedicalFlagEv);
    self.attributes.version2.DemEduCollMajorPhysSciFlagEv := MAP(noDid or isMinor                       => -99999,
                                                                 le.DemEduCollFlagEv=0                  => -99998,
                                                                                                           le.DemEduCollMajorPhysSciFlagEv);
    self.attributes.version2.DemEduCollMajorSocSciFlagEv  := MAP(noDid or isMinor                       => -99999,
                                                                 le.DemEduCollFlagEv=0                  => -99998,
                                                                                                           le.DemEduCollMajorSocSciFlagEv);
    self.attributes.version2.DemEduCollMajorLibArtsFlagEv := MAP(noDid or isMinor                       => -99999,
                                                                 le.DemEduCollFlagEv=0                  => -99998,
                                                                                                           le.DemEduCollMajorLibArtsFlagEv);
    self.attributes.version2.DemEduCollMajorTechnicalFlagEv := MAP(noDid or isMinor                     => -99999,
                                                                 le.DemEduCollFlagEv=0                  => -99998,
                                                                                                           le.DemEduCollMajorTechnicalFlagEv);
    self.attributes.version2.DemEduCollMajorBusFlagEv     := MAP(noDid or isMinor                       => -99999,
                                                                 le.DemEduCollFlagEv=0                  => -99998,
                                                                                                           le.DemEduCollMajorBusFlagEv);
    self.attributes.version2.DemEduCollMajorEduFlagEv     := MAP(noDid or isMinor                       => -99999,
                                                                 le.DemEduCollFlagEv=0                  => -99998,
                                                                                                           le.DemEduCollMajorEduFlagEv);
    self.attributes.version2.DemEduCollMajorLawFlagEv     := MAP(noDid or isMinor                       => -99999,
                                                                 le.DemEduCollFlagEv=0                  => -99998,
                                                                                                           le.DemEduCollMajorLawFlagEv);
    self.attributes.version2.DemBankingIndx               := MAP(noDid or isMinor                       => '-99999',le.DemBankingIndx);
    self.attributes.version2.PurchNewAmt                  := MAP(noDid or isMinor                       => -99999,
                                                                                                           le.PurchNewAmt);
    self.attributes.version2.PurchTotEv                   := MAP(noDid or isMinor                       => -99999,
                                                                                                           le.PurchTotEv);
    self.attributes.version2.PurchCntEv                   := MAP(noDid or isMinor                       => -99999,
                                                                                                           le.PurchCntEv);
    self.attributes.version2.PurchNewMsnc                 := MAP(noDid or isMinor                       => -99999,
                                                                                                           le.PurchNewMsnc);
    self.attributes.version2.PurchOldMsnc                 := MAP(noDid or isMinor                       => -99999,
                                                                                                           le.PurchOldMsnc);
    self.attributes.version2.PurchItemCntEv               := MAP(noDid or isMinor                       => -99999,
                                                                                                           le.PurchItemCntEv);
    self.attributes.version2.PurchAmtAvg                  := MAP(noDid or isMinor                       => -99999,
                                                                                                           le.PurchAmtAvg);
    self.attributes.version2.AstVehAutoCntEv              := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehAutoCntEv = -99999            => 0,
                                                                                                           le.AstVehAutoCntEv);
    self.attributes.version2.AstVehAutoCarCntEv           := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehAutoCarCntEv = -99999         => 0,
                                                                                                           le.AstVehAutoCarCntEv);
    self.attributes.version2.AstVehAutoSUVCntEv           := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehAutoSUVCntEv = -99999         => 0,
                                                                                                           le.AstVehAutoSUVCntEv);
    self.attributes.version2.AstVehAutoTruckCntEv         := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehAutoTruckCntEv = -99999       => 0,
                                                                                                           le.AstVehAutoTruckCntEv);
    self.attributes.version2.AstVehAutoVanCntEv           := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehAutoVanCntEv = -99999         => 0,
                                                                                                           le.AstVehAutoVanCntEv);
    self.attributes.version2.AstVehAutoNewTypeIndx        := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehAutoNewTypeIndx = -99999      => -99998,
                                                                 le.AstVehAutoCntEv = 0                 => -99998,
                                                                                                           le.AstVehAutoNewTypeIndx);
    self.attributes.version2.AstVehAutoExpCntEv           := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehAutoExpCntEv = -99999         => 0,
                                                                                                           le.AstVehAutoExpCntEv);
    self.attributes.version2.AstVehAutoEliteCntEv         := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehAutoEliteCntEv = -99999       => 0,
                                                                                                           le.AstVehAutoEliteCntEv);
    self.attributes.version2.AstVehAutoLuxuryCntEv        := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehAutoLuxuryCntEv = -99999      => 0,
                                                                                                           le.AstVehAutoLuxuryCntEv);
    self.attributes.version2.AstVehAutoOrigOwnCntEv       := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehAutoOrigOwnCntEv = -99999     => 0,
                                                                                                           le.AstVehAutoOrigOwnCntEv);
    self.attributes.version2.AstVehAutoMakeCntEv          := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehAutoMakeCntEv = -99999        => 0,
                                                                                                           le.AstVehAutoMakeCntEv);
    self.attributes.version2.AstVehAutoFreqMake           := MAP(noDid or isMinor                       => '-99999',
                                                                 le.AstVehAutoFreqMake=''               => '-99998',
                                                                 le.AstVehAutoFreqMake='-99999'         => '-99998',
                                                                                                           le.AstVehAutoFreqMake);
    self.attributes.version2.AstVehAutoFreqMakeCntEv      := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehAutoFreqMakeCntEv = -99999    => 0,
                                                                                                           le.AstVehAutoFreqMakeCntEv);
    self.attributes.version2.AstVehAuto2ndFreqMake        := MAP(noDid or isMinor                       => '-99999',
                                                                 le.AstVehAuto2ndFreqMake=''            => '-99998',
                                                                 le.AstVehAuto2ndFreqMake='-99999'      => '-99998',
                                                                                                           le.AstVehAuto2ndFreqMake);
    self.attributes.version2.AstVehAuto2ndFreqMakeCntEv   := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehAuto2ndFreqMakeCntEv = -99999 => 0,
                                                                                                           le.AstVehAuto2ndFreqMakeCntEv);
    self.attributes.version2.AstVehAutoEmrgPriceAvg       := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehAutoEmrgPriceAvg=-99999       => -99998,
                                                                 le.AstVehAutoCntEv=0                   => -99998,
                                                                 le.AstVehAutoEmrgPriceAvg=0            => -99997,
                                                                                                           le.AstVehAutoEmrgPriceAvg);
    self.attributes.version2.AstVehAutoEmrgPriceMax       := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehAutoEmrgPriceMax=-99999       => -99998,
                                                                 le.AstVehAutoCntEv=0                   => -99998,
                                                                 le.AstVehAutoEmrgPriceMax=0            => -99997,
                                                                                                           le.AstVehAutoEmrgPriceMax);
    self.attributes.version2.AstVehAutoEmrgPriceMin       := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehAutoEmrgPriceMin=-99999       => -99998,
                                                                 le.AstVehAutoCntEv=0                   => -99998,
                                                                 le.AstVehAutoEmrgPriceMin=0            => -99997,
                                                                                                           le.AstVehAutoEmrgPriceMin);
    self.attributes.version2.AstVehAutoNewPrice           := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehAutoNewPrice=-99999           => -99998,
                                                                 le.AstVehAutoCntEv=0                   => -99998,
                                                                 le.AstVehAutoNewPrice=0                => -99997,
                                                                                                           le.AstVehAutoNewPrice);
    self.attributes.version2.AstVehAutoEmrgPriceDiff      := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehAutoEmrgPriceDiff=-99999      => -99998,
                                                                 le.AstVehAutoCntEv=0                   => -99998,
                                                                                                           le.AstVehAutoEmrgPriceDiff);
    self.attributes.version2.AstVehAutoLastAgeAvg         := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehAutoLastAgeAvg=-99999         => -99998,
                                                                 le.AstVehAutoCntEv=0                   => -99998,
                                                                                                           le.AstVehAutoLastAgeAvg);
    self.attributes.version2.AstVehAutoLastAgeMax         := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehAutoLastAgeMax=-99999         => -99998,
                                                                 le.AstVehAutoCntEv=0                   => -99998,
                                                                                                           le.AstVehAutoLastAgeMax);
    self.attributes.version2.AstVehAutoLastAgeMin         := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehAutoLastAgeMin=-99999         => -99998,
                                                                 le.AstVehAutoCntEv=0                   => -99998,
                                                                                                           le.AstVehAutoLastAgeMin);
    self.attributes.version2.AstVehAutoEmrgAgeAvg         := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehAutoEmrgAgeAvg=-99999         => -99998,
                                                                 le.AstVehAutoCntEv=0                   => -99998,
                                                                                                           le.AstVehAutoEmrgAgeAvg);
    self.attributes.version2.AstVehAutoEmrgAgeMax         := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehAutoEmrgAgeMax=-99999         => -99998,
                                                                 le.AstVehAutoCntEv=0                   => -99998,
                                                                                                           le.AstVehAutoEmrgAgeMax);
    self.attributes.version2.AstVehAutoEmrgAgeMin         := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehAutoEmrgAgeMin=-99999         => -99998,
                                                                 le.AstVehAutoCntEv=0                   => -99998,
                                                                                                           le.AstVehAutoEmrgAgeMin);
    self.attributes.version2.AstVehAutoEmrgSpanAvg        := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehAutoEmrgSpanAvg=-99999        => -99998,
                                                                 le.AstVehAutoCntEv=0                   => -99998,
                                                                                                           le.AstVehAutoEmrgSpanAvg);
    self.attributes.version2.AstVehAutoNewMsnc            := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehAutoNewMsnc=-99999            => -99998,
                                                                 le.AstVehAutoCntEv=0                   => -99998,
                                                                                                           le.AstVehAutoNewMsnc);
    self.attributes.version2.AstVehAutoTimeOwnSpanAvg     := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehAutoTimeOwnSpanAvg=-99999     => -99998,
                                                                 le.AstVehAutoCntEv=0                   => -99998,
                                                                                                           le.AstVehAutoTimeOwnSpanAvg);
    self.attributes.version2.AstVehOtherCntEv             := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehOtherCntEv = -99999           => 0,
                                                                                                           le.AstVehOtherCntEv);
    self.attributes.version2.AstVehOtherATVCntEv          := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehOtherATVCntEv = -99999        => 0,
                                                                                                           le.AstVehOtherATVCntEv);
    self.attributes.version2.AstVehOtherCamperCntEv       := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehOtherCamperCntEv = -99999     => 0,
                                                                                                           le.AstVehOtherCamperCntEv);
    self.attributes.version2.AstVehOtherCommCntEv         := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehOtherCommCntEv = -99999       => 0,
                                                                                                           le.AstVehOtherCommCntEv);
    self.attributes.version2.AstVehOtherMtrCntEv          := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehOtherMtrCntEv = -99999        => 0,
                                                                                                           le.AstVehOtherMtrCntEv);
    self.attributes.version2.AstVehOtherScooterCntEv      := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehOtherScooterCntEv = -99999    => 0,
                                                                                                           le.AstVehOtherScooterCntEv);
    self.attributes.version2.AstVehOtherNewTypeIndx       := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehOtherNewTypeIndx = -99999     => -99998,
                                                                 le.AstVehOtherCntEv = 0                => -99998,
                                                                                                           le.AstVehOtherNewTypeIndx);
    self.attributes.version2.AstVehOtherOrigOwnCntEv      := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehOtherOrigOwnCntEv = -99999    => 0,
                                                                                                           le.AstVehOtherOrigOwnCntEv);
    self.attributes.version2.AstVehOtherNewMsnc           := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehOtherNewMsnc = -99999         => -99998,
                                                                 le.AstVehOtherCntEv = 0                => -99998,
                                                                                                           le.AstVehOtherNewMsnc);
    self.attributes.version2.AstVehOtherPriceAvg          := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehOtherPriceAvg = -99999        => -99998,
                                                                 le.AstVehOtherCntEv = 0                => -99998,
                                                                 le.AstVehOtherPriceAvg = 0             => -99997,
                                                                                                           le.AstVehOtherPriceAvg);
    self.attributes.version2.AstVehOtherPriceMax          := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehOtherPriceMax = -99999        => -99998,
                                                                 le.AstVehOtherCntEv = 0                => -99998,
                                                                 le.AstVehOtherPriceMax = 0             => -99997,
                                                                                                           le.AstVehOtherPriceMax);
    self.attributes.version2.AstVehOtherPriceMin          := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehOtherPriceMin = -99999        => -99998,
                                                                 le.AstVehOtherCntEv = 0                => -99998,
                                                                 le.AstVehOtherPriceMin = 0             => -99997,
                                                                                                           le.AstVehOtherPriceMin);
    self.attributes.version2.AstVehOtherNewPrice          := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstVehOtherNewPrice = -99999        => -99998,
                                                                 le.AstVehOtherCntEv = 0                => -99998,
                                                                 le.AstVehOtherNewPrice = 0             => -99997,
                                                                                                           le.AstVehOtherNewPrice);
    AstCurrFlag                                           := MAP(le.AstPropWtrcrftCntEv>0               => 1,//2.9%
                                                                 le.AstPropAircrftCntEv>0               => 1,//5 recs
                                                                 le.AstVehAutoCntEv>0                   => 1,//72 recs
                                                                 le.AstVehOtherCntEv>0                  => 1,//5 recs
                                                                 le.AstPropCurrFlag>0                   => 1,//46%
                                                                 // LifeAstPurchOldMsnc>0 //63%
                                                                 // LifeAstPurchNewMsnc>0 //63%
                                                                                                           le.AstCurrFlag);
    self.attributes.version2.AstCurrFlag                  := MAP(noDid or isMinor                       => -99999, 
                                                                                                           AstCurrFlag);
    self.attributes.version2.AstPropCurrFlag              := IF(noDid or isMinor, -99999, le.AstPropCurrFlag);
    self.attributes.version2.AstPropCurrCntEv             := IF(noDid or isMinor, -99999, MIN(le.AstPropCurrCntEv,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.AstPropCurrValTot            := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstPropCurrValTot > 0               => MIN(le.AstPropCurrValTot,ProfileBooster.V2_Constants.Max9999999),
                                                                 le.AstPropCurrFlag = 1                 => -99997,
                                                                 le.PPCurrOwner <> 1                    => -99998,
                                                                                                           -99997);                                                                                            
    self.attributes.version2.AstPropCurrAVMTot            := MAP(noDid or isMinor                       => -99999,
                                                                 le.AstPropCurrAVMTot > 0               => MIN(le.AstPropCurrAVMTot,ProfileBooster.V2_Constants.Max9999999),
                                                                 le.AstPropCurrFlag = 1                 => -99997,
                                                                 le.PPCurrOwner <> 1                    => -99998,
                                                                                                           -99997);
    self.attributes.version2.AstPropSaleNewMsnc           := MAP(noDid or isMinor                       => -99999, 
                                                                 le.AstPropSaleNewMsnc >=0 AND le.AstPropCntEv > 0 => MIN(le.AstPropSaleNewMsnc,ProfileBooster.V2_Constants.Max960),
                                                                 le.AstPropCntEv <= 0                   => -99998,
                                                                                                          -99997);
    self.attributes.version2.AstPropCntEv                 := MAP(noDid or isMinor                       => -99999, 
                                                                 le.AstPropSoldCnt1Y>0                  => MIN(max(le.AstPropSoldCnt1Y,le.AstPropCntEv),ProfileBooster.V2_Constants.Max255),                                                               
                                                                 le.AstPropCntEv>0                      => MIN(le.AstPropCntEv,ProfileBooster.V2_Constants.Max255),
                                                                 le.AstPropSoldCntEv>0                  => MIN(le.AstPropSoldCntEv,ProfileBooster.V2_Constants.Max255),
                                                                                                           0);
    self.attributes.version2.AstPropSoldCntEv             := MAP(noDid or isMinor                       => -99999, 
                                                                                                           MIN(le.AstPropSoldCntEv,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.AstPropSoldCnt1Y             := MAP(noDid or isMinor                       => -99999,
                                                                                                           MIN(le.AstPropSoldCnt1Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.AstPropSoldNewRatio          := MAP(noDid or isMinor                       => '-99999', 
                                                                 le.AstPropCntEv <= 0                   => '-99998',
                                                                 le.AstPropSoldNewRatio = ''            => '-99997',                                                                 
                                                                 le.AstPropSoldNewRatio = '0'           => '-99997',
                                                                                                           le.AstPropSoldNewRatio);
    self.attributes.version2.AstPropAirCrftCntEv          := IF(noDid or isMinor, -99999, MIN(le.AstPropAirCrftCntEv,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.AstPropWtrcrftCntEv          := IF(noDid or isMinor, -99999, MIN(le.AstPropWtrcrftCntEv,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.AstPropPurchCnt1Y            := IF(noDid or isMinor, -99999, MIN(le.AstPropPurchCnt1Y,ProfileBooster.V2_Constants.Max255));
    NoAddressHistoryOnFile                                := le.LifeMoveNewMsnc < 0;
    LifeMoveNewMsnc                                       := MAP(noDid or isMinor                       => -99999,
                                                                 NoAddressHistoryOnFile                 => -99998,
                                                                 le.LifeMoveNewMsnc IN [nines,-99997]   => -99997,
                                                                 le.LifeMoveNewMsnc >= 0                => MIN(le.LifeMoveNewMsnc,ProfileBooster.V2_Constants.Max960),
                                                                                                          -99997);
    self.attributes.version2.LifeMoveNewMsnc              := LifeMoveNewMsnc;
    self.attributes.version2.LifeNameLastChngFlag         := MAP(noDid or isMinor                       => -99999, 
                                                                                                           le.LifeNameLastChngFlag);
    self.attributes.version2.LifeNameLastChngFlag1Y       := MAP(noDid or isMinor                       => -99999,
                                                                 le.LifeNameLastChngFlag1Y>=0           => le.LifeNameLastChngFlag1Y,
                                                                                                           -99997);
    self.attributes.version2.LifeNameLastCntEv            := MAP(noDid or isMinor                       => -99999, 
                                                                                                           MIN(le.LifeNameLastCntEv,ProfileBooster.V2_Constants.Max99));
    maxNameLastChangeMnthsMax                             := MAP((integer4)le.DemAge>0                  => MIN((integer4)le.DemAge*12,ProfileBooster.V2_Constants.Max960),
                                                                                                           ProfileBooster.V2_Constants.Max960);                                                                                       
    self.attributes.version2.LifeNameLastChngNewMsnc      := MAP(noDid or isMinor                       => -99999, 
                                                                 le.LifeNameLastCntEv=0 or le.LifeNameLastCntEv=-99998 => -99998,
                                                                 le.LifeNameLastChngNewMsnc>=0           => MIN(le.LifeNameLastChngNewMsnc,maxNameLastChangeMnthsMax),
                                                                                                            -99997);
    notOwner                                              := le.AstPropCntEv = 0 and le.PPCurrOwnedCnt = 0;
    noAssets                                              := AstCurrFlag <> 1;
    LifeAstPurchOldMsnc                                   := le.LifeAstPurchOldMsnc;
    LifeAstPurchNewMsnc                                   := le.LifeAstPurchNewMsnc;
    self.attributes.version2.LifeAstPurchOldMsnc          := MAP(noDid or isMinor                        => -99999,
                                                                 notOwner and LifeAstPurchOldMsnc = 0 AND AstCurrFlag=0 => -99998,
                                                                 noAssets OR AstCurrFlag=0               => -99998,
                                                                 LifeAstPurchOldMsnc = 0 and LifeAstPurchNewMsnc IN [-99998,99998] AND AstCurrFlag=0 => -99998,
                                                                 LifeAstPurchNewMsnc>=0 and ~noAssets AND AstCurrFlag=1 => MIN(LifeAstPurchOldMsnc,ProfileBooster.V2_Constants.Max960),
                                                                                                            -99997);
    self.attributes.version2.LifeAstPurchNewMsnc          := MAP(noDid or isMinor                        => -99999,
                                                                 notOwner and LifeAstPurchNewMsnc IN [0,99998] AND AstCurrFlag=0 => -99998,
                                                                 noAssets OR AstCurrFlag=0               => -99998,
                                                                 LifeAstPurchOldMsnc = 0 and LifeAstPurchNewMsnc IN [-99998,99998] AND AstCurrFlag=0 => -99998,
                                                                 LifeAstPurchNewMsnc>=0 and ~noAssets AND AstCurrFlag=1 => MIN(LifeAstPurchNewMsnc,ProfileBooster.V2_Constants.Max960),
                                                                                                            -99997);
    self.attributes.version2.LifeAddrCnt                  := MAP(noDid or isMinor                        => -99999, 
                                                                                                            MIN(le.LifeAddrCnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.LifeAddrCurrToPrevValRatio5Y := MAP(noDid or isMinor                        => '-99999',
                                                                 NoAddressHistoryOnFile or LifeMoveNewMsnc > 60 or le.curr_AssessedAmount = 0 or le.prev_AssessedAmount = 0  => '-99998',
                                                                 le.prev_AssessedAmount > 0              => trim((STRING6)(decimal4_2)MIN(le.curr_AssessedAmount / le.prev_AssessedAmount, 99.0)),
                                                                                                           '-99997');
    self.attributes.version2.LifeAddrEconTrajType         := MAP(noDid or isMinor                        => -99999,
                                                                 NoAddressHistoryOnFile                  => -99998,
                                                                 LifeMoveNewMsnc <= 0                    => -99997, //if we couldn't determine last move, set to -99997
                                                                 le.LifeAddrEconTrajType = 0             => -99997, 
                                                                                                            le.LifeAddrEconTrajType);
    self.attributes.version2.LifeAddrEconTrajIndx         := MAP(noDid or isMinor                        => -99999, 
                                                                 NoAddressHistoryOnFile                  => -99998,
                                                                 LifeMoveNewMsnc <= 0                    => -99997, //if we couldn't determine last move, set to -99997
                                                                 le.LifeAddrEconTrajIndx = 0             => -99997, 
                                                                                                            le.LifeAddrEconTrajIndx);
    CurrAddrOwnershipIndx                                 := MAP(noDid or isMinor                        => -99999,
                                                                 le.curr_addr_type = 'P'                 => -99998, //if curr addr is PO Box, set ownership index to '0'
                                                                 NOT le.CurrAddrOwnershipIndx IN [1,2,3,4] => -99998,
                                                                                                            le.CurrAddrOwnershipIndx);
    self.attributes.version2.CurrAddrOwnershipIndx        := CurrAddrOwnershipIndx;
    self.attributes.version2.CurrAddrHasPoolFlag          := MAP(noDid or isMinor                        => -99999, 
                                                                 CurrAddrOwnershipIndx = -99998          => -99998,
                                                                 NOT le.CurrAddrHasPoolFlag IN [0,1]     => -99998,
                                                                 NOT le.CurrAddrHasPoolFlag >= 0         => -99998,
                                                                                                        le.CurrAddrHasPoolFlag);
    self.attributes.version2.CurrAddrIsMobileHomeFlag     := MAP(noDid or isMinor                        => -99999, 
                                                                 CurrAddrOwnershipIndx = -99998          => -99998, 
                                                                 NOT le.CurrAddrIsMobileHomeFlag IN [0,1] => -99998,
                                                                 NOT le.CurrAddrIsMobileHomeFlag >= 0    => -99998,
                                                                                                            le.CurrAddrIsMobileHomeFlag);
    self.attributes.version2.CurrAddrBathCnt              := MAP(noDid or isMinor                        => -99999, 
                                                                 CurrAddrOwnershipIndx = -99998          => -99998, 
                                                                 le.CurrAddrBathCnt < 0                  => -99998,
                                                                 le.CurrAddrBathCnt = 0                  => -99997,
                                                                                                            MIN(le.CurrAddrBathCnt,99));
    self.attributes.version2.CurrAddrParkingCnt           := MAP(noDid or isMinor                        => -99999, 
                                                                 CurrAddrOwnershipIndx = -99998          => -99998, 
                                                                 le.CurrAddrParkingCnt < 0               => -99998,
                                                                 le.CurrAddrParkingCnt = 0               => -99997,
                                                                                                            MIN(le.CurrAddrParkingCnt,99));
    self.attributes.version2.CurrAddrBuildYr              := MAP(noDid or isMinor                        => -99999,  
                                                                 CurrAddrOwnershipIndx = -99998          => -99998,
                                                                 le.CurrAddrBuildYr = 0                  => -99997,
                                                                 NOT le.CurrAddrBuildYr BETWEEN 1800 AND 9999 => -99998,
                                                                                                            MIN(le.CurrAddrBuildYr,ProfileBooster.V2_Constants.Max9999));
    self.attributes.version2.CurrAddrBedCnt               := MAP(noDid or isMinor                        => -99999, 
                                                                 CurrAddrOwnershipIndx = -99998          => -99998, 
                                                                 le.CurrAddrBedCnt < 0                   => -99998,
                                                                 le.CurrAddrBedCnt = 0                   => -99997,
                                                                                                            MIN(le.CurrAddrBedCnt,99));
    self.attributes.version2.CurrAddrBldgSize             := MAP(noDid or isMinor                        => -99999,  
                                                                 CurrAddrOwnershipIndx = -99998          => -99998,
                                                                 le.CurrAddrBldgSize < 0                 => -99998,
                                                                 le.CurrAddrBldgSize = 0                 => -99997,
                                                                                                            MIN(le.CurrAddrBldgSize,99999));
    self.attributes.version2.CurrAddrLat                  := MAP(noDid or isMinor                        => '-99999', 
                                                                 le.CurrAddrLat = ''                     => '-99998',
                                                                                                            le.CurrAddrLat);
    self.attributes.version2.CurrAddrLng                  := MAP(noDid or isMinor                        => '-99999', 
                                                                 le.CurrAddrLng = ''                     => '-99998',
                                                                                                            le.CurrAddrLng);
    self.attributes.version2.CurrAddrIsCollegeFlag        := MAP(noDid or isMinor                        => -99999, 
                                                                 le.CurrAddrIsCollegeFlag NOT IN [1,0,-99998] => -99997,                                                                 
                                                                                                            le.CurrAddrIsCollegeFlag);
    CurrAddrAVMVal                                        := MAP(noDid or isMinor                        => -99999, 
                                                                 le.CurrAddrAVMVal<=0                    => -99997,
                                                                                                            MIN(le.CurrAddrAVMVal,ProfileBooster.V2_Constants.Max9999999));
    self.attributes.version2.CurrAddrAVMVal               := CurrAddrAVMVal;
    CurrAddrAVMValA1Y                                     := MAP(noDid or isMinor                        => -99999, 
                                                                 le.CurrAddrAVMValA1Y <= 0               => -99997,
                                                                                                            MIN(le.CurrAddrAVMValA1Y,ProfileBooster.V2_Constants.Max9999999));    self.attributes.version2.CurrAddrAVMValA1Y             := CurrAddrAVMValA1Y;
    CurrAddrAVMRatio1Y                                    := MAP(noDid or isMinor                        => '-99999', 
                                                                 CurrAddrAVMVal<=0                       => '-99997',
                                                                 CurrAddrAVMValA1Y <= 0                  => '-99997',
                                                                 le.CurrAddrAVMRatio1Y IN ['','0'] AND ~(CurrAddrAVMVal>0 AND CurrAddrAVMValA1Y>0) => '-99997',                                                                 

                                                                                                            le.CurrAddrAVMRatio1Y);    
    self.attributes.version2.CurrAddrAVMRatio1Y           := CurrAddrAVMRatio1Y;
    self.attributes.version2.CurrAddrAVMValA5Y            := MAP(noDid or isMinor                        => -99999, 
                                                                 le.CurrAddrAVMValA5Y <= 0               => -99997,
                                                                                                            MIN(le.CurrAddrAVMValA5Y,ProfileBooster.V2_Constants.Max9999999));
    CurrAddrAVMRatio5Y                                    := MAP(noDid or isMinor                        => '-99999', 
                                                                 le.CurrAddrAVMVal<=0                    => '-99997',
                                                                 le.CurrAddrAVMValA5Y <= 0               => '-99997',
                                                                 le.CurrAddrAVMRatio5Y IN ['','0'] AND ~(le.CurrAddrAVMVal>0 AND le.CurrAddrAVMValA5Y>0) => '-99997',                                                                 
                                                                                                            le.CurrAddrAVMRatio5Y);
    self.attributes.version2.CurrAddrAVMRatio5Y           := CurrAddrAVMRatio5Y;
    self.attributes.version2.CurrAddrMedAVMCtyRatio       := MAP(noDid or isMinor                        => '-99999', 
                                                                 le.CurrAddrAVMVal<=0                    => '-99997',
                                                                 le.CurrAddrMedAVMCtyRatio IN ['','0']   => '-99997',  
                                                                                                            le.CurrAddrMedAVMCtyRatio);
    self.attributes.version2.CurrAddrMedAVMCenTractRatio  := MAP(noDid or isMinor                        => '-99999', 
                                                                 le.CurrAddrAVMVal<=0                    => '-99997',
                                                                 le.CurrAddrMedAVMCenTractRatio IN ['','0'] => '-99997',
                                                                                                            le.CurrAddrMedAVMCenTractRatio);
    self.attributes.version2.CurrAddrMedAVMCenBlockRatio  := MAP(noDid or isMinor                        => '-99999', 
                                                                 le.CurrAddrAVMVal<=0                    => '-99997',
                                                                 le.CurrAddrMedAVMCenBlockRatio IN ['','0'] => '-99997',
                                                                                                            le.CurrAddrMedAVMCenBlockRatio);
    self.attributes.version2.CurrAddrType                 := MAP(noDid or isMinor                        => '-99999', 
                                                                 (string)TRIM(le.Curr_Addr_Type) in ['S','H','P','F','G','R','U'] => (STRING)le.Curr_Addr_Type, 
                                                                                                            '-99998');
    CurrAddrTypeIndx := MAP((string)TRIM(le.Curr_Addr_Type) in ['S','G','R']  => 3,
                            (string)TRIM(le.Curr_Addr_Type) in ['P']          => 2,
                            (string)TRIM(le.Curr_Addr_Type) in ['H','F']      => 1,
                            le.CurrAddrTypeIndx<>0                            => le.CurrAddrTypeIndx,
                                                                                 0);                                                                                                            
    self.attributes.version2.CurrAddrTypeIndx             := MAP(noDid or isMinor                        => -99999, 
                                                                 CurrAddrTypeIndx IN [1,2,3]             => CurrAddrTypeIndx,
                                                                                                            -99998);
    self.attributes.version2.CurrAddrBusRegCnt            := MAP(noDid or isMinor                        => -99999, 
                                                                                                            MIN(le.CurrAddrBusRegCnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.CurrAddrIsVacantFlag         := MAP(noDid or isMinor                        => -99999, 
                                                                   le.CurrAddrIsVacantFlag NOT IN [1,0,-99998] => -99997,
                                                                                                            le.CurrAddrIsVacantFlag);
    self.attributes.version2.CurrAddrStatus               := MAP(noDid or isMinor                        => -99999, 
                                                                   CurrAddrOwnershipIndx = 4             => 1,                                                                   
                                                                   CurrAddrOwnershipIndx IN [1,2,3]      => 0,                                                                   
                                                                                                            -99998);
    self.attributes.version2.CurrAddrIsAptFlag            := MAP(noDid or isMinor                        => -99999, 
                                                                   le.CurrAddrIsAptFlag NOT IN [1,0,-99997] => -99998,
                                                                                                            le.CurrAddrIsAptFlag);
    InpAddrOwnershipIndx                                  := MAP(noDid or isMinor                        => -99999,
                                                                 le.addr_type = 'P'                      => -99998, //if Inp addr is PO Box, set ownership index to '0'
                                                                 NOT le.InpAddrOwnershipIndx IN [1,2,3,4] => -99998,
                                                                                                             le.InpAddrOwnershipIndx);
    self.attributes.version2.InpAddrOwnershipIndx         := InpAddrOwnershipIndx;
    self.attributes.version2.InpAddrHasPoolFlag           := MAP(noDid or isMinor                        => -99999, 
                                                                 InpAddrOwnershipIndx = -99998           => -99998,
                                                                 NOT le.InpAddrHasPoolFlag IN [0,1]      => -99998,
                                                                 NOT le.InpAddrHasPoolFlag >= 0          => -99998,
                                                                                                            le.InpAddrHasPoolFlag);
    self.attributes.version2.InpAddrIsMobileHomeFlag      := MAP(noDid or isMinor                        => -99999, 
                                                                 InpAddrOwnershipIndx = -99998           => -99998, 
                                                                 NOT le.InpAddrIsMobileHomeFlag IN [0,1] => -99998,
                                                                 NOT le.InpAddrIsMobileHomeFlag >= 0     => -99998,
                                                                                                            le.InpAddrIsMobileHomeFlag);
    self.attributes.version2.InpAddrBathCnt               := MAP(noDid or isMinor                        => -99999, 
                                                                 InpAddrOwnershipIndx = -99998           => -99998, 
                                                                 le.InpAddrBathCnt < 0                   => -99998,
                                                                 le.InpAddrBathCnt = 0                   => -99997,
                                                                                                            MIN(le.InpAddrBathCnt,99));
    self.attributes.version2.InpAddrParkingCnt            := MAP(noDid or isMinor                        => -99999, 
                                                                 InpAddrOwnershipIndx = -99998           => -99998, 
                                                                 le.InpAddrParkingCnt < 0                => -99998,
                                                                 le.InpAddrParkingCnt = 0                => -99997,
                                                                                                            MIN(le.InpAddrParkingCnt,99));
    self.attributes.version2.InpAddrBuildYr               := MAP(noDid or isMinor                        => -99999,  
                                                                 InpAddrOwnershipIndx = -99998           => -99998,
                                                                 le.InpAddrBuildYr = 0                   => -99997,
                                                                 NOT le.InpAddrBuildYr BETWEEN 1800 AND 9999 => -99998,
                                                                                                            MIN(le.InpAddrBuildYr,ProfileBooster.V2_Constants.Max9999));
    self.attributes.version2.InpAddrBedCnt                := MAP(noDid or isMinor                        => -99999, 
                                                                 InpAddrOwnershipIndx = -99998           => -99998, 
                                                                 le.InpAddrBedCnt < 0                    => -99998,
                                                                 le.InpAddrBedCnt = 0                    => -99997,
                                                                                                            MIN(le.InpAddrBedCnt,99));
    self.attributes.version2.InpAddrBldgSize              := MAP(noDid or isMinor                        => -99999,  
                                                                 InpAddrOwnershipIndx = -99998           => -99998,
                                                                 le.InpAddrBldgSize < 0                  => -99998,
                                                                 le.InpAddrBldgSize = 0                  => -99997,
                                                                                                            MIN(le.InpAddrBldgSize,99999));
    self.attributes.version2.InpAddrLat                   := MAP(noDid or isMinor                        => '-99999', 
                                                                 le.InpAddrLat = ''                      => '-99998',
                                                                                                            le.InpAddrLat);
    self.attributes.version2.InpAddrLng                   := MAP(noDid or isMinor                        => '-99999', 
                                                                 le.InpAddrLng = ''                      => '-99998',
                                                                                                            le.InpAddrLng);
    self.attributes.version2.InpAddrIsCollegeFlag         := MAP(noDid or isMinor                        => -99999, 
                                                                 le.InpAddrIsCollegeFlag NOT IN [1,0,-99998] => -99997,                                                                 
                                                                                                            le.InpAddrIsCollegeFlag);
    InpAddrAVMVal                                         := MAP(noDid or isMinor                        => -99999, 
                                                                 le.InpAddrAVMVal<=0                     => -99997,
                                                                                                            MIN(le.InpAddrAVMVal,ProfileBooster.V2_Constants.Max9999999));
    self.attributes.version2.InpAddrAVMVal                := InpAddrAVMVal;
    InpAddrAVMValA1Y                                      := MAP(noDid or isMinor                        => -99999, 
                                                                 le.InpAddrAVMValA1Y <= 0                => -99997,
                                                                                                            MIN(le.InpAddrAVMValA1Y,ProfileBooster.V2_Constants.Max9999999));    self.attributes.version2.InpAddrAVMValA1Y             := InpAddrAVMValA1Y;
    InpAddrAVMRatio1Y                                     := MAP(noDid or isMinor                        => '-99999', 
                                                                 InpAddrAVMVal<=0                        => '-99997',
                                                                 InpAddrAVMValA1Y <= 0                   => '-99997',
                                                                 le.InpAddrAVMRatio1Y IN ['','0'] AND ~(InpAddrAVMVal>0 AND InpAddrAVMValA1Y>0) => '-99997',                                                                 
                                                                                                            le.InpAddrAVMRatio1Y);    
    self.attributes.version2.InpAddrAVMRatio1Y            := InpAddrAVMRatio1Y;
    self.attributes.version2.InpAddrAVMValA5Y             := MAP(noDid or isMinor                        => -99999, 
                                                                 le.InpAddrAVMValA5Y <= 0                => -99997,
                                                                                                            MIN(le.InpAddrAVMValA5Y,ProfileBooster.V2_Constants.Max9999999));
    InpAddrAVMRatio5Y                                     := MAP(noDid or isMinor                        => '-99999', 
                                                                 le.InpAddrAVMVal<=0                     => '-99997',
                                                                 le.InpAddrAVMValA5Y <= 0                => '-99997',
                                                                 le.InpAddrAVMRatio5Y IN ['','0'] AND ~(le.InpAddrAVMVal>0 AND le.InpAddrAVMValA5Y>0) => '-99997',                                                                 
                                                                                                            le.InpAddrAVMRatio5Y);
    self.attributes.version2.InpAddrAVMRatio5Y            := InpAddrAVMRatio5Y;
    self.attributes.version2.InpAddrMedAVMCtyRatio        := MAP(noDid or isMinor                        => '-99999', 
                                                                 le.InpAddrAVMVal<=0                     => '-99997',
                                                                 le.InpAddrMedAVMCtyRatio IN ['','0']    => '-99997',  
                                                                                                            le.InpAddrMedAVMCtyRatio);
    self.attributes.version2.InpAddrMedAVMCenTractRatio   := MAP(noDid or isMinor                        => '-99999', 
                                                                 le.InpAddrAVMVal<=0                     => '-99997',
                                                                 le.InpAddrMedAVMCenTractRatio IN ['','0'] => '-99997',
                                                                                                            le.InpAddrMedAVMCenTractRatio);
    self.attributes.version2.InpAddrMedAVMCenBlockRatio   := MAP(noDid or isMinor                        => '-99999', 
                                                                 le.InpAddrAVMVal<=0                     => '-99997',
                                                                 le.InpAddrMedAVMCenBlockRatio IN ['','0'] => '-99997',
                                                                                                            le.InpAddrMedAVMCenBlockRatio);
    self.attributes.version2.InpAddrType                  := MAP(noDid or isMinor                        => '-99999', 
                                                                 (string)TRIM(le.Addr_Type) in ['S','H','P','F','G','R','U'] => (STRING)le.Addr_Type, 
                                                                                                            '-99998');
    InpAddrTypeIndex := MAP((string)TRIM(le.Addr_Type) in ['S','G','R']  => 3,
                            (string)TRIM(le.Addr_Type) in ['P']          => 2,
                            (string)TRIM(le.Addr_Type) in ['H','F']      => 1,
                                                                           0);                                                                                                            
    self.attributes.version2.InpAddrTypeIndex             := MAP(noDid or isMinor                        => -99999, 
                                                                  InpAddrTypeIndex IN [1,2,3]            => InpAddrTypeIndex,
                                                                                                            -99998);
    self.attributes.version2.InpAddrBusRegCnt             := MAP(noDid or isMinor                        => -99999, 
                                                                                                            MIN(le.InpAddrBusRegCnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.InpAddrIsVacantFlag          := MAP(noDid or isMinor                        => -99999, 
                                                                   le.InpAddrIsVacantFlag NOT IN [1,0,-99998] => -99997,
                                                                                                            le.InpAddrIsVacantFlag);
    self.attributes.version2.InpAddrIsAptFlag             := MAP(noDid or isMinor                        => -99999, 
                                                                   le.InpAddrIsAptFlag NOT IN [1,0,-99997] => -99998,
                                                                                                            le.InpAddrIsAptFlag);                                                                                                            
    DrgCnt7Y                                              := IF(noDid or isMinor, -99999, MIN(le.DrgCnt7Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.DrgCnt7Y                     := DrgCnt7Y;
    self.attributes.version2.DrgSeverityIndx7Y            := MAP(noDid or isMinor                        => -99999, 
                                                                   le.DrgCnt7Y = 0                       => -99998,
                                                                   le.DrgSeverityIndx7Y < 0              => -99997,
                                                                                                            MIN(le.DrgSeverityIndx7Y,ProfileBooster.V2_Constants.Max5));
    DrgCnt1Y                                              := IF(noDid or isMinor, -99999, MIN(le.DrgCnt1Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.DrgCnt1Y                     := DrgCnt1Y;
    DrgNewMsnc7Y                                          := MAP(noDid or isMinor                        => -99999, 
                                                                   le.DrgCnt7Y = 0                       => -99998,
                                                                   le.DrgNewMsnc7Y < 0                   => -99997,
                                                                                                            MIN(le.DrgNewMsnc7Y,ProfileBooster.V2_Constants.Max960));
    self.attributes.version2.DrgNewMsnc7Y                 := DrgNewMsnc7Y;                                                                                                            
    DrgCrimFelCnt7Y                                       := IF(noDid or isMinor, -99999, MIN(le.DrgCrimFelCnt7Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.DrgCrimFelCnt7Y              := DrgCrimFelCnt7Y;
    DrgCrimFelCnt1Y                                       := IF(noDid or isMinor, -99999, MIN(le.DrgCrimFelCnt1Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.DrgCrimFelCnt1Y              := DrgCrimFelCnt1Y;
    DrgCrimFelNewMsnc7Y                                   := MAP(noDid or isMinor                        => -99999, 
                                                                   le.DrgCrimFelCnt7Y=0                  => -99998,                                                                   
                                                                                                            MIN(le.DrgCrimFelNewMsnc7Y,ProfileBooster.V2_Constants.Max960));
    self.attributes.version2.DrgCrimFelNewMsnc7Y          := DrgCrimFelNewMsnc7Y;                                                                                                  
    DrgCrimNFelCnt7Y                                      := IF(noDid or isMinor, -99999, MIN(le.DrgCrimNFelCnt7Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.DrgCrimNFelCnt7Y             := DrgCrimNFelCnt7Y;
    DrgCrimNFelCnt1Y                                      := IF(noDid or isMinor, -99999, MIN(le.DrgCrimNFelCnt1Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.DrgCrimNFelCnt1Y             := DrgCrimNFelCnt1Y;
    DrgCrimNFelNewMsnc7Y                                  := MAP(noDid or isMinor                        => -99999, 
                                                                   le.DrgCrimNFelCnt7Y=0                 => -99998,
                                                                   le.DrgCrimNFelNewMsnc7Y < 0           => -99997,
                                                                                                            MIN(le.DrgCrimNFelNewMsnc7Y,ProfileBooster.V2_Constants.Max960));
    self.attributes.version2.DrgCrimNFelNewMsnc7Y         := DrgCrimNFelNewMsnc7Y;                                                                                                           
    DrgEvictCnt7Y                                         := IF(noDid or isMinor, -99999, MIN(le.DrgEvictCnt7Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.DrgEvictCnt7Y                := DrgEvictCnt7Y;
    DrgEvictCnt1Y                                         := IF(noDid or isMinor, -99999, MIN(le.DrgEvictCnt1Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.DrgEvictCnt1Y                := DrgEvictCnt1Y;
    DrgEvictNewMsnc7Y                                     := MAP(noDid or isMinor                        => -99999, 
                                                                   le.DrgEvictCnt7Y=0                    => -99998,
                                                                   le.DrgEvictNewMsnc7Y < 0              => -99997,
                                                                                                            MIN(le.DrgEvictNewMsnc7Y,ProfileBooster.V2_Constants.Max960));
    self.attributes.version2.DrgEvictNewMsnc7Y            := DrgEvictNewMsnc7Y;
    DrgLnJCnt7Y                                           := IF(noDid or isMinor, -99999, MIN(le.DrgLnJCnt7Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.DrgLnJCnt7Y                  := DrgLnJCnt7Y;
    DrgLnJCnt1Y                                           := IF(noDid or isMinor, -99999, MIN(le.DrgLnJCnt1Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.DrgLnJCnt1Y                  := DrgLnJCnt1Y;
    DrgLnJNewMsnc7Y                                       := MAP(noDid or isMinor                        => -99999, 
                                                                   le.DrgLnJCnt7Y=0                      => -99998,
                                                                   le.DrgLnJNewMsnc7Y < 0                => -99997,
                                                                                                            MIN(le.DrgLnJNewMsnc7Y,ProfileBooster.V2_Constants.Max960));
    self.attributes.version2.DrgLnJNewMsnc7Y              := DrgLnJNewMsnc7Y;
    DrgLnJAmtTot7Y                                        := MAP(noDid or isMinor                        => -99999, 
                                                                   le.DrgLnJCnt7Y=0                      => -99998,
                                                                   le.DrgLnJAmtTot7Y <= 0                => -99997,
                                                                                                            MIN(le.DrgLnJAmtTot7Y, ProfileBooster.V2_Constants.Max9999999));
    self.attributes.version2.DrgLnJAmtTot7Y               := DrgLnJAmtTot7Y;                                                                                                            
    DrgBkCnt10Y                                           := IF(noDid or isMinor, -99999, MIN(le.DrgBkCnt10Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.DrgBkCnt10Y                  := DrgBkCnt10Y;
    DrgBkCnt1Y                                            := IF(noDid or isMinor, -99999, MIN(le.DrgBkCnt1Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.DrgBkCnt1Y                   := DrgBkCnt1Y;
    DrgBkNewMsnc10Y                                       := MAP(noDid or isMinor                        => -99999, 
                                                                   le.DrgBkCnt10Y=0                      => -99998,
                                                                   le.DrgBkNewMsnc10Y < 0                => -99997,
                                                                                                            MIN(le.DrgBkNewMsnc10Y,ProfileBooster.V2_Constants.Max960));
    self.attributes.version2.DrgBkNewMsnc10Y              := DrgBkNewMsnc10Y;                                                                                                           
    self.attributes.version2.ProfLicFlagEv                := IF(noDid or isMinor, -99999, le.ProfLicFlagEv);
    ProfLicActivNewIndx                                   := MAP(noDid or isMinor                        => -99999,
                                                                   le.ProfLicFlagEv = 0                  => -99998, 
                                                                   le.ProfLicActivNewIndx = 0            => -99997,
                                                                   MIN(le.ProfLicActivNewIndx, ProfileBooster.V2_Constants.Max5));
    self.attributes.version2.ProfLicActivNewIndx          := ProfLicActivNewIndx;
    self.attributes.version2.BusAssocFlagEv               := IF(noDid or isMinor, -99999, le.BusAssocFlagEv);
    self.attributes.version2.BusAssocOldMSnc              := MAP(noDid or isMinor                        => -99999, 
                                                                   le.busassocflagev = 0                 => -99998,
                                                                                                            MIN(le.BusAssocOldMSnc,ProfileBooster.V2_Constants.Max960));
    self.attributes.version2.BusLeadershipTitleFlag       := MAP(noDid or isMinor                        => -99999, 
                                                                   le.busassocflagev = 0                 => -99998,
                                                                                                            le.BusLeadershipTitleFlag);
    self.attributes.version2.BusAssocCntEv                := IF(noDid or isMinor, -99999, MIN(le.BusAssocCntEv,99));
    // self.attributes.version2.BusAssocSmBusFlag              := IF(noDid or isMinor, -99999, le.BusAssocSmBusFlag);
    self.attributes.version2.ProfLicActvNewTitleType      := MAP(noDid or isMinor                        => '-99999', 
                                                                   le.ProfLicFlagEv = 0                  => '-99998',
                                                                   ProfLicActivNewIndx = -99997          => '-99997',
                                                                   ProfLicActivNewIndx = -99998          => '-99998',
                                                                   le.ProfLicActvNewTitleType = ''       => '-99998',
                                                                                                            le.ProfLicActvNewTitleType);
    self.attributes.version2.BusUCCFilingCntEv            := IF(noDid or isMinor, -99999, MIN(le.BusUCCFilingCntEv,ProfileBooster.V2_Constants.Max999));
    self.attributes.version2.BusUCCFilingActiveCnt        := IF(noDid or isMinor, -99999, MIN(le.BusUCCFilingActiveCnt,ProfileBooster.V2_Constants.Max999));

    self.attributes.version2.IntSportPersonFlagEv         := IF(noDid or isMinor, -99999, le.IntSportPersonFlagEv);  
    self.attributes.version2.IntSportPersonFlag1Y         := IF(noDid or isMinor, -99999, le.IntSportPersonFlag1Y);  
    self.attributes.version2.IntSportPersonFlag5Y         := IF(noDid or isMinor, -99999, le.IntSportPersonFlag5Y);  
    self.attributes.version2.IntSportPersonTravelerFlagEv := IF(noDid or isMinor, -99999, le.IntSportPersonTravelerFlagEv);  
    
    EmrgAge                                               := MAP(noDid or isMinor                        => -99999, 
                                                                le.EmrgRecordType = '' or le.EmrgAge < 0 => -99998,
                                                                le.EmrgAge BETWEEN 0 AND 17              => 0,
                                                                                                            MIN(le.EmrgAge,ProfileBooster.V2_Constants.Max99));  
    self.attributes.version2.EmrgAge                      := EmrgAge;
    self.attributes.version2.EmrgAtOrAfter21Flag          := MAP(noDid or isMinor                        => -99999, 
                                                                   EmrgAge = -99998                      => -99998,
                                                                                                            le.EmrgAtOrAfter21Flag);  
    self.attributes.version2.EmrgRecordType               := MAP(noDid or isMinor                        => '-99999', 
                                                                   le.EmrgRecordType NOT IN ['A','P','D','B','E','S','O'] => '-99998',
                                                                                                            le.EmrgRecordType);  
    self.attributes.version2.EmrgAddrType                 := MAP(noDid or isMinor                        => '-99999', 
                                                                   le.EmrgPrimaryName=''                 => '-99998',
                                                                   le.EmrgAddrType NOT IN ['F','G','H','P','R','S','U'] => '-99997',
                                                                                                            le.EmrgAddrType);  
    self.attributes.version2.EmrgLexIDsAtEmrgAddrCnt1Y    := MAP(noDid or isMinor                        => -99999, 
                                                                   le.EmrgAddrType = '-99998'            => -99998,
                                                                   le.EmrgPrimaryName=''                 => -99998,
                                                                   le.EmrgDt_first_seen <= 0             => -99997,
                                                                                                            MIN(le.EmrgLexIDsAtEmrgAddrCnt1Y,ProfileBooster.V2_Constants.Max999));  
    self.attributes.version2.EmrgAge25to59Flag            := MAP(noDid or isMinor                        => -99999, 
                                                                   EmrgAge=-99998                        => -99998,
                                                                   (unsigned)le.EmrgDob<=0               => -99997,

                                                                                                            le.EmrgAge25to59Flag);  

    self.attributes.version2.ShortTermShopNewMsnc         := MAP(noDid or isMinor                        => -99999, 
                                                                   le.ShortTermShopNewMsnc = 99998 or le.ShortTermShopCntEv=0 => -99998,
                                                                   le.ShortTermShopNewMsnc = 99997       => -99997,
                                                                                                            MIN(le.ShortTermShopNewMsnc,ProfileBooster.V2_Constants.Max960));  
    self.attributes.version2.ShortTermShopOldMsnc         := MAP(noDid or isMinor                        => -99999, 
                                                                   le.ShortTermShopCntEv=0               => -99998,
                                                                                                            MIN(le.ShortTermShopOldMsnc,ProfileBooster.V2_Constants.Max960));  
    self.attributes.version2.ShortTermShopCntEv           := IF(noDid or isMinor, -99999, MIN(le.ShortTermShopCntEv,ProfileBooster.V2_Constants.Max960));  
    self.attributes.version2.ShortTermShopCnt6M           := IF(noDid or isMinor, -99999, MIN(le.ShortTermShopCnt6M,ProfileBooster.V2_Constants.Max960));  
    self.attributes.version2.ShortTermShopCnt5Y           := IF(noDid or isMinor, -99999, MIN(le.ShortTermShopCnt5Y,ProfileBooster.V2_Constants.Max960));  
    self.attributes.version2.ShortTermShopCnt1Y           := IF(noDid or isMinor, -99999, MIN(le.ShortTermShopCnt1Y,ProfileBooster.V2_Constants.Max960));  
    
    //HOUSEHOLD ATTRIBUTES
    self.attributes.version2.HHID                         := MAP(noDid or isMinor                        => -99999,
                                                                 noHHID                                  => -99998,
                                                                                                            MIN(le.HHID,ProfileBooster.V2_Constants.Max999999999999999));  
    //include our prospect in the appropriate age bucket for household members
    HHTeenagerMmbrCnt                                     := le.HHTeenagerMmbrCnt + IF((integer)le.DemAge between 13 and 19, 1, 0);
    HHYoungAdultMmbrCnt                                   := le.HHYoungAdultMmbrCnt + IF((integer)le.DemAge between 20 and 39, 1, 0);
    HHMiddleAgemmbrCnt                                    := le.HHMiddleAgemmbrCnt + IF((integer)le.DemAge between 40 and 64, 1, 0);   
    HHSeniorMmbrCnt                                       := le.HHSeniorMmbrCnt + IF((integer)le.DemAge between 65 and 79, 1, 0);
    HHElderlyMmbrCnt                                      := le.HHElderlyMmbrCnt + IF((integer)le.DemAge > 79, 1, 0);
    // self.attributes.version2.HHTeenagerMmbrCnt              := IF(noDid or isMinor, -99999, MIN(HHTeenagerMmbrCnt,ProfileBooster.V2_Constants.Max255));
    prospectDemAge := IF(le.ProspectAge = 0 and NOT isMinor, -99997, le.ProspectAge);
    self.attributes.version2.HHTeenagerMmbrCnt            := IF((integer)prospectDemAge < 0, -99997, IF((integer)prospectDemAge between 13 and 19, 1, 0));
    self.attributes.version2.HHYoungAdultMmbrCnt          := IF((integer)prospectDemAge < 0, -99997, IF((integer)prospectDemAge between 20 and 39, 1, 0));
    self.attributes.version2.HHMiddleAgemmbrCnt           := IF((integer)prospectDemAge < 0, -99997, IF((integer)prospectDemAge between 40 and 64, 1, 0));
    self.attributes.version2.HHSeniorMmbrCnt              := IF((integer)prospectDemAge < 0, -99997, IF((integer)prospectDemAge between 65 and 79, 1, 0));
    self.attributes.version2.HHElderlyMmbrCnt             := IF((integer)prospectDemAge < 0, -99997, IF((integer)prospectDemAge > 79, 1, 0));
    self.attributes.version2.HHMmbrCnt                    := 1; //add 1 to include the prospect  
    self.attributes.version2.HHComplexTotalCnt            := MAP(le.curr_prim_range = le.prim_range OR le.rec_type = 1 => 1, 
                                                                                                         le.curr_prim_range = '' OR le.prim_range = '' => -99997,
                                                                                                         0); //add 1 to include the prospect  
    self.attributes.version2.HHUnitsInComplexCnt          := 1; //add 1 to include the prospect  
    self.attributes.version2.HHMmbrAgeMed                 := (INTEGER)prospectDemAge; //add 1 to include the prospect  
    self.attributes.version2.HHMmbrAgeAvg                 := (INTEGER)prospectDemAge; //add 1 to include the prospect  
    self.attributes.version2.HHEstimatedIncomeRange       := IF((INTEGER)le.ProspectEstimatedIncomeRange < 0, -99997, (INTEGER)le.ProspectEstimatedIncomeRange);
    // self.attributes.version2.HHEstimatedIncomeAvg            := IF(noDid or isMinor, -99999, le.HHEstimatedIncomeAvg);
    self.attributes.version2.HHMmbrWEduCollCnt            := MIN(le.DemEduCollFlagEv,ProfileBooster.V2_Constants.Max255);
    self.attributes.version2.HHMmbrWEduCollEvidEvCnt      := MIN(le.DemEduCollEvidFlagEv,ProfileBooster.V2_Constants.Max255);
    // self.attributes.version2.HHMmbrWEduColl2YrCnt         := IF(le.DemEduCollLevelHighEv < 0, -99997, MIN(le.DemEduCollLevelHighEv,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.HHMmbrWEduColl2YrCnt         := MAP(le.DemEduCollLevelHighEv < 0 => -99997,
                                                                                                                le.DemEduCollLevelHighEv = 1 => 1,
                                                                                                                0);
    self.attributes.version2.HHMmbrWEduColl4YrCnt         := MAP(le.DemEduCollLevelHighEv < 0 => -99997,
                                                                                                                le.DemEduCollLevelHighEv = 2 => 1,
                                                                                                                0);
    self.attributes.version2.HHMmbrWEduCollGradCnt        := MAP(le.DemEduCollLevelHighEv < 0 => -99997,
                                                                                                                le.DemEduCollLevelHighEv = 3 => 1,
                                                                                                                0);
    self.attributes.version2.HHMmbrWCollPvtCnt            := IF(le.DemEduCollInstPvtFlagEv < 0, -99997, MIN(le.DemEduCollInstPvtFlagEv,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.HHMmbrCollTierHighest        := MAP(le.DemEduCollTierHighEv < 0 => -99997, le.DemEduCollTierHighEv = 0 => -99998, le.DemEduCollTierHighEv);
    self.attributes.version2.HHMmbrCollTierAvg            := MAP(le.DemEduCollTierHighEv < 0 => -99997, le.DemEduCollTierHighEv = 0 => -99998, le.DemEduCollTierHighEv);
    // self.attributes.version2.HHMmbrWAstPropCurrCnt              := MAP(noDid or isMinor or noHHID => -99999,
                                                                                                                              // le.HHPropCurrOwnerMmbrCnt < 0=> -99997,
                                                                                                                              // MIN(le.HHPropCurrOwnerMmbrCnt,ProfileBooster.V2_Constants.Max255));
    // self.attributes.version2.HHAstPropCurrCnt                      := MAP(noDid or isMinor or noHHID => -99999, 
                                                                                                                              // le.HHPropCurrOwnedCnt < 0 => -99997,
                                                                                                                              // MIN(le.HHPropCurrOwnedCnt,ProfileBooster.V2_Constants.Max255));
    // self.attributes.version2.HHMmbrPropAVMMax                := MAP(noDid or isMinor or noHHID  => -99999, 
                                                                                                                              // le.HHPropCurrAVMHighest <= 0 => -99997,
                                                                                                                              // MIN(le.HHPropCurrAVMHighest,ProfileBooster.V2_Constants.Max9999999));
    // self.attributes.version2.HHMmbrPropAVMAvg                    := MAP(noDid or isMinor or noHHID => -99999,
                                                                                                                              // le.HHMmbrPropAVMAvg <= 0 => -99997,
                                                                                                                              // MIN(le.HHMmbrPropAVMAvg,ProfileBooster.V2_Constants.Max9999999999));
    // self.attributes.version2.HHMmbrPropAVMTot                := MAP(noDid or isMinor or noHHID => -99999,
                                                                                                                              // le.HHMmbrPropAVMTot <= 0 => -99997,
                                                                                                                              // MIN(le.HHMmbrPropAVMTot,ProfileBooster.V2_Constants.Max9999999999));
    // self.attributes.version2.HHMmbrPropAVMTot1Y            := MAP(noDid or isMinor or noHHID => -99999,
                                                                                                                              // le.HHMmbrPropAVMTot1Y <= 0 => -99997,
                                                                                                                              // MIN(le.HHMmbrPropAVMTot1Y,ProfileBooster.V2_Constants.Max9999999));
    // self.attributes.version2.HHMmbrPropAVMTot5Y            := MAP(noDid or isMinor or noHHID => -99999,
                                                                                                                              // le.HHMmbrPropAVMTot5Y <= 0 => -99997,
                                                                                                                              // MIN(le.HHMmbrPropAVMTot5Y,ProfileBooster.V2_Constants.Max9999999));    
    // self.attributes.version2.HHMmbrWAstPropCurrCnt              := le.AstPropCntEv;
    // self.attributes.version2.HHAstPropCurrCnt                      := le.AstPropCurrCntEv;
    // self.attributes.version2.HHMmbrPropAVMMax                := 0;
    // self.attributes.version2.HHMmbrPropAVMAvg                    := 0;
    // self.attributes.version2.HHMmbrPropAVMTot                    := IF(le.AstPropCurrAVMTot <= 0, -99997, MIN(le.AstPropCurrAVMTot,ProfileBooster.V2_Constants.Max9999999999));        
    self.attributes.version2.HHMmbrWAstPropCurrCnt        := IF(le.AstPropCurrFlag < 0, -99997, MIN(le.AstPropCurrFlag,ProfileBooster.V2_Constants.Max255));     
    self.attributes.version2.HHAstPropCurrCnt             := IF(le.AstPropCurrCntEv < 0, -99997, MIN(le.AstPropCurrCntEv,ProfileBooster.V2_Constants.Max255));     
    self.attributes.version2.HHMmbrPropAVMMax             := IF(le.AstPropCurrAVMTot < 0, -99997, MIN(le.AstPropCurrAVMTot,ProfileBooster.V2_Constants.Max9999999));
    self.attributes.version2.HHMmbrPropAVMAvg             := IF(le.AstPropCurrAVMTot < 0, -99997, MIN(le.AstPropCurrAVMTot,ProfileBooster.V2_Constants.Max9999999));
    self.attributes.version2.HHMmbrPropAVMTot             := IF(le.AstPropCurrAVMTot < 0, -99997, MIN(le.AstPropCurrAVMTot,ProfileBooster.V2_Constants.Max9999999999));    
    self.attributes.version2.HHMmbrPropAVMTot1Y           := MAP((INTEGER)TimeOnRecord < 12 AND (INTEGER)TimeOnRecord >= 0 AND le.AstPropCurrAVMTot >= 0 => le.AstPropCurrAVMTot, 
                                                                                                                           le.AstPropCurrAVMTot < 0 OR (INTEGER)TimeOnRecord < 0 => -99997,
                                                                                                                           0);
    self.attributes.version2.HHMmbrPropAVMTot5Y           := MAP((INTEGER)TimeOnRecord < 60 AND (INTEGER)TimeOnRecord >= 0 AND le.AstPropCurrAVMTot >= 0 => le.AstPropCurrAVMTot, 
                                                                                                                           le.AstPropCurrAVMTot < 0 OR (INTEGER)TimeOnRecord < 0 => -99997,
                                                                                                                           0);
                                                                                                                           
    AutoOwnedCntHelper := IF(le.AstVehAutoCntEv < 0, -99997, MIN(le.AstVehAutoCntEv,ProfileBooster.V2_Constants.Max255));
    MotorcycleOwnedCntHelper := IF(le.AstVehOtherMtrCntEv < 0, -99997, MIN(le.AstVehOtherMtrCntEv,ProfileBooster.V2_Constants.Max255));
    AircraftOwnedCntHelper := IF(le.AstPropAirCrftCntEv < 0, -99997, MIN(le.AstPropAirCrftCntEv,ProfileBooster.V2_Constants.Max255));
    WatercraftOwnedCntHelper := IF(le.AstPropWtrcrftCntEv < 0, -99997, MIN(le.AstPropWtrcrftCntEv,ProfileBooster.V2_Constants.Max255));
    AllVehiclesTogetherHelper := MAX(AutoOwnedCntHelper, 0) + MAX(MotorcycleOwnedCntHelper, 0) + MAX(AircraftOwnedCntHelper, 0) + MAX(WatercraftOwnedCntHelper, 0);
    
    self.attributes.version2.HHVehicleOwnedCnt            := MAP(AllVehiclesTogetherHelper > 0 => AllVehiclesTogetherHelper,
                                                                                                          AutoOwnedCntHelper < 0 OR MotorcycleOwnedCntHelper < 0 OR AircraftOwnedCntHelper < 0 OR WatercraftOwnedCntHelper < 0=> -99997,
                                                                                                          0);
    self.attributes.version2.HHAutoOwnedCnt               := AutoOwnedCntHelper;
    self.attributes.version2.HHMotorcycleOwnedCnt         := MotorcycleOwnedCntHelper;
    self.attributes.version2.HHAircraftOwnedCnt           := AircraftOwnedCntHelper;
    self.attributes.version2.HHWatercraftOwnedCnt         := WatercraftOwnedCntHelper;
    
    self.attributes.version2.HHMmbrWDrgCnt7Y              := MAP(noDid or isMinor or noHHID              => -99999,
                                                                 DrgCnt7Y > 0                            => 1, 
                                                                                                            DrgCnt7Y);
    // self.attributes.version2.HHMmbrWDrgSeverityIndx7Y        := IF(noDid or isMinor or noHHID, -99999, MIN(DrgSeverityIndx7Y,ProfileBooster.V2_Constants.Max5));
    self.attributes.version2.HHMmbrWDrgCnt1Y              := MAP(noDid or isMinor or noHHID              => -99999,
                                                                 DrgCnt1Y > 0                            => 1, 
                                                                                                            DrgCnt1Y);
    self.attributes.version2.HHMmbrDrgNewMsnc7Y           := IF(noDid or isMinor or noHHID, -99999, MIN(DrgNewMsnc7Y,ProfileBooster.V2_Constants.Max84));
    self.attributes.version2.HHMmbrWCrimFelCnt7Y          := MAP(noDid or isMinor                        => -99999,
                                                                 DrgCrimFelCnt7Y > 0                     => 1, 
                                                                                                            DrgCrimFelCnt7Y);
    self.attributes.version2.HHMmbrWCrimFelCnt1Y          := MAP(noDid or isMinor or noHHID              => -99999,
                                                                 DrgCrimFelCnt1Y > 0                     => 1, 
                                                                                                            DrgCrimFelCnt1Y);
    self.attributes.version2.HHMmbrWCrimFelNewMsnc7Y      := IF(noDid or isMinor or noHHID, -99999, MIN(DrgCrimFelNewMsnc7Y,ProfileBooster.V2_Constants.Max84));
    self.attributes.version2.HHMmbrWCrimNFelCnt7Y         := MAP(noDid or isMinor or noHHID              => -99999,
                                                                 DrgCrimNFelCnt7Y > 0                    => 1, 
                                                                                                            DrgCrimNFelCnt7Y);
    self.attributes.version2.HHMmbrWCrimNFelCnt1Y         := MAP(noDid or isMinor or noHHID              => -99999,
                                                                 DrgCrimNFelCnt1Y > 0                    => 1, 
                                                                                                            DrgCrimNFelCnt1Y);
    self.attributes.version2.HHMmbrWCrimNFelNewMsnc7Y     := IF(noDid or isMinor or noHHID, -99999, MIN(DrgCrimNFelNewMsnc7Y,ProfileBooster.V2_Constants.Max84));
    self.attributes.version2.HHMmbrWEvictCnt7Y            := MAP(noDid or isMinor or noHHID              => -99999,
                                                                 DrgEvictCnt7Y > 0                       => 1, 
                                                                                                            DrgEvictCnt7Y);
    self.attributes.version2.HHMmbrWEvictCnt1Y            := MAP(noDid or isMinor or noHHID              => -99999,
                                                                 DrgEvictCnt1Y > 0                       => 1, 
                                                                                                            DrgEvictCnt1Y);
    self.attributes.version2.HHMmbrWEvictNewMsnc7Y        := IF(noDid or isMinor or noHHID, -99999, MIN(DrgEvictNewMsnc7Y,ProfileBooster.V2_Constants.Max84));
    self.attributes.version2.HHMmbrWLnJCnt7Y              := MAP(noDid or isMinor or noHHID              => -99999,
                                                                 DrgLnJCnt7Y > 0                         => 1, 
                                                                                                            DrgLnJCnt7Y);
    self.attributes.version2.HHMmbrWLnJCnt1Y              := MAP(noDid or isMinor or noHHID              => -99999,
                                                                 DrgLnJCnt1Y > 0                         => 1, 
                                                                                                            DrgLnJCnt1Y);
    self.attributes.version2.HHMmbrLnJAmtTot7Y            := IF(noDid or isMinor or noHHID, -99999, MIN(DrgLnJAmtTot7Y,ProfileBooster.V2_Constants.Max9999999));
    self.attributes.version2.HHMmbrWLnJNewMsnc7Y          := IF(noDid or isMinor or noHHID, -99999, MIN(DrgLnJNewMsnc7Y,ProfileBooster.V2_Constants.Max84));
    self.attributes.version2.HHMmbrWBkCnt10Y              := MAP(noDid or isMinor or noHHID              => -99999,
                                                                 DrgBkCnt10Y > 0                         => 1, 
                                                                                                            DrgBkCnt10Y);
    self.attributes.version2.HHMmbrWBkCnt1Y               := MAP(noDid or isMinor or noHHID              => -99999,
                                                                 DrgBkCnt1Y > 0                          => 1, 
                                                                                                            DrgBkCnt1Y);
    self.attributes.version2.HHMmbrWBkCnt2Y               := MAP(noDid or isMinor or noHHID              => -99999,
                                                                 DrgBkNewMsnc10Y BETWEEN 0 AND 24        => 1, 
                                                                                                            0);
    self.attributes.version2.HHMmbrWBkNewMsnc10Y          := IF(noDid or isMinor or noHHID, -99999, MIN(DrgBkNewMsnc10Y,ProfileBooster.V2_Constants.Max120));
    
    self.attributes.version2.HHMmbrWithProfLicCnt         := IF(noDid or isMinor, -99999, MIN(le.HHMmbrWithProfLicCnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.HHMmbrWBusAssocCnt           := IF(noDid or isMinor, -99999, MIN(le.HHMmbrWBusAssocCnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.HHMmbrWProfLicCat1Cnt        := IF(noDid or isMinor, -99999, MIN(le.HHMmbrWProfLicCat1Cnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.HHMmbrWProfLicCat2Cnt        := IF(noDid or isMinor, -99999, MIN(le.HHMmbrWProfLicCat2Cnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.HHMmbrWProfLicCat3Cnt        := IF(noDid or isMinor, -99999, MIN(le.HHMmbrWProfLicCat3Cnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.HHMmbrWProfLicCat4Cnt        := IF(noDid or isMinor, -99999, MIN(le.HHMmbrWProfLicCat4Cnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.HHMmbrWProfLicCat5Cnt        := IF(noDid or isMinor, -99999, MIN(le.HHMmbrWProfLicCat5Cnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.HHMmbrWProfLicUncatCnt       := IF(noDid or isMinor, -99999, MIN(le.HHMmbrWProfLicUncatCnt,ProfileBooster.V2_Constants.Max255));
    
    self.attributes.version2.HHMmbrWIntSportCnt           := MIN(le.IntSportPersonFlag5Y,ProfileBooster.V2_Constants.Max255);
    
    self.attributes.version2.HHPurchNewAmt                := MAP(le.purchnewamt = 0 => -99998,
                                                                                                          le.purchnewamt < 0 => -99997, 
                                                                                                          MIN(le.purchnewamt,ProfileBooster.V2_Constants.Max9999));
    self.attributes.version2.HHPurchTotEv                 := MAP(le.purchtotev = 0 => -99998,
                                                                                                          le.purchtotev < 0 => -99997, 
                                                                                                          MIN(le.purchtotev,ProfileBooster.V2_Constants.Max99999));
    self.attributes.version2.HHPurchCntEv                 := MIN(le.purchcntev,ProfileBooster.V2_Constants.Max999);
    self.attributes.version2.HHPurchNewMsnc               := MAP(le.purchnewmsnc = 0 OR le.purchnewmsnc = 99998 => -99998,
                                                                                                          le.purchnewmsnc < 0 => -99997,
                                                                                                          MIN(le.purchnewmsnc,ProfileBooster.V2_Constants.Max99));
    self.attributes.version2.HHPurchOldMsnc               := MAP(le.purcholdmsnc = 0 OR le.purcholdmsnc = 99998 => -99998,
                                                                                                          le.purcholdmsnc < 0 => -99997,
                                                                                                          MIN(le.purcholdmsnc,ProfileBooster.V2_Constants.Max99));
    self.attributes.version2.HHPurchItemCntEv             := IF(le.purchitemcntev < 0, -99997, MIN(le.purchitemcntev,ProfileBooster.V2_Constants.Max999));
    self.attributes.version2.HHPurchAmtAvg                := MAP(le.purchamtavg = 0 => -99998,
                                                                                                          le.purchamtavg < 0 => -99997, 
                                                                                                          MIN(le.purchamtavg,ProfileBooster.V2_Constants.Max9999));

    self.attributes.version2.HHAstVehAutoCarCntEv         := IF(noDid or isMinor, -99999, MIN(le.HHAstVehAutoCarCntEv,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehAutoCntEv            := IF(noDid or isMinor, -99999, MIN(le.HHAstVehAutoCntEv,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehAutoEliteCntEv       := IF(noDid or isMinor, -99999, MIN(le.HHAstVehAutoEliteCntEv,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehAutoExpCntEv         := IF(noDid or isMinor, -99999, MIN(le.HHAstVehAutoExpCntEv,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehAutoLuxuryCntEv      := IF(noDid or isMinor, -99999, MIN(le.HHAstVehAutoLuxuryCntEv,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehAutoMakeCntEv        := IF(noDid or isMinor, -99999, MIN(le.HHAstVehAutoMakeCntEv,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehAutoOrigOwnCntEv     := IF(noDid or isMinor, -99999, MIN(le.HHAstVehAutoOrigOwnCntEv,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehAutoSUVCntEv         := IF(noDid or isMinor, -99999, MIN(le.HHAstVehAutoSUVCntEv,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehAutoTruckCntEv       := IF(noDid or isMinor, -99999, MIN(le.HHAstVehAutoTruckCntEv,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehAutoVanCntEv         := IF(noDid or isMinor, -99999, MIN(le.HHAstVehAutoVanCntEv,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehAuto2ndFreqMake      := IF(noDid or isMinor, '-99999', le.HHAstVehAuto2ndFreqMake);  
    self.attributes.version2.HHAstVehAuto2ndFreqMakeCntEv := IF(noDid or isMinor, -99999, MIN(le.HHAstVehAuto2ndFreqMakeCntEv,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehAutoFreqMake         := IF(noDid or isMinor, '-99999', le.HHAstVehAutoFreqMake);  
    self.attributes.version2.HHAstVehAutoFreqMakeCntEv    := IF(noDid or isMinor, -99999, MIN(le.HHAstVehAutoFreqMakeCntEv,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehAutoNewTypeIndx      := IF(noDid or isMinor, -99999, MIN(le.HHAstVehAutoNewTypeIndx,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehAutoEmrgPriceAvg     := IF(noDid or isMinor, -99999, MIN(le.HHAstVehAutoEmrgPriceAvg,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehAutoEmrgPriceDiff    := IF(noDid or isMinor, -99999, MIN(le.HHAstVehAutoEmrgPriceDiff,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehAutoEmrgPriceMax     := IF(noDid or isMinor, -99999, MIN(le.HHAstVehAutoEmrgPriceMax,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehAutoNewPrice         := IF(noDid or isMinor, -99999, MIN(le.HHAstVehAutoNewPrice,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehAutoEmrgAgeAvg       := IF(noDid or isMinor, -99999, MIN(le.HHAstVehAutoEmrgAgeAvg,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehAutoEmrgAgeMax       := IF(noDid or isMinor, -99999, MIN(le.HHAstVehAutoEmrgAgeMax,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehAutoEmrgAgeMin       := IF(noDid or isMinor, -99999, MIN(le.HHAstVehAutoEmrgAgeMin,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehAutoEmrgSpanAvg      := IF(noDid or isMinor, -99999, MIN(le.HHAstVehAutoEmrgSpanAvg,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehAutoLastAgeAvg       := IF(noDid or isMinor, -99999, MIN(le.HHAstVehAutoLastAgeAvg,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehAutoLastAgeMax       := IF(noDid or isMinor, -99999, MIN(le.HHAstVehAutoLastAgeMax,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehAutoLastAgeMin       := IF(noDid or isMinor, -99999, MIN(le.HHAstVehAutoLastAgeMin,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehAutoNewMsnc          := IF(noDid or isMinor, -99999, MIN(le.HHAstVehAutoNewMsnc,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehAutoTimeOwnSpanAvg   := IF(noDid or isMinor, -99999, MIN(le.HHAstVehAutoTimeOwnSpanAvg,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehOtherATVCntEv        := IF(noDid or isMinor, -99999, MIN(le.HHAstVehOtherATVCntEv,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehOtherCamperCntEv     := IF(noDid or isMinor, -99999, MIN(le.HHAstVehOtherCamperCntEv,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehOtherCntEv           := IF(noDid or isMinor, -99999, MIN(le.HHAstVehOtherCntEv,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehOtherCommCntEv       := IF(noDid or isMinor, -99999, MIN(le.HHAstVehOtherCommCntEv,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehOtherMtrCntEv        := IF(noDid or isMinor, -99999, MIN(le.HHAstVehOtherMtrCntEv,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehOtherOrigOwnCntEv    := IF(noDid or isMinor, -99999, MIN(le.HHAstVehOtherOrigOwnCntEv,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehOtherScooterCntEv    := IF(noDid or isMinor, -99999, MIN(le.HHAstVehOtherScooterCntEv,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehOtherNewMsnc         := IF(noDid or isMinor, -99999, MIN(le.HHAstVehOtherNewMsnc,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehOtherNewTypeIndx     := IF(noDid or isMinor, -99999, MIN(le.HHAstVehOtherNewTypeIndx,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehOtherNewPrice        := IF(noDid or isMinor, -99999, MIN(le.HHAstVehOtherNewPrice,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehOtherPriceAvg        := IF(noDid or isMinor, -99999, MIN(le.HHAstVehOtherPriceAvg,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehOtherPriceMax        := IF(noDid or isMinor, -99999, MIN(le.HHAstVehOtherPriceMax,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehOtherPriceMin        := IF(noDid or isMinor, -99999, MIN(le.HHAstVehOtherPriceMin,ProfileBooster.V2_Constants.Max9999));  
    self.attributes.version2.HHAstVehAutoEmrgPriceMin     := IF(noDid or isMinor, -99999, MIN(le.HHAstVehAutoEmrgPriceMin,ProfileBooster.V2_Constants.Max9999));  
 
    self.attributes.version2.RaATeenagerCnt               := IF(noDid or isMinor, -99999, MIN(le.RaATeenagerCnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAYoungAdultCnt             := IF(noDid or isMinor, -99999, MIN(le.RaAYoungAdultCnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAMiddleAgeCnt              := IF(noDid or isMinor, -99999, MIN(le.RaAMiddleAgeCnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaASeniorCnt                 := IF(noDid or isMinor, -99999, MIN(le.RaASeniorCnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAElderlyCnt                := IF(noDid or isMinor, -99999, MIN(le.RaAElderlyCnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAUniqueHHCnt               := IF(noDid or isMinor, -99999, MIN(le.RaAUniqueHHCnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaACnt                       := IF(noDid or isMinor, -99999, MIN(le.RaACnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAMedianIncome              := MAP(noDid or isMinor              => -99999, 
                                                                   le.RaAMedianIncome > 150000  => 11,
                                                                   le.RaAMedianIncome > 120000  => 10,
                                                                   le.RaAMedianIncome > 100000  => 9,
                                                                   le.RaAMedianIncome > 80000    => 8,
                                                                   le.RaAMedianIncome > 60000    => 7,
                                                                   le.RaAMedianIncome > 50000    => 6,
                                                                   le.RaAMedianIncome > 40000    => 5,
                                                                   le.RaAMedianIncome > 35000    => 4,
                                                                   le.RaAMedianIncome > 30000    => 3,
                                                                   le.RaAMedianIncome > 25000    => 2,
                                                                   le.RaAMedianIncome > 0        => 1,
                                                                                                   -99999);  
    self.attributes.version2.RaAWEduCollCnt               := IF(noDid or isMinor, -99999, MIN(le.RaAWEduCollCnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWEduColl2YCnt             := IF(noDid or isMinor, -99999, MIN(le.RaAWEduColl2YCnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWEduColl4YCnt             := IF(noDid or isMinor, -99999, MIN(le.RaAWEduColl4YCnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWEduCollGradCnt           := IF(noDid or isMinor, -99999, MIN(le.RaAWEduCollGradCnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWCollPvtCnt               := IF(noDid or isMinor, -99999, MIN(le.RaAWCollPvtCnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWTopTierCollCnt           := IF(noDid or isMinor, -99999, MIN(le.RaAWTopTierCollCnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWMidTierCollCnt           := IF(noDid or isMinor, -99999, MIN(le.RaAWMidTierCollCnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWLowTierCollCnt           := IF(noDid or isMinor, -99999, MIN(le.RaAWLowTierCollCnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaACurrAddrCloseDist         := IF(noDid or isMinor, -99999, MIN(le.RaACurrAddrCloseDist,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaACurrAddrCloseNZDist       := IF(noDid or isMinor, -99999, MIN(le.RaACurrAddrCloseNZDist,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaACurrAddr25MiDistCnt1Y     := IF(noDid or isMinor, -99999, MIN(le.RaACurrAddr25MiDistCnt1Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaACurrAddr100MiDistCnt1Y    := IF(noDid or isMinor, -99999, MIN(le.RaACurrAddr100MiDistCnt1Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaACurrAddrGT500MiDistCnt1Y  := IF(noDid or isMinor, -99999, MIN(le.RaACurrAddrGT500MiDistCnt1Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaACurrAddrDistAvg1Y         := IF(noDid or isMinor, -99999, MIN(le.RaACurrAddrDistAvg1Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWCrim25MiCnt7Y            := IF(noDid or isMinor, -99999, MIN(le.RaAWCrim25MiCnt7Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWCrimCurrAddrCloseDist7Y  := IF(noDid or isMinor, -99999, MIN(le.RaAWCrimCurrAddrCloseDist7Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAEstIncomeAvg              := IF(noDid or isMinor, -99999, MIN(le.RaAEstIncomeAvg,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAEstIncomeMax              := IF(noDid or isMinor, -99999, MIN(le.RaAEstIncomeMax,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaACurrHomeValAvg            := IF(noDid or isMinor, -99999, MIN(le.RaACurrHomeValAvg,ProfileBooster.V2_Constants.Max255));

    self.attributes.version2.RaAPropOwnCnt                := IF(noDid or isMinor, -99999, MIN(le.RaAPropOwnCnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAPropCurrOwnTot            := IF(noDid or isMinor, -99999, MIN(le.RaAPropCurrOwnTot,ProfileBooster.V2_Constants.Max9999999));
    self.attributes.version2.RaAPropCurrAVMValMax         := IF(noDid or isMinor, -99999, MIN(le.RaAPropCurrAVMValMax,ProfileBooster.V2_Constants.Max9999999));
    self.attributes.version2.RaAPropCurrAVMValAvg         := IF(noDid or isMinor, -99999, MIN(le.RaAPropCurrAVMValAvg,ProfileBooster.V2_Constants.Max9999999));
    self.attributes.version2.RaAPropCurrAVMValTot         := IF(noDid or isMinor, -99999, MIN(le.RaAPropCurrAVMValTot,ProfileBooster.V2_Constants.Max9999999));
    self.attributes.version2.RaAPropCurrAVMValTot1Y       := IF(noDid or isMinor, -99999, MIN(le.RaAPropCurrAVMValTot1Y,ProfileBooster.V2_Constants.Max9999999));
    self.attributes.version2.RaAPropCurrAVMValTot5Y       := IF(noDid or isMinor, -99999, MIN(le.RaAPropCurrAVMValTot5Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAVehicleOwnedCnt           := IF(noDid or isMinor, -99999, MIN(le.RaAVehicleOwnedCnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAAutoOwnedCnt              := IF(noDid or isMinor, -99999, MIN(le.RaAAutoOwnedCnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAMotorcycleOwnedCnt        := IF(noDid or isMinor, -99999, MIN(le.RaAMotorcycleOwnedCnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAAircraftOwnedCnt          := IF(noDid or isMinor, -99999, MIN(le.RaAAircraftOwnedCnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWatercraftOwnedCnt        := IF(noDid or isMinor, -99999, MIN(le.RaAWatercraftOwnedCnt,ProfileBooster.V2_Constants.Max255));
    
    self.attributes.version2.RaAWIntSportCnt              := IF(noDid or isMinor, -99999, MIN(le.RaAWIntSportCnt,ProfileBooster.V2_Constants.Max255));

    self.attributes.version2.RaAWDrgCnt7Y                 := IF(noDid or isMinor, -99999, MIN(le.RaAWDrgCnt7Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWDrgCnt1Y                 := IF(noDid or isMinor, -99999, MIN(le.RaAWDrgCnt1Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWDrgNewMSnc7Y             := IF(noDid or isMinor, -99999, MIN(le.RaAWDrgNewMSnc7Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWCrimFelCnt7Y             := IF(noDid or isMinor, -99999, MIN(le.RaAWCrimFelCnt7Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWCrimFelCnt1Y             := IF(noDid or isMinor, -99999, MIN(le.RaAWCrimFelCnt1Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWCrimFelNewMSnc7Y         := IF(noDid or isMinor, -99999, MIN(le.RaAWCrimFelNewMSnc7Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWCrimNFelCnt7Y            := IF(noDid or isMinor, -99999, MIN(le.RaAWCrimNFelCnt7Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWCrmiNFelCnt1Y            := IF(noDid or isMinor, -99999, MIN(le.RaAWCrmiNFelCnt1Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWCrimNFelNewMSnc7Y        := IF(noDid or isMinor, -99999, MIN(le.RaAWCrimNFelNewMSnc7Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWEvictCnt7Y               := IF(noDid or isMinor, -99999, MIN(le.RaAWEvictCnt7Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWEvictCnt1Y               := IF(noDid or isMinor, -99999, MIN(le.RaAWEvictCnt1Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWEvictNewMSnc7Y           := IF(noDid or isMinor, -99999, MIN(le.RaAWEvictNewMSnc7Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWLnJCnt7Y                 := IF(noDid or isMinor, -99999, MIN(le.RaAWLnJCnt7Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWLnJCnt1Y                 := IF(noDid or isMinor, -99999, MIN(le.RaAWLnJCnt1Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaALnJAmtTot                 := IF(noDid or isMinor, -99999, MIN(le.RaALnJAmtTot, ProfileBooster.V2_Constants.Max9999999));
    self.attributes.version2.RaAWLnJNewMSnc7Y             := IF(noDid or isMinor, -99999, MIN(le.RaAWLnJNewMSnc7Y, ProfileBooster.V2_Constants.Max9999999));
    self.attributes.version2.RaAWBkCnt10Y                 := IF(noDid or isMinor, -99999, MIN(le.RaAWBkCnt10Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWBkCnt1Y                  := IF(noDid or isMinor, -99999, MIN(le.RaAWBkCnt1Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWBkCnt2Y                  := IF(noDid or isMinor, -99999, MIN(le.RaAWBkCnt2Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWBkNewMSnc10Y             := IF(noDid or isMinor, -99999, MIN(le.RaAWBkNewMSnc10Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAFrClCnt7Y                 := IF(noDid or isMinor, -99999, MIN(le.RaAFrClCnt7Y,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAFrClNewMsnc7Y             := IF(noDid or isMinor, -99999, MIN(le.RaAFrClNewMsnc7Y,ProfileBooster.V2_Constants.Max255));
    
    self.attributes.version2.RaAWProfLicCnt               := IF(noDid or isMinor, -99999, MIN(le.RaAWProfLicCnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWBusAssocCnt              := IF(noDid or isMinor, -99999, MIN(le.RaAWBusAssocCnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWProfLicCat1Cnt           := IF(noDid or isMinor, -99999, MIN(le.RaAWProfLicCat1Cnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWProfLicCat2Cnt           := IF(noDid or isMinor, -99999, MIN(le.RaAWProfLicCat2Cnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWProfLicCat3Cnt           := IF(noDid or isMinor, -99999, MIN(le.RaAWProfLicCat3Cnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWProfLicCat4Cnt           := IF(noDid or isMinor, -99999, MIN(le.RaAWProfLicCat4Cnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWProfLicCat5Cnt           := IF(noDid or isMinor, -99999, MIN(le.RaAWProfLicCat5Cnt,ProfileBooster.V2_Constants.Max255));
    self.attributes.version2.RaAWProfLicUncatCnt          := IF(noDid or isMinor, -99999, MIN(le.RaAWProfLicUncatCnt,ProfileBooster.V2_Constants.Max255));
    
    self.attributes.version2.RaAPurchNewAmt               := IF(noDid or isMinor, -99999, MIN(le.RaAPurchNewAmt,ProfileBooster.V2_Constants.Max9999));
    self.attributes.version2.RaAPurchTotEv                := IF(noDid or isMinor, -99999, MIN(le.RaAPurchTotEv,ProfileBooster.V2_Constants.Max99999));
    self.attributes.version2.RaAPurchCntEv                := IF(noDid or isMinor, -99999, MIN(le.RaAPurchCntEv,ProfileBooster.V2_Constants.Max999));
    self.attributes.version2.RaAPurchItemCntEv            := IF(noDid or isMinor, -99999, MIN(le.RaAPurchItemCntEv,ProfileBooster.V2_Constants.Max999));
    self.attributes.version2.RaAPurchAmtAvg               := IF(noDid or isMinor, -99999, MIN(le.RaAPurchAmtAvg,ProfileBooster.V2_Constants.Max9999));

    self.attributes.version2.NBHDHHCnt                    := IF(noDid or isMinor, -99999, MIN(le.NBHDHHCnt,ProfileBooster.V2_Constants.Max999999));
    self.attributes.version2.NBHDHHSizeAvg                := IF(noDid or isMinor, -99999, MIN(le.NBHDHHSizeAvg,ProfileBooster.V2_Constants.Max99_9));
    self.attributes.version2.NBHDMmbrCnt                  := IF(noDid or isMinor, -99999, MIN(le.NBHDMmbrCnt,ProfileBooster.V2_Constants.Max100000));
    self.attributes.version2.NBHDMmbrAgeAvg               := IF(noDid or isMinor, -99999, MIN(le.NBHDMmbrAgeAvg,ProfileBooster.V2_Constants.Max99_9));
    self.attributes.version2.NBHDMarriedMmbrPct           := IF(noDid or isMinor, -99999, MIN(le.NBHDMarriedMmbrPct,ProfileBooster.V2_Constants.Max100_0));
    self.attributes.version2.NBHDMedIncome                := IF(noDid or isMinor, -99999, MIN(le.NBHDMedIncome,ProfileBooster.V2_Constants.Max999999));
    self.attributes.version2.NBHDCollegeAttendedMmbrPct   := IF(noDid or isMinor, -99999, MIN(le.NBHDCollegeAttendedMmbrPct,ProfileBooster.V2_Constants.Max100_0));
    self.attributes.version2.NBHDCollege2yrAttendedMmbrPct := IF(noDid or isMinor, -99999, MIN(le.NBHDCollege2yrAttendedMmbrPct,ProfileBooster.V2_Constants.Max100_0));
    self.attributes.version2.NBHDCollege4yrAttendedMmbrPct := IF(noDid or isMinor, -99999, MIN(le.NBHDCollege4yrAttendedMmbrPct,ProfileBooster.V2_Constants.Max100_0));
    self.attributes.version2.NBHDCollegePrivateMmbrPct    := IF(noDid or isMinor, -99999, MIN(le.NBHDCollegePrivateMmbrPct,ProfileBooster.V2_Constants.Max100_0));
    self.attributes.version2.NBHDCollegeTopTierMmbrPct    := IF(noDid or isMinor, -99999, MIN(le.NBHDCollegeTopTierMmbrPct,ProfileBooster.V2_Constants.Max100_0));
    self.attributes.version2.NBHDCollegeCurrentAttendingPct := IF(noDid or isMinor, -99999, MIN(le.NBHDCollegeCurrentAttendingPct,ProfileBooster.V2_Constants.Max100_0));
    self.attributes.version2.NBHDCollegeMidTierMmbrPct    := IF(noDid or isMinor, -99999, MIN(le.NBHDCollegeMidTierMmbrPct,ProfileBooster.V2_Constants.Max100_0));
    self.attributes.version2.NBHDCollegeLowTierMmbrPct    := IF(noDid or isMinor, -99999, MIN(le.NBHDCollegeLowTierMmbrPct,ProfileBooster.V2_Constants.Max100_0));
    self.attributes.version2.NBHDBusinessCnt              := IF(noDid or isMinor, -99999, MIN(le.NBHDBusinessCnt,ProfileBooster.V2_Constants.Max99999));
    self.attributes.version2.NBHDValueChangeIndex         := IF(noDid or isMinor, -99999, MIN(le.NBHDValueChangeIndex,ProfileBooster.V2_Constants.Max99));
    self.attributes.version2.NBHDPropCurrOwnershipHHPct   := IF(noDid or isMinor, -99999, MIN(le.NBHDPropCurrOwnershipHHPct,ProfileBooster.V2_Constants.Max100_0));
    self.attributes.version2.NBHDPropOwnerMmbrPct         := IF(noDid or isMinor, -99999, MIN(le.NBHDPropOwnerMmbrPct,ProfileBooster.V2_Constants.Max100_0));
    self.attributes.version2.NBHDPPCurrOwnedHHPct         := IF(noDid or isMinor, -99999, MIN(le.NBHDPPCurrOwnedHHPct,ProfileBooster.V2_Constants.Max100_0));
    self.attributes.version2.NBHDPPCurrOwnedAutoHHPct     := IF(noDid or isMinor, -99999, MIN(le.NBHDPPCurrOwnedAutoHHPct,ProfileBooster.V2_Constants.Max100_0));
    self.attributes.version2.NBHDPPCurrOwnedMtrcycleHHPct := IF(noDid or isMinor, -99999, MIN(le.NBHDPPCurrOwnedMtrcycleHHPct,ProfileBooster.V2_Constants.Max100_0));
    self.attributes.version2.NBHDPPCurrOwnedAircraftHHPct := IF(noDid or isMinor, -99999, MIN(le.NBHDPPCurrOwnedAircraftHHPct,ProfileBooster.V2_Constants.Max100_0));
    self.attributes.version2.NBHDPPCurrOwnedWtrcrftHHPct  := IF(noDid or isMinor, -99999, MIN(le.NBHDPPCurrOwnedWtrcrftHHPct,ProfileBooster.V2_Constants.Max100_0));
    self.attributes.version2.NBHDOccProfLicenseMmbrPct    := IF(noDid or isMinor, -99999, MIN(le.NBHDOccProfLicenseMmbrPct,ProfileBooster.V2_Constants.Max100_0));
    self.attributes.version2.NBHDOccBusinessAssociationMmbrPct := IF(noDid or isMinor, -99999, MIN(le.NBHDOccBusinessAssociationMmbrPct,ProfileBooster.V2_Constants.Max100_0));
    self.attributes.version2.NBHDInterestSportsPersonMmbrPct   := IF(noDid or isMinor, -99999, MIN(le.NBHDInterestSportsPersonMmbrPct,ProfileBooster.V2_Constants.Max100_0));
    self.attributes.version2.NBHDCrtRcrdMmbrPct1Y         := IF(noDid or isMinor, -99999, MIN(le.NBHDCrtRcrdMmbrPct1Y,ProfileBooster.V2_Constants.Max100_0));
    self.attributes.version2.NBHDCrtRcrdFelonyMmbrPct     := IF(noDid or isMinor, -99999, MIN(le.NBHDCrtRcrdFelonyMmbrPct,ProfileBooster.V2_Constants.Max100_0));
    self.attributes.version2.NBHDCrtRcrdMsdmeanMmbrPct    := IF(noDid or isMinor, -99999, MIN(le.NBHDCrtRcrdMsdmeanMmbrPct,ProfileBooster.V2_Constants.Max100_0));
    self.attributes.version2.NBHDCrtRcrdEvictionMmbrPct   := IF(noDid or isMinor, -99999, MIN(le.NBHDCrtRcrdEvictionMmbrPct,ProfileBooster.V2_Constants.Max100_0));
    self.attributes.version2.NBHDCrtRcrdLienJudgeMmbrPct  := IF(noDid or isMinor, -99999, MIN(le.NBHDCrtRcrdLienJudgeMmbrPct,ProfileBooster.V2_Constants.Max100_0));
    self.attributes.version2.NBHDCrtRcrdBkrptMmbrPct      := IF(noDid or isMinor, -99999, MIN(le.NBHDCrtRcrdBkrptMmbrPct,ProfileBooster.V2_Constants.Max100_0));
    self.attributes.version2.NBHDCrtRcrdBkrptMmbrPct1Y    := IF(noDid or isMinor, -99999, MIN(le.NBHDCrtRcrdBkrptMmbrPct1Y,ProfileBooster.V2_Constants.Max100_0));
    self.attributes.version2.NBHDRiskViewBankScoreAvg     := IF(noDid or isMinor, -99999, MIN(le.NBHDRiskViewBankScoreAvg,ProfileBooster.V2_Constants.Max900));
    self.attributes.version2.NBHDTelecomScoreAvg          := IF(noDid or isMinor, -99999, MIN(le.NBHDTelecomScoreAvg,ProfileBooster.V2_Constants.Max900));
    self.attributes.version2.NBHDShortTermLendingScoreAvg := IF(noDid or isMinor, -99999, MIN(le.NBHDShortTermLendingScoreAvg,ProfileBooster.V2_Constants.Max900));
    self.attributes.version2.NBHDAutoScoreAvg             := IF(noDid or isMinor, -99999, MIN(le.NBHDAutoScoreAvg,ProfileBooster.V2_Constants.Max900));
    
    self  := le;
    self  := [];
  end;

  attr := project(PB2Shell, getAttr(left)); 

  OUTPUT(CHOOSEN(PB2Shell, 100), NAMED('AttributesInput'));
  return attr;  
  
END;