import BIPV2_LGID3;

EXPORT _proc_Specificities(
    pInfile          = 'BIPV2_LGID3.In_LGID3'
) :=
functionmacro

	specMod   := BIPV2_LGID3.specificities(pInfile);
  
	runSpecBuild := sequential(
     specMod.Build
    ,parallel(
       OUTPUT(specMod.Specificities ,NAMED('Specificities'  ))
      ,OUTPUT(specMod.SpcShift      ,NAMED('SpcShift'       ))  
    )
  );

  return runSpecBuild;
  
endmacro;
