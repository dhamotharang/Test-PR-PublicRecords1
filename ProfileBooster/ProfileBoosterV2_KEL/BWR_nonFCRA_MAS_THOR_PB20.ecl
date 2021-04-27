﻿#WORKUNIT('name', 'NonFCRA MAS THOR ProfileBoosterV1.1');
#OPTION('expandSelectCreateRow', true);
#OPTION('outputLimit', 2000);
#OPTION('outputLimitMb', 1000);
#OPTION('splitterSpill', 1);
#OPTION('multiplePersistInstances',FALSE);
// #OPTION('defaultSkewError', 1);

//Ensure to check the RecordsToRun below to see if that is how many you want to run. 

IMPORT ProfileBooster.ProfileBoosterV2_KEL, ProfileBooster, STD, Risk_Indicators;
IMPORT KEL12 AS KEL;

	InputFile := '~jfrancis::out::profilebooster20_sample_100k_qa_clean__w20210401-153001';
  headerRecords := 1; // Number of header rows on the input file
  prii_layout := RECORD
  string30 acctno;
  unsigned6 seq;
  unsigned6 lexid;
  string6 verdonotmailflag;
  string6 verprospectfoundflag;
  string6 verinpnameindx;
  string6 verinpssnflag;
  string6 verinpphoneflag;
  string6 verinpaddrmatchindx;
  string6 verinpemailflag;
  string6 demupdtoldmsnc;
  string6 demupdtnewmsnc;
  string6 demupdtflag1y;
  string6 demage;
  string6 demgender;
  string6 demismarriedflag;
  string6 demestinc;
  string6 demdeceasedflag;
  integer3 demeducollcurrflag;
  integer3 demeducollflagev;
  integer3 demeducollnewlevelev;
  integer3 demeducollnewpvtflag;
  integer3 demeducollnewtierindx;
  integer3 demeducolllevelhighev;
  string6 demeducollrecnewinsttypeev;
  integer3 demeducolltierhighev;
  integer3 demeducollrecnewmajortypeev;
  integer3 demeducollevidflagev;
  integer3 demeducollsrcnewrecoldmsncev;
  integer3 demeducollsrcnewrecnewmsncev;
  integer3 demeducollrecspanev;
  integer3 demeducollrecnewclassev;
  integer3 demeducollsrcnewexpgradyr;
  integer3 demeducollinstpvtflagev;
  integer3 demeducollmajormedicalflagev;
  integer3 demeducollmajorphyssciflagev;
  integer3 demeducollmajorsocsciflagev;
  integer3 demeducollmajorlibartsflagev;
  integer3 demeducollmajortechnicalflagev;
  integer3 demeducollmajorbusflagev;
  integer3 demeducollmajoreduflagev;
  integer3 demeducollmajorlawflagev;
  string6 dembankingindx;
  integer3 intsportpersonflagev;
  integer3 intsportpersonflag1y;
  integer3 intsportpersonflag5y;
  integer3 intsportpersontravelerflagev;
  integer3 lifemovenewmsnc;
  integer3 lifenamelastchngflag;
  integer3 lifenamelastchngflag1y;
  integer3 lifenamelastcntev;
  integer3 lifenamelastchngnewmsnc;
  integer3 lifeastpurcholdmsnc;
  integer3 lifeastpurchnewmsnc;
  integer3 lifeaddrcnt;
  string6 lifeaddrcurrtoprevvalratio5y;
  integer3 lifeaddrecontrajtype;
  integer3 lifeaddrecontrajindx;
  integer3 astcurrflag;
  integer3 astpropcurrflag;
  integer3 astpropcurrcntev;
  integer4 astpropcurrvaltot;
  integer4 astpropcurravmtot;
  integer3 astpropsalenewmsnc;
  integer3 astpropcntev;
  integer3 astpropsoldcntev;
  integer3 astpropsoldcnt1y;
  string6 astpropsoldnewratio;
  integer3 astproppurchcnt1y;
  integer3 astpropaircrftcntev;
  integer3 astpropwtrcrftcntev;
  integer3 curraddrownershipindx;
  integer3 curraddrhaspoolflag;
  integer3 curraddrismobilehomeflag;
  integer3 curraddrbathcnt;
  integer3 curraddrparkingcnt;
  integer3 curraddrbuildyr;
  integer3 curraddrbedcnt;
  integer3 curraddrbldgsize;
  string curraddrlat;
  string curraddrlng;
  integer3 curraddriscollegeflag;
  integer3 curraddravmval;
  integer3 curraddravmvala1y;
  string curraddravmratio1y;
  integer3 curraddravmvala5y;
  string curraddravmratio5y;
  string curraddrmedavmctyratio;
  string curraddrmedavmcentractratio;
  string curraddrmedavmcenblockratio;
  string6 curraddrtype;
  integer3 curraddrtypeindx;
  integer3 curraddrbusregcnt;
  integer3 curraddrisvacantflag;
  integer3 curraddrstatus;
  integer3 curraddrisaptflag;
  integer3 purchnewamt;
  integer3 purchtotev;
  integer3 purchcntev;
  integer3 purchnewmsnc;
  integer3 purcholdmsnc;
  integer3 purchitemcntev;
  integer3 purchamtavg;
  integer3 astvehautocntev;
  integer3 astvehautocarcntev;
  integer3 astvehautosuvcntev;
  integer3 astvehautotruckcntev;
  integer3 astvehautovancntev;
  integer3 astvehautonewtypeindx;
  integer3 astvehautoexpcntev;
  integer3 astvehautoelitecntev;
  integer3 astvehautoluxurycntev;
  integer3 astvehautoorigowncntev;
  integer3 astvehautomakecntev;
  string astvehautofreqmake;
  integer3 astvehautofreqmakecntev;
  string astvehauto2ndfreqmake;
  integer3 astvehauto2ndfreqmakecntev;
  integer3 astvehautoemrgpriceavg;
  integer3 astvehautoemrgpricemax;
  integer3 astvehautoemrgpricemin;
  integer3 astvehautonewprice;
  integer3 astvehautoemrgpricediff;
  integer3 astvehautolastageavg;
  integer3 astvehautolastagemax;
  integer3 astvehautolastagemin;
  integer3 astvehautoemrgageavg;
  integer3 astvehautoemrgagemax;
  integer3 astvehautoemrgagemin;
  integer3 astvehautoemrgspanavg;
  integer3 astvehautonewmsnc;
  integer3 astvehautotimeownspanavg;
  integer3 astvehothercntev;
  integer3 astvehotheratvcntev;
  integer3 astvehothercampercntev;
  integer3 astvehothercommcntev;
  integer3 astvehothermtrcntev;
  integer3 astvehotherscootercntev;
  integer3 astvehothernewtypeindx;
  integer3 astvehotherorigowncntev;
  integer3 astvehothernewmsnc;
  integer3 astvehotherpriceavg;
  integer3 astvehotherpricemax;
  integer3 astvehotherpricemin;
  integer3 astvehothernewprice;
  integer3 proflicflagev;
  integer3 proflicactivnewindx;
  integer3 busassocflagev;
  integer3 busassocoldmsnc;
  integer3 busleadershiptitleflag;
  integer3 busassoccntev;
  string6 proflicactvnewtitletype;
  integer3 busuccfilingcntev;
  integer3 busuccfilingactivecnt;
  integer3 emrgage;
  integer3 emrgatorafter21flag;
  string6 emrgrecordtype;
  string6 emrgaddrtype;
  integer3 emrglexidsatemrgaddrcnt1y;
  integer3 emrgage25to59flag;
  string emrgdob;
  string2 emrgsrc;
  unsigned6 emrgdt_first_seen;
  string emrgaddrfull;
  string10 emrgprimaryrange;
  string6 emrgpredirectional;
  string28 emrgprimaryname;
  string6 emrgsuffix;
  string6 emrgpostdirectional;
  string10 emrgunitdesignation;
  string8 emrgsecondaryrange;
  string6 emrgzip5;
  string6 emrgzip4;
  string25 emrgcity_name;
  string6 emrgst;
  integer3 drgcnt7y;
  integer3 drgseverityindx7y;
  integer3 drgcnt1y;
  integer3 drgnewmsnc7y;
  integer3 drgcrimfelcnt7y;
  integer3 drgcrimfelcnt1y;
  integer3 drgcrimfelnewmsnc7y;
  integer3 drgcrimnfelcnt7y;
  integer3 drgcrimnfelcnt1y;
  integer3 drgcrimnfelnewmsnc7y;
  integer3 drgevictcnt7y;
  integer3 drgevictcnt1y;
  integer3 drgevictnewmsnc7y;
  integer3 drglnjcnt7y;
  integer3 drglnjcnt1y;
  integer3 drglnjnewmsnc7y;
  integer4 drglnjamttot7y;
  integer3 drgbkcnt10y;
  integer3 drgbkcnt1y;
  integer3 drgbknewmsnc10y;
  integer3 shorttermshopnewmsnc;
  integer3 shorttermshopoldmsnc;
  integer3 shorttermshopcntev;
  integer3 shorttermshopcnt6m;
  integer3 shorttermshopcnt5y;
  integer3 shorttermshopcnt1y;
  integer3 inpaddrownershipindx;
  integer3 inpaddrhaspoolflag;
  integer3 inpaddrismobilehomeflag;
  integer3 inpaddrbathcnt;
  integer3 inpaddrparkingcnt;
  integer3 inpaddrbuildyr;
  integer3 inpaddrbedcnt;
  integer4 inpaddrbldgsize;
  string inpaddrlat;
  string inpaddrlng;
  integer3 inpaddriscollegeflag;
  integer8 inpaddravmval;
  integer8 inpaddravmvala1y;
  string7 inpaddravmratio1y;
  integer8 inpaddravmvala5y;
  string7 inpaddravmratio5y;
  string7 inpaddrmedavmctyratio;
  string7 inpaddrmedavmcentractratio;
  string7 inpaddrmedavmcenblockratio;
  string6 inpaddrtype;
  integer3 inpaddrtypeindex;
  integer3 inpaddrbusregcnt;
  integer3 inpaddrisvacantflag;
  integer3 inpaddrisaptflag;
  integer4 hhid;
  integer3 hhteenagermmbrcnt;
  integer3 hhyoungadultmmbrcnt;
  integer3 hhmiddleagemmbrcnt;
  integer3 hhseniormmbrcnt;
  integer3 hhelderlymmbrcnt;
  integer3 hhmmbragemed;
  integer3 hhmmbrageavg;
  integer3 hhcomplextotalcnt;
  integer3 hhunitsincomplexcnt;
  integer3 hhmmbrcnt;
  integer3 hhestimatedincometotal;
  integer3 hhestimatedincomeavg;
  integer3 hhmmbrweducollcnt;
  integer3 hhmmbrweducollevidevcnt;
  integer3 hhmmbrweducoll2yrcnt;
  integer3 hhmmbrweducoll4yrcnt;
  integer3 hhmmbrweducollgradcnt;
  integer3 hhmmbrwcollpvtcnt;
  integer3 hhmmbrcolltierhighest;
  integer3 hhmmbrcolltieravg;
  integer3 hhmmbrwastpropcurrcnt;
  integer3 hhastpropcurrcnt;
  integer4 hhmmbrpropavmmax;
  integer5 hhmmbrpropavmavg;
  integer5 hhmmbrpropavmttl;
  integer4 hhmemberpropavmttl1y;
  integer4 hhmemberpropavmttl5y;
  integer3 hhvehicleownedcnt;
  integer3 hhautoownedcnt;
  integer3 hhmotorcycleownedcnt;
  integer3 hhaircraftownedcnt;
  integer3 hhwatercraftownedcnt;
  integer3 hhmmbrwintsportcnt;
  integer3 hhmmbrwdrgcnt7y;
  integer3 hhmmbrwdrgcnt1y;
  integer3 hhdrgnewmsnc7y;
  integer3 hhmmbrwcrimfelcnt7y;
  integer3 hhmmbrwcrimfelcnt1y;
  integer3 hhmmbrwcrimfelnewmsnc7y;
  integer3 hhmmbrwcrimnfelcnt7y;
  integer3 hhmmbrwcrimnfelcnt1y;
  integer3 hhmmbrwcrimnfelnewmsnc7y;
  integer3 hhmmbrwevictcnt7y;
  integer3 hhmmbrwevictcnt1y;
  integer3 hhmmbrwevictnewmsnc7y;
  integer3 hhmmbrwlnjcnt7y;
  integer3 hhmmbrwlnjcnt1y;
  integer4 hhmmbrlnjamttot7y;
  integer3 hhmmbrwlnjnewmsnc7y;
  integer3 hhmmbrwbkcnt10y;
  integer3 hhmmbrwbkcnt1y;
  integer3 hhmmbrwbkcnt2y;
  integer3 hhmmbrwbknewmsnc10y;
  integer3 hhmmbrwfrclcnt7y;
  integer3 hhmmbrwfrclnewmsnc7y;
  integer3 hhmmbrwithprofliccnt;
  integer3 hhmmbrwbusassoccnt;
  integer3 hhmmbrwprofliccat1cnt;
  integer3 hhmmbrwprofliccat2cnt;
  integer3 hhmmbrwprofliccat3cnt;
  integer3 hhmmbrwprofliccat4cnt;
  integer3 hhmmbrwprofliccat5cnt;
  integer3 hhmmbrwproflicuncatcnt;
  integer3 hhpurchnewamt;
  integer3 hhpurchtotev;
  integer3 hhpurchcntev;
  integer3 hhpurchnewmsnc;
  integer3 hhpurcholdmsnc;
  integer3 hhpurchitemcntev;
  integer3 hhpurchamtavg;
  integer3 hhastvehautocarcntev;
  integer3 hhastvehautocntev;
  integer3 hhastvehautoelitecntev;
  integer3 hhastvehautoexpcntev;
  integer3 hhastvehautoluxurycntev;
  integer3 hhastvehautomakecntev;
  integer3 hhastvehautoorigowncntev;
  integer3 hhastvehautosuvcntev;
  integer3 hhastvehautotruckcntev;
  integer3 hhastvehautovancntev;
  string36 hhastvehauto2ndfreqmake;
  integer3 hhastvehauto2ndfreqmakecntev;
  string36 hhastvehautofreqmake;
  integer3 hhastvehautofreqmakecntev;
  integer3 hhastvehautonewtypeindx;
  integer3 hhastvehautoemrgpriceavg;
  integer3 hhastvehautoemrgpricediff;
  integer3 hhastvehautoemrgpricemax;
  integer3 hhastvehautonewprice;
  integer3 hhastvehautoemrgageavg;
  integer3 hhastvehautoemrgagemax;
  integer3 hhastvehautoemrgagemin;
  integer3 hhastvehautoemrgspanavg;
  integer3 hhastvehautolastageavg;
  integer3 hhastvehautolastagemax;
  integer3 hhastvehautolastagemin;
  integer3 hhastvehautonewmsnc;
  integer3 hhastvehautotimeownspanavg;
  integer3 hhastvehotheratvcntev;
  integer3 hhastvehothercampercntev;
  integer3 hhastvehothercntev;
  integer3 hhastvehothercommcntev;
  integer3 hhastvehothermtrcntev;
  integer3 hhastvehotherorigowncntev;
  integer3 hhastvehotherscootercntev;
  integer3 hhastvehothernewmsnc;
  integer3 hhastvehothernewtypeindx;
  integer3 hhastvehothernewprice;
  integer3 hhastvehotherpriceavg;
  integer3 hhastvehotherpricemax;
  integer3 hhastvehotherpricemin;
  integer3 hhastvehautoemrgpricemin;
  integer3 raateenagercnt;
  integer3 raayoungadultcnt;
  integer3 raamiddleagecnt;
  integer3 raaseniorcnt;
  integer3 raaelderlycnt;
  integer3 raauniquehhcnt;
  integer3 raacnt;
  integer3 raamedianincome;
  integer3 raaweducollcnt;
  integer3 raaweducoll2ycnt;
  integer3 raaweducoll4ycnt;
  integer3 raaweducollgradcnt;
  integer3 raawcollpvtcnt;
  integer3 raawtoptiercollcnt;
  integer3 raawmidtiercollcnt;
  integer3 raawlowtiercollcnt;
  integer3 raacurraddrclosedist;
  integer3 raacurraddrclosenzdist;
  integer3 raacurraddr25midistcnt1y;
  integer3 raacurraddr100midistcnt1y;
  integer3 raacurraddrgt500midistcnt1y;
  integer3 relover500micnt1y;
  integer3 raacurraddrdistavg1y;
  integer3 raawcrim25micnt7y;
  integer3 raawcrimcurraddrclosedist7y;
  integer3 raaestincomeavg;
  integer3 raaestincomemax;
  integer3 raacurrhomevalavg;
  integer3 raapropowncnt;
  integer3 raapropcurrowntot;
  integer3 raapropcurravmvalmax;
  integer3 raapropcurravmvalavg;
  integer3 raapropcurravmvaltot;
  integer3 raapropcurravmvaltot1y;
  integer3 raapropcurravmvaltot5y;
  integer3 raavehicleownedcnt;
  integer3 raaautoownedcnt;
  integer3 raamotorcycleownedcnt;
  integer3 raaaircraftownedcnt;
  integer3 raawatercraftownedcnt;
  integer3 raawintsportcnt;
  integer3 raawdrgcnt7y;
  integer3 raawdrgcnt1y;
  integer3 raawdrgnewmsnc7y;
  integer3 raawcrimfelcnt7y;
  integer3 raawcrimfelcnt1y;
  integer3 raawcrimfelnewmsnc7y;
  integer3 raawcrimnfelcnt7y;
  integer3 raawcrminfelcnt1y;
  integer3 raawcrimnfelnewmsnc7y;
  integer3 raawevictcnt7y;
  integer3 raawevictcnt1y;
  integer3 raawevictnewmsnc7y;
  integer3 raawlnjcnt7y;
  integer3 raawlnjcnt1y;
  integer4 raalnjamttot;
  integer3 raawlnjnewmsnc7y;
  integer3 raawbkcnt10y;
  integer3 raawbkcnt1y;
  integer3 raawbkcnt2y;
  integer3 raawbknewmsnc10y;
  integer3 raafrclcnt7y;
  integer3 raafrclnewmsnc7y;
  integer3 raawprofliccnt;
  integer3 raawbusassoccnt;
  integer3 raawprofliccat1cnt;
  integer3 raawprofliccat2cnt;
  integer3 raawprofliccat3cnt;
  integer3 raawprofliccat4cnt;
  integer3 raawprofliccat5cnt;
  integer3 raawproflicuncatcnt;
  integer3 raapurchnewamt;
  integer3 raapurchtotev;
  integer3 raapurchcntev;
  integer3 raapurchitemcntev;
  integer3 raapurchamtavg;
  integer3 nbhdhhcnt;
  integer3 nbhdhhsizeavg;
  integer3 nbhdmmbrcnt;
  integer3 nbhdmmbrageavg;
  integer3 nbhdmarriedmmbrpct;
  integer3 nbhdmedincome;
  integer3 nbhdcollegeattendedmmbrpct;
  integer3 nbhdcollege2yrattendedmmbrpct;
  integer3 nbhdcollege4yrattendedmmbrpct;
  integer3 nbhdcollegeprivatemmbrpct;
  integer3 nbhdcollegetoptiermmbrpct;
  integer3 nbhdcollegecurrentattendingpct;
  integer3 nbhdcollegemidtiermmbrpct;
  integer3 nbhdcollegelowtiermmbrpct;
  integer3 nbhdbusinesscnt;
  integer3 nbhdvaluechangeindex;
  integer3 nbhdpropcurrownershiphhpct;
  integer3 nbhdpropownermmbrpct;
  integer3 nbhdppcurrownedhhpct;
  integer3 nbhdppcurrownedautohhpct;
  integer3 nbhdppcurrownedmtrcyclehhpct;
  integer3 nbhdppcurrownedaircrafthhpct;
  integer3 nbhdppcurrownedwtrcrfthhpct;
  integer3 nbhdoccproflicensemmbrpct;
  integer3 nbhdoccbusinessassociationmmbrpct;
  integer3 nbhdinterestsportspersonmmbrpct;
  integer3 nbhdcrtrcrdmmbrpct1y;
  integer3 nbhdcrtrcrdfelonymmbrpct;
  integer3 nbhdcrtrcrdmsdmeanmmbrpct;
  integer3 nbhdcrtrcrdevictionmmbrpct;
  integer3 nbhdcrtrcrdlienjudgemmbrpct;
  integer3 nbhdcrtrcrdbkrptmmbrpct;
  integer3 nbhdcrtrcrdbkrptmmbrpct1y;
  integer3 nbhdriskviewbankscoreavg;
  integer3 nbhdtelecomscoreavg;
  integer3 nbhdshorttermlendingscoreavg;
  integer3 nbhdautoscoreavg;
 END;

// Universally Set the History Date YYYYMMDD for ALL records. Set to 0 to use the History Date located on each record of the input file
histDate := '0';
// histDate := (STRING)STD.Date.Today(); // Run with today's date

Score_threshold := 80;
// RecordsToRun := 0;
RecordsToRun := 100;
eyeball := 100;

// runUsingInfo := 1; //pii only
runUsingInfo := 2; //LexID only
// runUsingInfo := 3; //both PII and LexID

// selectedMode := 1;  //current
selectedMode := 2;  //archive
// selectedMode := 3;  //archive with todays date

mapInputData := MAP(runUsingInfo = 1 => 'PIIOnly',
                    runUsingInfo = 2 => 'LexIDOnly',
                    runUsingInfo = 3 => 'BothPIILexID',
                    'Unknown');
mapModeText := MAP(selectedMode = 1 => 'CurrentMode',
										selectedMode = 2 => 'ArchiveMode',
										selectedMode = 3 => 'ArchiveCurrentDate',
										'Unknown');
STRING8 today := (STRING8)Std.Date.Today();

outputFile := TRIM('~jfrancis::out::' + today + '_' + thorlib.wuid() + '_PB20_' + TRIM(mapInputData) + '_' + TRIM(mapModeText));


// p_in := DATASET([{'1','SAFIATOU','','DRAME','16 BRYANT ST NW','WASHINGTON','DC','20001','','','','20190131',681800322}], prii_layout);//, thor);
p_in := DATASET(InputFile, prii_layout, CSV(HEADING(1),QUOTE('"')));
p := IF (RecordsToRun = 0, p_in, CHOOSEN (p_in, RecordsToRun));
OUTPUT(p_in, named('p_in'));

// PP1 := PROJECT(P, TRANSFORM(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Input_Layout, 
PP1 := PROJECT(P, TRANSFORM(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Layouts.LayoutInputPII, 
	SELF.P_InpArchDt := '20190101';
	SELF.P_InpLexID := (INTEGER7)LEFT.lexid;
	SELF.P_LexID := (INTEGER7)LEFT.lexid;
	// SELF.G_ProcUID := 1;
	SELF.G_ProcUID := COUNTER;
	SELF.P_InpAcct := LEFT.acctno;
  SELF.P_InpClnArchDt := '20190101';
	SELF := LEFT;
	SELF := [];
	));	
OUTPUT(PP1, named('PP1'));
PP := DISTRIBUTE(PP1, RANDOM());
// PP := PP1;
OUTPUT(PP, named('PP'));

myCFG := MODULE(ProfileBooster.ProfileBoosterV2_KEL.CFG_Compile)
END;

GLBA := 1; 
DPPA := 1; 
DataRestrictionMask						:= '00000000000000000000000000000000000000000000000000';
DataPermissionMask 						:= '11111111111111111111111111111111111111111111111111';  

Options := MODULE(ProfileBooster.ProfileBoosterV2_KEL.Interface_Options)
	EXPORT STRING AttributeSetName := 'Development KEL Attributes';
	EXPORT STRING VersionName := 'Version 1.0';
	EXPORT BOOLEAN isFCRA := FALSE;
	EXPORT STRING ArchiveDate := histDate;
	EXPORT STRING InputFileName := InputFile;
	EXPORT STRING Data_Restriction_Mask := DataRestrictionMask;
	EXPORT STRING Data_Permission_Mask := DataPermissionMask;
	EXPORT UNSIGNED GLBAPurpose := GLBA;
	EXPORT UNSIGNED DPPAPurpose := DPPA;
	EXPORT INTEGER ScoreThreshold := Score_threshold;
	EXPORT BOOLEAN OutputMasterResults := FALSE;
	EXPORT BOOLEAN isMarketing := TRUE; // When TRUE enables Marketing Restrictions
END;

// ResultSet:= ProfileBooster.ProfileBoosterV2_KEL.FnThor_GetAttrsV11(PP, Options); 
ResultSet:= ProfileBooster.ProfileBoosterV2_KEL.FnThor_GetPB20Attributes(PP, Options); 
// OUTPUT(ResultSet,,OutputFile, thor); W20200515-153410
OUTPUT(ResultSet,,OutputFile, CSV(HEADING(single), QUOTE('"')));
