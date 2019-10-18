/* ----------------- Quick Simple Sanity Check(using Strata) ------------------- */
import strata,bipv2_build,BIPV2_Files,bipv2,BIPV2_Strata,tools;
export _PreProcess_Strata(
   DATASET(layout_DOT_Base)   pPrep       = BIPV2_Files.files_dotid.DS_BASE
  ,dataset(layout_DOT_Base)   pPrepped    = BIPV2_ProxID_Platform._fPatch_Proxids(pPrep)
  ,string                     pversion    = bipv2.KeySuffix
  ,string                     pBuildStep  = 'Preprocess'  //Preprocess or PrePost(last iteration)
  ,boolean                    pIsTesting  = false
) :=
  BIPV2_Strata.mac_BIP_ID_Check(pPrepped,'Proxid',pBuildStep,tools.get_version(pversion),pIsTesting);