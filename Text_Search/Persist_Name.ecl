EXPORT Persist_Name(FileName_Info info, Types.PersistType ptyp) := FUNCTION
//	STRING name := info.stem + '::persist::' + info.srcType
	STRING name := '~THOR_DATA400::PERSIST::'  + info.srcType
								+ CASE(ptyp,
											Types.PersistType.Posting			=> '::posting',
											Types.PersistType.Dict				=> '::dict',
											Types.PersistType.Assigned		=> '::assigned',
											'::unknown')
								+ '::boolean';
	RETURN name;
END;