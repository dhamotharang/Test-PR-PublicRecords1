import strata,tools;

export Strata_Stats(
	 boolean														pUseOtherEnviron	= tools._Constants.IsDataland
	,dataset(layouts.base							)	pBaseFile					= files(,pUseOtherEnviron).base.built

) :=
module

	Strata.mac_Pops		(pBaseFile				,dNoGrouping																	);
	Strata.mac_Pops		(pBaseFile				,demail_src								,'email_src'					);
	Strata.mac_Pops		(pBaseFile				,dPerson_addr_st					,'Person_addr.st'			);
	Strata.mac_Pops		(pBaseFile				,dbh_Company_addr_st			,'bh_Company_addr.st'	);

	//do uniques only on interesting fields to save time
	Strata.mac_Uniques(pBaseFile				,dUniqueNoGrouping				,'',,,false
			,[ 'date_first_seen','date_last_seen','email_src','Did','Bdid'				
				,'group_id','agrp_bdid','best_ssn','best_dob','append_rawaid','bh_rawaid'	]);

end;