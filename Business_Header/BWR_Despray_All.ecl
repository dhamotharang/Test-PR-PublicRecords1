#workunit ('name', 'DKC ALL Business Header Keys ' + business_header.Version);

do1 := business_header.DKC_BH_Contacts_Keys			: success(output('DKC of Bus Contact Keys successful'));
do2 := business_header.DKC_Employment_Keys			: success(output('DKC of Employment Keys successful'));
do3 := business_header.Despray_Business_Header		: success(output('Despray of Bus Header Files successful'));
do4 := business_header.DKC_BH_Keys					: success(output('DKC of Bus Header Keys successful'));
do5 := business_header.DKC_BH_MISC_Keys				: success(output('DKC of Business Relatives/Best/Stat Keys successful'));

sequential(
	 do1
    ,do2
    ,do3
    ,do4
    ,do5
);
    