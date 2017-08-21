EXPORT Fn_roll_Incident (dataset(FLAccidents_Ecrash.Layouts.slim_layout)infile):= function

t_sort := sort(distribute(infile,hash(incident_id)),case_identifier,agency_id,loss_state_abbr,report_type_id,crash_date,source_id,-creation_date,-Sent_to_HPCC_DateTime,incident_id,last_name , first_name, middle_name, address,city,state,zip_code,
               Drivers_License_Number,License_Plate,vin,Make,Model_Yr,Model,hash_key,loss_street,loss_cross_street,local);

t_sort t(t_sort L, t_sort R) := TRANSFORM

  self.last_name                := l.last_name  + r.last_name  ; 
  self.first_name               := l.first_name + r.first_name ; 
  self.middle_name              := l.middle_name + r.middle_name ; 
  self.address                  := l.address +r.address; 
  self.city                     := l.city+r.city ;
  self.state                    := l.state+r.state ; 
  self.zip_code                 := l.zip_code +r.zip_code ; 
  self.Drivers_License_Number   := l.Drivers_License_Number + r.Drivers_License_Number ;
  self.License_Plate            := l.License_Plate + r.License_Plate; 
  self.vin                      := l.vin +r.vin ;
  self.Make                     := l.make+r.make; 
  self.Model_Yr                 := l.Model_Yr + r.Model_Yr; 
  self.Model                    := l.Model + r.Model; 
  self                          := l;
END;

troll  := ROLLUP(t_sort, LEFT.incident_id= RIGHT.incident_id,t(LEFT, RIGHT),local);

return troll; 
end 
;