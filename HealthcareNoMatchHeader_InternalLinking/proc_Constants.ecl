// constants for Healthcare NoMatch build processing
IMPORT tools, _Control;
 
EXPORT proc_Constants := MODULE
  EXPORT  IsDataland        :=  tools._Constants.IsDataland;
  EXPORT  primaryQueue      :=  IF(IsDataland, 'thor400_sta_eclcc', 'thor400_44_eclcc');
  EXPORT  secondaryQueue    :=  IF(IsDataland, 'thor400_sta_eclcc', 'thor400_44_eclcc');
  EXPORT  startIter         :=  1;
  EXPORT  numIters          :=  4;
  EXPORT  pollingFreq       :=  '1';
  EXPORT  outECL            :=  FALSE;
  EXPORT  emailNotifyOps    :=  '';
  EXPORT  emailNotifyHeader :=  'kevin.garrity@lexisnexisrisk.com';
  EXPORT  emailNotifyQA     :=  '';
  EXPORT  emailNotify       :=  IF(IsDataland, emailNotifyHeader, emailNotifyOps +','+ emailNotifyHeader);
  EXPORT  emailNotifyAll    :=  emailNotify +','+ emailNotifyQA;
  EXPORT  stopThreshold     :=  0.001;
END;
