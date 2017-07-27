import doxie;

KeyName       := cluster.cluster_out+'Key::infoUSA::IDEXEC::';

bdid_file := File_IDEXEC_BDID;

export Key_IDEXEC_BDID := index(bdid_file,{bdid},{bdid_file},KeyName + Doxie.Version_SuperKey+'::Bdid');