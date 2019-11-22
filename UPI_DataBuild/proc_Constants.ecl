// thor build portion constants for Healthcare NoMatch build processing - there is also a proc_Constants for the HealthcareNoMatchHeader_InternalLinking
IMPORT tools, _Control, UPI_DataBuild, HealthcareNoMatchHeader_InternalLinking;
 
EXPORT proc_Constants := MODULE
  EXPORT  IsDataland        		:=  tools._Constants.IsDataland;
  EXPORT  primaryQueue      		:=  'thor400_sta';//IF(IsDataland, 'thor400_sta', 'thor400_44');
  EXPORT  secondaryQueue    		:=  'hthor_sta';//IF(IsDataland, 'hthor_sta', 'hthor ');
  EXPORT  maxNumIters       		:=  1;//10; not anticipating needing more than 1 for the outer wrap-around process that eventually calls the CRK macro
  EXPORT  pollingFreq       		:=  '1';
  EXPORT  emailNotifyOps    		:=  '';
  EXPORT  emailNotifyDeveloper	:=  'jennifer.hennigar@lexisnexisrisk.com';
  EXPORT  emailNotifyQA     		:=  '';
  EXPORT  emailNotify       		:=  IF(HealthcareNoMatchHeader_InternalLinking.proc_Constants.IsDataland, emailNotifyDeveloper, emailNotifyOps +','+ emailNotifyDeveloper);
  EXPORT  emailNotifyAll    		:=  emailNotify +','+ emailNotifyQA;
END;
