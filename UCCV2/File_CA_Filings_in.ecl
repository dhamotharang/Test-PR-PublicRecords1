import UCCv2;

export File_CA_Filings_in 
       := dataset(Cluster.Cluster_In + 'in::uccv2::CA::Filings',Layout_File_CA_Filings_in, csv(separator('|'),heading(1),TERMINATOR(['\n','\r\n']),MAXLENGTH(100000)));