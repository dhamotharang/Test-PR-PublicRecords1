IMPORT prte2;

EXPORT fSpray := FUNCTION

return Parallel(
									prte2.SprayFiles.Spray_Raw_Data('gong__history__base', '', 'Gong_History', true),
									prte2.SprayFiles.Spray_Raw_Data('gong__weekly', '', 'Gong_Weekly', true),
									prte2.SprayFiles.Spray_Raw_Data('gong__santander__base', '', 'Gong_Santander', true));

END;