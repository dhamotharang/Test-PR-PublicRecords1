//HPCC Systems KEL Compiler Version 0.8.2
IMPORT KEL08a AS KEL;
IMPORT B_Tradeline_10,CFG_graph,E_Account,E_Account_Tradeline,E_Tradeline FROM Business_Credit_KEL;
IMPORT * FROM KEL08a.Null;
EXPORT B_Account_9(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(E_Account(__in,__cfg).__Result) __E_Account := E_Account(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(E_Account_Tradeline(__in,__cfg).__Result) __E_Account_Tradeline := E_Account_Tradeline(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Tradeline_10(__in,__cfg).__ENH_Tradeline_10) __ENH_Tradeline_10 := B_Tradeline_10(__in,__cfg).__ENH_Tradeline_10;
  SHARED __EE141977 := __E_Account;
  SHARED __ST144737_Layout := RECORD
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
  END;
  SHARED __EE144735 := PROJECT(__EE141977,__ST144737_Layout);
  SHARED __EE142123 := __ENH_Tradeline_10;
  SHARED __EE142113 := __E_Account_Tradeline;
  SHARED __EE146591 := __EE142113(__NN(__EE142113._acc_) AND __NN(__EE142113._trade_));
  SHARED __ST145304_Layout := RECORD
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
    KEL.typ.nbool Shows_Closed_Account_;
    KEL.typ.ntyp(E_Account().Typ) _acc_;
    KEL.typ.ntyp(E_Tradeline().Typ) _trade_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC146609(B_Tradeline_10(__in,__cfg).__ST141048_Layout __EE142123, E_Account_Tradeline(__in,__cfg).Layout __EE146591) := __EEQP(__EE146591._trade_,__EE142123.UID);
  __ST145304_Layout __JT146609(B_Tradeline_10(__in,__cfg).__ST141048_Layout __l, E_Account_Tradeline(__in,__cfg).Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE146610 := JOIN(__EE146591,__EE142123,__JC146609(RIGHT,LEFT),__JT146609(RIGHT,LEFT),INNER,HASH);
  SHARED __ST144491_Layout := RECORD
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
    KEL.typ.nbool Shows_Closed_Account_;
  END;
  SHARED __ST144491_Layout __ND146707__Project(__ST145304_Layout __PP146611) := TRANSFORM
    SELF.UID := __PP146611._acc_;
    SELF.U_I_D__1_ := __PP146611.UID;
    SELF := __PP146611;
  END;
  SHARED __EE147076 := PROJECT(__EE146610,__ND146707__Project(LEFT));
  SHARED __ST144700_Layout := RECORD
    KEL.typ.ntyp(E_Account().Typ) UID;
    KEL.typ.nkdate Exp1_;
    KEL.typ.nkdate Exp2_;
  END;
  SHARED __ST144700_Layout __ND147314__Project(__ST144491_Layout __PP147077) := TRANSFORM
    SELF.Exp1_ := IF(__T(__PP147077.Shows_Closed_Account_),__PP147077._load__date_,__N(KEL.typ.kdate));
    SELF.Exp2_ := IF(__T(__AND(__OP2(__PP147077._date__account__opened_,<=,__CN(__cfg.CurrentDate)),__NOT(__NT(__PP147077._date__account__opened_)))),__PP147077._load__date_,__N(KEL.typ.kdate));
    SELF := __PP147077;
  END;
  SHARED __EE147319 := PROJECT(__EE147076,__ND147314__Project(LEFT));
  SHARED __ST144720_Layout := RECORD
    KEL.typ.nkdate Most_Recent_Closed_Report_Date_;
    KEL.typ.nkdate Most_Recently_Open_Load_Date_;
    KEL.typ.ntyp(E_Account().Typ) UID;
  END;
  SHARED __EE147127 := PROJECT(__CLEANANDDO(__EE147319,TABLE(__EE147319,{KEL.Aggregates.MaxNG(__EE147319.Exp1_) Most_Recent_Closed_Report_Date_,KEL.Aggregates.MaxNG(__EE147319.Exp2_) Most_Recently_Open_Load_Date_,UID},UID,MERGE)),__ST144720_Layout);
  SHARED __ST144778_Layout := RECORD
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
    KEL.typ.nkdate Most_Recent_Closed_Report_Date_;
    KEL.typ.nkdate Most_Recently_Open_Load_Date_;
    KEL.typ.ntyp(E_Account().Typ) U_I_D__1_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC147133(__ST144737_Layout __EE144735, __ST144720_Layout __EE147127) := __EEQP(__EE144735.UID,__EE147127.UID);
  __ST144778_Layout __JT147133(__ST144737_Layout __l, __ST144720_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE147134 := JOIN(__EE144735,__EE147127,__JC147133(LEFT,RIGHT),__JT147133(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST140018_Layout := RECORD
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
    KEL.typ.nkdate Most_Recent_Closed_Report_Date_;
    KEL.typ.nkdate Most_Recently_Open_Load_Date_;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Account_9 := PROJECT(__EE147134,__ST140018_Layout);
END;
