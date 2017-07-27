
EXPORT fn_MeetsAuthRepMinInputRequirements( DATASET(BusinessInstantID20_Services.Layouts.InputAuthRepInfoClean) AuthReps ) := 
		AuthReps( TRIM(FirstName) != '' AND TRIM(LastName) != '' );