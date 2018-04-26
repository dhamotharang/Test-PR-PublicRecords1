import DOPSGrowthCheck;
export HasPrevious(string PackageName,string keyfile,string Oldversion) := function
    TestFile:=dataset('~thor_data400::DeltaStats::'+PackageName+'::IndividualFileStats',DOPSGrowthCheck.layouts.Unique_Stats_Layout,thor,__compressed__,opt);
    return if(exists(TestFile(KeyName=KeyFile and Version=Oldversion)),'true','false');
end;