import Infutor_NARC3;


EXPORT raw_in_infutor_narc3 :=  DATASET(Infutor_NARC3.Filenames().Input.consumer.sprayed, Infutor_NARC3.Layout_Infile, csv( separator('\t'),heading(1), terminator(['\n', '\r\n']), quote(['"'])));;