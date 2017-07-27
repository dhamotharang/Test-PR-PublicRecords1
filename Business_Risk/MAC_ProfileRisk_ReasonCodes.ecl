export MAC_ProfileRisk_ReasonCodes(layout, cnt, serviceIndicator, final) := macro


choosen(
    if(layout.OFAC_Cnt > 0, dataset([{101,business_risk.Get_PRRC_Desc(101)}],Business_Risk.Layout_Profile_Risk_Desc)) &
//    if(TBD, dataset([{102,business_risk.Get_PRRC_Desc(102)}],Business_Risk.Layout_Profile_Risk_Desc)) &
    if(layout.Cnt_B > 0, dataset([{103,business_risk.Get_PRRC_Desc(103)}],Business_Risk.Layout_Profile_Risk_Desc)) &
    if(layout.lj = 1, dataset([{104,business_risk.Get_PRRC_Desc(104)}],Business_Risk.Layout_Profile_Risk_Desc)) &
    if(layout.lj = 2, dataset([{105,business_risk.Get_PRRC_Desc(105)}],Business_Risk.Layout_Profile_Risk_Desc)) &
    if(layout.t1x = 0, dataset([{106,business_risk.Get_PRRC_Desc(106)}],Business_Risk.Layout_Profile_Risk_Desc)) &
    if(layout.PRScore <> 100 and (layout.t1x in [1,2]), dataset([{107,business_risk.Get_PRRC_Desc(107)}],Business_Risk.Layout_Profile_Risk_Desc)) &
    if(layout.CurrPhn = 0, dataset([{108,business_risk.Get_PRRC_Desc(108)}],Business_Risk.Layout_Profile_Risk_Desc)),
cnt)

endmacro;