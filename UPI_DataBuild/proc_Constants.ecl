// thor build portion constants for Healthcare NoMatch build processing - there is also a proc_Constants for the HealthcareNoMatchHeader_InternalLinking
IMPORT tools, _Control, UPI_DataBuild, HealthcareNoMatchHeader_InternalLinking;
 
EXPORT proc_Constants := MODULE
  EXPORT  IsDataland        		:=  tools._Constants.IsDataland;
  EXPORT  primaryQueue      		:=  IF(IsDataland, 'thor400_sta', 'thor400_44_eclcc');
  EXPORT  secondaryQueue    		:=  IF(IsDataland, 'hthor_sta', 'hthor_eclcc');
  EXPORT  maxNumIters       		:=  1;
  EXPORT  pollingFreq       		:=  '1';
  EXPORT  emailNotifyOps    		:=  '';
  EXPORT  emailNotifyDeveloper	:=  'jennifer.hennigar@lexisnexisrisk.com';
  EXPORT  emailNotifyQA     		:=  '';
  EXPORT  emailNotify       		:=  IF(HealthcareNoMatchHeader_InternalLinking.proc_Constants.IsDataland, emailNotifyDeveloper, emailNotifyOps +','+ emailNotifyDeveloper);
  EXPORT  emailNotifyAll    		:=  emailNotify +','+ emailNotifyQA;
END;
