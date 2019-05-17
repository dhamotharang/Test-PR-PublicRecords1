import $, doxie, iesp, prof_licensev2, one_click_data;

export Records := module

  export GetCollections(unsigned6 lexid, string8 request_date, $.IParam.ICollectionReportParam params) := function
    dids := dataset([{lexid}], doxie.layout_references);
    recs := 
      MAC.GetCollection(dids, did, prof_licensev2.Key_Proflic_Did(), 'ProfLicense', 'prof_licensev2.Key_Proflic_Did', '1.0')
    + MAC.GetCollection(dids, did, one_click_data.keys().did.qa, 'OneClickData', 'one_click_data.keys().did.qa', '1.0');
    return recs;
  end;

  export GetSales(unsigned6 lexid, string8 request_date, $.IParam.ISoldToReportParam params) := function
    dids := dataset([{lexid}], doxie.layout_references);
    sales_rec := project(normalize(dids, 5, transform(LEFT)), 
      transform(iesp.consumer_sold_to_report.t_SoldToSales,
        self.SaleDate := iesp.ECL2ESP.toDatestring8('20190519');
        self.ClientGCID := 500+100*COUNTER+COUNTER;
        self.SourceIds := dataset([{(string) (100*COUNTER+COUNTER)}],iesp.share.t_StringArrayItem);
      ));
    return sales_rec;  
  end;
 
end;