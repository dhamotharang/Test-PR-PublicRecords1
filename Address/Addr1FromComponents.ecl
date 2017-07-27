export string Addr1FromComponents(string prim_range, string predir, string prim_name,
                         string suffix, string postdir, string unit_desig, string sec_range) :=
IF(prim_range<>'',trim(prim_range)+' ','') +
IF(predir<>'',trim(predir)+' ','') +
IF(prim_name<>'',trim(prim_name)+' ','') +
IF(suffix<>'',trim(suffix)+' ','') +
IF(postdir<>'',trim(postdir)+' ','') +
IF(unit_desig<>'' and sec_range<>'',trim(unit_desig)+' ','') +
trim(sec_range);