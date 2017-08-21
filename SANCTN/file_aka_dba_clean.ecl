import SANCTN,ut;

export file_aka_dba_clean  := dataset(SANCTN.cluster + 'out::sanctn::aka_dba_cleaned',SANCTN.layout_SANCTN_aka_dba_in,thor);
// export file_aka_dba_clean  := dataset(SANCTN.cluster + 'out::sanctn::aka_dba_cleaned',SANCTN.layout_SANCTN_aka_dba_out,thor);