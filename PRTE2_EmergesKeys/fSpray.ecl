IMPORT prte2;

EXPORT fSpray := FUNCTION

RETURN PARALLEL(
                  prte2.SprayFiles.Spray_Raw_Data('Emerges__Hunters', 'hunting_fishing', 'ccw');
									prte2.SprayFiles.Spray_Raw_Data('Emerges__CCW', 'ccw', 'ccw'));											
END;



