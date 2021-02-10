//HPCC Systems KEL Compiler Version 1.3.2
#OPTION('expandSelectCreateRow',true);
IMPORT KEL13 AS KEL;
IMPORT CFG_graph,E_Account,E_Account_Bus_Owner,E_Account_Indiv_Owner,E_Account_Industry,E_Account_Tradeline,E_Business,E_Business_Account,E_Business_Industry,E_Business_Owner,E_Individual_Owner,E_Industry,E_Tradeline FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
 
RunAll := TRUE;
RunFast := FALSE;
RunSanityCheckSummary := FALSE;
RunInvalidSingleValues := FALSE;
RunUidSourceCounts := FALSE;
RunNullCounts := FALSE;
TopNUids := 10;
 
//Business sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Business().SanityCheck,NAMED('E_Business_SanityCheck')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Business().UIDSourceCounts,NAMED('E_Business_UIDSourceCounts')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Business().TopSourcedUIDs(TopNUids),NAMED('E_Business_TopSourcedUIDs')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Business().UIDSourceDistribution,NAMED('E_Business_UIDSourceDistribution')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Business().NullCounts,NAMED('E_Business_NullCounts')));
 
//Account sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Account().SanityCheck,NAMED('E_Account_SanityCheck')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Account()._seq__SingleValue_Invalid,NAMED('E_Account__seq__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Account()._ultid__SingleValue_Invalid,NAMED('E_Account__ultid__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Account()._orgid__SingleValue_Invalid,NAMED('E_Account__orgid__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Account()._seleid__SingleValue_Invalid,NAMED('E_Account__seleid__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Account()._proxid__SingleValue_Invalid,NAMED('E_Account__proxid__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Account()._powid__SingleValue_Invalid,NAMED('E_Account__powid__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Account()._empid__SingleValue_Invalid,NAMED('E_Account__empid__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Account()._dotid__SingleValue_Invalid,NAMED('E_Account__dotid__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Account()._ultscore__SingleValue_Invalid,NAMED('E_Account__ultscore__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Account()._orgscore__SingleValue_Invalid,NAMED('E_Account__orgscore__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Account()._selescore__SingleValue_Invalid,NAMED('E_Account__selescore__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Account()._proxscore__SingleValue_Invalid,NAMED('E_Account__proxscore__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Account()._powscore__SingleValue_Invalid,NAMED('E_Account__powscore__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Account()._empscore__SingleValue_Invalid,NAMED('E_Account__empscore__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Account()._dotscore__SingleValue_Invalid,NAMED('E_Account__dotscore__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Account()._ultweight__SingleValue_Invalid,NAMED('E_Account__ultweight__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Account()._orgweight__SingleValue_Invalid,NAMED('E_Account__orgweight__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Account()._seleweight__SingleValue_Invalid,NAMED('E_Account__seleweight__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Account()._proxweight__SingleValue_Invalid,NAMED('E_Account__proxweight__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Account()._powweight__SingleValue_Invalid,NAMED('E_Account__powweight__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Account()._empweight__SingleValue_Invalid,NAMED('E_Account__empweight__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Account()._dotweight__SingleValue_Invalid,NAMED('E_Account__dotweight__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Account()._dt__first__seen__SingleValue_Invalid,NAMED('E_Account__dt__first__seen__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Account()._dt__last__seen__SingleValue_Invalid,NAMED('E_Account__dt__last__seen__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Account()._dt__vendor__first__reported__SingleValue_Invalid,NAMED('E_Account__dt__vendor__first__reported__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Account()._dt__vendor__last__reported__SingleValue_Invalid,NAMED('E_Account__dt__vendor__last__reported__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Account()._dt__datawarehouse__first__reported__SingleValue_Invalid,NAMED('E_Account__dt__datawarehouse__first__reported__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Account()._dt__datawarehouse__last__reported__SingleValue_Invalid,NAMED('E_Account__dt__datawarehouse__last__reported__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Account()._did__SingleValue_Invalid,NAMED('E_Account__did__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Account()._did__score__SingleValue_Invalid,NAMED('E_Account__did__score__SingleValue_Invalid')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Account().UIDSourceCounts,NAMED('E_Account_UIDSourceCounts')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Account().TopSourcedUIDs(TopNUids),NAMED('E_Account_TopSourcedUIDs')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Account().UIDSourceDistribution,NAMED('E_Account_UIDSourceDistribution')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Account().NullCounts,NAMED('E_Account_NullCounts')));
 
//Tradeline sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Tradeline().SanityCheck,NAMED('E_Tradeline_SanityCheck')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._load__date__SingleValue_Invalid,NAMED('E_Tradeline__load__date__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._sbfe__contributor__number__SingleValue_Invalid,NAMED('E_Tradeline__sbfe__contributor__number__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._contract__account__number__SingleValue_Invalid,NAMED('E_Tradeline__contract__account__number__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._cycle__end__date__SingleValue_Invalid,NAMED('E_Tradeline__cycle__end__date__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._segment__identifier__SingleValue_Invalid,NAMED('E_Tradeline__segment__identifier__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._file__segment__num__SingleValue_Invalid,NAMED('E_Tradeline__file__segment__num__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._parent__sequence__number__SingleValue_Invalid,NAMED('E_Tradeline__parent__sequence__number__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._account__holder__business__name__SingleValue_Invalid,NAMED('E_Tradeline__account__holder__business__name__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._dba__SingleValue_Invalid,NAMED('E_Tradeline__dba__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._company__website__SingleValue_Invalid,NAMED('E_Tradeline__company__website__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._legal__business__structure__SingleValue_Invalid,NAMED('E_Tradeline__legal__business__structure__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._business__established__date__SingleValue_Invalid,NAMED('E_Tradeline__business__established__date__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._account__type__reported__SingleValue_Invalid,NAMED('E_Tradeline__account__type__reported__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._account__status__1__SingleValue_Invalid,NAMED('E_Tradeline__account__status__1__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._account__status__2__SingleValue_Invalid,NAMED('E_Tradeline__account__status__2__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._date__account__opened__SingleValue_Invalid,NAMED('E_Tradeline__date__account__opened__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._date__account__closed__SingleValue_Invalid,NAMED('E_Tradeline__date__account__closed__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._account__closure__basis__SingleValue_Invalid,NAMED('E_Tradeline__account__closure__basis__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._account__expiration__date__SingleValue_Invalid,NAMED('E_Tradeline__account__expiration__date__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._last__activity__date__SingleValue_Invalid,NAMED('E_Tradeline__last__activity__date__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._last__activity__type__SingleValue_Invalid,NAMED('E_Tradeline__last__activity__type__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._recent__activity__indicator__SingleValue_Invalid,NAMED('E_Tradeline__recent__activity__indicator__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._original__credit__limit__SingleValue_Invalid,NAMED('E_Tradeline__original__credit__limit__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._highest__credit__used__SingleValue_Invalid,NAMED('E_Tradeline__highest__credit__used__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._current__credit__limit__SingleValue_Invalid,NAMED('E_Tradeline__current__credit__limit__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._reporting__indicator__length__SingleValue_Invalid,NAMED('E_Tradeline__reporting__indicator__length__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._payment__interval__SingleValue_Invalid,NAMED('E_Tradeline__payment__interval__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._payment__status__category__SingleValue_Invalid,NAMED('E_Tradeline__payment__status__category__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline().D_B_T___V5__SingleValue_Invalid,NAMED('E_Tradeline_D_B_T___V5__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._raw__dbt__v5__SingleValue_Invalid,NAMED('E_Tradeline__raw__dbt__v5__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._overall__file__format__version__SingleValue_Invalid,NAMED('E_Tradeline__overall__file__format__version__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._term__of__account__in__months__SingleValue_Invalid,NAMED('E_Tradeline__term__of__account__in__months__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._first__payment__due__date__SingleValue_Invalid,NAMED('E_Tradeline__first__payment__due__date__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._final__pyament__due__date__SingleValue_Invalid,NAMED('E_Tradeline__final__pyament__due__date__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._original__rate__SingleValue_Invalid,NAMED('E_Tradeline__original__rate__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._floating__rate__SingleValue_Invalid,NAMED('E_Tradeline__floating__rate__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._grace__period__SingleValue_Invalid,NAMED('E_Tradeline__grace__period__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._payment__category__SingleValue_Invalid,NAMED('E_Tradeline__payment__category__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._payment__history__profile__12__months__SingleValue_Invalid,NAMED('E_Tradeline__payment__history__profile__12__months__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._payment__history__profile__13__24__months__SingleValue_Invalid,NAMED('E_Tradeline__payment__history__profile__13__24__months__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._payment__history__profile__25__36__months__SingleValue_Invalid,NAMED('E_Tradeline__payment__history__profile__25__36__months__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._payment__history__profile__37__48__months__SingleValue_Invalid,NAMED('E_Tradeline__payment__history__profile__37__48__months__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._payment__history__length__SingleValue_Invalid,NAMED('E_Tradeline__payment__history__length__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._year__to__date__purchases__count__SingleValue_Invalid,NAMED('E_Tradeline__year__to__date__purchases__count__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._lifetime__to__date__purchases__count__SingleValue_Invalid,NAMED('E_Tradeline__lifetime__to__date__purchases__count__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._year__to__date__purchases__sum__amount__SingleValue_Invalid,NAMED('E_Tradeline__year__to__date__purchases__sum__amount__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._lifetime__to__date__purchases__sum__amount__SingleValue_Invalid,NAMED('E_Tradeline__lifetime__to__date__purchases__sum__amount__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._payment__amount__scheduled__SingleValue_Invalid,NAMED('E_Tradeline__payment__amount__scheduled__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._recent__payment__amount__SingleValue_Invalid,NAMED('E_Tradeline__recent__payment__amount__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._recent__payment__date__SingleValue_Invalid,NAMED('E_Tradeline__recent__payment__date__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._remaining__balance__SingleValue_Invalid,NAMED('E_Tradeline__remaining__balance__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._carried__over__amount__SingleValue_Invalid,NAMED('E_Tradeline__carried__over__amount__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._new__applied__charges__SingleValue_Invalid,NAMED('E_Tradeline__new__applied__charges__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._balloon__payment__due__SingleValue_Invalid,NAMED('E_Tradeline__balloon__payment__due__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._balloon__payment__due__date__SingleValue_Invalid,NAMED('E_Tradeline__balloon__payment__due__date__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._delinquency__date__SingleValue_Invalid,NAMED('E_Tradeline__delinquency__date__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._days__delinquent__SingleValue_Invalid,NAMED('E_Tradeline__days__delinquent__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._past__due__amount__SingleValue_Invalid,NAMED('E_Tradeline__past__due__amount__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._maximum__number__of__past__due__aging__amounts__buckets__provided__SingleValue_Invalid,NAMED('E_Tradeline__maximum__number__of__past__due__aging__amounts__buckets__provided__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._past__due__aging__bucket__type__SingleValue_Invalid,NAMED('E_Tradeline__past__due__aging__bucket__type__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._past__due__aging__amount__bucket__1__SingleValue_Invalid,NAMED('E_Tradeline__past__due__aging__amount__bucket__1__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._past__due__aging__amount__bucket__2__SingleValue_Invalid,NAMED('E_Tradeline__past__due__aging__amount__bucket__2__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._past__due__aging__amount__bucket__3__SingleValue_Invalid,NAMED('E_Tradeline__past__due__aging__amount__bucket__3__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._past__due__aging__amount__bucket__4__SingleValue_Invalid,NAMED('E_Tradeline__past__due__aging__amount__bucket__4__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._past__due__aging__amount__bucket__5__SingleValue_Invalid,NAMED('E_Tradeline__past__due__aging__amount__bucket__5__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._past__due__aging__amount__bucket__6__SingleValue_Invalid,NAMED('E_Tradeline__past__due__aging__amount__bucket__6__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._past__due__aging__amount__bucket__7__SingleValue_Invalid,NAMED('E_Tradeline__past__due__aging__amount__bucket__7__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._maximum__number__of__payment__tracking__cycle__periods__provided__SingleValue_Invalid,NAMED('E_Tradeline__maximum__number__of__payment__tracking__cycle__periods__provided__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._payment__tracking__cycle__type__SingleValue_Invalid,NAMED('E_Tradeline__payment__tracking__cycle__type__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._payment__tracking__cycle__0__current__SingleValue_Invalid,NAMED('E_Tradeline__payment__tracking__cycle__0__current__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._payment__tracking__cycle__1__1__30__days__SingleValue_Invalid,NAMED('E_Tradeline__payment__tracking__cycle__1__1__30__days__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._payment__tracking__cycle__2__31__60__days__SingleValue_Invalid,NAMED('E_Tradeline__payment__tracking__cycle__2__31__60__days__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._payment__tracking__cycle__3__61__90__days__SingleValue_Invalid,NAMED('E_Tradeline__payment__tracking__cycle__3__61__90__days__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._payment__tracking__cycle__4__91__120__days__SingleValue_Invalid,NAMED('E_Tradeline__payment__tracking__cycle__4__91__120__days__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._payment__tracking__cycle__5__121__150days__SingleValue_Invalid,NAMED('E_Tradeline__payment__tracking__cycle__5__121__150days__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._payment__tracking__number__of__times__cycle__6__151__180__days__SingleValue_Invalid,NAMED('E_Tradeline__payment__tracking__number__of__times__cycle__6__151__180__days__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._payment__tracking__number__of__times__cycle__7__181__or__greater__days__SingleValue_Invalid,NAMED('E_Tradeline__payment__tracking__number__of__times__cycle__7__181__or__greater__days__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._date__account__was__charged__off__SingleValue_Invalid,NAMED('E_Tradeline__date__account__was__charged__off__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._amount__charged__off__by__creditor__SingleValue_Invalid,NAMED('E_Tradeline__amount__charged__off__by__creditor__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._charge__off__type__indicator__SingleValue_Invalid,NAMED('E_Tradeline__charge__off__type__indicator__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._total__charge__off__recoveries__to__date__SingleValue_Invalid,NAMED('E_Tradeline__total__charge__off__recoveries__to__date__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._government__guarantee__flag__SingleValue_Invalid,NAMED('E_Tradeline__government__guarantee__flag__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._government__guarantee__category__SingleValue_Invalid,NAMED('E_Tradeline__government__guarantee__category__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._portion__of__account__guaranteed__by__government__SingleValue_Invalid,NAMED('E_Tradeline__portion__of__account__guaranteed__by__government__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._guarantors__indicator__SingleValue_Invalid,NAMED('E_Tradeline__guarantors__indicator__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._number__of__guarantors__SingleValue_Invalid,NAMED('E_Tradeline__number__of__guarantors__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._owners__indicator__SingleValue_Invalid,NAMED('E_Tradeline__owners__indicator__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._number__of__principals__SingleValue_Invalid,NAMED('E_Tradeline__number__of__principals__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline()._account__update__deletion__indicator__SingleValue_Invalid,NAMED('E_Tradeline__account__update__deletion__indicator__SingleValue_Invalid')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Tradeline().UIDSourceCounts,NAMED('E_Tradeline_UIDSourceCounts')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Tradeline().TopSourcedUIDs(TopNUids),NAMED('E_Tradeline_TopSourcedUIDs')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Tradeline().UIDSourceDistribution,NAMED('E_Tradeline_UIDSourceDistribution')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Tradeline().NullCounts,NAMED('E_Tradeline_NullCounts')));
 
//Industry sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Industry().SanityCheck,NAMED('E_Industry_SanityCheck')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Industry()._record__type__SingleValue_Invalid,NAMED('E_Industry__record__type__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Industry()._sbfe__contributor__number__SingleValue_Invalid,NAMED('E_Industry__sbfe__contributor__number__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Industry()._contract__account__number__SingleValue_Invalid,NAMED('E_Industry__contract__account__number__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Industry()._dt__first__seen__SingleValue_Invalid,NAMED('E_Industry__dt__first__seen__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Industry()._dt__last__seen__SingleValue_Invalid,NAMED('E_Industry__dt__last__seen__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Industry()._classification__code__type__SingleValue_Invalid,NAMED('E_Industry__classification__code__type__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Industry()._classification__code__SingleValue_Invalid,NAMED('E_Industry__classification__code__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Industry()._primary__industry__code__indicator__SingleValue_Invalid,NAMED('E_Industry__primary__industry__code__indicator__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Industry()._privacy__indicator__SingleValue_Invalid,NAMED('E_Industry__privacy__indicator__SingleValue_Invalid')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Industry().UIDSourceCounts,NAMED('E_Industry_UIDSourceCounts')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Industry().TopSourcedUIDs(TopNUids),NAMED('E_Industry_TopSourcedUIDs')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Industry().UIDSourceDistribution,NAMED('E_Industry_UIDSourceDistribution')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Industry().NullCounts,NAMED('E_Industry_NullCounts')));
 
//BusinessOwner sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Business_Owner().SanityCheck,NAMED('E_Business_Owner_SanityCheck')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Owner()._sbfe__contributor__number__SingleValue_Invalid,NAMED('E_Business_Owner__sbfe__contributor__number__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Owner()._contract__account__number__SingleValue_Invalid,NAMED('E_Business_Owner__contract__account__number__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Owner()._account__type__reported__SingleValue_Invalid,NAMED('E_Business_Owner__account__type__reported__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Owner()._dt__first__seen__SingleValue_Invalid,NAMED('E_Business_Owner__dt__first__seen__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Owner()._dt__last__seen__SingleValue_Invalid,NAMED('E_Business_Owner__dt__last__seen__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Owner()._dt__vendor__first__reported__SingleValue_Invalid,NAMED('E_Business_Owner__dt__vendor__first__reported__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Owner()._dt__vendor__last__reported__SingleValue_Invalid,NAMED('E_Business_Owner__dt__vendor__last__reported__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Owner()._dt__datawarehouse__first__reported__SingleValue_Invalid,NAMED('E_Business_Owner__dt__datawarehouse__first__reported__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Owner()._dt__datawarehouse__last__reported__SingleValue_Invalid,NAMED('E_Business_Owner__dt__datawarehouse__last__reported__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Owner()._business__name__SingleValue_Invalid,NAMED('E_Business_Owner__business__name__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Owner()._web__address__SingleValue_Invalid,NAMED('E_Business_Owner__web__address__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Owner()._guarantor__owner__indicator__SingleValue_Invalid,NAMED('E_Business_Owner__guarantor__owner__indicator__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Owner()._relationship__to__business__indicator__SingleValue_Invalid,NAMED('E_Business_Owner__relationship__to__business__indicator__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Owner()._percent__of__liability__SingleValue_Invalid,NAMED('E_Business_Owner__percent__of__liability__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Owner()._percent__of__ownership__if__owner__principal__SingleValue_Invalid,NAMED('E_Business_Owner__percent__of__ownership__if__owner__principal__SingleValue_Invalid')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Business_Owner().UIDSourceCounts,NAMED('E_Business_Owner_UIDSourceCounts')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Business_Owner().TopSourcedUIDs(TopNUids),NAMED('E_Business_Owner_TopSourcedUIDs')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Business_Owner().UIDSourceDistribution,NAMED('E_Business_Owner_UIDSourceDistribution')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Business_Owner().NullCounts,NAMED('E_Business_Owner_NullCounts')));
 
//IndividualOwner sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Individual_Owner().SanityCheck,NAMED('E_Individual_Owner_SanityCheck')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Individual_Owner()._sbfe__contributor__number__SingleValue_Invalid,NAMED('E_Individual_Owner__sbfe__contributor__number__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Individual_Owner()._contract__account__number__SingleValue_Invalid,NAMED('E_Individual_Owner__contract__account__number__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Individual_Owner()._account__type__reported__SingleValue_Invalid,NAMED('E_Individual_Owner__account__type__reported__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Individual_Owner()._dt__first__seen__SingleValue_Invalid,NAMED('E_Individual_Owner__dt__first__seen__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Individual_Owner()._dt__last__seen__SingleValue_Invalid,NAMED('E_Individual_Owner__dt__last__seen__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Individual_Owner()._dt__vendor__first__reported__SingleValue_Invalid,NAMED('E_Individual_Owner__dt__vendor__first__reported__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Individual_Owner()._dt__vendor__last__reported__SingleValue_Invalid,NAMED('E_Individual_Owner__dt__vendor__last__reported__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Individual_Owner()._dt__datawarehouse__first__reported__SingleValue_Invalid,NAMED('E_Individual_Owner__dt__datawarehouse__first__reported__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Individual_Owner()._dt__datawarehouse__last__reported__SingleValue_Invalid,NAMED('E_Individual_Owner__dt__datawarehouse__last__reported__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Individual_Owner()._first__name__SingleValue_Invalid,NAMED('E_Individual_Owner__first__name__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Individual_Owner()._middle__name__SingleValue_Invalid,NAMED('E_Individual_Owner__middle__name__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Individual_Owner()._last__name__SingleValue_Invalid,NAMED('E_Individual_Owner__last__name__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Individual_Owner()._suffix__SingleValue_Invalid,NAMED('E_Individual_Owner__suffix__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Individual_Owner()._e__mail__address__SingleValue_Invalid,NAMED('E_Individual_Owner__e__mail__address__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Individual_Owner()._guarantor__owner__indicator__SingleValue_Invalid,NAMED('E_Individual_Owner__guarantor__owner__indicator__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Individual_Owner()._relationship__to__business__indicator__SingleValue_Invalid,NAMED('E_Individual_Owner__relationship__to__business__indicator__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Individual_Owner()._business__title__SingleValue_Invalid,NAMED('E_Individual_Owner__business__title__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Individual_Owner()._percent__of__liability__SingleValue_Invalid,NAMED('E_Individual_Owner__percent__of__liability__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Individual_Owner()._percent__of__ownership__SingleValue_Invalid,NAMED('E_Individual_Owner__percent__of__ownership__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Individual_Owner()._source__SingleValue_Invalid,NAMED('E_Individual_Owner__source__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Individual_Owner()._active__SingleValue_Invalid,NAMED('E_Individual_Owner__active__SingleValue_Invalid')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Individual_Owner().UIDSourceCounts,NAMED('E_Individual_Owner_UIDSourceCounts')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Individual_Owner().TopSourcedUIDs(TopNUids),NAMED('E_Individual_Owner_TopSourcedUIDs')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Individual_Owner().UIDSourceDistribution,NAMED('E_Individual_Owner_UIDSourceDistribution')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Individual_Owner().NullCounts,NAMED('E_Individual_Owner_NullCounts')));
 
//BusinessAccount sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Business_Account().SanityCheck,NAMED('E_Business_Account_SanityCheck')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Business_Account().NullCounts,NAMED('E_Business_Account_NullCounts')));
 
//AccountTradeline sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Account_Tradeline().SanityCheck,NAMED('E_Account_Tradeline_SanityCheck')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Account_Tradeline().NullCounts,NAMED('E_Account_Tradeline_NullCounts')));
 
//BusinessIndustry sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Business_Industry().SanityCheck,NAMED('E_Business_Industry_SanityCheck')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Business_Industry().NullCounts,NAMED('E_Business_Industry_NullCounts')));
 
//AccountIndustry sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Account_Industry().SanityCheck,NAMED('E_Account_Industry_SanityCheck')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Account_Industry().NullCounts,NAMED('E_Account_Industry_NullCounts')));
 
//AccountBusOwner sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Account_Bus_Owner().SanityCheck,NAMED('E_Account_Bus_Owner_SanityCheck')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Account_Bus_Owner().NullCounts,NAMED('E_Account_Bus_Owner_NullCounts')));
 
//AccountIndivOwner sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Account_Indiv_Owner().SanityCheck,NAMED('E_Account_Indiv_Owner_SanityCheck')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Account_Indiv_Owner().NullCounts,NAMED('E_Account_Indiv_Owner_NullCounts')));
