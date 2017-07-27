IMPORT InsuranceHeader,_Control;
BOOLEAN isIncremental 	:= FALSE:STORED('IsIncrementalBuild');
STRING fileVersion := '' :STORED('fileVersion'); 
EXPORT KeyInfix := IF(fileVersion<>'', fileVersion, thorlib.wuid()[2..9] + IF (isIncremental, thorlib.wuid()[11..16] , ''));
