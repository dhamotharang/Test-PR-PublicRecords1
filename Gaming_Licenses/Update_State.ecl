export Update_State :=
module

	export NJ(string pversion) := Update_NJ(
									         Gaming_Licenses.Files().input.NJ.using
									        ,Gaming_Licenses.Files().base.NJ.qa
									        ,pversion
						                     );
end;