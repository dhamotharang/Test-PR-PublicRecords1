lBaseName := '~thor_200::in::pad_';

export File_PA_Full
 := dataset(lBaseName + '20040203',matrix_dl.Layout_PA_Full,flat)
 +	dataset(lBaseName + '20040505',matrix_dl.Layout_PA_Full,flat)
 +	dataset(lBaseName + '20040706',matrix_dl.Layout_PA_Full,flat)
 +	dataset(lBaseName + '20040816',matrix_dl.Layout_PA_Full,flat)
 +	dataset(lBaseName + '20040929',matrix_dl.Layout_PA_Full,flat)
 +	dataset(lBaseName + '20041005',matrix_dl.Layout_PA_Full,flat)
 +	dataset(lBaseName + '20041118',matrix_dl.Layout_PA_Full,flat)
 +	dataset(lBaseName + '20041214',matrix_dl.Layout_PA_Full,flat)
 +	dataset(lBaseName + '20050120',matrix_dl.Layout_PA_Full,flat)
 +	dataset(lBaseName + '20050303',matrix_dl.Layout_PA_Full,flat)
 ;