import crim_common;

lInDOCOffender		:= output(Crim_Common.Version_In_DOC_Offender,named('Version_In_DOC_Offender'));
lInDOCOffenses		:= output(Crim_Common.Version_In_DOC_Offenses,named('Version_In_DOC_Offenses'));
lInDOCPunishment	:= output(Crim_Common.Version_In_DOC_Punishment,named('Version_In_DOC_Punishment'));
lInArrestOffender	:= output(Crim_Common.Version_In_Arrest_Offender,named('Version_In_Arrest_Offender'));
lInArrestOffenses	:= output(Crim_Common.Version_In_Arrest_Offenses,named('Version_In_Arrest_Offenses'));
lVersionDevelopment	:= output(Crim_Common.Version_Development,named('Version_Development'));
lVersionProduction	:= output(Crim_Common.Version_Production,named('Version_Production'));


export Out_Version_Attribute_Values
 :=
  parallel(
			lInDOCOffender,
			lInDOCOffenses,
			lInDOCPunishment,
			lInArrestOffender,
			lInArrestOffenses,
			lVersionDevelopment,
			lVersionProduction
		   );