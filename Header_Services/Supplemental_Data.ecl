
import header_services, std;

export Supplemental_Data := module

  export unix_path := header_services.ProductionLZ.Directory_Loc1 : stored('unix_path_override');

  export IP 													:= header_services.ProductionLZ.IP_Loc; 

  shared emailAddr										:= header_services.ProductionLZ.notification_email;
  shared emailInfo 										:= '\r\n Job Name: ' + thorlib.jobname() + ' \r\n User Name: ' + thorlib.jobowner() + ' \r\n Cluster: ' + thorlib.cluster();
  export emailMsg(string msg)					:= FileServices.sendemail(emailAddr, 'Upload from Drop Zone Status ' + Thorlib.WUID(), msg + emailInfo);

  export full_file_name(string fname) := STD.File.ExternalLogicalFileName(IP, unix_path + fname);

  export enhFileName 									:= 'file_enhanced_fnames.txt'; //AR
  export enhfull_file_name 						:= STD.File.ExternalLogicalFileName(IP, unix_path + enhFileName);  //AR

  export should_fail := true : stored('fail_switch');

  export check_found(string fullname) := 
    function
        // output(fullname);
        file_exists					:= std.file.fileexists(fullname);
        file_not_found_msg  := 'supplemental data file ' + fullname + ' not found';
        file_not_found 			:= if(should_fail
                                  , sequential(emailMsg(file_not_found_msg)
                                            , fail(file_not_found_msg))
                                  , emailMsg(file_not_found_msg)
        );
        if(not file_exists
            , file_not_found);
      
        return file_exists;
    end;	

  export check_size(string fname, unsigned record_length) := 
    function
        fsize 						:= STD.File.RemoteDirectory(IP, unix_path, fname)[1].size;
        file_size_good   	:= (((fsize % record_length) = 0) or (fsize % (record_length+8) = 0)) and (fsize <> 0);
        size_failure_msg 	:= 'unexpected supplemental data file size/record length: ' + fsize 
                              + ', expected record length: ' +  record_length + ' for '+ full_file_name(fname);
        size_failure     	:= if(should_fail
                                , sequential(emailMsg(size_failure_msg), fail(size_failure_msg))
                                , emailMsg(size_failure_msg)
        );
        if(not file_size_good
            , size_failure);
      
        return file_size_good;
    end;		


  export determine_file( fname, layout) := functionmacro			
    enhanced_layout := record 
        unsigned8 record_source_id; 
        layout;
    end;

    enh_base_file:=dataset(fname, enhanced_layout, flat);
    base_file:=dataset(fname, layout, flat);
    unenhanced_base_ds := project(enh_base_file(record_source_id % 2 = 0) ,
        transform(layout,
            self := left;
            self := []));
  
    final_file := if(is_enhancedFile, unenhanced_base_ds, base_file); 
        
    return final_file;
  endmacro;	

  export is_file_enh(string enhffName, string fname) := function
    enhanced_fname_layout := 
        record 
            string32 file_name;
            string2  crlf;
        end;
    enhffds := 	dataset(enhffName, enhanced_fname_layout, flat);
                  
    enhfile	:= enhffds(file_name=stringlib.Data2String(hashmd5(fname)));
    enhfilecnt := if(count(enhfile)>0, true, false);
    return enhfilecnt;
  end;

  export mac_verify(file,layout,attr) := macro
    #uniquename(SD)
    %SD% := header_services.Supplemental_Data;
  
    dataset(layout) attr() := function						
        full_file_path    := %SD%.full_file_name(file);
        isFound         	:= nothor(%SD%.check_found(full_file_path));			
              
        record_length			:= sizeof(Layout);
        isSizeGood        := %SD%.check_size(file, record_length);

        enhfull_file_path := %SD%.enhfull_file_name;		
        is_enhFound       := nothor(%SD%.check_found(enhfull_file_path));
        is_enhancedFile		:= %SD%.is_file_enh(enhfull_file_path, file);

        determine_outfile	:= %SD%.determine_file(full_file_path, layout);

        success_msg       := 'successfully read supplemental data file ' + full_file_path;
        success_email     := %SD%.emailMsg(success_msg);
        if(isFound
            , if(isSizeGood
                , success_email));
      
        return if( isFound and isSizeGood
                  , determine_outfile
                  , dataset([],layout) );
      
    end;
  endmacro;

  export layout_in := record
    string32 hval_s;
    string2  nl;
  end;

  export layout_out := record
    data16 hval;
  end;

  export layout_out in_to_out(layout_in l) := transform
    self.hval := stringlib.string2data(l.hval_s);
  end; 

end; //module





