export _joinMedschool := dedup(join(_joinHospital, basefile_Medschool_BDID,
                             left.filetyp=right.filetyp and
														 left.providerid=right.providerid
														 ));