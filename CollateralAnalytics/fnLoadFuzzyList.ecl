import CollateralAnalytics,PromoteSupers;

export fnLoadFuzzyList(string pversion):=function

FuzzyMatch:=CollateralAnalytics.fn_FuzzyMatching;

PromoteSupers.Mac_SF_BuildProcess(FuzzyMatch,'~thor_data400::collateral_analytics::FuzzyList',build_base,,,TRUE,pversion);

return build_base;

end;