export Update_State :=
module

	export CA(string pversion) := Update_CA(
									 Liquor_Licenses.Files().input.CA.using
									,Liquor_Licenses.Files().base.CA.qa
									,pversion
								);
	export CT(string pversion) := Update_CT(
									 Liquor_Licenses.Files().input.CT.using
									,Liquor_Licenses.Files().base.CT.qa
									,pversion
								);
	export IN(string pversion) := Update_IN(
									 Liquor_Licenses.Files().input.IN.using
									,Liquor_Licenses.Files().base.IN.qa
									,pversion
								);
	export LA(string pversion) := Update_LA(
									 Liquor_Licenses.Files().input.LA.using
									,Liquor_Licenses.Files().base.LA.qa
									,pversion
								);
	export OH(string pversion) := Update_OH(
									 Liquor_Licenses.Files().input.OH.using
									,Liquor_Licenses.Files().base.OH.qa
									,pversion
								);
	
	export PA(string pversion) := Update_PA(
									 Liquor_Licenses.Files().input.PA.using
									,Liquor_Licenses.Files().base.PA.qa
									,pversion
								);

	export TX(string pversion) := Update_TX(
									 Liquor_Licenses.Files().input.TX.using
									,Liquor_Licenses.Files().base.TX.qa
									,pversion
								);


end;