EXPORT is_Completed(
    string    pState
   ,boolean   pCompile      = false
   ,unsigned  pTimesCalled  = 0
) := 
function

  set_completed_states := ['completed' ,'failed' ,'aborted' ] + if(pCompile = true ,['compiled']  ,[]);
  unknown_state := 'unknown';
  
  completed_condition :=      (                     trim(pState) in set_completed_states)
                          or  (pTimesCalled > 5 and trim(pState)  = unknown_state       )
                          ;
    
  return completed_condition;
  
end;