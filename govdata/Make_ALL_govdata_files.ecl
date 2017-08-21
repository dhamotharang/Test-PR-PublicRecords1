#workunit('name','Build Misc govdata files')
/* -- Make sure to set these build date attributes before running:
   -- govdata.CA_Sales_Tax_File_Date
   -- govdata.FDIC_Build_Date
   -- govdata.Gov_Phones_Build_Date
   -- govdata.IA_Sales_Tax_File_Date
   -- And make sure you updated these filenames:
   -- 
*/
a := govdata.Make_CA_Sales_Tax_BDID;
b := govdata.Make_FDIC_BDID;
c := govdata.Make_FL_FBN_Base;
d := govdata.Make_FL_NonProfit_BDID;
e := govdata.Make_Gov_Phones_Base;
f := govdata.Make_IA_SalesTax_BDID;
g := govdata.Make_IRS_NonProfit_BDID;
h := govdata.Make_MS_Workers_Comp_BDID;
i := govdata.Make_OR_Workers_Comp_BDID;
j := govdata.Make_SEC_Broker_Dealer_BDID;

a1 := output('Make CA SALES TAX BASE') : success(a);
b1 := output('Make FDIC BASE') : success(b);
c1 := output('Make FL FBN BASE') : success(c);
d1 := output('Make FL NONprofit BASE') : success(d);
e1 := output('Make GOV PHONES BASE') : success(e);
f1 := output('Make IA SALES TAX BASE') : success(f);
g1 := output('Make IRS NONPROFIT BASE') : success(g);
h1 := output('Make MS WORKERS BASE') : success(h);
i1 := output('Make OR WORKERS BASE') : success(i);
j1 := output('Make SEC BROKER DEALER BASE') : success(j);

build_base_files := sequential(a1,b1,c1,d1,e1,f1,g1,h1,i1,j1);

export Make_ALL_govdata_files := 
	sequential(
		 build_base_files
		,proc_build_all_keys
//		,govdata.Out_Population_Stats.all // commented out until I have time to change stats to call the macro
	);
