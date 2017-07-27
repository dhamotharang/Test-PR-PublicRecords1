IMPORT Data_Services, doxie;

 base := PROJECT(GSA.File_GSA_LNPID(lnpid != 0), TRANSFORM(GSA.Layouts_GSA.layout_Base, SELF := LEFT));
  slim_layout:= record
    unsigned8  gsa_id;
    unsigned8    lnpid;
end;

gsaid_base          := dedup(sort(distribute(project(base,slim_layout), hash(lnpid)),lnpid,gsa_id,local),lnpid,gsa_id,local);

EXPORT Key_GSA_LNPID := INDEX(gsaid_base,
							               {LNPID},
							               {gsaid_base},
							               Data_Services.Data_location.Prefix('GSA') +
															  'thor_data400::key::gsa::' + doxie.Version_SuperKey + '::lnpid');