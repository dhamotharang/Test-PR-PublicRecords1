EXPORT Proc_Build_All(string pversion) := FUNCTION

	spray_input_file := fSpray_InputFiles;
	build_base_file	:=	Proc_Build_Base(pversion);
	build_keys :=	Proc_Build_Keys(pversion);
	
	RETURN SEQUENTIAL(
			spray_input_file
			,build_base_file
			,build_keys
		);
		
END;