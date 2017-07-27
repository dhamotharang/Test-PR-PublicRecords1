export UNSIGNED fn_Tra_Penalty_DLState(string2 n_dlState):= FUNCTION
  retval :=  map (n_dlState = '' => 0,
							input.dlState = '' => 0,
							n_dlState = input.dlState => 0,
							10
	);
	return (unsigned)retval;
END;