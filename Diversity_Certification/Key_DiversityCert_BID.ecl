Import Data_Services, doxie;

base := Diversity_Certification.Files().KeyBuildSF(bid>0);			   
valid_base  :=base (sizeof(base)<=4096);

 rec:=RECORD
   ,maxLength(9999)
     Diversity_Certification.Layouts.KeyBuild-bid;
    END;

newbase:=project(valid_base ,TRANSFORM(rec,self.bdid :=left.bid ,SELF := LEFT;));
export Key_DiversityCert_BID := index(newbase,
							                     {bdid},
												 {newbase},
							                     Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::Diversity_Certification::'+doxie.Version_SuperKey+'::BID');