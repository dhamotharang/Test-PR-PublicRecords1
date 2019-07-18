﻿import AutoStandardI,Foreclosure_Services,iesp;

// defaults to Foreclosure records, pass true for Notice of Defaults records
export foreclosure_records(dataset(doxie_cbrs.layout_references) bdids, boolean isNodSearch=false) := MODULE

gmod := AutoStandardI.GlobalModule();
nMod := MODULE(Foreclosure_Services.Raw.params);
  EXPORT string5 industry_class := gmod.IndustryClass;
  EXPORT string32 application_type := gmod.ApplicationType;
  EXPORT string ssn_mask := gmod.ssnmask;
END;

for := Foreclosure_Services.Raw.report_view.by_bdid(bdids,nMod,false);
nod := Foreclosure_Services.Raw.report_view.by_bdid(bdids,nMod,true);

fids := set(for,ForeclosureId);

nodFlg := record 
	iesp.foreclosure.t_ForeclosureReportRecord,
	boolean foreclosed
end;

nodFlg assignFlg(iesp.foreclosure.t_ForeclosureReportRecord l) := transform 
	self := l; 
	self.foreclosed := if(isNodSearch,self.ForeclosureId in fids,true)
end;

export records := if(isNodSearch,project(nod,assignFlg(LEFT)),project(for,assignFlg(LEFT)));

export records_count := count(records);

end;
