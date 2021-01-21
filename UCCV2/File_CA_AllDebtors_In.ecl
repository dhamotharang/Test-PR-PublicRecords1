import UCCv2;

export File_CA_AllDebtors_In 
       := dataset(Cluster.Cluster_In + 'in::uccv2::CA::AllDebtors',Layout_File_CA_AllDebtors_in, csv(separator('|'),heading(1),TERMINATOR(['\n','\r\n']),MAXLENGTH(100000)));