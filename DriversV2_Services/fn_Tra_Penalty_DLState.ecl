EXPORT UNSIGNED fn_Tra_Penalty_DLState(STRING2 n_dlState):= FUNCTION
  retval := MAP (n_dlState = '' => 0,
              input.dlState = '' => 0,
              n_dlState = input.dlState => 0,
              10
  );
  RETURN (UNSIGNED)retval;
END;
