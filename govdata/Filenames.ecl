import business_header, versioncontrol;
export Filenames(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	export Input :=
	module
		
		shared lroot := business_header.bus_thor(pUseProd) + 'in::';
		
		export CA_Sales_Tax								:= lroot + 'ca_sales_tax::@version@::data'	;
		export FDIC												:= lroot + 'fdic::@version@::data'					;
		export FL_FBN											:= lroot + 'fl_fbn'													;
		export FL_FBN_Events							:= lroot + 'fl_fbn_events'									;
		export FL_Non_Profit							:= lroot + 'fl_non_profit_orgs';
		export FL_Professional_Liability	:= lroot + 'fl_prof_liab';
		export Employee_Directories				:= lroot + 'gov_phones';
		export IA_Sales_Tax								:= lroot + 'ia_sales_tax';
		export IRS_NonProfit							:= lroot + 'irs_non_profit';
		export MS_Workers_Comp						:= 'MS_Workers_comp';
		export OR_Workers_Comp						:= 'or_workcomp';
		export SEC_Broker_Dealer					:= 'sec_broker_dealer';

	end;
	
	export Base :=
	module
	
		shared lroot := business_header.bus_thor(pUseProd) + 'base::';

		export CA_Sales_TaxRoot								:= lroot + 'CA_Sales_Tax_BDID';
		export FDICRoot												:= lroot + 'govdata_FDIC_BDID';
		export FL_FBNRoot											:= lroot + 'Fl_fbn_base';
		export FL_Non_ProfitRoot							:= lroot + 'FL_NonProfit_bdid';
		export EmployeeDirsRoot								:= lroot + 'gov_phones';
		export IA_Sales_TaxRoot								:= lroot + 'IA_Sales_Tax';
		export IRS_NonProfitRoot							:= lroot + 'IRS_NonProfit';
		export MS_Workers_CompRoot						:= lroot + 'MS_Workers_Comp';	//more dependencies, so don't change now
		export OR_Workers_CompRoot						:= lroot + 'or_workers_comp';
		export SEC_Broker_DealerRoot					:= lroot + 'SEC_Broker_Dealer';	//stay same now, change later to in:: dir
//	export FL_Professional_LiabilityRoot	:= lroot + '';

		export CASalesTax					:= versioncontrol.mBuildFilenameVersionsOld(CA_Sales_TaxRoot				,pversion, newCASalesTax				);
		export FDIC 							:= versioncontrol.mBuildFilenameVersionsOld(FDICRoot								,pversion, newFDIC 							);
		export FL_FBN							:= versioncontrol.mBuildFilenameVersionsOld(FL_FBNRoot							,pversion, newFL_FBN						);
		export FL_Nonprofit				:= versioncontrol.mBuildFilenameVersionsOld(FL_Non_ProfitRoot				,pversion, newFL_Nonprofit			);
		export EmployeeDirs				:= versioncontrol.mBuildFilenameVersionsOld(EmployeeDirsRoot				,pversion, newEmployeeDirs			);
		export IASalesTax					:= versioncontrol.mBuildFilenameVersionsOld(IA_Sales_TaxRoot				,pversion, newIASalesTax				);
		export IRS_Nonprofit			:= versioncontrol.mBuildFilenameVersionsOld(IRS_NonProfitRoot				,pversion, newIRS_Nonprofit			);
		export Ms_workers_Comp		:= versioncontrol.mBuildFilenameVersionsOld(MS_Workers_CompRoot			,pversion, newMs_workers_Comp		);
		export Or_workers_Comp		:= versioncontrol.mBuildFilenameVersionsOld(OR_Workers_CompRoot			,pversion, newOr_workers_Comp		);
		export Sec_broker_dealer	:= versioncontrol.mBuildFilenameVersionsOld(SEC_Broker_DealerRoot		,pversion, newSec_broker_dealer	);
                                                                  
	end;

end;
