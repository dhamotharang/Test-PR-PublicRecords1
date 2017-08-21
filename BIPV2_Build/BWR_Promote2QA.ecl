import BIPV2;
#workunit('name','BIPV2_Build.proc_Promote2QA ' + bipv2.KeySuffix);
BIPV2_Build.proc_Promote2QA(pversion := bipv2.KeySuffix /*,pShouldUpdateDOPS := true*/);