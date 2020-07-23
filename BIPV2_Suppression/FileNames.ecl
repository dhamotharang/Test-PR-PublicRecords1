IMPORT _Control;
IMPORT Data_Services;
IMPORT STD;
IMPORT tools; 

EXPORT FileNames := MODULE
  
SHARED KeySuper     := 'QA' ; 
SHARED keyFather    := 'FATHER'; 
EXPORT Baseprefix   :=  '~thor_data400::base::bipv2_suppression';

environment := STD.Str.ToUpperCase(_Control.ThisEnvironment.Name);
EXPORT prefix       :=  if(environment = 'ALPHA_DEV', Data_Services.foreign_prod, '~' ) + 'thor_data400::key::bipv2_suppression';
EXPORT Suffix        :=  'seleprox';

EXPORT Baseseleprox            := BASEprefix + '::' + Suffix;
EXPORT Baseseleproxfather      := BASEprefix + '::' + keyFather    + '::' + Suffix;
EXPORT BaseLogicalF(STRING Version) := Baseprefix +'::' + Version +'::' + Suffix;

EXPORT Keyseleprox                := prefix + '::' + KeySuper+ '::' + Suffix;
EXPORT Keyseleproxfather          := prefix + '::' + keyFather+ '::' + Suffix;
EXPORT KeyLogicalF(STRING version) := prefix + '::' + Version +'::' + Suffix;

	export key_sele_prox_names(string pversion)            := tools.mod_FilenamesBuild(prefix + '::' + '@version@' +'::' + Suffix     ,pversion);

END; 