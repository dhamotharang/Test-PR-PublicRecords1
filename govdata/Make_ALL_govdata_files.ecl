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

sequential(a1,b1,c1,d1,e1,f1,g1,h1,i1,j1);

a2 := govdata.proc_build_ca_sales_tax_key;
b2 := govdata.proc_build_fdic_key;
c2 := govdata.proc_build_FL_FBN_Key;
d2 := govdata.proc_build_FL_NonProfit_Key;
e2 := govdata.proc_build_gov_phones_key;
f2 := govdata.proc_build_ia_salestax_key;
g2 := govdata.Proc_build_irs_NonProfit_Key;
h2 := govdata.proc_build_ms_workers_comp_key;
i2 := govdata.proc_build_or_workers_comp_key;
j2 := govdata.proc_build_sec_broker_dealer_key;

a3 := output('Make CA SALES TAX KEY') : success(a2);
b3 := output('Make FDIC KEY') : success(b2);
c3 := output('Make FL FBN KEY') : success(c2);
d3 := output('Make FL NONprofit KEY') : success(d2);
e3 := output('Make GOV PHONES KEY') : success(e2);
f3 := output('Make IA SALES TAX KEY') : success(f2);
g3 := output('Make IRS NONPROFIT KEY') : success(g2);
h3 := output('Make MS WORKERS KEY') : success(h2);
i3 := output('Make OR WORKERS KEY') : success(i2);
j3 := output('Make SEC BROKER DEALER KEY') : success(j2);

sequential(a3,b3,c3,d3,e3,f3,g3,h3,i3,j3);
