// constants for Healthcare NoMatch build processing
IMPORT tools, _Control;
 
EXPORT proc_Constants := MODULE
  EXPORT  IsDataland          :=  tools._Constants.IsDataland;
  EXPORT  primaryQueue        :=  IF(IsDataland, 'thor400_sta_eclcc', 'thor400_44_eclcc');
  EXPORT  secondaryQueue      :=  IF(IsDataland, 'hthor_sta_eclcc', 'hthor_eclcc');
  EXPORT  maxNumIters         :=  10;
  EXPORT  pollingFreq         :=  '1';
  EXPORT  emailNotifyOps      :=  '';
  EXPORT  emailNotifyHeader   :=  'Kevin.Garrity@lexisnexisrisk.com,Ayeesha.Kayttala@lexisnexisrisk.com,Vijay.Kumar1@lexisnexisrisk.com';
  EXPORT  emailNotifyQA       :=  '';
  EXPORT  emailNotify         :=  IF(IsDataland, emailNotifyHeader, emailNotifyOps +','+ emailNotifyHeader);
  EXPORT  emailNotifyAll      :=  emailNotify +','+ emailNotifyQA;
	EXPORT  WUStatusInProgress  :=  ['RUNNING', 'SUBMITTED', 'COMPILING', 'COMPILED', 'BLOCKED'];
END;
