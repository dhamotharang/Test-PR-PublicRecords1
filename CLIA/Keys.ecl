IMPORT doxie, tools;

EXPORT Keys(STRING pversion = '',
	          DATASET(Layouts.Base) pBaseBuilt = Files(pversion).Base.Main.Built) := MODULE

	SHARED Base := PROJECT(pBaseBuilt(CLIA_Number != ''), Layouts.KeyBuild);
	SHARED Base_BDID := Base(BDID != 0);
	SHARED Base_LNpid	:= pBaseBuilt(lnpid>0);
	
	slim_layout	:= record
			string10 CLIA_number;
			unsigned8	lnpid;
	end;

	shared lnpid_base	:= dedup(sort(distribute(project(base_lnpid, slim_layout), hash(lnpid)),lnpid,clia_number, local),lnpid,clia_number,local);

	tools.mac_FilesIndex('Base, {CLIA_Number, record_type}, {Base}',
	                        KeyNames(pversion).CLIA_Number, CLIA_Number);
	tools.mac_FilesIndex('Base_BDID, {BDID, CLIA_Number}, {Base}',
	                        KeyNames(pversion).BDID, BDID);
	tools.mac_FilesIndex('lnpid_base, {LNpid, CLIA_Number}, {lnpid_base}',
	                        KeyNames(pversion).LNpid, LNpid);


END;