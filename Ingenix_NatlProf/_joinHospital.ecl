export _joinHospital := dedup(join(basefile_group_BDID, basefile_hospital_BDID,
                             left.filetyp=right.filetyp and
														 left.providerid=right.providerid
														 ));