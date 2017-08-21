import Prof_License;

EXPORT fn_ValidateLicInBase(dataset(Prof_License.Layout_proLic_in) prepfile, dataset(Prof_License.Layout_proLic_in) basefile,string st)  := module

dInprep := distribute( prepfile (license_number <> '') , hash(license_number));

dInbase := distribute( basefile (license_number <> ''), hash(license_number));



Prof_License.Layout_proLic_in getlic ( dInprep l , dInbase r) := transform
self := l;
end;

Lic_not_in_base := join ( dInprep , dInbase,
                     left.license_number=right.license_number,
										 getlic(left,right),
										 left only,
										 local
									 );
									 
									 
basefile_old := dataset('~thor_data400::in::prolic_'+st+'_old',Prof_License.Layout_proLic_in,flat);

dInbaseold := distribute( basefile_old (license_number <> ''), hash(license_number));


Prof_License.Layout_proLic_in getlicnew ( dInprep l , dInbaseold r) := transform
self := l;
end;

newlicadded := join ( dInprep , dInbaseold,
                     left.license_number=right.license_number,
										 getlicnew(left,right),
										 left only,
										 local
									 );

export out := if ( count ( Lic_not_in_base ) > 0 or count(newlicadded) = 0, Output('Missing License numbers in base or No New Licenses added '+st)
                                       , Output(' Prep process for state '+st + ' looks good.Count of new license added --'+count(newlicadded) )
																			 
							);
							
end;