IMPORT	Business_Credit,	Address,	BIPV2;

	SBFE_Account_Layout	:=	RECORD	
		Business_Credit.Layouts.SBFEAccountLayout-Tradeline;
		Business_Credit.Layouts.LayoutTradeline;
	END;

EXPORT	LinkID_Layout_Business_Credit	:=	SBFE_Account_Layout;