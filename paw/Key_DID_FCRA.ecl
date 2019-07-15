import  doxie;

KeyName       := cluster.cluster_out+'Key::pAW::';
KeyBaseFile   := PAW.File_Key_DID_FCRA;

EXPORT Key_DID_FCRA := INDEX(KeyBaseFile, {did}, {KeyBaseFile}, KeyName + doxie.Version_SuperKey + '::did_FCRA');
