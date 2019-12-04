export proc_HighRiskKey(
   string                            pversion
  ,boolean                           pPromote2QA          = false
) := module

     export run := parallel( 
                            evaluate(BIPV2_Build.HighRiskIndustries.buildKeys(pversion,pPromote2QA))
                           );

end;