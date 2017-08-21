EXPORT Generate_Normalized_Data(data_parent, child_layout, child_name) := FUNCTIONMACRO
	
	child_layout Denorm(child_layout R):= TRANSFORM

		SELF := R;

	END;
	
	RETURN NORMALIZE(data_parent,LEFT.child_name,Denorm(RIGHT));

ENDMACRO;
