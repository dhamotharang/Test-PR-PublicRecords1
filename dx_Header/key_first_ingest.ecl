IMPORT $;


EXPORT key_first_ingest (integer data_category = 0) :=
         INDEX ({$.layouts.i_first_ingest}, $.names().i_first_ingest,OPT);