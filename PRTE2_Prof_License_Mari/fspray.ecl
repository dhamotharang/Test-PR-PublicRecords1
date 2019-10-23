IMPORT ut, std, prte2;


EXPORT fSpray := FUNCTION

prte2.SprayFiles.Spray_Raw_Data('proflic_mari__search', 'search', 'proflic_mari');
prte2.SprayFiles.Spray_Raw_Data('proflic_mari__Disciplinary_Actions','disciplinary_actions','proflic_mari');
prte2.SprayFiles.Spray_Raw_Data('proflic_mari__individual_detail','individual_detail','proflic_mari');
prte2.SprayFiles.Spray_Raw_Data('proflic_mari__regulatory_actions','regulatory_actions','proflic_mari');

return 'success';

END;