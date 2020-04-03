import Advo, ut, iesp, dx_Gong;

export Areacode_records (Lookup_Services.Areacode_IParam.searchParams inrec) := FUNCTION

  isAreaCodeSearch := length(trim(inrec.AreaCode))=3;
  area_rec := Lookup_Services.Areacode_layouts.AreacodeRecords;
  zip_rec  := Lookup_Services.Areacode_layouts.AreaCodeZipcodeRecords;
  area_slim := Lookup_Services.Areacode_layouts.Areacode_slim;
  area_rec fnFilterBadData(dataset(area_rec) areafile, dataset(zip_rec) zipdata):=function
    //GetThresholdDefault
    getThresholdMultiplier:=if(isAreaCodeSearch,.15,.05);
    sd_zipdata := sort(dedup(sort(zipdata,record),record),zip);
    u_zipdata := dedup(sd_zipdata,zip);
    outrec := record
      u_zipdata.zip;
      dataset(recordof(u_zipdata)) filterBasedonThreshold;
    end;

    outrec calcthresh(u_zipdata Le) := transform
        workdata := sd_zipdata(zip=Le.zip);
        //Calculate a threshold (What other areacodes are associated with this zip)
        getThreshold:=round(sum(workdata,occurs)*getThresholdMultiplier);
        //Filter out records that really do not belong to this this zipcode areacode combination or are simply POBox locations
        filterBasedonThreshold:=workdata(occurs>getThreshold and poboxpercent<80);
        self.zip := le.zip;
        self.filterBasedonThreshold := filterbasedonthreshold;
    end;
    f_zipdata := project(u_zipdata,calcthresh(left));

    Lookup_Services.Areacode_layouts.AreaCodeRecordsFilter checkZipVersusAreacode(area_rec L, f_zipdata R) :=transform
        keepRecord:=if(isAreaCodeSearch,
                      inrec.areacode in set(r.filterBasedonThreshold,areacode),
                      L.areacode in set(r.filterBasedonThreshold,areacode));
        self.good := keepRecord;
        self := L;
    end;
    //below filter appears to be happening in the keepRecord.
    areafile_1 := if(isAreaCodeSearch,areafile(areacode = inrec.areacode),areafile);

    appendFlag:=join(areafile_1,f_zipdata,left.zip = right.zip,checkZipVersusAreacode(left,right));
    filtered:=appendFlag(good=true);
    return project(filtered,area_rec);
  end;

  //Handle Areacode Searches
  areacodeData:=Project(dx_Gong.key_npa()(keyed(areacode=inrec.areacode)),area_rec);
  key_zip := dx_Gong.key_zip();
  areacodeDataAll:=Project(key_zip(keyed(zip in set(areacodeData,zip))),area_rec);
  //Handle Zipcode searches
  zipcodeData:=Project(key_zip(keyed(zip=inrec.zip)),area_rec);
  //Handle City State Searches
  ds_zips := dataset(ut.ZipsWithinCity(inrec.state,inrec.city),{Integer4 ZIP});
  getCityZipsUT := project(ds_zips,transform(recordof(Advo.Key_Addr_City),
                                      self.zip := intformat(left.zip,5,1),
                                      self := []));
  getCityZipsADVO:=Advo.Key_Addr_City(keyed(city=inrec.city) and State=inrec.state);
  getCityZips := dedup(sort(getCityZipsADVO&getCityZipsUT,zip),zip);
  cityData:=Project(key_zip(keyed(zip in set(getCityZips,zip))),area_rec);
  //Handle City Only Searches
  getCityOnlyZips:=Advo.Key_Addr_City(keyed(city=inrec.city));
  cityOnlyData:=Project(key_zip(keyed(zip in set(getCityOnlyZips,zip))),area_rec);
  //Handle State Only Searches
  getStateOnlyZips := dedup(sort(Advo.Key_Addr_City(state=inrec.State),zip),zip);
  stateOnlyData:=Project(key_zip(keyed(zip in set(getStateOnlyZips,zip))),area_rec);

  pickRecords:= map(inrec.Zip <> '' => zipcodeData,
                    inrec.City <> '' and inrec.State <> '' => cityData,
                    inrec.City <> '' => cityOnlyData,
                    inrec.areacode <> '' => areacodeDataAll,
                    inrec.State <> '' => stateOnlyData,
                    dataset([],area_rec));

  joinPickRecords := project(join(pickRecords,Advo.Key_Addr_Zip,keyed(left.zip=right.zip)),
                                        Lookup_Services.Areacode_layouts.AreaCodeZipcodeRecords);
  getDataClean:=fnFilterBadData(pickRecords,joinPickRecords);
  getCityData:=dedup(sort(Advo.Key_Addr_Zip(keyed(zip in set(getDataClean,zip))),city,state),city,state);
  getAreaCodeData:=join(getDataClean,getCitydata,left.zip=right.zip);
  getformatedAreacode:=project(getAreaCodeData,area_slim);
  getResults:=if(isAreaCodeSearch,
                sort(getformatedAreacode,state,city),
                dedup(sort(getformatedAreacode,Areacode,County_Name,timezone),Areacode,County_Name,timezone));

  iesp.areacode.t_AreaCodeSearchRecord xfmOutput(area_slim l) := transform
      self.AreaCode:=l.areacode;
      self.City:=if(isAreaCodeSearch,l.City,'');
      self.State:=l.State;
      self.County:=l.County_Name;
      self.TimeZone:=l.Timezone;
  end;

  return Project(getResults,xfmOutput(left));
End;
