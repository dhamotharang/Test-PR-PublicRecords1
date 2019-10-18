export proc_crosswalk(
   string                            pversion
  ,boolean                           pPromote2QA          = false
) := module

     export run := parallel( 
                            evaluate(GenCrosswalk(pversion, pPromote2QA))
                           );

end;