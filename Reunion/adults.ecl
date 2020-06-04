IMPORT header,ut,driversv2,american_student_list,watchdog,infutor;

INTEGER iTodayInMonths:=header.ConvertYYYYMMToNumberOfMonths((INTEGER)ut.GetDate);

BOOLEAN bIsMinor(INTEGER iDOB):=FUNCTION
 INTEGER iDOBInMonths:=header.ConvertYYYYMMToNumberOfMonths(iDOB);
 RETURN iDOB>0 and iDOBInMonths+216>iTodayInMonths;
END;

lMinorFlags:=RECORD
  UNSIGNED6 did;
  STRING8 wdog_glb_dob:='';
  STRING1 wdog_glb_under_18:='';
  STRING1 wdog_glb_over_18:='';
  STRING8 wdog_nonglb_dob:='';
  STRING1 wdog_nonglb_under_18:='';
  STRING1 wdog_nonglb_over_18:='';
END;
 
lMinorFlags tFlagBest(watchdog.layout_best L):=TRANSFORM
  SELF.wdog_glb_dob:=IF(L.dob>0,(STRING)L.dob,'');
  SELF.wdog_glb_under_18:=IF(bIsMinor(L.dob)=TRUE,'Y','');
  SELF.wdog_glb_over_18:=IF(L.dob>0 AND SELF.wdog_glb_under_18='','Y','');
  SELF:=L;
END;
dMinorFlagsBest:=PROJECT(watchdog.file_best,tFlagBest(LEFT));

lMinorFlags tFlagBestNonGLB(watchdog.layout_best L):=TRANSFORM
  SELF.wdog_nonglb_dob:=IF(L.dob>0,(STRING)L.dob,'');
  SELF.wdog_nonglb_under_18:=IF(bIsMinor(L.dob)=TRUE,'Y','');
  SELF.wdog_nonglb_over_18:=IF(L.dob>0 AND SELF.wdog_nonglb_under_18='','Y','');
  SELF:=L;
END;
dMinorFlagsBestNonGLB:=PROJECT(watchdog.file_best_nonglb,tFlagBestNonGLB(LEFT));

dMinorFlags:=DEDUP(SORT(DISTRIBUTE(dMinorFlagsBest+dMinorFlagsBestNonGLB,HASH(did)),did,LOCAL),RECORD,ALL,LOCAL);

lMinorFlags tRoll(lMinorFlags L, lMinorFlags R):=TRANSFORM
  SELF.wdog_glb_under_18:=if(L.wdog_glb_under_18='Y',L.wdog_glb_under_18,R.wdog_glb_under_18);
  SELF.wdog_glb_over_18:=if(L.wdog_glb_over_18='Y',L.wdog_glb_over_18,R.wdog_glb_over_18);
  SELF.wdog_nonglb_under_18:=if(L.wdog_nonglb_under_18='Y',L.wdog_nonglb_under_18,R.wdog_nonglb_under_18);
  SELF.wdog_nonglb_over_18:=if(L.wdog_nonglb_over_18='Y',L.wdog_nonglb_over_18,R.wdog_nonglb_over_18);				   
  SELF:=L;
END;
dMinorFlagsRolled:=ROLLUP(dMinorFlags,LEFT.did=RIGHT.did,tRoll(LEFT,RIGHT),LOCAL);

//drop minors
dNoMinors:=dMinorFlagsRolled(~(wdog_glb_under_18='Y' OR wdog_nonglb_under_18='Y'));

//keep adults
dAdults:=dNoMinors(wdog_glb_over_18='Y' OR wdog_nonglb_over_18='Y');


EXPORT adults:=dAdults : PERSIST('~thor::persist::mylife::adults_wdog_only', EXPIRE(10), REFRESH(FALSE));