/* ----------------- Quick Simple Sanity Check(using Strata) ------------------- */
import strata,bipv2_build,BIPV2_Files,bipv2,BIPV2_Proxid,BIPV2_Strata,tools;
export _PreProcess_Strata(
   DATASET(_layouts.DOT_Base_orig)  pPrep       = BIPV2_Proxid.files().base.built
  ,string                           pversion    = bipv2.KeySuffix
  ,boolean                          pIsTesting  = false
  ,boolean                          pOverwrite  = false
) :=
  BIPV2_Strata.mac_BIP_ID_Check(pPrep,'ProxidMJ6','Preprocess',tools.get_version(pversion),pIsTesting);
