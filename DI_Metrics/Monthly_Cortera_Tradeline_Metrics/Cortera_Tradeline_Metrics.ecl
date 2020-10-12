﻿
// The following function calculates metrics for Cortera Tradeline history and growth
// at the weekly, monthly, and yearly intervals.

// Sample parameters:
//    destinationIP   := _Control.IPAddress.bctlpedata12;
//    destinationpath := '/data/datainsight/data_evaluations/DataMetrics/Stats_NonFCRA/';
//    emailContact    := 'christopher.albee@lexisnexisrisk.com';

IMPORT _control, Cortera_Tradeline, DI_Metrics, STD;

EXPORT Cortera_Tradeline_Metrics(STRING destinationIP, STRING destinationpath, STRING emailContact = 'DataInsightAutomation@lexisnexisrisk.com') := FUNCTION

  build_all := SEQUENTIAL(

     DI_Metrics.Monthly_Cortera_Tradeline_Metrics.CorteraTradelineGrowth(destinationIP, destinationpath, emailContact, weekly)

    ,DI_Metrics.Monthly_Cortera_Tradeline_Metrics.CorteraTradelineGrowth(destinationIP, destinationpath, emailContact, monthly)

    ,DI_Metrics.Monthly_Cortera_Tradeline_Metrics.CorteraTradelineGrowth(destinationIP, destinationpath, emailContact, yearly)

    ,DI_Metrics.Monthly_Cortera_Tradeline_Metrics.CorteraTradelineHistory(destinationIP, destinationpath, emailContact, weekly)

    ,DI_Metrics.Monthly_Cortera_Tradeline_Metrics.CorteraTradelineHistory(destinationIP, destinationpath, emailContact, monthly)

    ,DI_Metrics.Monthly_Cortera_Tradeline_Metrics.CorteraTradelineHistory(destinationIP, destinationpath, emailContact, yearly)

  );

  RETURN build_all;

END;
