import SANCTN,ut;

export file_aka_dba_clean  := dataset(SANCTN.cluster + 'out::sanctn::aka_dba_cleaned',SANCTN.layout_SANCTN_aka_dba_base,thor);
// export file_aka_dba_clean  := dataset(SANCTN.cluster + 'out::sanctn::aka_dba_cleaned',SANCTN.layout_SANCTN_aka_dba_out,thor);