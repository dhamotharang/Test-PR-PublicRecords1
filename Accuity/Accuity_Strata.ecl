import Accuity, Strata;

export Accuity_Strata(string versiondate) := function

Parent       := Accuity.Reformat.Parent.GWL                     + Accuity.Reformat.Parent.MSB	                        + Accuity.Reformat.Parent.OFAC;
Child_Addr   := Accuity.Reformat.normalizd.gwl.Addresses			  + Accuity.Reformat.normalizd.msb.Addresses						+ Accuity.Reformat.normalizd.ofac.Addresses;
Child_Alias  := Accuity.Reformat.normalizd.gwl.Alias	          + Accuity.Reformat.normalizd.msb.Alias                + Accuity.Reformat.normalizd.ofac.Alias;
Child_Dob    := Accuity.Reformat.normalizd.gwl.Dob	            + Accuity.Reformat.normalizd.msb.Dob									+ Accuity.Reformat.normalizd.ofac.Dob;
Child_ID     := Accuity.Reformat.normalizd.gwl.Identifications	+ Accuity.Reformat.normalizd.msb.Identifications			+ Accuity.Reformat.normalizd.ofac.Identifications;
Child_Phones := Accuity.Reformat.normalizd.gwl.Phones				    + Accuity.Reformat.normalizd.msb.Phones							  + Accuity.Reformat.normalizd.ofac.Phones;
Child_Pob    := Accuity.Reformat.normalizd.gwl.Pob							+ Accuity.Reformat.normalizd.msb.Pob									+ Accuity.Reformat.normalizd.ofac.Pob;
Child_Addl   := Accuity.Reformat.normalizd.gwl.supplemental		  + Accuity.Reformat.normalizd.msb.Supplemental				  + Accuity.Reformat.normalizd.ofac.Supplemental;

Accuity.Strata(Parent,
							 Child_Addr,
							 Child_Alias,
						   Child_Dob,
							 Child_ID,
							 Child_Phones,
							 Child_Pob,
							 Child_Addl,
							 versiondate,
							 out_strata);
							 
return sequential(out_strata);

end;

