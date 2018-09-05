import ut, std, prte2;

EXPORT fSpray := function
	return parallel(prte2.SprayFiles.Spray_Raw_Data('prte__sanctn__incident','incident','sanctn'),
									prte2.SprayFiles.Spray_Raw_Data('prte__sanctn__license','license','sanctn'),
									prte2.SprayFiles.Spray_Raw_Data('prte__sanctn__party__','party','sanctn'),
									prte2.SprayFiles.Spray_Raw_Data('prte__sanctn__party_aka_dba__','party_aka_dba','sanctn'),
									prte2.SprayFiles.Spray_Raw_Data('prte__sanctn__rebuttal','rebuttal','sanctn')
									);
end;									