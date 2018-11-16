layout_names := RECORD
   string name;
  END;
mylay := RECORD
  string24 wuid;
  string owner;
  string cluster;
  string job;
  string10 state;
  string7 priority;
  boolean online;
  boolean protected;
  string totalthortime;
  string description;
  string version;
  string iteration;
  string preclustercount;
  string postclustercount;
  string basicmatchesperformed;
  string matchesperformed;
  string slicesperformed;
  DATASET(layout_names) filesread;
  DATASET(layout_names) fileswritten;
 END;
output(project(dataset('~bipv2_build::qa::summary_report::proc_lgid3.iterations',mylay,flat),mylay - filesread - fileswritten - priority - online - protected - cluster - state - totalthortime - description)(regexfind('20150512|20150420',version,nocase)));
