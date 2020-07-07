IMPORT $, doxie;

EXPORT Get_Gateway_Data ($.IParam.polkParams aGatewayInputData)
  := FUNCTION

  BOOLEAN doCombined := FALSE;
  BOOLEAN noFailInput := aGatewayInputData.noFail;
  BOOLEAN useExperian := ~doxie.DataPermission.use_Polk;

  aPolkInputMod := MODULE(PROJECT(aGatewayInputData,$.IParam.polkParams,OPT))
    EXPORT BOOLEAN noFail := IF(noFailInput,TRUE,useExperian);
  END;
  aExperianInputMod := MODULE(PROJECT(aGatewayInputData,$.IParam.polkParams,OPT))
    EXPORT BOOLEAN noFail := IF(noFailInput,TRUE,~useExperian);
  END;

  Gateway_Data:=
  MAP(useExperian =>
      PROJECT($.Get_Experian_Data.val(aExperianInputMod,doCombined),$.Layout_Report_RealTime),
      PROJECT($.Get_Polk_Data.val(aPolkInputMod,doCombined),$.Layout_Report_RealTime));
// output(Gateway_Data,NAMED('Gateway_Data'));
  RETURN Gateway_Data;
END;
