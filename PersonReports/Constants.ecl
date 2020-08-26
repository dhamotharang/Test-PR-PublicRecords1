IMPORT iesp;

export Constants := MODULE
  // is used as a sequence number in an address table to indicate that address was added
  // using residents records; can improve address-phone match.
  export integer APPENDED_BY_RESIDENTS := -1000;

  // TODO: check these defaults!
  // export boolean Include_PriorProperties_val := FALSE;
  // export boolean Use_CurrentlyOwnedProperty_value := TRUE;

// TODO: must be in sync with  IPTree* BpsDenormalizer::buildSourceCountsSection()
  export SourceData := dataset ([
      {'Federal Firearms and Explosives Licenses', 0, 'ATF', 'Retrievable'},
      {'Bankruptcy Records', 0, 'BK', 'Retrievable'},
      {'Bankruptcy Records', 0, 'BK_V2', 'Retrievable'},
      {'Liens and Judgments', 0, 'LIEN', 'Retrievable'},
      {'Liens and Judgments', 0, 'LIEN_V2', 'Retrievable'},
      {'Driver Licenses', 0, 'DL', 'Retrievable'},
      {'Driver Licenses', 0, 'DL_V2', 'Retrievable'},
      {'DECEASED', 0, 'DEATH', 'Retrievable'},
      {'Professional Licenses', 0, 'PROFLIC', 'Retrievable'},
      {'Professional Licenses', 0, 'PROFLIC', 'Retrievable'},
      {'Providers', 0, 'PROV', 'Retrievable'},
      {'Sanctions', 0, 'SANC', 'Retrievable'},
      {'Motor Vehicle Rigistrations', 0, 'VEH', 'Retrievable'},
      {'Motor Vehicle Rigistrations', 0, 'VEH', 'Retrievable'},
      {'Motor Vehicle Rigistrations', 0, 'VEH_2', 'Retrievable'},
      {'Person Locator 1', 0, 'PL1', 'Retrievable'},
      {'DEA Controled Substance Registrations', 0, 'DEA', 'Retrievable'},
      {'DEA Controled Substance Registrations', 0, 'DEA_V2', 'Retrievable'},
      {'FAA Aircraft Registrations', 0, 'AIRC', 'Retrievable'},
      {'Email addresses', 0, 'EMAIL', 'Retrievable'},
      {'FAA Pilot Licenses', 0, 'PILOT', 'Retrievable'},
      {'FAA Pilot Certifications', 0, 'PILOTCERT', 'Retrievable'},
      {'WaterCraft Registrations', 0, 'WATERCRAFT', 'Retrievable'},
      {'Corporate Affiliations', 0, 'CORPAFFIL', 'Retrievable'},
      {'MerchantVessel Registrations', 0, 'MERCHVESSEL', 'Retrievable'},
      {'Voter Registrations', 0, 'VOTER', 'Retrievable'},
      {'Voter Registrations', 0, 'VOTER_2', 'Retrievable'},
      {'PhonesPlus Records', 0, 'PP', 'Retrievable'},
      {'Weapon Permits', 0, 'CCW', 'Retrievable'},
      {'Hunting and Fishing Licenses', 0, 'HUNT', 'Retrievable'},
      {'Internet Domain Registrations', 0, 'WHOIS', 'Retrievable'},
      {'Phone', 0, 'PHONE', 'Retrievable'},
      {'Accident', 0, 'FLCRASH', 'Retrievable'},
      {'SexualOffense', 0, 'SO', 'Retrievable'},
      {'Alaska Permanent Fund', 0, 'AK', 'Retrievable'},
      {'Mississippi Worker\'s Compensation', 0, 'MSWORK', 'Retrievable'},
      {'Foreclosure Records', 0, 'FOR', 'Retrievable'},
      {'Notice Of Defaults Records', 0, 'NOD', 'Retrievable'},
      {'Fictitious Business Names Records', 0, 'FBNV2', 'Retrievable'},
      {'Boat Registrations', 0, 'BOATER', 'Retrievable'},
      {'UCC Lien Filings', 0, 'UCC', 'Retrievable'},
      {'UCC Lien Filings', 0, 'UCC_V2', 'Retrievable'},
      {'Historical Person Locator', 0, 'FINDER', 'Retrievable'},
      {'Person Locator 2', 0, 'PL2', 'Retrievable'},
      {'Deed Transfers', 0, 'DEED', 'Retrievable'},
      {'Deed Transfers', 0, 'DEED_V2', 'Retrievable'},
      {'Criminal', 0, 'DOC', 'Retrievable'},
      {'Tax Assessor Records', 0, 'ASSESSMENT', 'Retrievable'},
      {'Tax Assessor Records', 0, 'ASSESSMENT_V2', 'Retrievable'},
      {'Utility Locator', 0, 'UTIL', 'Retrievable'},
      {'State Death Records', 0, 'STATEDEATH', 'Retrievable'},
      {'Person Locator 4', 0, 'TARG', 'Retrievable'}
    ], iesp.share.t_SourceSection);

export RealEstate := 1;
export UCC := 2;
export JudgementLien := 3;
export Bankruptcy := 4;
export AttorneyClient := 5;
export OtherProp := 6;
export Business := 7;
export PossibleRoommate := 8;
export Associate := 9;

export rolesSet := ['Real Property','UCC','Judgment/Lien','Bankruptcy','Attorney-Client','Personal Property','Business','Possible Roommate','Associate'];

END;