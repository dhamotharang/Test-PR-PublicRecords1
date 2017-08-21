DNB_DMI_As_Business_Contact				:= DNB_DMI.As_Business_Contact(pUsingInBizHdr := false);
DNB_DMI_As_Business_Header				:= DNB_DMI.As_Business_Header	(pUsingInBizHdr := false);

countDNB_DMI_As_Business_Contact	:= count(DNB_DMI_As_Business_Contact	);
countDNB_DMI_As_Business_Header	 	:= count(DNB_DMI_As_Business_Header		);

output(countDNB_DMI_As_Business_Contact				,named('countDNB_DMI_As_Business_Contact'	));
output(countDNB_DMI_As_Business_Header				,named('countDNB_DMI_As_Business_Header'	));
output(enth(DNB_DMI_As_Business_Contact	,300)	,named('DNB_DMI_As_Business_Contact'			),all);
output(enth(DNB_DMI_As_Business_Header	,300)	,named('DNB_DMI_As_Business_Header'				),all);