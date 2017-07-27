import Crim_Common;

lCrimCommonDev 	:= output(Crim_Common.Version_Development,named('Crim_Common_Development'));
lCrimCommonProd := output(Crim_Common.Version_Production,named('Crim_Common_Production'));
lCrimOffender2	:= output(CrimSrch.Version.CrimOffender,named('Version_CrimOffender2'));
lCourtOffenses	:= output(CrimSrch.Version.Court_Offenses,named('Version_Court_Offenses'));
lDOCOffenses	:= output(CrimSrch.Version.DOC_Offenses,named('Version_DOC_Offenses'));
lDOCPunishment	:= output(CrimSrch.Version.DOC_Punishment,named('Version_DOC_Punishment'));
lSexPred		:= output(CrimSrch.Version.SexPred,named('Version_SexPred'));
lCrimSrchDev	:= output(CrimSrch.Version.Development,named('CrimSrch_Version_Development'));
lCrimSrchProd	:= output(CrimSrch.Version.Production,named('CrimSrch_Version_Production'));

export Out_Version_Attribute_Values
 :=
  parallel(
			lCrimCommonDev,
			lCrimCommonProd,
			lCrimOffender2,
			lCourtOffenses,
			lDOCOffenses,
			lDOCPunishment,
			lSexPred,
			lCrimSrchDev,
			lCrimSrchProd
		   );