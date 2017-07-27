import ut, vehlic, Fair_Isaac;
/*
//***** These are from the Fair Isaacs Test (source = F)
fi_fat := did_regression.Fair_Isaac_Prep;

//***** Put some vehicle recs into common format (source = V)
ve_fat := did_regression.Vehicles_Prep;

//****** Put the Checkfree File in the common format (source = C)
cf_fat := did_regression.Checkfree_Prep;

//****** Put the EFX File in the common format (source = E)
efx_fat := did_regression.Equifax_Prep;

//****** Get some records that will only be DIDable by phone (source = P)
ph_fat := did_regression.Phone_Prep;

//***** Criminal records, from the xlink file (source = R)
crim_fat := did_regression.Crim_Prep;

// add some sex offenders (source = S)
so_fat := did_regression.SexOffend_Prep;

//throw in some utility records, mix well, and bake at 350 for 25 min.
// (source = U)
ut_fat := did_regression.Util_Prep;

//****** Slap an RID on these
both_fat := cf_fat + efx_fat + ve_fat + fi_fat + ph_fat + crim_fat + so_fat + ut_fat;

ut.MAC_Sequence_Records(both_fat, rid, both_id)

export Common_Prep := both_id : persist('Common_Prep','400way');
*/

export Common_Prep := dataset('~thor_hank::BASE::Common_Prep_newlayout', did_regression.Layout_Common, flat);