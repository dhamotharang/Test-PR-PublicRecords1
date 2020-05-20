ds_clean := bipv2.CommonBase.ds_built(ingest_status != 'Old');

ds_clean_slim := table(ds_clean ,{string source := BIPV2.mod_sources.TranslateSource_aggregate(source)  ,boolean is_partitioned := if(trim(BIPV2.mod_sources.src2partition(source)) = '' ,false  ,true)    });

ds_clean_table := table(ds_clean_slim ,{source  ,is_partitioned,unsigned cnt := count(group)} ,source ,is_partitioned ,few);

output(sort(ds_clean_table ,source)  ,named('BIP_Clean_Sources'));