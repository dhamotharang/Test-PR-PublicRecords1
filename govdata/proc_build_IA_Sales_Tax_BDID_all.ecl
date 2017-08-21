IMPORT ut, _control, tools;

EXPORT proc_build_ia_sales_tax_BDID_all(STRING pfiledate) := FUNCTION

//Spray File
sprayfile := FileServices.SprayVariable(_control.IPAddress.bctlpedata11
									,'/data/prod_data_build_10/production_data/business_headers/ia_sales_tax/out/ia_sales_tax.csv'
									,,,,
                  , tools.fun_Groupname(),
									'~thor_data400::in::ia::sprayed::' + pfiledate + '::sales_tax',-1,,,TRUE,TRUE,TRUE);

//Superfile Transactions
superfile_transac := SEQUENTIAL( FileServices.StartSuperFileTransaction(),
                fileservices.addsuperfile('~thor_data400::in::ia::sprayed::delete::sales_tax','~thor_data400::in::ia::sprayed::grandfather::sales_tax',,TRUE),
								fileservices.clearsuperfile('~thor_data400::in::ia::sprayed::grandfather::sales_tax'),
								fileservices.addsuperfile('~thor_data400::in::ia::sprayed::grandfather::sales_tax','~thor_data400::in::ia::sprayed::father::sales_tax',,TRUE),
								fileservices.clearsuperfile('~thor_data400::in::ia::sprayed::father::sales_tax'),
								fileservices.addsuperfile('~thor_data400::in::ia::sprayed::father::sales_tax','~thor_data400::in::ia::sprayed::sales_tax',,TRUE),
								fileservices.clearsuperfile('~thor_data400::in::ia::sprayed::sales_tax'),
								fileservices.addsuperfile('~thor_data400::in::ia::sprayed::sales_tax','~thor_data400::in::ia::sprayed::' + pfiledate + '::sales_tax'),
								fileservices.clearsuperfile('~thor_data400::in::ia::sprayed::delete::sales_tax',true),
								FileServices.FinishSuperFileTransaction()
								);

// Make BDID 
make_bdid := govdata.Make_IA_SalesTax_BDID;


//STRATA
strata_counts := govdata.Strata_Population_Stats.IA_Sales_pop;

retval := SEQUENTIAL(sprayfile, 
                     superfile_transac,                     
                     make_bdid,
				             strata_counts);

RETURN retval;
END;