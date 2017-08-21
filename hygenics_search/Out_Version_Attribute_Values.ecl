import Crim_Common;

lCrimCommonDev 	:= output(Crim_Common.Version_Development,named('Crim_Common_Development'));
lCrimCommonProd := output(Crim_Common.Version_Production,named('Crim_Common_Production'));
//lCrimOffender2	:= output(Hygenics_search.Version.CrimOffender,named('Version_CrimOffender2'));
//lCourtOffenses	:= output(Hygenics_search.Version.Court_Offenses,named('Version_Court_Offenses'));
//lDOCOffenses	:= output(Hygenics_search.Version.DOC_Offenses,named('Version_DOC_Offenses'));
//lDOCPunishment	:= output(Hygenics_search.Version.DOC_Punishment,named('Version_DOC_Punishment'));
//lSexPred		:= output(Hygenics_search.Version.SexPred,named('Version_SexPred'));
//lCrimSrchDev	:= output(Hygenics_search.Version.Development,named('CrimSrch_Version_Development'));
//lCrimSrchProd	:= output(Hygenics_search.Version.Production,named('CrimSrch_Version_Production'));

export Out_Version_Attribute_Values
 :=
  parallel(
			lCrimCommonDev,
			lCrimCommonProd
		   );