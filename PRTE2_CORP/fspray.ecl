IMPORT prte2;

EXPORT fSpray := FUNCTION

RETURN PARALLEL(
									prte2.SprayFiles.Spray_Raw_Data('corp2__ar__', 'ar', 'corp2'),
									prte2.SprayFiles.Spray_Raw_Data('corp2__cont__', 'cont', 'corp2'),
									prte2.SprayFiles.Spray_Raw_Data('corp2__corp__', 'corp', 'corp2'),
									prte2.SprayFiles.Spray_Raw_Data('corp2__event__', 'event', 'corp2'),
									prte2.SprayFiles.Spray_Raw_Data('corp2__stock__', 'stock', 'corp2')
								);
END;


