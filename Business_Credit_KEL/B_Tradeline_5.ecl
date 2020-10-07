﻿//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Account_6,B_Tradeline_6,CFG_graph,E_Account,E_Account_Tradeline,E_Tradeline FROM Business_Credit_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Tradeline_5(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(B_Account_6(__in,__cfg).__ENH_Account_6) __ENH_Account_6 := B_Account_6(__in,__cfg).__ENH_Account_6;
  SHARED VIRTUAL TYPEOF(E_Account_Tradeline(__in,__cfg).__Result) __E_Account_Tradeline := E_Account_Tradeline(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Tradeline_6(__in,__cfg).__ENH_Tradeline_6) __ENH_Tradeline_6 := B_Tradeline_6(__in,__cfg).__ENH_Tradeline_6;
  SHARED __EE355783 := __ENH_Tradeline_6;
  SHARED __ST356370_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nkdate _load__date_;
    KEL.typ.nstr _sbfe__contributor__number_;
    KEL.typ.nstr _contract__account__number_;
    KEL.typ.nkdate _cycle__end__date_;
    KEL.typ.nstr _segment__identifier_;
    KEL.typ.nstr _file__segment__num_;
    KEL.typ.nstr _parent__sequence__number_;
    KEL.typ.nstr _account__holder__business__name_;
    KEL.typ.nstr _dba_;
    KEL.typ.nstr _company__website_;
    KEL.typ.nint _legal__business__structure_;
    KEL.typ.nkdate _business__established__date_;
    KEL.typ.nint _account__type__reported_;
    KEL.typ.nstr _account__status__1_;
    KEL.typ.nstr _account__status__2_;
    KEL.typ.nkdate _date__account__opened_;
    KEL.typ.nkdate _date__account__closed_;
    KEL.typ.nstr _account__closure__basis_;
    KEL.typ.nkdate _account__expiration__date_;
    KEL.typ.nkdate _last__activity__date_;
    KEL.typ.nstr _last__activity__type_;
    KEL.typ.nstr _recent__activity__indicator_;
    KEL.typ.nint _original__credit__limit_;
    KEL.typ.nint _highest__credit__used_;
    KEL.typ.nint _current__credit__limit_;
    KEL.typ.nunk _reporting__indicator__length_;
    KEL.typ.nstr _payment__interval_;
    KEL.typ.nstr _payment__status__category_;
    KEL.typ.nint D_B_T___V5_;
    KEL.typ.nstr _ln__delinquency__date_;
    KEL.typ.nunk _term__of__account__in__months_;
    KEL.typ.nkdate _first__payment__due__date_;
    KEL.typ.nkdate _final__pyament__due__date_;
    KEL.typ.nunk _original__rate_;
    KEL.typ.nunk _floating__rate_;
    KEL.typ.nunk _grace__period_;
    KEL.typ.nunk _payment__category_;
    KEL.typ.nunk _payment__history__profile__12__months_;
    KEL.typ.nunk _payment__history__profile__13__24__months_;
    KEL.typ.nunk _payment__history__profile__25__36__months_;
    KEL.typ.nunk _payment__history__profile__37__48__months_;
    KEL.typ.nunk _payment__history__length_;
    KEL.typ.nunk _year__to__date__purchases__count_;
    KEL.typ.nunk _lifetime__to__date__purchases__count_;
    KEL.typ.nunk _year__to__date__purchases__sum__amount_;
    KEL.typ.nunk _lifetime__to__date__purchases__sum__amount_;
    KEL.typ.nint _payment__amount__scheduled_;
    KEL.typ.nint _recent__payment__amount_;
    KEL.typ.nkdate _recent__payment__date_;
    KEL.typ.nint _remaining__balance_;
    KEL.typ.nunk _carried__over__amount_;
    KEL.typ.nunk _new__applied__charges_;
    KEL.typ.nint _balloon__payment__due_;
    KEL.typ.nkdate _balloon__payment__due__date_;
    KEL.typ.nkdate _delinquency__date_;
    KEL.typ.nunk _days__delinquent_;
    KEL.typ.nint _past__due__amount_;
    KEL.typ.nunk _maximum__number__of__past__due__aging__amounts__buckets__provided_;
    KEL.typ.nunk _past__due__aging__bucket__type_;
    KEL.typ.nint _past__due__aging__amount__bucket__1_;
    KEL.typ.nint _past__due__aging__amount__bucket__2_;
    KEL.typ.nint _past__due__aging__amount__bucket__3_;
    KEL.typ.nint _past__due__aging__amount__bucket__4_;
    KEL.typ.nint _past__due__aging__amount__bucket__5_;
    KEL.typ.nint _past__due__aging__amount__bucket__6_;
    KEL.typ.nint _past__due__aging__amount__bucket__7_;
    KEL.typ.nunk _maximum__number__of__payment__tracking__cycle__periods__provided_;
    KEL.typ.nunk _payment__tracking__cycle__type_;
    KEL.typ.nunk _payment__tracking__cycle__0__current_;
    KEL.typ.nunk _payment__tracking__cycle__1__1__30__days_;
    KEL.typ.nunk _payment__tracking__cycle__2__31__60__days_;
    KEL.typ.nunk _payment__tracking__cycle__3__61__90__days_;
    KEL.typ.nunk _payment__tracking__cycle__4__91__120__days_;
    KEL.typ.nunk _payment__tracking__cycle__5__121__150days_;
    KEL.typ.nunk _payment__tracking__number__of__times__cycle__6__151__180__days_;
    KEL.typ.nunk _payment__tracking__number__of__times__cycle__7__181__or__greater__days_;
    KEL.typ.nkdate _date__account__was__charged__off_;
    KEL.typ.nint _amount__charged__off__by__creditor_;
    KEL.typ.nstr _charge__off__type__indicator_;
    KEL.typ.nint _total__charge__off__recoveries__to__date_;
    KEL.typ.nstr _government__guarantee__flag_;
    KEL.typ.nint _government__guarantee__category_;
    KEL.typ.nint _portion__of__account__guaranteed__by__government_;
    KEL.typ.nstr _guarantors__indicator_;
    KEL.typ.nint _number__of__guarantors_;
    KEL.typ.nstr _owners__indicator_;
    KEL.typ.nint _number__of__principals_;
    KEL.typ.nunk _account__update__deletion__indicator_;
    KEL.typ.nkdate Date_Reported_Closed_;
    KEL.typ.nint Days_Ago_;
    KEL.typ.nbool Is_Chargeoff_;
    KEL.typ.nbool Is_Closed_;
    KEL.typ.nint Months_Since_Trade_;
    KEL.typ.nint Past_Due_Amount_;
    KEL.typ.nint Past_Due_Amount_Bucket1_;
    KEL.typ.nint Past_Due_Amount_Bucket2_;
    KEL.typ.nint Past_Due_Amount_Bucket3_;
    KEL.typ.nint Past_Due_Amount_Bucket4_;
    KEL.typ.nint Past_Due_Amount_Bucket5_;
    KEL.typ.nint Past_Due_Amount_Bucket6_;
    KEL.typ.nint Past_Due_Amount_Bucket7_;
    KEL.typ.int Past_Due_Amount_Status_ := 0;
    KEL.typ.nbool Shows_Closed_Account_;
    KEL.typ.bool Account_Tradeline_ := FALSE;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE354600 := __E_Account_Tradeline;
  SHARED __EE359843 := __EE354600(__NN(__EE354600._acc_) AND __NN(__EE354600._trade_));
  SHARED __EE354615 := __ENH_Account_6;
  SHARED __ST356129_Layout := RECORD
    KEL.typ.ntyp(E_Account().Typ) _acc_;
    KEL.typ.ntyp(E_Tradeline().Typ) _trade_;
    KEL.typ.nuid UID;
    KEL.typ.nunk _seq_;
    KEL.typ.nunk _ultid_;
    KEL.typ.nunk _orgid_;
    KEL.typ.nunk _seleid_;
    KEL.typ.nunk _proxid_;
    KEL.typ.nunk _powid_;
    KEL.typ.nunk _empid_;
    KEL.typ.nunk _dotid_;
    KEL.typ.nunk _ultscore_;
    KEL.typ.nunk _orgscore_;
    KEL.typ.nunk _selescore_;
    KEL.typ.nunk _proxscore_;
    KEL.typ.nunk _powscore_;
    KEL.typ.nunk _empscore_;
    KEL.typ.nunk _dotscore_;
    KEL.typ.nunk _ultweight_;
    KEL.typ.nunk _orgweight_;
    KEL.typ.nunk _seleweight_;
    KEL.typ.nunk _proxweight_;
    KEL.typ.nunk _powweight_;
    KEL.typ.nunk _empweight_;
    KEL.typ.nunk _dotweight_;
    KEL.typ.nkdate _dt__first__seen_;
    KEL.typ.nkdate _dt__last__seen_;
    KEL.typ.nkdate _dt__vendor__first__reported_;
    KEL.typ.nkdate _dt__vendor__last__reported_;
    KEL.typ.nkdate _dt__datawarehouse__first__reported_;
    KEL.typ.nkdate _dt__datawarehouse__last__reported_;
    KEL.typ.nunk _did_;
    KEL.typ.nunk _did__score_;
    KEL.typ.nint Account_Type_;
    KEL.typ.nkdate Date_Account_Opened_;
    KEL.typ.nkdate Date_Closed_;
    KEL.typ.nkdate Date_Closed_Estimated_;
    KEL.typ.bool Has_Closed_ := FALSE;
    KEL.typ.nbool Has_Closed12_Month_;
    KEL.typ.nbool Has_Closed24_Month_;
    KEL.typ.nbool Has_Closed36_Month_;
    KEL.typ.nbool Has_Closed3_Month_;
    KEL.typ.nbool Has_Closed60_Month_;
    KEL.typ.nbool Has_Closed6_Month_;
    KEL.typ.nbool Has_Closed84_Month_;
    KEL.typ.nkdate Last_Cycle_End_Date_;
    KEL.typ.nkdate Most_Recent_Closed_Report_Date_;
    KEL.typ.nkdate Most_Recent_Type_Report_Date_;
    KEL.typ.nkdate Most_Recently_Open_Load_Date_;
    KEL.typ.nbool Opened_Last03_Month_;
    KEL.typ.nbool Opened_Last06_Month_;
    KEL.typ.nbool Opened_Last12_Month_;
    KEL.typ.nbool Opened_Last24_Month_;
    KEL.typ.nbool Opened_Last36_Month_;
    KEL.typ.nbool Opened_Last60_Month_;
    KEL.typ.nbool Opened_Last84_Month_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC359855(E_Account_Tradeline(__in,__cfg).Layout __EE359843, B_Account_6(__in,__cfg).__ST250344_Layout __EE354615) := __EEQP(__EE359843._acc_,__EE354615.UID);
  __ST356129_Layout __JT359855(E_Account_Tradeline(__in,__cfg).Layout __l, B_Account_6(__in,__cfg).__ST250344_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE359856 := JOIN(__EE359843,__EE354615,__JC359855(LEFT,RIGHT),__JT359855(LEFT,RIGHT),INNER,HASH);
  __JC359929(B_Tradeline_6(__in,__cfg).__ST250855_Layout __EE355783, __ST356129_Layout __EE359856) := __EEQP(__EE355783.UID,__EE359856._trade_) AND __T(__AND(__OP2(__EE359856.Date_Closed_Estimated_,<=,__EE355783._cycle__end__date_),__EEQ(__EE355783.UID,__EE359856._trade_)));
  __JF359929(__ST356129_Layout __EE359856) := __NN(__EE359856.Date_Closed_Estimated_) OR __NN(__EE359856._trade_);
  SHARED __EE359930 := JOIN(__EE355783,__EE359856,__JC359929(LEFT,RIGHT),TRANSFORM(__ST356370_Layout,SELF:=LEFT,SELF.Account_Tradeline_:=__JF359929(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST249972_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nkdate _load__date_;
    KEL.typ.nstr _sbfe__contributor__number_;
    KEL.typ.nstr _contract__account__number_;
    KEL.typ.nkdate _cycle__end__date_;
    KEL.typ.nstr _segment__identifier_;
    KEL.typ.nstr _file__segment__num_;
    KEL.typ.nstr _parent__sequence__number_;
    KEL.typ.nstr _account__holder__business__name_;
    KEL.typ.nstr _dba_;
    KEL.typ.nstr _company__website_;
    KEL.typ.nint _legal__business__structure_;
    KEL.typ.nkdate _business__established__date_;
    KEL.typ.nint _account__type__reported_;
    KEL.typ.nstr _account__status__1_;
    KEL.typ.nstr _account__status__2_;
    KEL.typ.nkdate _date__account__opened_;
    KEL.typ.nkdate _date__account__closed_;
    KEL.typ.nstr _account__closure__basis_;
    KEL.typ.nkdate _account__expiration__date_;
    KEL.typ.nkdate _last__activity__date_;
    KEL.typ.nstr _last__activity__type_;
    KEL.typ.nstr _recent__activity__indicator_;
    KEL.typ.nint _original__credit__limit_;
    KEL.typ.nint _highest__credit__used_;
    KEL.typ.nint _current__credit__limit_;
    KEL.typ.nunk _reporting__indicator__length_;
    KEL.typ.nstr _payment__interval_;
    KEL.typ.nstr _payment__status__category_;
    KEL.typ.nint D_B_T___V5_;
    KEL.typ.nstr _ln__delinquency__date_;
    KEL.typ.nunk _term__of__account__in__months_;
    KEL.typ.nkdate _first__payment__due__date_;
    KEL.typ.nkdate _final__pyament__due__date_;
    KEL.typ.nunk _original__rate_;
    KEL.typ.nunk _floating__rate_;
    KEL.typ.nunk _grace__period_;
    KEL.typ.nunk _payment__category_;
    KEL.typ.nunk _payment__history__profile__12__months_;
    KEL.typ.nunk _payment__history__profile__13__24__months_;
    KEL.typ.nunk _payment__history__profile__25__36__months_;
    KEL.typ.nunk _payment__history__profile__37__48__months_;
    KEL.typ.nunk _payment__history__length_;
    KEL.typ.nunk _year__to__date__purchases__count_;
    KEL.typ.nunk _lifetime__to__date__purchases__count_;
    KEL.typ.nunk _year__to__date__purchases__sum__amount_;
    KEL.typ.nunk _lifetime__to__date__purchases__sum__amount_;
    KEL.typ.nint _payment__amount__scheduled_;
    KEL.typ.nint _recent__payment__amount_;
    KEL.typ.nkdate _recent__payment__date_;
    KEL.typ.nint _remaining__balance_;
    KEL.typ.nunk _carried__over__amount_;
    KEL.typ.nunk _new__applied__charges_;
    KEL.typ.nint _balloon__payment__due_;
    KEL.typ.nkdate _balloon__payment__due__date_;
    KEL.typ.nkdate _delinquency__date_;
    KEL.typ.nunk _days__delinquent_;
    KEL.typ.nint _past__due__amount_;
    KEL.typ.nunk _maximum__number__of__past__due__aging__amounts__buckets__provided_;
    KEL.typ.nunk _past__due__aging__bucket__type_;
    KEL.typ.nint _past__due__aging__amount__bucket__1_;
    KEL.typ.nint _past__due__aging__amount__bucket__2_;
    KEL.typ.nint _past__due__aging__amount__bucket__3_;
    KEL.typ.nint _past__due__aging__amount__bucket__4_;
    KEL.typ.nint _past__due__aging__amount__bucket__5_;
    KEL.typ.nint _past__due__aging__amount__bucket__6_;
    KEL.typ.nint _past__due__aging__amount__bucket__7_;
    KEL.typ.nunk _maximum__number__of__payment__tracking__cycle__periods__provided_;
    KEL.typ.nunk _payment__tracking__cycle__type_;
    KEL.typ.nunk _payment__tracking__cycle__0__current_;
    KEL.typ.nunk _payment__tracking__cycle__1__1__30__days_;
    KEL.typ.nunk _payment__tracking__cycle__2__31__60__days_;
    KEL.typ.nunk _payment__tracking__cycle__3__61__90__days_;
    KEL.typ.nunk _payment__tracking__cycle__4__91__120__days_;
    KEL.typ.nunk _payment__tracking__cycle__5__121__150days_;
    KEL.typ.nunk _payment__tracking__number__of__times__cycle__6__151__180__days_;
    KEL.typ.nunk _payment__tracking__number__of__times__cycle__7__181__or__greater__days_;
    KEL.typ.nkdate _date__account__was__charged__off_;
    KEL.typ.nint _amount__charged__off__by__creditor_;
    KEL.typ.nstr _charge__off__type__indicator_;
    KEL.typ.nint _total__charge__off__recoveries__to__date_;
    KEL.typ.nstr _government__guarantee__flag_;
    KEL.typ.nint _government__guarantee__category_;
    KEL.typ.nint _portion__of__account__guaranteed__by__government_;
    KEL.typ.nstr _guarantors__indicator_;
    KEL.typ.nint _number__of__guarantors_;
    KEL.typ.nstr _owners__indicator_;
    KEL.typ.nint _number__of__principals_;
    KEL.typ.nunk _account__update__deletion__indicator_;
    KEL.typ.nint Account_Balance_;
    KEL.typ.bool Account_Closed_ := FALSE;
    KEL.typ.nint D_P_D01_Amount_Anual_V5_;
    KEL.typ.nint D_P_D01_Amount_Bi_Monthly_V5_;
    KEL.typ.nint D_P_D01_Amount_Bi_Weekly_V5_;
    KEL.typ.nint D_P_D01_Amount_Daily_V5_;
    KEL.typ.nint D_P_D01_Amount_Q_S_V5_;
    KEL.typ.nint D_P_D01_Amount_Semi_Anual_V5_;
    KEL.typ.nint D_P_D01_Amount_V4_;
    KEL.typ.nint D_P_D01_Amount_Weekly_V5_;
    KEL.typ.nint D_P_D121_Amount_Bi_Monthly_V5_;
    KEL.typ.nint D_P_D121_Amount_V4_;
    KEL.typ.nint D_P_D31_Amount_Bi_Weekly_V5_;
    KEL.typ.nint D_P_D31_Amount_V4_;
    KEL.typ.nint D_P_D31_Amount_Weekly_V5_;
    KEL.typ.nint D_P_D61_Amount_Bi_Monthly_V5_;
    KEL.typ.nint D_P_D61_Amount_Bi_Weekly_V5_;
    KEL.typ.nint D_P_D61_Amount_V4_;
    KEL.typ.nint D_P_D91_Amount_Q_S_V5_;
    KEL.typ.nint D_P_D91_Amount_V4_;
    KEL.typ.nint D_P_D_Other_Amount_Anual_V5_;
    KEL.typ.nint D_P_D_Other_Amount_Bi_Weekly_V5_;
    KEL.typ.nint D_P_D_Other_Amount_Daily_V5_;
    KEL.typ.nint D_P_D_Other_Amount_Q_S_V5_;
    KEL.typ.nint D_P_D_Other_Amount_Semi_Anual_V5_;
    KEL.typ.nint D_P_D_Other_Amount_Weekly_V5_;
    KEL.typ.nkdate Date_Reported_Closed_;
    KEL.typ.nint Days_Ago_;
    KEL.typ.nint Days_From_One_Year_;
    KEL.typ.nint Days_From_Two_Years_;
    KEL.typ.nbool Is_Chargeoff_;
    KEL.typ.nbool Is_Closed_;
    KEL.typ.float Months_Between_Payment_ := 0.0;
    KEL.typ.nint Months_Since_Trade_;
    KEL.typ.nint Past_Due_Amount_;
    KEL.typ.nint Past_Due_Amount_Bucket1_;
    KEL.typ.nint Past_Due_Amount_Bucket2_;
    KEL.typ.nint Past_Due_Amount_Bucket3_;
    KEL.typ.nint Past_Due_Amount_Bucket4_;
    KEL.typ.nint Past_Due_Amount_Bucket5_;
    KEL.typ.nint Past_Due_Amount_Bucket6_;
    KEL.typ.nint Past_Due_Amount_Bucket7_;
    KEL.typ.int Past_Due_Amount_Status_ := 0;
    KEL.typ.int Payment_Status_V4_ := 0;
    KEL.typ.int Payment_Status_V5_ := 0;
    KEL.typ.nbool Shows_Closed_Account_;
    KEL.typ.nbool Unknown_D_P_D01_Amount_Anual_V5_;
    KEL.typ.nbool Unknown_D_P_D01_Amount_Bi_Monthly_V5_;
    KEL.typ.nbool Unknown_D_P_D01_Amount_Bi_Weekly_V5_;
    KEL.typ.nbool Unknown_D_P_D01_Amount_Daily_V5_;
    KEL.typ.nbool Unknown_D_P_D01_Amount_Q_S_V5_;
    KEL.typ.nbool Unknown_D_P_D01_Amount_Semi_Anual_V5_;
    KEL.typ.nbool Unknown_D_P_D01_Amount_V4_;
    KEL.typ.nbool Unknown_D_P_D01_Amount_Weekly_V5_;
    KEL.typ.nbool Unknown_D_P_D121_Amount_Bi_Monthly_V5_;
    KEL.typ.nbool Unknown_D_P_D121_Amount_V4_;
    KEL.typ.nbool Unknown_D_P_D31_Amount_Bi_Weekly_V5_;
    KEL.typ.nbool Unknown_D_P_D31_Amount_V4_;
    KEL.typ.nbool Unknown_D_P_D31_Amount_Weekly_V5_;
    KEL.typ.nbool Unknown_D_P_D61_Amount_Bi_Monthly_V5_;
    KEL.typ.nbool Unknown_D_P_D61_Amount_Bi_Weekly_V5_;
    KEL.typ.nbool Unknown_D_P_D61_Amount_V4_;
    KEL.typ.nbool Unknown_D_P_D91_Amount_Q_S_V5_;
    KEL.typ.nbool Unknown_D_P_D91_Amount_V4_;
    KEL.typ.nbool Unknown_D_P_D_Other_Amount_Anual_V5_;
    KEL.typ.nbool Unknown_D_P_D_Other_Amount_Bi_Weekly_V5_;
    KEL.typ.nbool Unknown_D_P_D_Other_Amount_Daily_V5_;
    KEL.typ.nbool Unknown_D_P_D_Other_Amount_Q_S_V5_;
    KEL.typ.nbool Unknown_D_P_D_Other_Amount_Semi_Anual_V5_;
    KEL.typ.nbool Unknown_D_P_D_Other_Amount_Weekly_V5_;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST249972_Layout __ND361532__Project(__ST356370_Layout __PP359931) := TRANSFORM
    SELF.Account_Balance_ := IF(__T(__AND(__OP2(__PP359931._remaining__balance_,<,__CN(0)),__NOT(__NT(__PP359931._remaining__balance_)))),__ECAST(KEL.typ.nint,__CN(0)),__ECAST(KEL.typ.nint,__PP359931._remaining__balance_));
    SELF.Account_Closed_ := __PP359931.Account_Tradeline_;
    SELF.D_P_D01_Amount_Anual_V5_ := __OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__PP359931.Past_Due_Amount_Bucket1_,+,__PP359931.Past_Due_Amount_Bucket2_),+,__PP359931.Past_Due_Amount_Bucket3_),+,__PP359931.Past_Due_Amount_Bucket4_),+,__PP359931.Past_Due_Amount_Bucket5_),+,__PP359931.Past_Due_Amount_Bucket6_),+,__PP359931.Past_Due_Amount_Bucket7_);
    SELF.D_P_D01_Amount_Bi_Monthly_V5_ := __OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__PP359931.Past_Due_Amount_Bucket1_,+,__PP359931.Past_Due_Amount_Bucket2_),+,__PP359931.Past_Due_Amount_Bucket3_),+,__PP359931.Past_Due_Amount_Bucket4_),+,__PP359931.Past_Due_Amount_Bucket5_),+,__PP359931.Past_Due_Amount_Bucket6_),+,__PP359931.Past_Due_Amount_Bucket7_);
    SELF.D_P_D01_Amount_Bi_Weekly_V5_ := __OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__PP359931.Past_Due_Amount_Bucket1_,+,__PP359931.Past_Due_Amount_Bucket2_),+,__PP359931.Past_Due_Amount_Bucket3_),+,__PP359931.Past_Due_Amount_Bucket4_),+,__PP359931.Past_Due_Amount_Bucket5_),+,__PP359931.Past_Due_Amount_Bucket6_),+,__PP359931.Past_Due_Amount_Bucket7_);
    SELF.D_P_D01_Amount_Daily_V5_ := __OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__PP359931.Past_Due_Amount_Bucket1_,+,__PP359931.Past_Due_Amount_Bucket2_),+,__PP359931.Past_Due_Amount_Bucket3_),+,__PP359931.Past_Due_Amount_Bucket4_),+,__PP359931.Past_Due_Amount_Bucket5_),+,__PP359931.Past_Due_Amount_Bucket6_),+,__PP359931.Past_Due_Amount_Bucket7_);
    SELF.D_P_D01_Amount_Q_S_V5_ := __OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__PP359931.Past_Due_Amount_Bucket1_,+,__PP359931.Past_Due_Amount_Bucket2_),+,__PP359931.Past_Due_Amount_Bucket3_),+,__PP359931.Past_Due_Amount_Bucket4_),+,__PP359931.Past_Due_Amount_Bucket5_),+,__PP359931.Past_Due_Amount_Bucket6_),+,__PP359931.Past_Due_Amount_Bucket7_);
    SELF.D_P_D01_Amount_Semi_Anual_V5_ := __OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__PP359931.Past_Due_Amount_Bucket1_,+,__PP359931.Past_Due_Amount_Bucket2_),+,__PP359931.Past_Due_Amount_Bucket3_),+,__PP359931.Past_Due_Amount_Bucket4_),+,__PP359931.Past_Due_Amount_Bucket5_),+,__PP359931.Past_Due_Amount_Bucket6_),+,__PP359931.Past_Due_Amount_Bucket7_);
    SELF.D_P_D01_Amount_V4_ := __OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__PP359931.Past_Due_Amount_Bucket1_,+,__PP359931.Past_Due_Amount_Bucket2_),+,__PP359931.Past_Due_Amount_Bucket3_),+,__PP359931.Past_Due_Amount_Bucket4_),+,__PP359931.Past_Due_Amount_Bucket5_),+,__PP359931.Past_Due_Amount_Bucket6_),+,__PP359931.Past_Due_Amount_Bucket7_);
    SELF.D_P_D01_Amount_Weekly_V5_ := __OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__PP359931.Past_Due_Amount_Bucket1_,+,__PP359931.Past_Due_Amount_Bucket2_),+,__PP359931.Past_Due_Amount_Bucket3_),+,__PP359931.Past_Due_Amount_Bucket4_),+,__PP359931.Past_Due_Amount_Bucket5_),+,__PP359931.Past_Due_Amount_Bucket6_),+,__PP359931.Past_Due_Amount_Bucket7_);
    SELF.D_P_D121_Amount_Bi_Monthly_V5_ := __OP2(__OP2(__OP2(__OP2(__PP359931.Past_Due_Amount_Bucket3_,+,__PP359931.Past_Due_Amount_Bucket4_),+,__PP359931.Past_Due_Amount_Bucket5_),+,__PP359931.Past_Due_Amount_Bucket6_),+,__PP359931.Past_Due_Amount_Bucket7_);
    SELF.D_P_D121_Amount_V4_ := __OP2(__OP2(__PP359931.Past_Due_Amount_Bucket5_,+,__PP359931.Past_Due_Amount_Bucket6_),+,__PP359931.Past_Due_Amount_Bucket7_);
    SELF.D_P_D31_Amount_Bi_Weekly_V5_ := __OP2(__OP2(__OP2(__OP2(__PP359931.Past_Due_Amount_Bucket3_,+,__PP359931.Past_Due_Amount_Bucket4_),+,__PP359931.Past_Due_Amount_Bucket5_),+,__PP359931.Past_Due_Amount_Bucket6_),+,__PP359931.Past_Due_Amount_Bucket7_);
    SELF.D_P_D31_Amount_V4_ := __OP2(__OP2(__OP2(__OP2(__OP2(__PP359931.Past_Due_Amount_Bucket2_,+,__PP359931.Past_Due_Amount_Bucket3_),+,__PP359931.Past_Due_Amount_Bucket4_),+,__PP359931.Past_Due_Amount_Bucket5_),+,__PP359931.Past_Due_Amount_Bucket6_),+,__PP359931.Past_Due_Amount_Bucket7_);
    SELF.D_P_D31_Amount_Weekly_V5_ := __OP2(__OP2(__PP359931.Past_Due_Amount_Bucket5_,+,__PP359931.Past_Due_Amount_Bucket6_),+,__PP359931.Past_Due_Amount_Bucket7_);
    SELF.D_P_D61_Amount_Bi_Monthly_V5_ := __OP2(__OP2(__OP2(__OP2(__OP2(__PP359931.Past_Due_Amount_Bucket2_,+,__PP359931.Past_Due_Amount_Bucket3_),+,__PP359931.Past_Due_Amount_Bucket4_),+,__PP359931.Past_Due_Amount_Bucket5_),+,__PP359931.Past_Due_Amount_Bucket6_),+,__PP359931.Past_Due_Amount_Bucket7_);
    SELF.D_P_D61_Amount_Bi_Weekly_V5_ := __OP2(__OP2(__PP359931.Past_Due_Amount_Bucket5_,+,__PP359931.Past_Due_Amount_Bucket6_),+,__PP359931.Past_Due_Amount_Bucket7_);
    SELF.D_P_D61_Amount_V4_ := __OP2(__OP2(__OP2(__OP2(__PP359931.Past_Due_Amount_Bucket3_,+,__PP359931.Past_Due_Amount_Bucket4_),+,__PP359931.Past_Due_Amount_Bucket5_),+,__PP359931.Past_Due_Amount_Bucket6_),+,__PP359931.Past_Due_Amount_Bucket7_);
    SELF.D_P_D91_Amount_Q_S_V5_ := __OP2(__OP2(__OP2(__OP2(__OP2(__PP359931.Past_Due_Amount_Bucket2_,+,__PP359931.Past_Due_Amount_Bucket3_),+,__PP359931.Past_Due_Amount_Bucket4_),+,__PP359931.Past_Due_Amount_Bucket5_),+,__PP359931.Past_Due_Amount_Bucket6_),+,__PP359931.Past_Due_Amount_Bucket7_);
    SELF.D_P_D91_Amount_V4_ := __OP2(__OP2(__OP2(__PP359931.Past_Due_Amount_Bucket4_,+,__PP359931.Past_Due_Amount_Bucket5_),+,__PP359931.Past_Due_Amount_Bucket6_),+,__PP359931.Past_Due_Amount_Bucket7_);
    SELF.D_P_D_Other_Amount_Anual_V5_ := __OP2(__OP2(__OP2(__OP2(__OP2(__PP359931.Past_Due_Amount_Bucket2_,+,__PP359931.Past_Due_Amount_Bucket3_),+,__PP359931.Past_Due_Amount_Bucket4_),+,__PP359931.Past_Due_Amount_Bucket5_),+,__PP359931.Past_Due_Amount_Bucket6_),+,__PP359931.Past_Due_Amount_Bucket7_);
    SELF.D_P_D_Other_Amount_Bi_Weekly_V5_ := __PP359931.Past_Due_Amount_Bucket7_;
    SELF.D_P_D_Other_Amount_Daily_V5_ := __PP359931.Past_Due_Amount_Bucket7_;
    SELF.D_P_D_Other_Amount_Q_S_V5_ := __OP2(__OP2(__OP2(__OP2(__PP359931.Past_Due_Amount_Bucket3_,+,__PP359931.Past_Due_Amount_Bucket4_),+,__PP359931.Past_Due_Amount_Bucket5_),+,__PP359931.Past_Due_Amount_Bucket6_),+,__PP359931.Past_Due_Amount_Bucket7_);
    SELF.D_P_D_Other_Amount_Semi_Anual_V5_ := __OP2(__OP2(__OP2(__OP2(__OP2(__PP359931.Past_Due_Amount_Bucket2_,+,__PP359931.Past_Due_Amount_Bucket3_),+,__PP359931.Past_Due_Amount_Bucket4_),+,__PP359931.Past_Due_Amount_Bucket5_),+,__PP359931.Past_Due_Amount_Bucket6_),+,__PP359931.Past_Due_Amount_Bucket7_);
    SELF.D_P_D_Other_Amount_Weekly_V5_ := __PP359931.Past_Due_Amount_Bucket7_;
    SELF.Days_From_One_Year_ := __FN1(ABS,__OP2(__PP359931.Days_Ago_,-,__CN(365)));
    SELF.Days_From_Two_Years_ := __FN1(ABS,__OP2(__PP359931.Days_Ago_,-,__CN(730)));
    SELF.Months_Between_Payment_ := MAP(__T(__OP2(__PP359931._payment__interval_,=,__CN('A')))=>(KEL.typ.float)12,__T(__OP2(__PP359931._payment__interval_,=,__CN('BM')))=>(KEL.typ.float)2,__T(__OP2(__PP359931._payment__interval_,=,__CN('BW')))=>0.5,__T(__OP2(__PP359931._payment__interval_,=,__CN('D')))=>1 / 30,__T(__OP2(__PP359931._payment__interval_,=,__CN('M')))=>(KEL.typ.float)1,__T(__OP2(__PP359931._payment__interval_,=,__CN('Q')))=>(KEL.typ.float)3,__T(__OP2(__PP359931._payment__interval_,IN,__CN(['S','SF'])))=>(KEL.typ.float)3,__T(__OP2(__PP359931._payment__interval_,=,__CN('SA')))=>(KEL.typ.float)6,__T(__OP2(__PP359931._payment__interval_,=,__CN('SM')))=>0.5,__T(__OP2(__PP359931._payment__interval_,=,__CN('SP')))=>(KEL.typ.float)1,__T(__OP2(__PP359931._payment__interval_,=,__CN('W')))=>0.25,(KEL.typ.float)1);
    __CC337 := -97;
    SELF.Payment_Status_V4_ := MAP(__T(__PP359931.Is_Chargeoff_)=>9,__T(__AND(__NT(__PP359931._payment__status__category_),__OP2(__PP359931.Past_Due_Amount_,>,__CN(0))))=>__PP359931.Past_Due_Amount_Status_,__T(__AND(__NT(__PP359931._payment__status__category_),__OP2(__PP359931.Past_Due_Amount_,=,__CN(0))))=>0,__T(__OP2(__PP359931._payment__status__category_,=,__CN('000')))=>0,__T(__OP2(__PP359931._payment__status__category_,=,__CN('001')))=>2,__T(__OP2(__PP359931._payment__status__category_,=,__CN('002')))=>3,__T(__OP2(__PP359931._payment__status__category_,=,__CN('003')))=>4,__T(__OP2(__PP359931._payment__status__category_,=,__CN('004')))=>5,__T(__OP2(__PP359931._payment__status__category_,=,__CN('005')))=>6,__T(__OP2(__PP359931._payment__status__category_,=,__CN('006')))=>7,__T(__OP2(__PP359931._payment__status__category_,=,__CN('007')))=>8,__CC337);
    SELF.Payment_Status_V5_ := MAP(__T(__PP359931.Is_Chargeoff_)=>9,__T(__NT(__PP359931._ln__delinquency__date_))=>0,__T(__OP2(__PP359931._ln__delinquency__date_,IN,__CN(['-1','-2','-3','-4'])))=>1,__T(__AND(__OP2(__PP359931.D_B_T___V5_,>=,__CN(0)),__OP2(__PP359931.D_B_T___V5_,<=,__CN(30))))=>2,__T(__AND(__OP2(__PP359931.D_B_T___V5_,>,__CN(30)),__OP2(__PP359931.D_B_T___V5_,<=,__CN(60))))=>3,__T(__AND(__OP2(__PP359931.D_B_T___V5_,>,__CN(60)),__OP2(__PP359931.D_B_T___V5_,<=,__CN(90))))=>4,__T(__AND(__OP2(__PP359931.D_B_T___V5_,>,__CN(90)),__OP2(__PP359931.D_B_T___V5_,<=,__CN(120))))=>5,__T(__AND(__OP2(__PP359931.D_B_T___V5_,>,__CN(120)),__OP2(__PP359931.D_B_T___V5_,<=,__CN(150))))=>6,__T(__AND(__OP2(__PP359931.D_B_T___V5_,>,__CN(150)),__OP2(__PP359931.D_B_T___V5_,<=,__CN(180))))=>7,__T(__OP2(__PP359931.D_B_T___V5_,>,__CN(180)))=>8,__CC337);
    SELF.Unknown_D_P_D01_Amount_Anual_V5_ := __AND(__AND(__AND(__AND(__AND(__AND(__NT(__PP359931._past__due__aging__amount__bucket__1_),__NT(__PP359931._past__due__aging__amount__bucket__2_)),__NT(__PP359931._past__due__aging__amount__bucket__3_)),__NT(__PP359931._past__due__aging__amount__bucket__4_)),__NT(__PP359931._past__due__aging__amount__bucket__5_)),__NT(__PP359931._past__due__aging__amount__bucket__6_)),__NT(__PP359931._past__due__aging__amount__bucket__7_));
    SELF.Unknown_D_P_D01_Amount_Bi_Monthly_V5_ := __AND(__AND(__AND(__AND(__AND(__AND(__NT(__PP359931._past__due__aging__amount__bucket__1_),__NT(__PP359931._past__due__aging__amount__bucket__2_)),__NT(__PP359931._past__due__aging__amount__bucket__3_)),__NT(__PP359931._past__due__aging__amount__bucket__4_)),__NT(__PP359931._past__due__aging__amount__bucket__5_)),__NT(__PP359931._past__due__aging__amount__bucket__6_)),__NT(__PP359931._past__due__aging__amount__bucket__7_));
    SELF.Unknown_D_P_D01_Amount_Bi_Weekly_V5_ := __AND(__AND(__AND(__AND(__AND(__AND(__NT(__PP359931._past__due__aging__amount__bucket__1_),__NT(__PP359931._past__due__aging__amount__bucket__2_)),__NT(__PP359931._past__due__aging__amount__bucket__3_)),__NT(__PP359931._past__due__aging__amount__bucket__4_)),__NT(__PP359931._past__due__aging__amount__bucket__5_)),__NT(__PP359931._past__due__aging__amount__bucket__6_)),__NT(__PP359931._past__due__aging__amount__bucket__7_));
    SELF.Unknown_D_P_D01_Amount_Daily_V5_ := __AND(__AND(__AND(__AND(__AND(__AND(__NT(__PP359931._past__due__aging__amount__bucket__1_),__NT(__PP359931._past__due__aging__amount__bucket__2_)),__NT(__PP359931._past__due__aging__amount__bucket__3_)),__NT(__PP359931._past__due__aging__amount__bucket__4_)),__NT(__PP359931._past__due__aging__amount__bucket__5_)),__NT(__PP359931._past__due__aging__amount__bucket__6_)),__NT(__PP359931._past__due__aging__amount__bucket__7_));
    SELF.Unknown_D_P_D01_Amount_Q_S_V5_ := __AND(__AND(__AND(__AND(__AND(__AND(__NT(__PP359931._past__due__aging__amount__bucket__1_),__NT(__PP359931._past__due__aging__amount__bucket__2_)),__NT(__PP359931._past__due__aging__amount__bucket__3_)),__NT(__PP359931._past__due__aging__amount__bucket__4_)),__NT(__PP359931._past__due__aging__amount__bucket__5_)),__NT(__PP359931._past__due__aging__amount__bucket__6_)),__NT(__PP359931._past__due__aging__amount__bucket__7_));
    SELF.Unknown_D_P_D01_Amount_Semi_Anual_V5_ := __AND(__AND(__AND(__AND(__AND(__AND(__NT(__PP359931._past__due__aging__amount__bucket__1_),__NT(__PP359931._past__due__aging__amount__bucket__2_)),__NT(__PP359931._past__due__aging__amount__bucket__3_)),__NT(__PP359931._past__due__aging__amount__bucket__4_)),__NT(__PP359931._past__due__aging__amount__bucket__5_)),__NT(__PP359931._past__due__aging__amount__bucket__6_)),__NT(__PP359931._past__due__aging__amount__bucket__7_));
    SELF.Unknown_D_P_D01_Amount_V4_ := __AND(__AND(__AND(__AND(__AND(__AND(__NT(__PP359931._past__due__aging__amount__bucket__1_),__NT(__PP359931._past__due__aging__amount__bucket__2_)),__NT(__PP359931._past__due__aging__amount__bucket__3_)),__NT(__PP359931._past__due__aging__amount__bucket__4_)),__NT(__PP359931._past__due__aging__amount__bucket__5_)),__NT(__PP359931._past__due__aging__amount__bucket__6_)),__NT(__PP359931._past__due__aging__amount__bucket__7_));
    SELF.Unknown_D_P_D01_Amount_Weekly_V5_ := __AND(__AND(__AND(__AND(__AND(__AND(__NT(__PP359931._past__due__aging__amount__bucket__1_),__NT(__PP359931._past__due__aging__amount__bucket__2_)),__NT(__PP359931._past__due__aging__amount__bucket__3_)),__NT(__PP359931._past__due__aging__amount__bucket__4_)),__NT(__PP359931._past__due__aging__amount__bucket__5_)),__NT(__PP359931._past__due__aging__amount__bucket__6_)),__NT(__PP359931._past__due__aging__amount__bucket__7_));
    SELF.Unknown_D_P_D121_Amount_Bi_Monthly_V5_ := __AND(__AND(__AND(__AND(__NT(__PP359931._past__due__aging__amount__bucket__3_),__NT(__PP359931._past__due__aging__amount__bucket__4_)),__NT(__PP359931._past__due__aging__amount__bucket__5_)),__NT(__PP359931._past__due__aging__amount__bucket__6_)),__NT(__PP359931._past__due__aging__amount__bucket__7_));
    SELF.Unknown_D_P_D121_Amount_V4_ := __AND(__AND(__NT(__PP359931._past__due__aging__amount__bucket__5_),__NT(__PP359931._past__due__aging__amount__bucket__6_)),__NT(__PP359931._past__due__aging__amount__bucket__7_));
    SELF.Unknown_D_P_D31_Amount_Bi_Weekly_V5_ := __AND(__AND(__AND(__AND(__NT(__PP359931._past__due__aging__amount__bucket__3_),__NT(__PP359931._past__due__aging__amount__bucket__4_)),__NT(__PP359931._past__due__aging__amount__bucket__5_)),__NT(__PP359931._past__due__aging__amount__bucket__6_)),__NT(__PP359931._past__due__aging__amount__bucket__7_));
    SELF.Unknown_D_P_D31_Amount_V4_ := __AND(__AND(__AND(__AND(__AND(__NT(__PP359931._past__due__aging__amount__bucket__2_),__NT(__PP359931._past__due__aging__amount__bucket__3_)),__NT(__PP359931._past__due__aging__amount__bucket__4_)),__NT(__PP359931._past__due__aging__amount__bucket__5_)),__NT(__PP359931._past__due__aging__amount__bucket__6_)),__NT(__PP359931._past__due__aging__amount__bucket__7_));
    SELF.Unknown_D_P_D31_Amount_Weekly_V5_ := __AND(__AND(__NT(__PP359931._past__due__aging__amount__bucket__5_),__NT(__PP359931._past__due__aging__amount__bucket__6_)),__NT(__PP359931._past__due__aging__amount__bucket__7_));
    SELF.Unknown_D_P_D61_Amount_Bi_Monthly_V5_ := __AND(__AND(__AND(__AND(__AND(__NT(__PP359931._past__due__aging__amount__bucket__2_),__NT(__PP359931._past__due__aging__amount__bucket__3_)),__NT(__PP359931._past__due__aging__amount__bucket__4_)),__NT(__PP359931._past__due__aging__amount__bucket__5_)),__NT(__PP359931._past__due__aging__amount__bucket__6_)),__NT(__PP359931._past__due__aging__amount__bucket__7_));
    SELF.Unknown_D_P_D61_Amount_Bi_Weekly_V5_ := __AND(__AND(__NT(__PP359931._past__due__aging__amount__bucket__5_),__NT(__PP359931._past__due__aging__amount__bucket__6_)),__NT(__PP359931._past__due__aging__amount__bucket__7_));
    SELF.Unknown_D_P_D61_Amount_V4_ := __AND(__AND(__AND(__AND(__NT(__PP359931._past__due__aging__amount__bucket__3_),__NT(__PP359931._past__due__aging__amount__bucket__4_)),__NT(__PP359931._past__due__aging__amount__bucket__5_)),__NT(__PP359931._past__due__aging__amount__bucket__6_)),__NT(__PP359931._past__due__aging__amount__bucket__7_));
    SELF.Unknown_D_P_D91_Amount_Q_S_V5_ := __AND(__AND(__AND(__AND(__AND(__NT(__PP359931._past__due__aging__amount__bucket__2_),__NT(__PP359931._past__due__aging__amount__bucket__3_)),__NT(__PP359931._past__due__aging__amount__bucket__4_)),__NT(__PP359931._past__due__aging__amount__bucket__5_)),__NT(__PP359931._past__due__aging__amount__bucket__6_)),__NT(__PP359931._past__due__aging__amount__bucket__7_));
    SELF.Unknown_D_P_D91_Amount_V4_ := __AND(__AND(__AND(__NT(__PP359931._past__due__aging__amount__bucket__4_),__NT(__PP359931._past__due__aging__amount__bucket__5_)),__NT(__PP359931._past__due__aging__amount__bucket__6_)),__NT(__PP359931._past__due__aging__amount__bucket__7_));
    SELF.Unknown_D_P_D_Other_Amount_Anual_V5_ := __AND(__AND(__AND(__AND(__AND(__NT(__PP359931._past__due__aging__amount__bucket__2_),__NT(__PP359931._past__due__aging__amount__bucket__3_)),__NT(__PP359931._past__due__aging__amount__bucket__4_)),__NT(__PP359931._past__due__aging__amount__bucket__5_)),__NT(__PP359931._past__due__aging__amount__bucket__6_)),__NT(__PP359931._past__due__aging__amount__bucket__7_));
    SELF.Unknown_D_P_D_Other_Amount_Bi_Weekly_V5_ := __NT(__PP359931._past__due__aging__amount__bucket__7_);
    SELF.Unknown_D_P_D_Other_Amount_Daily_V5_ := __NT(__PP359931._past__due__aging__amount__bucket__7_);
    SELF.Unknown_D_P_D_Other_Amount_Q_S_V5_ := __AND(__AND(__AND(__AND(__NT(__PP359931._past__due__aging__amount__bucket__3_),__NT(__PP359931._past__due__aging__amount__bucket__4_)),__NT(__PP359931._past__due__aging__amount__bucket__5_)),__NT(__PP359931._past__due__aging__amount__bucket__6_)),__NT(__PP359931._past__due__aging__amount__bucket__7_));
    SELF.Unknown_D_P_D_Other_Amount_Semi_Anual_V5_ := __AND(__AND(__AND(__AND(__AND(__NT(__PP359931._past__due__aging__amount__bucket__2_),__NT(__PP359931._past__due__aging__amount__bucket__3_)),__NT(__PP359931._past__due__aging__amount__bucket__4_)),__NT(__PP359931._past__due__aging__amount__bucket__5_)),__NT(__PP359931._past__due__aging__amount__bucket__6_)),__NT(__PP359931._past__due__aging__amount__bucket__7_));
    SELF.Unknown_D_P_D_Other_Amount_Weekly_V5_ := __NT(__PP359931._past__due__aging__amount__bucket__7_);
    SELF := __PP359931;
  END;
  EXPORT __ENH_Tradeline_5 := PROJECT(__EE359930,__ND361532__Project(LEFT));
END;
