import BIPV2, ut;
// partial data
//EXPORT In_Base := dataset('~BIPV2_Seleid_Relative::base::20130920::data', BIPV2.CommonBase.Layout, flat);
// full data
// EXPORT In_Base := BIPV2.CommonBase.DS_BASE;
export In_Base := bipv2.CommonBase.DS_CLEAN;