  EXPORT REAL8 aggAVE(SET of REAL8 vals):=FUNCTION
		result:=IF(COUNT(vals)=0,0,SUM(vals)/COUNT(vals));
		RETURN result;
  END;