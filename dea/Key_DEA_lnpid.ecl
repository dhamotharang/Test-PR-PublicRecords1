import doxie,dea,ut;

BASE := dea.file_DEA_Lnpid((integer)lnpid != 0);
slim_layout:= record
        String9	Dea_Registration_Number;
			  unsigned8    lnpid;
end;

DEAid_base          := dedup(sort(distribute(project(base,slim_layout), hash(lnpid)),lnpid,DEA_REGISTRATION_NUMBER,local),lnpid,DEA_REGISTRATION_NUMBER,local);

EXPORT Key_DEA_LNPID := INDEX(DEAid_base,
							               {LNPID},
							               {DEAid_base},
							                 '~thor_data400::key::dea::' + doxie.Version_SuperKey + '::lnpid');