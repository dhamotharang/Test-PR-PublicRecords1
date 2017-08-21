ddca := dcav2.files().base.companies.built;

ddca_reed_gid 				:= ddca(rawfields.enterprise_num = '246589'	)[1].lncaGID;
ddca_asiapacific_gid 	:= ddca(rawfields.enterprise_num = '181912'	)[1].lncaGID;
ddca_banque_gid 			:= ddca(rawfields.enterprise_num = '1250186')[1].lncaGID;
ddca_berkshire_gid 		:= ddca(rawfields.enterprise_num = '19814'	)[1].lncaGID;

ftable (dataset(dcav2.layouts.base.companies) pdata) := table(pdata,{rid,lncagid,lncaiid,lncaghid,file_type,rawfields.enterprise_num,rawfields.parent_enterprise_number,rawfields.company_type, rawfields.name,rawfields.root, rawfields.sub,rawfields.level,rawfields.parent_name, rawfields.parent_number});

ddca_reed_group 				:= sort(ftable(ddca(lncaGID = ddca_reed_gid 				)),lncaIID);
ddca_asiapacific_group 	:= sort(ftable(ddca(lncaGID = ddca_asiapacific_gid	)),lncaIID);
ddca_banque_group 			:= sort(ftable(ddca(lncaGID = ddca_banque_gid 			)),lncaIID);
ddca_berkshire_group 		:= sort(ftable(ddca(lncaGID = ddca_berkshire_gid 		)),lncaIID);

output(ddca_reed_gid 				,named('ddca_reed_gid' 				),all);
output(ddca_asiapacific_gid	,named('ddca_asiapacific_gid'	),all);
output(ddca_banque_gid 			,named('ddca_banque_gid' 			),all);
output(ddca_berkshire_gid 	,named('ddca_berkshire_gid' 	),all);

output(ddca_reed_group 				,named('ddca_reed_group' 				),all);
output(ddca_asiapacific_group	,named('ddca_asiapacific_group'	),all);
output(ddca_banque_group 			,named('ddca_banque_group' 			),all);
output(ddca_berkshire_group 	,named('ddca_berkshire_group' 	),all);