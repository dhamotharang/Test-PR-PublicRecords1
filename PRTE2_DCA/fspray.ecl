IMPORT prte2;

EXPORT fSpray := FUNCTION

//Verify that the file names for the logical file, the second parameter, matches your IN superfile name.  It should be blank
//if you only have one input file to spray.

return prte2.SprayFiles.Spray_Raw_Data('dca__base', '', 'dca');

END;

