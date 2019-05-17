import $,autostandardi,iesp;

export IParam := module

  export IBaseParam := interface
    export string _place_holder := '';
  end;

  export ICollectionReportParam := interface(IBaseParam)
  end;

  export ISoldToReportParam := interface(IBaseParam)
  end;

  export GetCollectionReportParams(iesp.consumer_collection_report.t_CollectionReportOptions options) := function

     inmod := module  (PROJECT(AutoStandardI.GlobalModule(), ICollectionReportParam, opt))  
     END;

     return inmod;

  end;

  export GetSoldToReportParams(iesp.consumer_sold_to_report.t_SoldToReportOptions options) := function
    inmod := module  (PROJECT(AutoStandardI.GlobalModule(), ISoldToReportParam, opt))  
     END;

     return inmod;

  end;


end;