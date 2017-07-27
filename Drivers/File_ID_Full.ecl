lBaseIDName := (Drivers.Cluster + 'in::DrvLic_ID_Full_');

export File_ID_Full
 :=	dataset(lBaseIDName + '20030317',drivers.Layout_ID_Full,flat)
 +	dataset(lBaseIDName + '20030422',drivers.Layout_ID_Full,flat)
 +	dataset(lBaseIDName + '20030509',drivers.Layout_ID_Full,flat)
 +	dataset(lBaseIDName + '20030606',drivers.Layout_ID_Full,flat)
 +	dataset(lBaseIDName + '20030709',drivers.Layout_ID_Full,flat)
 +	dataset(lBaseIDName + '20030813',drivers.Layout_ID_Full,flat)
 +	dataset(lBaseIDName + '20030919',drivers.Layout_ID_Full,flat)
 +	dataset(lBaseIDName + '20031030',drivers.Layout_ID_Full,flat)
 +	dataset(lBaseIDName + '20031119',drivers.Layout_ID_Full,flat)
 +	dataset(lBaseIDName + '20040204',drivers.Layout_ID_Full,flat)
 +	dataset(lBaseIDName + '20040211',drivers.Layout_ID_Full,flat)
 +	dataset(lBaseIDName + '20040223',drivers.Layout_ID_Full,flat)
 +	dataset(lBaseIDName + '20040326',drivers.Layout_ID_Full,flat)
 +	dataset(lBaseIDName + '20040505',drivers.Layout_ID_Full,flat)
 +	dataset(lBaseIDName + '20040518',drivers.Layout_ID_Full,flat)
 ;