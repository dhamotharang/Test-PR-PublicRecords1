import atf,bankrupt,dea,emerges,faa, header, merchant_vessels,patriot,prof_license;


do1 := atf.accept_sk_to_Prod;
do2 := bankrupt.proc_accept_SK_To_Prod;
do3 := DEA.proc_accept_sk_to_Prod;
do4 := doxie_build.proc_acceptSK_DOC_to_Prod;
do5 := doxie_build.Proc_AcceptSK_dl_toProd;
do6 := doxie_build.Proc_AcceptSK_so_toProd;
do7 := doxie_build.Proc_AcceptSK_veh_toProd;
do8 := emerges.proc_accept_sk_To_Prod;
do9 := faa.proc_accept_sk_to_Prod;
do10 := merchant_vessels.proc_accept_sk_to_Prod;
//do11 := patriot.proc_accept_sk_to_Prod;
do12 := prof_license.accept_sk_to_Prod;
do13 := header.Proc_AcceptSK_toProd;

export Proc_AcceptSK_ALL_to_Prod := parallel(do1,do2,do3,do4,
									do5,do6,do7,do8,
									do9,do10,do12,do13);

