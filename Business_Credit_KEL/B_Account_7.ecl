﻿//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Account_8,B_Tradeline_8,CFG_graph,E_Account,E_Account_Tradeline,E_Tradeline FROM Business_Credit_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Account_7(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(B_Account_8(__in,__cfg).__ENH_Account_8) __ENH_Account_8 := B_Account_8(__in,__cfg).__ENH_Account_8;
  SHARED VIRTUAL TYPEOF(E_Account_Tradeline(__in,__cfg).__Result) __E_Account_Tradeline := E_Account_Tradeline(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Tradeline_8(__in,__cfg).__ENH_Tradeline_8) __ENH_Tradeline_8 := B_Tradeline_8(__in,__cfg).__ENH_Tradeline_8;
  SHARED __EE294814 := __ENH_Account_8;
  SHARED __EE295440 := __ENH_Tradeline_8;
  SHARED __EE295438 := __E_Account_Tradeline;
  SHARED __EE299436 := __EE295438(__NN(__EE295438._acc_) AND __NN(__EE295438._trade_));
  SHARED __ST297725_Layout := RECORD
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
    KEL.typ.nbool Is_Chargeoff_;
    KEL.typ.nbool Is_Closed_;
    KEL.typ.nbool Shows_Closed_Account_;
    KEL.typ.ntyp(E_Account().Typ) _acc_;
    KEL.typ.ntyp(E_Tradeline().Typ) _trade_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC299454(B_Tradeline_8(__in,__cfg).__ST251864_Layout __EE295440, E_Account_Tradeline(__in,__cfg).Layout __EE299436) := __EEQP(__EE299436._trade_,__EE295440.UID);
  __ST297725_Layout __JT299454(B_Tradeline_8(__in,__cfg).__ST251864_Layout __l, E_Account_Tradeline(__in,__cfg).Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE299455 := JOIN(__EE299436,__EE295440,__JC299454(RIGHT,LEFT),__JT299454(RIGHT,LEFT),INNER,HASH);
  SHARED __ST297010_Layout := RECORD
    KEL.typ.ntyp(E_Account().Typ) UID;
    KEL.typ.ntyp(E_Account().Typ) _acc_;
    KEL.typ.ntyp(E_Tradeline().Typ) _trade_;
    KEL.typ.nuid U_I_D__1_;
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
    KEL.typ.nbool Is_Chargeoff_;
    KEL.typ.nbool Is_Closed_;
    KEL.typ.nbool Shows_Closed_Account_;
  END;
  SHARED __ST297010_Layout __ND299556__Project(__ST297725_Layout __PP299456) := TRANSFORM
    SELF.UID := __PP299456._acc_;
    SELF.U_I_D__1_ := __PP299456.UID;
    SELF := __PP299456;
  END;
  SHARED __EE299941 := PROJECT(__EE299455,__ND299556__Project(LEFT));
  SHARED __ST297227_Layout := RECORD
    KEL.typ.ntyp(E_Account().Typ) UID;
    KEL.typ.nkdate Exp1_;
    KEL.typ.nbool Is_Closed_;
    KEL.typ.nkdate Exp2_;
  END;
  SHARED __ST297227_Layout __ND299946__Project(__ST297010_Layout __PP299942) := TRANSFORM
    SELF.Exp1_ := IF(__T(__PP299942.Is_Closed_),__ECAST(KEL.typ.nkdate,__PP299942._cycle__end__date_),__ECAST(KEL.typ.nkdate,__N(KEL.typ.kdate)));
    SELF.Exp2_ := IF(__T(__NOT(__NT(__PP299942._account__type__reported_))),__ECAST(KEL.typ.nkdate,__PP299942._load__date_),__ECAST(KEL.typ.nkdate,__N(KEL.typ.kdate)));
    SELF := __PP299942;
  END;
  SHARED __EE299971 := PROJECT(__EE299941,__ND299946__Project(LEFT));
  SHARED __ST297252_Layout := RECORD
    KEL.typ.nkdate M_I_N__cycle__end__date_;
    KEL.typ.int C_O_U_N_T___Tradeline_ := 0;
    KEL.typ.nkdate M_A_X__load__date_;
    KEL.typ.ntyp(E_Account().Typ) UID;
  END;
  SHARED __EE300264 := PROJECT(__CLEANANDDO(__EE299971,TABLE(__EE299971,{KEL.Aggregates.MinNG(__EE299971.Exp1_) M_I_N__cycle__end__date_,KEL.typ.int C_O_U_N_T___Tradeline_ := COUNT(GROUP,__T(__EE299971.Is_Closed_)),KEL.Aggregates.MaxNG(__EE299971.Exp2_) M_A_X__load__date_,UID},UID,MERGE)),__ST297252_Layout);
  SHARED __ST298222_Layout := RECORD
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
    KEL.typ.nkdate Date_Account_Opened_;
    KEL.typ.nkdate Date_Closed_;
    KEL.typ.nkdate Most_Recent_Closed_Report_Date_;
    KEL.typ.nkdate Most_Recently_Open_Load_Date_;
    KEL.typ.nkdate M_I_N__cycle__end__date_;
    KEL.typ.int C_O_U_N_T___Tradeline_ := 0;
    KEL.typ.nkdate M_A_X__load__date_;
    KEL.typ.ntyp(E_Account().Typ) U_I_D__1_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC300270(B_Account_8(__in,__cfg).__ST251594_Layout __EE294814, __ST297252_Layout __EE300264) := __EEQP(__EE294814.UID,__EE300264.UID);
  __ST298222_Layout __JT300270(B_Account_8(__in,__cfg).__ST251594_Layout __l, __ST297252_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE300313 := JOIN(__EE294814,__EE300264,__JC300270(LEFT,RIGHT),__JT300270(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST251089_Layout := RECORD
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
    KEL.typ.nkdate Date_Account_Opened_;
    KEL.typ.nkdate Date_Closed_;
    KEL.typ.nkdate Date_Closed_Estimated_;
    KEL.typ.bool Has_Closed_ := FALSE;
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
  SHARED __ST251089_Layout __ND300318__Project(__ST298222_Layout __PP300314) := TRANSFORM
    SELF.Date_Closed_Estimated_ := IF(__T(__NOT(__NT(__PP300314.Date_Closed_))),__ECAST(KEL.typ.nkdate,__PP300314.Date_Closed_),__ECAST(KEL.typ.nkdate,__PP300314.M_I_N__cycle__end__date_));
    SELF.Has_Closed_ := __PP300314.C_O_U_N_T___Tradeline_ <> 0;
    SELF.Most_Recent_Type_Report_Date_ := __PP300314.M_A_X__load__date_;
    SELF.Opened_Last03_Month_ := __OP2(__FN2(KEL.Routines.MonthsBetween,__PP300314.Date_Account_Opened_,__CN(__cfg.CurrentDate)),<,__CN(3));
    SELF.Opened_Last06_Month_ := __OP2(__FN2(KEL.Routines.MonthsBetween,__PP300314.Date_Account_Opened_,__CN(__cfg.CurrentDate)),<,__CN(6));
    SELF.Opened_Last12_Month_ := __OP2(__FN2(KEL.Routines.MonthsBetween,__PP300314.Date_Account_Opened_,__CN(__cfg.CurrentDate)),<,__CN(12));
    SELF.Opened_Last24_Month_ := __OP2(__FN2(KEL.Routines.MonthsBetween,__PP300314.Date_Account_Opened_,__CN(__cfg.CurrentDate)),<,__CN(24));
    SELF.Opened_Last36_Month_ := __OP2(__FN2(KEL.Routines.MonthsBetween,__PP300314.Date_Account_Opened_,__CN(__cfg.CurrentDate)),<,__CN(36));
    SELF.Opened_Last60_Month_ := __OP2(__FN2(KEL.Routines.MonthsBetween,__PP300314.Date_Account_Opened_,__CN(__cfg.CurrentDate)),<,__CN(60));
    SELF.Opened_Last84_Month_ := __OP2(__FN2(KEL.Routines.MonthsBetween,__PP300314.Date_Account_Opened_,__CN(__cfg.CurrentDate)),<,__CN(84));
    SELF := __PP300314;
  END;
  EXPORT __ENH_Account_7 := PROJECT(__EE300313,__ND300318__Project(LEFT));
END;
