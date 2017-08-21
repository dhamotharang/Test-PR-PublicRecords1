EXPORT Persist_Name(FileName_Info info, Types.PersistType ptyp,BOOLEAN pDelta=FALSE) := FUNCTION
//	STRING name := info.stem + '::persist::' + info.srcType
	sffx(isDelta):=functionmacro return if(isDelta,'_delta',''); endmacro;
	STRING name := '~THOR_DATA400::PERSIST::'  + info.srcType
								+ CASE(ptyp,
											Types.PersistType.Posting			=> '::posting',
											Types.PersistType.Dict				=> '::dict',
											Types.PersistType.Assigned		=> '::assigned',
											'::unknown')
								+ '::boolean'+sffx(pDelta) ;
	RETURN name;
END;