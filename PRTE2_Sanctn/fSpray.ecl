import ut, std, prte2;

EXPORT fSpray := function
	return parallel(prte2.SprayFiles.Spray_Raw_Data('sanctn__incident','incident','sanctn'),
									prte2.SprayFiles.Spray_Raw_Data('sanctn__license','license','sanctn'),
									prte2.SprayFiles.Spray_Raw_Data('sanctn__party','party','sanctn'),
									prte2.SprayFiles.Spray_Raw_Data('sanctn__party_aka_dba','party_aka_dba','sanctn'),
									prte2.SprayFiles.Spray_Raw_Data('sanctn__rebuttal','rebuttal','sanctn')
									);
end;									