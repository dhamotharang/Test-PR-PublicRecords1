lPAFullBaseName := '~thor_200::in::pav_';

export File_PA_Full
 :=	dataset(lPAFullBaseName + '20040203',Layout_PA_Full,flat)
 +	dataset(lPAFullBaseName + '20040505',Layout_PA_Full,flat)
 +	dataset(lPAFullBaseName + '20040706',Layout_PA_Full,flat)
 +	dataset(lPAFullBaseName + '20040816',Layout_PA_Full,flat)
 +	dataset(lPAFullBaseName + '20040929',Layout_PA_Full,flat)
 +	dataset(lPAFullBaseName + '20041005',Layout_PA_Full,flat)
 +	dataset(lPAFullBaseName + '20041118',Layout_PA_Full,flat)
 +	dataset(lPAFullBaseName + '20041214',Layout_PA_Full,flat)
 +	dataset(lPAFullBaseName + '20050120',Layout_PA_Full,flat)
 +	dataset(lPAFullBaseName + '20050303',Layout_PA_Full,flat)
 ;