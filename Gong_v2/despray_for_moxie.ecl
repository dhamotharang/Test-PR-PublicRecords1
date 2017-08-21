import gong;

export despray_for_moxie(string rundate) := function

base_for_despray := project(gong.File_GongBase, transform(gong.layout_gong_for_despray, self := left));

perform_despray :=

sequential(
output(base_for_despray,,Gong_v2.thor_cluster+'base::lss_gong_for_despray'+rundate,overwrite)
//,fileservices.Despray(Gong_v2.thor_cluster+'base::lss_gong_for_despray'+rundate,'edata11-bld.br.seisint.com','/gong/gong/thor_keys/gong.d00',,,,true)
);

return perform_despray;
end;