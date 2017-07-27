export	file_vehicleV2_party_bid	:=	module

export Bid_IN_Bdid :=project(vehicleV2.File_VehicleV2_Party_Building,transform(VehicleV2.Layout_Base_Party,self.append_bdid:=left.bid, self.append_bdid_score:=left.bid_score,self:=left;));

export BaseFileWithBid :=vehicleV2.File_VehicleV2_Party_Building;

end;