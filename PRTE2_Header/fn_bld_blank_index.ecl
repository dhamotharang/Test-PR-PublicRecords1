IMPORT data_services,header;

// example
// fn_bld_blank_index('','doxie.key_header_address_research  ','thor_data400::key::address_research',           '::address_research','~prte::key::header::',filedate,       '01')
           

EXPORT fn_bld_blank_index (string ds_text='',           // if blank will initialize a blank dataset. Must contain fields to support the key build
                           string key_ref_text,         // The key attributre in text form to use as a basis for the key payload
                           string iName,                // The original key prefix to use in querying the layout of the key
                           string sfx,                  // key ending eg ::address
                           string kp,                   // new key prefix
                           string fdate,                // version for the key build
                           string3 seq,                 // numbrical increment if you are building multiple keys
                           string midFix=''             // if the key has a midfix before the fdate
                           ):= FUNCTION
           
    loc := data_services.Data_location.prefix('person_header');
    refrence_key_name := if(length(midFix)=0,'~'+iName+'_qa','~'+iName+midFix+sfx);
    key_layout := header.cmd_text.fgetkeyedcolumns(refrence_key_name);
    ds_name:=if(ds_text='','dataset([],payload'+seq+')',ds_text);
    return 
            'payload'+seq+':=recordof('+key_ref_text+');\n'+
            'ds'+seq+':='+ds_name+';\n'+
            'dp'+seq+' := project(ds'+seq+',payload'+seq+');\n'+
            'daIndex'+seq+':=index(dp'+seq+',{'+key_layout+'}\n'+
            ',{dp'+seq+'} AND NOT ['+key_layout+']\n'+
            ',\''+refrence_key_name+'\');\n'+
            'RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(daIndex'+seq+',\''+kp+sfx[3..]+'\',\''+kp+fdate+sfx+'\',bld'+seq+');\n\n'
             ;
    
    END;