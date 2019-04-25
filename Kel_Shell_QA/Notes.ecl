EXPORT Notes := 'todo';

AC07 - Check BkCnt1Y range 0~99, BkCnt7Y range 0~99, BkCnt10Y range 0~999 (except for -99999) 


BkCnt1Y == -99999 or BkCnt1Y in range(0, 100)
BkCnt7Y == -99999 or BkCnt7Y in range(0, 100)
BkCnt10Y == -99999 or BkCnt10Y in range(0, 100)

AC08 - Check dates in DtOfBksList1Y, DtOfBksList7Y, DtOfBksList10Y are ordered from earliest to latest 


"  sorted(list(map(int, ' DtOfBksList1Y '.split('|') )),reverse=False) == list(map(int,' DtOfBksList1Y '.split('|')))"
"  sorted(list(map(int, ' DtOfBksList7Y '.split('|') )),reverse=False) == list(map(int,' DtOfBksList7Y '.split('|')))"
"  sorted(list(map(int, ' DtOfBksList10Y '.split('|') )),reverse=False) == list(map(int,' DtOfBksList10Y '.split('|')))"


Check when BkCnt1Y, BkCnt7Y, BkCnt10Y = 0, DtOfBksList1Y, DtOfBksList7Y, DtOfBksList10Y = -99998 

( BkCnt1Y <> 0) or ( BkCnt1Y == 0 and DtOfBksList1Y == -99998 )
( BkCnt7Y <> 0) or ( BkCnt7Y == 0 and DtOfBksList7Y == -99998 )
( BkCnt10Y <> 0) or ( BkCnt10Y == 0 and DtOfBksList10Y == -99998 )

AC10 - Check when DtOfBksList1Y not in (-99998,-99999), # of items in DtOfBksList1Y = BkCnt1Y 

" DtOfBksList1Y in [-99998,-99999] or int( len ( ' DtOfBksList1Y   '.split ('|')))== int( BkCnt1Y )"

AC11 - Check when DtOfBksList7Y not in (-99998,-99999), # of items in DtOfBksList7Y = BkCnt7Y 

" DtOfBksList7Y in [-99998,-99999] or int( len ( ' DtOfBksList7Y   '.split ('|')))== int( BkCnt7Y )"


AC12 - Check when DtOfBksList10Y not in (-99998,-99999), # of items in DtOfBksList10Y = BkCnt10Y 

" DtOfBksList10Y in [-99998,-99999] or int( len ( ' DtOfBksList10Y   '.split ('|')))== int( BkCnt10Y )"

AC13 - Check MonSinceNewestBkCnt1Y and MonSinceOldestBkCnt1Y range 0~12 (except for -99999, -99998) 

MonSinceNewestBkCnt1Y in [-99999, -99998] or MonSinceNewestBkCnt1Y in range(0, 13)
MonSinceOldestBkCnt1Y in [-99999, -99998] or MonSinceOldestBkCnt1Y in range(0, 13)

AC14 - Check MonSinceNewestBkCnt7Y and MonSinceOldestBkCnt7Y range 0~84 (except for -99999, -99998)

MonSinceNewestBkCnt7Y in [-99999, -99998] or MonSinceNewestBkCnt7Y in range(0, 85)
MonSinceOldestBkCnt7Y in [-99999, -99998] or MonSinceOldestBkCnt7Y in range(0, 85)
 
AC15 - Check MonSinceNewestBkCnt10Y and MonSinceOldestBkCnt10Y range 0~120 (except for -99999, -99998) 

MonSinceNewestBkCnt10Y in [-99999, -99998] or MonSinceNewestBkCnt10Y in range(0, 121)
MonSinceOldestBkCnt10Y in [-99999, -99998] or MonSinceOldestBkCnt10Y in range(0, 121)

AC16 - Check # of months between [MIN(InputArchiveDateClean, BkHistoryBuild), BkNew1Y] = MonSinceNewestBkCnt1Y (except for -99999, -99998) 
InputArchiveDateClean BkHistoryBuild BkNew1Y MonSinceNewestBkCnt1Y

AC17 - Check # of months between [MIN(InputArchiveDateClean, BkHistoryBuild), BkOld1Y] = MonSinceOldestBkCnt1Y (except for -99999, -99998) 
InputArchiveDateClean BkHistoryBuild BkOld1Y MonSinceOldestBkCnt1Y

AC18 - Check # of months between [MIN(InputArchiveDateClean, BkHistoryBuild), BkNew7Y] = MonSinceNewestBkCnt7Y (except for -99999, -99998) 
InputArchiveDateClean BkHistoryBuild BkNew7Y MonSinceNewestBkCnt7Y

AC19 - Check # of months between [MIN(InputArchiveDateClean, BkHistoryBuild), BkOld7Y] = MonSinceOldestBkCnt7Y (except for -99999, -99998) 
InputArchiveDateClean BkHistoryBuild BkOld7Y MonSinceOldestBkCnt7Y


AC20 - Check # of months between [MIN(InputArchiveDateClean, BkHistoryBuild), BkNew10Y] = MonSinceNewestBkCnt10Y (except for -99999, -99998) 
InputArchiveDateClean BkHistoryBuild BkNew10Y MonSinceNewestBkCnt10Y

AC21 - Check # of months between [MIN(InputArchiveDateClean, BkHistoryBuild), BkOld10Y] = MonSinceOldestBkCnt10Y (except for -99999, -99998) 
InputArchiveDateClean BkHistoryBuild BkOld10Y MonSinceOldestBkCnt10Y


AC22 - Check BkCnt1Y <= BkCnt7Y <= BkCnt10Y 

BkCnt1Y <= BkCnt7Y <= BkCnt10Y 


AC23 - Check BkNew1Y = BkNew7Y = BkNew10Y (except for -99999, -99998) 

( BkNew1Y in [-99999, -99998]) or ( BkNew7Y in [-99999, -99998]) or ( BkNew10Y in [-99999, -99998]) or ( BkNew1Y == BkNew7Y == BkNew10Y )


AC24 - Check BkOld1Y >= BkOld7Y >= BkOld10Y (except for -99999, -99998) 


( BkOld1Y in [-99999, -99998]) or ( BkOld7Y in [-99999, -99998]) or ( BkOld10Y in [-99999, -99998]) or ( BkOld1Y >= BkOld7Y >= BkOld10Y )


AC25 - Check MonSinceNewestBkCnt1Y = MonSinceNewestBkCnt7Y = MonSinceNewestBkCnt10Y (except for -99999, -99998) 
( MonSinceNewestBkCnt1Y in [-99999, -99998]) or ( MonSinceNewestBkCnt7Y in [-99999, -99998]) or ( MonSinceNewestBkCnt10Y in [-99999, -99998]) or ( MonSinceNewestBkCnt1Y == MonSinceNewestBkCnt7Y == MonSinceNewestBkCnt10Y )


AC26 - Check MonSinceOldestBkCnt1Y <= MonSinceOldestBkCnt7Y <= MonSinceOldestBkCnt10Y (except for -99999, -99998) 
( MonSinceOldestBkCnt1Y in [-99999, -99998]) or ( MonSinceOldestBkCnt7Y) or (MonSinceOldestBkCnt10Y in [-99999, -99998]) or ( MonSinceOldestBkCnt1Y <= MonSinceOldestBkCnt7Y <= MonSinceOldestBkCnt10Y )


AC27 - Check MonSinceNewestBkCnt1Y <= MonSinceOldestBkCnt1Y (except for -99999, -99998) 
( MonSinceNewestBkCnt1Y in [-99999, -99998]) or ( MonSinceOldestBkCnt1Y in [-99999, -99998])) or ( MonSinceNewestBkCnt1Y <= MonSinceOldestBkCnt1Y )


AC28 - Check MonSinceNewestBkCnt7Y <= MonSinceOldestBkCnt7Y (except for -99999, -99998) 
( MonSinceNewestBkCnt7Y in [-99999, -99998]) or ( MonSinceOldestBkCnt7Y in [-99999, -99998])) or ( MonSinceNewestBkCnt7Y <= MonSinceOldestBkCnt7Y )

AC29 - Check MonSinceNewestBkCnt10Y <= MonSinceOldestBkCnt10Y (except for -99999, -99998) 
( MonSinceNewestBkCnt10Y in [-99999, -99998]) or (MonSinceOldestBkCnt10Y)) or ( MonSinceNewestBkCnt10Y <= MonSinceOldestBkCnt10Y )

AC30 - Check when BkCnt1Y=0, then BkNew1Y=BkOld1Y=MonSinceNewestBkCnt1Y=MonSinceOldestBkCnt1Y=-99998 
( BkCnt1Y <> 0) or ( BkCnt1Y == 0 and BkNew1Y == BkOld1Y == MonSinceNewestBkCnt1Y == MonSinceOldestBkCnt1Y == -99998 )


AC31 - Check when BkCnt7Y=0, then BkNew7Y=BkOld7Y=MonSinceNewestBkCnt7Y=MonSinceOldestBkCnt7Y=-99998 
( BkCnt7Y <> 0) or ( BkCnt7Y == 0 and BkNew7Y == BkOld7Y == MonSinceNewestBkCnt7Y == MonSinceOldestBkCnt7Y == -99998 )


AC32 - Check when BkCnt10Y=0, then BkNew10Y=BkOld10Y=MonSinceNewestBkCnt10Y=MonSinceOldestBkCnt10Y=-99998 
( BkCnt10Y <> 0) or ( BkCnt10Y == 0 and BkNew10Y == BkOld10Y == MonSinceNewestBkCnt10Y == MonSinceOldestBkCnt10Y == -99998 )


AC33 - Check when BkCnt1Y>0, then BkNew1Y=BkNew7Y=BkNew10Y
( BkCnt1Y <= 0) or ( BkCnt1Y > 0 and BkNew1Y == BkNew7Y == BkNew10Y )



AC07 - Check # months between [UpdateToAnyBkNew1Y, MIN(InputArchiveDateClean, BkHistoryBuild)] = MonSinceNewestBkUpdatedCnt1Y (except for -99999, -99998, -99997) 
InputArchiveDateClean BkHistoryBuild UpdateToAnyBkNew1Y MonSinceNewestBkUpdatedCnt1Y

AC08 - Check # months between [UpdateToAnyBkNew7Y, MIN(InputArchiveDateClean, BkHistoryBuild)] = MonSinceNewestBkUpdatedCnt7Y (except for -99999, -99998, -99997) 
InputArchiveDateClean BkHistoryBuild UpdateToAnyBkNew7Y MonSinceNewestBkUpdatedCnt7Y

AC09 - Check # months between [UpdateToAnyBkNew10Y, MIN(InputArchiveDateClean, BkHistoryBuild)] = MonSinceNewestBkUpdatedCnt10Y (except for -99999, -99998, -99997) 
InputArchiveDateClean BkHistoryBuild UpdateToAnyBkNew10Y MonSinceNewestBkUpdatedCnt10Y
 
AC10 - Check MonSinceNewestBkUpdatedCnt1Y range 0~12, MonSinceNewestBkUpdatedCnt7Y range 0~84, MonSinceNewestBkUpdatedCnt10Y range 0~120 (except for -99999, -99998, -99997)

MonSinceNewestBkUpdatedCnt1Y in [-99999, -99998, -99997] or MonSinceNewestBkUpdatedCnt1Y in range(0, 13)
MonSinceNewestBkUpdatedCnt7Y in [-99999, -99998, -99997] or MonSinceNewestBkUpdatedCnt7Y in range(0, 85)
MonSinceNewestBkUpdatedCnt10Y in [-99999, -99998, -99997] or MonSinceNewestBkUpdatedCnt10Y in range(0, 121)


AC07 - Check when DispOfBksList1Y not in (-99999, -99998), # of items in DispOfBksList1Y = BkCnt1Y 
" DispOfBksList1Y in [-99998,-99999] or int( len ( ' DispOfBksList1Y   '.split ('|')))== int( BkCnt1Y )"

AC08 - Check when DispOfBksList7Y not in (-99999, -99998), # of items in DispOfBksList7Y = BkCnt7Y 
" DispOfBksList7Y in [-99998,-99999] or int( len ( ' DispOfBksList7Y   '.split ('|')))== int( BkCnt7Y )"

AC09 - Check when DispOfBksList10Y not in (-99999, -99998), # of items in DispOfBksList10Y = BkCnt10Y 
" DispOfBksList10Y in [-99998,-99999] or int( len ( ' DispOfBksList10Y   '.split ('|')))== int( BkCnt10Y )"

AC10 - Check when DispOfBksList1Y not in (-99999, -99998), BkWithNewestDateDisp1Y = last item in DispOfBksList1Y 
" ( DispOfBksList1Y in [-99998,-99999] ) or int( ' DispOfBksList1Y '.split ('|')[-1]) == int( BkWithNewestDateDisp1Y )"

AC11 - Check when DispOfBksList7Y not in (-99999, -99998), BkWithNewestDateDisp7Y = last item in DispOfBksList7Y 
" ( DispOfBksList7Y in [-99998,-99999] ) or int( ' DispOfBksList7Y '.split ('|')[-1]) == int( BkWithNewestDateDisp7Y )"


AC12 - Check when DispOfBksList10Y not in (-99999, -99998), BkWithNewestDateDisp10Y = last item in DispOfBksList10Y
" ( DispOfBksList10Y in [-99998,-99999] ) or int( ' DispOfBksList10Y '.split ('|')[-1]) == int( BkWithNewestDateDisp10Y )"

 
AC13 - Check MonSinceDispOfNewestBkCnt1Y range 0~12, MonSinceDispOfNewestBkCnt7Y range 0~84, MonSinceDispOfNewestBkCnt10Y range 0~120 (except for -99999, -99998, -99997) 

MonSinceDispOfNewestBkCnt1Y in [-99999, -99998, -99997] or MonSinceDispOfNewestBkCnt1Y in range(0, 13)
MonSinceDispOfNewestBkCnt7Y in [-99999, -99998, -99997] or MonSinceDispOfNewestBkCnt7Y in range(0, 85)
MonSinceDispOfNewestBkCnt10Y in [-99999, -99998, -99997] or MonSinceDispOfNewestBkCnt10Y in range(0, 121)


AC14 - Check # months between [DispOfNewestBkDt1Y, MIN(InputArchiveDateClean, BkHistoryBuild)] = MonSinceDispOfNewestBkCnt1Y (except for -99999, -99998, -99997) 
InputArchiveDateClean  BkHistoryBuild DispOfNewestBkDt1Y MonSinceDispOfNewestBkCnt1Y

AC15 - Check # months between [DispOfNewestBkDt7Y, MIN(InputArchiveDateClean, BkHistoryBuild)] = MonSinceDispOfNewestBkCnt7Y (except for -99999, -99998, -99997) 
InputArchiveDateClean  BkHistoryBuild DispOfNewestBkDt7Y MonSinceDispOfNewestBkCnt7Y

AC16 - Check # months between [DispOfNewestBkDt10Y, MIN(InputArchiveDateClean, BkHistoryBuild)] = MonSinceDispOfNewestBkCnt10Y (except for -99999, -99998, -99997) 
InputArchiveDateClean BkHistoryBuild DispOfNewestBkDt10Y MonSinceDispOfNewestBkCnt10Y

AC17 - Check BkWithNewestDateDisp1Y, BkWithNewestDateDisp7Y, BkWithNewestDateDisp10Y return one of ['DISCHARGED', 'DISMISSED', 'WITHDRAWN'] (except for -99999, -99998, -99997)

str( BkWithNewestDateDisp1Y ) in ['DISCHARGED', 'DISMISSED', 'WITHDRAWN'] or  int( BkWithNewestDateDisp1Y ) in [-99999, -99998, -99997]
str( BkWithNewestDateDisp7Y ) in ['DISCHARGED', 'DISMISSED', 'WITHDRAWN'] or  int( BkWithNewestDateDisp7Y ) in [-99999, -99998, -99997]
str( BkWithNewestDateDisp10Y ) in ['DISCHARGED', 'DISMISSED', 'WITHDRAWN'] or  int( BkWithNewestDateDisp10Y ) in [-99999, -99998, -99997]
  
AC18 - Check BkDismissedCnt1Y, BkDischargedCnt1Y range 0~99 (except for -99999, -99998, -99997) 
BkDismissedCnt1Y in [-99999, -99998, -99997] or BkDismissedCnt1Y in range(0, 100)
BkDischargedCnt1Y in [-99999, -99998, -99997] or BkDischargedCnt1Y in range(0, 100)

AC19 - Check BkDismissedCnt7Y, BkDischargedCnt7Y range 0~99 (except for -99999, -99998, -99997) 
BkDismissedCnt7Y in [-99999, -99998, -99997] or BkDismissedCnt7Y in range(0, 100)
BkDischargedCnt7Y in [-99999, -99998, -99997] or BkDischargedCnt7Y in range(0, 100)

AC20 - Check BkDismissedCnt10Y, BkDischargedCnt10Y range 0~99 (except for -99999, -99998, -99997) 
BkDismissedCnt10Y in [-99999, -99998, -99997] or BkDismissedCnt10Y in range(0, 100)
BkDischargedCnt10Y in [-99999, -99998, -99997] or BkDischargedCnt10Y in range(0, 100)

AC21 - Check when BkDisposedCnt1Y = 0, then BkDismissedCnt1Y = BkDischargedCnt1Y = -99997 
( BkDisposedCnt1Y <> 0) or ( BkDisposedCnt1Y == 0 and BkDismissedCnt1Y == BkDischargedCnt1Y == -99997 )


AC22 - Check when BkDisposedCnt7Y = 0, then BkDismissedCnt7Y = BkDischargedCnt7Y = -99997 
( BkDisposedCnt7Y <> 0) or ( BkDisposedCnt7Y == 0 and BkDismissedCnt7Y == BkDischargedCnt7Y == -99997 )

AC23 - Check when BkDisposedCnt10Y = 0, then BkDismissedCnt10Y = BkDischargedCnt10Y = -99997 
( BkDisposedCnt10Y <> 0) or ( BkDisposedCnt10Y == 0 and BkDismissedCnt10Y == BkDischargedCnt10Y == -99997 )

AC24 - Check when BkDisposedCnt1Y not in (-99999, -99998, 0), then BkDisposedCnt1Y >= BkDismissedCnt1Y + BkDischargedCnt1Y >= 0 
( BkDisposedCnt1Y in [-99999, -99998, 0] ) or (  BkDisposedCnt1Y not in [-99999, -99998, 0] and BkDisposedCnt1Y >= ( BkDismissedCnt1Y + BkDischargedCnt1Y ) >= 0 )

AC25 - Check when BkDisposedCnt7Y not in (-99999, -99998, 0), then BkDisposedCnt7Y >= BkDismissedCnt7Y + BkDischargedCnt7Y >= 0 
( BkDisposedCnt7Y in [-99999, -99998, 0] ) or (  BkDisposedCnt7Y not in [-99999, -99998, 0] and BkDisposedCnt7Y >= ( BkDismissedCnt7Y + BkDischargedCnt7Y ) >= 0  )

AC26 - Check when BkDisposedCnt10Y not in (-99999, -99998, 0), then BkDisposedCnt10Y >= BkDismissedCnt10Y + BkDischargedCnt10Y >= 0
( BkDisposedCnt10Y in [-99999, -99998, 0] ) or (  BkDisposedCnt10Y not in [-99999, -99998, 0] and BkDisposedCnt10Y >= ( BkDismissedCnt10Y + BkDischargedCnt10Y ) >= 0 )



AC07 - Check when ChForBksList1Y not in (-99999, -99998), # of items in ChForBksList1Y = BkCnt1Y 
" ChForBksList1Y in [-99998,-99999] or int( len ( ' ChForBksList1Y   '.split ('|')))== int( BkCnt1Y )"

AC08 - Check when ChForBksList7Y not in (-99999, -99998), # of items in ChForBksList7Y = BkCnt7Y 
" ChForBksList7Y in [-99998,-99999] or int( len ( ' ChForBksList7Y   '.split ('|')))== int( BkCnt7Y )"

AC09 - Check when ChForBksList10Y not in (-99999, -99998), # of items in ChForBksList10Y = BkCnt10Y 
" ChForBksList10Y in [-99998,-99999] or int( len ( ' ChForBksList10Y   '.split ('|')))== int( BkCnt10Y )"

AC10 - Check when ChForBksList1Y not in (-99999, -99998), BkWithNewestDateCh1Y = last item in ChForBksList1Y 
" ( ChForBksList1Y in [-99998,-99999] ) or int( ' ChForBksList1Y '.split ('|')[-1]) == int( BkWithNewestDateCh1Y )"

AC11 - Check when ChForBksList7Y not in (-99999, -99998), BkWithNewestDateCh7Y = last item in ChForBksList7Y 
" ( ChForBksList7Y in [-99998,-99999] ) or int( ' ChForBksList7Y '.split ('|')[-1]) == int( BkWithNewestDateCh7Y )"

AC12 - Check when ChForBksList10Y not in (-99999, -99998), BkWithNewestDateCh10Y = last item in ChForBksList10Y 
" ( ChForBksList10Y in [-99998,-99999] ) or int( ' ChForBksList10Y '.split ('|')[-1]) == int( BkWithNewestDateCh10Y )"

AC13 - Check BkUnderCh7Cnt1Y, BkUnderCh7Cnt7Y, BkUnderCh7Cnt10Y, BkUnderCh13Cnt1Y, BkUnderCh13Cnt7Y, BkUnderCh13Cnt10Y range 0~99 (except for -99999, -99998, -99997) 
BkUnderCh7Cnt1Y in [-99999, -99998, -99997] or BkUnderCh7Cnt1Y in range(0, 100)
BkUnderCh7Cnt7Y in [-99999, -99998, -99997] or BkUnderCh7Cnt7Y in range(0, 100)
BkUnderCh7Cnt10Y in [-99999, -99998, -99997] or BkUnderCh7Cnt10Y in range(0, 100)
BkUnderCh13Cnt1Y in [-99999, -99998, -99997] or BkUnderCh13Cnt1Y in range(0, 100)
BkUnderCh13Cnt7Y in [-99999, -99998, -99997] or BkUnderCh13Cnt7Y in range(0, 100)
BkUnderCh13Cnt10Y in [-99999, -99998, -99997] or BkUnderCh13Cnt10Y in range(0, 100)


AC14 - Check BkUnderCh7Cnt1Y <= BkUnderCh7Cnt7Y <= BkUnderCh7Cnt10Y (except for -99999, -99998, -99997) 
( BkUnderCh7Cnt1Y in [-99999, -99998, -99997] or BkUnderCh7Cnt7Y in [-99999, -99998, -99997] or BkUnderCh7Cnt10Y in [-99999, -99998, -99997] ) or ( BkUnderCh7Cnt1Y <= BkUnderCh7Cnt7Y <= BkUnderCh7Cnt10Y )

AC15 - Check BkUnderCh13Cnt1Y <= BkUnderCh13Cnt7Y <= BkUnderCh13Cnt10Y (except for -99999, -99998, -99997)
( BkUnderCh13Cnt1Y in [-99999, -99998, -99997] or BkUnderCh13Cnt7Y in [-99999, -99998, -99997] or BkUnderCh13Cnt10Y in [-99999, -99998, -99997] ) or ( BkUnderCh13Cnt1Y <= BkUnderCh13Cnt7Y <= BkUnderCh13Cnt10Y  )

AC07 - Check when BkCnt1Y = 0, then BkHavingBusTypeFlag1Y = -99998 and TypeOfBksList1Y = -99998 
( BkCnt1Y <> 0) or ( BkCnt1Y == 0 and BkHavingBusTypeFlag1Y == -99998 and TypeOfBksList1Y == -99998 )

AC08 - Check when BkCnt7Y = 0, then BkHavingBusTypeFlag7Y = -99998 and TypeOfBksList7Y = -99998 
( BkCnt7Y <> 0) or ( BkCnt7Y == 0 and BkHavingBusTypeFlag7Y == -99998 and TypeOfBksList7Y == -99998 )

AC09 - Check when BkCnt10Y = 0, then BkHavingBusTypeFlag10Y = -99998 and TypeOfBksList10Y = -99998 
( BkCnt10Y <> 0) or ( BkCnt10Y == 0 and BkHavingBusTypeFlag10Y == -99998 and TypeOfBksList10Y == -99998 )

AC10 - Check when BkHavingBusTypeFlag1Y = -99997, then all items in TypeOfBksList1Y are -99997 
( BkHavingBusTypeFlag1Y <> -99997) or ( BkHavingBusTypeFlag1Y == -99997 and int( sorted(list(map(int, ' TypeOfBksList1Y '.split('|') )),reverse=False)[-1]) == int(sorted(list(map(int, ' TypeOfBksList1Y '.split('|') )),reverse=False)[0]) == -99997 )

AC11 - Check when BkHavingBusTypeFlag7Y = -99997, then all items in TypeOfBksList7Y are -99997 
( BkHavingBusTypeFlag7Y <> -99997) or ( BkHavingBusTypeFlag7Y == -99997 and int( sorted(list(map(int, ' TypeOfBksList7Y '.split('|') )),reverse=False)[-1]) == int(sorted(list(map(int, ' TypeOfBksList7Y '.split('|') )),reverse=False)[0]) == -99997 )

AC12 - Check when BkHavingBusTypeFlag10Y = -99997, then all items in TypeOfBksList10Y are -99997 
( BkHavingBusTypeFlag10Y <> -99997) or ( BkHavingBusTypeFlag10Y == -99997 and int( sorted(list(map(int, ' TypeOfBksList10Y '.split('|') )),reverse=False)[-1]) == int(sorted(list(map(int, ' TypeOfBksList10Y '.split('|') )),reverse=False)[0]) == -99997 )

AC13 - Check when BkSeverityIndex10Y = -99998, then BkCnt10Y = 0 
( BkSeverityIndex10Y <> -99998) or ( BkSeverityIndex10Y == -99998 and BkCnt10Y == 0 ) 

AC14 - Check when BkSeverityIndex10Y = -99997, then BkCnt10Y > 0 and BkWithNewestDateDisp10Y and BkWithNewestDateCh10Y = -99997 
( BkSeverityIndex10Y <> -99997) or ( BkSeverityIndex10Y == -99997 and ( BkCnt10Y > 0 ) and ( BkWithNewestDateDisp10Y == -99997) and ( BkWithNewestDateCh10Y == -99997) ) 

AC15 - Check when BkSeverityIndex10Y = 4, then BkCnt10Y >= 3 
( BkSeverityIndex10Y <> 4) or ( BkSeverityIndex10Y == 4 and BkCnt10Y >= 3 ) 

AC16 - Check when BkSeverityIndex10Y = 3, then BkWithNewestDateDisp10Y = 'DISMISSED' 
( BkSeverityIndex10Y <> 3) or ( BkSeverityIndex10Y == 3 and BkWithNewestDateDisp10Y = 'DISMISSED') 

AC17 - Check when BkSeverityIndex10Y = 2, then BkWithNewestDateCh10Y = '13'
( BkSeverityIndex10Y <> 2) or ( BkSeverityIndex10Y == 2 and str( BkWithNewestDateCh10Y ) = '13' ) 

