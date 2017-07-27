lMNDLBaseName := (Drivers.Cluster + 'in::drvlic_mn_full_');

export File_MN_Raw
 := dataset(lMNDLBaseName + '200301_200312', drivers.Layout_MN_Raw, flat)
 +	dataset(lMNDLBaseName + '20040108', drivers.Layout_MN_Raw, flat)
 +	dataset(lMNDLBaseName + '20040226', drivers.Layout_MN_Raw, flat)
 +	dataset(lMNDLBaseName + '20040325', drivers.Layout_MN_Raw, flat)
 +	dataset(lMNDLBaseName + '20040408', drivers.Layout_MN_Raw, flat)
 +	dataset(lMNDLBaseName + '20040508', drivers.Layout_MN_Raw, flat)
 +	dataset(lMNDLBaseName + '20040610', drivers.Layout_MN_Raw, flat)
 +	dataset(lMNDLBaseName + '20040709', drivers.Layout_MN_Raw, flat)
 +	dataset(lMNDLBaseName + '20040811', drivers.Layout_MN_Raw, flat)
 +	dataset(lMNDLBaseName + '20040909', drivers.Layout_MN_Raw, flat)
 +	dataset(lMNDLBaseName + '20041015', drivers.Layout_MN_Raw, flat)
 +	dataset(lMNDLBaseName + '20050113', drivers.Layout_MN_Raw, flat)
 +	dataset(lMNDLBaseName + '20050209', drivers.Layout_MN_Raw, flat)
 +	dataset(lMNDLBaseName + '20050314', drivers.Layout_MN_Raw, flat)
 +	dataset(lMNDLBaseName + '20050406', drivers.Layout_MN_Raw, flat)
 +	dataset(lMNDLBaseName + '20050511', drivers.Layout_MN_Raw, flat)
 +	dataset(lMNDLBaseName + '20050608', drivers.Layout_MN_Raw, flat)
 +	dataset(lMNDLBaseName + '20050708', drivers.Layout_MN_Raw, flat)
 +	dataset(lMNDLBaseName + '20050811', drivers.Layout_MN_Raw, flat)
 ;