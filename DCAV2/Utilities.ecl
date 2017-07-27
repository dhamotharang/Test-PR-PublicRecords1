export Utilities :=
module
  export RecordType							:= ENUM		(UNSIGNED1,Unknown	,Unchanged	,Updated	,Old	,New	);
  export RTToText(unsigned1 c) 	:= CHOOSE	(c				,'UNKNOWN','Unchanged','Updated','Old','New');
end;
