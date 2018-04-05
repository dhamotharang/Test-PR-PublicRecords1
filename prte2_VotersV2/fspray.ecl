IMPORT prte2;

EXPORT fSpray := FUNCTION

//The line below is used temporarily until a shorter string can be used for a successful spray

RETURN prte2.SprayFiles.Spray_Raw_Data('VotersV2','','voters');

//return prte2.SprayFiles.Spray_Raw_Data('voters', '', 'voters');

END;