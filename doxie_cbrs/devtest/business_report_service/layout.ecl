IMPORT doxie_cbrs;

EXPORT layout := MODULE

  EXPORT request := RECORD
    STRING glbpurpose;
    STRING dppapurpose;
    STRING industryclass;
    STRING applicationtype;
    STRING datapermissionmask;
    STRING datarestrictionmask;
    STRING bdid;
    STRING addr;
    STRING city;
    STRING zip;
    STRING companyname;
    STRING alternatecompanyname;
    STRING taxidnumber;
    STRING businessphone;
    STRING bankruptcyversion;
    BOOLEAN selectindividually;
    BOOLEAN alwayscompute;
    BOOLEAN include_bus_dppa;
    BOOLEAN includeaddressvariations;
    BOOLEAN includeaircrafts;
    BOOLEAN includeassociatedpeople;
    BOOLEAN includebankruptcies;
    BOOLEAN includebankruptciesv2;
    BOOLEAN includebusinessassociates;
    BOOLEAN includebusinessregistrations;
    BOOLEAN includecompanyidnumbers;
    BOOLEAN includecompanyprofile;
    BOOLEAN includecompanyprofilev2;
    BOOLEAN includecompanyverification;
    BOOLEAN includedca;
    BOOLEAN includedunbradstreetrecords;
    BOOLEAN includeexecutives;
    BOOLEAN includeexperianbusinessreports;
    BOOLEAN includeforeclosures;
    BOOLEAN includeindustryinformation;
    BOOLEAN includeinternetdomains;
    BOOLEAN includeirs5500;
    BOOLEAN includeliensjudgments;
    BOOLEAN includeliensjudgmentsv2;
    BOOLEAN includemotorvehicles;
    BOOLEAN includemotorvehiclesv2;
    BOOLEAN includenamevariations;
    BOOLEAN includenoticeofdefaults;
    BOOLEAN includephonesummary;
    BOOLEAN includephonevariations;
    BOOLEAN includeprofessionallicenses;
    BOOLEAN includeproperties;
    BOOLEAN includepropertiesv2;
    BOOLEAN includeregisteredagents;
    BOOLEAN includesales;
    BOOLEAN includesanctions;
    BOOLEAN includesourcecounts;
    BOOLEAN includesourceflags;
    BOOLEAN includeuccfilings;
    BOOLEAN includeuccfilingsv2;
    BOOLEAN includewatercrafts;
  END;

  EXPORT response := RECORD
    string1 nada;
    //doxie_cbrs.layout_report;
  END;

END;
