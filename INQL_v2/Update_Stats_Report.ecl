Import ut;

EXPORT Update_Reports (string version, boolean isFCRA = false, boolean pDaily = true) := MODULE

 inq_file := inql_v2.Files(,isFCRA,true).Inql_Base.building_reports 
												  (~inquiry_acclogs.fnTranslations.is_SubMarketFilter(allow_flags.allowflags) and
													 ~inquiry_acclogs.fnTranslations.is_IndustryFilter(allow_flags.allowflags) and
													 ~inquiry_acclogs.fnTranslations.is_VerticalFilter(allow_flags.allowflags) and
													 ~inquiry_acclogs.fnTranslations.is_Disable_Observation(allow_flags.allowflags) and
													 ~inquiry_acclogs.fnTranslations.is_Internal(allow_flags.allowflags) and
													 ~inquiry_acclogs.fnTranslations.is_AdditionalHealthcare(allow_flags.allowflags) and
													(mbs.company_id <> '' or MBS.global_company_id <> '')
												  );

end;