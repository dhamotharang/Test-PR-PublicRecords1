
IMPORT prte2;

EXPORT fSpray := FUNCTION

return  parallel(prte2.SprayFiles.Spray_Raw_Data('phonesmetadata___transactions__', 'metadata_trans', 'met'),
        prte2.SprayFiles.Spray_Raw_Data('phonesmetadata___type__', 'metadata_type', 'met')
				);

end;


