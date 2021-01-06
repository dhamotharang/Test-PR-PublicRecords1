import UCCv2;

export File_CA_FilingAmendments_in 
       := dataset(Cluster.Cluster_In + 'in::uccv2::CA::FilingAmendments',Layout_File_CA_FilingAmendments_in, csv(separator('|'),heading(1),TERMINATOR(['\n','\r\n']),MAXLENGTH(100000)));