IMPORT ut, std, prte2;

EXPORT fSpray := FUNCTION

	RETURN PARALLEL(prte2.SprayFiles.Spray_Raw_Data('bkv3__main','main','bankruptcy'),
									prte2.SprayFiles.Spray_Raw_Data('bkv3__comments','comments','bankruptcy'),
									prte2.SprayFiles.Spray_Raw_Data('bkv3__status','status','bankruptcy'),
									prte2.SprayFiles.Spray_Raw_Data('bkv3__search','search','bankruptcy')
									);
END;