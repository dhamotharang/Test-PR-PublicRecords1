﻿EXPORT Append_Model1_Model( infile,do_model=true,p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_INPUTADDRBUSINESSCOUNT,p_INPUTADDRDWELLTYPE,p_VARIATIONRISKLEVEL,p_DIVADDRIDENTITYCOUNT,p_AGENEWESTRECORD,p_ESTIMATEDANNUALINCOME_24,p_RAAPROPCURROWNERMMBRCNT,p_RAASENIORMMBRCNT,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_RAACRTRECMSDMEANMMBRCNT,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_INPUTADDRMOBILITYINDEX,p_DIVADDRIDENTITYMSOURCECOUNT,p_SUBJECTSSNCOUNT,p_RAAYOUNGADULTMMBRCNT,p_VOTERREGISTRATIONRECORD,p_CURRADDRCRIMEINDEX,p_PHONEIDENTITIESCOUNT,p_PREVADDRCARTHEFTINDEX,p_ESTIMATEDANNUALINCOME,p_ESTIMATEDANNUALINCOME_12,p_LIFEEVTIMEFIRSTASSETPURCHASE,p_ADDRMOSTRECENTVALUEDIFF,p_SUBJECTADDRCOUNT,p_RAAPROPOWNERAVMHIGHEST,p_INPUTADDRCARTHEFTINDEX,p_PREVADDRAGELASTSALE,p_BUSINESSINPUTADDRCOUNT,p_PHONEOTHERAGENEWESTRECORD,p_ADDRCHANGECOUNT12,p_HHESTIMATEDINCOMERANGE,p_CURRADDRAGEOLDESTRECORD,p_OCCPROFLICENSECATEGORY,p_RESINPUTOWNERSHIPINDEX,p_AGE_IN_YEARS,p_CURRADDRBURGLARYINDEX,p_CRTRECBKRPTTIMENEWEST,p_SSNADDRCOUNT,p_RELATIVESDISTANCECLOSEST,p_ASSOCCREDITBUREAUONLYCOUNT,p_LIFEEVTIMELASTASSETPURCHASE,p_CORRELATIONRISKLEVEL,p_PRSEARCHLOCATECOUNT,p_HHCNT,p_AVGSTATECOST,p_AG_PDC_RATE,p_RECENTACTIVITYINDEX,p_ADDRMOSTRECENTINCOMEDIFF,p_PROSPECTBANKINGEXPERIENCE,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_SEARCHADDRSEARCHCOUNT,p_INPUTADDRCRIMEINDEX,p_PREVADDRLENOFRES,p_PROSPECTAGE,p_DIVSSNADDRMSOURCECOUNT,p_VERIFIEDDOB,p_CURRADDRMEDIANINCOME,p_IDVERADDRESSASSOCCOUNT,p_ACCIDENTCOUNT,p_CRTRECSEVERITYINDEX,p_CURRADDRMURDERINDEX,p_RAAPPCURROWNERWTRCRFTMMBRCNT,p_EDUCATIONPROGRAM4YR,p_PREVADDRAVMVALUE,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_ARRESTAGE,p_SOURCERISKLEVEL,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_INPUTADDRERRORCODE,p_INPUTADDRAGELASTSALE,p_INPUTPHONETYPE,p_RAACRTRECEVICTIONMMBRCNT,p_ADDRCHANGECOUNT60,p_HHCRTRECLIENJUDGMMBRCNT,p_INPUTADDRSINGLEFAMILYCOUNT,p_ADDRMOSTRECENTCRIMEDIFF,p_PREVADDRBURGLARYINDEX,p_RAAMEDINCOMERANGE,p_RAAMMBRCNT,p_INPUTADDRBURGLARYINDEX,p_RAACRTRECLIENJUDGMMBRCNT,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_INPUTADDRMEDIANVALUE,p_CURRADDRAGELASTSALE,p_ACCIDENTAGE,p_INPUTADDRVACANTPROPCOUNT,p_PRSEARCHPERSONALFINANCECOUNT,p_NONDEROGCOUNT01,p_PROSPECTESTIMATEDINCOMERANGE,p_RELATIVESCOUNT,p_SUBJECTLASTNAMECOUNT,p_INPUTADDRMEDIANINCOME,p_CURRADDRBURGLARYINDEX_12,p_INPUTPHONESERVICETYPE,p_INPUTADDRPHONECOUNT,p_PROPAGENEWESTPURCHASE,p_RAAELDERLYMMBRCNT,p_RAAPROPOWNERAVMMED,p_ADDRMOSTRECENTMOVEAGE,p_INPUTADDRAGEOLDESTRECORD,p_PRSEARCHOTHERCOUNT24,p_RELATIVESBANKRUPTCYCOUNT,p_CRTRECMSDMEANTIMENEWEST,p_CURRADDRCARTHEFTINDEX,p_PROSPECTTIMEONRECORD,p_PREVADDRCRIMEINDEX,p_HHCRTRECMSDMEANMMBRCNT,p_GENDER,p_INPUTADDRMURDERINDEX,p_PHONEEDAAGEOLDESTRECORD,p_CURRADDRBURGLARYINDEX_24,p_HHPPCURROWNEDAUTOCNT,p_RAACOLLEGEATTENDEDMMBRCNT,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_RAAMIDDLEAGEMMBRCNT,p_SEARCHVELOCITYRISKLEVEL,p_RAACRTRECMMBRCNT,p_RAAPPCURROWNERMMBRCNT,p_AGEOLDESTRECORD,p_PREVADDRMEDIANINCOME,p_INPUTADDRMULTIFAMILYCOUNT,p_ADDRRECENTECONTRAJECTORY,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_INPUTADDRAVMVALUE60,p_PROSPECTTIMELASTUPDATE) := FUNCTIONMACRO
  IMPORT LUCI;
  RPrep := RECORD
    infile;
    HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Append_Model1_ModelLayouts.Prepare;
    HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Append_Model1_ModelLayouts.Working;
  END;
  RPrep PrepareMe(infile le) := TRANSFORM
    SELF.Model1_sc := 1;
    SELF := le;
  END;
  Prepared := PROJECT(infile(do_model),PrepareMe(LEFT));
  rres := RECORD
    infile;
    HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Append_Model1_ModelLayouts.Result;
  END;
// Transform to generate next state
    FieldValFunc(Prepared le,UNSIGNED2 FN) := DEFINE CASE(FN,1 => le.phoneotherageoldestrecord,2 => le.phoneedaagenewestrecord,3 => le.inputaddrbusinesscount,4 => le.inputaddrdwelltype,5 => le.variationrisklevel,6 => le.divaddridentitycount,7 => le.agenewestrecord,8 => le.estimatedannualincome_24,9 => le.raapropcurrownermmbrcnt,10 => le.raaseniormmbrcnt,11 => le.variationdobcount,12 => le.lienfiledage,13 => le.raacrtrecmsdmeanmmbrcnt,14 => le.prevaddragenewestrecord,15 => le.ssnhighissueage,16 => le.propageoldestpurchase,17 => le.prevaddrmedianvalue,18 => le.inputaddrmobilityindex,19 => le.divaddridentitymsourcecount,20 => le.subjectssncount,21 => le.raayoungadultmmbrcnt,22 => le.voterregistrationrecord,23 => le.curraddrcrimeindex,24 => le.phoneidentitiescount,25 => le.prevaddrcartheftindex,26 => le.estimatedannualincome,27 => le.estimatedannualincome_12,28 => le.lifeevtimefirstassetpurchase,29 => le.addrmostrecentvaluediff,30 => le.subjectaddrcount,31 => le.raapropowneravmhighest,32 => le.inputaddrcartheftindex,33 => le.prevaddragelastsale,34 => le.businessinputaddrcount,35 => le.phoneotheragenewestrecord,36 => le.addrchangecount12,37 => le.hhestimatedincomerange,38 => le.curraddrageoldestrecord,39 => le.occproflicensecategory,40 => le.resinputownershipindex,41 => le.age_in_years,42 => le.curraddrburglaryindex,43 => le.crtrecbkrpttimenewest,44 => le.ssnaddrcount,45 => le.relativesdistanceclosest,46 => le.assoccreditbureauonlycount,47 => le.lifeevtimelastassetpurchase,48 => le.correlationrisklevel,49 => le.prsearchlocatecount,50 => le.hhcnt,51 => le.avgstatecost,52 => le.ag_pdc_rate,53 => le.recentactivityindex,54 => le.addrmostrecentincomediff,55 => le.prospectbankingexperience,56 => le.prsearchothercount,57 => le.curraddrmedianvalue,58 => le.searchaddrsearchcount,59 => le.inputaddrcrimeindex,60 => le.prevaddrlenofres,61 => le.prospectage,62 => le.divssnaddrmsourcecount,63 => le.verifieddob,64 => le.curraddrmedianincome,65 => le.idveraddressassoccount,66 => le.accidentcount,67 => le.crtrecseverityindex,68 => le.curraddrmurderindex,69 => le.raappcurrownerwtrcrftmmbrcnt,70 => le.educationprogram4yr,71 => le.prevaddravmvalue,72 => le.variationmsourcesssnunrelcount,73 => le.arrestage,74 => le.sourcerisklevel,75 => le.relativespropownedcount,76 => le.ssnlowissueage,77 => le.inputaddrerrorcode,78 => le.inputaddragelastsale,79 => le.inputphonetype,80 => le.raacrtrecevictionmmbrcnt,81 => le.addrchangecount60,82 => le.hhcrtreclienjudgmmbrcnt,83 => le.inputaddrsinglefamilycount,84 => le.addrmostrecentcrimediff,85 => le.prevaddrburglaryindex,86 => le.raamedincomerange,87 => le.raammbrcnt,88 => le.inputaddrburglaryindex,89 => le.raacrtreclienjudgmmbrcnt,90 => le.assocsuspicousidentitiescount,91 => le.inputaddrmedianvalue,92 => le.curraddragelastsale,93 => le.accidentage,94 => le.inputaddrvacantpropcount,95 => le.prsearchpersonalfinancecount,96 => le.nonderogcount01,97 => le.prospectestimatedincomerange,98 => le.relativescount,99 => le.subjectlastnamecount,100 => le.inputaddrmedianincome,101 => le.curraddrburglaryindex_12,102 => le.inputphoneservicetype,103 => le.inputaddrphonecount,104 => le.propagenewestpurchase,105 => le.raaelderlymmbrcnt,106 => le.raapropowneravmmed,107 => le.addrmostrecentmoveage,108 => le.inputaddrageoldestrecord,109 => le.prsearchothercount24,110 => le.relativesbankruptcycount,111 => le.crtrecmsdmeantimenewest,112 => le.curraddrcartheftindex,113 => le.prospecttimeonrecord,114 => le.prevaddrcrimeindex,115 => le.hhcrtrecmsdmeanmmbrcnt,116 => le.gender,117 => le.inputaddrmurderindex,118 => le.phoneedaageoldestrecord,119 => le.curraddrburglaryindex_24,120 => le.hhppcurrownedautocnt,121 => le.raacollegeattendedmmbrcnt,122 => le.assocrisklevel,123 => le.srcsconfirmidaddrcount,124 => le.searchssnsearchcount,125 => le.raamiddleagemmbrcnt,126 => le.searchvelocityrisklevel,127 => le.raacrtrecmmbrcnt,128 => le.raappcurrownermmbrcnt,129 => le.ageoldestrecord,130 => le.prevaddrmedianincome,131 => le.inputaddrmultifamilycount,132 => le.addrrecentecontrajectory,133 => le.nonderogcount,134 => le.lastnamechangeage,135 => le.inputaddravmvalue60,136 => le.prospecttimelastupdate,0);
    FieldNull(UNSIGNED2 FN) := DEFINE CASE(FN,-999999999);
  rprep tr1_Working(Prepared le) := TRANSFORM
    FieldVal(UNSIGNED n) := FieldValFunc(le,n);
    SELF.State_Score1_Tree1 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree1[le.State_Score1_Tree1].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree1,le.State_Score1_Tree1,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree1[le.State_Score1_Tree1].FieldNumber));
    SELF.State_Score1_Tree2 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree2[le.State_Score1_Tree2].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree2,le.State_Score1_Tree2,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree2[le.State_Score1_Tree2].FieldNumber));
    SELF.State_Score1_Tree3 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree3[le.State_Score1_Tree3].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree3,le.State_Score1_Tree3,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree3[le.State_Score1_Tree3].FieldNumber));
    SELF.State_Score1_Tree4 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree4[le.State_Score1_Tree4].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree4,le.State_Score1_Tree4,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree4[le.State_Score1_Tree4].FieldNumber));
    SELF.State_Score1_Tree5 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree5[le.State_Score1_Tree5].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree5,le.State_Score1_Tree5,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree5[le.State_Score1_Tree5].FieldNumber));
    SELF.State_Score1_Tree6 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree6[le.State_Score1_Tree6].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree6,le.State_Score1_Tree6,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree6[le.State_Score1_Tree6].FieldNumber));
    SELF.State_Score1_Tree7 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree7[le.State_Score1_Tree7].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree7,le.State_Score1_Tree7,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree7[le.State_Score1_Tree7].FieldNumber));
    SELF.State_Score1_Tree8 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree8[le.State_Score1_Tree8].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree8,le.State_Score1_Tree8,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree8[le.State_Score1_Tree8].FieldNumber));
    SELF.State_Score1_Tree9 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree9[le.State_Score1_Tree9].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree9,le.State_Score1_Tree9,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree9[le.State_Score1_Tree9].FieldNumber));
    SELF.State_Score1_Tree10 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree10[le.State_Score1_Tree10].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree10,le.State_Score1_Tree10,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree10[le.State_Score1_Tree10].FieldNumber));
    SELF.State_Score1_Tree11 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree11[le.State_Score1_Tree11].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree11,le.State_Score1_Tree11,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree11[le.State_Score1_Tree11].FieldNumber));
    SELF.State_Score1_Tree12 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree12[le.State_Score1_Tree12].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree12,le.State_Score1_Tree12,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree12[le.State_Score1_Tree12].FieldNumber));
    SELF.State_Score1_Tree13 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree13[le.State_Score1_Tree13].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree13,le.State_Score1_Tree13,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree13[le.State_Score1_Tree13].FieldNumber));
    SELF.State_Score1_Tree14 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree14[le.State_Score1_Tree14].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree14,le.State_Score1_Tree14,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree14[le.State_Score1_Tree14].FieldNumber));
    SELF.State_Score1_Tree15 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree15[le.State_Score1_Tree15].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree15,le.State_Score1_Tree15,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree15[le.State_Score1_Tree15].FieldNumber));
    SELF.State_Score1_Tree16 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree16[le.State_Score1_Tree16].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree16,le.State_Score1_Tree16,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree16[le.State_Score1_Tree16].FieldNumber));
    SELF.State_Score1_Tree17 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree17[le.State_Score1_Tree17].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree17,le.State_Score1_Tree17,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree17[le.State_Score1_Tree17].FieldNumber));
    SELF.State_Score1_Tree18 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree18[le.State_Score1_Tree18].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree18,le.State_Score1_Tree18,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree18[le.State_Score1_Tree18].FieldNumber));
    SELF.State_Score1_Tree19 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree19[le.State_Score1_Tree19].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree19,le.State_Score1_Tree19,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree19[le.State_Score1_Tree19].FieldNumber));
    SELF.State_Score1_Tree20 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree20[le.State_Score1_Tree20].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree20,le.State_Score1_Tree20,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree20[le.State_Score1_Tree20].FieldNumber));
    SELF.State_Score1_Tree21 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree21[le.State_Score1_Tree21].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree21,le.State_Score1_Tree21,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree21[le.State_Score1_Tree21].FieldNumber));
    SELF.State_Score1_Tree22 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree22[le.State_Score1_Tree22].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree22,le.State_Score1_Tree22,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree22[le.State_Score1_Tree22].FieldNumber));
    SELF.State_Score1_Tree23 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree23[le.State_Score1_Tree23].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree23,le.State_Score1_Tree23,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree23[le.State_Score1_Tree23].FieldNumber));
    SELF.State_Score1_Tree24 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree24[le.State_Score1_Tree24].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree24,le.State_Score1_Tree24,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree24[le.State_Score1_Tree24].FieldNumber));
    SELF.State_Score1_Tree25 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree25[le.State_Score1_Tree25].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree25,le.State_Score1_Tree25,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree25[le.State_Score1_Tree25].FieldNumber));
    SELF.State_Score1_Tree26 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree26[le.State_Score1_Tree26].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree26,le.State_Score1_Tree26,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree26[le.State_Score1_Tree26].FieldNumber));
    SELF.State_Score1_Tree27 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree27[le.State_Score1_Tree27].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree27,le.State_Score1_Tree27,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree27[le.State_Score1_Tree27].FieldNumber));
    SELF.State_Score1_Tree28 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree28[le.State_Score1_Tree28].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree28,le.State_Score1_Tree28,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree28[le.State_Score1_Tree28].FieldNumber));
    SELF.State_Score1_Tree29 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree29[le.State_Score1_Tree29].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree29,le.State_Score1_Tree29,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree29[le.State_Score1_Tree29].FieldNumber));
    SELF.State_Score1_Tree30 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree30[le.State_Score1_Tree30].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree30,le.State_Score1_Tree30,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree30[le.State_Score1_Tree30].FieldNumber));
    SELF.State_Score1_Tree31 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree31[le.State_Score1_Tree31].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree31,le.State_Score1_Tree31,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree31[le.State_Score1_Tree31].FieldNumber));
    SELF.State_Score1_Tree32 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree32[le.State_Score1_Tree32].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree32,le.State_Score1_Tree32,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree32[le.State_Score1_Tree32].FieldNumber));
    SELF.State_Score1_Tree33 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree33[le.State_Score1_Tree33].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree33,le.State_Score1_Tree33,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree33[le.State_Score1_Tree33].FieldNumber));
    SELF.State_Score1_Tree34 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree34[le.State_Score1_Tree34].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree34,le.State_Score1_Tree34,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree34[le.State_Score1_Tree34].FieldNumber));
    SELF.State_Score1_Tree35 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree35[le.State_Score1_Tree35].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree35,le.State_Score1_Tree35,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree35[le.State_Score1_Tree35].FieldNumber));
    SELF.State_Score1_Tree36 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree36[le.State_Score1_Tree36].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree36,le.State_Score1_Tree36,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree36[le.State_Score1_Tree36].FieldNumber));
    SELF.State_Score1_Tree37 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree37[le.State_Score1_Tree37].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree37,le.State_Score1_Tree37,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree37[le.State_Score1_Tree37].FieldNumber));
    SELF.State_Score1_Tree38 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree38[le.State_Score1_Tree38].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree38,le.State_Score1_Tree38,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree38[le.State_Score1_Tree38].FieldNumber));
    SELF.State_Score1_Tree39 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree39[le.State_Score1_Tree39].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree39,le.State_Score1_Tree39,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree39[le.State_Score1_Tree39].FieldNumber));
    SELF.State_Score1_Tree40 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree40[le.State_Score1_Tree40].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree40,le.State_Score1_Tree40,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree40[le.State_Score1_Tree40].FieldNumber));
    SELF.State_Score1_Tree41 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree41[le.State_Score1_Tree41].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree41,le.State_Score1_Tree41,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree41[le.State_Score1_Tree41].FieldNumber));
    SELF.State_Score1_Tree42 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree42[le.State_Score1_Tree42].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree42,le.State_Score1_Tree42,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree42[le.State_Score1_Tree42].FieldNumber));
    SELF.State_Score1_Tree43 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree43[le.State_Score1_Tree43].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree43,le.State_Score1_Tree43,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree43[le.State_Score1_Tree43].FieldNumber));
    SELF.State_Score1_Tree44 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree44[le.State_Score1_Tree44].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree44,le.State_Score1_Tree44,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree44[le.State_Score1_Tree44].FieldNumber));
    SELF.State_Score1_Tree45 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree45[le.State_Score1_Tree45].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree45,le.State_Score1_Tree45,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree45[le.State_Score1_Tree45].FieldNumber));
    SELF.State_Score1_Tree46 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree46[le.State_Score1_Tree46].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree46,le.State_Score1_Tree46,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree46[le.State_Score1_Tree46].FieldNumber));
    SELF.State_Score1_Tree47 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree47[le.State_Score1_Tree47].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree47,le.State_Score1_Tree47,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree47[le.State_Score1_Tree47].FieldNumber));
    SELF.State_Score1_Tree48 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree48[le.State_Score1_Tree48].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree48,le.State_Score1_Tree48,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree48[le.State_Score1_Tree48].FieldNumber));
    SELF.State_Score1_Tree49 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree49[le.State_Score1_Tree49].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree49,le.State_Score1_Tree49,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree49[le.State_Score1_Tree49].FieldNumber));
    SELF.State_Score1_Tree50 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree50[le.State_Score1_Tree50].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree50,le.State_Score1_Tree50,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree50[le.State_Score1_Tree50].FieldNumber));
    SELF.State_Score1_Tree51 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree51[le.State_Score1_Tree51].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree51,le.State_Score1_Tree51,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree51[le.State_Score1_Tree51].FieldNumber));
    SELF.State_Score1_Tree52 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree52[le.State_Score1_Tree52].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree52,le.State_Score1_Tree52,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree52[le.State_Score1_Tree52].FieldNumber));
    SELF.State_Score1_Tree53 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree53[le.State_Score1_Tree53].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree53,le.State_Score1_Tree53,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree53[le.State_Score1_Tree53].FieldNumber));
    SELF.State_Score1_Tree54 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree54[le.State_Score1_Tree54].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree54,le.State_Score1_Tree54,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree54[le.State_Score1_Tree54].FieldNumber));
    SELF.State_Score1_Tree55 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree55[le.State_Score1_Tree55].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree55,le.State_Score1_Tree55,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree55[le.State_Score1_Tree55].FieldNumber));
    SELF.State_Score1_Tree56 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree56[le.State_Score1_Tree56].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree56,le.State_Score1_Tree56,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree56[le.State_Score1_Tree56].FieldNumber));
    SELF.State_Score1_Tree57 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree57[le.State_Score1_Tree57].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree57,le.State_Score1_Tree57,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree57[le.State_Score1_Tree57].FieldNumber));
    SELF.State_Score1_Tree58 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree58[le.State_Score1_Tree58].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree58,le.State_Score1_Tree58,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree58[le.State_Score1_Tree58].FieldNumber));
    SELF.State_Score1_Tree59 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree59[le.State_Score1_Tree59].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree59,le.State_Score1_Tree59,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree59[le.State_Score1_Tree59].FieldNumber));
    SELF.State_Score1_Tree60 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree60[le.State_Score1_Tree60].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree60,le.State_Score1_Tree60,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree60[le.State_Score1_Tree60].FieldNumber));
    SELF.State_Score1_Tree61 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree61[le.State_Score1_Tree61].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree61,le.State_Score1_Tree61,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree61[le.State_Score1_Tree61].FieldNumber));
    SELF.State_Score1_Tree62 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree62[le.State_Score1_Tree62].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree62,le.State_Score1_Tree62,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree62[le.State_Score1_Tree62].FieldNumber));
    SELF.State_Score1_Tree63 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree63[le.State_Score1_Tree63].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree63,le.State_Score1_Tree63,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree63[le.State_Score1_Tree63].FieldNumber));
    SELF.State_Score1_Tree64 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree64[le.State_Score1_Tree64].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree64,le.State_Score1_Tree64,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree64[le.State_Score1_Tree64].FieldNumber));
    SELF.State_Score1_Tree65 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree65[le.State_Score1_Tree65].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree65,le.State_Score1_Tree65,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree65[le.State_Score1_Tree65].FieldNumber));
    SELF.State_Score1_Tree66 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree66[le.State_Score1_Tree66].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree66,le.State_Score1_Tree66,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree66[le.State_Score1_Tree66].FieldNumber));
    SELF.State_Score1_Tree67 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree67[le.State_Score1_Tree67].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree67,le.State_Score1_Tree67,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree67[le.State_Score1_Tree67].FieldNumber));
    SELF.State_Score1_Tree68 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree68[le.State_Score1_Tree68].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree68,le.State_Score1_Tree68,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree68[le.State_Score1_Tree68].FieldNumber));
    SELF.State_Score1_Tree69 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree69[le.State_Score1_Tree69].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree69,le.State_Score1_Tree69,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree69[le.State_Score1_Tree69].FieldNumber));
    SELF.State_Score1_Tree70 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree70[le.State_Score1_Tree70].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree70,le.State_Score1_Tree70,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree70[le.State_Score1_Tree70].FieldNumber));
    SELF.State_Score1_Tree71 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree71[le.State_Score1_Tree71].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree71,le.State_Score1_Tree71,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree71[le.State_Score1_Tree71].FieldNumber));
    SELF.State_Score1_Tree72 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree72[le.State_Score1_Tree72].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree72,le.State_Score1_Tree72,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree72[le.State_Score1_Tree72].FieldNumber));
    SELF.State_Score1_Tree73 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree73[le.State_Score1_Tree73].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree73,le.State_Score1_Tree73,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree73[le.State_Score1_Tree73].FieldNumber));
    SELF.State_Score1_Tree74 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree74[le.State_Score1_Tree74].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree74,le.State_Score1_Tree74,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree74[le.State_Score1_Tree74].FieldNumber));
    SELF.State_Score1_Tree75 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree75[le.State_Score1_Tree75].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree75,le.State_Score1_Tree75,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree75[le.State_Score1_Tree75].FieldNumber));
    SELF.State_Score1_Tree76 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree76[le.State_Score1_Tree76].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree76,le.State_Score1_Tree76,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree76[le.State_Score1_Tree76].FieldNumber));
    SELF.State_Score1_Tree77 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree77[le.State_Score1_Tree77].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree77,le.State_Score1_Tree77,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree77[le.State_Score1_Tree77].FieldNumber));
    SELF.State_Score1_Tree78 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree78[le.State_Score1_Tree78].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree78,le.State_Score1_Tree78,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree78[le.State_Score1_Tree78].FieldNumber));
    SELF.State_Score1_Tree79 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree79[le.State_Score1_Tree79].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree79,le.State_Score1_Tree79,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree79[le.State_Score1_Tree79].FieldNumber));
    SELF.State_Score1_Tree80 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree80[le.State_Score1_Tree80].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree80,le.State_Score1_Tree80,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree80[le.State_Score1_Tree80].FieldNumber));
    SELF.State_Score1_Tree81 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree81[le.State_Score1_Tree81].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree81,le.State_Score1_Tree81,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree81[le.State_Score1_Tree81].FieldNumber));
    SELF.State_Score1_Tree82 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree82[le.State_Score1_Tree82].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree82,le.State_Score1_Tree82,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree82[le.State_Score1_Tree82].FieldNumber));
    SELF.State_Score1_Tree83 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree83[le.State_Score1_Tree83].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree83,le.State_Score1_Tree83,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree83[le.State_Score1_Tree83].FieldNumber));
    SELF.State_Score1_Tree84 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree84[le.State_Score1_Tree84].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree84,le.State_Score1_Tree84,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree84[le.State_Score1_Tree84].FieldNumber));
    SELF.State_Score1_Tree85 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree85[le.State_Score1_Tree85].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree85,le.State_Score1_Tree85,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree85[le.State_Score1_Tree85].FieldNumber));
    SELF.State_Score1_Tree86 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree86[le.State_Score1_Tree86].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree86,le.State_Score1_Tree86,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree86[le.State_Score1_Tree86].FieldNumber));
    SELF.State_Score1_Tree87 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree87[le.State_Score1_Tree87].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree87,le.State_Score1_Tree87,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree87[le.State_Score1_Tree87].FieldNumber));
    SELF.State_Score1_Tree88 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree88[le.State_Score1_Tree88].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree88,le.State_Score1_Tree88,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree88[le.State_Score1_Tree88].FieldNumber));
    SELF.State_Score1_Tree89 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree89[le.State_Score1_Tree89].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree89,le.State_Score1_Tree89,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree89[le.State_Score1_Tree89].FieldNumber));
    SELF.State_Score1_Tree90 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree90[le.State_Score1_Tree90].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree90,le.State_Score1_Tree90,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree90[le.State_Score1_Tree90].FieldNumber));
    SELF.State_Score1_Tree91 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree91[le.State_Score1_Tree91].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree91,le.State_Score1_Tree91,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree91[le.State_Score1_Tree91].FieldNumber));
    SELF.State_Score1_Tree92 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree92[le.State_Score1_Tree92].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree92,le.State_Score1_Tree92,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree92[le.State_Score1_Tree92].FieldNumber));
    SELF.State_Score1_Tree93 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree93[le.State_Score1_Tree93].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree93,le.State_Score1_Tree93,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree93[le.State_Score1_Tree93].FieldNumber));
    SELF.State_Score1_Tree94 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree94[le.State_Score1_Tree94].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree94,le.State_Score1_Tree94,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree94[le.State_Score1_Tree94].FieldNumber));
    SELF.State_Score1_Tree95 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree95[le.State_Score1_Tree95].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree95,le.State_Score1_Tree95,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree95[le.State_Score1_Tree95].FieldNumber));
    SELF.State_Score1_Tree96 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree96[le.State_Score1_Tree96].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree96,le.State_Score1_Tree96,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree96[le.State_Score1_Tree96].FieldNumber));
    SELF.State_Score1_Tree97 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree97[le.State_Score1_Tree97].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree97,le.State_Score1_Tree97,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree97[le.State_Score1_Tree97].FieldNumber));
    SELF.State_Score1_Tree98 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree98[le.State_Score1_Tree98].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree98,le.State_Score1_Tree98,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree98[le.State_Score1_Tree98].FieldNumber));
    SELF.State_Score1_Tree99 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree99[le.State_Score1_Tree99].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree99,le.State_Score1_Tree99,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree99[le.State_Score1_Tree99].FieldNumber));
    SELF.State_Score1_Tree100 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree100[le.State_Score1_Tree100].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree100,le.State_Score1_Tree100,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree100[le.State_Score1_Tree100].FieldNumber));
    SELF.State_Score1_Tree101 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree101[le.State_Score1_Tree101].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree101,le.State_Score1_Tree101,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree101[le.State_Score1_Tree101].FieldNumber));
    SELF.State_Score1_Tree102 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree102[le.State_Score1_Tree102].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree102,le.State_Score1_Tree102,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree102[le.State_Score1_Tree102].FieldNumber));
    SELF.State_Score1_Tree103 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree103[le.State_Score1_Tree103].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree103,le.State_Score1_Tree103,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree103[le.State_Score1_Tree103].FieldNumber));
    SELF.State_Score1_Tree104 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree104[le.State_Score1_Tree104].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree104,le.State_Score1_Tree104,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree104[le.State_Score1_Tree104].FieldNumber));
    SELF.State_Score1_Tree105 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree105[le.State_Score1_Tree105].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree105,le.State_Score1_Tree105,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree105[le.State_Score1_Tree105].FieldNumber));
    SELF.State_Score1_Tree106 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree106[le.State_Score1_Tree106].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree106,le.State_Score1_Tree106,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree106[le.State_Score1_Tree106].FieldNumber));
    SELF.State_Score1_Tree107 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree107[le.State_Score1_Tree107].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree107,le.State_Score1_Tree107,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree107[le.State_Score1_Tree107].FieldNumber));
    SELF.State_Score1_Tree108 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree108[le.State_Score1_Tree108].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree108,le.State_Score1_Tree108,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree108[le.State_Score1_Tree108].FieldNumber));
    SELF.State_Score1_Tree109 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree109[le.State_Score1_Tree109].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree109,le.State_Score1_Tree109,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree109[le.State_Score1_Tree109].FieldNumber));
    SELF.State_Score1_Tree110 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree110[le.State_Score1_Tree110].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree110,le.State_Score1_Tree110,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree110[le.State_Score1_Tree110].FieldNumber));
    SELF.State_Score1_Tree111 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree111[le.State_Score1_Tree111].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree111,le.State_Score1_Tree111,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree111[le.State_Score1_Tree111].FieldNumber));
    SELF.State_Score1_Tree112 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree112[le.State_Score1_Tree112].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree112,le.State_Score1_Tree112,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree112[le.State_Score1_Tree112].FieldNumber));
    SELF.State_Score1_Tree113 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree113[le.State_Score1_Tree113].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree113,le.State_Score1_Tree113,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree113[le.State_Score1_Tree113].FieldNumber));
    SELF.State_Score1_Tree114 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree114[le.State_Score1_Tree114].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree114,le.State_Score1_Tree114,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree114[le.State_Score1_Tree114].FieldNumber));
    SELF.State_Score1_Tree115 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree115[le.State_Score1_Tree115].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree115,le.State_Score1_Tree115,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree115[le.State_Score1_Tree115].FieldNumber));
    SELF.State_Score1_Tree116 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree116[le.State_Score1_Tree116].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree116,le.State_Score1_Tree116,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree116[le.State_Score1_Tree116].FieldNumber));
    SELF.State_Score1_Tree117 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree117[le.State_Score1_Tree117].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree117,le.State_Score1_Tree117,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree117[le.State_Score1_Tree117].FieldNumber));
    SELF.State_Score1_Tree118 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree118[le.State_Score1_Tree118].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree118,le.State_Score1_Tree118,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree118[le.State_Score1_Tree118].FieldNumber));
    SELF.State_Score1_Tree119 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree119[le.State_Score1_Tree119].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree119,le.State_Score1_Tree119,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree119[le.State_Score1_Tree119].FieldNumber));
    SELF.State_Score1_Tree120 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree120[le.State_Score1_Tree120].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree120,le.State_Score1_Tree120,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree120[le.State_Score1_Tree120].FieldNumber));
    SELF.State_Score1_Tree121 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree121[le.State_Score1_Tree121].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree121,le.State_Score1_Tree121,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree121[le.State_Score1_Tree121].FieldNumber));
    SELF.State_Score1_Tree122 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree122[le.State_Score1_Tree122].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree122,le.State_Score1_Tree122,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree122[le.State_Score1_Tree122].FieldNumber));
    SELF.State_Score1_Tree123 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree123[le.State_Score1_Tree123].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree123,le.State_Score1_Tree123,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree123[le.State_Score1_Tree123].FieldNumber));
    SELF.State_Score1_Tree124 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree124[le.State_Score1_Tree124].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree124,le.State_Score1_Tree124,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree124[le.State_Score1_Tree124].FieldNumber));
    SELF.State_Score1_Tree125 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree125[le.State_Score1_Tree125].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree125,le.State_Score1_Tree125,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree125[le.State_Score1_Tree125].FieldNumber));
    SELF.State_Score1_Tree126 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree126[le.State_Score1_Tree126].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree126,le.State_Score1_Tree126,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree126[le.State_Score1_Tree126].FieldNumber));
    SELF.State_Score1_Tree127 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree127[le.State_Score1_Tree127].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree127,le.State_Score1_Tree127,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree127[le.State_Score1_Tree127].FieldNumber));
    SELF.State_Score1_Tree128 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree128[le.State_Score1_Tree128].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree128,le.State_Score1_Tree128,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree128[le.State_Score1_Tree128].FieldNumber));
    SELF.State_Score1_Tree129 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree129[le.State_Score1_Tree129].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree129,le.State_Score1_Tree129,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree129[le.State_Score1_Tree129].FieldNumber));
    SELF.State_Score1_Tree130 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree130[le.State_Score1_Tree130].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree130,le.State_Score1_Tree130,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree130[le.State_Score1_Tree130].FieldNumber));
    SELF.State_Score1_Tree131 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree131[le.State_Score1_Tree131].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree131,le.State_Score1_Tree131,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree131[le.State_Score1_Tree131].FieldNumber));
    SELF.State_Score1_Tree132 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree132[le.State_Score1_Tree132].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree132,le.State_Score1_Tree132,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree132[le.State_Score1_Tree132].FieldNumber));
    SELF.State_Score1_Tree133 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree133[le.State_Score1_Tree133].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree133,le.State_Score1_Tree133,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree133[le.State_Score1_Tree133].FieldNumber));
    SELF.State_Score1_Tree134 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree134[le.State_Score1_Tree134].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree134,le.State_Score1_Tree134,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree134[le.State_Score1_Tree134].FieldNumber));
    SELF.State_Score1_Tree135 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree135[le.State_Score1_Tree135].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree135,le.State_Score1_Tree135,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree135[le.State_Score1_Tree135].FieldNumber));
    SELF.State_Score1_Tree136 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree136[le.State_Score1_Tree136].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree136,le.State_Score1_Tree136,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree136[le.State_Score1_Tree136].FieldNumber));
    SELF.State_Score1_Tree137 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree137[le.State_Score1_Tree137].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree137,le.State_Score1_Tree137,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree137[le.State_Score1_Tree137].FieldNumber));
    SELF.State_Score1_Tree138 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree138[le.State_Score1_Tree138].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree138,le.State_Score1_Tree138,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree138[le.State_Score1_Tree138].FieldNumber));
    SELF.State_Score1_Tree139 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree139[le.State_Score1_Tree139].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree139,le.State_Score1_Tree139,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree139[le.State_Score1_Tree139].FieldNumber));
    SELF.State_Score1_Tree140 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree140[le.State_Score1_Tree140].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree140,le.State_Score1_Tree140,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree140[le.State_Score1_Tree140].FieldNumber));
    SELF.State_Score1_Tree141 := LUCI.ComputeCATEGORICNode( FieldVal(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree141[le.State_Score1_Tree141].FieldNumber),HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree141,le.State_Score1_Tree141,FieldNull(HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree141[le.State_Score1_Tree141].FieldNumber));
    SELF := le;
  END;
  Computed1 := LOOP ( Prepared(Model1_sc =1),12,PROJECT(ROWS(LEFT),tr1_Working(LEFT)));
// Transform to compute result
  rres tr1(Computed1 le) := TRANSFORM
    REAL Model1_Score1_Score0 := 0.7698942643734032 + LUCI.aggADD([
			HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree1[le.State_Score1_Tree1].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree2[le.State_Score1_Tree2].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree3[le.State_Score1_Tree3].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree4[le.State_Score1_Tree4].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree5[le.State_Score1_Tree5].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree6[le.State_Score1_Tree6].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree7[le.State_Score1_Tree7].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree8[le.State_Score1_Tree8].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree9[le.State_Score1_Tree9].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree10[le.State_Score1_Tree10].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree11[le.State_Score1_Tree11].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree12[le.State_Score1_Tree12].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree13[le.State_Score1_Tree13].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree14[le.State_Score1_Tree14].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree15[le.State_Score1_Tree15].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree16[le.State_Score1_Tree16].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree17[le.State_Score1_Tree17].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree18[le.State_Score1_Tree18].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree19[le.State_Score1_Tree19].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree20[le.State_Score1_Tree20].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree21[le.State_Score1_Tree21].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree22[le.State_Score1_Tree22].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree23[le.State_Score1_Tree23].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree24[le.State_Score1_Tree24].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree25[le.State_Score1_Tree25].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree26[le.State_Score1_Tree26].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree27[le.State_Score1_Tree27].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree28[le.State_Score1_Tree28].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree29[le.State_Score1_Tree29].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree30[le.State_Score1_Tree30].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree31[le.State_Score1_Tree31].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree32[le.State_Score1_Tree32].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree33[le.State_Score1_Tree33].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree34[le.State_Score1_Tree34].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree35[le.State_Score1_Tree35].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree36[le.State_Score1_Tree36].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree37[le.State_Score1_Tree37].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree38[le.State_Score1_Tree38].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree39[le.State_Score1_Tree39].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree40[le.State_Score1_Tree40].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree41[le.State_Score1_Tree41].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree42[le.State_Score1_Tree42].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree43[le.State_Score1_Tree43].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree44[le.State_Score1_Tree44].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree45[le.State_Score1_Tree45].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree46[le.State_Score1_Tree46].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree47[le.State_Score1_Tree47].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree48[le.State_Score1_Tree48].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree49[le.State_Score1_Tree49].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree50[le.State_Score1_Tree50].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree51[le.State_Score1_Tree51].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree52[le.State_Score1_Tree52].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree53[le.State_Score1_Tree53].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree54[le.State_Score1_Tree54].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree55[le.State_Score1_Tree55].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree56[le.State_Score1_Tree56].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree57[le.State_Score1_Tree57].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree58[le.State_Score1_Tree58].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree59[le.State_Score1_Tree59].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree60[le.State_Score1_Tree60].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree61[le.State_Score1_Tree61].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree62[le.State_Score1_Tree62].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree63[le.State_Score1_Tree63].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree64[le.State_Score1_Tree64].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree65[le.State_Score1_Tree65].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree66[le.State_Score1_Tree66].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree67[le.State_Score1_Tree67].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree68[le.State_Score1_Tree68].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree69[le.State_Score1_Tree69].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree70[le.State_Score1_Tree70].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree71[le.State_Score1_Tree71].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree72[le.State_Score1_Tree72].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree73[le.State_Score1_Tree73].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree74[le.State_Score1_Tree74].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree75[le.State_Score1_Tree75].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree76[le.State_Score1_Tree76].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree77[le.State_Score1_Tree77].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree78[le.State_Score1_Tree78].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree79[le.State_Score1_Tree79].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree80[le.State_Score1_Tree80].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree81[le.State_Score1_Tree81].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree82[le.State_Score1_Tree82].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree83[le.State_Score1_Tree83].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree84[le.State_Score1_Tree84].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree85[le.State_Score1_Tree85].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree86[le.State_Score1_Tree86].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree87[le.State_Score1_Tree87].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree88[le.State_Score1_Tree88].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree89[le.State_Score1_Tree89].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree90[le.State_Score1_Tree90].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree91[le.State_Score1_Tree91].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree92[le.State_Score1_Tree92].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree93[le.State_Score1_Tree93].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree94[le.State_Score1_Tree94].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree95[le.State_Score1_Tree95].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree96[le.State_Score1_Tree96].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree97[le.State_Score1_Tree97].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree98[le.State_Score1_Tree98].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree99[le.State_Score1_Tree99].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree100[le.State_Score1_Tree100].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree101[le.State_Score1_Tree101].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree102[le.State_Score1_Tree102].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree103[le.State_Score1_Tree103].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree104[le.State_Score1_Tree104].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree105[le.State_Score1_Tree105].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree106[le.State_Score1_Tree106].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree107[le.State_Score1_Tree107].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree108[le.State_Score1_Tree108].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree109[le.State_Score1_Tree109].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree110[le.State_Score1_Tree110].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree111[le.State_Score1_Tree111].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree112[le.State_Score1_Tree112].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree113[le.State_Score1_Tree113].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree114[le.State_Score1_Tree114].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree115[le.State_Score1_Tree115].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree116[le.State_Score1_Tree116].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree117[le.State_Score1_Tree117].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree118[le.State_Score1_Tree118].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree119[le.State_Score1_Tree119].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree120[le.State_Score1_Tree120].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree121[le.State_Score1_Tree121].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree122[le.State_Score1_Tree122].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree123[le.State_Score1_Tree123].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree124[le.State_Score1_Tree124].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree125[le.State_Score1_Tree125].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree126[le.State_Score1_Tree126].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree127[le.State_Score1_Tree127].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree128[le.State_Score1_Tree128].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree129[le.State_Score1_Tree129].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree130[le.State_Score1_Tree130].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree131[le.State_Score1_Tree131].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree132[le.State_Score1_Tree132].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree133[le.State_Score1_Tree133].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree134[le.State_Score1_Tree134].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree135[le.State_Score1_Tree135].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree136[le.State_Score1_Tree136].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree137[le.State_Score1_Tree137].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree138[le.State_Score1_Tree138].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree139[le.State_Score1_Tree139].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree140[le.State_Score1_Tree140].Number
			,
HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.Model1_Score1_Tree141[le.State_Score1_Tree141].Number
			]);
    REAL Model1_Score1_Score1 := Model1_Score1_Score0;
    REAL Model1_Score1_Score := Model1_Score1_Score1;
    SELF.Model1_Score := Model1_Score1_Score;
    SELF.Model1_Reasons := [];
    SELF := le;
  END;
  RETURN PROJECT(infile(~do_model),rres)+PROJECT( Computed1,Tr1(LEFT));
ENDMACRO;
