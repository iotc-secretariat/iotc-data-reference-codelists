-- Some values are null on type_of_fate_code, since type_of_fate_id is null
-- ALTER TABLE ros_ll.ll_catch_details ALTER COLUMN type_of_fate_code SET NOT NULL;
ALTER TABLE ros_gn.gn_catch_details ALTER COLUMN type_of_fate_code SET NOT NULL;
ALTER TABLE ros_ps.ps_catch_details ALTER COLUMN type_of_fate_code SET NOT NULL;
ALTER TABLE ros_pl.pl_catch_details ALTER COLUMN type_of_fate_code SET NOT NULL;
ALTER TABLE ros_common.measured_lengths ALTER COLUMN  type_of_measurement_code SET NOT NULL;
ALTER TABLE ros_common.estimated_weights ALTER COLUMN  type_of_measurement_code SET NOT NULL;
