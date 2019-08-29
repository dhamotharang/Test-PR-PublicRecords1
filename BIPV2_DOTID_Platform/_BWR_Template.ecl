import BIPV2_Files,BIPV2_Build;

iteration := '@iteration@';
pversion  := '@version@';
lih       := BIPV2_Files.files_dotid.DS_DOTID_BUILDING;

#workunit('name','BIPV2 DotID ' + pversion + ' iter ' + iteration);
#workunit('priority','high');

BIPV2_Build.proc_dotid(lih,iteration).runIter;