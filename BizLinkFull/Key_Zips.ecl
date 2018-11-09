IMPORT RiskWise;
IMPORT Data_Services;
IMPORT doxie;
EXPORT Key_Zips:= INDEX(riskwise.File_CityStateZip,{zip5},{riskwise.File_CityStateZip},'~key::BizLinkFullBizHeadZips');

