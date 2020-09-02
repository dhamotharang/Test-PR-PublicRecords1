import CollateralAnalytics;

export proc_ProcessExceptionList(string pversion):= FUNCTION
  return sequential(
      CollateralAnalytics.fSpray_ExceptionList(pversion),
      CollateralAnalytics.AddNewExceptionRecords(pversion));
  
  END;
