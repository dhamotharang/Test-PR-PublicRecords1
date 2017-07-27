import strata;

export Strata_Stats(

          dataset( VINA.layout_vina_infile ) pBaseFile = VINA.file_vina_infile

) :=
module

          Strata.mac_Pops (pBaseFile ,dNoGrouping );

end;
