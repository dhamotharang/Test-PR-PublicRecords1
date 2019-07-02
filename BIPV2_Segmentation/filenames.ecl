import tools;
import BIPV2_PostProcess;
export filenames(string pversion = '',boolean pUseOtherEnvironment = false) :=
module

     shared lfileprefix    := BIPV2_PostProcess._Constants(pUseOtherEnvironment).prefix;

     export BIPSeleIDSegs  := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2::PostProcess::SeleID::Segmentation::@version@', pversion);
    
end;