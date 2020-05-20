import prte2_business_credit, BIPV2, Address;


EXPORT File_TradeLinesBase := project(File_Linkids, transform(layouts.tradelinebase, self := left, self := []));