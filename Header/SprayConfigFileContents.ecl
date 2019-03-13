import PromoteSupers, std;

sf_name := 'thor_data400::out::spray_config_file_contents';

EXPORT SprayConfigFileContents(string bld_name, string lz_ip = '', string lz_dir = '') := MODULE

    shared rec := record
      string build_name;
      string lz_ip;
      string lz_dir;
    end;
    
    EXPORT Read  := dataset(sf_name, rec, thor)(build_name = STD.Str.ToUpperCase(bld_name));
	
    ds	:= dataset([{STD.Str.ToUpperCase(bld_name), lz_ip, lz_dir}], rec) + Read(build_name <> STD.Str.ToUpperCase(bld_name));
	PromoteSupers.MAC_SF_BuildProcess(ds, sf_name, Post ,2,,true,thorlib.wuid()+random());
	EXPORT Write := sequential(
                        if(~STD.File.FileExists(sf_name), STD.File.CreateSuperFile(sf_name)),
                        if(~STD.File.FileExists(sf_name + '_father'), STD.File.CreateSuperFile(sf_name + '_father')),
                        Post);      
   
END;