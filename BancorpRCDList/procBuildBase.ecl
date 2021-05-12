import BancorpRCDList,VersionControl,std;

export procBuildBase(string pVersion, boolean isDelta=true):=function

    loadfile:=BancorpRCDList.files.infile;

    RemoveDate:=project(loadfile,transform(BancorpRCDList.layouts.base,self:=left;));
    UniqueSSNs:=table(RemoveDate(trim(ssn,left,right)<>''),{ssn},ssn);
    PreviousFile:=BancorpRCDList.files.base;
    OnlyNew:=join(distribute(PreviousFile,hash(ssn)),distribute(UniqueSSNs,hash(ssn)),left.ssn=right.ssn,transform(right),right only,local);
    VersionControl.macBuildNewLogicalFile(BancorpRCDList.Filenames(pVersion).Base.RCDList.new			,OnlyNew			,buildBase			,TRUE);
    DeltaSteps:=sequential(
	buildBase,
	fileservices.addsuperfile('~thor_data400::base::BancorpRCDList::qa::SSN', BancorpRCDList.Filenames(pVersion).base.RCDList.new);
    );
    RefreshSteps:=sequential(
	buildBase,
	STD.File.PromoteSuperFileList(['~thor_data400::base::BancorpRCDList::qa::SSN','~thor_data400::father::BancorpRCDList::qa::SSN','~thor_data400::base::BancorpRCDList::grandfather::SSN'],BancorpRCDList.Filenames(pVersion).base.RCDList.new,true);
    );

    BuildFile:=if(isDelta,DeltaSteps,RefreshSteps);
    return BuildFile;

end;