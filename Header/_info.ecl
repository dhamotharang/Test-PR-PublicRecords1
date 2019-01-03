IMPORT STD,dops;

EXPORT _info := MODULE

    EXPORT dops_datasetname:='PersonHeaderKeys';
    EXPORT current_prod_roxie_version := dops.GetBuildVersion(dops_datasetname,'B','N','P')[1..9];

    hdr_base_prod := '~thor_data400::base::header_prod';
    EXPORT version_base_qa:=regexfind('[0-9]{8}',nothor(STD.File.SuperFileContents(hdr_base_prod))[1].name,0);

    EXPORT wuidLink:= 'http://prod_esp.br.seisint.com:8010/?Wuid='+workunit+'&Widget=WUDetailsWidget#/stub/Summary';

END;