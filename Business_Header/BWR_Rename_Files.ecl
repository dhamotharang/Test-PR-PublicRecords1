import business_header,doxie, VersionControl;

all_superkeynames := DATASET([

	 {business_header.Filenames.OldConvention.Base.Stat.root				, business_header.Filenames.NewConvention.Base.Stat.Template				}
	,{business_header.Filenames.OldConvention.Base.Search.qa				, business_header.Filenames.NewConvention.Base.Search.Template				}
	,{business_header.Filenames.OldConvention.Base.HeaderBest.root			, business_header.Filenames.NewConvention.Base.HeaderBest.Template			}
	,{business_header.Filenames.OldConvention.Base.Relatives.root			, business_header.Filenames.NewConvention.Base.Relatives.Template			}
	,{business_header.Filenames.OldConvention.Base.RelativesGroup.root		, business_header.Filenames.NewConvention.Base.RelativesGroup.Template		}
	,{business_header.Filenames.OldConvention.Base.Companyname.root			, business_header.Filenames.NewConvention.Base.Companyname.Template			}
	,{business_header.Filenames.OldConvention.Base.CompanynameAddress.root	, business_header.Filenames.NewConvention.Base.CompanynameAddress.Template	}
	,{business_header.Filenames.OldConvention.Base.CompanynamePhone.root	, business_header.Filenames.NewConvention.Base.CompanynamePhone.Template	}
	,{business_header.Filenames.OldConvention.Base.CompanynameFein.root		, business_header.Filenames.NewConvention.Base.CompanynameFein.Template		}
	,{business_header.Filenames.OldConvention.Base.SuperGroup.root			, business_header.Filenames.NewConvention.Base.SuperGroup.Template			}
	,{business_header.Filenames.OldConvention.Base.CompanyWords.root		, business_header.Filenames.NewConvention.Base.CompanyWords.Template		}
	,{business_header.Filenames.OldConvention.Base.Bdid.root				, business_header.Filenames.NewConvention.Base.Bdid.Template				}
	,{business_header.Filenames.OldConvention.Base.AddressSicCode.root		, business_header.Filenames.NewConvention.Base.AddressSicCode.Template		}
	,{business_header.Filenames.OldConvention.Base.AddressSicCode2.root		, business_header.Filenames.NewConvention.Base.AddressSicCode2.Template		}
	,{business_header.Filenames.OldConvention.Base.PeopleAtWorkStats.root	, business_header.Filenames.NewConvention.Base.PeopleAtWorkStats.Template	}
	,{business_header.Filenames.OldConvention.Base.Contacts.qa				, business_header.Filenames.NewConvention.Base.Contacts.Template			}

], versioncontrol.Layout_Superkeynames.InputLayout);                                                                

rename_keys := versioncontrol.fLogicalKeyRenaming(all_superkeynames, true, business_header.Version);

rename_keys;
